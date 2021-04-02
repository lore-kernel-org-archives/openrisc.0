From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:16 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 14/20] riscv: Convert to GENERIC_CMDLINE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <9590d262050923a22d434358a9037131f67fcaae.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: Remove the message when forcing
---
 arch/riscv/Kconfig        | 44 +--------------------------------------
 arch/riscv/kernel/setup.c |  7 +++----
 2 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 87d7b52f278f..3dbd50bed037 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CMDLINE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IOREMAP
@@ -390,49 +391,6 @@ endmenu
 
 menu "Boot options"
 
-config CMDLINE
-	string "Built-in kernel command line"
-	help
-	  For most platforms, the arguments for the kernel's command line
-	  are provided at run-time, during boot. However, there are cases
-	  where either no arguments are being provided or the provided
-	  arguments are insufficient or even invalid.
-
-	  When that occurs, it is possible to define a built-in command
-	  line here and choose how the kernel should use it later on.
-
-choice
-	prompt "Built-in command line usage" if CMDLINE != ""
-	default CMDLINE_FALLBACK
-	help
-	  Choose how the kernel will handle the provided built-in command
-	  line.
-
-config CMDLINE_FALLBACK
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Use the built-in command line as fallback in case we get nothing
-	  during boot. This is the default behaviour.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided during boot will be
-	  appended to the built-in command line. This is useful in
-	  cases where the provided arguments are insufficient and
-	  you don't want to or cannot modify them.
-
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the built-in command line, even if we get one during
-	  boot. This is useful in case you need to override the provided
-	  command line on systems where you don't have or want control
-	  over it.
-
-endchoice
-
 config EFI_STUB
 	bool
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f8f15332caa2..d4f16a9c1762 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
 #include <linux/efi.h>
+#include <linux/cmdline.h>
 
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
@@ -228,10 +229,8 @@ static void __init parse_dtb(void)
 	}
 
 	pr_err("No DTB passed to the kernel\n");
-#ifdef CONFIG_CMDLINE_FORCE
-	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
-#endif
+
+	cmdline_build(boot_command_line, NULL);
 }
 
 void __init setup_arch(char **cmdline_p)
-- 
2.25.0

