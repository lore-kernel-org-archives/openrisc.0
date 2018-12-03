From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 3 Dec 2018 18:55:04 +0200
Subject: [OpenRISC] [PATCH v2 6/6] arm,
	unicore32: remove early_alloc*() wrappers
In-Reply-To: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
 <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Message-ID: <20181203165504.GC26700@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 03, 2018 at 10:27:02AM -0600, Rob Herring wrote:
> On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> > oneliner wrappers for memblock_alloc.
> >
> > Replace their usage with direct call to memblock_alloc.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm/mm/mmu.c       | 11 +++--------
> >  arch/unicore32/mm/mmu.c | 12 ++++--------
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 0a04c9a5..57de0dd 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
> >
> >  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
> >
> > -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> > -{
> > -       return memblock_alloc(sz, align);
> > -}
> > -
> >  static void __init *early_alloc(unsigned long sz)
> 
> Why not get rid of this wrapper like you do on unicore?

ARM has early_alloc() and late_alloc() callbacks which in the end are
passed as a parameter to alloc_init_pXd() functions. 

Removing early_alloc() would require refactoring all the page table
allocation code.
 
> >  {
> > -       return early_alloc_aligned(sz, sz);
> > +       return memblock_alloc(sz, sz);
> >  }
> 

-- 
Sincerely yours,
Mike.

