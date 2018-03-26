From: Palmer Dabbelt <palmer@sifive.com>
Date: Sun, 25 Mar 2018 17:41:14 -0700 (PDT)
Subject: [OpenRISC] [PATCH v2 02/16] riscv: Use INITRAMFS_GENERIC_UNLOAD.
In-Reply-To: <20180325221853.10839-3-shea@shealevy.com>
Message-ID: <mhng-5691a509-dedf-4092-bd6d-020a81512c15@palmer-si-x1c4>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, 25 Mar 2018 15:18:39 PDT (-0700), shea at shealevy.com wrote:
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  arch/riscv/Kconfig   | 1 +
>  arch/riscv/mm/init.c | 6 ------
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c22ebe08e902..ab1b4cee84fc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -37,6 +37,7 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
> +	select INITRAMFS_GENERIC_UNLOAD
>
>  config MMU
>  	def_bool y
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c77df8142be2..36f83fe8a726 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -62,9 +62,3 @@ void free_initmem(void)
>  {
>  	free_initmem_default(0);
>  }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -}
> -#endif /* CONFIG_BLK_DEV_INITRD */

I haven't looked through the rest of the patch set, but this is a pretty 
trivial change so feel free to add a 

Reviewed-By: Palmer Dabbelt <palmer@sifive.com>

if you'd like.  If you'd like it merged through my tree then just say 
something!
