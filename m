From: Stafford Horne <shorne@gmail.com>
Date: Sat,  5 Feb 2022 23:19:53 +0900
Subject: [OpenRISC] [PATCH] mm: Remove mmu_gathers storage from remaining
 architectures
Message-ID: <20220205141956.3315419-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Originally the mmu_gathers were removed in commit 1c3951769621 ("mm: now
that all old mmu_gather code is gone, remove the storage").  However,
the openrisc and hexagon architecture were merged around the same time
and mmu_gathers was not removed.

This patch removes them from openrisc, hexagon and nds32:

Noticed while cleaning this warning:

    arch/openrisc/mm/init.c:41:1: warning: symbol 'mmu_gathers' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/hexagon/mm/init.c  | 2 --
 arch/nds32/mm/init.c    | 1 -
 arch/openrisc/mm/init.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f01e91e10d95..3167a3b5c97b 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -29,8 +29,6 @@ int max_kernel_seg = 0x303;
 /*  indicate pfn's of high memory  */
 unsigned long highstart_pfn, highend_pfn;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 /* Default cache attribute for newly created page tables */
 unsigned long _dflt_cache_att = CACHEDEF;
 
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index f63f839738c4..825c85cab1a1 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -18,7 +18,6 @@
 #include <asm/tlb.h>
 #include <asm/page.h>
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 97305bde1b16..3a021ab6f1ae 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -38,8 +38,6 @@
 
 int mem_init_done;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-- 
2.31.1

