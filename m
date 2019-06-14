From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Jun 2019 16:44:30 +0200
Subject: [OpenRISC] [PATCH 6/7] dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
Message-ID: <20190614144431.21760-7-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

DMA_ATTR_NO_KERNEL_MAPPING is generally implemented by allocating
normal cacheable pages or CMA memory, and then returning the page
pointer as the opaque handle.  Lift that code from the xtensa and
generic dma remapping implementations into the generic dma-direct
code so that we don't even call arch_dma_alloc for these allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/kernel/pci-dma.c    |  8 +-------
 include/linux/dma-noncoherent.h |  2 ++
 kernel/dma/direct.c             | 14 ++++++++++++++
 kernel/dma/remap.c              | 13 ++-----------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 9171bff76fc4..206771277dff 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -167,10 +167,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	*handle = phys_to_dma(dev, page_to_phys(page));
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		return page;
-	}
-
 #ifdef CONFIG_MMU
 	if (PageHighMem(page)) {
 		void *p;
@@ -196,9 +192,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page *page;
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		page = vaddr;
-	} else if (platform_vaddr_uncached(vaddr)) {
+	if (platform_vaddr_uncached(vaddr)) {
 		page = virt_to_page(platform_vaddr_to_cached(vaddr));
 	} else {
 #ifdef CONFIG_MMU
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 732919ac5c11..53ee36ecdf37 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -28,6 +28,8 @@ static inline bool dma_alloc_need_uncached(struct device *dev,
 {
 	if (dev_is_dma_coherent(dev))
 		return false;
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return false;
 	if (IS_ENABLED(CONFIG_DMA_NONCOHERENT_CACHE_SYNC) &&
 	    (attrs & DMA_ATTR_NON_CONSISTENT))
 		return false;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fc354f4f490b..b90e1aede743 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -138,6 +138,14 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		/* remove any dirty cache lines on the kernel alias */
+		if (!PageHighMem(page))
+			arch_dma_prep_coherent(page, size);
+		/* return the page pointer as the opaque cookie */
+		return page;
+	}
+
 	if (PageHighMem(page)) {
 		/*
 		 * Depending on the cma= arguments and per-arch setup
@@ -178,6 +186,12 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		/* cpu_addr is a struct page cookie, not a kernel address */
+		__dma_direct_free_pages(dev, size, cpu_addr);
+		return;
+	}
+
 	if (force_dma_unencrypted())
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 0207e3764d52..a594aec07882 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -202,8 +202,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	size = PAGE_ALIGN(size);
 
-	if (!gfpflags_allow_blocking(flags) &&
-	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
+	if (!gfpflags_allow_blocking(flags)) {
 		ret = dma_alloc_from_pool(size, &page, flags);
 		if (!ret)
 			return NULL;
@@ -217,11 +216,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		ret = page; /* opaque cookie */
-		goto done;
-	}
-
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
@@ -240,10 +234,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		/* vaddr is a struct page cookie, not a kernel address */
-		__dma_direct_free_pages(dev, size, vaddr);
-	} else if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
+	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
 		phys_addr_t phys = dma_to_phys(dev, dma_handle);
 		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
-- 
2.20.1

