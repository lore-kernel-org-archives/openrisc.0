From: Christoph Hellwig <hch@lst.de>
Date: Mon, 24 Feb 2020 22:56:57 +0100
Subject: [OpenRISC] [PATCH 4/5] dma-direct: provide a
 arch_dma_clear_uncached hook
In-Reply-To: <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
References: <20200224194446.690816-1-hch@lst.de>
 <20200224194446.690816-5-hch@lst.de>
 <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
Message-ID: <20200224215657.GA12618@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 24, 2020 at 01:53:28PM -0800, Ira Weiny wrote:
> > +	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
> > +		arch_dma_clear_uncached(cpu_addr, size);
> 
> Isn't using arch_dma_clear_uncached() before patch 5 going to break
> bisectability?

Only if ARCH_HAS_DMA_CLEAR_UNCACHED is selected by anything, which
only happens in patch 5.
