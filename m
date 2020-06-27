From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 27 Jun 2020 20:03:04 +0100
Subject: [OpenRISC] [PATCH 4/8] asm-generic: pgalloc: provide generic
 pmd_alloc_one() and pmd_free_one()
In-Reply-To: <20200627143453.31835-5-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-5-rppt@kernel.org>
Message-ID: <20200627190304.GG25039@casper.infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jun 27, 2020 at 05:34:49PM +0300, Mike Rapoport wrote:
> More elaborate versions on arm64 and x86 account memory for the user page
> tables and call to pgtable_pmd_page_ctor() as the part of PMD page
> initialization.
> 
> Move the arm64 version to include/asm-generic/pgalloc.h and use the generic
> version on several architectures.
> 
> The pgtable_pmd_page_ctor() is a NOP when ARCH_ENABLE_SPLIT_PMD_PTLOCK is
> not enabled, so there is no functional change for most architectures except
> of the addition of __GFP_ACCOUNT for allocation of user page tables.

Thanks for including this line; it reminded me that we're not setting
the PageTable flag on the page, nor accounting it to the zone page stats.
Hope you don't mind me tagging a patch to do that on as 9/8.

We could also do with a pud_page_[cd]tor and maybe even p4d/pgd versions.
But that brings me to the next question -- could/should some of this
be moved over to asm-generic/pgalloc.h?  The ctor/dtor aren't called
from anywhere else, and there's value to reducing the total amount of
code in mm.h, but then there's also value to keeping all the ifdef
ARCH_ENABLE_SPLIT_PMD_PTLOCK code together too.  So I'm a bit torn.
What do you think?
