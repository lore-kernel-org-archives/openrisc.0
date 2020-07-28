From: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Jul 2020 06:37:53 -0000
Subject: [OpenRISC] [PATCH 02/15] dma-contiguous: simplify
 cma_early_percent_memory()
In-Reply-To: <20200728051153.1590-3-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-3-rppt@kernel.org>
Message-ID: <20200728063749.GA21221@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jul 28, 2020 at 08:11:40AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The memory size calculation in cma_early_percent_memory() traverses
> memblock.memory rather than simply call memblock_phys_mem_size(). The
> comment in that function suggests that at some point there should have been
> call to memblock_analyze() before memblock_phys_mem_size() could be used.
> As of now, there is no memblock_analyze() at all and
> memblock_phys_mem_size() can be used as soon as cold-plug memory is
> registerd with memblock.
> 
> Replace loop over memblock.memory with a call to memblock_phys_mem_size().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
