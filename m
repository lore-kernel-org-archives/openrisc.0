From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:37 +0900
Subject: [OpenRISC] [PATCH v2 7/9] openrisc: Consolidate setup to use
	memblock instead of bootmem
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <87a7b561ff0325d839987154b02a377b59ca339f.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Clearing out one todo item. Use the memblock boot time memory
which is the current standard.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Jonas <jonas@southpole.se>
---
 arch/openrisc/Kconfig               |  1 +
 arch/openrisc/TODO.openrisc         |  3 ---
 arch/openrisc/include/asm/pgalloc.h |  1 -
 arch/openrisc/kernel/setup.c        | 36 ++++++++++++------------------------
 arch/openrisc/mm/init.c             |  2 +-
 arch/openrisc/mm/ioremap.c          |  4 ----
 6 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 691e1af..8d22015 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -26,6 +26,7 @@ config OPENRISC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
+	select NO_BOOTMEM
 
 config MMU
 	def_bool y
diff --git a/arch/openrisc/TODO.openrisc b/arch/openrisc/TODO.openrisc
index acfeef9..0eb04c8 100644
--- a/arch/openrisc/TODO.openrisc
+++ b/arch/openrisc/TODO.openrisc
@@ -5,9 +5,6 @@ that are due for investigation shortly, i.e. our TODO list:
 
 -- Implement the rest of the DMA API... dma_map_sg, etc.
 
--- Consolidate usage of memblock and bootmem... move everything over to
-   memblock.
-
 -- Finish the renaming cleanup... there are references to or32 in the code
    which was an older name for the architecture.  The name we've settled on is
    or1k and this change is slowly trickling through the stack.  For the time
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 87eebd1..3e1a466 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -23,7 +23,6 @@
 #include <linux/threads.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
-#include <linux/bootmem.h>
 
 extern int mem_init_done;
 
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index d2f78cf..6329d7a 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -50,18 +50,16 @@
 
 #include "vmlinux.h"
 
-static unsigned long __init setup_memory(void)
+static void __init setup_memory(void)
 {
-	unsigned long bootmap_size;
 	unsigned long ram_start_pfn;
-	unsigned long free_ram_start_pfn;
 	unsigned long ram_end_pfn;
 	phys_addr_t memory_start, memory_end;
 	struct memblock_region *region;
 
 	memory_end = memory_start = 0;
 
-	/* Find main memory where is the kernel */
+	/* Find main memory where is the kernel, we assume its the only one */
 	for_each_memblock(memory, region) {
 		memory_start = region->base;
 		memory_end = region->base + region->size;
@@ -74,10 +72,11 @@ static unsigned long __init setup_memory(void)
 	}
 
 	ram_start_pfn = PFN_UP(memory_start);
-	/* free_ram_start_pfn is first page after kernel */
-	free_ram_start_pfn = PFN_UP(__pa(_end));
 	ram_end_pfn = PFN_DOWN(memblock_end_of_DRAM());
 
+	/* setup bootmem globals (we use no_bootmem, but mm still depends on this) */
+	min_low_pfn = ram_start_pfn;
+	max_low_pfn = ram_end_pfn;
 	max_pfn = ram_end_pfn;
 
 	/*
@@ -85,22 +84,13 @@ static unsigned long __init setup_memory(void)
 	 *
 	 * This makes the memory from the end of the kernel to the end of
 	 * RAM usable.
-	 * init_bootmem sets the global values min_low_pfn, max_low_pfn.
 	 */
-	bootmap_size = init_bootmem(free_ram_start_pfn,
-				    ram_end_pfn - ram_start_pfn);
-	free_bootmem(PFN_PHYS(free_ram_start_pfn),
-		     (ram_end_pfn - free_ram_start_pfn) << PAGE_SHIFT);
-	reserve_bootmem(PFN_PHYS(free_ram_start_pfn), bootmap_size,
-			BOOTMEM_DEFAULT);
-
-	for_each_memblock(reserved, region) {
-		printk(KERN_INFO "Reserved - 0x%08x-0x%08x\n",
-		       (u32) region->base, (u32) region->size);
-		reserve_bootmem(region->base, region->size, BOOTMEM_DEFAULT);
-	}
+	memblock_reserve(__pa(_stext), _end - _stext);
+
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
 
-	return ram_end_pfn;
+	memblock_dump_all();
 }
 
 struct cpuinfo cpuinfo;
@@ -272,8 +262,6 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	unsigned long max_low_pfn;
-
 	unflatten_and_copy_device_tree();
 
 	setup_cpuinfo();
@@ -294,8 +282,8 @@ void __init setup_arch(char **cmdline_p)
 	initrd_below_start_ok = 1;
 #endif
 
-	/* setup bootmem allocator */
-	max_low_pfn = setup_memory();
+	/* setup memblock allocator */
+	setup_memory();
 
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index b782ce9..f67d82b 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -106,7 +106,7 @@ static void __init map_ram(void)
 			}
 
 			/* Alloc one page for holding PTE's... */
-			pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+			pte = (pte_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
 			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
 
 			/* Fill the newly allocated page with PTE'S */
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index fa60b81..8705a46 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -124,11 +124,7 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm,
 	if (likely(mem_init_done)) {
 		pte = (pte_t *) __get_free_page(GFP_KERNEL);
 	} else {
-		pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-#if 0
-		/* FIXME: use memblock... */
 		pte = (pte_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
-#endif
 	}
 
 	if (pte)
-- 
2.7.4


