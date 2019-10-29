From: Christoph Hellwig <hch@lst.de>
Date: Tue, 29 Oct 2019 07:48:16 +0100
Subject: [OpenRISC] [PATCH 03/21] ia64: rename ioremap_nocache to ioremap_uc
In-Reply-To: <20191029064834.23438-1-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
Message-ID: <20191029064834.23438-4-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On ia64 ioremap_nocache fails if attributes don't match.  Not other
architectures does this, and we plan to get rid of ioremap_nocache.
So get rid of the special semantics and define ioremap_nocache in
terms of ioremap as no portable driver could rely on the behavior
anyway.

However x86 implements ioremap_uc in a similar way as the ia64
version of ioremap_nocache, in that it ignores the firmware tables.
Switch ia64 to override ioremap_uc instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/io.h | 6 +++---
 arch/ia64/mm/ioremap.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 54e70c21352a..fec9df9609ed 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -256,16 +256,16 @@ static inline void outsl(unsigned long port, const void *src,
 # ifdef __KERNEL__
 
 extern void __iomem * ioremap(unsigned long offset, unsigned long size);
-extern void __iomem * ioremap_nocache (unsigned long offset, unsigned long size);
+extern void __iomem * ioremap_uc(unsigned long offset, unsigned long size);
 extern void iounmap (volatile void __iomem *addr);
 static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
 {
 	return ioremap(phys_addr, size);
 }
 #define ioremap ioremap
-#define ioremap_nocache ioremap_nocache
+#define ioremap_nocache ioremap
 #define ioremap_cache ioremap_cache
-#define ioremap_uc ioremap_nocache
+#define ioremap_uc ioremap_uc
 #define iounmap iounmap
 
 /*
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 0c0de2c4ec69..a09cfa064536 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -99,14 +99,14 @@ ioremap (unsigned long phys_addr, unsigned long size)
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
-ioremap_nocache (unsigned long phys_addr, unsigned long size)
+ioremap_uc(unsigned long phys_addr, unsigned long size)
 {
 	if (kern_mem_attribute(phys_addr, size) & EFI_MEMORY_WB)
 		return NULL;
 
 	return __ioremap_uc(phys_addr);
 }
-EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(ioremap_uc);
 
 void
 early_iounmap (volatile void __iomem *addr, unsigned long size)
-- 
2.20.1

