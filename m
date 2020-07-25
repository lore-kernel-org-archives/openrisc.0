From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Jul 2020 01:01:03 -0000
Subject: [OpenRISC] [PATCH] openrisc: Implement proper SMP tlb flushing
Message-ID: <20200725010049.693421-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Up until now when flushing pages from the TLB on SMP OpenRISC was always
resorting to flush the entire TLB on all CPUs.  This patch adds the
mechanics for flushing specific ranges and pages based on the usage.

The function switch_mm is updated to account for cpu usage by updating
mm_struct's cpumask.  This is used in the SMP flush routines.

This mostly follows the riscv implementation.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/smp.c | 85 ++++++++++++++++++++++++++++++++++----
 arch/openrisc/mm/tlb.c     | 17 +++++---
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index bd1e660bbc89..29c82ef2e207 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -219,30 +219,99 @@ static inline void ipi_flush_tlb_all(void *ignored)
 	local_flush_tlb_all();
 }
 
+static inline void ipi_flush_tlb_mm(void *info)
+{
+	struct mm_struct *mm = (struct mm_struct *)info;
+
+	local_flush_tlb_mm(mm);
+}
+
+static void smp_flush_tlb_mm(struct cpumask *cmask, struct mm_struct *mm)
+{
+	unsigned int cpuid;
+
+	if (cpumask_empty(cmask))
+		return;
+
+	cpuid = get_cpu();
+
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
+		/* local cpu is the only cpu present in cpumask */
+		local_flush_tlb_mm(mm);
+	} else {
+		on_each_cpu_mask(cmask, ipi_flush_tlb_mm, mm, 1);
+	}
+	put_cpu();
+}
+
+struct flush_tlb_data {
+	unsigned long addr1;
+	unsigned long addr2;
+};
+
+static inline void ipi_flush_tlb_page(void *info)
+{
+	struct flush_tlb_data *fd = (struct flush_tlb_data *)info;
+
+	local_flush_tlb_page(NULL, fd->addr1);
+}
+
+static inline void ipi_flush_tlb_range(void *info)
+{
+	struct flush_tlb_data *fd = (struct flush_tlb_data *)info;
+
+	local_flush_tlb_range(NULL, fd->addr1, fd->addr2);
+}
+
+static void smp_flush_tlb_range(struct cpumask *cmask, unsigned long start,
+				unsigned long end)
+{
+	unsigned int cpuid;
+
+	if (cpumask_empty(cmask))
+		return;
+
+	cpuid = get_cpu();
+
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
+		/* local cpu is the only cpu present in cpumask */
+		if ((end - start) <= PAGE_SIZE)
+			local_flush_tlb_page(NULL, start);
+		else
+			local_flush_tlb_range(NULL, start, end);
+	} else {
+		struct flush_tlb_data fd;
+
+		fd.addr1 = start;
+		fd.addr2 = end;
+
+		if ((end - start) <= PAGE_SIZE)
+			on_each_cpu_mask(cmask, ipi_flush_tlb_page, &fd, 1);
+		else
+			on_each_cpu_mask(cmask, ipi_flush_tlb_range, &fd, 1);
+	}
+	put_cpu();
+}
+
 void flush_tlb_all(void)
 {
 	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 }
 
-/*
- * FIXME: implement proper functionality instead of flush_tlb_all.
- * *But*, as things currently stands, the local_tlb_flush_* functions will
- * all boil down to local_tlb_flush_all anyway.
- */
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_flush_tlb_mm(mm_cpumask(mm), mm);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_flush_tlb_range(mm_cpumask(vma->vm_mm), uaddr, uaddr + PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma,
 		     unsigned long start, unsigned long end)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_flush_tlb_range(mm_cpumask(vma->vm_mm), start, end);
 }
 
 /* Instruction cache invalidate - performed on each cpu */
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 4b680aed8f5f..2b6feabf6381 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -137,21 +137,28 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *next_tsk)
 {
+	unsigned int cpu;
+
+	if (unlikely(prev == next))
+		return;
+
+	cpu = smp_processor_id();
+
+	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
 	/* remember the pgd for the fault handlers
 	 * this is similar to the pgd register in some other CPU's.
 	 * we need our own copy of it because current and active_mm
 	 * might be invalid at points where we still need to derefer
 	 * the pgd.
 	 */
-	current_pgd[smp_processor_id()] = next->pgd;
+	current_pgd[cpu] = next->pgd;
 
 	/* We don't have context support implemented, so flush all
 	 * entries belonging to previous map
 	 */
-
-	if (prev != next)
-		local_flush_tlb_mm(prev);
-
+	local_flush_tlb_mm(prev);
 }
 
 /*
-- 
2.26.2

