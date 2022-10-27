/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
//#include <linux/in.h>
#include <linux/if_ether.h>
#define _AF_XDP_KERN_H
#define USE_NVM
//#include "server.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
//#include <linux/checksum.h>
#include <linux/ip.h>
// The parsing helper functions from the packet01 lesson have moved here
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"
#include <sys/time.h>
#include <arpa/inet.h>
#include <unistd.h>
/* Defines xdp_stats_map */
#include "../common/xdp_stats_kern_user.h"
#include "../common/xdp_stats_kern.h"
struct bpf_map_def SEC("maps") xsks_map = {
	.type = BPF_MAP_TYPE_XSKMAP,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 64,  /* Assume netdev has no more than 64 queues */
};
#define CARRY 65536
#if 0
uint16_t calculate(uint16_t* data, int dataLen)
{
    uint16_t result;
    int tempChecksum=0;
    int length;
    int flag=0;
    if((dataLen%2)==0)
        length=dataLen/2;
    else
    {
        length=(dataLen/2)+1;
        flag=1;
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
uint16_t calIPChecksum(struct iphdr* data)
{
    uint16_t checksum = 0;
    struct iphdr* iph=data;
    iph->check=0;//set Checksum field 0

    checksum=calculate((uint16_t*)iph,iph->ihl*4);
    iph->check=htons(checksum^0xffff);//xor checksum
    return checksum;
}
static inline void compute_tcp_checksum(struct iphdr *pIph, unsigned short *ipPayload) {
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
#endif
#if 0
static inline unsigned short checksum(unsigned short *buf, int bufsz) {
    unsigned long sum = 0;

    while (bufsz > 1) {
        sum += *buf;
        buf++;
        bufsz -= 2;
    }

    if (bufsz == 1) {
        sum += *(unsigned char *)buf;
    }

    sum = (sum & 0xffff) + (sum >> 16);
    sum = (sum & 0xffff) + (sum >> 16);

    return ~sum;
}
#endif

SEC("xdp_sock")
int xdp_sock_prog(struct xdp_md *ctx)
{
    int index = ctx->rx_queue_index;
//    return XDP_PASS;
#if 1
    __u32 *pkt_count;

    pkt_count = bpf_map_lookup_elem(&xdp_stats_map, &index);
#if 0
    if (pkt_count) {

        /* We pass every other packet */
        if ((*pkt_count)++ & 1)
            return XDP_PASS;
    }
#endif
    //char buff[10] = "";
    //sds temp = "hello";
    int eth_type,ip_type;
    struct ethhdr *eth;
    struct iphdr *iphdr;
    struct tcphdr *tcphdr; 
    void *data_end = (void *)(long)ctx->data_end;
    void *data = (void *)(long)ctx->data;
    struct hdr_cursor nh = { .pos = data };
    eth_type = parse_ethhdr(&nh, data_end, &eth);
 
    if (eth_type < 0) {
        return XDP_PASS;
    }
    
    if (eth_type == bpf_htons(ETH_P_IP)) {
        ip_type = parse_iphdr(&nh, data_end, &iphdr);
    }
    else{
        return XDP_PASS;
    }

    if (ip_type == IPPROTO_TCP) {

        if (parse_tcphdr(&nh, data_end, &tcphdr) < 0) {
            return XDP_PASS;
        }
        if(tcphdr->fin){
//            tcphdr->seq = tcphdr->ack_seq;
            //            tcphdr->ack_seq = 100;
//            u_int32_t tmp_ack = tcphdr->ack_seq;
//            tcphdr->ack_seq=htonl(ntohl(tcphdr->seq) + 1);
//            tcphdr->seq = tmp_ack; 
//            tcphdr->ack_seq = tcphdr->seq;
//            return XDP_TX;
            swap_src_dst_mac(eth);
            swap_src_dst_ipv4(iphdr);
            swap_src_dst_tcp(tcphdr);

            u_int32_t tmp_ack = tcphdr->ack_seq;
            tcphdr->ack_seq=htonl(ntohl(tcphdr->seq) + 1);
            tcphdr->seq = tmp_ack; 
  
#if 0
            struct iphdr *iph = iphdr;       
            iph->check = 0;
            u_int32_t csum = 0;
            __u16 * next_iph_u16 = (__u16 *)iph;
            for (int i = 0; i < iph->ihl / 2; i++) {
                csum += *next_iph_u16++;
            }
            iph->check = ~((csum & 0xffff) + (csum >> 16));
            iph->check = 0;
#endif
//            compute_tcp_checksum(iph, (unsigned short*)tcphdr);
            unsigned long sum;

            struct iphdr* iph = iphdr;
            unsigned short old_daddr = ntohs(*(unsigned short *)&iph->daddr);
            sum = old_daddr + (~ntohs(*(unsigned short *)&iph->daddr) & 0xffff);
            sum += ntohs(tcphdr->check);
            sum = (sum & 0xffff) + (sum>>16);
            tcphdr->check = htons(sum + (sum>>16) - 1);
            //tcphdr->check = checksum((unsigned short *)tcphdr, sizeof(struct tcphdr));
            //            ip_send_check(iphdr);
#if 0

            struct iphdr* iph=iphdr;

            iph->check=0;//set Checksum field 0
            uint16_t checksum=0;
            uint16_t* data = (uint16_t*)iph;
            int dataLen = iph->ihl*4;

            uint16_t tempChecksum=0;
            int length;
            int flag=0;
            if((dataLen%2)==0)
                length=dataLen/2;
            else
            {
                length=(dataLen/2)+1;
                flag=1;
            }
            
            for (int i = 0; i < length; ++i) // cal 2byte unit
            {
               
                if(i==length-1&&flag){} //last num is odd num
               //     tempChecksum+=ntohs((data[i])&0x00ff);
                else{}
                    //          tempChecksum+=ntohs(data[i]);
                 
                    //tempChecksum+=ntohs(data[i]);
                
          //      if(tempChecksum>CARRY)
          //              tempChecksum=(tempChecksum-CARRY)+1;

            }
            checksum=tempChecksum;
//#endif

            //checksum=calculate((uint16_t*)iph,iph->ihl*4);
            iph->check=htons(checksum^0xffff);//xor checksum
#endif


            //         calIPChecksum(iphdr);
            return XDP_TX;
        }

        if(tcphdr->psh){
#if 0
            if(data_end < eth + offsetof(struct ethhdr, h_dest) + ETH_ALEN + 1){

                bpf_printk("1111111111111111111\n");
//                return bpf_redirect_map(&xsks_map, index, 0);
                return XDP_DROP;
                return XDP_PASS;
            }

#endif      
            //            bpf_printk("kernel Data received!");
            bpf_printk("aaaaaaaaaaaaaaaa\n");
//            return XDP_PASS;
            return bpf_redirect_map(&xsks_map, index, 0);
            bpf_printk("zzzzzzzzzzzzzzzzzzz\n");
            bpf_printk("SEQ = %u\n",tcphdr->seq);
#if 1
            
            bpf_printk("Before iphdr->saddr = %d\n",iphdr->saddr);
            bpf_printk("Before iphdr->daddr = %d\n",iphdr->daddr);
            bpf_printk("Before tcphdr->source = %d\n",tcphdr->source);
            bpf_printk("Before tcpdhr->dest = %d\n",tcphdr->dest);
            swap_src_dst_tcp(tcphdr);
            swap_src_dst_ipv4(iphdr);
            swap_src_dst_mac(eth);
            bpf_printk("After iphdr->saddr = %d\n",iphdr->saddr);
            bpf_printk("After iphdr->daddr = %d\n",iphdr->daddr);
            bpf_printk("After tcphdr->source = %d\n",tcphdr->source);
            bpf_printk("After tcpdhr->dest = %d\n",tcphdr->dest);
//            return XDP_DROP;
            tcphdr->syn = 0;
            tcphdr->ack = 1;
            int d_size = data_end - data;
            tcphdr->ack_seq = tcphdr->seq + d_size;
#endif
            return XDP_TX;
//            return XDP_PASS;
            return xdp_stats_record_action(ctx, XDP_TX);
//                bpf_xdp_adjust_tail(ctx,-10);
//                bpf_xdp_adjust_tail(ctx,0);
             //   bpf_xdp_adjust_tail(ctx,100);
                ((char*)data)[74] = 'g';
//                ctx->data = (ctx->data)+80;
                //data=data+80;
                //bpf_printk("server.port = %d\n",server.port);
//   bpf_printk("buff = %s\n",buff);
                //            buff[0] = '0'+index;
    //        if(tcphdr->syn || tcphdr->ack)
//                return XDP_PASS;
//            buff[1]='0'+tcphdr->syn;
//            buff[2]='0'+tcphdr->ack;
//            buff[3]='0'+tcphdr->fin;
//            buff[4]='0'+tcphdr->psh;
//            buff[5]='0'+tcphdr->rst;
//            buff[6]='0'+tcphdr->urg;
            //return XDP_PASS;
//            bpf_trace_printk(buff, sizeof(buff));
                          
            //if(data_end >= eth + offsetof(struct ethhdr, h_dest) + ETH_ALEN)
            //    return XDP_DROP;
            
//            ((char*)data)[87]='\n';
                   
            bpf_printk("%s\n",data+66);
//bpf_xdp_adjust_tail(ctx,-11);
//            bpf_xdp_adjust_tail(ctx,-1);
//            return XDP_PASS;
            return bpf_redirect_map(&xsks_map, index, 0);
        }
#if 0        

        if(tcphdr->psh)
            return bpf_redirect_map(&xsks_map, index, 0);
        else
            return XDP_PASS;
#endif
    }
//    else if(ip_type == IPPROTO_UDP)

//        return bpf_redirect_map(&xsks_map, index, 0);
    return XDP_PASS;
}


    /* A set entry here means that the correspnding queue_id
     * has an active AF_XDP socket bound to it. */
//    if (bpf_map_lookup_elem(&xsks_map, &index))
//        return bpf_redirect_map(&xsks_map, index, 0);
    //return XDP_DROP;

//    return XDP_PASS;


//out:
    //return xdp_stats_record_action(ctx, action);
//}

#endif
char _license[] SEC("license") = "GPL";
