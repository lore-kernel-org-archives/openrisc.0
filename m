From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:48 -0400
Subject: [OpenRISC] [PATCH v2 11/16] nios2: Use INITRAMFS_GENERIC_UNLOAD
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-12-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/nios2/Kconfig   | 1 +
 arch/nios2/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..d3b72d5c8967 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -19,6 +19,7 @@ config NIOS2
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
+	select INITRAMFS_GENERIC_UNLOAD
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index c92fe4234009..3df75ff8c768 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -82,13 +82,6 @@ void __init mmu_init(void)
 	flush_tlb_all();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
-- 
2.16.2

