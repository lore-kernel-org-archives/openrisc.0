From: Stafford Horne <shorne@gmail.com>
Date: Sun,  1 Jul 2018 16:47:02 +0900
Subject: [OpenRISC] [PATCH] openrisc: entry: Fix delay slot exception
	detection
Message-ID: <20180701074705.849-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Originally in patch e6d20c55a4 ("openrisc: entry: Fix delay slot
detection") I fixed delay slot detection, but only for QEMU.  We missed
that hardware delay slot detection using delay slot exception flag (DSX)
was still broken.  This was because QEMU set the DSX flag in both
pre-exception supervision register (ESR) and supervision register (SR)
register, but on real hardware the DSX flag is only set on the SR
register during exceptions.

Fix this by carrying the DSX flag into the SR register during exception.
We also update the DSX flag read locations to read the value from the SR
register not the pt_regs SR register which represents ESR.  The ESR
should never have the DSX flag set.

In the process I updated/removed a few comments to match the current
state.  Including removing a comment saying that the DSX detection logic
was inefficient and needed to be rewritten.

I have tested this on QEMU with a patch ensuring it matches the hardware
specification.

Link: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00000.html
Fixes: e6d20c55a4 ("openrisc: entry: Fix delay slot detection")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 8 +-------
 arch/openrisc/kernel/head.S  | 9 ++++++---
 arch/openrisc/kernel/traps.c | 2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 690d55272ba6..0c826ad6e994 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -277,12 +277,6 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 	l.addi  r3,r1,0                    // pt_regs
 	/* r4 set be EXCEPTION_HANDLE */   // effective address of fault
 
-	/*
-	 * __PHX__: TODO
-	 *
-	 * all this can be written much simpler. look at
-	 * DTLB miss handler in the CONFIG_GUARD_PROTECTED_CORE part
-	 */
 #ifdef CONFIG_OPENRISC_NO_SPR_SR_DSX
 	l.lwz   r6,PT_PC(r3)               // address of an offending insn
 	l.lwz   r6,0(r6)                   // instruction that caused pf
@@ -314,7 +308,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 
 #else
 
-	l.lwz   r6,PT_SR(r3)               // SR
+	l.mfspr r6,r0,SPR_SR               // SR
 	l.andi  r6,r6,SPR_SR_DSX           // check for delay slot exception
 	l.sfne  r6,r0                      // exception happened in delay slot
 	l.bnf   7f
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index fb02b2a1d6f2..9fc6b60140f0 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -210,8 +210,7 @@
  *	 r4  - EEAR     exception EA
  *	 r10 - current	pointing to current_thread_info struct
  *	 r12 - syscall  0, since we didn't come from syscall
- *	 r13 - temp	it actually contains new SR, not needed anymore
- *	 r31 - handler	address of the handler we'll jump to
+ *	 r30 - handler	address of the handler we'll jump to
  *
  *	 handler has to save remaining registers to the exception
  *	 ksp frame *before* tainting them!
@@ -244,6 +243,7 @@
 	/* r1 is KSP, r30 is __pa(KSP) */			;\
 	tophys  (r30,r1)					;\
 	l.sw    PT_GPR12(r30),r12				;\
+	/* r4 use for tmp before EA */				;\
 	l.mfspr r12,r0,SPR_EPCR_BASE				;\
 	l.sw    PT_PC(r30),r12					;\
 	l.mfspr r12,r0,SPR_ESR_BASE				;\
@@ -263,7 +263,10 @@
 	/* r12 == 1 if we come from syscall */			;\
 	CLEAR_GPR(r12)						;\
 	/* ----- turn on MMU ----- */				;\
-	l.ori	r30,r0,(EXCEPTION_SR)				;\
+	/* Carry DSX into exception SR */			;\
+	l.mfspr r30,r0,SPR_SR					;\
+	l.andi	r30,r30,SPR_SR_DSX				;\
+	l.ori	r30,r30,(EXCEPTION_SR)				;\
 	l.mtspr	r0,r30,SPR_ESR_BASE				;\
 	/* r30:	EA address of handler */			;\
 	LOAD_SYMBOL_2_GPR(r30,handler)				;\
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index fac246e6f37a..d8981cbb852a 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -300,7 +300,7 @@ static inline int in_delay_slot(struct pt_regs *regs)
 		return 0;
 	}
 #else
-	return regs->sr & SPR_SR_DSX;
+	return mfspr(SPR_SR) & SPR_SR_DSX;
 #endif
 }
 
-- 
2.17.0

