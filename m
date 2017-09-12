From: Stafford Horne <shorne@gmail.com>
Date: Tue, 12 Sep 2017 19:37:16 +0900
Subject: [OpenRISC] [PATCH] openrisc: add forward declaration for struct
 vm_area_struct
In-Reply-To: <20170912074204.GF5028@distanz.ch>
References: <201709080345.bk1IOlp7%fengguang.wu@intel.com>
 <20170908082508.14325-1-tklauser@distanz.ch>
 <20170908152911.GQ2609@lianli.shorne-pla.net>
 <20170912074204.GF5028@distanz.ch>
Message-ID: <20170912103716.GR2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Sep 12, 2017 at 09:42:05AM +0200, Tobias Klauser wrote:
> On 2017-09-08 at 17:29:11 +0200, Stafford Horne <shorne@gmail.com> wrote:
> > On Fri, Sep 08, 2017 at 10:25:08AM +0200, Tobias Klauser wrote:
> > > After removing linux/vmalloc.h from asm-generic/io.h, the following
> > > warning occurs on openrisc:
> > > 
> > >    In file included from arch/openrisc/include/asm/io.h:33:0,
> > >                     from include/linux/io.h:25,
> > >                     from drivers/tty/serial/earlycon.c:19:
> > >    arch/openrisc/include/asm/pgtable.h:424:2: warning: 'struct vm_area_struct' declared inside parameter list
> > >      unsigned long address, pte_t *pte)
> > >      ^
> > [..]
> > > @@ -414,6 +414,8 @@ static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
> > >  
> > >  extern pgd_t swapper_pg_dir[PTRS_PER_PGD]; /* defined in head.S */
> > >  
> > > +struct vm_area_struct;
> > > +
> > 
> > Acked-by: Stafford Horne <shorne@gmail.com>
> > 
> > I was kind of wondering whether is better to include linux/mm_types.h or
> > linux/vmalloc.h here instead of the forward declaration.  But looking at
> > how other architectures do it; about half do the forward declaration, and
> > half use an include.  So I guess this is fine.
> > 
> > I noticed you were getting a lot of these patches done for removing
> > linux/vmalloc.h from asm-generic/io.h.   Do you want me to push this
> > through my queue or are you planning sending them through another route?
> 
> Arnd has applied the patch removing linux/vmalloc.h from
> asm-generic/io.h to his testing tree to give it a good amount of testing
> before it comes anywhere near linux-next.  I'd say it's fine if you push
> this through your queue as long as it hits Linus' tree before my
> patch (which Arnd will submit, I suppose?).
> 
> Arnd, what would you prefer?

No worries,

I already have this queued up.  I dont have anything else on my queue
thought.  I will push this tomorrow.

-Stafford
