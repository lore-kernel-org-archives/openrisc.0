From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 26 Mar 2021 13:44:50 +0000 (UTC)
Subject: [OpenRISC] [PATCH v3 03/17] cmdline: Gives architectures
 opportunity to use generically defined boot cmdline manipulation
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
Message-ID: <76f43e108bda39dd374928d6d8b86038cc205e74.1616765869.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Most architectures have similar boot command line manipulation
options. This patchs adds the definition in init/Kconfig, gated by
CONFIG_HAVE_CMDLINE that the architectures can select to use them.

CONFIG_CMDLINE_EXTEND is understood differently by architectures.
For some of them it appends built-in CMDLINE to bootloader provided
line. For others it appends the bootloader provided CMDLINE to the
built-in one.
To avoid confusion, this commit brings to different options:
- CONFIG_CMDLINE_APPEND to append the built-in CMDLINE to the
bootloader line.
- CONFIG_CMDLINE_PREPEND to prepend the built-in CMDLINE in front of
the bootloader line.

For compatibility with existing architecture which uses CONFIG_OF, as
OF has already been converted to generic cmdline, we keep
CONFIG_CMDLINE_EXTEND as a synonym to CONFIG_CMDLINE_APPEND until
arm, powerpc, riscv and sh architectures have been converted.

A few differences are identified and will have to be taken
into account when converting the architecture to generic cmdline:
- riscv has CMDLINE_FALLBACK instead of CMDLINE_FROM_BOOTLOADER
- Some architectures are using CONFIG_CMDLINE_OVERRIDE or
CONFIG_CMDLINE_OVERWRITE instead of CONFIG_CMDLINE_FORCE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3:
- Comments from Will.
- Remove CONFIG_CMDLINE_BOOL. Using CONFIG_CMDLINE != "" instead, like arm and powerpc.
- Changed EXTEND to APPEND. Keep EXTEND for backward compatibility.
---
 include/linux/cmdline.h |  2 +-
 init/Kconfig            | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index dea87edd41be..38306c109041 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -36,7 +36,7 @@ static __always_inline void __cmdline_build(char *dst, const char *src, size_t l
 
 	cmdline_strlcat(dst, src, len);
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) || IS_ENABLED(CONFIG_CMDLINE_APPEND))
 		cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
 }
 
diff --git a/init/Kconfig b/init/Kconfig
index 5f5c776ef192..af0d84662cc2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -117,6 +117,58 @@ config INIT_ENV_ARG_LIMIT
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
 
+config GENERIC_CMDLINE
+	bool
+
+config CMDLINE
+	string "Default kernel command string" if GENERIC_CMDLINE
+	default ""
+	help
+	  Defines a default kernel command string.
+	  If this string is not empty, additional choices are proposed
+	  below to determine how it will be used by the kernel.
+
+choice
+	prompt "Kernel command line type" if CMDLINE != ""
+	default CMDLINE_PREPEND if ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT
+	default CMDLINE_FROM_BOOTLOADER
+	depends on GENERIC_CMDLINE
+	help
+	  Determine how the default kernel arguments are combined with any
+	  arguments passed by the bootloader if any.
+
+config CMDLINE_FROM_BOOTLOADER
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Uses the command-line options passed by the boot loader. If
+	  the boot loader doesn't provide any, the default kernel command
+	  string provided in CMDLINE will be used.
+
+config CMDLINE_APPEND
+	bool "Append to the bootloader kernel arguments"
+	help
+	  The default kernel command string will be appended to the
+	  command-line arguments provided by the bootloader.
+
+config CMDLINE_PREPEND
+	bool "Prepend to the bootloader kernel arguments"
+	help
+	  The default kernel command string will be prepended to the
+	  command-line arguments provided by the bootloader.
+
+config CMDLINE_FORCE
+	bool "Always use the default kernel command string"
+	help
+	  Always use the default kernel command string, ignoring any
+	  arguments provided by the bootloader.
+endchoice
+
+config CMDLINE_EXTEND
+	bool
+	default CMDLINE_APPEND
+	help
+	  To be removed once all architectures are converted to generic CMDLINE
+
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on HAS_IOMEM
-- 
2.25.0

