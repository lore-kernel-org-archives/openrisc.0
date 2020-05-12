From: Greg Ungerer <gerg@linux-m68k.org>
Date: Wed, 13 May 2020 00:44:59 +1000
Subject: [OpenRISC] [PATCH 16/31] m68knommu: use asm-generic/cacheflush.h
In-Reply-To: <20200510075510.987823-17-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-17-hch@lst.de>
Message-ID: <fb98853b-c02a-a682-443e-2ae62d0502d9@linux-m68k.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

On 10/5/20 5:54 pm, Christoph Hellwig wrote:
> m68knommu needs almost no cache flushing routines of its own.  Rely on
> asm-generic/cacheflush.h for the defaults.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>   arch/m68k/include/asm/cacheflush_no.h | 19 ++-----------------
>   1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/cacheflush_no.h b/arch/m68k/include/asm/cacheflush_no.h
> index 11e9a9dcbfb24..2731f07e7be8c 100644
> --- a/arch/m68k/include/asm/cacheflush_no.h
> +++ b/arch/m68k/include/asm/cacheflush_no.h
> @@ -9,25 +9,8 @@
>   #include <asm/mcfsim.h>
>   
>   #define flush_cache_all()			__flush_cache_all()
> -#define flush_cache_mm(mm)			do { } while (0)
> -#define flush_cache_dup_mm(mm)			do { } while (0)
> -#define flush_cache_range(vma, start, end)	do { } while (0)
> -#define flush_cache_page(vma, vmaddr)		do { } while (0)
>   #define flush_dcache_range(start, len)		__flush_dcache_all()
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -#define flush_dcache_page(page)			do { } while (0)
> -#define flush_dcache_mmap_lock(mapping)		do { } while (0)
> -#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>   #define flush_icache_range(start, len)		__flush_icache_all()
> -#define flush_icache_page(vma,pg)		do { } while (0)
> -#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
> -#define flush_cache_vmap(start, end)		do { } while (0)
> -#define flush_cache_vunmap(start, end)		do { } while (0)
> -
> -#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
> -#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
>   
>   void mcf_cache_push(void);
>   
> @@ -98,4 +81,6 @@ static inline void cache_clear(unsigned long paddr, int len)
>   	__clear_cache_all();
>   }
>   
> +#include <asm-generic/cacheflush.h>
> +
>   #endif /* _M68KNOMMU_CACHEFLUSH_H */
> 
