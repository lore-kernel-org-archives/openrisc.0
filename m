From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:37:01 -0800
Subject: [OpenRISC] [PATCH 09/10] dma-mapping: skip declared coherent memory
	for DMA_ATTR_NON_CONSISTENT
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
References: <20181208173702.15158-1-hch@lst.de>
Message-ID: <20181208173702.15158-10-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Memory declared using dma_declare_coherent is ioremapped and thus not
always suitable for our tightened DMA_ATTR_NON_CONSISTENT definition.

Skip it given all the existing callers don't DMA_ATTR_NON_CONSISTENT
anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7799c2b27849..8c81fa5d1f44 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -521,7 +521,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	BUG_ON(!ops);
 	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
 
-	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) &&
+	    dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
 	/* let the implementation decide on the zone to allocate from: */
-- 
2.19.2

