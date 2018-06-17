From: Stafford Horne <shorne@gmail.com>
Date: Mon, 18 Jun 2018 07:12:42 +0900
Subject: [OpenRISC] [PATCH] openrisc: Call destructor during __pte_free_tlb
Message-ID: <20180617221243.10126-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This fixes an issue uncovered when a recent change to add the "page
table" flag was merged.  During bootup we see many errors like the
following:

    BUG: Bad page state in process mkdir  pfn:00bae
    page:c1ff15c0 count:0 mapcount:-1024 mapping:00000000 index:0x0
    flags: 0x0()
    raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
    page dumped because: nonzero mapcount
    Modules linked in:
    CPU: 0 PID: 46 Comm: mkdir Tainted: G    B             4.17.0-simple-smp-07461-g1d40a5ea01d5-dirty #993
    Call trace:
    [<(ptrval)>] show_stack+0x44/0x54
    [<(ptrval)>] dump_stack+0xb0/0xe8
    [<(ptrval)>] bad_page+0x138/0x174
    [<(ptrval)>] ? cpumask_next+0x24/0x34
    [<(ptrval)>] free_pages_check_bad+0x6c/0xd0
    [<(ptrval)>] free_pcppages_bulk+0x174/0x42c
    [<(ptrval)>] free_unref_page_commit.isra.17+0xb8/0xc8
    [<(ptrval)>] free_unref_page_list+0x10c/0x190
    [<(ptrval)>] ? set_reset_devices+0x0/0x2c
    [<(ptrval)>] release_pages+0x3a0/0x414
    [<(ptrval)>] tlb_flush_mmu_free+0x5c/0x90
    [<(ptrval)>] tlb_flush_mmu+0x90/0xa4
    [<(ptrval)>] arch_tlb_finish_mmu+0x50/0x94
    [<(ptrval)>] tlb_finish_mmu+0x30/0x64
    [<(ptrval)>] exit_mmap+0x110/0x1e0
    [<(ptrval)>] mmput+0x50/0xf0
    [<(ptrval)>] do_exit+0x274/0xa94
    [<(ptrval)>] do_group_exit+0x50/0x110
    [<(ptrval)>] __wake_up_parent+0x0/0x38
    [<(ptrval)>] _syscall_return+0x0/0x4

During the __pte_free_tlb path openrisc fails to call the page
destructor which would clear the new bits that were introduced.
To fix this we are calling the destructor.

It seem openrisc was the only architecture missing this,  all other
architectures either call the destructor like we are doing here or use
pte_free.

Fixes: 1d40a5ea01d53 ("mm: mark pages in use for page tables")
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/pgalloc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 3e1a46615120..8999b9226512 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -98,8 +98,12 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte)
 	__free_page(pte);
 }
 
+#define __pte_free_tlb(tlb, pte, addr)	\
+do {					\
+	pgtable_page_dtor(pte);		\
+	tlb_remove_page((tlb), (pte));	\
+} while (0)
 
-#define __pte_free_tlb(tlb, pte, addr) tlb_remove_page((tlb), (pte))
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 #define check_pgt_cache()          do { } while (0)
-- 
2.17.0

