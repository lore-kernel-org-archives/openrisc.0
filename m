From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 26 Nov 2018 09:25:46 +0200
Subject: [OpenRISC] [PATCH 5/5] arch: simplify several early memory
	allocations
In-Reply-To: <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
 <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
Message-ID: <20181126072546.GB14863@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Mon, Nov 26, 2018 at 08:03:55AM +0100, Christophe LEROY wrote:
> 
> 
> Le 25/11/2018 à 22:44, Mike Rapoport a écrit :
> >There are several early memory allocations in arch/ code that use
> >memblock_phys_alloc() to allocate memory, convert the returned physical
> >address to the virtual address and then set the allocated memory to zero.
> >
> >Exactly the same behaviour can be achieved simply by calling
> >memblock_alloc(): it allocates the memory in the same way as
> >memblock_phys_alloc(), then it performs the phys_to_virt() conversion and
> >clears the allocated memory.
> >
> >Replace the longer sequence with a simpler call to memblock_alloc().
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/arm/mm/mmu.c                     |  4 +---
> >  arch/c6x/mm/dma-coherent.c            |  9 ++-------
> >  arch/nds32/mm/init.c                  | 12 ++++--------
> >  arch/powerpc/kernel/setup-common.c    |  4 ++--
> >  arch/powerpc/mm/pgtable_32.c          |  4 +---
> >  arch/powerpc/mm/ppc_mmu_32.c          |  3 +--
> >  arch/powerpc/platforms/powernv/opal.c |  3 +--
> >  arch/sparc/kernel/prom_64.c           |  7 ++-----
> >  arch/sparc/mm/init_64.c               |  9 +++------
> >  arch/unicore32/mm/mmu.c               |  4 +---
> >  10 files changed, 18 insertions(+), 41 deletions(-)
> >
> [...]
> 
> >diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> >index bda3c6f..9931e68 100644
> >--- a/arch/powerpc/mm/pgtable_32.c
> >+++ b/arch/powerpc/mm/pgtable_32.c
> >@@ -50,9 +50,7 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> >  	if (slab_is_available()) {
> >  		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> >  	} else {
> >-		pte = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> >-		if (pte)
> >-			clear_page(pte);
> >+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> 
> memblock_alloc() uses memset to zeroize the block.
> 
> clear_page() is more performant than memset().

As far as I can tell, the majority of the page table pages will be anyway
allocated with __get_free_page() so I think the performance loss here will
negligible.
 
> Christophe
> 
> [...]
> 

-- 
Sincerely yours,
Mike.

