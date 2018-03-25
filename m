From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:46 -0400
Subject: [OpenRISC] [PATCH v2 09/16] m68k: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-10-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/m68k/Kconfig   | 1 +
 arch/m68k/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..47913a68529e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -24,6 +24,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select INITRAMFS_GENERIC_UNLOAD
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index e85acd131fa8..e20bef09258c 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -172,10 +172,3 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 	print_memmap();
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2

