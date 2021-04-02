From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:09 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 08/20] arm: Convert to GENERIC_CMDLINE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <2e49b9ae60a90aec8b555946279cab059a2812a4.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4:
- Removed dependency to ATAGS
- Removed the message when forcing
---
 arch/arm/Kconfig              | 38 +----------------------------------
 arch/arm/kernel/atags_parse.c | 13 +++---------
 2 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5da96f5df48f..1a1808b0eef7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CMDLINE
 	select GENERIC_IRQ_IPI if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
@@ -1740,43 +1741,6 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 
 endchoice
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some architectures (e.g. CATS), there is currently no way
-	  for the boot loader to pass arguments to the kernel. For these
-	  architectures, you should supply some command-line options at build
-	  time by entering them here. As a minimum, you should specify the
-	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
-	depends on ATAGS
-
-config CMDLINE_FROM_BOOTLOADER
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Uses the command-line options passed by the boot loader. If
-	  the boot loader doesn't provide any, the default kernel command
-	  string provided in CMDLINE will be used.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided by the boot loader will be
-	  appended to the default kernel command string.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-endchoice
-
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 373b61f9a4f0..ef97ec015c51 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -14,6 +14,7 @@
  * is not parsed in any way).
  */
 
+#include <linux/cmdline.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
@@ -120,16 +121,8 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
 
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
-	strlcat(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n");
-#else
-	strlcpy(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#endif
+	cmdline_build(default_command_line, tag->u.cmdline.cmdline);
+
 	return 0;
 }
 
-- 
2.25.0

