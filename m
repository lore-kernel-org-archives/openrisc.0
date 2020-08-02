From: Mike Rapoport <rppt@kernel.org>
Date: Sun,  2 Aug 2020 19:35:59 +0300
Subject: [OpenRISC] [PATCH v2 15/17] memblock: remove unused
 memblock_mem_size()
In-Reply-To: <20200802163601.8189-1-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
Message-ID: <20200802163601.8189-16-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

The only user of memblock_mem_size() was x86 setup code, it is gone now and
memblock_mem_size() funciton can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h |  1 -
 mm/memblock.c            | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d70c2835e913..ec2fd8f32a19 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -450,7 +450,6 @@ static inline bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
-phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index c1a4c8798973..48d614352b25 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1656,21 +1656,6 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
-phys_addr_t __init memblock_mem_size(unsigned long limit_pfn)
-{
-	unsigned long pages = 0;
-	unsigned long start_pfn, end_pfn;
-	int i;
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
-		start_pfn = min_t(unsigned long, start_pfn, limit_pfn);
-		end_pfn = min_t(unsigned long, end_pfn, limit_pfn);
-		pages += end_pfn - start_pfn;
-	}
-
-	return PFN_PHYS(pages);
-}
-
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
-- 
2.26.2

