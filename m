From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:20 +0900
Subject: [OpenRISC] [PATCH 06/18] sim: or1k: fix branching and exceptions in
	sim
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-7-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/or1k/ChangeLog:

2012-06-22  Peter Gavin  <pgavin@gmail.com>

	fix the way branches and exceptions are handled
	* Makefile.in: build traps32.o and traps64.o instead of just traps.o
	* configure.ac: pick the correct traps object
	* configure: regenerated
	* mloop.in:
	(execute) pass idesc to @cpu at _insn_{before,after}, return vpc instead of result of @cpu at _insts_{after}
	(extract-pbb) end basic blocks at instructions marked FORCED-CTI
	* sim-main.h:
	(_sim_cpu) add fields delay_slot and next_delay_slot to track when
	an instruction is in a delay slot
	* or1k.c:
	(or1k_cpu_init) initialized current_cpu->{next_,}delay_slot
	(or1k32bf_insn_before) handle delay slot flags, check for invalid
	instructions in delay slots
	(or1k32bf_insn_after) handle delay slot flags
	(or1k32bf_mfspr) move to traps.c
	(or1k32bf_mtspr) ditto
	(or1k32bf_exception) ditto
	(or1k32bf_rfe) ditto
	* or1k.h:
	(SPR_ADDR_GROUP) new macro
	(SPR_INDEX_MASK) ditto
	(SPR_ADDR_INDEX) ditto
	(or1k32bf_insn_before, or1k32bf_insn_after) add idesc argument
	(or1k32bf_exception, or1k32bf_rfe, or1k32bf_nop) add prototypes
	(or1k32bf_mfspr, or1k32bf_mtspr) ditto
	* traps.h:
	(sim_engine_invalid_instruction) new function
	(or1k32bf_exception) new function (moved from or1k.c, but was just a stub)
	(or1k32bf_rfe) ditto
	(or1k32bf_mfspr) moved from or1k.c, some fixes
	(or1k32bf_mtspr) moved from or1k.c, some fixes

* sim/testsuite/ChangeLog-OR1K:

2012-06-22  Peter Gavin  <pgavin@gmail.com>

	* configure: regenerated
---
 sim/or1k/ChangeLog      |  38 +++++++++++
 sim/or1k/Makefile.in    |  19 +++++-
 sim/or1k/configure      |   8 +--
 sim/or1k/configure.ac   |   8 +--
 sim/or1k/mloop.in       |  27 +++++++-
 sim/or1k/or1k.c         | 116 +++++++++-----------------------
 sim/or1k/or1k.h         |  12 +++-
 sim/or1k/sim-main.h     |   5 ++
 sim/or1k/traps.c        | 173 +++++++++++++++++++++++++++++++++++++++++++++++-
 sim/testsuite/configure |   4 ++
 10 files changed, 307 insertions(+), 103 deletions(-)

diff --git a/sim/or1k/ChangeLog b/sim/or1k/ChangeLog
index cd2617c..90dc44a 100644
--- a/sim/or1k/ChangeLog
+++ b/sim/or1k/ChangeLog
@@ -1,3 +1,41 @@
+2012-06-22  Peter Gavin  <pgavin@gmail.com>
+
+	* configure: regenerated
+
+2012-06-22  Peter Gavin  <pgavin@gmail.com>
+
+	fix the way branches and exceptions are handled
+	* Makefile.in: build traps32.o and traps64.o instead of just traps.o
+	* configure.ac: pick the correct traps object
+	* mloop.in:
+	(execute) pass idesc to @cpu at _insn_{before,after}, return vpc instead of result of @cpu at _insts_{after}
+	(extract-pbb) end basic blocks at instructions marked FORCED-CTI
+	* sim-main.h:
+	(_sim_cpu) add fields delay_slot and next_delay_slot to track when
+	an instruction is in a delay slot
+	* or1k.c:
+	(or1k_cpu_init) initialized current_cpu->{next_,}delay_slot
+	(or1k32bf_insn_before) handle delay slot flags, check for invalid
+	instructions in delay slots
+	(or1k32bf_insn_after) handle delay slot flags
+	(or1k32bf_mfspr) move to traps.c
+	(or1k32bf_mtspr) ditto
+	(or1k32bf_exception) ditto
+	(or1k32bf_rfe) ditto
+	* or1k.h:
+	(SPR_ADDR_GROUP) new macro
+	(SPR_INDEX_MASK) ditto
+	(SPR_ADDR_INDEX) ditto
+	(or1k32bf_insn_before, or1k32bf_insn_after) add idesc argument
+	(or1k32bf_exception, or1k32bf_rfe, or1k32bf_nop) add prototypes
+	(or1k32bf_mfspr, or1k32bf_mtspr) ditto
+	* traps.h:
+	(sim_engine_invalid_instruction) new function
+	(or1k32bf_exception) new function (moved from or1k.c, but was just a stub)
+	(or1k32bf_rfe) ditto
+	(or1k32bf_mfspr) moved from or1k.c, some fixes
+	(or1k32bf_mtspr) moved from or1k.c, some fixes
+
 2012-05-21  Peter Gavin  <pgavin@gmail.com>
 
 	* or1k.c (or1k32bf_nop) make NOP_EXIT report exit code on
diff --git a/sim/or1k/Makefile.in b/sim/or1k/Makefile.in
index b89c070..35ef7e6 100644
--- a/sim/or1k/Makefile.in
+++ b/sim/or1k/Makefile.in
@@ -92,9 +92,6 @@ SIM_EXTRA_CLEAN =
 
 arch = or1k
 
-traps.o: traps.c $(SIM_MAIN_DEPS)
-traps-linux.o: traps-linux.c $(SIM_MAIN_DEPS)
-
 # or1k32bf
 
 OR1K32BF_INCLUDE_DEPS = \
@@ -126,6 +123,14 @@ sim-if32.o: sim-if.c $(SIM_MAIN_DEPS) $(srcdir)/../common/sim-core.h eng32.h
 	$(COMPILE) $<
 	$(POSTCOMPILE)
 
+traps32.o: traps.c $(SIM_MAIN_DEPS) eng32.h
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+traps32-linux.o: traps-linux.c $(SIM_MAIN_DEPS) eng32.h
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+
+
 # or1k64bf
 
 OR1K64BF_INCLUDE_DEPS = \
@@ -157,6 +162,14 @@ sim-if64.o: sim-if.c $(SIM_MAIN_DEPS) $(srcdir)/../common/sim-core.h eng64.h
 	$(COMPILE) $<
 	$(POSTCOMPILE)
 
+traps64.o: traps.c $(SIM_MAIN_DEPS) eng64.h
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+traps64-linux.o: traps-linux.c $(SIM_MAIN_DEPS) eng64.h
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+
+
 # cgen support, enable with --enable-cgen-maint
 CGEN_MAINT = ; @true
 # The following line is commented in or out depending upon --enable-cgen-maint.
diff --git a/sim/or1k/configure b/sim/or1k/configure
index ea562d4..eb5e0a2 100644
--- a/sim/or1k/configure
+++ b/sim/or1k/configure
@@ -2489,11 +2489,11 @@ sim_inline="-DDEFAULT_INLINE=0"
 
 
   case "${target_alias}" in
-  or1k*-linux*)
-    traps_obj=traps-linux.o
+  or1k-linux*|or1knd-linux*)
+    traps_obj=traps32-linux.o
     ;;
-  *)
-    traps_obj=traps.o
+  or1k-*|or1knd-*)
+    traps_obj=traps32.o
     ;;
   esac
 
diff --git a/sim/or1k/configure.ac b/sim/or1k/configure.ac
index fde576b..d5dca70 100644
--- a/sim/or1k/configure.ac
+++ b/sim/or1k/configure.ac
@@ -4,11 +4,11 @@ AC_INIT(Makefile.in)
 sinclude(../common/acinclude.m4)
   
   case "${target_alias}" in
-  or1k*-linux*)
-    traps_obj=traps-linux.o
+  or1k-linux*|or1knd-linux*)
+    traps_obj=traps32-linux.o
     ;;
-  *)
-    traps_obj=traps.o
+  or1k-*|or1knd-*)
+    traps_obj=traps32.o
     ;;
   esac
 
diff --git a/sim/or1k/mloop.in b/sim/or1k/mloop.in
index 328d1e6..6f19c50 100644
--- a/sim/or1k/mloop.in
+++ b/sim/or1k/mloop.in
@@ -62,7 +62,7 @@ execute (SIM_CPU *current_cpu, SCACHE *sc, int fast_p)
 {
   SEM_PC vpc;
   
-  @cpu at _insn_before (current_cpu, vpc);
+  @cpu@_insn_before (current_cpu, vpc, sc->argbuf.idesc);
 
   if (fast_p)
     {
@@ -124,7 +124,9 @@ execute (SIM_CPU *current_cpu, SCACHE *sc, int fast_p)
 #endif /* WITH_SEM_SWITCH_FULL */
     }
 
-  return @cpu at _insn_after (current_cpu, vpc);
+  @cpu at _insn_after (current_cpu, vpc, sc->argbuf.idesc);
+  
+  return vpc;
 }
 
 EOF
@@ -161,27 +163,46 @@ xextract-pbb)
 
 cat <<EOF
 {
+  SIM_DESC sd = CPU_STATE(current_cpu);
   const IDESC *idesc;
   int icount = 0;
 
   while (max_insns > 0) {
+
     USI insn = GETIMEMUSI (current_cpu, pc);
+
     idesc = extract (current_cpu, pc, insn, &sc->argbuf, FAST_P);
+
     SEM_SKIP_COMPILE (current_cpu, sc, 1);
+
     ++sc;
     --max_insns;
     ++icount;
     pc += 4;
-    if (CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_DELAYED_CTI))
+
+    if (CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_FORCED_CTI))
+      {
+        
+        SET_CTI_VPC (sc - 1);
+
+        break;
+
+      }
+    else if (CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_DELAYED_CTI))
       {
+
         /* handle delay slot */
         SET_CTI_VPC (sc - 1);
+
         insn = GETIMEMUSI (current_cpu, pc);
+
         idesc = extract (current_cpu, pc, insn, &sc->argbuf, FAST_P);
+        
         ++sc;
         --max_insns;
         ++icount;
         pc += 4;
+
         break;
       }
   }
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
index aca7333..45147d2 100644
--- a/sim/or1k/or1k.c
+++ b/sim/or1k/or1k.c
@@ -77,6 +77,9 @@ void or1k32bf_cpu_init (SIM_DESC sd, sim_cpu *current_cpu)
                      #FIELD, #INDEX, field);                            \
     }                                                                   \
   } while (0)
+  
+  current_cpu->next_delay_slot = 0;
+  current_cpu->delay_slot = 0;
 
   CHECK_SPR_FIELD(SYS,UPR,UP,   field == 1);
   CHECK_SPR_FIELD(SYS,UPR,DCP,  field == 0);
@@ -109,21 +112,44 @@ void or1k32bf_cpu_init (SIM_DESC sd, sim_cpu *current_cpu)
   SET_H_SYS_FPCSR(0);
 }
 
-void or1k32bf_insn_before (sim_cpu *current_cpu, SEM_PC vpc)
+void or1k32bf_insn_before (sim_cpu *current_cpu, SEM_PC vpc, IDESC *idesc)
 {
+  SIM_DESC sd = CPU_STATE(current_cpu);
+
+  current_cpu->delay_slot = current_cpu->next_delay_slot;
+  current_cpu->next_delay_slot = 0;
+
+  if (current_cpu->delay_slot &&
+      CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_NOT_IN_DELAY_SLOT)) {
+    USI pc;
+#ifdef WITH_SCACHE
+    pc = vpc->argbuf.addr;
+#else
+    pc = vpc;
+#endif
+    sim_io_error (sd, "invalid instruction in a delay slot at PC 0x%08x", pc);
+  }
+  
 }
 
-SEM_PC or1k32bf_insn_after (sim_cpu *current_cpu, SEM_PC vpc)
+void or1k32bf_insn_after (sim_cpu *current_cpu, SEM_PC vpc, IDESC *idesc)
 {
+  SIM_DESC sd = CPU_STATE(current_cpu);
   USI ppc;
+  
 #ifdef WITH_SCACHE
   ppc = vpc->argbuf.addr;
 #else
   ppc = vpc;
 #endif
-  SET_H_SPR (SPR_ADDR(SYS,PPC), ppc);
-  
-  return vpc;
+
+  SET_H_SYS_PPC (ppc);
+
+  if (!GET_H_SYS_CPUCFGR_ND () &&
+      CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_DELAYED_CTI)) {
+    SIM_ASSERT (!current_cpu->delay_slot);
+    current_cpu->next_delay_slot = 1;
+  }
 }
 
 void or1k32bf_nop (sim_cpu *current_cpu, USI uimm16)
@@ -157,86 +183,6 @@ void or1k32bf_nop (sim_cpu *current_cpu, USI uimm16)
   
 }
 
-void or1k32bf_mfspr (sim_cpu *current_cpu, USI pc, int rd, USI addr)
-{
-  SIM_DESC sd = CPU_STATE(current_cpu);
-  
-  if (!GET_H_SYS_SR_SM () && !GET_H_SYS_SR_SUMRA ()) {
-    sim_io_eprintf(sd, "WARNING: l.mfspr in user mode (SR 0x%x)\n", GET_H_SYS_SR());
-    return;
-  }
-  
-  if (addr >= NUM_SPR)
-    return;
-  
-  SI val = GET_H_SPR(addr);
-  
-  switch (addr) {
-
-  case SPR_ADDR(SYS,VR):
-  case SPR_ADDR(SYS,UPR):
-  case SPR_ADDR(SYS,CPUCFGR):
-  case SPR_ADDR(SYS,SR):
-  case SPR_ADDR(SYS,FPCSR):
-  case SPR_ADDR(SYS,DMMUCFGR):
-    SET_H_GPR(rd, val);
-    break;
-    
-  default:
-    if (addr >= SPR_ADDR(SYS,GPR0) && addr <= SPR_ADDR(SYS,GPR511)) {
-      SET_H_GPR(rd, val);
-    } else {
-      sim_io_eprintf (sd, "WARNING: l.mfspr with invalid SPR address 0x%x\n", addr);
-    }
-    break;
-    
-  }
-
-}
-
-void or1k32bf_mtspr (sim_cpu *current_cpu, USI pc, USI addr, USI val)
-{
-  SIM_DESC sd = CPU_STATE(current_cpu);
-  
-  if (!GET_H_SYS_SR_SM () && !GET_H_SYS_SR_SUMRA ()) {
-    sim_io_eprintf(sd, "WARNING: l.mtspr in user mode (SR 0x%x)\n", GET_H_SYS_SR());
-    return;
-  }
-  
-  if (addr >= NUM_SPR)
-    return;
-  
-  switch (addr) {
-    
-  case SPR_ADDR(SYS,SR):
-    break;
-
-  case SPR_ADDR(SYS,UPR):
-    break;
-    
-  default:
-    if (addr >= SPR_ADDR(SYS,GPR0) && addr <= SPR_ADDR(SYS,GPR511)) {
-      SET_H_SPR(addr, val);
-    }
-    break;
-    
-  }
-  
-  return;
-}
-
-void or1k32bf_exception (sim_cpu *current_cpu, USI pc, USI exnum)
-{
-  /* TODO */
-  abort();
-}
-
-void or1k32bf_rfe (sim_cpu *current_cpu, USI pc)
-{
-  /* TODO */
-  abort();
-}
-
 USI or1k32bf_make_load_store_addr (sim_cpu *current_cpu, USI base, SI offset, int size)
 {
   SIM_DESC sd = CPU_STATE(current_cpu);
diff --git a/sim/or1k/or1k.h b/sim/or1k/or1k.h
index f1c9b73..e71a845 100644
--- a/sim/or1k/or1k.h
+++ b/sim/or1k/or1k.h
@@ -19,12 +19,20 @@
 #define SPR_GROUP_FIRST(group) (((UWI) SPR_GROUP_##group) << SPR_GROUP_SHIFT)
 #define SPR_GROUP_LAST(group) (SPR_GROUP_FIRST | (((UWI) 1 << SPR_GROUP_SHIFT) - 1))
 #define SPR_ADDR(group,index) (SPR_GROUP_FIRST(group) | ((UWI) SPR_INDEX_##group##_##index))
+#define SPR_ADDR_GROUP(addr) (((UWI) (addr)) >> SPR_GROUP_SHIFT)
+#define SPR_INDEX_MASK (~(~((UWI) 0) << SPR_GROUP_SHIFT))
+#define SPR_ADDR_INDEX(addr) (((UWI) (addr)) && SPR_INDEX_MASK)
 #define SPR_FIELD(group,index,field,val) ((SPR_FIELD_MASK_##group##_##index##_##field & (val)) >> SPR_FIELD_LSB_##group##_##index##_##field)
 
 #ifdef WANT_CPU_OR1K32BF
 void or1k32bf_cpu_init (SIM_DESC sd, sim_cpu *current_cpu);
-void or1k32bf_insn_before (sim_cpu *current_cpu, SEM_PC vpc);
-SEM_PC or1k32bf_insn_after (sim_cpu *current_cpu, SEM_PC vpc);
+void or1k32bf_insn_before (sim_cpu *current_cpu, SEM_PC vpc, IDESC *idesc);
+void or1k32bf_insn_after (sim_cpu *current_cpu, SEM_PC vpc, IDESC *idesc);
+void or1k32bf_exception (sim_cpu *current_cpu, USI pc, USI exnum);
+void or1k32bf_rfe (sim_cpu *current_cpu);
+void or1k32bf_nop (sim_cpu *current_cpu, USI uimm16);
+USI or1k32bf_mfspr (sim_cpu *current_cpu, USI addr);
+void or1k32bf_mtspr (sim_cpu *current_cpu, USI addr, USI val);
 #endif
 
 #endif
diff --git a/sim/or1k/sim-main.h b/sim/or1k/sim-main.h
index 8b27906..d26d616 100644
--- a/sim/or1k/sim-main.h
+++ b/sim/or1k/sim-main.h
@@ -44,6 +44,11 @@ struct _sim_cpu {
      go after here.  Oh for a better language.  */
   UWI spr[NUM_SPR];
 
+  /* next instruction will be in delay slot */
+  BI next_delay_slot;
+  /* currently in delay slot */
+  BI delay_slot;
+
 #ifdef WANT_CPU_OR1K32BF
   OR1K32BF_CPU_DATA cpu_data;
 #endif
diff --git a/sim/or1k/traps.c b/sim/or1k/traps.c
index d2a111f..526f2e7 100644
--- a/sim/or1k/traps.c
+++ b/sim/or1k/traps.c
@@ -1,8 +1,177 @@
+#ifndef WANT_OR1K64
+#define WANT_CPU or1k32bf
+#define WANT_CPU_OR1K32BF
+#else
+#define WANT_CPU or1k64bf
+#define WANT_CPU_OR1K64BF
+#endif
+
 #include "sim-main.h"
+#include "cgen-ops.h"
 
 SEM_PC
 sim_engine_invalid_insn (SIM_CPU *current_cpu, IADDR cia, SEM_PC vpc)
 {
-  /* TODO */
-  abort();
+  SET_H_SYS_EEAR0(cia);
+
+#ifdef WANT_CPU_OR1K32BF
+  or1k32bf_exception (current_cpu, cia, EXCEPT_ILLEGAL);
+#endif
+  
+  return vpc;
+}
+
+void or1k32bf_exception (sim_cpu *current_cpu, USI pc, USI exnum)
+{
+  SIM_DESC sd = CPU_STATE(current_cpu);
+  
+  SET_H_SYS_ESR0 (GET_H_SYS_SR ());
+  
+  SET_H_SYS_SR_DSX (current_cpu->delay_slot);
+  
+  switch (exnum) {
+  case EXCEPT_RESET:
+    break;
+
+  case EXCEPT_SYSCALL:
+    SET_H_SYS_EPCR0 (pc + 4 - (current_cpu->delay_slot ? 4 : 0));
+    break;
+
+  case EXCEPT_BUSERR:
+  case EXCEPT_ALIGN:
+  case EXCEPT_RANGE:
+  case EXCEPT_TRAP:
+  case EXCEPT_ILLEGAL:
+    SET_H_SYS_EPCR0 (pc - (current_cpu->delay_slot ? 4 : 0));
+    break;
+
+  default:
+    sim_io_error (sd, "unexpected exception 0x%x raised at PC 0x%08x", exnum, pc);
+    break;
+    
+  }
+  
+  current_cpu->next_delay_slot = 0;
+  
+  IADDR handler_pc = (GET_H_SYS_SR_EPH() ? 0xf0000000 : 0x00000000) + (exnum << 8);
+  
+  sim_engine_restart (CPU_STATE (current_cpu),
+                      current_cpu,
+                      NULL,
+                      handler_pc);
+}
+
+void or1k32bf_rfe (sim_cpu *current_cpu)
+{
+  SET_H_SYS_SR (GET_H_SYS_ESR0 ());
+  SET_H_SYS_SR_FO (1);
+
+  current_cpu->next_delay_slot = 0;
+  
+  sim_engine_restart (CPU_STATE (current_cpu),
+                      current_cpu,
+                      NULL,
+                      GET_H_SYS_EPCR0 ());
+}
+
+USI or1k32bf_mfspr (sim_cpu *current_cpu, USI addr)
+{
+  SIM_DESC sd = CPU_STATE(current_cpu);
+  
+  if (!GET_H_SYS_SR_SM () && !GET_H_SYS_SR_SUMRA ()) {
+    sim_io_eprintf(sd, "WARNING: l.mfspr in user mode (SR 0x%x)\n", GET_H_SYS_SR());
+    return 0;
+  }
+  
+  if (addr >= NUM_SPR)
+    goto bad_address;
+  
+  SI val = GET_H_SPR(addr);
+  
+  switch (addr) {
+    
+  case SPR_ADDR(SYS,VR):
+  case SPR_ADDR(SYS,UPR):
+  case SPR_ADDR(SYS,CPUCFGR):
+  case SPR_ADDR(SYS,SR):
+  case SPR_ADDR(SYS,PPC):
+  case SPR_ADDR(SYS,FPCSR):
+  case SPR_ADDR(SYS,EPCR0):
+  case SPR_ADDR(MAC,MACHI):
+  case SPR_ADDR(MAC,MACLO):
+    break;
+
+  default:
+    if (addr < SPR_ADDR(SYS,GPR0) || addr > SPR_ADDR(SYS,GPR511)) {
+      goto bad_address;
+    }
+    break;
+    
+  }
+  
+  return val;
+
+ bad_address:
+  sim_io_eprintf (sd, "WARNING: l.mfspr with invalid SPR address 0x%x\n", addr);
+  return 0;
+
+}
+
+void or1k32bf_mtspr (sim_cpu *current_cpu, USI addr, USI val)
+{
+  SIM_DESC sd = CPU_STATE(current_cpu);
+  
+  if (!GET_H_SYS_SR_SM () && !GET_H_SYS_SR_SUMRA ()) {
+    sim_io_eprintf(sd, "WARNING: l.mtspr with address 0x%x in user mode (SR 0x%x)\n", addr, GET_H_SYS_SR());
+    return;
+  }
+  
+  if (addr >= NUM_SPR)
+    goto bad_address;
+  
+  switch (addr) {
+    
+  case SPR_ADDR(SYS,FPCSR):
+  case SPR_ADDR(SYS,EPCR0):
+  case SPR_ADDR(SYS,ESR0):
+  case SPR_ADDR(MAC,MACHI):
+  case SPR_ADDR(MAC,MACLO):
+    SET_H_SPR(addr, val);
+    break;
+    
+  case SPR_ADDR(SYS,SR):
+    SET_H_SPR(addr, val);
+    SET_H_SYS_SR_FO(1);
+    break;
+
+  case SPR_ADDR(SYS,NPC):
+    current_cpu->next_delay_slot = 0;
+  
+    sim_engine_restart (CPU_STATE (current_cpu),
+                        current_cpu,
+                        NULL,
+                        val);
+    break;
+
+  case SPR_ADDR(TICK,TTMR):
+    /* allow some registers to be silently cleared */
+    if (val != 0)
+      sim_io_eprintf (sd, "WARNING: l.mtspr to SPR address 0x%x with invalid value 0x%x\n", addr, val);
+    break;
+
+  default:
+    if (addr >= SPR_ADDR(SYS,GPR0) && addr <= SPR_ADDR(SYS,GPR511)) {
+      SET_H_SPR(addr, val);
+    } else {
+      goto bad_address;
+    }
+    break;
+    
+  }
+  
+  return;
+
+ bad_address:
+  sim_io_eprintf (sd, "WARNING: l.mtspr with invalid SPR address 0x%x\n", addr);
+
 }
diff --git a/sim/testsuite/configure b/sim/testsuite/configure
index bbc3bea..e37bdbd 100755
--- a/sim/testsuite/configure
+++ b/sim/testsuite/configure
@@ -1888,6 +1888,10 @@ case "${target}" in
    msp430*-*-*)
        sim_arch=msp430
        ;;
+   or1k-*-* | or1knd-*-*)
+       sim_arch=or1k
+       sim_testsuite=yes
+       ;;
    rl78-*-*)
        sim_arch=rl78
        ;;
-- 
2.7.4


