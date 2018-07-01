From: Stafford Horne <shorne@gmail.com>
Date: Sun,  1 Jul 2018 14:11:47 +0900
Subject: [OpenRISC] [PATCH] target/openrisc: Fix delay slot exception flag
	to match spec
Message-ID: <20180701051147.31649-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The delay slot exception flag is only set on the SR register during
exception.  Previously it was being set on both the ESR and SR this
caused QEMU to differ from the spec.  The was apparent as the linux
kernel had a bug where it could boot on QEMU but not on real hardware.

The fixed logic now matches hardware.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 138ad17f00..bbae956361 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -35,13 +35,6 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     int exception = cs->exception_index;
 
     env->epcr = env->pc;
-    if (env->dflag) {
-        env->dflag = 0;
-        env->sr |= SR_DSX;
-        env->epcr -= 4;
-    } else {
-        env->sr &= ~SR_DSX;
-    }
     if (exception == EXCP_SYSCALL) {
         env->epcr += 4;
     }
@@ -51,7 +44,10 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         env->eear = env->pc;
     }
 
+    /* During exceptions esr is populared with the pre-exception sr.  */
     env->esr = cpu_get_sr(env);
+    /* In parallel sr is updated to disable mmu, interrupts, timers and
+       set the delay slot exception flag.  */
     env->sr &= ~SR_DME;
     env->sr &= ~SR_IME;
     env->sr |= SR_SM;
@@ -61,6 +57,15 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->pmr &= ~PMR_SME;
     env->lock_addr = -1;
 
+    /* Set/clear dsx to indicate if we are in a delay slot exception.  */
+    if (env->dflag) {
+        env->dflag = 0;
+        env->sr |= SR_DSX;
+        env->epcr -= 4;
+    } else {
+        env->sr &= ~SR_DSX;
+    }
+
     if (exception > 0 && exception < EXCP_NR) {
         static const char * const int_name[EXCP_NR] = {
             [EXCP_RESET]    = "RESET",
-- 
2.17.0

