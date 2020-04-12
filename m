From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 12 Apr 2020 22:48:44 +0300
Subject: [OpenRISC] [PATCH 06/21] alpha: simplify detection of memory zone
 boundaries
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Message-ID: <20200412194859.12663-7-rppt@kernel.org>
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
 arch/alpha/mm/numa.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index a24cd13e71cb..5ad6087de1d6 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -202,8 +202,7 @@ setup_memory(void *kernel_end)
 
 void __init paging_init(void)
 {
-	unsigned int    nid;
-	unsigned long   zones_size[MAX_NR_ZONES] = {0, };
+	unsigned long   max_zone_pfn[MAX_NR_ZONES] = {0, };
 	unsigned long	dma_local_pfn;
 
 	/*
@@ -215,19 +214,10 @@ void __init paging_init(void)
 	 */
 	dma_local_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	for_each_online_node(nid) {
-		unsigned long start_pfn = NODE_DATA(nid)->node_start_pfn;
-		unsigned long end_pfn = start_pfn + NODE_DATA(nid)->node_present_pages;
+	max_zone_pfn[ZONE_DMA] = dma_local_pfn;
+	max_zone_pfn[ZONE_NORMAL] = max_pfn;
 
-		if (dma_local_pfn >= end_pfn - start_pfn)
-			zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		else {
-			zones_size[ZONE_DMA] = dma_local_pfn;
-			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
-		}
-		node_set_state(nid, N_NORMAL_MEMORY);
-		free_area_init_node(nid, zones_size, start_pfn, NULL);
-	}
+	free_area_init(max_zone_pfn);
 
 	/* Initialize the kernel's ZERO_PGE. */
 	memset((void *)ZERO_PGE, 0, PAGE_SIZE);
-- 
2.25.1

