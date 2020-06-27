From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 27 Jun 2020 19:46:42 +0100
Subject: [OpenRISC] [PATCH 9/8] mm: Account PMD tables like PTE tables
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
Message-ID: <20200627184642.GF25039@casper.infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

We account the PTE level of the page tables to the process in order to
make smarter OOM decisions and help diagnose why memory is fragmented.
For these same reasons, we should account pages allocated for PMDs.
With larger process address spaces and ASLR, the number of PMDs in use
is higher than it used to be so the inaccuracy is starting to matter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..b283e25fcffa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2271,7 +2271,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_to_page(pmd));
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool pmd_ptlock_init(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	page->pmd_huge_pte = NULL;
@@ -2279,7 +2279,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	return ptlock_init(page);
 }
 
-static inline void pgtable_pmd_page_dtor(struct page *page)
+static inline void pmd_ptlock_free(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
@@ -2296,8 +2296,8 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page) { return true; }
-static inline void pgtable_pmd_page_dtor(struct page *page) {}
+static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2310,6 +2310,22 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
+static inline bool pgtable_pmd_page_ctor(struct page *page)
+{
+	if (!pmd_ptlock_init(page))
+		return false;
+	__SetPageTable(page);
+	inc_zone_page_state(page, NR_PAGETABLE);
+	return true;
+}
+
+static inline void pgtable_pmd_page_dtor(struct page *page)
+{
+	pmd_ptlock_free(page);
+	__ClearPageTable(page);
+	dec_zone_page_state(page, NR_PAGETABLE);
+}
+
 /*
  * No scalability reason to split PUD locks yet, but follow the same pattern
  * as the PMD locks to make it easier if we decide to.  The VM should not be
-- 
2.27.0

