From: Stafford Horne <shorne@gmail.com>
Date: Fri, 22 Nov 2019 20:39:45 +0900
Subject: [OpenRISC] [PATCH] openrisc: Fix Kconfig indentation
In-Reply-To: <20191120133712.12066-1-krzk@kernel.org>
References: <20191120133712.12066-1-krzk@kernel.org>
Message-ID: <20191122113945.GL24874@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Nov 20, 2019 at 09:37:12PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Stafford Horne <shorne@gmail.com>

Thanks, I must have forgot to hit the TAB button on a few of these.  I will
queue these up for the next release unless you have a queue you want to merge
them on.

-Stafford

> ---
>  arch/openrisc/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index bf326f0edd2f..1928e061ff96 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -13,7 +13,7 @@ config OPENRISC
>  	select IRQ_DOMAIN
>  	select HANDLE_DOMAIN_IRQ
>  	select GPIOLIB
> -        select HAVE_ARCH_TRACEHOOK
> +	select HAVE_ARCH_TRACEHOOK
>  	select SPARSE_IRQ
>  	select GENERIC_IRQ_CHIP
>  	select GENERIC_IRQ_PROBE
> @@ -51,12 +51,12 @@ config NO_IOPORT_MAP
>  	def_bool y
>  
>  config TRACE_IRQFLAGS_SUPPORT
> -        def_bool y
> +	def_bool y
>  
>  # For now, use generic checksum functions
>  #These can be reimplemented in assembly later if so inclined
>  config GENERIC_CSUM
> -        def_bool y
> +	def_bool y
>  
>  config STACKTRACE_SUPPORT
>  	def_bool y
> @@ -89,8 +89,8 @@ config DCACHE_WRITETHROUGH
>  	  If unsure say N here
>  
>  config OPENRISC_BUILTIN_DTB
> -        string "Builtin DTB"
> -        default ""
> +	string "Builtin DTB"
> +	default ""
>  
>  menu "Class II Instructions"
>  
> @@ -161,13 +161,13 @@ config OPENRISC_HAVE_SHADOW_GPRS
>  	  On a unicore system it's safe to say N here if you are unsure.
>  
>  config CMDLINE
> -        string "Default kernel command string"
> -        default ""
> -        help
> -          On some architectures there is currently no way for the boot loader
> -          to pass arguments to the kernel. For these architectures, you should
> -          supply some command-line options at build time by entering them
> -          here.
> +	string "Default kernel command string"
> +	default ""
> +	help
> +	  On some architectures there is currently no way for the boot loader
> +	  to pass arguments to the kernel. For these architectures, you should
> +	  supply some command-line options at build time by entering them
> +	  here.
>  
>  menu "Debugging options"
>  
> @@ -185,7 +185,7 @@ config OPENRISC_ESR_EXCEPTION_BUG_CHECK
>  	default n
>  	help
>  	  This option enables some checks that might expose some problems
> -          in kernel.
> +	  in kernel.
>  
>  	  Say N if you are unsure.
>  
> -- 
> 2.17.1
> 
