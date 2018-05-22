From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 14:04:06 +0200
Subject: [OpenRISC] [PATCH 01/25] hexagon: remove the sync_single_for_cpu
	DMA operation
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Message-ID: <20180522120430.28709-2-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

hexagon does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 77459df34e2e..d2b717f352f4 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -181,13 +181,6 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
-static void hexagon_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
 static void hexagon_sync_single_for_device(struct device *dev,
 					dma_addr_t dma_handle, size_t size,
 					enum dma_data_direction dir)
@@ -205,7 +198,6 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.free		= hexagon_free_coherent,
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
-	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
-- 
2.17.0

