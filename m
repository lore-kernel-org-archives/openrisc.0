From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:12 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 11/20] microblaze: Convert to GENERIC_CMDLINE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <c73e170d5fbcc3ac5d7bc98a1e0bfa0b899b185e.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/microblaze/Kconfig               | 24 +-----------------------
 arch/microblaze/configs/mmu_defconfig |  2 +-
 arch/microblaze/kernel/head.S         |  4 ++--
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 0660f47012bc..1242f34bc2a2 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -15,6 +15,7 @@ config MICROBLAZE
 	select COMMON_CLK
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
+	select GENERIC_CMDLINE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
@@ -93,29 +94,6 @@ source "kernel/Kconfig.hz"
 config MMU
 	def_bool y
 
-comment "Boot options"
-
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Default kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyUL0,115200"
-	help
-	  On some architectures there is currently no way for the boot loader
-	  to pass arguments to the kernel. For these architectures, you should
-	  supply some command-line options at build time by entering them
-	  here.
-
-config CMDLINE_FORCE
-	bool "Force default kernel command string"
-	depends on CMDLINE_BOOL
-	default n
-	help
-	  Set this to have arguments from the default kernel command string
-	  override those passed by the boot loader.
-
 endmenu
 
 menu "Kernel features"
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 51337fffb947..b4d2219d0a8f 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -16,7 +16,7 @@ CONFIG_XILINX_MICROBLAZE0_USE_DIV=1
 CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL=2
 CONFIG_XILINX_MICROBLAZE0_USE_FPU=2
 CONFIG_HZ_100=y
-CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyUL0,115200"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_HIGHMEM=y
 CONFIG_PCI_XILINX=y
diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index ec2fcb545e64..605b18c86ac8 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -105,7 +105,7 @@ _copy_fdt:
 	addik	r3, r3, -4 /* descrement loop */
 no_fdt_arg:
 
-#ifndef CONFIG_CMDLINE_BOOL
+#if CONFIG_CMDLINE == ""
 /*
  * handling command line
  * copy command line directly to cmd_line placed in data section.
@@ -126,7 +126,7 @@ _copy_command_line:
 	addik	r5, r4, 0		/* add new space for command line */
 	tovirt(r5,r5)
 skip:
-#endif /* CONFIG_CMDLINE_BOOL */
+#endif /* CONFIG_CMDLINE */
 
 #ifdef NOT_COMPILE
 /* save bram context */
-- 
2.25.0

