From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 14:04:14 +0200
Subject: [OpenRISC] [PATCH 09/25] nds32: implement the unmap_sg DMA operation
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Message-ID: <20180522120430.28709-10-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This matches the implementation of the more commonly used unmap_single
routines and the sync_sg_for_cpu method which should provide equivalent
cache maintainance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index 4e6fb4ffd3f7..43d7fd432bb6 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -426,6 +426,12 @@ static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nhwentries, enum dma_data_direction dir,
 			       unsigned long attrs)
 {
+	int i;
+
+	for (i = 0; i < nhwentries; i++, sg++) {
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
+	}
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0

