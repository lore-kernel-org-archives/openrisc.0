From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:47 -0400
Subject: [OpenRISC] [PATCH v2 10/16] microblaze: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-11-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/microblaze/Kconfig   | 1 +
 arch/microblaze/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3817a3e2146c..ef23e8410b4b 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -36,6 +36,7 @@ config MICROBLAZE
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
+	select INITRAMFS_GENERIC_UNLOAD
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index df6de7ccdc2e..ea058dfda222 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -187,13 +187,6 @@ void __init setup_memory(void)
 	paging_init();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void free_initmem(void)
 {
 	free_initmem_default(-1);
-- 
2.16.2

