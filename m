From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:40 -0400
Subject: [OpenRISC] [PATCH v2 03/16] alpha: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-4-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/alpha/Kconfig   | 1 +
 arch/alpha/mm/init.c | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index e96adcbcab41..238d743ae8f2 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -27,6 +27,7 @@ config ALPHA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
+	select INITRAMFS_GENERIC_UNLOAD
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 9d74520298ab..55f7c8efa962 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -291,11 +291,3 @@ free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void
-free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2

