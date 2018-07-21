From: Stafford Horne <shorne@gmail.com>
Date: Sat, 21 Jul 2018 14:31:42 +0900
Subject: [OpenRISC] use the generic dma-noncoherent code for openrisc
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
Message-ID: <20180721053142.GC9742@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jul 19, 2018 at 06:02:28AM -0700, Christoph Hellwig wrote:
> Hi Openrisc maintainers,
> 
> can you review these patches to switch openrisc to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.

Hi Christoph,

Thanks for this, these look good to me.  I don't know much about the dma
infrastructure in the kernel to tell the truth, but the patches do maintain the
original cache flushing and invalidation core logic and I don't see any
problems.

I have applied these and ran my regular tests, but I don't really have any DMA
hardware so the testing doesn't mean much.

For upstreaming, do you want me to send these through the openrisc tree, or do
you want to send with the dma tree?

-Stafford
