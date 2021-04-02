From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:04 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 03/20] x86/efi: Replace
 CONFIG_CMDLINE_OVERRIDE by CONFIG_CMDLINE_FORCE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <76542a49b685ddb41894fd53feb250fcec731b01.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

During boot, x86 uses EFI driver. That driver is also used
by ARM.

In order to refactor the command line processing in that driver
in a following patch, rename CONFIG_CMDLINE_OVERRIDE by
CONFIG_CMDLINE_FORCE on the x86 in order to be similar
to ARM (and most other architectures).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: New
---
 arch/x86/Kconfig                        | 4 ++--
 arch/x86/kernel/setup.c                 | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..a20684d56b4b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2384,14 +2384,14 @@ config CMDLINE
 	  command line at boot time, it is appended to this string to
 	  form the full kernel command line, when the system boots.
 
-	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  However, you can use the CONFIG_CMDLINE_FORCE option to
 	  change this behavior.
 
 	  In most cases, the command line (whether built-in or provided
 	  by the boot loader) should specify the device for the root
 	  file system.
 
-config CMDLINE_OVERRIDE
+config CMDLINE_FORCE
 	bool "Built-in command line overrides boot loader arguments"
 	depends on CMDLINE_BOOL && CMDLINE != ""
 	help
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..6f2de58eeb54 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -884,7 +884,7 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
 #ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
+#ifdef CONFIG_CMDLINE_FORCE
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..28659276b6ba 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -742,7 +742,7 @@ unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 #endif
-	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = efi_parse_options((char *)cmdline_paddr);
-- 
2.25.0

