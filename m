From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 12 Apr 2020 22:48:53 +0300
Subject: [OpenRISC] [PATCH 15/21] mm: memmap_init: iterate over memblock
 regions rather that check each PFN
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Message-ID: <20200412194859.12663-16-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Baoquan He <bhe@redhat.com>

When called during boot the memmap_init_zone() function checks if each PFN
is valid and actually belongs to the node being initialized using
early_pfn_valid() and early_pfn_in_nid().

Each such check may cost up to O(log(n)) where n is the number of memory
banks, so for large amount of memory overall time spent in early_pfn*()
becomes substantial.

Since the information is anyway present in memblock, we can iterate over
memblock memory regions in memmap_init() and only call memmap_init_zone()
for PFN ranges that are know to be valid and in the appropriate node.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7f6a3081edb8..c43ce8709457 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5995,14 +5995,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * function.  They do not exist on hotplugged memory.
 		 */
 		if (context == MEMMAP_EARLY) {
-			if (!early_pfn_valid(pfn)) {
-				pfn = next_pfn(pfn);
-				continue;
-			}
-			if (!early_pfn_in_nid(pfn, nid)) {
-				pfn++;
-				continue;
-			}
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
 			if (defer_init(nid, pfn, end_pfn))
@@ -6118,9 +6110,23 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 }
 
 void __meminit __weak memmap_init(unsigned long size, int nid,
-				  unsigned long zone, unsigned long start_pfn)
+				  unsigned long zone,
+				  unsigned long range_start_pfn)
 {
-	memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
+	unsigned long start_pfn, end_pfn;
+	unsigned long range_end_pfn = range_start_pfn + size;
+	int i;
+
+	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
+		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+
+		if (end_pfn > start_pfn) {
+			size = end_pfn - start_pfn;
+			memmap_init_zone(size, nid, zone, start_pfn,
+					 MEMMAP_EARLY, NULL);
+		}
+	}
 }
 
 static int zone_batchsize(struct zone *zone)
-- 
2.25.1

