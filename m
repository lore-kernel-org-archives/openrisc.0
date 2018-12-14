From: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Date: Fri, 14 Dec 2018 12:12:00 +0000
Subject: [OpenRISC] [PATCH 1/2] dma-mapping: zero memory returned from
	dma_alloc_*
In-Reply-To: <20181214082515.14835-2-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de>
Message-ID: <1544789518.3270.34.camel@synopsys.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

do you have any public git repository with all your dma changes?

I want to test them for ARC.

Thanks.

On Fri, 2018-12-14 at 09:25 +0100, Christoph Hellwig wrote:
> If we want to map memory from the DMA allocator to userspace it must be
> zeroed at allocation time to prevent stale data leaks.   We already do
> this on most common architectures, but some architectures don't do this
> yet, fix them up, either by passing GFP_ZERO when we use the normal page
> allocator or doing a manual memset otherwise.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
-- 
 Eugeniy Paltsev
