From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 12 Apr 2020 22:48:48 +0300
Subject: [OpenRISC] [PATCH 10/21] m68k: mm: simplify detection of memory
 zone boundaries
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Message-ID: <20200412194859.12663-11-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone sizes
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/mm/motorola.c | 11 +++++------
 arch/m68k/mm/sun3mmu.c  | 10 +++-------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 84ab5963cabb..904c2a663977 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -365,7 +365,7 @@ static void __init map_node(int node)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
 	unsigned long min_addr, max_addr;
 	unsigned long addr;
 	int i;
@@ -448,11 +448,10 @@ void __init paging_init(void)
 #ifdef DEBUG
 	printk ("before free_area_init\n");
 #endif
-	for (i = 0; i < m68k_num_memory; i++) {
-		zones_size[ZONE_DMA] = m68k_memory[i].size >> PAGE_SHIFT;
-		free_area_init_node(i, zones_size,
-				    m68k_memory[i].addr >> PAGE_SHIFT, NULL);
+	for (i = 0; i < m68k_num_memory; i++)
 		if (node_present_pages(i))
 			node_set_state(i, N_NORMAL_MEMORY);
-	}
+
+	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
+	free_area_init(max_zone_pfn);
 }
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index eca1c46bb90a..5d8d956d9329 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -42,7 +42,7 @@ void __init paging_init(void)
 	unsigned long address;
 	unsigned long next_pgtable;
 	unsigned long bootmem_end;
-	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
 	unsigned long size;
 
 	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
@@ -89,14 +89,10 @@ void __init paging_init(void)
 	current->mm = NULL;
 
 	/* memory sizing is a hack stolen from motorola.c..  hope it works for us */
-	zones_size[ZONE_DMA] = ((unsigned long)high_memory - PAGE_OFFSET) >> PAGE_SHIFT;
+	max_zone_pfn[ZONE_DMA] = ((unsigned long)high_memory) >> PAGE_SHIFT;
 
 	/* I really wish I knew why the following change made things better...  -- Sam */
-/*	free_area_init(zones_size); */
-	free_area_init_node(0, zones_size,
-			    (__pa(PAGE_OFFSET) >> PAGE_SHIFT) + 1, NULL);
+	free_area_init(max_zone_pfn);
 
 
 }
-
-
-- 
2.25.1

