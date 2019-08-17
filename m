From: Christoph Hellwig <hch@lst.de>
Date: Sat, 17 Aug 2019 09:32:32 +0200
Subject: [OpenRISC] [PATCH 05/26] openrisc: map as uncached in ioremap
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
Message-ID: <20190817073253.27819-6-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Openrisc is the only architecture not mapping ioremap as uncached,
which has been the default since the Linux 2.6.x days.  Switch it
over to implement uncached semantics by default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/io.h      | 20 +++-----------------
 arch/openrisc/include/asm/pgtable.h |  2 +-
 arch/openrisc/mm/ioremap.c          |  8 ++++----
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 06a710757789..5b81a96ab85e 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -25,25 +25,11 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap_nocache ioremap_nocache
+#define ioremap_nocache ioremap
 #include <asm-generic/io.h>
 #include <asm/pgtable.h>
 
-extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
-				pgprot_t prot);
-
-static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
-{
-	return __ioremap(offset, size, PAGE_KERNEL);
-}
-
-/* #define _PAGE_CI       0x002 */
-static inline void __iomem *ioremap_nocache(phys_addr_t offset,
-					     unsigned long size)
-{
-	return __ioremap(offset, size,
-			 __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI));
-}
-
+void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 extern void iounmap(void *addr);
+
 #endif
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 497fd908a4c4..2fe9ff5b5d6f 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -97,7 +97,7 @@ extern void paging_init(void);
 /* Define some higher level generic page attributes.
  *
  * If you change _PAGE_CI definition be sure to change it in
- * io.h for ioremap_nocache() too.
+ * io.h for ioremap() too.
  */
 
 /*
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index e0c551ca0891..8f8e97f7eac9 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -34,8 +34,7 @@ static unsigned int fixmaps_used __initdata;
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-void __iomem *__ref
-__ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
+void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 {
 	phys_addr_t p;
 	unsigned long v;
@@ -66,7 +65,8 @@ __ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
 		fixmaps_used += (size >> PAGE_SHIFT);
 	}
 
-	if (ioremap_page_range(v, v + size, p, prot)) {
+	if (ioremap_page_range(v, v + size, p,
+			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
 		if (likely(mem_init_done))
 			vfree(area->addr);
 		else
@@ -76,7 +76,7 @@ __ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
 
 	return (void __iomem *)(offset + (char *)v);
 }
-EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap);
 
 void iounmap(void *addr)
 {
-- 
2.20.1

