From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 28 Jul 2020 05:12:35 -0000
Subject: [OpenRISC] [PATCH 02/15] dma-contiguous: simplify
 cma_early_percent_memory()
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
Message-ID: <20200728051153.1590-3-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

The memory size calculation in cma_early_percent_memory() traverses
memblock.memory rather than simply call memblock_phys_mem_size(). The
comment in that function suggests that at some point there should have been
call to memblock_analyze() before memblock_phys_mem_size() could be used.
As of now, there is no memblock_analyze() at all and
memblock_phys_mem_size() can be used as soon as cold-plug memory is
registerd with memblock.

Replace loop over memblock.memory with a call to memblock_phys_mem_size().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 kernel/dma/contiguous.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 15bc5026c485..1992afd8ca7b 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -73,16 +73,7 @@ early_param("cma", early_cma);
 
 static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
 {
-	struct memblock_region *reg;
-	unsigned long total_pages = 0;
-
-	/*
-	 * We cannot use memblock_phys_mem_size() here, because
-	 * memblock_analyze() has not been called yet.
-	 */
-	for_each_memblock(memory, reg)
-		total_pages += memblock_region_memory_end_pfn(reg) -
-			       memblock_region_memory_base_pfn(reg);
+	unsigned long total_pages = PHYS_PFN(memblock_phys_mem_size());
 
 	return (total_pages * CONFIG_CMA_SIZE_PERCENTAGE / 100) << PAGE_SHIFT;
 }
-- 
2.26.2

