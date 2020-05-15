From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 15 May 2020 14:12:11 -0700
Subject: [OpenRISC] [PATCH v2 00/12] mm: consolidate definitions of page
 table accessors
In-Reply-To: <20200514170327.31389-1-rppt@kernel.org>
References: <20200514170327.31389-1-rppt@kernel.org>
Message-ID: <20200515141211.653db07a4e7142107a57cf24@linux-foundation.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 14 May 2020 20:03:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> The low level page table accessors (pXY_index(), pXY_offset()) are
> duplicated across all architectures and sometimes more than once. For
> instance, we have 31 definition of pgd_offset() for 25 supported
> architectures.
> 
> Most of these definitions are actually identical and typically it boils
> down to, e.g. 
> 
> static inline unsigned long pmd_index(unsigned long address)
> {
>         return (address >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
> }
> 
> static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
> {
>         return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
> }
> 
> These definitions can be shared among 90% of the arches provided XYZ_SHIFT,
> PTRS_PER_XYZ and xyz_page_vaddr() are defined.
> 
> For architectures that really need a custom version there is always
> possibility to override the generic version with the usual ifdefs magic.
> 
> These patches introduce include/linux/pgtable.h that replaces
> include/asm-generic/pgtable.h and add the definitions of the page table
> accessors to the new header.

hm,

>  712 files changed, 684 insertions(+), 2021 deletions(-)

big!

There's a lot of stuff going on at present (I suspect everyone is
sitting at home coding up a storm).  However this all merged up fairly
cleanly, haven't tried compiling it yet.
