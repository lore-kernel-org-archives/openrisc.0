From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Mon, 24 Jun 2019 15:23:08 +0100
Subject: [OpenRISC] [PATCH 1/7] arm-nommu: remove the partial
 DMA_ATTR_NON_CONSISTENT support
In-Reply-To: <20190614144431.21760-2-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-2-hch@lst.de>
Message-ID: <a017e704-c6c4-7718-7f8b-eb8a0eced14d@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 6/14/19 3:44 PM, Christoph Hellwig wrote:
> The arm-nommu DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
> does not provide a cache_sync operation.  This means any user of it
> will never be able to actually transfer cache ownership and thus cause
> coherency bugs.

By the way, Documentation/DMA-attributes.txt doesn't specify cache_sync() as
requirement for DMA_ATTR_NON_CONSISTENT it only states that it is responsibility
of the driver to have all the correct and necessary sync points.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/mm/dma-mapping-nommu.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index f304b10e23a4..bc003df45546 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -39,18 +39,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>  				 unsigned long attrs)
>  
>  {
> -	void *ret;
> -
> -	/*
> -	 * Try generic allocator first if we are advertised that
> -	 * consistency is not required.
> -	 */
> -
> -	if (attrs & DMA_ATTR_NON_CONSISTENT)
> -		return dma_direct_alloc_pages(dev, size, dma_handle, gfp,
> -				attrs);
> -
> -	ret = dma_alloc_from_global_coherent(size, dma_handle);
> +	void *ret = dma_alloc_from_global_coherent(size, dma_handle);
>  
>  	/*
>  	 * dma_alloc_from_global_coherent() may fail because:
> @@ -70,16 +59,9 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
>  			       void *cpu_addr, dma_addr_t dma_addr,
>  			       unsigned long attrs)
>  {
> -	if (attrs & DMA_ATTR_NON_CONSISTENT) {
> -		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
> -	} else {
> -		int ret = dma_release_from_global_coherent(get_order(size),
> -							   cpu_addr);
> -
> -		WARN_ON_ONCE(ret == 0);
> -	}
> +	int ret = dma_release_from_global_coherent(get_order(size), cpu_addr);
>  
> -	return;
> +	WARN_ON_ONCE(ret == 0);
>  }
>  
>  static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> 

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
