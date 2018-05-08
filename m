From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 8 May 2018 11:05:20 +0100
Subject: [OpenRISC] [PATCH 3/3] dma-debug: unexport
 dma_debug_resize_entries and debug_dma_dump_mappings
In-Reply-To: <20180424140235.9125-4-hch@lst.de>
References: <20180424140235.9125-1-hch@lst.de>
 <20180424140235.9125-4-hch@lst.de>
Message-ID: <bb5bb25f-24da-9729-a39b-3b88c65ef628@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 24/04/18 15:02, Christoph Hellwig wrote:
> Only used by the AMD GART driver, which must be built in.

FWIW debug_dma_dump_mappings() is also called by the Intel VT-d driver, 
but the same reasoning still applies. This does rather beg the question 
of whether it's right to have bits of low-level dma-debug internals 
*only* called by a couple of IOMMU drivers, but that can wait for 
another day.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-debug.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 075253cb613b..6a1ebaa83623 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
>   		spin_unlock_irqrestore(&bucket->lock, flags);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_dump_mappings);
>   
>   /*
>    * For each mapping (initial cacheline in the case of
> @@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(dma_debug_resize_entries);
>   
>   /*
>    * DMA-API debugging init code
> 
