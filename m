From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:39 +0900
Subject: [OpenRISC] [PATCH v4 19/24] openrisc: entry: Whitespace and comment
	cleanups
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <bc9bb8b52d059efd339dc1bb649483cb8749ab02.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Cleanups to whitespace and add some comments. Reading through the delay
slot logic I noticed some things:
 - Delay slot instructions were not indented
 - Some comments are not lined up
 - Use tabs and spaces consistent with other code

No functional change

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index ba1a361..daae2a4 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -228,7 +228,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 	 * DTLB miss handler in the CONFIG_GUARD_PROTECTED_CORE part
 	 */
 #ifdef CONFIG_OPENRISC_NO_SPR_SR_DSX
-	l.lwz   r6,PT_PC(r3)                  // address of an offending insn
+	l.lwz   r6,PT_PC(r3)               // address of an offending insn
 	l.lwz   r6,0(r6)                   // instruction that caused pf
 
 	l.srli  r6,r6,26                   // check opcode for jump insn
@@ -244,49 +244,47 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 	l.bf    8f
 	l.sfeqi r6,0x12                    // l.jalr
 	l.bf    8f
-
-	l.nop
+	 l.nop
 
 	l.j     9f
-	l.nop
-8:
+	 l.nop
 
-	l.lwz   r6,PT_PC(r3)                  // address of an offending insn
+8: // offending insn is in delay slot
+	l.lwz   r6,PT_PC(r3)               // address of an offending insn
 	l.addi  r6,r6,4
 	l.lwz   r6,0(r6)                   // instruction that caused pf
 	l.srli  r6,r6,26                   // get opcode
-9:
+9: // offending instruction opcode loaded in r6
 
 #else
 
-	l.mfspr r6,r0,SPR_SR		   // SR
-//	l.lwz	r6,PT_SR(r3)		   // ESR
-	l.andi	r6,r6,SPR_SR_DSX	   // check for delay slot exception
-	l.sfeqi	r6,0x1			   // exception happened in delay slot
-	l.bnf	7f
-	l.lwz	r6,PT_PC(r3)		   // address of an offending insn
+	l.mfspr r6,r0,SPR_SR               // SR
+	l.andi  r6,r6,SPR_SR_DSX           // check for delay slot exception
+	l.sfeqi r6,0x1                     // exception happened in delay slot
+	l.bnf   7f
+	 l.lwz  r6,PT_PC(r3)               // address of an offending insn
 
-	l.addi	r6,r6,4			   // offending insn is in delay slot
+	l.addi	r6,r6,4                    // offending insn is in delay slot
 7:
 	l.lwz   r6,0(r6)                   // instruction that caused pf
 	l.srli  r6,r6,26                   // check opcode for write access
 #endif
 
-	l.sfgeui r6,0x33		   // check opcode for write access
+	l.sfgeui r6,0x33                   // check opcode for write access
 	l.bnf   1f
 	l.sfleui r6,0x37
 	l.bnf   1f
 	l.ori   r6,r0,0x1                  // write access
 	l.j     2f
-	l.nop
+	 l.nop
 1:	l.ori   r6,r0,0x0                  // !write access
 2:
 
 	/* call fault.c handler in or32/mm/fault.c */
 	l.jal   do_page_fault
-	l.nop
+	 l.nop
 	l.j     _ret_from_exception
-	l.nop
+	 l.nop
 
 /* ---[ 0x400: Insn Page Fault exception ]------------------------------- */
 EXCEPTION_ENTRY(_itlb_miss_page_fault_handler)
@@ -306,9 +304,9 @@ EXCEPTION_ENTRY(_insn_page_fault_handler)
 
 	/* call fault.c handler in or32/mm/fault.c */
 	l.jal   do_page_fault
-	l.nop
+	 l.nop
 	l.j     _ret_from_exception
-	l.nop
+	 l.nop
 
 
 /* ---[ 0x500: Timer exception ]----------------------------------------- */
-- 
2.9.3

