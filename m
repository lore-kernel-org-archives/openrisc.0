From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 18 Aug 2020 18:16:25 +0300
Subject: [OpenRISC] [PATCH v3 08/17] memblock: make for_each_memblock_type()
 iterator private
In-Reply-To: <20200818151634.14343-1-rppt@kernel.org>
References: <20200818151634.14343-1-rppt@kernel.org>
Message-ID: <20200818151634.14343-9-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

for_each_memblock_type() is not used outside mm/memblock.c, move it there
from include/linux/memblock.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 include/linux/memblock.h | 5 -----
 mm/memblock.c            | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9d925db0d355..550faf69fc1c 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -552,11 +552,6 @@ static inline unsigned long memblock_region_reserved_end_pfn(const struct memblo
 	     region < (memblock.memblock_type.regions + memblock.memblock_type.cnt);	\
 	     region++)
 
-#define for_each_memblock_type(i, memblock_type, rgn)			\
-	for (i = 0, rgn = &memblock_type->regions[0];			\
-	     i < memblock_type->cnt;					\
-	     i++, rgn = &memblock_type->regions[i])
-
 extern void *alloc_large_system_hash(const char *tablename,
 				     unsigned long bucketsize,
 				     unsigned long numentries,
diff --git a/mm/memblock.c b/mm/memblock.c
index 45f198750be9..59f3998ae5db 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -132,6 +132,11 @@ struct memblock_type physmem = {
 };
 #endif
 
+#define for_each_memblock_type(i, memblock_type, rgn)			\
+	for (i = 0, rgn = &memblock_type->regions[0];			\
+	     i < memblock_type->cnt;					\
+	     i++, rgn = &memblock_type->regions[i])
+
 int memblock_debug __initdata_memblock;
 static bool system_has_some_mirror __initdata_memblock = false;
 static int memblock_can_resize __initdata_memblock;
-- 
2.26.2

