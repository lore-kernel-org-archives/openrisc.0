From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Jun 2019 16:44:28 +0200
Subject: [OpenRISC] [PATCH 4/7] dma-mapping: add a dma_alloc_need_uncached
 helper
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
Message-ID: <20190614144431.21760-5-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Check if we need to allocate uncached memory for a device given the
allocation flags.  Switch over the uncached segment check to this helper
to deal with architectures that do not support the dma_cache_sync
operation and thus should not returned cacheable memory for
DMA_ATTR_NON_CONSISTENT allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-noncoherent.h | 14 ++++++++++++++
 kernel/dma/direct.c             |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 7e0126a04e02..732919ac5c11 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -20,6 +20,20 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
 
+/*
+ * Check if an allocation needs to be marked uncached to be coherent.
+ */
+static inline bool dma_alloc_need_uncached(struct device *dev,
+		unsigned long attrs)
+{
+	if (dev_is_dma_coherent(dev))
+		return false;
+	if (IS_ENABLED(CONFIG_DMA_NONCOHERENT_CACHE_SYNC) &&
+	    (attrs & DMA_ATTR_NON_CONSISTENT))
+		return false;
+	return true;
+}
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b67f0aa08aa3..c2893713bf80 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -160,7 +160,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	memset(ret, 0, size);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
-	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+	    dma_alloc_need_uncached(dev, attrs)) {
 		arch_dma_prep_coherent(page, size);
 		ret = uncached_kernel_address(ret);
 	}
@@ -182,7 +182,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
-	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT))
+	    dma_alloc_need_uncached(dev, attrs))
 		cpu_addr = cached_kernel_address(cpu_addr);
 	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
-- 
2.20.1

