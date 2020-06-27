From: Mike Rapoport <rppt@kernel.org>
Date: Sat, 27 Jun 2020 17:34:48 +0300
Subject: [OpenRISC] [PATCH 3/8] xtensa: switch to generic version of pte
 allocation
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
Message-ID: <20200627143453.31835-4-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

xtensa clears PTEs during allocation of the page tables and pte_clear()
sets the PTE to a non-zero value. Splitting ptes_clear() helper out of
pte_alloc_one() and pte_alloc_one_kernel() allows reuse of base generic
allocation methods (__pte_alloc_one() and __pte_alloc_one_kernel()) and the
common GFP mask for page table allocations.

The pte_free() and pte_free_kernel() implementations on xtensa are
identical to the generic ones and can be dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/include/asm/pgalloc.h | 41 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 1d38f0e755ba..60ee94b42850 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -8,9 +8,14 @@
 #ifndef _XTENSA_PGALLOC_H
 #define _XTENSA_PGALLOC_H
 
+#ifdef CONFIG_MMU
 #include <linux/highmem.h>
 #include <linux/slab.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>
+
 /*
  * Allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
@@ -33,45 +38,37 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_page((unsigned long)pgd);
 }
 
+static inline void ptes_clear(pte_t *ptep)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		pte_clear(NULL, 0, ptep + i);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	pte_t *ptep;
-	int i;
 
-	ptep = (pte_t *)__get_free_page(GFP_KERNEL);
+	ptep = (pte_t *)__pte_alloc_one_kernel(mm);
 	if (!ptep)
 		return NULL;
-	for (i = 0; i < 1024; i++)
-		pte_clear(NULL, 0, ptep + i);
+	ptes_clear(ptep);
 	return ptep;
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	pte_t *pte;
 	struct page *page;
 
-	pte = pte_alloc_one_kernel(mm);
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	page = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (!page)
 		return NULL;
-	}
+	ptes_clear(page_address(page));
 	return page;
 }
 
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_pte_page_dtor(pte);
-	__free_page(pte);
-}
 #define pmd_pgtable(pmd) pmd_page(pmd)
+#endif CONFIG_MMU
 
 #endif /* _XTENSA_PGALLOC_H */
-- 
2.26.2

