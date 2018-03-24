From: Shea Levy <shea@shealevy.com>
Date: Sat, 24 Mar 2018 13:44:49 -0400
Subject: [OpenRISC] [PATCH 07/16] h8300: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Message-ID: <20180324174458.26423-8-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/h8300/Kconfig   | 1 +
 arch/h8300/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 091d6d04b5e5..58c9b6b1df16 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -24,6 +24,7 @@ config H8300
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DIRECT_OPS
+	select INITRAMFS_GENERIC_UNLOAD
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 015287ac8ce8..37574332b202 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -102,13 +102,6 @@ void __init mem_init(void)
 }
 
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void
 free_initmem(void)
 {
-- 
2.16.2

