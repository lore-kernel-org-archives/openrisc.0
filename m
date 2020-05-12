From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 12 May 2020 21:44:15 +0300
Subject: [OpenRISC] [PATCH 05/12] m68k/mm/motorola: move comment about page
 table allocation funcitons
In-Reply-To: <20200512184422.12418-1-rppt@kernel.org>
References: <20200512184422.12418-1-rppt@kernel.org>
Message-ID: <20200512184422.12418-6-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

The comment about page table allocation functions resides in
include/asm/motorola_pgtable.h while the functions live in
include/asm/motorola_pgaloc.h.

Move the comment close to the code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/include/asm/motorola_pgalloc.h | 6 ++++++
 arch/m68k/include/asm/motorola_pgtable.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index c66e42917912..f3cb453a07b7 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -18,6 +18,12 @@ extern void init_pointer_table(void *table, int type);
 extern void *get_pointer_table(int type);
 extern int free_pointer_table(void *table, int type);
 
+/*
+ * Allocate and free page tables. The xxx_kernel() versions are
+ * used to allocate a kernel page table - this turns on ASN bits
+ * if any.
+ */
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	return get_pointer_table(TABLE_PTE);
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 48f19f0ab1e7..9e5a3de21e15 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -227,12 +227,6 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmdp, unsigned long address)
 #define pte_offset_map(pmdp,address) ((pte_t *)__pmd_page(*pmdp) + (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 #define pte_unmap(pte)		((void)0)
 
-/*
- * Allocate and free page tables. The xxx_kernel() versions are
- * used to allocate a kernel page table - this turns on ASN bits
- * if any.
- */
-
 /* Prior to calling these routines, the page should have been flushed
  * from both the cache and ATC, or the CPU might not notice that the
  * cache setting for the page has been changed. -jskov
-- 
2.26.1

