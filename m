From: Stafford Horne <shorne@gmail.com>
Date: Wed, 19 Dec 2018 23:47:18 +0900
Subject: [OpenRISC] [PATCH resend] openrisc: Fix broken paths to
	arch/or32
In-Reply-To: <20181203122047.12225-1-geert@linux-m68k.org>
References: <20181203122047.12225-1-geert@linux-m68k.org>
Message-ID: <20181219144718.GK3235@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 03, 2018 at 01:20:47PM +0100, Geert Uytterhoeven wrote:
> OpenRISC was mainlined as "openrisc", not "or32".
> vmlinux.lds is generated from vmlinux.lds.S.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks,

Sorry for the delay.

I will queue this up.

-Stafford

> ---
>  arch/openrisc/kernel/entry.S | 2 +-
>  arch/openrisc/kernel/head.S  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> index 0c826ad6e994cce3..ee6159d2ed22ec49 100644
> --- a/arch/openrisc/kernel/entry.S
> +++ b/arch/openrisc/kernel/entry.S
> @@ -240,7 +240,7 @@ handler:							;\
>   *	 occured. in fact they never do. if you need them use
>   *	 values saved on stack (for SPR_EPC, SPR_ESR) or content
>   *       of r4 (for SPR_EEAR). for details look at EXCEPTION_HANDLE()
> - *       in 'arch/or32/kernel/head.S'
> + *       in 'arch/openrisc/kernel/head.S'
>   */
>  
>  /* =====================================================[ exceptions] === */
> diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> index 9fc6b60140f007be..31ed257ff06188ee 100644
> --- a/arch/openrisc/kernel/head.S
> +++ b/arch/openrisc/kernel/head.S
> @@ -1728,7 +1728,7 @@ _string_nl:
>  
>  /*
>   * .data section should be page aligned
> - *	(look into arch/or32/kernel/vmlinux.lds)
> + *	(look into arch/openrisc/kernel/vmlinux.lds.S)
>   */
>  	.section .data,"aw"
>  	.align	8192
> -- 
> 2.17.1
> 
