From: Stafford Horne <shorne@gmail.com>
Date: Sun, 10 Sep 2017 15:49:24 +0900
Subject: [OpenRISC] [PATCH v2 12/14] openrisc: support framepointers and
	STACKTRACE_SUPPORT
In-Reply-To: <20170910064926.5874-1-shorne@gmail.com>
References: <20170910064926.5874-1-shorne@gmail.com>
Message-ID: <20170910064926.5874-13-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

For lockdep support a reliable stack trace mechanism is needed.  This
patch adds support in OpenRISC for the stacktrace framework, implemented
by a simple unwinder api.  The unwinder api supports both framepointer
and basic stack tracing.

The unwinder is now used to replace the stack_dump() implementation as
well. The new traces are inline with other architectures trace format:

 Call trace:
 [<c0004448>] show_stack+0x3c/0x58
 [<c031c940>] dump_stack+0xa8/0xe4
 [<c0008104>] __cpu_up+0x64/0x130
 [<c000d268>] bringup_cpu+0x3c/0x178
 [<c000d038>] cpuhp_invoke_callback+0xa8/0x1fc
 [<c000d680>] cpuhp_up_callbacks+0x44/0x14c
 [<c000e400>] cpu_up+0x14c/0x1bc
 [<c041da60>] smp_init+0x104/0x15c
 [<c033843c>] ? kernel_init+0x0/0x140
 [<c0415e04>] kernel_init_freeable+0xbc/0x25c
 [<c033843c>] ? kernel_init+0x0/0x140
 [<c0338458>] kernel_init+0x1c/0x140
 [<c003a174>] ? schedule_tail+0x18/0xa0
 [<c0006b80>] ret_from_fork+0x1c/0x9c

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig                |   4 ++
 arch/openrisc/include/asm/unwinder.h |  20 +++++++
 arch/openrisc/kernel/Makefile        |   3 +-
 arch/openrisc/kernel/stacktrace.c    |  86 ++++++++++++++++++++++++++++
 arch/openrisc/kernel/traps.c         |  54 +++---------------
 arch/openrisc/kernel/unwinder.c      | 105 +++++++++++++++++++++++++++++++++++
 6 files changed, 224 insertions(+), 48 deletions(-)
 create mode 100644 arch/openrisc/include/asm/unwinder.h
 create mode 100644 arch/openrisc/kernel/stacktrace.c
 create mode 100644 arch/openrisc/kernel/unwinder.c

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index bfff04ae7f7d..399f55e82dcb 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -33,6 +33,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
+	select ARCH_WANT_FRAME_POINTERS
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -60,6 +61,9 @@ config TRACE_IRQFLAGS_SUPPORT
 config GENERIC_CSUM
         def_bool y
 
+config STACKTRACE_SUPPORT
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/openrisc/include/asm/unwinder.h b/arch/openrisc/include/asm/unwinder.h
new file mode 100644
index 000000000000..165ec6f02ab8
--- /dev/null
+++ b/arch/openrisc/include/asm/unwinder.h
@@ -0,0 +1,20 @@
+/*
+ * OpenRISC unwinder.h
+ *
+ * Architecture API for unwinding stacks.
+ *
+ * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_OPENRISC_UNWINDER_H
+#define __ASM_OPENRISC_UNWINDER_H
+
+void unwind_stack(void *data, unsigned long *stack,
+		  void (*trace)(void *data, unsigned long addr,
+				int reliable));
+
+#endif /* __ASM_OPENRISC_UNWINDER_H */
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 7d94643c878d..b4b51a07016a 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -6,9 +6,10 @@ extra-y	:= head.o vmlinux.lds
 
 obj-y	:= setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
-	   sys_call_table.o
+	   sys_call_table.o unwinder.o
 
 obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
 
diff --git a/arch/openrisc/kernel/stacktrace.c b/arch/openrisc/kernel/stacktrace.c
new file mode 100644
index 000000000000..43f140a28bc7
--- /dev/null
+++ b/arch/openrisc/kernel/stacktrace.c
@@ -0,0 +1,86 @@
+/*
+ * Stack trace utility for OpenRISC
+ *
+ * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Losely based on work from sh and powerpc.
+ */
+
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/stacktrace.h>
+
+#include <asm/processor.h>
+#include <asm/unwinder.h>
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+static void
+save_stack_address(void *data, unsigned long addr, int reliable)
+{
+	struct stack_trace *trace = data;
+
+	if (!reliable)
+		return;
+
+	if (trace->skip > 0) {
+		trace->skip--;
+		return;
+	}
+
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = addr;
+}
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	unwind_stack(trace, (unsigned long *) &trace, save_stack_address);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+static void
+save_stack_address_nosched(void *data, unsigned long addr, int reliable)
+{
+	struct stack_trace *trace = (struct stack_trace *)data;
+
+	if (!reliable)
+		return;
+
+	if (in_sched_functions(addr))
+		return;
+
+	if (trace->skip > 0) {
+		trace->skip--;
+		return;
+	}
+
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = addr;
+}
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	unsigned long *sp = NULL;
+
+	if (tsk == current)
+		sp = (unsigned long *) &sp;
+	else
+		sp = (unsigned long *) KSTK_ESP(tsk);
+
+	unwind_stack(trace, sp, save_stack_address_nosched);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void
+save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+{
+	unwind_stack(trace, (unsigned long *) regs->sp,
+		     save_stack_address_nosched);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_regs);
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 803e9e756f77..4085d72fa5ae 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -38,6 +38,7 @@
 #include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/unwinder.h>
 
 extern char _etext, _stext;
 
@@ -45,61 +46,20 @@ int kstack_depth_to_print = 0x180;
 int lwa_flag;
 unsigned long __user *lwa_addr;
 
-static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+void print_trace(void *data, unsigned long addr, int reliable)
 {
-	return p > (void *)tinfo && p < (void *)tinfo + THREAD_SIZE - 3;
-}
-
-void show_trace(struct task_struct *task, unsigned long *stack)
-{
-	struct thread_info *context;
-	unsigned long addr;
-
-	context = (struct thread_info *)
-	    ((unsigned long)stack & (~(THREAD_SIZE - 1)));
-
-	while (valid_stack_ptr(context, stack)) {
-		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			printk(" [<%08lx>]", addr);
-			print_symbol(" %s", addr);
-			printk("\n");
-		}
-	}
-	printk(" =======================\n");
+	pr_emerg("[<%p>] %s%pS\n", (void *) addr, reliable ? "" : "? ",
+	       (void *) addr);
 }
 
 /* displays a short stack trace */
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
-	unsigned long addr, *stack;
-	int i;
-
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
 
-	stack = esp;
-
-	printk("Stack dump [0x%08lx]:\n", (unsigned long)esp);
-	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (kstack_end(stack))
-			break;
-		if (__get_user(addr, stack)) {
-			/* This message matches "failing address" marked
-			   s390 in ksymoops, so lines containing it will
-			   not be filtered out by ksymoops.  */
-			printk("Failing address 0x%lx\n", (unsigned long)stack);
-			break;
-		}
-		stack++;
-
-		printk("sp + %02d: 0x%08lx\n", i * 4, addr);
-	}
-	printk("\n");
-
-	show_trace(task, esp);
-
-	return;
+	pr_emerg("Call trace:\n");
+	unwind_stack(NULL, esp, print_trace);
 }
 
 void show_trace_task(struct task_struct *tsk)
@@ -115,7 +75,7 @@ void show_registers(struct pt_regs *regs)
 	int in_kernel = 1;
 	unsigned long esp;
 
-	esp = (unsigned long)(&regs->sp);
+	esp = (unsigned long)(regs->sp);
 	if (user_mode(regs))
 		in_kernel = 0;
 
diff --git a/arch/openrisc/kernel/unwinder.c b/arch/openrisc/kernel/unwinder.c
new file mode 100644
index 000000000000..8ae15c2c1845
--- /dev/null
+++ b/arch/openrisc/kernel/unwinder.c
@@ -0,0 +1,105 @@
+/*
+ * OpenRISC unwinder.c
+ *
+ * Reusable arch specific api for unwinding stacks.
+ *
+ * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/sched/task_stack.h>
+#include <linux/kernel.h>
+
+#include <asm/unwinder.h>
+
+#ifdef CONFIG_FRAME_POINTER
+struct or1k_frameinfo {
+	unsigned long *fp;
+	unsigned long ra;
+	unsigned long top;
+};
+
+/*
+ * Verify a frameinfo structure.  The return address should be a valid text
+ * address.  The frame pointer may be null if its the last frame, otherwise
+ * the frame pointer should point to a location in the stack after the the
+ * top of the next frame up.
+ */
+static inline int or1k_frameinfo_valid(struct or1k_frameinfo *frameinfo)
+{
+	return (frameinfo->fp == NULL ||
+		(!kstack_end(frameinfo->fp) &&
+		 frameinfo->fp > &frameinfo->top)) &&
+	       __kernel_text_address(frameinfo->ra);
+}
+
+/*
+ * Create a stack trace doing scanning which is frame pointer aware. We can
+ * get reliable stack traces by matching the previously found frame
+ * pointer with the top of the stack address every time we find a valid
+ * or1k_frameinfo.
+ *
+ * Ideally the stack parameter will be passed as FP, but it can not be
+ * guaranteed.  Therefore we scan each address looking for the first sign
+ * of a return address.
+ *
+ * The OpenRISC stack frame looks something like the following.  The
+ * location SP is held in r1 and location FP is held in r2 when frame pointers
+ * enabled.
+ *
+ * SP   -> (top of stack)
+ *      -  (callee saved registers)
+ *      -  (local variables)
+ * FP-8 -> previous FP             \
+ * FP-4 -> return address          |- or1k_frameinfo
+ * FP   -> (previous top of stack) /
+ */
+void unwind_stack(void *data, unsigned long *stack,
+		  void (*trace)(void *data, unsigned long addr, int reliable))
+{
+	unsigned long *next_fp = NULL;
+	struct or1k_frameinfo *frameinfo = NULL;
+	int reliable = 0;
+
+	while (!kstack_end(stack)) {
+		frameinfo = container_of(stack,
+					 struct or1k_frameinfo,
+					 top);
+
+		if (__kernel_text_address(frameinfo->ra)) {
+			if (or1k_frameinfo_valid(frameinfo) &&
+			    (next_fp == NULL ||
+			     next_fp == &frameinfo->top)) {
+				reliable = 1;
+				next_fp = frameinfo->fp;
+			} else
+				reliable = 0;
+
+			trace(data, frameinfo->ra, reliable);
+		}
+		stack++;
+	}
+}
+
+#else /* CONFIG_FRAME_POINTER */
+
+/*
+ * Create a stack trace by doing a simple scan treating all text addresses
+ * as return addresses.
+ */
+void unwind_stack(void *data, unsigned long *stack,
+		   void (*trace)(void *data, unsigned long addr, int reliable))
+{
+	unsigned long addr;
+
+	while (!kstack_end(stack)) {
+		addr = *stack++;
+		if (__kernel_text_address(addr))
+			trace(data, addr, 0);
+	}
+}
+#endif /* CONFIG_FRAME_POINTER */
+
-- 
2.13.5

