From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 14:04:12 +0200
Subject: [OpenRISC] [PATCH 07/25] nds32: remove the broken kmap code in
	nds32_dma_map_sg
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Message-ID: <20180522120430.28709-8-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

nds32_dma_map_sg is the only of the various DMA operations that tries
to deal with highmem (the single page variants and SG sync routines are
missing, SG unmap is entirely unimplemented), and it does so without
taking into account S/G list items that are bigger than a page, which
are legal and can happen frequently.

Remove this code for now - if highmem support on nds32 becomes a real
thing it needs to be added back as a loop over pages in the newly
consolidated code that deals with all operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index d291800fc621..e1bf7206e015 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -393,24 +393,9 @@ static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		void *virt;
-		unsigned long pfn;
-		struct page *page = sg_page(sg);
-
-		sg->dma_address = sg_phys(sg);
-		pfn = page_to_pfn(page) + sg->offset / PAGE_SIZE;
-		page = pfn_to_page(pfn);
-		if (PageHighMem(page)) {
-			virt = kmap_atomic(page);
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-			kunmap_atomic(virt);
-		} else {
-			if (sg->offset > PAGE_SIZE)
-				panic("sg->offset:%08x > PAGE_SIZE\n",
-				      sg->offset);
-			virt = page_address(page) + sg->offset;
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-		}
+		char *virt =
+		    page_address((struct page *)sg->page_link) + sg->offset;
+		consistent_sync(virt, sg->length, dir, FOR_CPU);
 	}
 	return nents;
 }
-- 
2.17.0

