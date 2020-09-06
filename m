From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 6 Sep 2020 09:15:38 +0300
Subject: [OpenRISC] [PATCH v2 1/3] openrisc: Reserve memblock for initrd
In-Reply-To: <20200905131935.972386-2-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-2-shorne@gmail.com>
Message-ID: <20200906061538.GB1213823@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Sep 05, 2020 at 10:19:33PM +0900, Stafford Horne wrote:
> Recently OpenRISC added support for external initrd images, but I found
> some instability when using larger buildroot initrd images. It turned
> out that I forgot to reserve the memblock space for the initrd image.
> 
> This patch fixes the instability issue by reserving memblock space.
> 
> Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/openrisc/kernel/setup.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index b18e775f8be3..13c87f1f872b 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -80,6 +80,16 @@ static void __init setup_memory(void)
>  	 */
>  	memblock_reserve(__pa(_stext), _end - _stext);
>  
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Then reserve the initrd, if any */
> +	if (initrd_start && (initrd_end > initrd_start)) {
> +		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
> +		unsigned long aligned_end = ALIGN(initrd_end, PAGE_SIZE);
> +
> +		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
> +	}
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
>  	early_init_fdt_reserve_self();
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
