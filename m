From: Baoquan He <bhe@redhat.com>
Date: Thu, 30 Jul 2020 01:54:38 -0000
Subject: [OpenRISC] [PATCH 10/15] memblock: make memblock_debug and
 related functionality private
In-Reply-To: <20200728051153.1590-11-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-11-rppt@kernel.org>
Message-ID: <20200730015424.GJ14854@MiWiFi-R3L-srv>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 07/28/20 at 08:11am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The only user of memblock_dbg() outside memblock was s390 setup code and it
> is converted to use pr_debug() instead.
> This allows to stop exposing memblock_debug and memblock_dbg() to the rest
> of the kernel.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/s390/kernel/setup.c |  4 ++--
>  include/linux/memblock.h | 12 +-----------
>  mm/memblock.c            | 13 +++++++++++--
>  3 files changed, 14 insertions(+), 15 deletions(-)

Nice clean up.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 07aa15ba43b3..8b284cf6e199 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -776,8 +776,8 @@ static void __init memblock_add_mem_detect_info(void)
>  	unsigned long start, end;
>  	int i;
>  
> -	memblock_dbg("physmem info source: %s (%hhd)\n",
> -		     get_mem_info_source(), mem_detect.info_source);
> +	pr_debug("physmem info source: %s (%hhd)\n",
> +		 get_mem_info_source(), mem_detect.info_source);
>  	/* keep memblock lists close to the kernel */
>  	memblock_set_bottom_up(true);
>  	for_each_mem_detect_block(i, &start, &end) {
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 220b5f0dad42..e6a23b3db696 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -90,7 +90,6 @@ struct memblock {
>  };
>  
>  extern struct memblock memblock;
> -extern int memblock_debug;
>  
>  #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
>  #define __init_memblock __meminit
> @@ -102,9 +101,6 @@ void memblock_discard(void);
>  static inline void memblock_discard(void) {}
>  #endif
>  
> -#define memblock_dbg(fmt, ...) \
> -	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> -
>  phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
>  				   phys_addr_t size, phys_addr_t align);
>  void memblock_allow_resize(void);
> @@ -456,13 +452,7 @@ bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
>  bool memblock_is_reserved(phys_addr_t addr);
>  bool memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
>  
> -extern void __memblock_dump_all(void);
> -
> -static inline void memblock_dump_all(void)
> -{
> -	if (memblock_debug)
> -		__memblock_dump_all();
> -}
> +void memblock_dump_all(void);
>  
>  /**
>   * memblock_set_current_limit - Set the current allocation limit to allow
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a5b9b3df81fc..824938849f6d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -134,7 +134,10 @@ struct memblock memblock __initdata_memblock = {
>  	     i < memblock_type->cnt;					\
>  	     i++, rgn = &memblock_type->regions[i])
>  
> -int memblock_debug __initdata_memblock;
> +#define memblock_dbg(fmt, ...) \
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> +
> +static int memblock_debug __initdata_memblock;
>  static bool system_has_some_mirror __initdata_memblock = false;
>  static int memblock_can_resize __initdata_memblock;
>  static int memblock_memory_in_slab __initdata_memblock = 0;
> @@ -1919,7 +1922,7 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>  	}
>  }
>  
> -void __init_memblock __memblock_dump_all(void)
> +static void __init_memblock __memblock_dump_all(void)
>  {
>  	pr_info("MEMBLOCK configuration:\n");
>  	pr_info(" memory size = %pa reserved size = %pa\n",
> @@ -1933,6 +1936,12 @@ void __init_memblock __memblock_dump_all(void)
>  #endif
>  }
>  
> +void __init_memblock memblock_dump_all(void)
> +{
> +	if (memblock_debug)
> +		__memblock_dump_all();
> +}
> +
>  void __init memblock_allow_resize(void)
>  {
>  	memblock_can_resize = 1;
> -- 
> 2.26.2
> 
> 

