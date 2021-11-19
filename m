From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 19 Nov 2021 11:56:08 +0200
Subject: [OpenRISC] [PATCH 2/2] of: reserved_mem: Remove reserved
 regions count restriction
In-Reply-To: <20211119075844.2902592-3-calvinzhang.cool@gmail.com>
References: <20211119075844.2902592-1-calvinzhang.cool@gmail.com>
 <20211119075844.2902592-3-calvinzhang.cool@gmail.com>
Message-ID: <YZd0uEWNH6Def3+8@smile.fi.intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Nov 19, 2021 at 03:58:19PM +0800, Calvin Zhang wrote:
> Change to allocate reserved_mems dynamically. Static reserved regions
> must be reserved before any memblock allocations. The reserved_mems
> array couldn't be allocated until memblock and linear mapping are ready.
> 
> So move the allocation and initialization of records and reserved memory
> from early_init_fdt_scan_reserved_mem() to of_reserved_mem_init().

>  arch/arc/mm/init.c                 |  3 ++
>  arch/arm/kernel/setup.c            |  2 +
>  arch/arm64/kernel/setup.c          |  3 ++
>  arch/csky/kernel/setup.c           |  3 ++
>  arch/h8300/kernel/setup.c          |  2 +
>  arch/mips/kernel/setup.c           |  3 ++
>  arch/nds32/kernel/setup.c          |  3 ++
>  arch/nios2/kernel/setup.c          |  2 +
>  arch/openrisc/kernel/setup.c       |  3 ++
>  arch/powerpc/kernel/setup-common.c |  3 ++
>  arch/riscv/kernel/setup.c          |  2 +
>  arch/sh/kernel/setup.c             |  3 ++
>  arch/xtensa/kernel/setup.c         |  2 +

Isn't x86 missed? Is it on purpose?
Would be nice to have this in the commit message or fixed accordingly.

-- 
With Best Regards,
Andy Shevchenko


