From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:36:55 -0800
Subject: [OpenRISC] [PATCH 03/10] arm64/iommu: implement support for
	DMA_ATTR_NON_CONSISTENT
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
References: <20181208173702.15158-1-hch@lst.de>
Message-ID: <20181208173702.15158-4-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

DMA_ATTR_NON_CONSISTENT forces contiguous allocations as we don't
want to remap, and is otherwise forced down the same pass as if we
were always on a coherent device.  No new code required except for
a few conditionals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index d39b60113539..0010688ca30e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -240,7 +240,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				dma_free_from_pool(addr, size);
 			addr = NULL;
 		}
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+	} else if (attrs & (DMA_ATTR_FORCE_CONTIGUOUS |
+			DMA_ATTR_NON_CONSISTENT)) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 		struct page *page;
 
@@ -256,7 +257,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 			return NULL;
 		}
 
-		if (coherent) {
+		if (coherent || (attrs & DMA_ATTR_NON_CONSISTENT)) {
 			memset(addr, 0, size);
 			return addr;
 		}
@@ -309,7 +310,8 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	if (dma_in_atomic_pool(cpu_addr, size)) {
 		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		dma_free_from_pool(cpu_addr, size);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+	} else if (attrs & (DMA_ATTR_FORCE_CONTIGUOUS |
+			DMA_ATTR_NON_CONSISTENT)) {
 		struct page *page = vmalloc_to_page(cpu_addr);
 
 		iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
@@ -342,10 +344,11 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+	if (attrs & (DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NON_CONSISTENT)) {
 		unsigned long pfn;
 
-		if (dev_is_dma_coherent(dev))
+		if (dev_is_dma_coherent(dev) ||
+		    (attrs & DMA_ATTR_NON_CONSISTENT))
 			pfn = virt_to_pfn(cpu_addr);
 		else
 			pfn = vmalloc_to_pfn(cpu_addr);
@@ -366,10 +369,11 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+	if (attrs & (DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NON_CONSISTENT)) {
 		struct page *page;
 
-		if (dev_is_dma_coherent(dev))
+		if (dev_is_dma_coherent(dev) ||
+		    (attrs & DMA_ATTR_NON_CONSISTENT))
 			page = virt_to_page(cpu_addr);
 		else
 			page = vmalloc_to_page(cpu_addr);
-- 
2.19.2

