From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:13 -0800
Subject: [OpenRISC] [PATCH 4/6] sparc: remove not required includes from
	dma-mapping.h
In-Reply-To: <20181208174115.16237-1-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
Message-ID: <20181208174115.16237-5-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The only thing we need to explicitly pull in is the defines for the
CPU type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/dma-mapping.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index b0bb2fcaf1c9..55a44f08a9a4 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -2,9 +2,7 @@
 #ifndef ___ASM_SPARC_DMA_MAPPING_H
 #define ___ASM_SPARC_DMA_MAPPING_H
 
-#include <linux/scatterlist.h>
-#include <linux/mm.h>
-#include <linux/dma-debug.h>
+#include <asm/cpu_type.h>
 
 extern const struct dma_map_ops *dma_ops;
 
-- 
2.19.2

