From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 28 Dec 2020 09:33:28 +0100
Subject: [OpenRISC] [PATCH] openrisc: io: Add missing __iomem annotation to
 iounmap()
Message-ID: <20201228083328.3823431-1-geert+renesas@glider.be>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

With C=1:

    drivers/soc/renesas/rmobile-sysc.c:330:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] base @@
    drivers/soc/renesas/rmobile-sysc.c:330:33: sparse:     expected void *addr
    drivers/soc/renesas/rmobile-sysc.c:330:33: sparse:     got void [noderef] __iomem *[assigned] base

Fix this by adding the missing __iomem annotation to iounmap().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/openrisc/include/asm/io.h | 2 +-
 arch/openrisc/mm/ioremap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 7d6b4a77b379d8e2..c298061c70a7ee2e 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -31,7 +31,7 @@
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 
 #define iounmap iounmap
-extern void iounmap(void *addr);
+extern void iounmap(void __iomem *addr);
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index a978590d802d0c3b..9595be51b100c40e 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -78,7 +78,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void iounmap(void *addr)
+void iounmap(void __iomem *addr)
 {
 	/* If the page is from the fixmap pool then we just clear out
 	 * the fixmap mapping.
-- 
2.25.1

