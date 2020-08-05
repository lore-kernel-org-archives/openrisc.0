From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Wed, 5 Aug 2020 13:00:35 +0200
Subject: [OpenRISC] [PATCH v2 12/17] arch,
 drivers: replace for_each_membock() with for_each_mem_range()
In-Reply-To: <20200802163601.8189-13-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-13-rppt@kernel.org>
Message-ID: <20200805110035.GB11658@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Aug 02, 2020 at 07:35:56PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are several occurrences of the following pattern:
> 
> 	for_each_memblock(memory, reg) {
> 		start = __pfn_to_phys(memblock_region_memory_base_pfn(reg);
> 		end = __pfn_to_phys(memblock_region_memory_end_pfn(reg));
> 
> 		/* do something with start and end */
> 	}
> 
> Using for_each_mem_range() iterator is more appropriate in such cases and
> allows simpler and cleaner code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/mips/cavium-octeon/dma-octeon.c     | 12 +++---
>  arch/mips/kernel/setup.c                 | 31 +++++++--------

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
