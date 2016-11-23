From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:30 +0900
Subject: [OpenRISC] [PATCH 16/18] sim: or1k: Do trap breakpoint handling
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-17-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Breakpoints were not implemented in the sim.  This change allows for
trap instructions (inserted when gdb sets breakpoints) to transfer
control back to GDB allowing breakpoints to work with 'target sim'

After implementing this gdb test suite is looking better with:

                === gdb Summary ===

 # of expected passes            15981
 # of unexpected failures        509
 # of expected failures          27
 # of known failures             47
 # of unresolved testcases       34
 # of untested testcases         174
 # of unsupported tests          309
---
 sim/or1k/traps.c | 70 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/sim/or1k/traps.c b/sim/or1k/traps.c
index 526f2e7..235d9b5 100644
--- a/sim/or1k/traps.c
+++ b/sim/or1k/traps.c
@@ -17,48 +17,52 @@ sim_engine_invalid_insn (SIM_CPU *current_cpu, IADDR cia, SEM_PC vpc)
 #ifdef WANT_CPU_OR1K32BF
   or1k32bf_exception (current_cpu, cia, EXCEPT_ILLEGAL);
 #endif
-  
+
   return vpc;
 }
 
 void or1k32bf_exception (sim_cpu *current_cpu, USI pc, USI exnum)
 {
   SIM_DESC sd = CPU_STATE(current_cpu);
-  
-  SET_H_SYS_ESR0 (GET_H_SYS_SR ());
-  
-  SET_H_SYS_SR_DSX (current_cpu->delay_slot);
-  
-  switch (exnum) {
-  case EXCEPT_RESET:
-    break;
 
-  case EXCEPT_SYSCALL:
-    SET_H_SYS_EPCR0 (pc + 4 - (current_cpu->delay_slot ? 4 : 0));
-    break;
+  if (exnum == EXCEPT_TRAP) {
+    /* Trap, used for breakpoints, sends control back to gdb breakpoint handling */
+    sim_engine_halt (sd, current_cpu, NULL, pc, sim_stopped, SIM_SIGTRAP);
+  } else {
+
+    /* Calculate the exception program counter */
+    switch (exnum) {
+    case EXCEPT_RESET:
+      break;
+
+    case EXCEPT_SYSCALL:
+      SET_H_SYS_EPCR0 (pc + 4 - (current_cpu->delay_slot ? 4 : 0));
+      break;
+
+    case EXCEPT_BUSERR:
+    case EXCEPT_ALIGN:
+    case EXCEPT_ILLEGAL:
+      SET_H_SYS_EPCR0 (pc - (current_cpu->delay_slot ? 4 : 0));
+      break;
+
+    default:
+      sim_io_error (sd, "unexpected exception 0x%x raised at PC 0x%08x", exnum, pc);
+      break;
+    }
 
-  case EXCEPT_BUSERR:
-  case EXCEPT_ALIGN:
-  case EXCEPT_RANGE:
-  case EXCEPT_TRAP:
-  case EXCEPT_ILLEGAL:
-    SET_H_SYS_EPCR0 (pc - (current_cpu->delay_slot ? 4 : 0));
-    break;
+    /* Store the curent SR into ESR0 */
+    SET_H_SYS_ESR0 (GET_H_SYS_SR ());
 
-  default:
-    sim_io_error (sd, "unexpected exception 0x%x raised at PC 0x%08x", exnum, pc);
-    break;
-    
+    /* Indicate in SR if the failed instruction is in delay slot or not */
+    SET_H_SYS_SR_DSX (current_cpu->delay_slot);
+
+    current_cpu->next_delay_slot = 0;
+
+    /* jump program counter into handler */
+    IADDR handler_pc = (GET_H_SYS_SR_EPH() ? 0xf0000000 : 0x00000000) + (exnum << 8);
+
+    sim_engine_restart (sd, current_cpu, NULL, handler_pc);
   }
-  
-  current_cpu->next_delay_slot = 0;
-  
-  IADDR handler_pc = (GET_H_SYS_SR_EPH() ? 0xf0000000 : 0x00000000) + (exnum << 8);
-  
-  sim_engine_restart (CPU_STATE (current_cpu),
-                      current_cpu,
-                      NULL,
-                      handler_pc);
 }
 
 void or1k32bf_rfe (sim_cpu *current_cpu)
@@ -97,8 +101,8 @@ USI or1k32bf_mfspr (sim_cpu *current_cpu, USI addr)
   case SPR_ADDR(SYS,PPC):
   case SPR_ADDR(SYS,FPCSR):
   case SPR_ADDR(SYS,EPCR0):
-  case SPR_ADDR(MAC,MACHI):
   case SPR_ADDR(MAC,MACLO):
+  case SPR_ADDR(MAC,MACHI):
     break;
 
   default:
-- 
2.7.4


