From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:37:00 -0800
Subject: [OpenRISC] [PATCH 08/10] sparc64/pci_sun4v: implement
	DMA_ATTR_NON_CONSISTENT
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
References: <20181208173702.15158-1-hch@lst.de>
Message-ID: <20181208173702.15158-9-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Just allocate the memory and use map_page to map the memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/pci_sun4v.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index b95c70136559..24a76ecf2986 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -590,6 +590,14 @@ static void *dma_4v_alloc(struct device *dev, size_t size,
 	first_page = (unsigned long) page_address(page);
 	memset((char *)first_page, 0, PAGE_SIZE << order);
 
+	if (attrs & DMA_ATTR_NON_CONSISTENT) {
+		*dma_addrp = dma_4v_map_page(dev, page, 0, size,
+					     DMA_BIDIRECTIONAL, 0);
+		if (*dma_addrp == DMA_MAPPING_ERROR)
+			goto range_alloc_fail;
+		return page_address(page);
+	}
+
 	iommu = dev->archdata.iommu;
 	atu = iommu->atu;
 
@@ -649,6 +657,11 @@ static void dma_4v_free(struct device *dev, size_t size, void *cpu,
 	unsigned long iotsb_num;
 	u32 devhandle;
 
+	if (attrs & DMA_ATTR_NON_CONSISTENT) {
+		dma_4v_unmap_page(dev, dvma, size, DMA_BIDIRECTIONAL, 0);
+		goto free_pages;
+	}
+
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
 	pbm = dev->archdata.host_controller;
@@ -665,6 +678,7 @@ static void dma_4v_free(struct device *dev, size_t size, void *cpu,
 	entry = ((dvma - tbl->table_map_base) >> IO_PAGE_SHIFT);
 	dma_4v_iommu_demap(dev, devhandle, dvma, iotsb_num, entry, npages);
 	iommu_tbl_range_free(tbl, dvma, npages, IOMMU_ERROR_CODE);
+free_pages:
 	order = get_order(size);
 	if (order < 10)
 		free_pages((unsigned long)cpu, order);
-- 
2.19.2

