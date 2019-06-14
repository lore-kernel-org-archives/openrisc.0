From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date: Fri, 14 Jun 2019 18:05:01 +0000
Subject: [OpenRISC] [PATCH 7/7] arc: use the generic remapping allocator
 for coherent DMA allocations
In-Reply-To: <20190614144431.21760-8-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-8-hch@lst.de>
Message-ID: <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

Regular question - do you have any public git repository with all this dma changes?
I want to test it for ARC.

Pretty sure the
 [PATCH 2/7] arc: remove the partial DMA_ATTR_NON_CONSISTENT support
is fine.

Not so sure about
 [PATCH 7/7] arc: use the generic remapping allocator for coherent DMA allocations
:)

On Fri, 2019-06-14 at 16:44 +0200, Christoph Hellwig wrote:
> Replace the code that sets up uncached PTEs with the generic vmap based
> remapping code.  It also provides an atomic pool for allocations from
> non-blocking context, which we not properly supported by the existing
> arc code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig  |  2 ++
>  arch/arc/mm/dma.c | 62 ++++++++---------------------------------------
>  2 files changed, 12 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 23e063df5d2c..cdad7d30ff1d 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -10,6 +10,7 @@ config ARC
>  	def_bool y
>  	select ARC_TIMERS
>  	select ARCH_HAS_DMA_COHERENT_TO_PFN
> +	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
> @@ -19,6 +20,7 @@ config ARC
>  	select BUILDTIME_EXTABLE_SORT
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> +	select DMA_DIRECT_REMAP
>  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_FIND_FIRST_BIT
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 9832928f896d..0fa850709fac 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -11,46 +11,15 @@
>  #include <asm/cacheflush.h>
>  
>  /*
> - * ARCH specific callbacks for generic noncoherent DMA ops (dma/noncoherent.c)
> + * ARCH specific callbacks for generic noncoherent DMA ops
>   *  - hardware IOC not available (or "dma-coherent" not set for device in DT)
>   *  - But still handle both coherent and non-coherent requests from caller
>   *
>   * For DMA coherent hardware (IOC) generic code suffices
>   */
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t gfp, unsigned long attrs)
> -{
> -	unsigned long order = get_order(size);
> -	struct page *page;
> -	phys_addr_t paddr;
> -	void *kvaddr;
> -
> -	/*
> -	 * __GFP_HIGHMEM flag is cleared by upper layer functions
> -	 * (in include/linux/dma-mapping.h) so we should never get a
> -	 * __GFP_HIGHMEM here.
> -	 */
> -	BUG_ON(gfp & __GFP_HIGHMEM);
> -
> -	page = alloc_pages(gfp | __GFP_ZERO, order);
> -	if (!page)
> -		return NULL;
> -
> -	/* This is linear addr (0x8000_0000 based) */
> -	paddr = page_to_phys(page);
> -
> -	*dma_handle = paddr;
> -
> -	/*
> -	 * A coherent buffer needs MMU mapping to enforce non-cachability.
> -	 * kvaddr is kernel Virtual address (0x7000_0000 based).
> -	 */
> -	kvaddr = ioremap_nocache(paddr, size);
> -	if (kvaddr == NULL) {
> -		__free_pages(page, order);
> -		return NULL;
> -	}
>  
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
>  	/*
>  	 * Evict any existing L1 and/or L2 lines for the backing page
>  	 * in case it was used earlier as a normal "cached" page.
> @@ -61,24 +30,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	 * Currently flush_cache_vmap nukes the L1 cache completely which
>  	 * will be optimized as a separate commit
>  	 */
> -	dma_cache_wback_inv(paddr, size);
> -	return kvaddr;
> -}
> -
> -void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	phys_addr_t paddr = dma_handle;
> -	struct page *page = virt_to_page(paddr);
> -
> -	iounmap((void __force __iomem *)vaddr);
> -	__free_pages(page, get_order(size));
> -}
> -
> -long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> -		dma_addr_t dma_addr)
> -{
> -	return __phys_to_pfn(dma_addr);
> +	dma_cache_wback_inv(page_to_phys(page), size);
>  }
>  
>  /*
> @@ -155,3 +107,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	dev_info(dev, "use %sncoherent DMA ops\n",
>  		 dev->dma_coherent ? "" : "non");
>  }
> +
> +static int __init atomic_pool_init(void)
> +{
> +	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> +}
> +postcore_initcall(atomic_pool_init);
-- 
 Eugeniy Paltsev
