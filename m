From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Wed, 5 Aug 2020 12:58:44 +0200
Subject: [OpenRISC] [PATCH v2 17/17] memblock: use separate iterators
 for memory and reserved regions
In-Reply-To: <20200802163601.8189-18-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-18-rppt@kernel.org>
Message-ID: <20200805105844.GA11658@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Aug 02, 2020 at 07:36:01PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> for_each_memblock() is used to iterate over memblock.memory in
> a few places that use data from memblock_region rather than the memory
> ranges.
> 
> Introduce separate for_each_mem_region() and for_each_reserved_mem_region()
> to improve encapsulation of memblock internals from its users.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/mips/netlogic/xlp/setup.c |  2 +-

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
