From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 14:28:08 +0200
Subject: [OpenRISC] [PATCH 5/7] dma-direct: handle
 DMA_ATTR_NON_CONSISTENT in common code
In-Reply-To: <3eb32e0b-5aa4-fe1e-e581-038750e11cef@gmx.de>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-6-hch@lst.de>
 <3eb32e0b-5aa4-fe1e-e581-038750e11cef@gmx.de>
Message-ID: <20190625122808.GB4421@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 25, 2019 at 02:23:45PM +0200, Helge Deller wrote:
> On 14.06.19 16:44, Christoph Hellwig wrote:
> > Only call into arch_dma_alloc if we require an uncached mapping,
> > and remove the parisc code manually doing normal cached
> > DMA_ATTR_NON_CONSISTENT allocations.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> 
> Boot-tested 32-bit kernel on PCX-L and PCX-W2 machines (although
> the patches don't cleanly apply any longer against git head).

The series was against the dma-mapping tree, which might have diverged
a bit already.

Thanks for testing!
