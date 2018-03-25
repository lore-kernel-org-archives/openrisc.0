From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:45 -0400
Subject: [OpenRISC] [PATCH v2 08/16] m32r: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-9-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/m32r/Kconfig   |  1 +
 arch/m32r/mm/init.c | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index dd84ee194579..010a2b999181 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -21,6 +21,7 @@ config M32R
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DIRECT_OPS
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
+	select INITRAMFS_GENERIC_UNLOAD
 
 config SBUS
 	bool
diff --git a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
index 93abc8c3a46e..e2b5f09209ee 100644
--- a/arch/m32r/mm/init.c
+++ b/arch/m32r/mm/init.c
@@ -139,14 +139,3 @@ void free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-/*======================================================================*
- * free_initrd_mem() :
- * orig : arch/sh/mm/init.c
- *======================================================================*/
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2

