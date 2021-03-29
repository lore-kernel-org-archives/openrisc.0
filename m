From: Tan, Ley Foon <ley.foon.tan@intel.com>
Date: Mon, 29 Mar 2021 01:35:21 +0000
Subject: [OpenRISC] [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
In-Reply-To: <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
Message-ID: <BY5PR11MB38934E74AF74D40379E46AB9CC7E9@BY5PR11MB3893.namprd11.prod.outlook.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



> -----Original Message-----
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> Sent: Friday, March 26, 2021 9:45 PM
> To: will at kernel.org; danielwa at cisco.com; robh at kernel.org;
> daniel at gimpelevich.san-francisco.ca.us
> Cc: linux-arch at vger.kernel.org; devicetree at vger.kernel.org; linuxppc-
> dev at lists.ozlabs.org; linux-kernel at vger.kernel.org; linuxppc-
> dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; microblaze
> <monstr@monstr.eu>; linux-mips at vger.kernel.org; Tan, Ley Foon
> <ley.foon.tan@intel.com>; openrisc at lists.librecores.org; linux-
> hexagon at vger.kernel.org; linux-riscv at lists.infradead.org; x86 at kernel.org;
> linux-xtensa at linux-xtensa.org; linux-sh at vger.kernel.org;
> sparclinux at vger.kernel.org
> Subject: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
> 
> This converts the architecture to GENERIC_CMDLINE.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/nios2/Kconfig        | 24 +-----------------------
>  arch/nios2/kernel/setup.c | 13 ++++---------
>  2 files changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig index
> c24955c81c92..f66c97b15813 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -90,31 +90,9 @@ config NIOS2_ALIGNMENT_TRAP
> 
>  comment "Boot options"
> 
> -config CMDLINE_BOOL
> -	bool "Default bootloader kernel arguments"
> -	default y
> -
> -config CMDLINE
> -	string "Default kernel command string"
> -	default ""
> -	depends on CMDLINE_BOOL
> -	help
> -	  On some platforms, there is currently no way for the boot loader to
> -	  pass arguments to the kernel. For these platforms, you can supply
> -	  some command-line options at build time by entering them here.  In
> -	  other cases you can specify kernel args so that you don't have
> -	  to set them up in board prom initialization routines.
> -
> -config CMDLINE_FORCE
> -	bool "Force default kernel command string"
> -	depends on CMDLINE_BOOL
> -	help
> -	  Set this to have arguments from the default kernel command string
> -	  override those passed by the boot loader.
> -
>  config NIOS2_CMDLINE_IGNORE_DTB
>  	bool "Ignore kernel command string from DTB"
> -	depends on CMDLINE_BOOL
> +	depends on CMDLINE != ""
>  	depends on !CMDLINE_FORCE
>  	default y
>  	help

Missing " select GENERIC_CMDLINE" ?




> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c index
> d2f21957e99c..42464f457a6d 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -20,6 +20,7 @@
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
>  #include <linux/screen_info.h>
> +#include <linux/cmdline.h>
> 
>  #include <asm/mmu_context.h>
>  #include <asm/sections.h>
> @@ -108,7 +109,7 @@ asmlinkage void __init nios2_boot_init(unsigned r4,
> unsigned r5, unsigned r6,
>  				       unsigned r7)
>  {
>  	unsigned dtb_passed = 0;
> -	char cmdline_passed[COMMAND_LINE_SIZE] __maybe_unused =
> { 0, };
> +	char cmdline_passed[COMMAND_LINE_SIZE] = { 0, };
> 
>  #if defined(CONFIG_NIOS2_PASS_CMDLINE)
>  	if (r4 == 0x534f494e) { /* r4 is magic NIOS */ @@ -127,14 +128,8 @@
> asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
> 
>  	early_init_devtree((void *)dtb_passed);
> 
> -#ifndef CONFIG_CMDLINE_FORCE
> -	if (cmdline_passed[0])
> -		strlcpy(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
> -#ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
> -	else
> -		strlcpy(boot_command_line, CONFIG_CMDLINE,
> COMMAND_LINE_SIZE);
> -#endif
> -#endif
> +	if (cmdline_passed[0] ||
> IS_ENABLED(CONFIG_NIOS2_CMDLINE_IGNORE_DTB))
> +		cmdline_build(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
> 
>  	parse_early_param();
>  }
> --
> 2.25.0

