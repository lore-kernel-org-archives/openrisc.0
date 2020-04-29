From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 29 Apr 2020 15:11:25 +0300
Subject: [OpenRISC] [PATCH v2 19/20] mm: simplify
 find_min_pfn_with_active_regions()
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Message-ID: <20200429121126.17989-20-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

The find_min_pfn_with_active_regions() calls find_min_pfn_for_node() with
nid parameter set to MAX_NUMNODES. This makes the find_min_pfn_for_node()
traverse all memblock memory regions although the first PFN in the system
can be easily found with memblock_start_of_DRAM().

Use memblock_start_of_DRAM() in find_min_pfn_with_active_regions() and drop
now unused find_min_pfn_for_node().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 30d171451d4c..b990e9734474 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7045,24 +7045,6 @@ unsigned long __init node_map_pfn_alignment(void)
 	return ~accl_mask + 1;
 }
 
-/* Find the lowest pfn for a node */
-static unsigned long __init find_min_pfn_for_node(int nid)
-{
-	unsigned long min_pfn = ULONG_MAX;
-	unsigned long start_pfn;
-	int i;
-
-	for_each_mem_pfn_range(i, nid, &start_pfn, NULL, NULL)
-		min_pfn = min(min_pfn, start_pfn);
-
-	if (min_pfn == ULONG_MAX) {
-		pr_warn("Could not find start_pfn for node %d\n", nid);
-		return 0;
-	}
-
-	return min_pfn;
-}
-
 /**
  * find_min_pfn_with_active_regions - Find the minimum PFN registered
  *
@@ -7071,7 +7053,7 @@ static unsigned long __init find_min_pfn_for_node(int nid)
  */
 unsigned long __init find_min_pfn_with_active_regions(void)
 {
-	return find_min_pfn_for_node(MAX_NUMNODES);
+	return PHYS_PFN(memblock_start_of_DRAM());
 }
 
 /*
-- 
2.26.1

