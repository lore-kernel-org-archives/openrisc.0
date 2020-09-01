From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 1 Sep 2020 15:11:30 +0300
Subject: [OpenRISC] [PATCH] openrisc: Reserve memblock for initrd
In-Reply-To: <20200901102044.GB3562056@lianli.shorne-pla.net>
References: <20200831212102.4014642-1-shorne@gmail.com>
 <20200901055924.GC432455@kernel.org>
 <20200901102044.GB3562056@lianli.shorne-pla.net>
Message-ID: <20200901121130.GA698558@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Sep 01, 2020 at 07:20:44PM +0900, Stafford Horne wrote:
> On Tue, Sep 01, 2020 at 08:59:24AM +0300, Mike Rapoport wrote:
> > On Tue, Sep 01, 2020 at 06:21:01AM +0900, Stafford Horne wrote:
> > > Recently OpenRISC added support for external initrd images, but I found
> > > some instability when using larger buildroot initrd images. It turned
> > > out that I forgot to reserve the memblock space for the initrd image.
> > > 
> > > This patch fixes the instability issue by reserving memblock space.
> > > 
> > > Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > ---
> > >  arch/openrisc/kernel/setup.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > > index b18e775f8be3..2c8aa53cc7ba 100644
> > > --- a/arch/openrisc/kernel/setup.c
> > > +++ b/arch/openrisc/kernel/setup.c
> > > @@ -80,6 +80,15 @@ static void __init setup_memory(void)
> > >  	 */
> > >  	memblock_reserve(__pa(_stext), _end - _stext);
> > >  
> > > +#ifdef CONFIG_BLK_DEV_INITRD
> > > +	/* Then reserve the initrd, if any */
> > > +	if (initrd_start && (initrd_end > initrd_start)) {
> > > + 	memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> > > +		ALIGN(initrd_end, PAGE_SIZE) -
> > > +		ALIGN_DOWN(initrd_start, PAGE_SIZE));
> > > +	}
> > 
> > The core mm takes care of reserving the entrire pages for the memory
> > reserved with memblock, so it is not necessary to do it here.
> 
> Thanks for the pointer
> 
> I guess what you mean is it is not required to do the page alignment.

Right. 

> I used other architectures as an example and most do the alignment, I
> think for most architectures this can be pulled out to generic code.

You are more than welcome :)
We already have a generic free_initrd_mem(), maybe it's time to have a
generic reserve_initrd_mem().

I'm ok with openrisc doing the alignment, but I think using local
variables would make the core more readable, e.g

	if (initd_start && (initrd_end)) {
		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
		unsigned long aligned_end = ALIGN(end, PAGE_SIZE);

		memblock_reserve(aligned_start, aligned_end);
	}

What do you say?

> -Stafford
> 
> > > +#endif /* CONFIG_BLK_DEV_INITRD */
> > > +
> > >  	early_init_fdt_reserve_self();
> > >  	early_init_fdt_scan_reserved_mem();
> > >  
> > > -- 
> > > 2.26.2
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
