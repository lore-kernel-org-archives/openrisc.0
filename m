From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Dec 2021 11:18:40 +0900
Subject: [OpenRISC] [PATCH 1/3] openrisc: Cleanup switch code and comments
In-Reply-To: <20211204021842.1853549-1-shorne@gmail.com>
References: <20211204021842.1853549-1-shorne@gmail.com>
Message-ID: <20211204021842.1853549-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The saving of the r12 register was there for a compiler bug referring
to a port that was never upstreamed.  It should be safe to use this
as the new compiler is what we use and the old deprecated.

Also, clean up some typos and references to old names in the switch
comments.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 59c6d3aa7081..c608f76e5753 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1001,11 +1001,10 @@ ENTRY(ret_from_fork)
 	l.lwz	r11,PT_GPR11(r1)
 
 	/* The syscall fast path return expects call-saved registers
-	 * r12-r28 to be untouched, so we restore them here as they
+	 * r14-r28 to be untouched, so we restore them here as they
 	 * will have been effectively clobbered when arriving here
 	 * via the call to switch()
 	 */
-	l.lwz	r12,PT_GPR12(r1)
 	l.lwz	r14,PT_GPR14(r1)
 	l.lwz	r16,PT_GPR16(r1)
 	l.lwz	r18,PT_GPR18(r1)
@@ -1037,10 +1036,10 @@ ENTRY(ret_from_fork)
 
 /* _switch MUST never lay on page boundry, cause it runs from
  * effective addresses and beeing interrupted by iTLB miss would kill it.
- * dTLB miss seams to never accour in the bad place since data accesses
+ * dTLB miss seems to never accour in the bad place since data accesses
  * are from task structures which are always page aligned.
  *
- * The problem happens in RESTORE_ALL_NO_R11 where we first set the EPCR
+ * The problem happens in RESTORE_ALL where we first set the EPCR
  * register, then load the previous register values and only at the end call
  * the l.rfe instruction. If get TLB miss in beetwen the EPCR register gets
  * garbled and we end up calling l.rfe with the wrong EPCR. (same probably
@@ -1068,9 +1067,8 @@ ENTRY(_switch)
 	/* No need to store r1/PT_SP as it goes into KSP below */
 	l.sw    PT_GPR2(r1),r2
 	l.sw    PT_GPR9(r1),r9
-	/* This is wrong, r12 shouldn't be here... but GCC is broken for the time being
-	 * and expects r12 to be callee-saved... */
-	l.sw    PT_GPR12(r1),r12
+
+	/* Save callee-saved registers to the new pt_regs */
 	l.sw    PT_GPR14(r1),r14
 	l.sw    PT_GPR16(r1),r16
 	l.sw    PT_GPR18(r1),r18
@@ -1111,9 +1109,7 @@ ENTRY(_switch)
 	/* No need to restore r10 */
 	/* ...and do not restore r11 */
 
-	/* This is wrong, r12 shouldn't be here... but GCC is broken for the time being
-	 * and expects r12 to be callee-saved... */
-	l.lwz   r12,PT_GPR12(r1)
+	/* Restore callee-saved registers */
 	l.lwz   r14,PT_GPR14(r1)
 	l.lwz   r16,PT_GPR16(r1)
 	l.lwz   r18,PT_GPR18(r1)
-- 
2.31.1

