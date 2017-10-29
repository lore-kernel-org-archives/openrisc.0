From: Stafford Horne <shorne@gmail.com>
Date: Mon, 30 Oct 2017 08:11:23 +0900
Subject: [OpenRISC] [PATCH v4 13/13] openrisc: add tick timer multi-core
	sync logic
In-Reply-To: <20171029231123.27281-1-shorne@gmail.com>
References: <20171029231123.27281-1-shorne@gmail.com>
Message-ID: <20171029231123.27281-14-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In case timers are not in sync when cpus start (i.e. hot plug / offset
resets) we need to synchronize the secondary cpus internal timer with
the main cpu.  This is needed as in OpenRISC SMP there is only one
clocksource registered which reads from the same ttcr register on each
cpu.

This synchronization routine heavily borrows from mips implementation that
does something similar.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since v2
 - none

Changes since v1
 - change from timer-sync.h header to just time.h

 arch/openrisc/include/asm/time.h  |   8 +++
 arch/openrisc/kernel/Makefile     |   2 +-
 arch/openrisc/kernel/smp.c        |   3 +
 arch/openrisc/kernel/sync-timer.c | 120 ++++++++++++++++++++++++++++++++++++++
 arch/openrisc/kernel/time.c       |  15 ++++-
 5 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 arch/openrisc/kernel/sync-timer.c

diff --git a/arch/openrisc/include/asm/time.h b/arch/openrisc/include/asm/time.h
index fe83a34a7d68..313ee975774b 100644
--- a/arch/openrisc/include/asm/time.h
+++ b/arch/openrisc/include/asm/time.h
@@ -12,4 +12,12 @@
 
 extern void openrisc_clockevent_init(void);
 
+extern void openrisc_timer_set(unsigned long count);
+extern void openrisc_timer_set_next(unsigned long delta);
+
+#ifdef CONFIG_SMP
+extern void synchronise_count_master(int cpu);
+extern void synchronise_count_slave(int cpu);
+#endif
+
 #endif /* __ASM_OR1K_TIME_H */
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index b4b51a07016a..9028e5a1fdd7 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y	:= setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
 	   sys_call_table.o unwinder.o
 
-obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 4763b8b9161e..4d80ce6fa045 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -100,6 +100,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_crit("CPU%u: failed to start\n", cpu);
 		return -EIO;
 	}
+	synchronise_count_master(cpu);
 
 	return 0;
 }
@@ -129,6 +130,8 @@ asmlinkage __init void secondary_start_kernel(void)
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
+	synchronise_count_slave(cpu);
+
 	local_irq_enable();
 
 	preempt_disable();
diff --git a/arch/openrisc/kernel/sync-timer.c b/arch/openrisc/kernel/sync-timer.c
new file mode 100644
index 000000000000..ed8d835caca1
--- /dev/null
+++ b/arch/openrisc/kernel/sync-timer.c
@@ -0,0 +1,120 @@
+/*
+ * OR1K timer synchronisation
+ *
+ * Based on work from MIPS implementation.
+ *
+ * All CPUs will have their count registers synchronised to the CPU0 next time
+ * value. This can cause a small timewarp for CPU0. All other CPU's should
+ * not have done anything significant (but they may have had interrupts
+ * enabled briefly - prom_smp_finish() should not be responsible for enabling
+ * interrupts...)
+ */
+
+#include <linux/kernel.h>
+#include <linux/irqflags.h>
+#include <linux/cpumask.h>
+
+#include <asm/time.h>
+#include <asm/timex.h>
+#include <linux/atomic.h>
+#include <asm/barrier.h>
+
+#include <asm/spr.h>
+
+static unsigned int initcount;
+static atomic_t count_count_start = ATOMIC_INIT(0);
+static atomic_t count_count_stop = ATOMIC_INIT(0);
+
+#define COUNTON 100
+#define NR_LOOPS 3
+
+void synchronise_count_master(int cpu)
+{
+	int i;
+	unsigned long flags;
+
+	pr_info("Synchronize counters for CPU %u: ", cpu);
+
+	local_irq_save(flags);
+
+	/*
+	 * We loop a few times to get a primed instruction cache,
+	 * then the last pass is more or less synchronised and
+	 * the master and slaves each set their cycle counters to a known
+	 * value all at once. This reduces the chance of having random offsets
+	 * between the processors, and guarantees that the maximum
+	 * delay between the cycle counters is never bigger than
+	 * the latency of information-passing (cachelines) between
+	 * two CPUs.
+	 */
+
+	for (i = 0; i < NR_LOOPS; i++) {
+		/* slaves loop on '!= 2' */
+		while (atomic_read(&count_count_start) != 1)
+			mb();
+		atomic_set(&count_count_stop, 0);
+		smp_wmb();
+
+		/* Let the slave writes its count register */
+		atomic_inc(&count_count_start);
+
+		/* Count will be initialised to current timer */
+		if (i == 1)
+			initcount = get_cycles();
+
+		/*
+		 * Everyone initialises count in the last loop:
+		 */
+		if (i == NR_LOOPS-1)
+			openrisc_timer_set(initcount);
+
+		/*
+		 * Wait for slave to leave the synchronization point:
+		 */
+		while (atomic_read(&count_count_stop) != 1)
+			mb();
+		atomic_set(&count_count_start, 0);
+		smp_wmb();
+		atomic_inc(&count_count_stop);
+	}
+	/* Arrange for an interrupt in a short while */
+	openrisc_timer_set_next(COUNTON);
+
+	local_irq_restore(flags);
+
+	/*
+	 * i386 code reported the skew here, but the
+	 * count registers were almost certainly out of sync
+	 * so no point in alarming people
+	 */
+	pr_cont("done.\n");
+}
+
+void synchronise_count_slave(int cpu)
+{
+	int i;
+
+	/*
+	 * Not every cpu is online@the time this gets called,
+	 * so we first wait for the master to say everyone is ready
+	 */
+
+	for (i = 0; i < NR_LOOPS; i++) {
+		atomic_inc(&count_count_start);
+		while (atomic_read(&count_count_start) != 2)
+			mb();
+
+		/*
+		 * Everyone initialises count in the last loop:
+		 */
+		if (i == NR_LOOPS-1)
+			openrisc_timer_set(initcount);
+
+		atomic_inc(&count_count_stop);
+		while (atomic_read(&count_count_stop) != 2)
+			mb();
+	}
+	/* Arrange for an interrupt in a short while */
+	openrisc_timer_set_next(COUNTON);
+}
+#undef NR_LOOPS
diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index ab04eaedbf8d..6baecea27080 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -27,8 +27,14 @@
 
 #include <asm/cpuinfo.h>
 
-static int openrisc_timer_set_next_event(unsigned long delta,
-					 struct clock_event_device *dev)
+/* Test the timer ticks to count, used in sync routine */
+inline void openrisc_timer_set(unsigned long count)
+{
+	mtspr(SPR_TTCR, count);
+}
+
+/* Set the timer to trigger in delta cycles */
+inline void openrisc_timer_set_next(unsigned long delta)
 {
 	u32 c;
 
@@ -44,7 +50,12 @@ static int openrisc_timer_set_next_event(unsigned long delta,
 	 * Keep timer in continuous mode always.
 	 */
 	mtspr(SPR_TTMR, SPR_TTMR_CR | SPR_TTMR_IE | c);
+}
 
+static int openrisc_timer_set_next_event(unsigned long delta,
+					 struct clock_event_device *dev)
+{
+	openrisc_timer_set_next(delta);
 	return 0;
 }
 
-- 
2.13.6

