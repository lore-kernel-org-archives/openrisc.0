From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Wed, 14 Apr 2021 17:27:57 +0800
Subject: [OpenRISC] [PATCH] init: consolidate trap_init()
In-Reply-To: <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
References: <20210414165808.458a3d11@xhacker.debian>
 <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
Message-ID: <20210414172757.3ebfaa4c@xhacker.debian>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Wed, 14 Apr 2021 11:10:42 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> 
> Le 14/04/2021 à 10:58, Jisheng Zhang a écrit :
> > Many architectures implement the trap_init() as NOP, since there is
> > no such default for trap_init(), this empty stub is duplicated among
> > these architectures. Provide a generic but weak NOP implementation
> > to drop the empty stubs of trap_init() in these architectures.  
> 
> You define the weak function in the __init section.
> 
> Most but not all architectures had it in __init section.
> 
> And the remaining ones may not be defined in __init section. For instance look at the one in alpha
> architecture.
> 
> Have you checked that it is not a problem ? It would be good to say something about it in the commit
> description.

For those non-nop platforms, I can only test x86/arm64/, but both has
__init mark. I'm not sure whether this is a problem for alpha etc. Maybe
I can check which section the trap_init() sits. Or to avoid any possible
regression, I can add __init mark to those remaining ones without it in
preparation patches.

> 
> 
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >   arch/arc/kernel/traps.c      |  5 -----
> >   arch/arm/kernel/traps.c      |  5 -----
> >   arch/h8300/kernel/traps.c    | 13 -------------
> >   arch/hexagon/kernel/traps.c  |  4 ----
> >   arch/nds32/kernel/traps.c    |  5 -----
> >   arch/nios2/kernel/traps.c    |  5 -----
> >   arch/openrisc/kernel/traps.c |  5 -----
> >   arch/parisc/kernel/traps.c   |  4 ----
> >   arch/powerpc/kernel/traps.c  |  5 -----
> >   arch/riscv/kernel/traps.c    |  5 -----
> >   arch/um/kernel/trap.c        |  4 ----
> >   init/main.c                  |  2 ++
> >   12 files changed, 2 insertions(+), 60 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 53b278845b88..4bdbe2928530 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -790,6 +790,8 @@ static inline void initcall_debug_enable(void)
> >   }
> >   #endif
> >
> > +void __init __weak trap_init(void) { }
> > +  
> 
> I think in a C file we don't try to save space as much as in a header file.
> 

This is to follow most weak NOP implementations in init/main.c to make
the style unified in the same file. I'm not sure which is better.

> I would prefer something like:
> 
> 
> void __init __weak trap_init(void)
> {
> }
> 
> 
> >   /* Report memory auto-initialization states for this boot. */
> >   static void __init report_meminit(void)
> >   {
> >  

