From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 12:15:55 +0900
Subject: [OpenRISC] [PATCH v3 08/13] openrisc: sleep instead of spin on
	secondary wait
In-Reply-To: <20171022031600.29612-1-shorne@gmail.com>
References: <20171022031600.29612-1-shorne@gmail.com>
Message-ID: <20171022031600.29612-9-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Currently we do a spin on secondary cpus when waiting to boot.  This
theoretically causes issues with power consumption and does cause issues
with qemu cycle burning (it starves cpu 0 from actually being able to
boot.)

This change puts each secondary cpu to sleep if they have a power
management unit, then signals them to wake via IPI when its time to boot.
If the cpus have no power management unit they will loop as before.

Note: The wakeup IPI requires a special interrupt handler as on secondary
cpu's the interrupt infrastructure is not yet established.  This
interrupt handler is set and reset by updating SPR_EVBAR.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since v2
 - none

Changes since v1
 - Check if power management exists before sleeping

 arch/openrisc/kernel/head.S | 51 +++++++++++++++++++++++++++++++++++++++++++--
 arch/openrisc/kernel/smp.c  |  5 +++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index a9972dc103f8..fb02b2a1d6f2 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -712,9 +712,45 @@ _flush_tlb:
 
 #ifdef CONFIG_SMP
 secondary_wait:
+	/* Doze the cpu until we are asked to run */
+	/* If we dont have power management skip doze */
+	l.mfspr r25,r0,SPR_UPR
+	l.andi  r25,r25,SPR_UPR_PMP
+	l.sfeq  r25,r0
+	l.bf	secondary_check_release
+	 l.nop
+
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
+secondary_check_release:
+	/*
+	 * Check if we actually got the release signal, if not go-back to
+	 * sleep.
+	 */
 	l.mfspr	r25,r0,SPR_COREID
-	l.movhi	r3,hi(secondary_release)
-	l.ori	r3,r3,lo(secondary_release)
+	LOAD_SYMBOL_2_GPR(r3, secondary_release)
 	tophys(r4, r3)
 	l.lwz	r3,0(r4)
 	l.sfeq	r25,r3
@@ -1663,6 +1699,17 @@ ENTRY(_early_uart_init)
 	l.jr	r9
 	l.nop
 
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
index 154c94a0cfbc..685b4934fa39 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -26,6 +26,7 @@ unsigned long secondary_release = -1;
 struct thread_info *secondary_thread_info;
 
 enum ipi_msg_type {
+	IPI_WAKEUP,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
@@ -42,6 +43,7 @@ static void boot_secondary(unsigned int cpu, struct task_struct *idle)
 	spin_lock(&boot_lock);
 
 	secondary_release = cpu;
+	smp_cross_call(cpumask_of(cpu), IPI_WAKEUP);
 
 	/*
 	 * now the secondary core is starting up let it run its
@@ -140,6 +142,9 @@ void handle_IPI(unsigned int ipi_msg)
 	unsigned int cpu = smp_processor_id();
 
 	switch (ipi_msg) {
+	case IPI_WAKEUP:
+		break;
+
 	case IPI_RESCHEDULE:
 		scheduler_ipi();
 		break;
-- 
2.13.6

