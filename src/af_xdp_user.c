/* SPDX-License-Identifier: GPL-2.0 */
#include "server.h"
#include "sds.h"
#include "af_xdp_user.h"
#include "print.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assert.h>
#include <errno.h>
#include <getopt.h>
#include <locale.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <time.h>
#include <unistd.h>

#include <linux/if_ether.h>
#include <sys/resource.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <linux/ip.h>
#include <linux/if_link.h>
#include <netinet/tcp.h>	
#include <linux/if_ether.h>
#include <linux/ipv6.h>
#include <linux/icmpv6.h>

struct xsk_socket {
    struct xsk_ring_cons *rx;
    struct xsk_ring_prod *tx;
    __u64 outstanding_tx;
    struct xsk_umem *umem;
    struct xsk_socket_config config;
    int fd; 
    int ifindex;
    int prog_fd;
    int xsks_map_fd;
    __u32 queue_id;
    char ifname[IFNAMSIZ];
};

struct Pseudoheader{
    uint32_t srcIP;
    uint32_t destIP;
    uint8_t reserved;
    uint8_t protocol;
    uint16_t TCPLen;
};

#define CARRY 65536
uint16_t calculate(uint16_t* data, int dataLen)
{
    uint16_t result;
    int tempChecksum=0;
    int length;
    bool flag=false;
    if((dataLen%2)==0)
        length=dataLen/2;
    else
    {
        length=(dataLen/2)+1;
        flag=true;
    }

    for (int i = 0; i < length; ++i) // cal 2byte unit
    {
       

        if(i==length-1&&flag) //last num is odd num
            tempChecksum+=ntohs(data[i]&0x00ff);
        else
            tempChecksum+=ntohs(data[i]);

        if(tempChecksum>CARRY)
                tempChecksum=(tempChecksum-CARRY)+1;

    }

    result=tempChecksum;
    return result;
}
uint16_t calIPChecksum(uint8_t* data)
{
    struct iphdr* iph=(struct iphdr*)data;
    iph->check=0;//set Checksum field 0

    uint16_t checksum=calculate((uint16_t*)iph,iph->ihl*4);
    iph->check=htons(checksum^0xffff);//xor checksum

    return checksum;
}
void compute_tcp_checksum(struct iphdr *pIph, unsigned short *ipPayload) {
    register unsigned long sum = 0;
    unsigned short tcpLen = ntohs(pIph->tot_len) - (pIph->ihl<<2);
    struct tcphdr *tcphdrp = (struct tcphdr*)(ipPayload);
    //add the pseudo header 
    //the source ip
    sum += (pIph->saddr>>16)&0xFFFF;
    sum += (pIph->saddr)&0xFFFF;
    //the dest ip
    sum += (pIph->daddr>>16)&0xFFFF;
    sum += (pIph->daddr)&0xFFFF;
    //protocol and reserved: 6
    sum += htons(IPPROTO_TCP);
    //the length
    sum += htons(tcpLen);
 
    //add the IP payload
    //initialize checksum to 0
    tcphdrp->check = 0;
    while (tcpLen > 1) {
        sum += * ipPayload++;
        tcpLen -= 2;
    }
    //if any bytes left, pad the bytes and add
    if(tcpLen > 0) {
        //printf("+++++++++++padding, %dn", tcpLen);
        sum += ((*ipPayload)&htons(0xFF00));
    }
      //Fold 32-bit sum to 16 bits: add carrier to result
      while (sum>>16) {
          sum = (sum & 0xffff) + (sum >> 16);
      }
      sum = ~sum;
    //set computation result
    tcphdrp->check = (unsigned short)sum;
}

inline __u32 xsk_ring_prod__free(struct xsk_ring_prod *r)
{
    r->cached_cons = *r->consumer + r->size;
    return r->cached_cons - r->cached_prod;
}


bool global_exit;

struct xsk_umem_info *configure_xsk_umem(void *buffer, uint64_t size)
{
    struct xsk_umem_info *umem;
    int ret;

    umem = calloc(1, sizeof(*umem));
    if (!umem)
        return NULL;

    ret = xsk_umem__create(&umem->umem, buffer, size, &umem->fq, &umem->cq,
            NULL);
    if (ret) {
        errno = -ret;
        return NULL;
    }

    umem->buffer = buffer;
    return umem;
}

uint64_t xsk_alloc_umem_frame(struct xsk_socket_info *xsk)
{
    uint64_t frame;
    if (xsk->umem_frame_free == 0)
        return INVALID_UMEM_FRAME;

    frame = xsk->umem_frame_addr[--xsk->umem_frame_free];
    xsk->umem_frame_addr[xsk->umem_frame_free] = INVALID_UMEM_FRAME;
    return frame;
}

void xsk_free_umem_frame(struct xsk_socket_info *xsk, uint64_t frame)
{
    assert(xsk->umem_frame_free < NUM_FRAMES);

    xsk->umem_frame_addr[xsk->umem_frame_free++] = frame;
}

uint64_t xsk_umem_free_frames(struct xsk_socket_info *xsk)
{
    return xsk->umem_frame_free;
}

struct xsk_socket_info *xsk_configure_socket(struct config *cfg,
        struct xsk_umem_info *umem)
{
    struct xsk_socket_config xsk_cfg;
    struct xsk_socket_info *xsk_info;
    uint32_t idx;
    uint32_t prog_id = 0;
    int i;
    int ret;

    xsk_info = calloc(1, sizeof(*xsk_info));
    if (!xsk_info)
        return NULL;

    xsk_info->umem = umem;
    xsk_cfg.rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
    xsk_cfg.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
    xsk_cfg.libbpf_flags = 0;
    xsk_cfg.xdp_flags = cfg->xdp_flags;
    xsk_cfg.bind_flags = cfg->xsk_bind_flags;
    ret = xsk_socket__create(&xsk_info->xsk, cfg->ifname,
            cfg->xsk_if_queue, umem->umem, &xsk_info->rx,
            &xsk_info->tx, &xsk_cfg);

    if (ret)
        goto error_exit;

    ret = bpf_get_link_xdp_id(cfg->ifindex, &prog_id, cfg->xdp_flags);
    if (ret)
        goto error_exit;

    /* Initialize umem frame allocation */

    for (i = 0; i < NUM_FRAMES; i++)
        xsk_info->umem_frame_addr[i] = i * FRAME_SIZE;

    xsk_info->umem_frame_free = NUM_FRAMES;

    /* Stuff the receive path with buffers, we assume we have enough */
    ret = xsk_ring_prod__reserve(&xsk_info->umem->fq,
            XSK_RING_PROD__DEFAULT_NUM_DESCS,
            &idx);

    if (ret != XSK_RING_PROD__DEFAULT_NUM_DESCS)
        goto error_exit;

    for (i = 0; i < XSK_RING_PROD__DEFAULT_NUM_DESCS; i ++)
        *xsk_ring_prod__fill_addr(&xsk_info->umem->fq, idx++) =
            xsk_alloc_umem_frame(xsk_info);

    xsk_ring_prod__submit(&xsk_info->umem->fq,
            XSK_RING_PROD__DEFAULT_NUM_DESCS);

    return xsk_info;

error_exit:
    errno = -ret;
    return NULL;
}

void complete_tx(struct xsk_socket_info *xsk)
{
    unsigned int completed;
    uint32_t idx_cq;

    if (!xsk->outstanding_tx)
        return;

    sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);


    /* Collect/free completed TX buffers */
    completed = xsk_ring_cons__peek(&xsk->umem->cq,
            XSK_RING_CONS__DEFAULT_NUM_DESCS,
            &idx_cq);

    if (completed > 0) {
        for (int i = 0; i < completed; i++)
            xsk_free_umem_frame(xsk,
                    *xsk_ring_cons__comp_addr(&xsk->umem->cq,
                        idx_cq++));

        xsk_ring_cons__release(&xsk->umem->cq, completed);
        xsk->outstanding_tx -= completed < xsk->outstanding_tx ?
            completed : xsk->outstanding_tx;
    }
}

inline __sum16 csum16_add(__sum16 csum, __be16 addend)
{
    uint16_t res = (uint16_t)csum;

    res += (__u16)addend;
    return (__sum16)(res + (res < (__u16)addend));
}

inline __sum16 csum16_sub(__sum16 csum, __be16 addend)
{
    return csum16_add(csum, ~addend);
}

inline void csum_replace2(__sum16 *sum, __be16 old, __be16 new)
{
    *sum = ~csum16_add(csum16_sub(~(*sum), old), new);
}
bool process_packet(void* c, struct xsk_socket_info *xsk,
        uint64_t addr, uint32_t len)
{
    uint8_t *pkt = xsk_umem__get_data(xsk->umem->buffer, addr);
    
    readQueryFromXDP(pkt+66,c);
    int ret;
    uint32_t tx_idx = 0;
    uint8_t tmp_mac[ETH_ALEN];
    struct in_addr tmp_ip;
    struct ethhdr *eth = (struct ethhdr *) pkt;
    struct iphdr *ipv = (struct iphdr *) (eth + 1);
    struct tcphdr *tcphdr = (struct tcphdr *) (ipv + 1);
//    client *cli = (client*) c;
//    int i,j=0,cnt=0;
//    size_t qblen;
//    char v_size[10] = {0};
//    char* value;
    printf("Data received!!\n");
    int cnt=0;
//    printf("i = %d\n",sizeof(struct ethhdr) + ipv->ihl*4);
//    printf("ipv->ihl*4 = %d\n",ipv->ihl*4);
    for(int i = 66 ; i < len ; i++){
    //for(int i = sizeof(struct ethhdr) + ipv->ihl*4 ; i < 66 ; i++){
    //for(int i = sizeof(struct ethhdr) + ipv->ihl*4 + tcphdr->doff*4 ; i < len ; ++i){
        cnt++;
        printf("%c",pkt[i]);
#if 0
        for(int j = 7 ; j >=0 ; --j){
            int result=pkt[i] >> j & 1;
            printf("%d",result);   
        }
#endif
        //printf(" ");
    }
    printf("\n");
    for(int i = 65 ; i >= 62 ; i--){
    //for(int i = sizeof(struct ethhdr) + ipv->ihl*4 ; i < 66 ; i++){
    //for(int i = sizeof(struct ethhdr) + ipv->ihl*4 + tcphdr->doff*4 ; i < len ; ++i){
        cnt++;
//        printf("%c",pkt[i]);
#if 0
        for(int j = 7 ; j >=0 ; --j){
            int result=pkt[i] >> j & 1;
            printf("%d",result);   
        }
#endif
        //printf(" ");
    }
//    printf("\n");
//    printf("cnt = %d\n",cnt);
    //c->querybuf = pkt+66;
#if 0
    sds data = (sds)malloc(strlen(pkt+66));
    strcpy(data,pkt+66);
    readQueryFromXDP(c);
#endif

//    qblen = sdslen(cli->querybuf);
//    cli->querybuf = sdsMakeRoomFor(cli->querybuf, strlen(pkt+66));
//    strcpy(cli->querybuf+qblen,pkt+66);

    //    printf("%s\n",data);
#if 0
    
    for(i =0 ; i < len-66 ; ++i){
        printf("%c",data[i]);
    }
    printf("\n");
#endif
#if 0
    for(i =66 ; i < len ; ++i){
        printf("%c",pkt[i]);
    }
    printf("\n");
    //sdsmvtonvm(value);
    //ustime();
#endif
    //printf("server.port = %d\n",server.port);
#if 0
    if( (pkt[74] == 'S' || pkt[74] == 's') && (pkt[75] == 'E' || pkt[75] == 'e') && (pkt[76] == 'T' || pkt[76] == 't')) {
        for(i = 79 ; i < len ; ++i){
            if(pkt[i] == '$')
                cnt++;

            if(cnt == 2){
                while(1){
                    v_size[j++]=pkt[++i];
                    
                    if(pkt[i] == '\r')
                        break;
                }
                break;
            }
        }
        printf("value size = %d\n",atoi(v_size));
        //        value = (char*)malloc(sizeof(char*)*(atoi(v_size)+1));
//        strncpy(value,pkt+i+2,atoi(v_size));
    }
    //printf("%s\n",value);
#endif
//    int port = server.port;
//    printf("server.pmem_kind = %p\n",server.pmem_kind);
//    sds s = sdsmvtonvm(value);
//    printf("sds = %s\n",s);
    /* Lesson#3: Write an IPv6 ICMP ECHO parser to send responses
	 *
	 * Some assumptions to make it easier:
	 * - No VLAN handling
	 * - Only if nexthdr is ICMP
	 * - Just return all data with MAC/IP swapped, and type set to
	 *   ICMPV6_ECHO_REPLY
	 * - Recalculate the icmp checksum */
    
//    if(true) {
    if(false) {
#if 1
        memcpy(tmp_mac, eth->h_dest, ETH_ALEN);
		memcpy(eth->h_dest, eth->h_source, ETH_ALEN);
		memcpy(eth->h_source, tmp_mac, ETH_ALEN);

		memcpy(&tmp_ip, &ipv->saddr, sizeof(tmp_ip));
		memcpy(&ipv->saddr, &ipv->daddr, sizeof(tmp_ip));
		memcpy(&ipv->daddr, &tmp_ip, sizeof(tmp_ip));
#endif
//        compute_ip_checksum(ipv);
//        cal_checksum(ipv, len - sizeof(struct ethhdr));
//        calIPChecksum(ipv);
         
        uint8_t temp;
        for(int i = 58; i < 62 ; i++){
            temp = pkt[i];
            pkt[i] = pkt[i+4];
            pkt[i+4] = temp;
        }

        u_int16_t tmp = tcphdr->source;
        tcphdr->source = tcphdr->dest;
        tcphdr->dest=tmp;
        tcphdr->psh = 0;
        //        tcphdr->syn = 1;
//        tcphdr->th_off=6;v
        int d_size = len - (sizeof(struct ethhdr) + ipv->ihl*4 + tcphdr->doff*4);
        ipv->tot_len=htons(ntohs(ipv->tot_len)-d_size);
      
        
#if 1
//        printf("tcphdr->doff = %d\n",tcphdr->doff);
 
//        printf("1111111111111111111  checksum = %u\n",ntohs(tcphdr->check));
//        printf("Before tcphdr->seq = %u\n",ntohl(tcphdr->seq));
//        tcphdr->seq = htonl(10);
//        printf("Befter tcphdr->ack_seq = %u\n",ntohl(tcphdr->ack_seq));
       
//        printf("After tcphdr->seq = %u\n",ntohl(tcphdr->seq));
//        tcphdr->ack_seq=htonl(ntohl(tcphdr->seq) + d_size);
//        printf("After tcphdr->ack_seq = %u\n",ntohl(tcphdr->ack_seq));
//        tcphdr->window = htons(ntohs(tcphdr->window)+8);
//        tcphdr->check = tcp_checksum(tcphdr, ipv);
       // tcphdr->check = htons(calTCPChecksum(ipv, len - sizeof(struct ethhdr)));
//        calTCPChecksum(ipv, len - sizeof(struct ethhdr));
        //cal_checksum((u_short*)ipv, len - sizeof(struct ethhdr));
        //printf("tcphdr->ack_seq = %u\n",ntohl(tcphdr->ack_seq));

       // tcphdr->ack = tcphdr->seq + d_size;
       // printf("tcphdr->ack_seq = %d\n",tcphdr->ack_seq);
        //        bpf_xdp_adjust_tail((struct bpf_md*)pkt,-10);
        //        printf("data = %d\n",tcphdr->th_off);
       // tcphdr->ack_seq = tcphdr->seq + len -66;      
#endif
        calIPChecksum(ipv);
        compute_tcp_checksum(ipv, tcphdr);
        //        printf("2222222222222222222222  checksum = %u\n",ntohs(tcphdr->check));
        ret = xsk_ring_prod__reserve(&xsk->tx, 1, &tx_idx);
        //printf("flags = %d\n",&xsk->xsk->config.xdp_flags);

        if (ret != 1) {
			/* No more transmit slots, drop the packet */
			return false;
		}
#if 0
        void* buf = malloc(sizeof(struct ethhdr) + ipv->ihl*4 + tcphdr->off*4 + 1);
        memcpy(buf, xsk->umem->buffer, sizeof(struct ethhdr) + ipv->ihl*4 + tcphdr->doff*4);
        xsk->umem->buffer = buf;
        void* data = tcphdr + tcphdr->doff*4;
#endif
//        len-=sizeof(struct ethhdr) + ipv->ihl*4 + tcphdr->doff*4;
        xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->addr = addr;
        xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->len = len - d_size;
		xsk_ring_prod__submit(&xsk->tx, 1);
		xsk->outstanding_tx++;

		xsk->stats.tx_bytes += len - d_size;
		xsk->stats.tx_packets++;


        return true;

#if 0
		icmp->icmp_type = ICMP_ECHO_REPLY;

		csum_replace2(&icmp->icmp_cksum,
			      htons(ICMP_ECHO_REQUEST << 8),
			      htons(ICMP_ECHO_REPLY << 8));

        printf("bbbbbbbbbbbbbb\n");
		/* Here we sent the packet out of the receive port. Note that
		 * we allocate one entry and schedule it. Your design would be
		 * faster if you do batch processing/transmission */

		ret = xsk_ring_prod__reserve(&xsk->tx, 1, &tx_idx);
		if (ret != 1) {
			/* No more transmit slots, drop the packet */
			return false;
		}

        printf("bbbbbbbbbbbbbb\n");
		xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->addr = addr;
		xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->len = len;
		xsk_ring_prod__submit(&xsk->tx, 1);
		xsk->outstanding_tx++;

		xsk->stats.tx_bytes += len;
		xsk->stats.tx_packets++;
		return true;
#endif
    }

	return false;
}

int handle_receive_packets(void *c, struct xsk_socket_info *xsk)
{
	unsigned int rcvd, stock_frames, i;
	uint32_t idx_rx = 0, idx_fq = 0;
    int ret;
    rcvd = xsk_ring_cons__peek(&xsk->rx, RX_BATCH_SIZE, &idx_rx);
    if (!rcvd)
		return;
    printf("rcvd rcvd rcvd = %d\n",rcvd);
    /* Stuff the ring with as much frames as possible */
	stock_frames = xsk_prod_nb_free(&xsk->umem->fq,
					xsk_umem_free_frames(xsk));
    if (stock_frames > 0) {

		ret = xsk_ring_prod__reserve(&xsk->umem->fq, stock_frames,
					     &idx_fq);

		/* This should not happen, but just in case */
		while (ret != stock_frames)
			ret = xsk_ring_prod__reserve(&xsk->umem->fq, rcvd,
						     &idx_fq);

		for (i = 0; i < stock_frames; i++)
			*xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) =
				xsk_alloc_umem_frame(xsk);

		xsk_ring_prod__submit(&xsk->umem->fq, stock_frames);
	}   
    uint64_t addr;
    uint32_t len;
	/* Process received packets */
	for (i = 0; i < rcvd; i++) {
	//for (i = rcvd-1; i < rcvd; i++) {
        addr = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx)->addr;
		len = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++)->len;
#if 0	
        if (!process_packet(c, xsk, addr, len))
			xsk_free_umem_frame(xsk, addr);
#endif	
        xsk->stats.rx_bytes += len;
	}

    process_packet(c, xsk, addr, len);

	xsk_ring_cons__release(&xsk->rx, rcvd);
	xsk->stats.rx_packets += rcvd;

	/* Do we need to wake up the kernel for transmission */
	complete_tx(xsk);
}

void rx_and_process(struct config *cfg,
			   struct xsk_socket_info *xsk_socket)
{
	struct pollfd fds[2];
	int ret, nfds = 1;

	memset(fds, 0, sizeof(fds));
	fds[0].fd = xsk_socket__fd(xsk_socket->xsk);
	fds[0].events = POLLIN;
	while(!global_exit) {
		if (cfg->xsk_poll_mode) {
			ret = poll(fds, nfds, -1);
			if (ret <= 0 || ret > 1)
				continue;
		}
		//handle_receive_packets(xsk_socket);
	}
}
