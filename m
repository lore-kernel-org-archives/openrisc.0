From: Stafford Horne <shorne@gmail.com>
Date: Thu, 29 Mar 2018 14:01:44 +0900
Subject: [OpenRISC] [PATCH v4 2/8] openrisc: Set CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <20180327161911.14086-3-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
 <20180327161911.14086-3-palmer@sifive.com>
Message-ID: <20180329050144.GD2836@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 27, 2018 at 09:19:05AM -0700, Palmer Dabbelt wrote:
> arm has an optional MULTI_IRQ_HANDLER, which openrisc copied but didn't
> make optional.  I'm converting this to generic code, but in order to
> ensure everything stays bisectable I want this defined on openrisc for
> now.  This will go away by the end of the patch set.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Hi Palmer,
Thanks for doing this work, its always nice to see generic code pulled out of
architecture ports.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 339df7324e9c..9ecad05bfc73 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -27,6 +27,7 @@ config OPENRISC
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_SMP_IDLE_THREAD
>  	select MODULES_USE_ELF_RELA
> +	select MULTI_IRQ_HANDLER
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> @@ -68,6 +69,9 @@ config STACKTRACE_SUPPORT
>  config LOCKDEP_SUPPORT
>  	def_bool  y
>  
> +config MULTI_IRQ_HANDLER
> +	def_bool y
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> -- 
> 2.16.1
> 
