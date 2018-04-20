From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 10:02:53 +0200
Subject: [OpenRISC] [PATCH 02/22] dma-mapping: simplify Kconfig dependencies
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
Message-ID: <20180420080313.18796-3-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

ARCH_DMA_ADDR_T_64BIT is always true for 64-bit architectures now, so we
can skip the clause requiring it.  'n' is the default default, so no need
to explicitly state it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 01a37920949c..726b0562caa7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -443,13 +443,11 @@ config IOMMU_HELPER
 
 config DMA_DIRECT_OPS
 	bool
-	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
-	default n
+	depends on HAS_DMA
 
 config DMA_VIRT_OPS
 	bool
-	depends on HAS_DMA && (!64BIT || ARCH_DMA_ADDR_T_64BIT)
-	default n
+	depends on HAS_DMA
 
 config ARCH_HAS_SWIOTLB
 	bool
-- 
2.17.0

