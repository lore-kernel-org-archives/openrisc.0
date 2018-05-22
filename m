From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 14:04:07 +0200
Subject: [OpenRISC] [PATCH 02/25] hexagon: implement the sync_sg_for_device
	DMA operation
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Message-ID: <20180522120430.28709-3-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This methods needs to provide the equivalent of sync_single_for_device
for each S/G list element, but was missing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index d2b717f352f4..9e46556a227d 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -188,6 +188,18 @@ static void hexagon_sync_single_for_device(struct device *dev,
 	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
 }
 
+static void hexagon_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
+}
+
+
 static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == HEXAGON_MAPPING_ERROR;
@@ -199,6 +211,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
 	.sync_single_for_device = hexagon_sync_single_for_device,
+	.sync_sg_for_device = hexagon_sync_sg_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
 
-- 
2.17.0

