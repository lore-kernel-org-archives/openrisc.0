From: Stafford Horne <shorne@gmail.com>
Date: Mon, 13 Sep 2021 21:48:00 +0900
Subject: [OpenRISC] [PATCH 5/5] gdb: or1k: add single step for linux native
 debugging
In-Reply-To: <20210913124800.471680-1-shorne@gmail.com>
References: <20210913124800.471680-1-shorne@gmail.com>
Message-ID: <20210913124800.471680-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Needed for single stepping in Linux, this adds the or1k implementation
of or1k_software_single_step.  Most of the implementation is borrowed
from the bare metal single step code from or1k_single_step_through_delay
which has been extracted and shared in helper function
or1k_delay_slot_p.
---
 gdb/or1k-linux-tdep.c |  2 ++
 gdb/or1k-tdep.c       | 66 ++++++++++++++++++++++++++++++-------------
 gdb/or1k-tdep.h       |  5 ++++
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/gdb/or1k-linux-tdep.c b/gdb/or1k-linux-tdep.c
index a71a8202b1e..63c4171e295 100644
--- a/gdb/or1k-linux-tdep.c
+++ b/gdb/or1k-linux-tdep.c
@@ -154,6 +154,8 @@ or1k_linux_init_abi (struct gdbarch_info info, struct gdbarch *gdbarch)
   /* GNU/Linux uses the dynamic linker included in the GNU C Library.  */
   set_gdbarch_skip_solib_resolver (gdbarch, glibc_skip_solib_resolver);
 
+  set_gdbarch_software_single_step (gdbarch, or1k_software_single_step);
+
   /* Enable TLS support.  */
   set_gdbarch_fetch_tls_load_module_address (gdbarch,
 					     svr4_fetch_objfile_link_map);
diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 91f21576bd5..5bf617e78c4 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -346,6 +346,33 @@ constexpr gdb_byte or1k_break_insn[] = {0x21, 0x00, 0x00, 0x01};
 
 typedef BP_MANIPULATION (or1k_break_insn) or1k_breakpoint;
 
+static int
+or1k_delay_slot_p (struct gdbarch *gdbarch, CORE_ADDR pc)
+{
+  const CGEN_INSN *insn;
+  CGEN_FIELDS tmp_fields;
+  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
+
+  insn = cgen_lookup_insn (tdep->gdb_cgen_cpu_desc,
+			   NULL,
+			   or1k_fetch_instruction (gdbarch, pc),
+			   NULL, 32, &tmp_fields, 0);
+
+  /* NULL here would mean the last instruction was not understood by cgen.
+     This should not usually happen, but if does its not a delay slot.  */
+  if (insn == NULL)
+    return 0;
+
+  /* TODO: we should add a delay slot flag to the CGEN_INSN and remove
+     this hard coded test.  */
+  return ((CGEN_INSN_NUM (insn) == OR1K_INSN_L_J)
+	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_JAL)
+	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_JR)
+	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_JALR)
+	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_BNF)
+	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_BF));
+}
+
 /* Implement the single_step_through_delay gdbarch method.  */
 
 static int
@@ -355,10 +382,7 @@ or1k_single_step_through_delay (struct gdbarch *gdbarch,
   ULONGEST val;
   CORE_ADDR ppc;
   CORE_ADDR npc;
-  CGEN_FIELDS tmp_fields;
-  const CGEN_INSN *insn;
   struct regcache *regcache = get_current_regcache ();
-  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
 
   /* Get the previous and current instruction addresses.  If they are not
     adjacent, we cannot be in a delay slot.  */
@@ -370,24 +394,28 @@ or1k_single_step_through_delay (struct gdbarch *gdbarch,
   if (0x4 != (npc - ppc))
     return 0;
 
-  insn = cgen_lookup_insn (tdep->gdb_cgen_cpu_desc,
-			   NULL,
-			   or1k_fetch_instruction (gdbarch, ppc),
-			   NULL, 32, &tmp_fields, 0);
+  return or1k_delay_slot_p (gdbarch, ppc);
+}
 
-  /* NULL here would mean the last instruction was not understood by cgen.
-     This should not usually happen, but if does its not a delay slot.  */
-  if (insn == NULL)
-    return 0;
+/* or1k_software_single_step() is called just before we want to resume
+   the inferior, if we want to single-step it but there is no hardware
+   or kernel single-step support (OpenRISC on GNU/Linux for example).  We
+   find the target of the coming instruction skipping over delay slots
+   and breakpoint it.  */
 
-  /* TODO: we should add a delay slot flag to the CGEN_INSN and remove
-     this hard coded test.  */
-  return ((CGEN_INSN_NUM (insn) == OR1K_INSN_L_J)
-	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_JAL)
-	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_JR)
-	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_JALR)
-	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_BNF)
-	  || (CGEN_INSN_NUM (insn) == OR1K_INSN_L_BF));
+std::vector<CORE_ADDR>
+or1k_software_single_step (struct regcache *regcache)
+{
+  struct gdbarch *gdbarch = regcache->arch ();
+  CORE_ADDR pc, next_pc;
+
+  pc = regcache_read_pc (regcache);
+  next_pc = pc + 4;
+
+  if (or1k_delay_slot_p (gdbarch, pc))
+    next_pc += 4;
+
+  return {next_pc};
 }
 
 /* Name for or1k general registers.  */
diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
index d9dc1aca3c3..81d902ae49e 100644
--- a/gdb/or1k-tdep.h
+++ b/gdb/or1k-tdep.h
@@ -52,4 +52,9 @@
 #define OR1K_NUM_TAP_RECORDS         8
 #define OR1K_FRAME_RED_ZONE_SIZE     2536
 
+/* Single step based on where the current instruction will take us.  */
+extern std::vector<CORE_ADDR> or1k_software_single_step
+  (struct regcache *regcache);
+
+
 #endif /* OR1K_TDEP_H */
-- 
2.31.1

