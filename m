From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 08:13:32 +0200
Subject: [OpenRISC] [PATCH 1/7] arm-nommu: remove the partial
 DMA_ATTR_NON_CONSISTENT support
In-Reply-To: <a017e704-c6c4-7718-7f8b-eb8a0eced14d@arm.com>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-2-hch@lst.de>
 <a017e704-c6c4-7718-7f8b-eb8a0eced14d@arm.com>
Message-ID: <20190625061332.GC28986@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jun 24, 2019 at 03:23:08PM +0100, Vladimir Murzin wrote:
> On 6/14/19 3:44 PM, Christoph Hellwig wrote:
> > The arm-nommu DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
> > does not provide a cache_sync operation.  This means any user of it
> > will never be able to actually transfer cache ownership and thus cause
> > coherency bugs.
> 
> By the way, Documentation/DMA-attributes.txt doesn't specify cache_sync() as
> requirement for DMA_ATTR_NON_CONSISTENT it only states that it is responsibility
> of the driver to have all the correct and necessary sync points.

True.  dma_cache_sync has always been a rather odd interface, as it
doesn't specify in what direction we need to sync and doesn't
participate in our ownership protocol.  So my mid-term plan is to kill
it off and replace it with the existing dma_sync_* helpers.  This
series is the first step towards that.
