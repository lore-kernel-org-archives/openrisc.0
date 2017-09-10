From: Stafford Horne <shorne@gmail.com>
Date: Sun, 10 Sep 2017 15:49:25 +0900
Subject: [OpenRISC] [PATCH v2 13/14] openrisc: enable LOCKDEP_SUPPORT and
	irqflags tracing
In-Reply-To: <20170910064926.5874-1-shorne@gmail.com>
References: <20170910064926.5874-1-shorne@gmail.com>
Message-ID: <20170910064926.5874-14-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Lockdep is needed for proving the spinlocks and rwlocks work fine on our
platform.  It also requires calling the trace_hardirqs_off() and
trace_hardirqs_on() pair of routines when entering and exiting an
interrupt.

For OpenRISC the interrupt stack frame does not support frame pointers,
so to call trace_hardirqs_on() and trace_hardirqs_off() here the macro's
build up a stack frame each time.

There is one necessary small change in _sys_call_handler to move
interrupt enabling later so they can get re-enabled during syscall
restart. This was done to fix lockdep warnings that are now possible due
to this
patch.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig        |  3 ++
 arch/openrisc/kernel/entry.S | 74 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 399f55e82dcb..f8cfb3ba9e89 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -64,6 +64,9 @@ config GENERIC_CSUM
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config LOCKDEP_SUPPORT
+	def_bool  y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 1b7160c79646..690d55272ba6 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -42,6 +42,61 @@
 
 /* =========================================================[ macros ]=== */
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+/*
+ * Trace irq on/off creating a stack frame.
+ */
+#define TRACE_IRQS_OP(trace_op)					\
+	l.sw 	-8(r1),r2	/* store frame pointer */		;\
+	l.sw	-4(r1),r9	/* store return address */		;\
+	l.addi	r2,r1,0		/* move sp to fp */			;\
+	l.jal	trace_op						;\
+	 l.addi	r1,r1,-8						;\
+	l.ori	r1,r2,0		/* restore sp */			;\
+	l.lwz	r9,-4(r1)	/* restore return address */		;\
+	l.lwz	r2,-8(r1)	/* restore fp */			;\
+/*
+ * Trace irq on/off and save registers we need that would otherwise be
+ * clobbered.
+ */
+#define TRACE_IRQS_SAVE(t1,trace_op)					\
+	l.sw	-12(r1),t1	/* save extra reg */			;\
+	l.sw 	-8(r1),r2	/* store frame pointer */		;\
+	l.sw	-4(r1),r9	/* store return address */		;\
+	l.addi	r2,r1,0		/* move sp to fp */			;\
+	l.jal	trace_op						;\
+	 l.addi	r1,r1,-12						;\
+	l.ori	r1,r2,0		/* restore sp */			;\
+	l.lwz	r9,-4(r1)	/* restore return address */		;\
+	l.lwz	r2,-8(r1)	/* restore fp */			;\
+	l.lwz	t1,-12(r1)	/* restore extra reg */
+
+#define TRACE_IRQS_OFF	TRACE_IRQS_OP(trace_hardirqs_off)
+#define TRACE_IRQS_ON	TRACE_IRQS_OP(trace_hardirqs_on)
+#define TRACE_IRQS_ON_SYSCALL						\
+	TRACE_IRQS_SAVE(r10,trace_hardirqs_on)				;\
+	l.lwz	r3,PT_GPR3(r1)						;\
+	l.lwz	r4,PT_GPR4(r1)						;\
+	l.lwz	r5,PT_GPR5(r1)						;\
+	l.lwz	r6,PT_GPR6(r1)						;\
+	l.lwz	r7,PT_GPR7(r1)						;\
+	l.lwz	r8,PT_GPR8(r1)						;\
+	l.lwz	r11,PT_GPR11(r1)
+#define TRACE_IRQS_OFF_ENTRY						\
+	l.lwz	r5,PT_SR(r1)						;\
+	l.andi	r3,r5,(SPR_SR_IEE|SPR_SR_TEE)				;\
+	l.sfeq	r5,r0		/* skip trace if irqs were already off */;\
+	l.bf	1f							;\
+	 l.nop								;\
+	TRACE_IRQS_SAVE(r4,trace_hardirqs_off)				;\
+1:
+#else
+#define TRACE_IRQS_OFF
+#define TRACE_IRQS_ON
+#define TRACE_IRQS_OFF_ENTRY
+#define TRACE_IRQS_ON_SYSCALL
+#endif
+
 /*
  * We need to disable interrupts at beginning of RESTORE_ALL
  * since interrupt might come in after we've loaded EPC return address
@@ -124,6 +179,7 @@ handler:							;\
 	/* r30 already save */					;\
 /*        l.sw    PT_GPR30(r1),r30*/					;\
 	l.sw    PT_GPR31(r1),r31					;\
+	TRACE_IRQS_OFF_ENTRY						;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30
@@ -557,9 +613,6 @@ _string_syscall_return:
 	.align 4
 
 ENTRY(_sys_call_handler)
-	/* syscalls run with interrupts enabled */
-	ENABLE_INTERRUPTS(r29)		// enable interrupts, r29 is temp
-
 	/* r1, EPCR, ESR a already saved */
 	l.sw	PT_GPR2(r1),r2
 	/* r3-r8 must be saved because syscall restart relies
@@ -597,6 +650,10 @@ ENTRY(_sys_call_handler)
 /*	l.sw    PT_GPR30(r1),r30 */
 
 _syscall_check_trace_enter:
+	/* syscalls run with interrupts enabled */
+	TRACE_IRQS_ON_SYSCALL
+	ENABLE_INTERRUPTS(r29)		// enable interrupts, r29 is temp
+
 	/* If TIF_SYSCALL_TRACE is set, then we want to do syscall tracing */
 	l.lwz	r30,TI_FLAGS(r10)
 	l.andi	r30,r30,_TIF_SYSCALL_TRACE
@@ -657,6 +714,7 @@ _syscall_check_trace_leave:
 _syscall_check_work:
 	/* Here we need to disable interrupts */
 	DISABLE_INTERRUPTS(r27,r29)
+	TRACE_IRQS_OFF
 	l.lwz	r30,TI_FLAGS(r10)
 	l.andi	r30,r30,_TIF_WORK_MASK
 	l.sfne	r30,r0
@@ -871,6 +929,7 @@ UNHANDLED_EXCEPTION(_vector_0x1f00,0x1f00)
 
 _resume_userspace:
 	DISABLE_INTERRUPTS(r3,r4)
+	TRACE_IRQS_OFF
 	l.lwz	r4,TI_FLAGS(r10)
 	l.andi	r13,r4,_TIF_WORK_MASK
 	l.sfeqi	r13,0
@@ -909,6 +968,15 @@ _work_pending:
 	 l.lwz	r8,PT_GPR8(r1)
 
 _restore_all:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	l.lwz	r4,PT_SR(r1)
+	l.andi	r3,r4,(SPR_SR_IEE|SPR_SR_TEE)
+	l.sfeq	r3,r0		/* skip trace if irqs were off */
+	l.bf	skip_hardirqs_on
+	 l.nop
+	TRACE_IRQS_ON
+skip_hardirqs_on:
+#endif
 	RESTORE_ALL
 	/* This returns to userspace code */
 
-- 
2.13.5

