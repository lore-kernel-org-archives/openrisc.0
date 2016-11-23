From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:44 +0900
Subject: [OpenRISC] [PATCH 18/18] gdb: or1k: Refactor to new bp_kind_from_pc
	and pb_from_kind
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-19-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Updates to mirror refactorings by Yao Qi in cd6c3b4ffc.

New gdbarch methods breakpoint_kind_from_pc and sw_breakpoint_from_kind

gdb/ChangeLog:

	* or1k-tdep.c (or1k_breakpoint_kind_from_pc): New function
	(or1k_sw_breakpoint_from_kind): New function
	(or1k_breakpoint_from_pc): Remove
---
 gdb/or1k-tdep.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 5aa0e7c..dfaee96 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -124,6 +124,14 @@
 
 
 
+/* Enum describing different kinds of breakpoints for or1k */
+
+enum or1k_breakpoint_kind
+{
+  /* 32-bit standard OpenRISC breakpoint */
+  OR1K_BP_KIND_OR1K = 2,
+};
+
 /* The gdbarch_tdep structure.  */
 
 /*! OR1K specific per-architecture information. Replaces
@@ -526,6 +534,25 @@ or1k_return_value (struct gdbarch  *gdbarch,
 }	/* or1k_return_value() */
 
 
+
+/*----------------------------------------------------------------------------*/
+/*!Determine the kind of breakpoint based on the current pc
+
+   Given the pc address, return the type of breapoint that should be used.
+   For or1k we only use one type which is a 32-bit trap instruction.
+
+   @param[in]  gdbarch  The GDB architecture being used
+   @param[in]  pcptr    The program counter address in question
+
+   @return  The breakpoint type */
+/*----------------------------------------------------------------------------*/
+
+static int
+or1k_breakpoint_kind_from_pc (struct gdbarch *gdbarch, CORE_ADDR *pcptr)
+{
+  return OR1K_BP_KIND_OR1K;
+}	/* or1k_breakpoint_kind_from_pc() */
+
 /*----------------------------------------------------------------------------*/
 /*!Determine the instruction to use for a breakpoint.
 
@@ -543,16 +570,22 @@ or1k_return_value (struct gdbarch  *gdbarch,
 /*---------------------------------------------------------------------------*/
 
 static const gdb_byte *
-or1k_breakpoint_from_pc (struct gdbarch *gdbarch,
-			 CORE_ADDR      *bp_addr,
-			 int            *bp_size)
+or1k_sw_breakpoint_from_kind (struct gdbarch *gdbarch, int kind, int *size)
 {
-  static const gdb_byte breakpoint[] = OR1K_BRK_INSTR_STRUCT;
 
-  *bp_size = OR1K_INSTLEN;
-  return breakpoint;
-
-}	/* or1k_breakpoint_from_pc() */
+  switch (kind)
+    {
+    case OR1K_BP_KIND_OR1K:
+      {
+        static const gdb_byte breakpoint[] = OR1K_BRK_INSTR_STRUCT;
+        
+        *size = OR1K_INSTLEN;
+        return breakpoint;
+      }
+    default:
+      gdb_assert_not_reached ("unexpected or1k breakpoint kind");
+    };
+}	/* or1k_sw_breakpoint_from_kind() */
 
 
 /*----------------------------------------------------------------------------*/
@@ -2056,7 +2089,8 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 
   /* Information about the target architecture */
   set_gdbarch_return_value          (gdbarch, or1k_return_value);
-  set_gdbarch_breakpoint_from_pc    (gdbarch, or1k_breakpoint_from_pc);
+  set_gdbarch_breakpoint_kind_from_pc (gdbarch, or1k_breakpoint_kind_from_pc);
+  set_gdbarch_sw_breakpoint_from_kind (gdbarch, or1k_sw_breakpoint_from_kind);
   set_gdbarch_have_nonsteppable_watchpoint
                                     (gdbarch, 1);
 
-- 
2.7.4


