From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 21 Jan 2019 10:03:52 +0200
Subject: [OpenRISC] [PATCH v2 05/21] memblock: emphasize that
	memblock_alloc_range() returns a physical address
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1548057848-15136-6-git-send-email-rppt@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Rename memblock_alloc_range() to memblock_phys_alloc_range() to emphasize
that it returns a physical address.
While on it, remove the 'enum memblock_flags' parameter from this function
as its only user anyway sets it to MEMBLOCK_NONE, which is the default for
the most of memblock allocations.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h |  5 ++---
 mm/cma.c                 | 10 ++++------
 mm/memblock.c            |  9 +++++----
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f7ef313..66dfdb3 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -369,6 +369,8 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 #define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
 #endif
 
+phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
+				      phys_addr_t start, phys_addr_t end);
 phys_addr_t memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
@@ -487,9 +489,6 @@ static inline bool memblock_bottom_up(void)
 	return memblock.bottom_up;
 }
 
-phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
-					phys_addr_t start, phys_addr_t end,
-					enum memblock_flags flags);
 phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 				phys_addr_t max_addr);
 phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
diff --git a/mm/cma.c b/mm/cma.c
index c7b39dd..e4530ae 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -327,16 +327,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
 		 * memory in case of failure.
 		 */
 		if (base < highmem_start && limit > highmem_start) {
-			addr = memblock_alloc_range(size, alignment,
-						    highmem_start, limit,
-						    MEMBLOCK_NONE);
+			addr = memblock_phys_alloc_range(size, alignment,
+							 highmem_start, limit);
 			limit = highmem_start;
 		}
 
 		if (!addr) {
-			addr = memblock_alloc_range(size, alignment, base,
-						    limit,
-						    MEMBLOCK_NONE);
+			addr = memblock_phys_alloc_range(size, alignment, base,
+							 limit);
 			if (!addr) {
 				ret = -ENOMEM;
 				goto err;
diff --git a/mm/memblock.c b/mm/memblock.c
index c80029e..f019aee 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1338,12 +1338,13 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	return 0;
 }
 
-phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
-					phys_addr_t start, phys_addr_t end,
-					enum memblock_flags flags)
+phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
+					     phys_addr_t align,
+					     phys_addr_t start,
+					     phys_addr_t end)
 {
 	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
-					flags);
+					MEMBLOCK_NONE);
 }
 
 phys_addr_t __init memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid)
-- 
2.7.4

