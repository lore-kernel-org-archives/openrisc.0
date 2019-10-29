From: Christoph Hellwig <hch@lst.de>
Date: Tue, 29 Oct 2019 07:48:33 +0100
Subject: [OpenRISC] [PATCH 20/21] csky: remove ioremap_cache
In-Reply-To: <20191029064834.23438-1-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
Message-ID: <20191029064834.23438-21-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

No driver that can be used on csky uses ioremap_cache, and this
interface has been deprecated in favor of memremap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/io.h | 2 --
 arch/csky/mm/ioremap.c     | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index a4b9fb616faa..f572605d5ad5 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -36,13 +36,11 @@
 /*
  * I/O memory mapping functions.
  */
-extern void __iomem *ioremap_cache(phys_addr_t addr, size_t size);
 extern void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot);
 extern void iounmap(void *addr);
 
 #define ioremap(addr, size)		__ioremap((addr), (size), pgprot_noncached(PAGE_KERNEL))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), pgprot_writecombine(PAGE_KERNEL))
-#define ioremap_cache			ioremap_cache
 
 #include <asm-generic/io.h>
 
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index e13cd3497628..ae78256a56fd 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -44,13 +44,6 @@ void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
 }
 EXPORT_SYMBOL(__ioremap);
 
-void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
-{
-	return __ioremap_caller(phys_addr, size, PAGE_KERNEL,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_cache);
-
 void iounmap(void __iomem *addr)
 {
 	vunmap((void *)((unsigned long)addr & PAGE_MASK));
-- 
2.20.1

