From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 30 Nov 2021 23:07:40 +0200
Subject: [OpenRISC] [PATCH 0/2] of: remove reserved regions count
 restriction
In-Reply-To: <YaVrahm+ysoQRGKe@robh.at.kernel.org>
References: <20211119075844.2902592-1-calvinzhang.cool@gmail.com>
 <YZnqo3oA7srQik4N@kernel.org> <YaVrahm+ysoQRGKe@robh.at.kernel.org>
Message-ID: <YaaSnJ2Meo5mEKDN@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Nov 29, 2021 at 06:08:10PM -0600, Rob Herring wrote:
> On Sun, Nov 21, 2021 at 08:43:47AM +0200, Mike Rapoport wrote:
> > On Fri, Nov 19, 2021 at 03:58:17PM +0800, Calvin Zhang wrote:
> > > The count of reserved regions in /reserved-memory was limited because
> > > the struct reserved_mem array was defined statically. This series sorts
> > > out reserved memory code and allocates that array from early allocator.
> > > 
> > > Note: reserved region with fixed location must be reserved before any
> > > memory allocation. While struct reserved_mem array should be allocated
> > > after allocator is activated. We make early_init_fdt_scan_reserved_mem()
> > > do reservation only and add another call to initialize reserved memory.
> > > So arch code have to change for it.
> > 
> > I think much simpler would be to use the same constant for sizing
> > memblock.reserved and reserved_mem arrays.
> 
> Do those arrays get shrunk? Or do we waste the memory forever?

Memblock arrays don't get shrunk, but they are __init unless an architecture
chose to keep them after boot, but most architectures that use device tree
actually keep memblock structures.
 
> Maybe we can copy and shrink the initial array? Though I suspect struct 
> reserved_mem pointers have already been given out.

I'm not sure. It seems that reserved_mem pointers are given out at initcall
time and AFAIU the reserved_mem array is created somewhere around
setup_arch(). So maybe it's possible to copy and shrink the initial array.
 
> > 
> > If there is too much reserved regions in the device tree, reserving them in
> > memblock will fail anyway because memblock also starts with static array
> > for memblock.reserved, so doing one pass with memblock_reserve() and
> > another to set up reserved_mem wouldn't help anyway.
> > 
> > > I'm only familiar with arm and arm64 architectures. Approvals from arch
> > > maintainers are required. Thank you all.

-- 
Sincerely yours,
Mike.
