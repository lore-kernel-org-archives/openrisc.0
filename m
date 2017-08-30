From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 07:02:28 +0900
Subject: [OpenRISC] [PATCH 08/13] openrisc: sleep instead of spin on
	secondary wait
In-Reply-To: <cover.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
Message-ID: <b900ffaef91ef932fa375786b027b89d91d3b295.1504129273.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Currently we do a spin on secondary cpus when waiting to boot.  This causes
issues with power consumption as well as qemu cycle burning (it starves
cpu 0 from actually being able to boot.)

The secondary interrupt handler is stored in the init section so as to
allow it to be reclaimed after boot.  However, if we ever want to
support hotplug this may need to change.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 44 ++++++++++++++++++++++++++++++++++++++++++--
 arch/openrisc/kernel/smp.c  |  9 +++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index a9972dc103f8..ea065e091bd5 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -712,9 +712,37 @@ _flush_tlb:
 
 #ifdef CONFIG_SMP
 secondary_wait:
+	/* Doze the cpu until we are asked to run */
+	/* Setup special secondary exception handler */
+	LOAD_SYMBOL_2_GPR(r3, _secondary_evbar)
+	tophys(r25,r3)
+	l.mtspr	r0,r25,SPR_EVBAR
+
+	/* Enable Interrupts */
+	l.mfspr	r25,r0,SPR_SR
+	l.ori	r25,r25,SPR_SR_IEE
+	l.mtspr	r0,r25,SPR_SR
+
+	/* Unmask interrupts interrupts */
+	l.mfspr r25,r0,SPR_PICMR
+	l.ori   r25,r25,0xffff
+	l.mtspr	r0,r25,SPR_PICMR
+
+	/* Doze */
+	l.mfspr r25,r0,SPR_PMR
+	LOAD_SYMBOL_2_GPR(r3, SPR_PMR_DME)
+	l.or    r25,r25,r3
+	l.mtspr r0,r25,SPR_PMR
+
+	/* Wakeup - Restore exception handler */
+	l.mtspr	r0,r0,SPR_EVBAR
+
+	/*
+	 * Check if we actually got the wake signal, if not go-back to
+	 * sleep.
+	 */
 	l.mfspr	r25,r0,SPR_COREID
-	l.movhi	r3,hi(secondary_release)
-	l.ori	r3,r3,lo(secondary_release)
+	LOAD_SYMBOL_2_GPR(r3, secondary_release)
 	tophys(r4, r3)
 	l.lwz	r3,0(r4)
 	l.sfeq	r25,r3
@@ -1663,6 +1691,18 @@ ENTRY(_early_uart_init)
 	l.jr	r9
 	l.nop
 
+	.section .init.text, "ax"
+	.align	0x1000
+	.global _secondary_evbar
+_secondary_evbar:
+
+	.space 0x800
+	/* Just disable interrupts and Return */
+	l.ori	r3,r0,SPR_SR_SM
+	l.mtspr	r0,r3,SPR_ESR_BASE
+	l.rfe
+
+
 	.section .rodata
 _string_unhandled_exception:
 	.string "\n\rRunarunaround: Unhandled exception 0x\0"
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 24f7aa45b0ba..7696f9274608 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -18,10 +18,13 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
+static void (*smp_cross_call)(const struct cpumask *, unsigned int);
+
 volatile unsigned long secondary_release = -1;
 struct thread_info *secondary_thread_info;
 
 enum ipi_msg_type {
+	IPI_WAKEUP,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
@@ -38,6 +41,7 @@ static int boot_secondary(unsigned int cpu, struct task_struct *idle)
 	spin_lock(&boot_lock);
 
 	secondary_release = cpu;
+	smp_cross_call(cpumask_of(cpu), IPI_WAKEUP);
 
 	/*
 	 * now the secondary core is starting up let it run its
@@ -137,6 +141,9 @@ void handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	switch (ipinr) {
+	case IPI_WAKEUP:
+		break;
+
 	case IPI_RESCHEDULE:
 		scheduler_ipi();
 		break;
@@ -155,8 +162,6 @@ void handle_IPI(int ipinr)
 	}
 }
 
-static void (*smp_cross_call)(const struct cpumask *, unsigned int);
-
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
-- 
2.13.5

