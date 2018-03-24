From: Shea Levy <shea@shealevy.com>
Date: Sat, 24 Mar 2018 13:44:48 -0400
Subject: [OpenRISC] [PATCH 06/16] frv: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Message-ID: <20180324174458.26423-7-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/frv/Kconfig   |  1 +
 arch/frv/mm/init.c | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index af369b05fed5..5c104b800cb1 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -17,6 +17,7 @@ config FRV
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select INITRAMFS_GENERIC_UNLOAD
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/frv/mm/init.c b/arch/frv/mm/init.c
index cf464100e838..345edc4dc462 100644
--- a/arch/frv/mm/init.c
+++ b/arch/frv/mm/init.c
@@ -131,14 +131,3 @@ void free_initmem(void)
 	free_initmem_default(-1);
 #endif
 } /* end free_initmem() */
-
-/*****************************************************************************/
-/*
- * free the initial ramdisk memory
- */
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-} /* end free_initrd_mem() */
-#endif
-- 
2.16.2

