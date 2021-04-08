From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Apr 2021 14:41:48 -0500
Subject: [OpenRISC] [PATCH v4 18/20] x86: Convert to GENERIC_CMDLINE
In-Reply-To: <ab0fd4477964cdbf99e3dd2965a455aa3e738e4b.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <ab0fd4477964cdbf99e3dd2965a455aa3e738e4b.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <20210408194148.GB1724284@robh.at.kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Apr 02, 2021 at 03:18:20PM +0000, Christophe Leroy wrote:
> This converts the architecture to GENERIC_CMDLINE.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/x86/Kconfig        | 45 ++---------------------------------------
>  arch/x86/kernel/setup.c | 17 ++--------------
>  2 files changed, 4 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a20684d56b4b..66b384228ca3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -104,6 +104,7 @@ config X86
>  	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_USE_SYM_ANNOTATIONS
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> +	select ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT

Seems to be non-existent kconfig option.

>  	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_WANT_HUGE_PMD_SHARE
> @@ -118,6 +119,7 @@ config X86
>  	select EDAC_SUPPORT
>  	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
>  	select GENERIC_CLOCKEVENTS_MIN_ADJUST
> +	select GENERIC_CMDLINE
>  	select GENERIC_CMOS_UPDATE
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_CPU_VULNERABILITIES
> @@ -2358,49 +2360,6 @@ choice
>  
>  endchoice
>  
> -config CMDLINE_BOOL
> -	bool "Built-in kernel command line"
> -	help
> -	  Allow for specifying boot arguments to the kernel at
> -	  build time.  On some systems (e.g. embedded ones), it is
> -	  necessary or convenient to provide some or all of the
> -	  kernel boot arguments with the kernel itself (that is,
> -	  to not rely on the boot loader to provide them.)
> -
> -	  To compile command line arguments into the kernel,
> -	  set this option to 'Y', then fill in the
> -	  boot arguments in CONFIG_CMDLINE.
> -
> -	  Systems with fully functional boot loaders (i.e. non-embedded)
> -	  should leave this option set to 'N'.
> -
> -config CMDLINE
> -	string "Built-in kernel command string"
> -	depends on CMDLINE_BOOL
> -	default ""
> -	help
> -	  Enter arguments here that should be compiled into the kernel
> -	  image and used at boot time.  If the boot loader provides a
> -	  command line at boot time, it is appended to this string to
> -	  form the full kernel command line, when the system boots.
> -
> -	  However, you can use the CONFIG_CMDLINE_FORCE option to
> -	  change this behavior.
> -
> -	  In most cases, the command line (whether built-in or provided
> -	  by the boot loader) should specify the device for the root
> -	  file system.
> -
> -config CMDLINE_FORCE
> -	bool "Built-in command line overrides boot loader arguments"
> -	depends on CMDLINE_BOOL && CMDLINE != ""
> -	help
> -	  Set this option to 'Y' to have the kernel ignore the boot loader
> -	  command line, and use ONLY the built-in command line.
> -
> -	  This is used to work around broken boot loaders.  This should
> -	  be set to 'N' under normal conditions.
> -
>  config MODIFY_LDT_SYSCALL
>  	bool "Enable the LDT (local descriptor table)" if EXPERT
>  	default y
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6f2de58eeb54..3f274b02e51c 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -5,6 +5,7 @@
>   * This file contains the setup_arch() code, which handles the architecture-dependent
>   * parts of early kernel initialization.
>   */
> +#include <linux/cmdline.h>
>  #include <linux/console.h>
>  #include <linux/crash_dump.h>
>  #include <linux/dma-map-ops.h>
> @@ -161,9 +162,6 @@ unsigned long saved_video_mode;
>  #define RAMDISK_LOAD_FLAG		0x4000
>  
>  static char __initdata command_line[COMMAND_LINE_SIZE];
> -#ifdef CONFIG_CMDLINE_BOOL
> -static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
> -#endif
>  
>  #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
>  struct edd edd;
> @@ -883,18 +881,7 @@ void __init setup_arch(char **cmdline_p)
>  	bss_resource.start = __pa_symbol(__bss_start);
>  	bss_resource.end = __pa_symbol(__bss_stop)-1;
>  
> -#ifdef CONFIG_CMDLINE_BOOL
> -#ifdef CONFIG_CMDLINE_FORCE
> -	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -#else
> -	if (builtin_cmdline[0]) {
> -		/* append boot loader cmdline to builtin */
> -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> -		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -	}
> -#endif
> -#endif
> +	cmdline_build(boot_command_line, boot_command_line);
>  
>  	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p = command_line;

Once this is all done, I wonder if we can get rid of the strlcpy and 
perhaps also cmdline_p.

Rob
