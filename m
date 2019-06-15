From: hch@lst.de <hch@lst.de>
Date: Sat, 15 Jun 2019 10:35:54 +0200
Subject: [OpenRISC] [PATCH 7/7] arc: use the generic remapping allocator
 for coherent DMA allocations
In-Reply-To: <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-8-hch@lst.de>
 <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
Message-ID: <20190615083554.GC23406@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jun 14, 2019 at 06:05:01PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> Regular question - do you have any public git repository with all this dma changes?
> I want to test it for ARC.
> 
> Pretty sure the
>  [PATCH 2/7] arc: remove the partial DMA_ATTR_NON_CONSISTENT support
> is fine.
> 
> Not so sure about
>  [PATCH 7/7] arc: use the generic remapping allocator for coherent DMA allocations
> :)

   git://git.infradead.org/users/hch/misc.git dma-not-consistent-cleanup

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-not-consistent-cleanup
