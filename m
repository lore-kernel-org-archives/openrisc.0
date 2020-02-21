From: Stafford Horne <shorne@gmail.com>
Date: Sat, 22 Feb 2020 07:14:47 +0900
Subject: [OpenRISC] [PATCH 2/2] openrisc: use the generic in-place
 uncached DMA allocator
In-Reply-To: <20200220170139.387354-3-hch@lst.de>
References: <20200220170139.387354-1-hch@lst.de>
 <20200220170139.387354-3-hch@lst.de>
Message-ID: <20200221221447.GA7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 20, 2020 at 09:01:39AM -0800, Christoph Hellwig wrote:
> Switch openrisc to use the dma-direct allocator and just provide the
> hooks for setting memory uncached or cached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stafford Horne <shorne@gmail.com>

Also, I test booted openrisc with linux 5.5 + these patches.  Thanks for
continuing to shrink my code base.
 
