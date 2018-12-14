From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Dec 2018 19:35:09 +0100
Subject: [OpenRISC] [PATCH 1/2] dma-mapping: zero memory returned from
	dma_alloc_*
In-Reply-To: <20181214181056.GA17941@ravnborg.org>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de> <20181214181056.GA17941@ravnborg.org>
Message-ID: <20181214183509.GA5247@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Dec 14, 2018 at 07:10:56PM +0100, Sam Ravnborg wrote:
> Hi Christoph,
> 
> I stumbled upon this one:
> 
> #define __get_dma_pages(gfp_mask, order) \
>                 __get_free_pages((gfp_mask) | GFP_DMA, (order))

This isn't directly related to the dma mapping, but another place
that hides GFP_DMA allocations.  So no need for the treatment,
but we really should kill this obsfucating wrapper..
