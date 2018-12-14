From: hch@lst.de <hch@lst.de>
Date: Fri, 14 Dec 2018 13:21:49 +0100
Subject: [OpenRISC] [PATCH 1/2] dma-mapping: zero memory returned from
	dma_alloc_*
In-Reply-To: <1544789518.3270.34.camel@synopsys.com>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de> <1544789518.3270.34.camel@synopsys.com>
Message-ID: <20181214122149.GA7309@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Dec 14, 2018 at 12:12:00PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> do you have any public git repository with all your dma changes?

Most of the tree show up in my misc.git repo for testing.

This series is here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-alloc-always-zero

There current version of the DMA_ATTR_NON_CONSISTENT series is here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator.2


> I want to test them for ARC.

Thanks a lot!
