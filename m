From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 28 Jul 2020 05:13:14 -0000
Subject: [OpenRISC] [PATCH 06/15] powerpc: fadamp: simplify
 fadump_reserve_crash_area()
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
Message-ID: <20200728051153.1590-7-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

fadump_reserve_crash_area() reserves memory from a specified base address
till the end of the RAM.

Replace iteration through the memblock.memory with a single call to
memblock_reserve() with appropriate  that will take care of proper memory
reservation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 78ab9a6ee6ac..2446a61e3c25 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1658,25 +1658,7 @@ int __init fadump_reserve_mem(void)
 /* Preserve everything above the base address */
 static void __init fadump_reserve_crash_area(u64 base)
 {
-	struct memblock_region *reg;
-	u64 mstart, msize;
-
-	for_each_memblock(memory, reg) {
-		mstart = reg->base;
-		msize  = reg->size;
-
-		if ((mstart + msize) < base)
-			continue;
-
-		if (mstart < base) {
-			msize -= (base - mstart);
-			mstart = base;
-		}
-
-		pr_info("Reserving %lluMB of memory@%#016llx for preserving crash data",
-			(msize >> 20), mstart);
-		memblock_reserve(mstart, msize);
-	}
+	memblock_reserve(base, memblock_end_of_DRAM() - base);
 }
 
 unsigned long __init arch_reserved_kernel_pages(void)
-- 
2.26.2

