From: Christoph Hellwig <hch@lst.de>
Date: Thu, 19 Jul 2018 06:02:29 -0700
Subject: [OpenRISC] [PATCH 1/4] openrisc: remove the sync_single_for_cpu DMA
	operation
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
Message-ID: <20180719130232.1819-2-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

openrisc does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index ec7fd45704d2..47601274abf7 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -208,20 +208,6 @@ or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
 	}
 }
 
-static void
-or1k_sync_single_for_cpu(struct device *dev,
-			 dma_addr_t dma_handle, size_t size,
-			 enum dma_data_direction dir)
-{
-	unsigned long cl;
-	dma_addr_t addr = dma_handle;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	/* Invalidate the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBIR, cl);
-}
-
 static void
 or1k_sync_single_for_device(struct device *dev,
 			    dma_addr_t dma_handle, size_t size,
@@ -243,7 +229,6 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.unmap_page = or1k_unmap_page,
 	.map_sg = or1k_map_sg,
 	.unmap_sg = or1k_unmap_sg,
-	.sync_single_for_cpu = or1k_sync_single_for_cpu,
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.18.0

