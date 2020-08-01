From: Mike Rapoport <rppt@kernel.org>
Date: Sat, 01 Aug 2020 10:19:13 -0000
Subject: [OpenRISC] [PATCH 06/15] powerpc: fadamp: simplify
 fadump_reserve_crash_area()
In-Reply-To: <87d04d5hda.fsf@mpe.ellerman.id.au>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-7-rppt@kernel.org>
 <87d04d5hda.fsf@mpe.ellerman.id.au>
Message-ID: <20200801101854.GD534153@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jul 30, 2020 at 10:15:13PM +1000, Michael Ellerman wrote:
> Mike Rapoport <rppt@kernel.org> writes:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > fadump_reserve_crash_area() reserves memory from a specified base address
> > till the end of the RAM.
> >
> > Replace iteration through the memblock.memory with a single call to
> > memblock_reserve() with appropriate  that will take care of proper memory
>                                      ^
>                                      parameters?
> > reservation.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/fadump.c | 20 +-------------------
> >  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> I think this looks OK to me, but I don't have a setup to test it easily.
> I've added Hari to Cc who might be able to.
> 
> But I'll give you an ack in the hope that it works :)

Actually, I did some digging in the git log and the traversal was added
there on purpose by the commit b71a693d3db3 ("powerpc/fadump: exclude
memory holes while reserving memory in second kernel")
Presuming this is still reqruired I'm going to drop this patch and will
simply replace for_each_memblock() with for_each_mem_range() in v2.
 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> > index 78ab9a6ee6ac..2446a61e3c25 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -1658,25 +1658,7 @@ int __init fadump_reserve_mem(void)
> >  /* Preserve everything above the base address */
> >  static void __init fadump_reserve_crash_area(u64 base)
> >  {
> > -	struct memblock_region *reg;
> > -	u64 mstart, msize;
> > -
> > -	for_each_memblock(memory, reg) {
> > -		mstart = reg->base;
> > -		msize  = reg->size;
> > -
> > -		if ((mstart + msize) < base)
> > -			continue;
> > -
> > -		if (mstart < base) {
> > -			msize -= (base - mstart);
> > -			mstart = base;
> > -		}
> > -
> > -		pr_info("Reserving %lluMB of memory at %#016llx for preserving crash data",
> > -			(msize >> 20), mstart);
> > -		memblock_reserve(mstart, msize);
> > -	}
> > +	memblock_reserve(base, memblock_end_of_DRAM() - base);
> >  }
> >  
> >  unsigned long __init arch_reserved_kernel_pages(void)
> > -- 
> > 2.26.2

-- 
Sincerely yours,
Mike.
