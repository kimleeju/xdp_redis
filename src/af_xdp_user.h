#ifndef _AF_XDP_H
#define _AF_XDP_H

#include <bpf/bpf.h>
#include <bpf/xsk.h>


#include "../common/common_params.h"
#include "../common/common_user_bpf_xdp.h"
#include "../common/common_libbpf.h"


#define NUM_FRAMES         4096
#define FRAME_SIZE         XSK_UMEM__DEFAULT_FRAME_SIZE
#define RX_BATCH_SIZE      64
#define INVALID_UMEM_FRAME UINT64_MAX
struct xsk_umem_info {
	struct xsk_ring_prod fq;
	struct xsk_ring_cons cq;
	struct xsk_umem *umem;
	void *buffer;
};

struct stats_record {
	uint64_t timestamp;
	uint64_t rx_packets;
	uint64_t rx_bytes;
	uint64_t tx_packets;
	uint64_t tx_bytes;
};

struct xsk_socket_info {
	struct xsk_ring_cons rx;
	struct xsk_ring_prod tx;
	struct xsk_umem_info *umem;
	struct xsk_socket *xsk;

	uint64_t umem_frame_addr[NUM_FRAMES];
	uint32_t umem_frame_free;

	uint32_t outstanding_tx;

	struct stats_record stats;
	struct stats_record prev_stats;
};

 inline __u32 xsk_ring_prod__free(struct xsk_ring_prod *r);

struct xsk_umem_info *configure_xsk_umem(void *buffer, uint64_t size);
uint64_t xsk_alloc_umem_frame(struct xsk_socket_info *xsk);
void xsk_free_umem_frame(struct xsk_socket_info *xsk, uint64_t frame);
uint64_t xsk_umem_free_frames(struct xsk_socket_info *xsk);
struct xsk_socket_info *xsk_configure_socket(struct config *cfg,
                        struct xsk_umem_info *umem);
void complete_tx(struct xsk_socket_info *xsk);

inline __sum16 csum16_add(__sum16 csum, __be16 addend);
inline __sum16 csum16_sub(__sum16 csum, __be16 addend);
inline void csum_replace2(__sum16 *sum, __be16 old, __be16 new);
bool process_packet(struct xsk_socket_info *xsk,
           uint64_t addr, uint32_t len);


void handle_receive_packets(struct xsk_socket_info *xsk);

void rx_and_process(struct config *cfg,
           struct xsk_socket_info *xsk_socket);

#endif
