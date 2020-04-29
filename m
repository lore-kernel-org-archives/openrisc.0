From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 29 Apr 2020 15:11:18 +0300
Subject: [OpenRISC] [PATCH v2 12/20] sparc32: simplify detection of memory
 zone boundaries
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Message-ID: <20200429121126.17989-13-rppt@kernel.org>
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
 arch/sparc/mm/srmmu.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b7c94de70cca..cc071dd7d8da 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1008,24 +1008,13 @@ void __init srmmu_paging_init(void)
 	kmap_init();
 
 	{
-		unsigned long zones_size[MAX_NR_ZONES];
-		unsigned long zholes_size[MAX_NR_ZONES];
-		unsigned long npages;
-		int znum;
+		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-		for (znum = 0; znum < MAX_NR_ZONES; znum++)
-			zones_size[znum] = zholes_size[znum] = 0;
+		max_zone_pfn[ZONE_DMA] = max_low_pfn;
+		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
+		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
 
-		npages = max_low_pfn - pfn_base;
-
-		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
-
-		npages = highend_pfn - max_low_pfn;
-		zones_size[ZONE_HIGHMEM] = npages;
-		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
-
-		free_area_init_node(0, zones_size, pfn_base, zholes_size);
+		free_area_init(max_zone_pfn);
 	}
 }
 
-- 
2.26.1

