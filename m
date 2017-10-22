From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 12:15:56 +0900
Subject: [OpenRISC] [PATCH v3 09/13] openrisc: add cacheflush support to fix
	icache aliasing
In-Reply-To: <20171022031600.29612-1-shorne@gmail.com>
References: <20171022031600.29612-1-shorne@gmail.com>
Message-ID: <20171022031600.29612-10-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>

On OpenRISC the icache does not snoop data stores.  This can cause
aliasing as reported by Jan. This patch fixes the issue to ensure icache
is properly synchronized when code is written to memory.  It supports both
SMP and UP flushing.

This supports dcache flush as well for architectures that do not support
write-through caches; most OpenRISC implementations do implement
write-through cache however. Dcache flushes are done only on a single
core as OpenRISC dcaches all support snooping of bus stores.

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>
[shorne at gmail.com: Squashed patches and wrote commit message]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig                  | 11 ++++
 arch/openrisc/include/asm/Kbuild       |  1 -
 arch/openrisc/include/asm/cacheflush.h | 96 ++++++++++++++++++++++++++++++++++
 arch/openrisc/include/asm/pgtable.h    | 16 +++---
 arch/openrisc/kernel/smp.c             | 15 ++++++
 arch/openrisc/mm/Makefile              |  2 +-
 arch/openrisc/mm/cache.c               | 61 +++++++++++++++++++++
 7 files changed, 194 insertions(+), 8 deletions(-)
 create mode 100644 arch/openrisc/include/asm/cacheflush.h
 create mode 100644 arch/openrisc/mm/cache.c

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 2b3898ede888..bfff04ae7f7d 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -77,6 +77,17 @@ config OR1K_1200
 
 endchoice
 
+config DCACHE_WRITETHROUGH
+	bool "Have write through data caches"
+	default n
+	help
+	  Select this if your implementation features write through data caches.
+	  Selecting 'N' here will allow the kernel to force flushing of data
+	  caches at relevant times. Most OpenRISC implementations support write-
+	  through data caches.
+
+	  If unsure say N here
+
 config OPENRISC_BUILTIN_DTB
         string "Builtin DTB"
         default ""
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 5f066780d870..6eb16719549e 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
-generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += clkdev.h
 generic-y += current.h
diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
new file mode 100644
index 000000000000..70f46fd7a074
--- /dev/null
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -0,0 +1,96 @@
+/*
+ * OpenRISC Linux
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * OpenRISC implementation:
+ * Copyright (C) Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
+ * et al.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __ASM_CACHEFLUSH_H
+#define __ASM_CACHEFLUSH_H
+
+#include <linux/mm.h>
+
+/*
+ * Helper function for flushing or invalidating entire pages from data
+ * and instruction caches. SMP needs a little extra work, since we need
+ * to flush the pages on all cpus.
+ */
+extern void local_dcache_page_flush(struct page *page);
+extern void local_icache_page_inv(struct page *page);
+
+/*
+ * Data cache flushing always happen on the local cpu. Instruction cache
+ * invalidations need to be broadcasted to all other cpu in the system in
+ * case of SMP configurations.
+ */
+#ifndef CONFIG_SMP
+#define dcache_page_flush(page)      local_dcache_page_flush(page)
+#define icache_page_inv(page)        local_icache_page_inv(page)
+#else  /* CONFIG_SMP */
+#define dcache_page_flush(page)      local_dcache_page_flush(page)
+#define icache_page_inv(page)        smp_icache_page_inv(page)
+extern void smp_icache_page_inv(struct page *page);
+#endif /* CONFIG_SMP */
+
+/*
+ * Synchronizes caches. Whenever a cpu writes executable code to memory, this
+ * should be called to make sure the processor sees the newly written code.
+ */
+static inline void sync_icache_dcache(struct page *page)
+{
+	if (!IS_ENABLED(CONFIG_DCACHE_WRITETHROUGH))
+		dcache_page_flush(page);
+	icache_page_inv(page);
+}
+
+/*
+ * Pages with this bit set need not be flushed/invalidated, since
+ * they have not changed since last flush. New pages start with
+ * PG_arch_1 not set and are therefore dirty by default.
+ */
+#define PG_dc_clean                  PG_arch_1
+
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
+static inline void flush_dcache_page(struct page *page)
+{
+	clear_bit(PG_dc_clean, &page->flags);
+}
+
+/*
+ * Other interfaces are not required since we do not have virtually
+ * indexed or tagged caches. So we can use the default here.
+ */
+#define flush_cache_all()				do { } while (0)
+#define flush_cache_mm(mm)				do { } while (0)
+#define flush_cache_dup_mm(mm)				do { } while (0)
+#define flush_cache_range(vma, start, end)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)		do { } while (0)
+#define flush_dcache_mmap_lock(mapping)			do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)		do { } while (0)
+#define flush_icache_range(start, end)			do { } while (0)
+#define flush_icache_page(vma, pg)			do { } while (0)
+#define flush_icache_user_range(vma, pg, adr, len)	do { } while (0)
+#define flush_cache_vmap(start, end)			do { } while (0)
+#define flush_cache_vunmap(start, end)			do { } while (0)
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len)           \
+	do {                                                         \
+		memcpy(dst, src, len);                               \
+		if (vma->vm_flags & VM_EXEC)                         \
+			sync_icache_dcache(page);                    \
+	} while (0)
+
+#define copy_from_user_page(vma, page, vaddr, dst, src, len)         \
+	memcpy(dst, src, len)
+
+#endif /* __ASM_CACHEFLUSH_H */
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index eff5ba2a5af2..21c71303012f 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -416,15 +416,19 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD]; /* defined in head.S */
 
 struct vm_area_struct;
 
-/*
- * or32 doesn't have any external MMU info: the kernel page
- * tables contain all the necessary information.
- *
- * Actually I am not sure on what this could be used for.
- */
+static inline void update_tlb(struct vm_area_struct *vma,
+	unsigned long address, pte_t *pte)
+{
+}
+
+extern void update_cache(struct vm_area_struct *vma,
+	unsigned long address, pte_t *pte);
+
 static inline void update_mmu_cache(struct vm_area_struct *vma,
 	unsigned long address, pte_t *pte)
 {
+	update_tlb(vma, address, pte);
+	update_cache(vma, address, pte);
 }
 
 /* __PHX__ FIXME, SWAP, this probably doesn't work */
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 685b4934fa39..4763b8b9161e 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -18,6 +18,7 @@
 #include <asm/cpuinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 #include <asm/time.h>
 
 static void (*smp_cross_call)(const struct cpumask *, unsigned int);
@@ -239,3 +240,17 @@ void flush_tlb_range(struct vm_area_struct *vma,
 {
 	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 }
+
+/* Instruction cache invalidate - performed on each cpu */
+static void ipi_icache_page_inv(void *arg)
+{
+	struct page *page = arg;
+
+	local_icache_page_inv(page);
+}
+
+void smp_icache_page_inv(struct page *page)
+{
+	on_each_cpu(ipi_icache_page_inv, page, 1);
+}
+EXPORT_SYMBOL(smp_icache_page_inv);
diff --git a/arch/openrisc/mm/Makefile b/arch/openrisc/mm/Makefile
index 324ba2634529..a31b2a42e966 100644
--- a/arch/openrisc/mm/Makefile
+++ b/arch/openrisc/mm/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux openrisc-specific parts of the memory manager.
 #
 
-obj-y	:= fault.o tlb.o init.o ioremap.o
+obj-y	:= fault.o cache.o tlb.o init.o ioremap.o
diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
new file mode 100644
index 000000000000..b747bf1fc1b6
--- /dev/null
+++ b/arch/openrisc/mm/cache.c
@@ -0,0 +1,61 @@
+/*
+ * OpenRISC cache.c
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * Modifications for the OpenRISC architecture:
+ * Copyright (C) 2015 Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/spr.h>
+#include <asm/spr_defs.h>
+#include <asm/cache.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+static void cache_loop(struct page *page, const unsigned int reg)
+{
+	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
+	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
+
+	while (line < paddr + PAGE_SIZE) {
+		mtspr(reg, line);
+		line += L1_CACHE_BYTES;
+	}
+}
+
+void local_dcache_page_flush(struct page *page)
+{
+	cache_loop(page, SPR_DCBFR);
+}
+EXPORT_SYMBOL(local_dcache_page_flush);
+
+void local_icache_page_inv(struct page *page)
+{
+	cache_loop(page, SPR_ICBIR);
+}
+EXPORT_SYMBOL(local_icache_page_inv);
+
+void update_cache(struct vm_area_struct *vma, unsigned long address,
+	pte_t *pte)
+{
+	unsigned long pfn = pte_val(*pte) >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(pfn);
+	int dirty = !test_and_set_bit(PG_dc_clean, &page->flags);
+
+	/*
+	 * Since icaches do not snoop for updated data on OpenRISC, we
+	 * must write back and invalidate any dirty pages manually. We
+	 * can skip data pages, since they will not end up in icaches.
+	 */
+	if ((vma->vm_flags & VM_EXEC) && dirty)
+		sync_icache_dcache(page);
+}
+
-- 
2.13.6

