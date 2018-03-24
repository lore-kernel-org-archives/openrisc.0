From: Shea Levy <shea@shealevy.com>
Date: Sat, 24 Mar 2018 13:44:55 -0400
Subject: [OpenRISC] [PATCH 13/16] parisc: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Message-ID: <20180324174458.26423-14-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/parisc/Kconfig   | 1 +
 arch/parisc/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 9792d8cf4f56..7410c2094987 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -51,6 +51,7 @@ config PARISC
 	select GENERIC_CLOCKEVENTS
 	select ARCH_NO_COHERENT_DMA_MMAP
 	select CPU_NO_EFFICIENT_FFS
+	select INITRAMFS_GENERIC_UNLOAD
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index cab32ee824d2..3643399230f3 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -932,10 +932,3 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2

