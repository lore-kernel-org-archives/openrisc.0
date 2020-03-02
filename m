From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 2 Mar 2020 16:05:12 +0000
Subject: [OpenRISC] provide in-place uncached remapping for dma-direct v2
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
References: <20200224194446.690816-1-hch@lst.de>
Message-ID: <4fe14c57-78d4-6590-a4c4-14fbe061238e@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 24/02/2020 7:44 pm, Christoph Hellwig wrote:
> Hi all,
> 
> this series provides support for remapping places uncached in-place in
> the generic dma-direct code, and moves openrisc over from its own
> in-place remapping scheme.  The arm64 folks also had interest in such
> a scheme to avoid problems with speculating into cache aliases.
> 
> Also all architectures that always use small page mappings for the
> kernel and have non-coherent DMA should look into enabling this
> scheme, as it is much more efficient than the vmap remapping.
> 
> Changes since v1:
>   - share the arch hook for inline remap and uncached segment support
> 

For the whole series:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I think we might ultimately want to fiddle around a bit more in 
dma_direct_alloc_pages() to give ARCH_HAS_DMA_SET_UNCACHED clear 
precedence over DMA_DIRECT_REMAP if they have to coexist, but let's land 
these patches first as a solid foundation.

Thanks,
Robin.
