/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#define _AF_XDP_KERN_H
#define USE_NVM
//#include "server.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
// The parsing helper functions from the packet01 lesson have moved here
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"
#include <sys/time.h>
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

SEC("xdp_sock")
int xdp_sock_prog(struct xdp_md *ctx)
{
    int index = ctx->rx_queue_index;
    
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

        if(tcphdr->psh){
#if 1
            if(data_end < eth + offsetof(struct ethhdr, h_dest) + ETH_ALEN + 1){

     //           bpf_printk("1111111111111111111\n");
//                return bpf_redirect_map(&xsks_map, index, 0);
                return XDP_DROP;
            }
#endif          
//                bpf_xdp_adjust_tail(ctx,-10);
//                bpf_xdp_adjust_tail(ctx,0);
             //   bpf_xdp_adjust_tail(ctx,100);
//                ((char*)data)[74] = 'g';
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
                   
            bpf_printk("1111111111111111111\n");
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
