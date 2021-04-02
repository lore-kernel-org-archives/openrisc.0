From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:08 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 07/20] powerpc: Convert to GENERIC_CMDLINE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <bcc28f6552708885aecb14a7106b65afbffcc294.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This updates the powerpc code to use the new cmdline building function.

The cmdline_build() defines a temporary string in __initdata.
powerpc uses __prombss instead at the moment, so we must
call cmdline_build() with destination different from the source
to allow GCC to optimise the temporary string out.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4:
- Use cmdline_build() instead of __cmdline_build()
- Add cmdline_strlcpy() define
---
 arch/powerpc/Kconfig            | 37 +--------------------------------
 arch/powerpc/kernel/prom_init.c | 21 +++++++++----------
 2 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c1344c05226c..6723f10ac246 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -168,6 +168,7 @@ config PPC
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
@@ -888,42 +889,6 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
 
-config CMDLINE
-	string "Initial kernel command string"
-	default ""
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  most cases you will need to specify the root device here.
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
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
-
-endchoice
-
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 33316ee55265..704afd028213 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -152,7 +152,7 @@ static struct prom_t __prombss prom;
 static unsigned long __prombss prom_entry;
 
 static char __prombss of_stdout_device[256];
-static char __prombss prom_scratch[256];
+static char __prombss prom_scratch[COMMAND_LINE_SIZE];
 
 static unsigned long __prombss dt_header_start;
 static unsigned long __prombss dt_struct_start, dt_struct_end;
@@ -770,24 +770,23 @@ static unsigned long prom_memparse(const char *ptr, const char **retptr)
  * Early parsing of the command line passed to the kernel, used for
  * "mem=x" and the options that affect the iommu
  */
+#define cmdline_strlcat prom_strlcat
+#define cmdline_strlcpy prom_strlcpy
+#include <linux/cmdline.h>
+
 static void __init early_cmdline_parse(void)
 {
 	const char *opt;
-
-	char *p;
 	int l = 0;
-
-	prom_cmd_line[0] = 0;
-	p = prom_cmd_line;
+	bool truncated;
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && (long)prom.chosen > 0)
-		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
+		l = prom_getprop(prom.chosen, "bootargs", prom_scratch,
+				 COMMAND_LINE_SIZE - 1);
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) || l <= 0 || p[0] == '\0')
-		prom_strlcat(prom_cmd_line, " " CONFIG_CMDLINE,
-			     sizeof(prom_cmd_line));
+	truncated = !__cmdline_build(prom_cmd_line, l > 0 ? prom_scratch : NULL);
 
-	prom_printf("command line: %s\n", prom_cmd_line);
+	prom_printf("command line: %s %s\n", prom_cmd_line, truncated ? "[truncated]" : "");
 
 #ifdef CONFIG_PPC64
 	opt = prom_strstr(prom_cmd_line, "iommu=");
-- 
2.25.0

