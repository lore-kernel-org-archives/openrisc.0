From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 29 Jun 2019 08:09:15 -0700
Subject: [OpenRISC] [PATCH 6/7] dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code
In-Reply-To: <20190614144431.21760-7-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-7-hch@lst.de>
Message-ID: <20190629150915.GA817@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jun 14, 2019 at 04:44:30PM +0200, Christoph Hellwig wrote:
> DMA_ATTR_NO_KERNEL_MAPPING is generally implemented by allocating
> normal cacheable pages or CMA memory, and then returning the page
> pointer as the opaque handle.  Lift that code from the xtensa and
> generic dma remapping implementations into the generic dma-direct
> code so that we don't even call arch_dma_alloc for these allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch results in build failures for mips:nlm_xlp_defconfig and
mips:cavium_octeon_defconfig.

kernel/dma/direct.c:144: undefined reference to `arch_dma_prep_coherent'

Reverting the patch fixes the problem.

Guenter
