From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 12 Apr 2020 22:48:56 +0300
Subject: [OpenRISC] [PATCH 18/21] mm: rename free_area_init_node() to
 free_area_init_memoryless_node()
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Message-ID: <20200412194859.12663-19-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init_node() is only used by x86 to initialize a memory-less
nodes.
Make its name reflect this and drop all the function parameters except node
ID as they are anyway zero.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/numa.c | 5 +----
 include/linux/mm.h | 9 +++------
 mm/page_alloc.c    | 7 ++-----
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index fe024b2ac796..8ee952038c80 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -737,12 +737,9 @@ void __init x86_numa_init(void)
 
 static void __init init_memory_less_node(int nid)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0};
-	unsigned long zholes_size[MAX_NR_ZONES] = {0};
-
 	/* Allocate and initialize node data. Memory-less node is now online.*/
 	alloc_node_data(nid);
-	free_area_init_node(nid, zones_size, 0, zholes_size);
+	free_area_init_memoryless_node(nid);
 
 	/*
 	 * All zonelists will be built later in start_kernel() after per cpu
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c2ecb42e043..27660f6cf26e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2272,8 +2272,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 }
 
 extern void __init pagecache_init(void);
-extern void __init free_area_init_node(int nid, unsigned long * zones_size,
-		unsigned long zone_start_pfn, unsigned long *zholes_size);
+extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
 
 /*
@@ -2345,10 +2344,8 @@ static inline unsigned long get_num_physpages(void)
 
 /*
  * Using memblock node mappings, an architecture may initialise its
- * zones, allocate the backing mem_map and account for memory holes in a more
- * architecture independent manner. This is a substitute for creating the
- * zone_sizes[] and zholes_size[] arrays and passing them to
- * free_area_init_node()
+ * zones, allocate the backing mem_map and account for memory holes in an
+ * architecture independent manner.
  *
  * An architecture is expected to register range of page frames backed by
  * physical memory with memblock_add[_node]() before calling
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 376434c7a78b..e46232ec4849 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6979,12 +6979,9 @@ static void __init __free_area_init_node(int nid, unsigned long *zones_size,
 	free_area_init_core(pgdat);
 }
 
-void __init free_area_init_node(int nid, unsigned long *zones_size,
-				unsigned long node_start_pfn,
-				unsigned long *zholes_size)
+void __init free_area_init_memoryless_node(int nid)
 {
-	__free_area_init_node(nid, zones_size, node_start_pfn, zholes_size,
-			      true);
+	__free_area_init_node(nid, NULL, 0, NULL, false);
 }
 
 #if !defined(CONFIG_FLAT_NODE_MEM_MAP)
-- 
2.25.1

