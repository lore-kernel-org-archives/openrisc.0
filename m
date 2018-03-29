From: Stafford Horne <shorne@gmail.com>
Date: Thu, 29 Mar 2018 20:50:51 +0900
Subject: [OpenRISC] [PATCH v5 12/16] openrisc: Switch to generic
	free_initrd_mem.
In-Reply-To: <20180329113207.30674-12-shea@shealevy.com>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
 <20180329113207.30674-12-shea@shealevy.com>
Message-ID: <20180329115051.GF2836@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Mar 29, 2018 at 07:32:03AM -0400, Shea Levy wrote:
> The generic implementation is functionally identical.
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 6972d5d6f23f..c1a3dcf9ad40 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -222,13 +222,6 @@ void __init mem_init(void)
>  	return;
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> -
>  void free_initmem(void)
>  {
>  	free_initmem_default(-1);
> -- 
> 2.16.2
> 
