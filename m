From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Nov 2021 18:08:10 -0600
Subject: [OpenRISC] [PATCH 0/2] of: remove reserved regions count
 restriction
In-Reply-To: <YZnqo3oA7srQik4N@kernel.org>
References: <20211119075844.2902592-1-calvinzhang.cool@gmail.com>
 <YZnqo3oA7srQik4N@kernel.org>
Message-ID: <YaVrahm+ysoQRGKe@robh.at.kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Nov 21, 2021 at 08:43:47AM +0200, Mike Rapoport wrote:
> On Fri, Nov 19, 2021 at 03:58:17PM +0800, Calvin Zhang wrote:
> > The count of reserved regions in /reserved-memory was limited because
> > the struct reserved_mem array was defined statically. This series sorts
> > out reserved memory code and allocates that array from early allocator.
> > 
> > Note: reserved region with fixed location must be reserved before any
> > memory allocation. While struct reserved_mem array should be allocated
> > after allocator is activated. We make early_init_fdt_scan_reserved_mem()
> > do reservation only and add another call to initialize reserved memory.
> > So arch code have to change for it.
> 
> I think much simpler would be to use the same constant for sizing
> memblock.reserved and reserved_mem arrays.

Do those arrays get shrunk? Or do we waste the memory forever?

Maybe we can copy and shrink the initial array? Though I suspect struct 
reserved_mem pointers have already been given out.

> 
> If there is too much reserved regions in the device tree, reserving them in
> memblock will fail anyway because memblock also starts with static array
> for memblock.reserved, so doing one pass with memblock_reserve() and
> another to set up reserved_mem wouldn't help anyway.
> 
> > I'm only familiar with arm and arm64 architectures. Approvals from arch
> > maintainers are required. Thank you all.
> > 
> > Calvin Zhang (2):
> >   of: Sort reserved_mem related code
> >   of: reserved_mem: Remove reserved regions count restriction
> > 
> >  arch/arc/mm/init.c                 |   3 +
> >  arch/arm/kernel/setup.c            |   2 +
> >  arch/arm64/kernel/setup.c          |   3 +
> >  arch/csky/kernel/setup.c           |   3 +
> >  arch/h8300/kernel/setup.c          |   2 +
> >  arch/mips/kernel/setup.c           |   3 +
> >  arch/nds32/kernel/setup.c          |   3 +
> >  arch/nios2/kernel/setup.c          |   2 +
> >  arch/openrisc/kernel/setup.c       |   3 +
> >  arch/powerpc/kernel/setup-common.c |   3 +
> >  arch/riscv/kernel/setup.c          |   2 +
> >  arch/sh/kernel/setup.c             |   3 +
> >  arch/xtensa/kernel/setup.c         |   2 +
> >  drivers/of/fdt.c                   | 107 +---------------
> >  drivers/of/of_private.h            |  12 +-
> >  drivers/of/of_reserved_mem.c       | 189 ++++++++++++++++++++++++-----
> >  include/linux/of_reserved_mem.h    |   4 +
> >  17 files changed, 207 insertions(+), 139 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
