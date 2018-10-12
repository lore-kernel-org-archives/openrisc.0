From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 12 Oct 2018 09:50:12 -0700
Subject: [OpenRISC] [PATCH v2 2/2] mm: speed up mremap by 500x on large
	regions
In-Reply-To: <97cb3fe1-7bc1-12ff-d602-56c72a5496c5@kot-begemot.co.uk>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <9ed82f9e-88c4-8e4f-8c45-3ef153469603@kot-begemot.co.uk>
 <20181012143728.t42uvr6etg7gp7fh@kshutemo-mobl1>
 <4dd52e22-5b51-9b30-7178-fde603a08f88@kot-begemot.co.uk>
 <97cb3fe1-7bc1-12ff-d602-56c72a5496c5@kot-begemot.co.uk>
Message-ID: <20181012165012.GD223066@joelaf.mtv.corp.google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Fri, Oct 12, 2018 at 05:42:24PM +0100, Anton Ivanov wrote:
> 
> On 10/12/18 3:48 PM, Anton Ivanov wrote:
> > On 12/10/2018 15:37, Kirill A. Shutemov wrote:
> > > On Fri, Oct 12, 2018 at 03:09:49PM +0100, Anton Ivanov wrote:
> > > > On 10/12/18 2:37 AM, Joel Fernandes (Google) wrote:
> > > > > Android needs to mremap large regions of memory during
> > > > > memory management
> > > > > related operations. The mremap system call can be really
> > > > > slow if THP is
> > > > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > > > pte at a time, and can be really slow across a large map.
> > > > > Turning on THP
> > > > > may not be a viable option, and is not for us. This patch
> > > > > speeds up the
> > > > > performance for non-THP system by copying at the PMD level
> > > > > when possible.
> > > > > 
> > > > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > > > completion times drops from 160-250 millesconds to 380-400
> > > > > microseconds.
> > > > > 
> > > > > Before:
> > > > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > > > 
> > > > > After:
> > > > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > > > 
> > > > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > > > tlb every time we do this optimization since I couldn't find a way to
> > > > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > > > doing so is not much compared the improvement, on both
> > > > > x86-64 and arm64.
> > > > > 
> > > > > Cc: minchan at kernel.org
> > > > > Cc: pantin at google.com
> > > > > Cc: hughd at google.com
> > > > > Cc: lokeshgidra at google.com
> > > > > Cc: dancol at google.com
> > > > > Cc: mhocko at kernel.org
> > > > > Cc: kirill at shutemov.name
> > > > > Cc: akpm at linux-foundation.org
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > >    mm/mremap.c | 62
> > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 62 insertions(+)
> > > > > 
> > > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > > index 9e68a02a52b1..d82c485822ef 100644
> > > > > --- a/mm/mremap.c
> > > > > +++ b/mm/mremap.c
> > > > > @@ -191,6 +191,54 @@ static void move_ptes(struct
> > > > > vm_area_struct *vma, pmd_t *old_pmd,
> > > > >            drop_rmap_locks(vma);
> > > > >    }
> > > > > +static bool move_normal_pmd(struct vm_area_struct *vma,
> > > > > unsigned long old_addr,
> > > > > +          unsigned long new_addr, unsigned long old_end,
> > > > > +          pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > > > +{
> > > > > +    spinlock_t *old_ptl, *new_ptl;
> > > > > +    struct mm_struct *mm = vma->vm_mm;
> > > > > +
> > > > > +    if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > > > +        || old_end - old_addr < PMD_SIZE)
> > > > > +        return false;
> > > > > +
> > > > > +    /*
> > > > > +     * The destination pmd shouldn't be established, free_pgtables()
> > > > > +     * should have release it.
> > > > > +     */
> > > > > +    if (WARN_ON(!pmd_none(*new_pmd)))
> > > > > +        return false;
> > > > > +
> > > > > +    /*
> > > > > +     * We don't have to worry about the ordering of src and dst
> > > > > +     * ptlocks because exclusive mmap_sem prevents deadlock.
> > > > > +     */
> > > > > +    old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > > > +    if (old_ptl) {
> > > > > +        pmd_t pmd;
> > > > > +
> > > > > +        new_ptl = pmd_lockptr(mm, new_pmd);
> > > > > +        if (new_ptl != old_ptl)
> > > > > +            spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > > > > +
> > > > > +        /* Clear the pmd */
> > > > > +        pmd = *old_pmd;
> > > > > +        pmd_clear(old_pmd);
> > > > > +
> > > > > +        VM_BUG_ON(!pmd_none(*new_pmd));
> > > > > +
> > > > > +        /* Set the new pmd */
> > > > > +        set_pmd_at(mm, new_addr, new_pmd, pmd);
> > > > UML does not have set_pmd_at at all
> > > Every architecture does. :)
> > 
> > I tried to build it patching vs 4.19-rc before I made this statement and
> > ran into that.
> > 
> > Presently it does not.
> > 
> > https://elixir.bootlin.com/linux/v4.19-rc7/ident/set_pmd_at - UML is not
> > on the list.
> 
> Once this problem as well as the omissions in the include changes for UML in
> patch one have been fixed it appears to be working.
> 
> What it needs is attached.
> 
> 
> > 
> > > 
> > > But it may come not from the arch code.
> > 
> > There is no generic definition as far as I can see. All 12 defines in
> > 4.19 are in arch specific code. Unless i am missing something...
> > 
> > > 
> > > > If I read the code right, MIPS completely ignores the address
> > > > argument so
> > > > set_pmd_at there may not have the effect which this patch is trying to
> > > > achieve.
> > > Ignoring address is fine. Most architectures do that..
> > > The ideas is to move page table to the new pmd slot. It's nothing to do
> > > with the address passed to set_pmd_at().
> > 
> > If that is it's only function, then I am going to appropriate the code
> > out of the MIPS tree for further uml testing. It does exactly that -
> > just move the pmd the new slot.
> > 
> > > 
> > A.
> 
> 
> A.
> 

> From ac265d96897a346b05646fce91784ed4922c7f8d Mon Sep 17 00:00:00 2001
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Date: Fri, 12 Oct 2018 17:24:10 +0100
> Subject: [PATCH] Incremental fixes to the mmremap patch
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/include/asm/pgalloc.h | 4 ++--
>  arch/um/include/asm/pgtable.h | 3 +++
>  arch/um/kernel/tlb.c          | 6 ++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> index bf90b2aa2002..99eb5682792a 100644
> --- a/arch/um/include/asm/pgalloc.h
> +++ b/arch/um/include/asm/pgalloc.h
> @@ -25,8 +25,8 @@
>  extern pgd_t *pgd_alloc(struct mm_struct *);
>  extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>  
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
> -extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
> +extern pgtable_t pte_alloc_one(struct mm_struct *);

If its Ok, let me handle this bit since otherwise it complicates things for
me.

>  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 7485398d0737..1692da55e63a 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -359,4 +359,7 @@ do {						\
>  	__flush_tlb_one((vaddr));		\
>  } while (0)
>  
> +extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +		pmd_t *pmdp, pmd_t pmd);
> +
>  #endif
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 763d35bdda01..d17b74184ba0 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -647,3 +647,9 @@ void force_flush_all(void)
>  		vma = vma->vm_next;
>  	}
>  }
> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +		pmd_t *pmdp, pmd_t pmd)
> +{
> +	*pmdp = pmd;
> +}
> +

I believe this should be included in a separate patch since it is not related
specifically to pte_alloc argument removal. If you want, I could split it
into a separate patch for my series with you as author.

thanks,

- Joel

