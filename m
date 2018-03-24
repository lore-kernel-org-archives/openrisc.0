From: Shea Levy <shea@shealevy.com>
Date: Sat, 24 Mar 2018 13:44:47 -0400
Subject: [OpenRISC] [PATCH 05/16] c6x: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Message-ID: <20180324174458.26423-6-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/c6x/Kconfig   | 1 +
 arch/c6x/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index c6b4dd1418b4..857f95f9a6a4 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -19,6 +19,7 @@ config C6X
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select INITRAMFS_GENERIC_UNLOAD
 
 config MMU
 	def_bool n
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index 4cc72b0d1c1d..a11cb657182a 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -66,13 +66,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __init free_initmem(void)
 {
 	free_initmem_default(-1);
-- 
2.16.2

