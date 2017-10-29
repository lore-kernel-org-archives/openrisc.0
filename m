From: Stafford Horne <shorne@gmail.com>
Date: Mon, 30 Oct 2017 08:11:16 +0900
Subject: [OpenRISC] [PATCH v4 06/13] openrisc: initial SMP support
In-Reply-To: <20171029231123.27281-1-shorne@gmail.com>
References: <20171029231123.27281-1-shorne@gmail.com>
Message-ID: <20171029231123.27281-7-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

This patch introduces the SMP support for the OpenRISC architecture.
The SMP architecture requires cores which have multi-core features which
have been introduced a few years back including:

 - New SPRS SPR_COREID SPR_NUMCORES
 - Shadow SPRs
 - Atomic Instructions
 - Cache Coherency
 - A wired in IPI controller

This patch adds all of the SMP specific changes to core infrastructure,
it looks big but it needs to go all together as its hard to split this
one up.

Boot loader spinning of second cpu is not supported yet, it's assumed
that Linux is booted straight after cpu reset.

The bulk of these changes are trivial changes to refactor to use per cpu
data structures throughout.  The addition of the smp.c and changes in
time.c are the changes.  Some specific notes:

MM changes
----------
The reason why this is created as an array, and not with DEFINE_PER_CPU
is that doing it this way, we'll save a load in the tlb-miss handler
(the load from __per_cpu_offset).

TLB Flush
---------
The SMP implementation of flush_tlb_* works by sending out a
function-call IPI to all the non-local cpus by using the generic
on_each_cpu() function.

Currently, all flush_tlb_* functions will result in a flush_tlb_all(),
which has always been the behaviour in the UP case.

CPU INFO
--------
This creates a per cpu cpuinfo struct and fills it out accordingly for
each activated cpu.  show_cpuinfo is also updated to reflect new version
information in later versions of the spec.

SMP API
-------
This imitates the arm64 implementation by having a smp_cross_call
callback that can be set by set_smp_cross_call to initiate an IPI and a
handle_IPI function that is expected to be called from an IPI irqchip
driver.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: added cpu stop, checkpatch fixes, wrote commit message]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since v2
 - none

Changes since v1
 - Added time.h for timer initialization
 - Don't crash on boot if IPI initialization fails
 - Removed volatile on secondary_release flag (checkpatch report)
 - Change ipi variable name from ipi_msg from

 arch/openrisc/Kconfig                   |  17 ++-
 arch/openrisc/include/asm/cpuinfo.h     |   7 +-
 arch/openrisc/include/asm/mmu_context.h |   2 +-
 arch/openrisc/include/asm/pgtable.h     |   2 +-
 arch/openrisc/include/asm/serial.h      |   2 +-
 arch/openrisc/include/asm/smp.h         |  26 ++++
 arch/openrisc/include/asm/spr_defs.h    |  14 ++
 arch/openrisc/include/asm/time.h        |  15 ++
 arch/openrisc/include/asm/tlbflush.h    |  25 +++-
 arch/openrisc/kernel/Makefile           |   1 +
 arch/openrisc/kernel/dma.c              |  14 +-
 arch/openrisc/kernel/head.S             |  97 ++++++++++++-
 arch/openrisc/kernel/setup.c            | 165 ++++++++++++++--------
 arch/openrisc/kernel/smp.c              | 235 ++++++++++++++++++++++++++++++++
 arch/openrisc/kernel/time.c             |  51 ++++---
 arch/openrisc/lib/delay.c               |   2 +-
 arch/openrisc/mm/fault.c                |   4 +-
 arch/openrisc/mm/init.c                 |   2 +-
 arch/openrisc/mm/tlb.c                  |  16 +--
 19 files changed, 584 insertions(+), 113 deletions(-)
 create mode 100644 arch/openrisc/include/asm/smp.h
 create mode 100644 arch/openrisc/include/asm/time.h
 create mode 100644 arch/openrisc/kernel/smp.c

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 34eb4e90f56c..2b3898ede888 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,8 +21,10 @@ config OPENRISC
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
@@ -107,8 +109,19 @@ config OPENRISC_HAVE_INST_DIV
 endmenu
 
 config NR_CPUS
-	int
-	default "1"
+	int "Maximum number of CPUs (2-32)"
+	range 2 32
+	depends on SMP
+	default "2"
+
+config SMP
+	bool "Symmetric Multi-Processing support"
+	help
+	  This enables support for systems with more than one CPU. If you have
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
+
+	  If you don't know what to do here, say N.
 
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
index ec10679d6429..4ea0a33eba6c 100644
--- a/arch/openrisc/include/asm/cpuinfo.h
+++ b/arch/openrisc/include/asm/cpuinfo.h
@@ -19,7 +19,7 @@
 #ifndef __ASM_OPENRISC_CPUINFO_H
 #define __ASM_OPENRISC_CPUINFO_H
 
-struct cpuinfo {
+struct cpuinfo_or1k {
 	u32 clock_frequency;
 
 	u32 icache_size;
@@ -29,8 +29,11 @@ struct cpuinfo {
 	u32 dcache_size;
 	u32 dcache_block_size;
 	u32 dcache_ways;
+
+	u16 coreid;
 };
 
-extern struct cpuinfo cpuinfo;
+extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
+extern void setup_cpuinfo(void);
 
 #endif /* __ASM_OPENRISC_CPUINFO_H */
diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
index e94b814d2e3c..c380d8caf84f 100644
--- a/arch/openrisc/include/asm/mmu_context.h
+++ b/arch/openrisc/include/asm/mmu_context.h
@@ -34,7 +34,7 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * registers like cr3 on the i386
  */
 
-extern volatile pgd_t *current_pgd;   /* defined in arch/openrisc/mm/fault.c */
+extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 71a6f08de8f2..eff5ba2a5af2 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -94,7 +94,7 @@ extern void paging_init(void);
  * 64 MB of vmalloc area is comparable to what's available on other arches.
  */
 
-#define VMALLOC_START	(PAGE_OFFSET-0x04000000)
+#define VMALLOC_START	(PAGE_OFFSET-0x04000000UL)
 #define VMALLOC_END	(PAGE_OFFSET)
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
 
diff --git a/arch/openrisc/include/asm/serial.h b/arch/openrisc/include/asm/serial.h
index 270a45241639..cb5932f5447a 100644
--- a/arch/openrisc/include/asm/serial.h
+++ b/arch/openrisc/include/asm/serial.h
@@ -29,7 +29,7 @@
  * it needs to be correct to get the early console working.
  */
 
-#define BASE_BAUD (cpuinfo.clock_frequency/16)
+#define BASE_BAUD (cpuinfo_or1k[smp_processor_id()].clock_frequency/16)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/openrisc/include/asm/smp.h b/arch/openrisc/include/asm/smp.h
new file mode 100644
index 000000000000..e21d2f12b5b6
--- /dev/null
+++ b/arch/openrisc/include/asm/smp.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_OPENRISC_SMP_H
+#define __ASM_OPENRISC_SMP_H
+
+#include <asm/spr.h>
+#include <asm/spr_defs.h>
+
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
+#define hard_smp_processor_id()	mfspr(SPR_COREID)
+
+extern void smp_init_cpus(void);
+
+extern void arch_send_call_function_single_ipi(int cpu);
+extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+
+extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
+extern void handle_IPI(unsigned int ipi_msg);
+
+#endif /* __ASM_OPENRISC_SMP_H */
diff --git a/arch/openrisc/include/asm/spr_defs.h b/arch/openrisc/include/asm/spr_defs.h
index 367dac70326a..154b5a1ee579 100644
--- a/arch/openrisc/include/asm/spr_defs.h
+++ b/arch/openrisc/include/asm/spr_defs.h
@@ -51,6 +51,11 @@
 #define SPR_ICCFGR	(SPRGROUP_SYS + 6)
 #define SPR_DCFGR	(SPRGROUP_SYS + 7)
 #define SPR_PCCFGR	(SPRGROUP_SYS + 8)
+#define SPR_VR2		(SPRGROUP_SYS + 9)
+#define SPR_AVR		(SPRGROUP_SYS + 10)
+#define SPR_EVBAR	(SPRGROUP_SYS + 11)
+#define SPR_AECR	(SPRGROUP_SYS + 12)
+#define SPR_AESR	(SPRGROUP_SYS + 13)
 #define SPR_NPC         (SPRGROUP_SYS + 16)  /* CZ 21/06/01 */
 #define SPR_SR		(SPRGROUP_SYS + 17)  /* CZ 21/06/01 */
 #define SPR_PPC         (SPRGROUP_SYS + 18)  /* CZ 21/06/01 */
@@ -61,6 +66,8 @@
 #define SPR_EEAR_LAST	(SPRGROUP_SYS + 63)
 #define SPR_ESR_BASE	(SPRGROUP_SYS + 64)
 #define SPR_ESR_LAST	(SPRGROUP_SYS + 79)
+#define SPR_COREID	(SPRGROUP_SYS + 128)
+#define SPR_NUMCORES	(SPRGROUP_SYS + 129)
 #define SPR_GPR_BASE	(SPRGROUP_SYS + 1024)
 
 /* Data MMU group */
@@ -135,12 +142,19 @@
 #define SPR_VR_CFG	0x00ff0000  /* Processor configuration */
 #define SPR_VR_RES	0x0000ffc0  /* Reserved */
 #define SPR_VR_REV	0x0000003f  /* Processor revision */
+#define SPR_VR_UVRP	0x00000040  /* Updated Version Registers Present */
 
 #define SPR_VR_VER_OFF	24
 #define SPR_VR_CFG_OFF	16
 #define SPR_VR_REV_OFF	0
 
 /*
+ * Bit definitions for the Version Register 2
+ */
+#define SPR_VR2_CPUID	0xff000000  /* Processor ID */
+#define SPR_VR2_VER	0x00ffffff  /* Processor version */
+
+/*
  * Bit definitions for the Unit Present Register
  *
  */
diff --git a/arch/openrisc/include/asm/time.h b/arch/openrisc/include/asm/time.h
new file mode 100644
index 000000000000..fe83a34a7d68
--- /dev/null
+++ b/arch/openrisc/include/asm/time.h
@@ -0,0 +1,15 @@
+/*
+ * OpenRISC timer API
+ *
+ * Copyright (C) 2017 by Stafford Horne (shorne at gmail.com)
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_OR1K_TIME_H
+#define __ASM_OR1K_TIME_H
+
+extern void openrisc_clockevent_init(void);
+
+#endif /* __ASM_OR1K_TIME_H */
diff --git a/arch/openrisc/include/asm/tlbflush.h b/arch/openrisc/include/asm/tlbflush.h
index 6a2accd6cb67..94227f0eaf6d 100644
--- a/arch/openrisc/include/asm/tlbflush.h
+++ b/arch/openrisc/include/asm/tlbflush.h
@@ -33,13 +33,26 @@
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(mm, start, end) flushes a range of pages
  */
+extern void local_flush_tlb_all(void);
+extern void local_flush_tlb_mm(struct mm_struct *mm);
+extern void local_flush_tlb_page(struct vm_area_struct *vma,
+				 unsigned long addr);
+extern void local_flush_tlb_range(struct vm_area_struct *vma,
+				  unsigned long start,
+				  unsigned long end);
 
-void flush_tlb_all(void);
-void flush_tlb_mm(struct mm_struct *mm);
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
-void flush_tlb_range(struct vm_area_struct *vma,
-		     unsigned long start,
-		     unsigned long end);
+#ifndef CONFIG_SMP
+#define flush_tlb_all	local_flush_tlb_all
+#define flush_tlb_mm	local_flush_tlb_mm
+#define flush_tlb_page	local_flush_tlb_page
+#define flush_tlb_range	local_flush_tlb_range
+#else
+extern void flush_tlb_all(void);
+extern void flush_tlb_mm(struct mm_struct *mm);
+extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
+extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
+#endif
 
 static inline void flush_tlb(void)
 {
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index ec6d9d37cefd..7d94643c878d 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -8,6 +8,7 @@ obj-y	:= setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
 	   sys_call_table.o
 
+obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
 
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index b10369b7e31b..a945f00011b4 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -32,6 +32,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
 		 unsigned long next, struct mm_walk *walk)
 {
 	unsigned long cl;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	pte_val(*pte) |= _PAGE_CI;
 
@@ -42,7 +43,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
 	flush_tlb_page(NULL, addr);
 
 	/* Flush page out of dcache */
-	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo.dcache_block_size)
+	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
 		mtspr(SPR_DCBFR, cl);
 
 	return 0;
@@ -140,6 +141,7 @@ or1k_map_page(struct device *dev, struct page *page,
 {
 	unsigned long cl;
 	dma_addr_t addr = page_to_phys(page) + offset;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return addr;
@@ -148,13 +150,13 @@ or1k_map_page(struct device *dev, struct page *page,
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
 		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo.dcache_block_size)
+		     cl += cpuinfo->dcache_block_size)
 			mtspr(SPR_DCBFR, cl);
 		break;
 	case DMA_FROM_DEVICE:
 		/* Invalidate the dcache for the requested range */
 		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo.dcache_block_size)
+		     cl += cpuinfo->dcache_block_size)
 			mtspr(SPR_DCBIR, cl);
 		break;
 	default:
@@ -213,9 +215,10 @@ or1k_sync_single_for_cpu(struct device *dev,
 {
 	unsigned long cl;
 	dma_addr_t addr = dma_handle;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	/* Invalidate the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo.dcache_block_size)
+	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
 		mtspr(SPR_DCBIR, cl);
 }
 
@@ -226,9 +229,10 @@ or1k_sync_single_for_device(struct device *dev,
 {
 	unsigned long cl;
 	dma_addr_t addr = dma_handle;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	/* Flush the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo.dcache_block_size)
+	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
 		mtspr(SPR_DCBFR, cl);
 }
 
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 1e49895408f4..a9972dc103f8 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -158,12 +158,38 @@
 
 /* =========================================================[ macros ]=== */
 
-
+#ifdef CONFIG_SMP
 #define GET_CURRENT_PGD(reg,t1)					\
 	LOAD_SYMBOL_2_GPR(reg,current_pgd)			;\
+	l.mfspr	t1,r0,SPR_COREID				;\
+	l.slli	t1,t1,2						;\
+	l.add	reg,reg,t1					;\
 	tophys  (t1,reg)					;\
 	l.lwz   reg,0(t1)
+#else
+#define GET_CURRENT_PGD(reg,t1)					\
+	LOAD_SYMBOL_2_GPR(reg,current_pgd)			;\
+	tophys  (t1,reg)					;\
+	l.lwz   reg,0(t1)
+#endif
 
+/* Load r10 from current_thread_info_set - clobbers r1 and r30 */
+#ifdef CONFIG_SMP
+#define GET_CURRENT_THREAD_INFO					\
+	LOAD_SYMBOL_2_GPR(r1,current_thread_info_set)		;\
+	tophys  (r30,r1)					;\
+	l.mfspr	r10,r0,SPR_COREID				;\
+	l.slli	r10,r10,2					;\
+	l.add	r30,r30,r10					;\
+	/* r10: current_thread_info  */				;\
+	l.lwz   r10,0(r30)
+#else
+#define GET_CURRENT_THREAD_INFO					\
+	LOAD_SYMBOL_2_GPR(r1,current_thread_info_set)		;\
+	tophys  (r30,r1)					;\
+	/* r10: current_thread_info  */				;\
+	l.lwz   r10,0(r30)
+#endif
 
 /*
  * DSCR: this is a common hook for handling exceptions. it will save
@@ -206,10 +232,7 @@
 	l.bnf   2f                            /* kernel_mode */	;\
 	 EXCEPTION_T_STORE_SP                 /* delay slot */	;\
 1: /* user_mode:   */						;\
-	LOAD_SYMBOL_2_GPR(r1,current_thread_info_set)		;\
-	tophys  (r30,r1)					;\
-	/* r10: current_thread_info  */				;\
-	l.lwz   r10,0(r30)					;\
+	GET_CURRENT_THREAD_INFO	 				;\
 	tophys  (r30,r10)					;\
 	l.lwz   r1,(TI_KSP)(r30)				;\
 	/* fall through */					;\
@@ -530,6 +553,12 @@ _start:
 	CLEAR_GPR(r30)
 	CLEAR_GPR(r31)
 
+#ifdef CONFIG_SMP
+	l.mfspr	r26,r0,SPR_COREID
+	l.sfeq	r26,r0
+	l.bnf	secondary_wait
+	 l.nop
+#endif
 	/*
 	 * set up initial ksp and current
 	 */
@@ -681,6 +710,64 @@ _flush_tlb:
 	l.jr	r9
 	 l.nop
 
+#ifdef CONFIG_SMP
+secondary_wait:
+	l.mfspr	r25,r0,SPR_COREID
+	l.movhi	r3,hi(secondary_release)
+	l.ori	r3,r3,lo(secondary_release)
+	tophys(r4, r3)
+	l.lwz	r3,0(r4)
+	l.sfeq	r25,r3
+	l.bnf	secondary_wait
+	 l.nop
+	/* fall through to secondary_init */
+
+secondary_init:
+	/*
+	 * set up initial ksp and current
+	 */
+	LOAD_SYMBOL_2_GPR(r10, secondary_thread_info)
+	tophys	(r30,r10)
+	l.lwz	r10,0(r30)
+	l.addi	r1,r10,THREAD_SIZE
+	tophys	(r30,r10)
+	l.sw	TI_KSP(r30),r1
+
+	l.jal	_ic_enable
+	 l.nop
+
+	l.jal	_dc_enable
+	 l.nop
+
+	l.jal	_flush_tlb
+	 l.nop
+
+	/*
+	 * enable dmmu & immu
+	 */
+	l.mfspr	r30,r0,SPR_SR
+	l.movhi	r28,hi(SPR_SR_DME | SPR_SR_IME)
+	l.ori	r28,r28,lo(SPR_SR_DME | SPR_SR_IME)
+	l.or	r30,r30,r28
+	/*
+	 * This is a bit tricky, we need to switch over from physical addresses
+	 * to virtual addresses on the fly.
+	 * To do that, we first set up ESR with the IME and DME bits set.
+	 * Then EPCR is set to secondary_start and then a l.rfe is issued to
+	 * "jump" to that.
+	 */
+	l.mtspr	r0,r30,SPR_ESR_BASE
+	LOAD_SYMBOL_2_GPR(r30, secondary_start)
+	l.mtspr	r0,r30,SPR_EPCR_BASE
+	l.rfe
+
+secondary_start:
+	LOAD_SYMBOL_2_GPR(r30, secondary_start_kernel)
+	l.jr    r30
+	 l.nop
+
+#endif
+
 /* ========================================[ cache ]=== */
 
 	/* alignment here so we don't change memory offsets with
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index dbf5ee95a0d5..9d28ab14d139 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -93,7 +93,7 @@ static void __init setup_memory(void)
 	memblock_dump_all();
 }
 
-struct cpuinfo cpuinfo;
+struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
 
 static void print_cpuinfo(void)
 {
@@ -101,12 +101,13 @@ static void print_cpuinfo(void)
 	unsigned long vr = mfspr(SPR_VR);
 	unsigned int version;
 	unsigned int revision;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	version = (vr & SPR_VR_VER) >> 24;
 	revision = (vr & SPR_VR_REV);
 
 	printk(KERN_INFO "CPU: OpenRISC-%x (revision %d) @%d MHz\n",
-	       version, revision, cpuinfo.clock_frequency / 1000000);
+	       version, revision, cpuinfo->clock_frequency / 1000000);
 
 	if (!(upr & SPR_UPR_UP)) {
 		printk(KERN_INFO
@@ -117,15 +118,15 @@ static void print_cpuinfo(void)
 	if (upr & SPR_UPR_DCP)
 		printk(KERN_INFO
 		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
-		       cpuinfo.dcache_size, cpuinfo.dcache_block_size,
-		       cpuinfo.dcache_ways);
+		       cpuinfo->dcache_size, cpuinfo->dcache_block_size,
+		       cpuinfo->dcache_ways);
 	else
 		printk(KERN_INFO "-- dcache disabled\n");
 	if (upr & SPR_UPR_ICP)
 		printk(KERN_INFO
 		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
-		       cpuinfo.icache_size, cpuinfo.icache_block_size,
-		       cpuinfo.icache_ways);
+		       cpuinfo->icache_size, cpuinfo->icache_block_size,
+		       cpuinfo->icache_ways);
 	else
 		printk(KERN_INFO "-- icache disabled\n");
 
@@ -153,38 +154,58 @@ static void print_cpuinfo(void)
 		printk(KERN_INFO "-- custom unit(s)\n");
 }
 
+static struct device_node *setup_find_cpu_node(int cpu)
+{
+	u32 hwid;
+	struct device_node *cpun;
+	struct device_node *cpus = of_find_node_by_path("/cpus");
+
+	for_each_available_child_of_node(cpus, cpun) {
+		if (of_property_read_u32(cpun, "reg", &hwid))
+			continue;
+		if (hwid == cpu)
+			return cpun;
+	}
+
+	return NULL;
+}
+
 void __init setup_cpuinfo(void)
 {
 	struct device_node *cpu;
 	unsigned long iccfgr, dccfgr;
 	unsigned long cache_set_size;
+	int cpu_id = smp_processor_id();
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
 
-	cpu = of_find_compatible_node(NULL, NULL, "opencores,or1200-rtlsvn481");
+	cpu = setup_find_cpu_node(cpu_id);
 	if (!cpu)
-		panic("No compatible CPU found in device tree...\n");
+		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
 
 	iccfgr = mfspr(SPR_ICCFGR);
-	cpuinfo.icache_ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
+	cpuinfo->icache_ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
 	cache_set_size = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
-	cpuinfo.icache_block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
-	cpuinfo.icache_size =
-	    cache_set_size * cpuinfo.icache_ways * cpuinfo.icache_block_size;
+	cpuinfo->icache_block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
+	cpuinfo->icache_size =
+	    cache_set_size * cpuinfo->icache_ways * cpuinfo->icache_block_size;
 
 	dccfgr = mfspr(SPR_DCCFGR);
-	cpuinfo.dcache_ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
+	cpuinfo->dcache_ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
 	cache_set_size = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
-	cpuinfo.dcache_block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
-	cpuinfo.dcache_size =
-	    cache_set_size * cpuinfo.dcache_ways * cpuinfo.dcache_block_size;
+	cpuinfo->dcache_block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
+	cpuinfo->dcache_size =
+	    cache_set_size * cpuinfo->dcache_ways * cpuinfo->dcache_block_size;
 
 	if (of_property_read_u32(cpu, "clock-frequency",
-				 &cpuinfo.clock_frequency)) {
+				 &cpuinfo->clock_frequency)) {
 		printk(KERN_WARNING
 		       "Device tree missing CPU 'clock-frequency' parameter."
 		       "Assuming frequency 25MHZ"
 		       "This is probably not what you want.");
 	}
 
+	cpuinfo->coreid = mfspr(SPR_COREID);
+
 	of_node_put(cpu);
 
 	print_cpuinfo();
@@ -251,8 +272,8 @@ void __init detect_unit_config(unsigned long upr, unsigned long mask,
 void calibrate_delay(void)
 {
 	const int *val;
-	struct device_node *cpu = NULL;
-	cpu = of_find_compatible_node(NULL, NULL, "opencores,or1200-rtlsvn481");
+	struct device_node *cpu = setup_find_cpu_node(smp_processor_id());
+
 	val = of_get_property(cpu, "clock-frequency", NULL);
 	if (!val)
 		panic("no cpu 'clock-frequency' parameter in device tree");
@@ -268,6 +289,10 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_cpuinfo();
 
+#ifdef CONFIG_SMP
+	smp_init_cpus();
+#endif
+
 	/* process 1's initial memory region is the kernel code/data */
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long)_etext;
@@ -302,54 +327,78 @@ void __init setup_arch(char **cmdline_p)
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	unsigned long vr;
-	int version, revision;
+	unsigned int vr, cpucfgr;
+	unsigned int avr;
+	unsigned int version;
+	struct cpuinfo_or1k *cpuinfo = v;
 
 	vr = mfspr(SPR_VR);
-	version = (vr & SPR_VR_VER) >> 24;
-	revision = vr & SPR_VR_REV;
-
-	seq_printf(m,
-		  "cpu\t\t: OpenRISC-%x\n"
-		  "revision\t: %d\n"
-		  "frequency\t: %ld\n"
-		  "dcache size\t: %d bytes\n"
-		  "dcache block size\t: %d bytes\n"
-		  "dcache ways\t: %d\n"
-		  "icache size\t: %d bytes\n"
-		  "icache block size\t: %d bytes\n"
-		  "icache ways\t: %d\n"
-		  "immu\t\t: %d entries, %lu ways\n"
-		  "dmmu\t\t: %d entries, %lu ways\n"
-		  "bogomips\t: %lu.%02lu\n",
-		  version,
-		  revision,
-		  loops_per_jiffy * HZ,
-		  cpuinfo.dcache_size,
-		  cpuinfo.dcache_block_size,
-		  cpuinfo.dcache_ways,
-		  cpuinfo.icache_size,
-		  cpuinfo.icache_block_size,
-		  cpuinfo.icache_ways,
-		  1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
-		  1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW),
-		  1 << ((mfspr(SPR_IMMUCFGR) & SPR_IMMUCFGR_NTS) >> 2),
-		  1 + (mfspr(SPR_IMMUCFGR) & SPR_IMMUCFGR_NTW),
-		  (loops_per_jiffy * HZ) / 500000,
-		  ((loops_per_jiffy * HZ) / 5000) % 100);
+	cpucfgr = mfspr(SPR_CPUCFGR);
+
+#ifdef CONFIG_SMP
+	seq_printf(m, "processor\t\t: %d\n", cpuinfo->coreid);
+#endif
+	if (vr & SPR_VR_UVRP) {
+		vr = mfspr(SPR_VR2);
+		version = vr & SPR_VR2_VER;
+		avr = mfspr(SPR_AVR);
+		seq_printf(m, "cpu architecture\t: "
+			   "OpenRISC 1000 (%d.%d-rev%d)\n",
+			   (avr >> 24) & 0xff,
+			   (avr >> 16) & 0xff,
+			   (avr >> 8) & 0xff);
+		seq_printf(m, "cpu implementation id\t: 0x%x\n",
+			   (vr & SPR_VR2_CPUID) >> 24);
+		seq_printf(m, "cpu version\t\t: 0x%x\n", version);
+	} else {
+		version = (vr & SPR_VR_VER) >> 24;
+		seq_printf(m, "cpu\t\t\t: OpenRISC-%x\n", version);
+		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
+	}
+	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
+	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
+	seq_printf(m, "dcache block size\t: %d bytes\n",
+		   cpuinfo->dcache_block_size);
+	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
+	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
+	seq_printf(m, "icache block size\t: %d bytes\n",
+		   cpuinfo->icache_block_size);
+	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
+	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
+		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
+		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
+	seq_printf(m, "dmmu\t\t\t: %d entries, %lu ways\n",
+		   1 << ((mfspr(SPR_IMMUCFGR) & SPR_IMMUCFGR_NTS) >> 2),
+		   1 + (mfspr(SPR_IMMUCFGR) & SPR_IMMUCFGR_NTW));
+	seq_printf(m, "bogomips\t\t: %lu.%02lu\n",
+		   (loops_per_jiffy * HZ) / 500000,
+		   ((loops_per_jiffy * HZ) / 5000) % 100);
+
+	seq_puts(m, "features\t\t: ");
+	seq_printf(m, "%s ", cpucfgr & SPR_CPUCFGR_OB32S ? "orbis32" : "");
+	seq_printf(m, "%s ", cpucfgr & SPR_CPUCFGR_OB64S ? "orbis64" : "");
+	seq_printf(m, "%s ", cpucfgr & SPR_CPUCFGR_OF32S ? "orfpx32" : "");
+	seq_printf(m, "%s ", cpucfgr & SPR_CPUCFGR_OF64S ? "orfpx64" : "");
+	seq_printf(m, "%s ", cpucfgr & SPR_CPUCFGR_OV64S ? "orvdx64" : "");
+	seq_puts(m, "\n");
+
+	seq_puts(m, "\n");
+
 	return 0;
 }
 
-static void *c_start(struct seq_file *m, loff_t * pos)
+static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	/* We only have one CPU... */
-	return *pos < 1 ? (void *)1 : NULL;
+	*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	if ((*pos) < nr_cpu_ids)
+		return &cpuinfo_or1k[*pos];
+	return NULL;
 }
 
-static void *c_next(struct seq_file *m, void *v, loff_t * pos)
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	++*pos;
-	return NULL;
+	(*pos)++;
+	return c_start(m, pos);
 }
 
 static void c_stop(struct seq_file *m, void *v)
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
new file mode 100644
index 000000000000..fd724123229a
--- /dev/null
+++ b/arch/openrisc/kernel/smp.c
@@ -0,0 +1,235 @@
+/*
+ * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
+ *
+ * Based on arm64 and arc implementations
+ * Copyright (C) 2013 ARM Ltd.
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/irq.h>
+#include <asm/cpuinfo.h>
+#include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
+#include <asm/time.h>
+
+static void (*smp_cross_call)(const struct cpumask *, unsigned int);
+
+unsigned long secondary_release = -1;
+struct thread_info *secondary_thread_info;
+
+enum ipi_msg_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CALL_FUNC_SINGLE,
+};
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static void boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	secondary_release = cpu;
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+}
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+void __init smp_init_cpus(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated@the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+static DECLARE_COMPLETION(cpu_running);
+
+int __cpu_up(unsigned int cpu, struct task_struct *idle)
+{
+	if (smp_cross_call == NULL) {
+		pr_warn("CPU%u: failed to start, IPI controller missing",
+			cpu);
+		return -EIO;
+	}
+
+	secondary_thread_info = task_thread_info(idle);
+	current_pgd[cpu] = init_mm.pgd;
+
+	boot_secondary(cpu, idle);
+	if (!wait_for_completion_timeout(&cpu_running,
+					msecs_to_jiffies(1000))) {
+		pr_crit("CPU%u: failed to start\n", cpu);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+asmlinkage __init void secondary_start_kernel(void)
+{
+	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
+	/*
+	 * All kernel threads share the same mm context; grab a
+	 * reference and switch to it.
+	 */
+	atomic_inc(&mm->mm_count);
+	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+	pr_info("CPU%u: Booted secondary processor\n", cpu);
+
+	setup_cpuinfo();
+	openrisc_clockevent_init();
+
+	notify_cpu_starting(cpu);
+
+	/*
+	 * OK, now it's safe to let the boot CPU continue
+	 */
+	set_cpu_online(cpu, true);
+	complete(&cpu_running);
+
+	local_irq_enable();
+
+	/*
+	 * OK, it's off to the idle thread for us
+	 */
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
+
+void handle_IPI(unsigned int ipi_msg)
+{
+	unsigned int cpu = smp_processor_id();
+
+	switch (ipi_msg) {
+	case IPI_RESCHEDULE:
+		scheduler_ipi();
+		break;
+
+	case IPI_CALL_FUNC:
+		generic_smp_call_function_interrupt();
+		break;
+
+	case IPI_CALL_FUNC_SINGLE:
+		generic_smp_call_function_single_interrupt();
+		break;
+
+	default:
+		WARN(1, "CPU%u: Unknown IPI message 0x%x\n", cpu, ipi_msg);
+		break;
+	}
+}
+
+void smp_send_reschedule(int cpu)
+{
+	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+static void stop_this_cpu(void *dummy)
+{
+	/* Remove this CPU */
+	set_cpu_online(smp_processor_id(), false);
+
+	local_irq_disable();
+	/* CPU Doze */
+	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
+		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
+	/* If that didn't work, infinite loop */
+	while (1)
+		;
+}
+
+void smp_send_stop(void)
+{
+	smp_call_function(stop_this_cpu, NULL, 0);
+}
+
+/* not supported, yet */
+int setup_profiling_timer(unsigned int multiplier)
+{
+	return -EINVAL;
+}
+
+void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
+{
+	smp_cross_call = fn;
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	smp_cross_call(mask, IPI_CALL_FUNC);
+}
+
+/* TLB flush operations - Performed on each CPU*/
+static inline void ipi_flush_tlb_all(void *ignored)
+{
+	local_flush_tlb_all();
+}
+
+void flush_tlb_all(void)
+{
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+}
+
+/*
+ * FIXME: implement proper functionality instead of flush_tlb_all.
+ * *But*, as things currently stands, the local_tlb_flush_* functions will
+ * all boil down to local_tlb_flush_all anyway.
+ */
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+{
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
+{
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+}
diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index 687c11d048d7..ab04eaedbf8d 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -53,13 +53,32 @@ static int openrisc_timer_set_next_event(unsigned long delta,
  * timers) we cannot enable the PERIODIC feature.  The tick timer can run using
  * one-shot events, so no problem.
  */
+DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
 
-static struct clock_event_device clockevent_openrisc_timer = {
-	.name = "openrisc_timer_clockevent",
-	.features = CLOCK_EVT_FEAT_ONESHOT,
-	.rating = 300,
-	.set_next_event = openrisc_timer_set_next_event,
-};
+void openrisc_clockevent_init(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *evt =
+		&per_cpu(clockevent_openrisc_timer, cpu);
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu];
+
+	mtspr(SPR_TTMR, SPR_TTMR_CR);
+
+#ifdef CONFIG_SMP
+	evt->broadcast = tick_broadcast;
+#endif
+	evt->name = "openrisc_timer_clockevent",
+	evt->features = CLOCK_EVT_FEAT_ONESHOT,
+	evt->rating = 300,
+	evt->set_next_event = openrisc_timer_set_next_event,
+
+	evt->cpumask = cpumask_of(cpu);
+
+	/* We only have 28 bits */
+	clockevents_config_and_register(evt, cpuinfo->clock_frequency,
+					100, 0x0fffffff);
+
+}
 
 static inline void timer_ack(void)
 {
@@ -83,7 +102,9 @@ static inline void timer_ack(void)
 irqreturn_t __irq_entry timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct clock_event_device *evt = &clockevent_openrisc_timer;
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *evt =
+		&per_cpu(clockevent_openrisc_timer, cpu);
 
 	timer_ack();
 
@@ -99,24 +120,12 @@ irqreturn_t __irq_entry timer_interrupt(struct pt_regs *regs)
 	return IRQ_HANDLED;
 }
 
-static __init void openrisc_clockevent_init(void)
-{
-	clockevent_openrisc_timer.cpumask = cpumask_of(0);
-
-	/* We only have 28 bits */
-	clockevents_config_and_register(&clockevent_openrisc_timer,
-					cpuinfo.clock_frequency,
-					100, 0x0fffffff);
-
-}
-
 /**
  * Clocksource: Based on OpenRISC timer/counter
  *
  * This sets up the OpenRISC Tick Timer as a clock source.  The tick timer
  * is 32 bits wide and runs at the CPU clock frequency.
  */
-
 static u64 openrisc_timer_read(struct clocksource *cs)
 {
 	return (u64) mfspr(SPR_TTCR);
@@ -132,7 +141,9 @@ static struct clocksource openrisc_timer = {
 
 static int __init openrisc_timer_init(void)
 {
-	if (clocksource_register_hz(&openrisc_timer, cpuinfo.clock_frequency))
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+
+	if (clocksource_register_hz(&openrisc_timer, cpuinfo->clock_frequency))
 		panic("failed to register clocksource");
 
 	/* Enable the incrementer: 'continuous' mode with interrupt disabled */
diff --git a/arch/openrisc/lib/delay.c b/arch/openrisc/lib/delay.c
index 8b13fdf43ec6..a92bd621aa1f 100644
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -25,7 +25,7 @@
 
 int read_current_timer(unsigned long *timer_value)
 {
-	*timer_value = mfspr(SPR_TTCR);
+	*timer_value = get_cycles();
 	return 0;
 }
 
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index e310ab499385..d0021dfae20a 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -33,7 +33,7 @@ unsigned long pte_errors;	/* updated by do_page_fault() */
 /* __PHX__ :: - check the vmalloc_fault in do_page_fault()
  *            - also look into include/asm-or32/mmu_context.h
  */
-volatile pgd_t *current_pgd;
+volatile pgd_t *current_pgd[NR_CPUS];
 
 extern void die(char *, struct pt_regs *, long);
 
@@ -319,7 +319,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 		phx_mmu("vmalloc_fault");
 */
-		pgd = (pgd_t *)current_pgd + offset;
+		pgd = (pgd_t *)current_pgd[smp_processor_id()] + offset;
 		pgd_k = init_mm.pgd + offset;
 
 		/* Since we're two-level, we don't need to do both
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index f67d82b9d22f..6972d5d6f23f 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -147,7 +147,7 @@ void __init paging_init(void)
 	 * (even if it is most probably not used until the next
 	 *  switch_mm)
 	 */
-	current_pgd = init_mm.pgd;
+	current_pgd[smp_processor_id()] = init_mm.pgd;
 
 	end = (unsigned long)__va(max_low_pfn * PAGE_SIZE);
 
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 683bd4d31c7c..6c253a2e86bc 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -49,7 +49,7 @@
  *
  */
 
-void flush_tlb_all(void)
+void local_flush_tlb_all(void)
 {
 	int i;
 	unsigned long num_tlb_sets;
@@ -86,7 +86,7 @@ void flush_tlb_all(void)
 #define flush_itlb_page_no_eir(addr) \
 	mtspr_off(SPR_ITLBMR_BASE(0), ITLB_OFFSET(addr), 0);
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (have_dtlbeir)
 		flush_dtlb_page_eir(addr);
@@ -99,8 +99,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 		flush_itlb_page_no_eir(addr);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma,
-		     unsigned long start, unsigned long end)
+void local_flush_tlb_range(struct vm_area_struct *vma,
+			   unsigned long start, unsigned long end)
 {
 	int addr;
 	bool dtlbeir;
@@ -129,13 +129,13 @@ void flush_tlb_range(struct vm_area_struct *vma,
  * This should be changed to loop over over mm and call flush_tlb_range.
  */
 
-void flush_tlb_mm(struct mm_struct *mm)
+void local_flush_tlb_mm(struct mm_struct *mm)
 {
 
 	/* Was seeing bugs with the mm struct passed to us. Scrapped most of
 	   this function. */
 	/* Several architctures do this */
-	flush_tlb_all();
+	local_flush_tlb_all();
 }
 
 /* called in schedule() just before actually doing the switch_to */
@@ -149,14 +149,14 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 * might be invalid at points where we still need to derefer
 	 * the pgd.
 	 */
-	current_pgd = next->pgd;
+	current_pgd[smp_processor_id()] = next->pgd;
 
 	/* We don't have context support implemented, so flush all
 	 * entries belonging to previous map
 	 */
 
 	if (prev != next)
-		flush_tlb_mm(prev);
+		local_flush_tlb_mm(prev);
 
 }
 
-- 
2.13.6

