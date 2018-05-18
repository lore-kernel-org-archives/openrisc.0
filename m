From: Helge Deller <deller@gmx.de>
Date: Fri, 18 May 2018 22:05:51 +0200
Subject: [OpenRISC] [PATCH 02/20] dma-mapping: provide a generic
 dma-noncoherent implementation
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
Message-ID: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 18.05.2018 15:03, Alexey Brodkin wrote:
> But the real fix of my problem is:
> ---------------------------------------->8------------------------------------
> --- a/lib/dma-noncoherent.c
> +++ b/lib/dma-noncoherent.c
> @@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
>  
>         addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>         if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
>         return addr;
>  }
> ---------------------------------------->8------------------------------------
> 
> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Good.
This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.

So it leaves only one open issue on parisc:
Now every 32 bit parisc system is unnecessarily non-coherent.

Helge
