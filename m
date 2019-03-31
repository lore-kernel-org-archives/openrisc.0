From: Stafford Horne <shorne@gmail.com>
Date: Sun, 31 Mar 2019 09:40:38 +0900
Subject: [OpenRISC] [PATCH 2/6] opcodes: Regenerate opcodes for orfp64a32
 spec
In-Reply-To: <20190331004042.12172-1-shorne@gmail.com>
References: <20190331004042.12172-1-shorne@gmail.com>
Message-ID: <20190331004042.12172-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

opcodes/ChangeLog:

	* or1k-asm.c: Regenerated.
	* or1k-desc.c: Regenerated.
	* or1k-desc.h: Regenerated.
	* or1k-dis.c: Regenerated.
	* or1k-ibld.c: Regenerated.
	* or1k-opc.c: Regenerated.
	* or1k-opc.h: Regenerated.
	* or1k-opinst.c: Regenerated.
---
 opcodes/or1k-asm.c    |  19 ++-
 opcodes/or1k-desc.c   | 227 ++++++++++++++++++++++++++---
 opcodes/or1k-desc.h   | 330 +++++++++++++++++++++---------------------
 opcodes/or1k-dis.c    |  19 ++-
 opcodes/or1k-ibld.c   | 114 +++++++++++++--
 opcodes/or1k-opc.c    | 166 ++++++++++++++++++---
 opcodes/or1k-opc.h    |  21 +--
 opcodes/or1k-opinst.c |  51 +++++++
 8 files changed, 716 insertions(+), 231 deletions(-)

diff --git a/opcodes/or1k-asm.c b/opcodes/or1k-asm.c
index 7d058d03f5..f1e20e4ebc 100644
--- a/opcodes/or1k-asm.c
+++ b/opcodes/or1k-asm.c
@@ -466,8 +466,14 @@ or1k_cgen_parse_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RA :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_gpr, & fields->f_r2);
       break;
+    case OR1K_OPERAND_RAD32F :
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fd32r, & fields->f_r2);
+      break;
     case OR1K_OPERAND_RADF :
-      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fdr, & fields->f_r1);
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fdr, & fields->f_r2);
+      break;
+    case OR1K_OPERAND_RADI :
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_i64r, & fields->f_r2);
       break;
     case OR1K_OPERAND_RASF :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fsr, & fields->f_r2);
@@ -475,8 +481,11 @@ or1k_cgen_parse_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RB :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_gpr, & fields->f_r3);
       break;
+    case OR1K_OPERAND_RBD32F :
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fd32r, & fields->f_r3);
+      break;
     case OR1K_OPERAND_RBDF :
-      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fdr, & fields->f_r1);
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fdr, & fields->f_r3);
       break;
     case OR1K_OPERAND_RBSF :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fsr, & fields->f_r3);
@@ -484,9 +493,15 @@ or1k_cgen_parse_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RD :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_gpr, & fields->f_r1);
       break;
+    case OR1K_OPERAND_RDD32F :
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fd32r, & fields->f_r1);
+      break;
     case OR1K_OPERAND_RDDF :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fdr, & fields->f_r1);
       break;
+    case OR1K_OPERAND_RDDI :
+      errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_i64r, & fields->f_r1);
+      break;
     case OR1K_OPERAND_RDSF :
       errmsg = cgen_parse_keyword (cd, strp, & or1k_cgen_opval_h_fsr, & fields->f_r1);
       break;
diff --git a/opcodes/or1k-desc.c b/opcodes/or1k-desc.c
index 486b0f2626..9835d012cd 100644
--- a/opcodes/or1k-desc.c
+++ b/opcodes/or1k-desc.c
@@ -134,6 +134,52 @@ static const CGEN_MACH or1k_cgen_mach_table[] = {
   { 0, 0, 0, 0 }
 };
 
+static CGEN_KEYWORD_ENTRY or1k_cgen_opval_h_gpr_entries[] =
+{
+  { "r0", 0, {0, {{{0, 0}}}}, 0, 0 },
+  { "r1", 1, {0, {{{0, 0}}}}, 0, 0 },
+  { "r2", 2, {0, {{{0, 0}}}}, 0, 0 },
+  { "r3", 3, {0, {{{0, 0}}}}, 0, 0 },
+  { "r4", 4, {0, {{{0, 0}}}}, 0, 0 },
+  { "r5", 5, {0, {{{0, 0}}}}, 0, 0 },
+  { "r6", 6, {0, {{{0, 0}}}}, 0, 0 },
+  { "r7", 7, {0, {{{0, 0}}}}, 0, 0 },
+  { "r8", 8, {0, {{{0, 0}}}}, 0, 0 },
+  { "r9", 9, {0, {{{0, 0}}}}, 0, 0 },
+  { "r10", 10, {0, {{{0, 0}}}}, 0, 0 },
+  { "r11", 11, {0, {{{0, 0}}}}, 0, 0 },
+  { "r12", 12, {0, {{{0, 0}}}}, 0, 0 },
+  { "r13", 13, {0, {{{0, 0}}}}, 0, 0 },
+  { "r14", 14, {0, {{{0, 0}}}}, 0, 0 },
+  { "r15", 15, {0, {{{0, 0}}}}, 0, 0 },
+  { "r16", 16, {0, {{{0, 0}}}}, 0, 0 },
+  { "r17", 17, {0, {{{0, 0}}}}, 0, 0 },
+  { "r18", 18, {0, {{{0, 0}}}}, 0, 0 },
+  { "r19", 19, {0, {{{0, 0}}}}, 0, 0 },
+  { "r20", 20, {0, {{{0, 0}}}}, 0, 0 },
+  { "r21", 21, {0, {{{0, 0}}}}, 0, 0 },
+  { "r22", 22, {0, {{{0, 0}}}}, 0, 0 },
+  { "r23", 23, {0, {{{0, 0}}}}, 0, 0 },
+  { "r24", 24, {0, {{{0, 0}}}}, 0, 0 },
+  { "r25", 25, {0, {{{0, 0}}}}, 0, 0 },
+  { "r26", 26, {0, {{{0, 0}}}}, 0, 0 },
+  { "r27", 27, {0, {{{0, 0}}}}, 0, 0 },
+  { "r28", 28, {0, {{{0, 0}}}}, 0, 0 },
+  { "r29", 29, {0, {{{0, 0}}}}, 0, 0 },
+  { "r30", 30, {0, {{{0, 0}}}}, 0, 0 },
+  { "r31", 31, {0, {{{0, 0}}}}, 0, 0 },
+  { "lr", 9, {0, {{{0, 0}}}}, 0, 0 },
+  { "sp", 1, {0, {{{0, 0}}}}, 0, 0 },
+  { "fp", 2, {0, {{{0, 0}}}}, 0, 0 }
+};
+
+CGEN_KEYWORD or1k_cgen_opval_h_gpr =
+{
+  & or1k_cgen_opval_h_gpr_entries[0],
+  35,
+  0, 0, 0, 0, ""
+};
+
 static CGEN_KEYWORD_ENTRY or1k_cgen_opval_h_fsr_entries[] =
 {
   { "r0", 0, {0, {{{0, 0}}}}, 0, 0 },
@@ -226,7 +272,7 @@ CGEN_KEYWORD or1k_cgen_opval_h_fdr =
   0, 0, 0, 0, ""
 };
 
-static CGEN_KEYWORD_ENTRY or1k_cgen_opval_h_gpr_entries[] =
+static CGEN_KEYWORD_ENTRY or1k_cgen_opval_h_fd32r_entries[] =
 {
   { "r0", 0, {0, {{{0, 0}}}}, 0, 0 },
   { "r1", 1, {0, {{{0, 0}}}}, 0, 0 },
@@ -265,9 +311,55 @@ static CGEN_KEYWORD_ENTRY or1k_cgen_opval_h_gpr_entries[] =
   { "fp", 2, {0, {{{0, 0}}}}, 0, 0 }
 };
 
-CGEN_KEYWORD or1k_cgen_opval_h_gpr =
+CGEN_KEYWORD or1k_cgen_opval_h_fd32r =
 {
-  & or1k_cgen_opval_h_gpr_entries[0],
+  & or1k_cgen_opval_h_fd32r_entries[0],
+  35,
+  0, 0, 0, 0, ""
+};
+
+static CGEN_KEYWORD_ENTRY or1k_cgen_opval_h_i64r_entries[] =
+{
+  { "r0", 0, {0, {{{0, 0}}}}, 0, 0 },
+  { "r1", 1, {0, {{{0, 0}}}}, 0, 0 },
+  { "r2", 2, {0, {{{0, 0}}}}, 0, 0 },
+  { "r3", 3, {0, {{{0, 0}}}}, 0, 0 },
+  { "r4", 4, {0, {{{0, 0}}}}, 0, 0 },
+  { "r5", 5, {0, {{{0, 0}}}}, 0, 0 },
+  { "r6", 6, {0, {{{0, 0}}}}, 0, 0 },
+  { "r7", 7, {0, {{{0, 0}}}}, 0, 0 },
+  { "r8", 8, {0, {{{0, 0}}}}, 0, 0 },
+  { "r9", 9, {0, {{{0, 0}}}}, 0, 0 },
+  { "r10", 10, {0, {{{0, 0}}}}, 0, 0 },
+  { "r11", 11, {0, {{{0, 0}}}}, 0, 0 },
+  { "r12", 12, {0, {{{0, 0}}}}, 0, 0 },
+  { "r13", 13, {0, {{{0, 0}}}}, 0, 0 },
+  { "r14", 14, {0, {{{0, 0}}}}, 0, 0 },
+  { "r15", 15, {0, {{{0, 0}}}}, 0, 0 },
+  { "r16", 16, {0, {{{0, 0}}}}, 0, 0 },
+  { "r17", 17, {0, {{{0, 0}}}}, 0, 0 },
+  { "r18", 18, {0, {{{0, 0}}}}, 0, 0 },
+  { "r19", 19, {0, {{{0, 0}}}}, 0, 0 },
+  { "r20", 20, {0, {{{0, 0}}}}, 0, 0 },
+  { "r21", 21, {0, {{{0, 0}}}}, 0, 0 },
+  { "r22", 22, {0, {{{0, 0}}}}, 0, 0 },
+  { "r23", 23, {0, {{{0, 0}}}}, 0, 0 },
+  { "r24", 24, {0, {{{0, 0}}}}, 0, 0 },
+  { "r25", 25, {0, {{{0, 0}}}}, 0, 0 },
+  { "r26", 26, {0, {{{0, 0}}}}, 0, 0 },
+  { "r27", 27, {0, {{{0, 0}}}}, 0, 0 },
+  { "r28", 28, {0, {{{0, 0}}}}, 0, 0 },
+  { "r29", 29, {0, {{{0, 0}}}}, 0, 0 },
+  { "r30", 30, {0, {{{0, 0}}}}, 0, 0 },
+  { "r31", 31, {0, {{{0, 0}}}}, 0, 0 },
+  { "lr", 9, {0, {{{0, 0}}}}, 0, 0 },
+  { "sp", 1, {0, {{{0, 0}}}}, 0, 0 },
+  { "fp", 2, {0, {{{0, 0}}}}, 0, 0 }
+};
+
+CGEN_KEYWORD or1k_cgen_opval_h_i64r =
+{
+  & or1k_cgen_opval_h_i64r_entries[0],
   35,
   0, 0, 0, 0, ""
 };
@@ -285,10 +377,12 @@ const CGEN_HW_ENTRY or1k_cgen_hw_table[] =
   { "h-addr", HW_H_ADDR, CGEN_ASM_NONE, 0, { 0, { { { (1<<MACH_BASE), 0 } } } } },
   { "h-iaddr", HW_H_IADDR, CGEN_ASM_NONE, 0, { 0, { { { (1<<MACH_BASE), 0 } } } } },
   { "h-pc", HW_H_PC, CGEN_ASM_NONE, 0, { 0|A(PC), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
-  { "h-fsr", HW_H_FSR, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_fsr, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
-  { "h-fdr", HW_H_FDR, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_fdr, { 0|A(VIRTUAL), { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
   { "h-spr", HW_H_SPR, CGEN_ASM_NONE, 0, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
   { "h-gpr", HW_H_GPR, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_gpr, { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
+  { "h-fsr", HW_H_FSR, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_fsr, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
+  { "h-fdr", HW_H_FDR, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_fdr, { 0|A(VIRTUAL), { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
+  { "h-fd32r", HW_H_FD32R, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_fd32r, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } } },
+  { "h-i64r", HW_H_I64R, CGEN_ASM_KEYWORD, (PTR) & or1k_cgen_opval_h_i64r, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } } },
   { "h-sys-vr", HW_H_SYS_VR, CGEN_ASM_NONE, 0, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
   { "h-sys-upr", HW_H_SYS_UPR, CGEN_ASM_NONE, 0, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
   { "h-sys-cpucfgr", HW_H_SYS_CPUCFGR, CGEN_ASM_NONE, 0, { 0|A(VIRTUAL), { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } } },
@@ -1124,18 +1218,38 @@ const CGEN_OPERAND or1k_cgen_operand_table[] =
   { "rBSF", OR1K_OPERAND_RBSF, HW_H_FSR, 15, 5,
     { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R3] } },
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }  },
-/* rDDF: destination register (double floating point mode) */
+/* rDDF: or64 destination register (double floating point mode) */
   { "rDDF", OR1K_OPERAND_RDDF, HW_H_FDR, 25, 5,
     { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R1] } },
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }  },
-/* rADF: source register A (double floating point mode) */
-  { "rADF", OR1K_OPERAND_RADF, HW_H_FDR, 25, 5,
-    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R1] } },
+/* rADF: or64 source register A (double floating point mode) */
+  { "rADF", OR1K_OPERAND_RADF, HW_H_FDR, 20, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R2] } },
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }  },
-/* rBDF: source register B (double floating point mode) */
-  { "rBDF", OR1K_OPERAND_RBDF, HW_H_FDR, 25, 5,
-    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R1] } },
+/* rBDF: or64 source register B (double floating point mode) */
+  { "rBDF", OR1K_OPERAND_RBDF, HW_H_FDR, 15, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R3] } },
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }  },
+/* rDD32F: or32 destination register (double floating point mode) */
+  { "rDD32F", OR1K_OPERAND_RDD32F, HW_H_FD32R, 25, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R1] } },
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }  },
+/* rAD32F: or32 source register A (double floating point mode) */
+  { "rAD32F", OR1K_OPERAND_RAD32F, HW_H_FD32R, 20, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R2] } },
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }  },
+/* rBD32F: or32 source register B (double floating point mode) */
+  { "rBD32F", OR1K_OPERAND_RBD32F, HW_H_FD32R, 15, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R3] } },
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }  },
+/* rDDI: or32 destination register (double integer mode) */
+  { "rDDI", OR1K_OPERAND_RDDI, HW_H_I64R, 25, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R1] } },
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }  },
+/* rADI: or32 source register A (double integer mode) */
+  { "rADI", OR1K_OPERAND_RADI, HW_H_I64R, 20, 5,
+    { 0, { (const PTR) &or1k_cgen_ifld_table[OR1K_F_R2] } },
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }  },
 /* sentinel */
   { 0, 0, 0, 0, 0,
     { 0, { (const PTR) 0 } },
@@ -1656,6 +1770,11 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_ADD_D, "lf-add-d", "lf.add.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.add.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_ADD_D32, "lf-add-d32", "lf.add.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sub.s $rDSF,$rASF,$rBSF */
   {
     OR1K_INSN_LF_SUB_S, "lf-sub-s", "lf.sub.s", 32,
@@ -1666,6 +1785,11 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_SUB_D, "lf-sub-d", "lf.sub.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sub.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_SUB_D32, "lf-sub-d32", "lf.sub.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.mul.s $rDSF,$rASF,$rBSF */
   {
     OR1K_INSN_LF_MUL_S, "lf-mul-s", "lf.mul.s", 32,
@@ -1676,6 +1800,11 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_MUL_D, "lf-mul-d", "lf.mul.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.mul.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_MUL_D32, "lf-mul-d32", "lf.mul.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.div.s $rDSF,$rASF,$rBSF */
   {
     OR1K_INSN_LF_DIV_S, "lf-div-s", "lf.div.s", 32,
@@ -1686,6 +1815,11 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_DIV_D, "lf-div-d", "lf.div.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.div.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_DIV_D32, "lf-div-d32", "lf.div.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.rem.s $rDSF,$rASF,$rBSF */
   {
     OR1K_INSN_LF_REM_S, "lf-rem-s", "lf.rem.s", 32,
@@ -1696,16 +1830,26 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_REM_D, "lf-rem-d", "lf.rem.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.rem.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_REM_D32, "lf-rem-d32", "lf.rem.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.itof.s $rDSF,$rA */
   {
     OR1K_INSN_LF_ITOF_S, "lf-itof-s", "lf.itof.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.itof.d $rDSF,$rA */
+/* lf.itof.d $rDDF,$rA */
   {
     OR1K_INSN_LF_ITOF_D, "lf-itof-d", "lf.itof.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.itof.d $rDD32F,$rADI */
+  {
+    OR1K_INSN_LF_ITOF_D32, "lf-itof-d32", "lf.itof.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.ftoi.s $rD,$rASF */
   {
     OR1K_INSN_LF_FTOI_S, "lf-ftoi-s", "lf.ftoi.s", 32,
@@ -1716,66 +1860,101 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_FTOI_D, "lf-ftoi-d", "lf.ftoi.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.ftoi.d $rDDI,$rAD32F */
+  {
+    OR1K_INSN_LF_FTOI_D32, "lf-ftoi-d32", "lf.ftoi.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sfeq.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_EQ_S, "lf-eq-s", "lf.sfeq.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.sfeq.d $rASF,$rBSF */
+/* lf.sfeq.d $rADF,$rBDF */
   {
     OR1K_INSN_LF_EQ_D, "lf-eq-d", "lf.sfeq.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sfeq.d $rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_EQ_D32, "lf-eq-d32", "lf.sfeq.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sfne.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_NE_S, "lf-ne-s", "lf.sfne.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.sfne.d $rASF,$rBSF */
+/* lf.sfne.d $rADF,$rBDF */
   {
     OR1K_INSN_LF_NE_D, "lf-ne-d", "lf.sfne.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sfne.d $rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_NE_D32, "lf-ne-d32", "lf.sfne.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sfge.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_GE_S, "lf-ge-s", "lf.sfge.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.sfge.d $rASF,$rBSF */
+/* lf.sfge.d $rADF,$rBDF */
   {
     OR1K_INSN_LF_GE_D, "lf-ge-d", "lf.sfge.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sfge.d $rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_GE_D32, "lf-ge-d32", "lf.sfge.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sfgt.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_GT_S, "lf-gt-s", "lf.sfgt.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.sfgt.d $rASF,$rBSF */
+/* lf.sfgt.d $rADF,$rBDF */
   {
     OR1K_INSN_LF_GT_D, "lf-gt-d", "lf.sfgt.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sfgt.d $rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_GT_D32, "lf-gt-d32", "lf.sfgt.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sflt.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_LT_S, "lf-lt-s", "lf.sflt.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.sflt.d $rASF,$rBSF */
+/* lf.sflt.d $rADF,$rBDF */
   {
     OR1K_INSN_LF_LT_D, "lf-lt-d", "lf.sflt.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sflt.d $rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_LT_D32, "lf-lt-d32", "lf.sflt.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.sfle.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_LE_S, "lf-le-s", "lf.sfle.s", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* lf.sfle.d $rASF,$rBSF */
+/* lf.sfle.d $rADF,$rBDF */
   {
     OR1K_INSN_LF_LE_D, "lf-le-d", "lf.sfle.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.sfle.d $rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_LE_D32, "lf-le-d32", "lf.sfle.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.madd.s $rDSF,$rASF,$rBSF */
   {
     OR1K_INSN_LF_MADD_S, "lf-madd-s", "lf.madd.s", 32,
@@ -1786,6 +1965,11 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_MADD_D, "lf-madd-d", "lf.madd.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.madd.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    OR1K_INSN_LF_MADD_D32, "lf-madd-d32", "lf.madd.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 /* lf.cust1.s $rASF,$rBSF */
   {
     OR1K_INSN_LF_CUST1_S, "lf-cust1-s", "lf.cust1.s", 32,
@@ -1796,6 +1980,11 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_LF_CUST1_D, "lf-cust1-d", "lf.cust1.d", 32,
     { 0, { { { (1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* lf.cust1.d */
+  {
+    OR1K_INSN_LF_CUST1_D32, "lf-cust1-d32", "lf.cust1.d", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND), 0 } } } }
+  },
 };
 
 #undef OP
diff --git a/opcodes/or1k-desc.h b/opcodes/or1k-desc.h
index ade9241a93..de1f094a38 100644
--- a/opcodes/or1k-desc.h
+++ b/opcodes/or1k-desc.h
@@ -429,166 +429,167 @@ typedef enum cgen_hw_attr {
 /* Enum declaration for or1k hardware types.  */
 typedef enum cgen_hw_type {
   HW_H_MEMORY, HW_H_SINT, HW_H_UINT, HW_H_ADDR
- , HW_H_IADDR, HW_H_PC, HW_H_FSR, HW_H_FDR
- , HW_H_SPR, HW_H_GPR, HW_H_SYS_VR, HW_H_SYS_UPR
- , HW_H_SYS_CPUCFGR, HW_H_SYS_DMMUCFGR, HW_H_SYS_IMMUCFGR, HW_H_SYS_DCCFGR
- , HW_H_SYS_ICCFGR, HW_H_SYS_DCFGR, HW_H_SYS_PCCFGR, HW_H_SYS_NPC
- , HW_H_SYS_SR, HW_H_SYS_PPC, HW_H_SYS_FPCSR, HW_H_SYS_EPCR0
- , HW_H_SYS_EPCR1, HW_H_SYS_EPCR2, HW_H_SYS_EPCR3, HW_H_SYS_EPCR4
- , HW_H_SYS_EPCR5, HW_H_SYS_EPCR6, HW_H_SYS_EPCR7, HW_H_SYS_EPCR8
- , HW_H_SYS_EPCR9, HW_H_SYS_EPCR10, HW_H_SYS_EPCR11, HW_H_SYS_EPCR12
- , HW_H_SYS_EPCR13, HW_H_SYS_EPCR14, HW_H_SYS_EPCR15, HW_H_SYS_EEAR0
- , HW_H_SYS_EEAR1, HW_H_SYS_EEAR2, HW_H_SYS_EEAR3, HW_H_SYS_EEAR4
- , HW_H_SYS_EEAR5, HW_H_SYS_EEAR6, HW_H_SYS_EEAR7, HW_H_SYS_EEAR8
- , HW_H_SYS_EEAR9, HW_H_SYS_EEAR10, HW_H_SYS_EEAR11, HW_H_SYS_EEAR12
- , HW_H_SYS_EEAR13, HW_H_SYS_EEAR14, HW_H_SYS_EEAR15, HW_H_SYS_ESR0
- , HW_H_SYS_ESR1, HW_H_SYS_ESR2, HW_H_SYS_ESR3, HW_H_SYS_ESR4
- , HW_H_SYS_ESR5, HW_H_SYS_ESR6, HW_H_SYS_ESR7, HW_H_SYS_ESR8
- , HW_H_SYS_ESR9, HW_H_SYS_ESR10, HW_H_SYS_ESR11, HW_H_SYS_ESR12
- , HW_H_SYS_ESR13, HW_H_SYS_ESR14, HW_H_SYS_ESR15, HW_H_SYS_GPR0
- , HW_H_SYS_GPR1, HW_H_SYS_GPR2, HW_H_SYS_GPR3, HW_H_SYS_GPR4
- , HW_H_SYS_GPR5, HW_H_SYS_GPR6, HW_H_SYS_GPR7, HW_H_SYS_GPR8
- , HW_H_SYS_GPR9, HW_H_SYS_GPR10, HW_H_SYS_GPR11, HW_H_SYS_GPR12
- , HW_H_SYS_GPR13, HW_H_SYS_GPR14, HW_H_SYS_GPR15, HW_H_SYS_GPR16
- , HW_H_SYS_GPR17, HW_H_SYS_GPR18, HW_H_SYS_GPR19, HW_H_SYS_GPR20
- , HW_H_SYS_GPR21, HW_H_SYS_GPR22, HW_H_SYS_GPR23, HW_H_SYS_GPR24
- , HW_H_SYS_GPR25, HW_H_SYS_GPR26, HW_H_SYS_GPR27, HW_H_SYS_GPR28
- , HW_H_SYS_GPR29, HW_H_SYS_GPR30, HW_H_SYS_GPR31, HW_H_SYS_GPR32
- , HW_H_SYS_GPR33, HW_H_SYS_GPR34, HW_H_SYS_GPR35, HW_H_SYS_GPR36
- , HW_H_SYS_GPR37, HW_H_SYS_GPR38, HW_H_SYS_GPR39, HW_H_SYS_GPR40
- , HW_H_SYS_GPR41, HW_H_SYS_GPR42, HW_H_SYS_GPR43, HW_H_SYS_GPR44
- , HW_H_SYS_GPR45, HW_H_SYS_GPR46, HW_H_SYS_GPR47, HW_H_SYS_GPR48
- , HW_H_SYS_GPR49, HW_H_SYS_GPR50, HW_H_SYS_GPR51, HW_H_SYS_GPR52
- , HW_H_SYS_GPR53, HW_H_SYS_GPR54, HW_H_SYS_GPR55, HW_H_SYS_GPR56
- , HW_H_SYS_GPR57, HW_H_SYS_GPR58, HW_H_SYS_GPR59, HW_H_SYS_GPR60
- , HW_H_SYS_GPR61, HW_H_SYS_GPR62, HW_H_SYS_GPR63, HW_H_SYS_GPR64
- , HW_H_SYS_GPR65, HW_H_SYS_GPR66, HW_H_SYS_GPR67, HW_H_SYS_GPR68
- , HW_H_SYS_GPR69, HW_H_SYS_GPR70, HW_H_SYS_GPR71, HW_H_SYS_GPR72
- , HW_H_SYS_GPR73, HW_H_SYS_GPR74, HW_H_SYS_GPR75, HW_H_SYS_GPR76
- , HW_H_SYS_GPR77, HW_H_SYS_GPR78, HW_H_SYS_GPR79, HW_H_SYS_GPR80
- , HW_H_SYS_GPR81, HW_H_SYS_GPR82, HW_H_SYS_GPR83, HW_H_SYS_GPR84
- , HW_H_SYS_GPR85, HW_H_SYS_GPR86, HW_H_SYS_GPR87, HW_H_SYS_GPR88
- , HW_H_SYS_GPR89, HW_H_SYS_GPR90, HW_H_SYS_GPR91, HW_H_SYS_GPR92
- , HW_H_SYS_GPR93, HW_H_SYS_GPR94, HW_H_SYS_GPR95, HW_H_SYS_GPR96
- , HW_H_SYS_GPR97, HW_H_SYS_GPR98, HW_H_SYS_GPR99, HW_H_SYS_GPR100
- , HW_H_SYS_GPR101, HW_H_SYS_GPR102, HW_H_SYS_GPR103, HW_H_SYS_GPR104
- , HW_H_SYS_GPR105, HW_H_SYS_GPR106, HW_H_SYS_GPR107, HW_H_SYS_GPR108
- , HW_H_SYS_GPR109, HW_H_SYS_GPR110, HW_H_SYS_GPR111, HW_H_SYS_GPR112
- , HW_H_SYS_GPR113, HW_H_SYS_GPR114, HW_H_SYS_GPR115, HW_H_SYS_GPR116
- , HW_H_SYS_GPR117, HW_H_SYS_GPR118, HW_H_SYS_GPR119, HW_H_SYS_GPR120
- , HW_H_SYS_GPR121, HW_H_SYS_GPR122, HW_H_SYS_GPR123, HW_H_SYS_GPR124
- , HW_H_SYS_GPR125, HW_H_SYS_GPR126, HW_H_SYS_GPR127, HW_H_SYS_GPR128
- , HW_H_SYS_GPR129, HW_H_SYS_GPR130, HW_H_SYS_GPR131, HW_H_SYS_GPR132
- , HW_H_SYS_GPR133, HW_H_SYS_GPR134, HW_H_SYS_GPR135, HW_H_SYS_GPR136
- , HW_H_SYS_GPR137, HW_H_SYS_GPR138, HW_H_SYS_GPR139, HW_H_SYS_GPR140
- , HW_H_SYS_GPR141, HW_H_SYS_GPR142, HW_H_SYS_GPR143, HW_H_SYS_GPR144
- , HW_H_SYS_GPR145, HW_H_SYS_GPR146, HW_H_SYS_GPR147, HW_H_SYS_GPR148
- , HW_H_SYS_GPR149, HW_H_SYS_GPR150, HW_H_SYS_GPR151, HW_H_SYS_GPR152
- , HW_H_SYS_GPR153, HW_H_SYS_GPR154, HW_H_SYS_GPR155, HW_H_SYS_GPR156
- , HW_H_SYS_GPR157, HW_H_SYS_GPR158, HW_H_SYS_GPR159, HW_H_SYS_GPR160
- , HW_H_SYS_GPR161, HW_H_SYS_GPR162, HW_H_SYS_GPR163, HW_H_SYS_GPR164
- , HW_H_SYS_GPR165, HW_H_SYS_GPR166, HW_H_SYS_GPR167, HW_H_SYS_GPR168
- , HW_H_SYS_GPR169, HW_H_SYS_GPR170, HW_H_SYS_GPR171, HW_H_SYS_GPR172
- , HW_H_SYS_GPR173, HW_H_SYS_GPR174, HW_H_SYS_GPR175, HW_H_SYS_GPR176
- , HW_H_SYS_GPR177, HW_H_SYS_GPR178, HW_H_SYS_GPR179, HW_H_SYS_GPR180
- , HW_H_SYS_GPR181, HW_H_SYS_GPR182, HW_H_SYS_GPR183, HW_H_SYS_GPR184
- , HW_H_SYS_GPR185, HW_H_SYS_GPR186, HW_H_SYS_GPR187, HW_H_SYS_GPR188
- , HW_H_SYS_GPR189, HW_H_SYS_GPR190, HW_H_SYS_GPR191, HW_H_SYS_GPR192
- , HW_H_SYS_GPR193, HW_H_SYS_GPR194, HW_H_SYS_GPR195, HW_H_SYS_GPR196
- , HW_H_SYS_GPR197, HW_H_SYS_GPR198, HW_H_SYS_GPR199, HW_H_SYS_GPR200
- , HW_H_SYS_GPR201, HW_H_SYS_GPR202, HW_H_SYS_GPR203, HW_H_SYS_GPR204
- , HW_H_SYS_GPR205, HW_H_SYS_GPR206, HW_H_SYS_GPR207, HW_H_SYS_GPR208
- , HW_H_SYS_GPR209, HW_H_SYS_GPR210, HW_H_SYS_GPR211, HW_H_SYS_GPR212
- , HW_H_SYS_GPR213, HW_H_SYS_GPR214, HW_H_SYS_GPR215, HW_H_SYS_GPR216
- , HW_H_SYS_GPR217, HW_H_SYS_GPR218, HW_H_SYS_GPR219, HW_H_SYS_GPR220
- , HW_H_SYS_GPR221, HW_H_SYS_GPR222, HW_H_SYS_GPR223, HW_H_SYS_GPR224
- , HW_H_SYS_GPR225, HW_H_SYS_GPR226, HW_H_SYS_GPR227, HW_H_SYS_GPR228
- , HW_H_SYS_GPR229, HW_H_SYS_GPR230, HW_H_SYS_GPR231, HW_H_SYS_GPR232
- , HW_H_SYS_GPR233, HW_H_SYS_GPR234, HW_H_SYS_GPR235, HW_H_SYS_GPR236
- , HW_H_SYS_GPR237, HW_H_SYS_GPR238, HW_H_SYS_GPR239, HW_H_SYS_GPR240
- , HW_H_SYS_GPR241, HW_H_SYS_GPR242, HW_H_SYS_GPR243, HW_H_SYS_GPR244
- , HW_H_SYS_GPR245, HW_H_SYS_GPR246, HW_H_SYS_GPR247, HW_H_SYS_GPR248
- , HW_H_SYS_GPR249, HW_H_SYS_GPR250, HW_H_SYS_GPR251, HW_H_SYS_GPR252
- , HW_H_SYS_GPR253, HW_H_SYS_GPR254, HW_H_SYS_GPR255, HW_H_SYS_GPR256
- , HW_H_SYS_GPR257, HW_H_SYS_GPR258, HW_H_SYS_GPR259, HW_H_SYS_GPR260
- , HW_H_SYS_GPR261, HW_H_SYS_GPR262, HW_H_SYS_GPR263, HW_H_SYS_GPR264
- , HW_H_SYS_GPR265, HW_H_SYS_GPR266, HW_H_SYS_GPR267, HW_H_SYS_GPR268
- , HW_H_SYS_GPR269, HW_H_SYS_GPR270, HW_H_SYS_GPR271, HW_H_SYS_GPR272
- , HW_H_SYS_GPR273, HW_H_SYS_GPR274, HW_H_SYS_GPR275, HW_H_SYS_GPR276
- , HW_H_SYS_GPR277, HW_H_SYS_GPR278, HW_H_SYS_GPR279, HW_H_SYS_GPR280
- , HW_H_SYS_GPR281, HW_H_SYS_GPR282, HW_H_SYS_GPR283, HW_H_SYS_GPR284
- , HW_H_SYS_GPR285, HW_H_SYS_GPR286, HW_H_SYS_GPR287, HW_H_SYS_GPR288
- , HW_H_SYS_GPR289, HW_H_SYS_GPR290, HW_H_SYS_GPR291, HW_H_SYS_GPR292
- , HW_H_SYS_GPR293, HW_H_SYS_GPR294, HW_H_SYS_GPR295, HW_H_SYS_GPR296
- , HW_H_SYS_GPR297, HW_H_SYS_GPR298, HW_H_SYS_GPR299, HW_H_SYS_GPR300
- , HW_H_SYS_GPR301, HW_H_SYS_GPR302, HW_H_SYS_GPR303, HW_H_SYS_GPR304
- , HW_H_SYS_GPR305, HW_H_SYS_GPR306, HW_H_SYS_GPR307, HW_H_SYS_GPR308
- , HW_H_SYS_GPR309, HW_H_SYS_GPR310, HW_H_SYS_GPR311, HW_H_SYS_GPR312
- , HW_H_SYS_GPR313, HW_H_SYS_GPR314, HW_H_SYS_GPR315, HW_H_SYS_GPR316
- , HW_H_SYS_GPR317, HW_H_SYS_GPR318, HW_H_SYS_GPR319, HW_H_SYS_GPR320
- , HW_H_SYS_GPR321, HW_H_SYS_GPR322, HW_H_SYS_GPR323, HW_H_SYS_GPR324
- , HW_H_SYS_GPR325, HW_H_SYS_GPR326, HW_H_SYS_GPR327, HW_H_SYS_GPR328
- , HW_H_SYS_GPR329, HW_H_SYS_GPR330, HW_H_SYS_GPR331, HW_H_SYS_GPR332
- , HW_H_SYS_GPR333, HW_H_SYS_GPR334, HW_H_SYS_GPR335, HW_H_SYS_GPR336
- , HW_H_SYS_GPR337, HW_H_SYS_GPR338, HW_H_SYS_GPR339, HW_H_SYS_GPR340
- , HW_H_SYS_GPR341, HW_H_SYS_GPR342, HW_H_SYS_GPR343, HW_H_SYS_GPR344
- , HW_H_SYS_GPR345, HW_H_SYS_GPR346, HW_H_SYS_GPR347, HW_H_SYS_GPR348
- , HW_H_SYS_GPR349, HW_H_SYS_GPR350, HW_H_SYS_GPR351, HW_H_SYS_GPR352
- , HW_H_SYS_GPR353, HW_H_SYS_GPR354, HW_H_SYS_GPR355, HW_H_SYS_GPR356
- , HW_H_SYS_GPR357, HW_H_SYS_GPR358, HW_H_SYS_GPR359, HW_H_SYS_GPR360
- , HW_H_SYS_GPR361, HW_H_SYS_GPR362, HW_H_SYS_GPR363, HW_H_SYS_GPR364
- , HW_H_SYS_GPR365, HW_H_SYS_GPR366, HW_H_SYS_GPR367, HW_H_SYS_GPR368
- , HW_H_SYS_GPR369, HW_H_SYS_GPR370, HW_H_SYS_GPR371, HW_H_SYS_GPR372
- , HW_H_SYS_GPR373, HW_H_SYS_GPR374, HW_H_SYS_GPR375, HW_H_SYS_GPR376
- , HW_H_SYS_GPR377, HW_H_SYS_GPR378, HW_H_SYS_GPR379, HW_H_SYS_GPR380
- , HW_H_SYS_GPR381, HW_H_SYS_GPR382, HW_H_SYS_GPR383, HW_H_SYS_GPR384
- , HW_H_SYS_GPR385, HW_H_SYS_GPR386, HW_H_SYS_GPR387, HW_H_SYS_GPR388
- , HW_H_SYS_GPR389, HW_H_SYS_GPR390, HW_H_SYS_GPR391, HW_H_SYS_GPR392
- , HW_H_SYS_GPR393, HW_H_SYS_GPR394, HW_H_SYS_GPR395, HW_H_SYS_GPR396
- , HW_H_SYS_GPR397, HW_H_SYS_GPR398, HW_H_SYS_GPR399, HW_H_SYS_GPR400
- , HW_H_SYS_GPR401, HW_H_SYS_GPR402, HW_H_SYS_GPR403, HW_H_SYS_GPR404
- , HW_H_SYS_GPR405, HW_H_SYS_GPR406, HW_H_SYS_GPR407, HW_H_SYS_GPR408
- , HW_H_SYS_GPR409, HW_H_SYS_GPR410, HW_H_SYS_GPR411, HW_H_SYS_GPR412
- , HW_H_SYS_GPR413, HW_H_SYS_GPR414, HW_H_SYS_GPR415, HW_H_SYS_GPR416
- , HW_H_SYS_GPR417, HW_H_SYS_GPR418, HW_H_SYS_GPR419, HW_H_SYS_GPR420
- , HW_H_SYS_GPR421, HW_H_SYS_GPR422, HW_H_SYS_GPR423, HW_H_SYS_GPR424
- , HW_H_SYS_GPR425, HW_H_SYS_GPR426, HW_H_SYS_GPR427, HW_H_SYS_GPR428
- , HW_H_SYS_GPR429, HW_H_SYS_GPR430, HW_H_SYS_GPR431, HW_H_SYS_GPR432
- , HW_H_SYS_GPR433, HW_H_SYS_GPR434, HW_H_SYS_GPR435, HW_H_SYS_GPR436
- , HW_H_SYS_GPR437, HW_H_SYS_GPR438, HW_H_SYS_GPR439, HW_H_SYS_GPR440
- , HW_H_SYS_GPR441, HW_H_SYS_GPR442, HW_H_SYS_GPR443, HW_H_SYS_GPR444
- , HW_H_SYS_GPR445, HW_H_SYS_GPR446, HW_H_SYS_GPR447, HW_H_SYS_GPR448
- , HW_H_SYS_GPR449, HW_H_SYS_GPR450, HW_H_SYS_GPR451, HW_H_SYS_GPR452
- , HW_H_SYS_GPR453, HW_H_SYS_GPR454, HW_H_SYS_GPR455, HW_H_SYS_GPR456
- , HW_H_SYS_GPR457, HW_H_SYS_GPR458, HW_H_SYS_GPR459, HW_H_SYS_GPR460
- , HW_H_SYS_GPR461, HW_H_SYS_GPR462, HW_H_SYS_GPR463, HW_H_SYS_GPR464
- , HW_H_SYS_GPR465, HW_H_SYS_GPR466, HW_H_SYS_GPR467, HW_H_SYS_GPR468
- , HW_H_SYS_GPR469, HW_H_SYS_GPR470, HW_H_SYS_GPR471, HW_H_SYS_GPR472
- , HW_H_SYS_GPR473, HW_H_SYS_GPR474, HW_H_SYS_GPR475, HW_H_SYS_GPR476
- , HW_H_SYS_GPR477, HW_H_SYS_GPR478, HW_H_SYS_GPR479, HW_H_SYS_GPR480
- , HW_H_SYS_GPR481, HW_H_SYS_GPR482, HW_H_SYS_GPR483, HW_H_SYS_GPR484
- , HW_H_SYS_GPR485, HW_H_SYS_GPR486, HW_H_SYS_GPR487, HW_H_SYS_GPR488
- , HW_H_SYS_GPR489, HW_H_SYS_GPR490, HW_H_SYS_GPR491, HW_H_SYS_GPR492
- , HW_H_SYS_GPR493, HW_H_SYS_GPR494, HW_H_SYS_GPR495, HW_H_SYS_GPR496
- , HW_H_SYS_GPR497, HW_H_SYS_GPR498, HW_H_SYS_GPR499, HW_H_SYS_GPR500
- , HW_H_SYS_GPR501, HW_H_SYS_GPR502, HW_H_SYS_GPR503, HW_H_SYS_GPR504
- , HW_H_SYS_GPR505, HW_H_SYS_GPR506, HW_H_SYS_GPR507, HW_H_SYS_GPR508
- , HW_H_SYS_GPR509, HW_H_SYS_GPR510, HW_H_SYS_GPR511, HW_H_MAC_MACLO
- , HW_H_MAC_MACHI, HW_H_TICK_TTMR, HW_H_SYS_VR_REV, HW_H_SYS_VR_CFG
- , HW_H_SYS_VR_VER, HW_H_SYS_UPR_UP, HW_H_SYS_UPR_DCP, HW_H_SYS_UPR_ICP
- , HW_H_SYS_UPR_DMP, HW_H_SYS_UPR_MP, HW_H_SYS_UPR_IMP, HW_H_SYS_UPR_DUP
- , HW_H_SYS_UPR_PCUP, HW_H_SYS_UPR_PICP, HW_H_SYS_UPR_PMP, HW_H_SYS_UPR_TTP
- , HW_H_SYS_UPR_CUP, HW_H_SYS_CPUCFGR_NSGR, HW_H_SYS_CPUCFGR_CGF, HW_H_SYS_CPUCFGR_OB32S
- , HW_H_SYS_CPUCFGR_OB64S, HW_H_SYS_CPUCFGR_OF32S, HW_H_SYS_CPUCFGR_OF64S, HW_H_SYS_CPUCFGR_OV64S
- , HW_H_SYS_CPUCFGR_ND, HW_H_SYS_SR_SM, HW_H_SYS_SR_TEE, HW_H_SYS_SR_IEE
- , HW_H_SYS_SR_DCE, HW_H_SYS_SR_ICE, HW_H_SYS_SR_DME, HW_H_SYS_SR_IME
- , HW_H_SYS_SR_LEE, HW_H_SYS_SR_CE, HW_H_SYS_SR_F, HW_H_SYS_SR_CY
- , HW_H_SYS_SR_OV, HW_H_SYS_SR_OVE, HW_H_SYS_SR_DSX, HW_H_SYS_SR_EPH
- , HW_H_SYS_SR_FO, HW_H_SYS_SR_SUMRA, HW_H_SYS_SR_CID, HW_H_SYS_FPCSR_FPEE
- , HW_H_SYS_FPCSR_RM, HW_H_SYS_FPCSR_OVF, HW_H_SYS_FPCSR_UNF, HW_H_SYS_FPCSR_SNF
- , HW_H_SYS_FPCSR_QNF, HW_H_SYS_FPCSR_ZF, HW_H_SYS_FPCSR_IXF, HW_H_SYS_FPCSR_IVF
- , HW_H_SYS_FPCSR_INF, HW_H_SYS_FPCSR_DZF, HW_H_SIMM16, HW_H_UIMM16
- , HW_H_UIMM6, HW_H_ATOMIC_RESERVE, HW_H_ATOMIC_ADDRESS, HW_MAX
+ , HW_H_IADDR, HW_H_PC, HW_H_SPR, HW_H_GPR
+ , HW_H_FSR, HW_H_FDR, HW_H_FD32R, HW_H_I64R
+ , HW_H_SYS_VR, HW_H_SYS_UPR, HW_H_SYS_CPUCFGR, HW_H_SYS_DMMUCFGR
+ , HW_H_SYS_IMMUCFGR, HW_H_SYS_DCCFGR, HW_H_SYS_ICCFGR, HW_H_SYS_DCFGR
+ , HW_H_SYS_PCCFGR, HW_H_SYS_NPC, HW_H_SYS_SR, HW_H_SYS_PPC
+ , HW_H_SYS_FPCSR, HW_H_SYS_EPCR0, HW_H_SYS_EPCR1, HW_H_SYS_EPCR2
+ , HW_H_SYS_EPCR3, HW_H_SYS_EPCR4, HW_H_SYS_EPCR5, HW_H_SYS_EPCR6
+ , HW_H_SYS_EPCR7, HW_H_SYS_EPCR8, HW_H_SYS_EPCR9, HW_H_SYS_EPCR10
+ , HW_H_SYS_EPCR11, HW_H_SYS_EPCR12, HW_H_SYS_EPCR13, HW_H_SYS_EPCR14
+ , HW_H_SYS_EPCR15, HW_H_SYS_EEAR0, HW_H_SYS_EEAR1, HW_H_SYS_EEAR2
+ , HW_H_SYS_EEAR3, HW_H_SYS_EEAR4, HW_H_SYS_EEAR5, HW_H_SYS_EEAR6
+ , HW_H_SYS_EEAR7, HW_H_SYS_EEAR8, HW_H_SYS_EEAR9, HW_H_SYS_EEAR10
+ , HW_H_SYS_EEAR11, HW_H_SYS_EEAR12, HW_H_SYS_EEAR13, HW_H_SYS_EEAR14
+ , HW_H_SYS_EEAR15, HW_H_SYS_ESR0, HW_H_SYS_ESR1, HW_H_SYS_ESR2
+ , HW_H_SYS_ESR3, HW_H_SYS_ESR4, HW_H_SYS_ESR5, HW_H_SYS_ESR6
+ , HW_H_SYS_ESR7, HW_H_SYS_ESR8, HW_H_SYS_ESR9, HW_H_SYS_ESR10
+ , HW_H_SYS_ESR11, HW_H_SYS_ESR12, HW_H_SYS_ESR13, HW_H_SYS_ESR14
+ , HW_H_SYS_ESR15, HW_H_SYS_GPR0, HW_H_SYS_GPR1, HW_H_SYS_GPR2
+ , HW_H_SYS_GPR3, HW_H_SYS_GPR4, HW_H_SYS_GPR5, HW_H_SYS_GPR6
+ , HW_H_SYS_GPR7, HW_H_SYS_GPR8, HW_H_SYS_GPR9, HW_H_SYS_GPR10
+ , HW_H_SYS_GPR11, HW_H_SYS_GPR12, HW_H_SYS_GPR13, HW_H_SYS_GPR14
+ , HW_H_SYS_GPR15, HW_H_SYS_GPR16, HW_H_SYS_GPR17, HW_H_SYS_GPR18
+ , HW_H_SYS_GPR19, HW_H_SYS_GPR20, HW_H_SYS_GPR21, HW_H_SYS_GPR22
+ , HW_H_SYS_GPR23, HW_H_SYS_GPR24, HW_H_SYS_GPR25, HW_H_SYS_GPR26
+ , HW_H_SYS_GPR27, HW_H_SYS_GPR28, HW_H_SYS_GPR29, HW_H_SYS_GPR30
+ , HW_H_SYS_GPR31, HW_H_SYS_GPR32, HW_H_SYS_GPR33, HW_H_SYS_GPR34
+ , HW_H_SYS_GPR35, HW_H_SYS_GPR36, HW_H_SYS_GPR37, HW_H_SYS_GPR38
+ , HW_H_SYS_GPR39, HW_H_SYS_GPR40, HW_H_SYS_GPR41, HW_H_SYS_GPR42
+ , HW_H_SYS_GPR43, HW_H_SYS_GPR44, HW_H_SYS_GPR45, HW_H_SYS_GPR46
+ , HW_H_SYS_GPR47, HW_H_SYS_GPR48, HW_H_SYS_GPR49, HW_H_SYS_GPR50
+ , HW_H_SYS_GPR51, HW_H_SYS_GPR52, HW_H_SYS_GPR53, HW_H_SYS_GPR54
+ , HW_H_SYS_GPR55, HW_H_SYS_GPR56, HW_H_SYS_GPR57, HW_H_SYS_GPR58
+ , HW_H_SYS_GPR59, HW_H_SYS_GPR60, HW_H_SYS_GPR61, HW_H_SYS_GPR62
+ , HW_H_SYS_GPR63, HW_H_SYS_GPR64, HW_H_SYS_GPR65, HW_H_SYS_GPR66
+ , HW_H_SYS_GPR67, HW_H_SYS_GPR68, HW_H_SYS_GPR69, HW_H_SYS_GPR70
+ , HW_H_SYS_GPR71, HW_H_SYS_GPR72, HW_H_SYS_GPR73, HW_H_SYS_GPR74
+ , HW_H_SYS_GPR75, HW_H_SYS_GPR76, HW_H_SYS_GPR77, HW_H_SYS_GPR78
+ , HW_H_SYS_GPR79, HW_H_SYS_GPR80, HW_H_SYS_GPR81, HW_H_SYS_GPR82
+ , HW_H_SYS_GPR83, HW_H_SYS_GPR84, HW_H_SYS_GPR85, HW_H_SYS_GPR86
+ , HW_H_SYS_GPR87, HW_H_SYS_GPR88, HW_H_SYS_GPR89, HW_H_SYS_GPR90
+ , HW_H_SYS_GPR91, HW_H_SYS_GPR92, HW_H_SYS_GPR93, HW_H_SYS_GPR94
+ , HW_H_SYS_GPR95, HW_H_SYS_GPR96, HW_H_SYS_GPR97, HW_H_SYS_GPR98
+ , HW_H_SYS_GPR99, HW_H_SYS_GPR100, HW_H_SYS_GPR101, HW_H_SYS_GPR102
+ , HW_H_SYS_GPR103, HW_H_SYS_GPR104, HW_H_SYS_GPR105, HW_H_SYS_GPR106
+ , HW_H_SYS_GPR107, HW_H_SYS_GPR108, HW_H_SYS_GPR109, HW_H_SYS_GPR110
+ , HW_H_SYS_GPR111, HW_H_SYS_GPR112, HW_H_SYS_GPR113, HW_H_SYS_GPR114
+ , HW_H_SYS_GPR115, HW_H_SYS_GPR116, HW_H_SYS_GPR117, HW_H_SYS_GPR118
+ , HW_H_SYS_GPR119, HW_H_SYS_GPR120, HW_H_SYS_GPR121, HW_H_SYS_GPR122
+ , HW_H_SYS_GPR123, HW_H_SYS_GPR124, HW_H_SYS_GPR125, HW_H_SYS_GPR126
+ , HW_H_SYS_GPR127, HW_H_SYS_GPR128, HW_H_SYS_GPR129, HW_H_SYS_GPR130
+ , HW_H_SYS_GPR131, HW_H_SYS_GPR132, HW_H_SYS_GPR133, HW_H_SYS_GPR134
+ , HW_H_SYS_GPR135, HW_H_SYS_GPR136, HW_H_SYS_GPR137, HW_H_SYS_GPR138
+ , HW_H_SYS_GPR139, HW_H_SYS_GPR140, HW_H_SYS_GPR141, HW_H_SYS_GPR142
+ , HW_H_SYS_GPR143, HW_H_SYS_GPR144, HW_H_SYS_GPR145, HW_H_SYS_GPR146
+ , HW_H_SYS_GPR147, HW_H_SYS_GPR148, HW_H_SYS_GPR149, HW_H_SYS_GPR150
+ , HW_H_SYS_GPR151, HW_H_SYS_GPR152, HW_H_SYS_GPR153, HW_H_SYS_GPR154
+ , HW_H_SYS_GPR155, HW_H_SYS_GPR156, HW_H_SYS_GPR157, HW_H_SYS_GPR158
+ , HW_H_SYS_GPR159, HW_H_SYS_GPR160, HW_H_SYS_GPR161, HW_H_SYS_GPR162
+ , HW_H_SYS_GPR163, HW_H_SYS_GPR164, HW_H_SYS_GPR165, HW_H_SYS_GPR166
+ , HW_H_SYS_GPR167, HW_H_SYS_GPR168, HW_H_SYS_GPR169, HW_H_SYS_GPR170
+ , HW_H_SYS_GPR171, HW_H_SYS_GPR172, HW_H_SYS_GPR173, HW_H_SYS_GPR174
+ , HW_H_SYS_GPR175, HW_H_SYS_GPR176, HW_H_SYS_GPR177, HW_H_SYS_GPR178
+ , HW_H_SYS_GPR179, HW_H_SYS_GPR180, HW_H_SYS_GPR181, HW_H_SYS_GPR182
+ , HW_H_SYS_GPR183, HW_H_SYS_GPR184, HW_H_SYS_GPR185, HW_H_SYS_GPR186
+ , HW_H_SYS_GPR187, HW_H_SYS_GPR188, HW_H_SYS_GPR189, HW_H_SYS_GPR190
+ , HW_H_SYS_GPR191, HW_H_SYS_GPR192, HW_H_SYS_GPR193, HW_H_SYS_GPR194
+ , HW_H_SYS_GPR195, HW_H_SYS_GPR196, HW_H_SYS_GPR197, HW_H_SYS_GPR198
+ , HW_H_SYS_GPR199, HW_H_SYS_GPR200, HW_H_SYS_GPR201, HW_H_SYS_GPR202
+ , HW_H_SYS_GPR203, HW_H_SYS_GPR204, HW_H_SYS_GPR205, HW_H_SYS_GPR206
+ , HW_H_SYS_GPR207, HW_H_SYS_GPR208, HW_H_SYS_GPR209, HW_H_SYS_GPR210
+ , HW_H_SYS_GPR211, HW_H_SYS_GPR212, HW_H_SYS_GPR213, HW_H_SYS_GPR214
+ , HW_H_SYS_GPR215, HW_H_SYS_GPR216, HW_H_SYS_GPR217, HW_H_SYS_GPR218
+ , HW_H_SYS_GPR219, HW_H_SYS_GPR220, HW_H_SYS_GPR221, HW_H_SYS_GPR222
+ , HW_H_SYS_GPR223, HW_H_SYS_GPR224, HW_H_SYS_GPR225, HW_H_SYS_GPR226
+ , HW_H_SYS_GPR227, HW_H_SYS_GPR228, HW_H_SYS_GPR229, HW_H_SYS_GPR230
+ , HW_H_SYS_GPR231, HW_H_SYS_GPR232, HW_H_SYS_GPR233, HW_H_SYS_GPR234
+ , HW_H_SYS_GPR235, HW_H_SYS_GPR236, HW_H_SYS_GPR237, HW_H_SYS_GPR238
+ , HW_H_SYS_GPR239, HW_H_SYS_GPR240, HW_H_SYS_GPR241, HW_H_SYS_GPR242
+ , HW_H_SYS_GPR243, HW_H_SYS_GPR244, HW_H_SYS_GPR245, HW_H_SYS_GPR246
+ , HW_H_SYS_GPR247, HW_H_SYS_GPR248, HW_H_SYS_GPR249, HW_H_SYS_GPR250
+ , HW_H_SYS_GPR251, HW_H_SYS_GPR252, HW_H_SYS_GPR253, HW_H_SYS_GPR254
+ , HW_H_SYS_GPR255, HW_H_SYS_GPR256, HW_H_SYS_GPR257, HW_H_SYS_GPR258
+ , HW_H_SYS_GPR259, HW_H_SYS_GPR260, HW_H_SYS_GPR261, HW_H_SYS_GPR262
+ , HW_H_SYS_GPR263, HW_H_SYS_GPR264, HW_H_SYS_GPR265, HW_H_SYS_GPR266
+ , HW_H_SYS_GPR267, HW_H_SYS_GPR268, HW_H_SYS_GPR269, HW_H_SYS_GPR270
+ , HW_H_SYS_GPR271, HW_H_SYS_GPR272, HW_H_SYS_GPR273, HW_H_SYS_GPR274
+ , HW_H_SYS_GPR275, HW_H_SYS_GPR276, HW_H_SYS_GPR277, HW_H_SYS_GPR278
+ , HW_H_SYS_GPR279, HW_H_SYS_GPR280, HW_H_SYS_GPR281, HW_H_SYS_GPR282
+ , HW_H_SYS_GPR283, HW_H_SYS_GPR284, HW_H_SYS_GPR285, HW_H_SYS_GPR286
+ , HW_H_SYS_GPR287, HW_H_SYS_GPR288, HW_H_SYS_GPR289, HW_H_SYS_GPR290
+ , HW_H_SYS_GPR291, HW_H_SYS_GPR292, HW_H_SYS_GPR293, HW_H_SYS_GPR294
+ , HW_H_SYS_GPR295, HW_H_SYS_GPR296, HW_H_SYS_GPR297, HW_H_SYS_GPR298
+ , HW_H_SYS_GPR299, HW_H_SYS_GPR300, HW_H_SYS_GPR301, HW_H_SYS_GPR302
+ , HW_H_SYS_GPR303, HW_H_SYS_GPR304, HW_H_SYS_GPR305, HW_H_SYS_GPR306
+ , HW_H_SYS_GPR307, HW_H_SYS_GPR308, HW_H_SYS_GPR309, HW_H_SYS_GPR310
+ , HW_H_SYS_GPR311, HW_H_SYS_GPR312, HW_H_SYS_GPR313, HW_H_SYS_GPR314
+ , HW_H_SYS_GPR315, HW_H_SYS_GPR316, HW_H_SYS_GPR317, HW_H_SYS_GPR318
+ , HW_H_SYS_GPR319, HW_H_SYS_GPR320, HW_H_SYS_GPR321, HW_H_SYS_GPR322
+ , HW_H_SYS_GPR323, HW_H_SYS_GPR324, HW_H_SYS_GPR325, HW_H_SYS_GPR326
+ , HW_H_SYS_GPR327, HW_H_SYS_GPR328, HW_H_SYS_GPR329, HW_H_SYS_GPR330
+ , HW_H_SYS_GPR331, HW_H_SYS_GPR332, HW_H_SYS_GPR333, HW_H_SYS_GPR334
+ , HW_H_SYS_GPR335, HW_H_SYS_GPR336, HW_H_SYS_GPR337, HW_H_SYS_GPR338
+ , HW_H_SYS_GPR339, HW_H_SYS_GPR340, HW_H_SYS_GPR341, HW_H_SYS_GPR342
+ , HW_H_SYS_GPR343, HW_H_SYS_GPR344, HW_H_SYS_GPR345, HW_H_SYS_GPR346
+ , HW_H_SYS_GPR347, HW_H_SYS_GPR348, HW_H_SYS_GPR349, HW_H_SYS_GPR350
+ , HW_H_SYS_GPR351, HW_H_SYS_GPR352, HW_H_SYS_GPR353, HW_H_SYS_GPR354
+ , HW_H_SYS_GPR355, HW_H_SYS_GPR356, HW_H_SYS_GPR357, HW_H_SYS_GPR358
+ , HW_H_SYS_GPR359, HW_H_SYS_GPR360, HW_H_SYS_GPR361, HW_H_SYS_GPR362
+ , HW_H_SYS_GPR363, HW_H_SYS_GPR364, HW_H_SYS_GPR365, HW_H_SYS_GPR366
+ , HW_H_SYS_GPR367, HW_H_SYS_GPR368, HW_H_SYS_GPR369, HW_H_SYS_GPR370
+ , HW_H_SYS_GPR371, HW_H_SYS_GPR372, HW_H_SYS_GPR373, HW_H_SYS_GPR374
+ , HW_H_SYS_GPR375, HW_H_SYS_GPR376, HW_H_SYS_GPR377, HW_H_SYS_GPR378
+ , HW_H_SYS_GPR379, HW_H_SYS_GPR380, HW_H_SYS_GPR381, HW_H_SYS_GPR382
+ , HW_H_SYS_GPR383, HW_H_SYS_GPR384, HW_H_SYS_GPR385, HW_H_SYS_GPR386
+ , HW_H_SYS_GPR387, HW_H_SYS_GPR388, HW_H_SYS_GPR389, HW_H_SYS_GPR390
+ , HW_H_SYS_GPR391, HW_H_SYS_GPR392, HW_H_SYS_GPR393, HW_H_SYS_GPR394
+ , HW_H_SYS_GPR395, HW_H_SYS_GPR396, HW_H_SYS_GPR397, HW_H_SYS_GPR398
+ , HW_H_SYS_GPR399, HW_H_SYS_GPR400, HW_H_SYS_GPR401, HW_H_SYS_GPR402
+ , HW_H_SYS_GPR403, HW_H_SYS_GPR404, HW_H_SYS_GPR405, HW_H_SYS_GPR406
+ , HW_H_SYS_GPR407, HW_H_SYS_GPR408, HW_H_SYS_GPR409, HW_H_SYS_GPR410
+ , HW_H_SYS_GPR411, HW_H_SYS_GPR412, HW_H_SYS_GPR413, HW_H_SYS_GPR414
+ , HW_H_SYS_GPR415, HW_H_SYS_GPR416, HW_H_SYS_GPR417, HW_H_SYS_GPR418
+ , HW_H_SYS_GPR419, HW_H_SYS_GPR420, HW_H_SYS_GPR421, HW_H_SYS_GPR422
+ , HW_H_SYS_GPR423, HW_H_SYS_GPR424, HW_H_SYS_GPR425, HW_H_SYS_GPR426
+ , HW_H_SYS_GPR427, HW_H_SYS_GPR428, HW_H_SYS_GPR429, HW_H_SYS_GPR430
+ , HW_H_SYS_GPR431, HW_H_SYS_GPR432, HW_H_SYS_GPR433, HW_H_SYS_GPR434
+ , HW_H_SYS_GPR435, HW_H_SYS_GPR436, HW_H_SYS_GPR437, HW_H_SYS_GPR438
+ , HW_H_SYS_GPR439, HW_H_SYS_GPR440, HW_H_SYS_GPR441, HW_H_SYS_GPR442
+ , HW_H_SYS_GPR443, HW_H_SYS_GPR444, HW_H_SYS_GPR445, HW_H_SYS_GPR446
+ , HW_H_SYS_GPR447, HW_H_SYS_GPR448, HW_H_SYS_GPR449, HW_H_SYS_GPR450
+ , HW_H_SYS_GPR451, HW_H_SYS_GPR452, HW_H_SYS_GPR453, HW_H_SYS_GPR454
+ , HW_H_SYS_GPR455, HW_H_SYS_GPR456, HW_H_SYS_GPR457, HW_H_SYS_GPR458
+ , HW_H_SYS_GPR459, HW_H_SYS_GPR460, HW_H_SYS_GPR461, HW_H_SYS_GPR462
+ , HW_H_SYS_GPR463, HW_H_SYS_GPR464, HW_H_SYS_GPR465, HW_H_SYS_GPR466
+ , HW_H_SYS_GPR467, HW_H_SYS_GPR468, HW_H_SYS_GPR469, HW_H_SYS_GPR470
+ , HW_H_SYS_GPR471, HW_H_SYS_GPR472, HW_H_SYS_GPR473, HW_H_SYS_GPR474
+ , HW_H_SYS_GPR475, HW_H_SYS_GPR476, HW_H_SYS_GPR477, HW_H_SYS_GPR478
+ , HW_H_SYS_GPR479, HW_H_SYS_GPR480, HW_H_SYS_GPR481, HW_H_SYS_GPR482
+ , HW_H_SYS_GPR483, HW_H_SYS_GPR484, HW_H_SYS_GPR485, HW_H_SYS_GPR486
+ , HW_H_SYS_GPR487, HW_H_SYS_GPR488, HW_H_SYS_GPR489, HW_H_SYS_GPR490
+ , HW_H_SYS_GPR491, HW_H_SYS_GPR492, HW_H_SYS_GPR493, HW_H_SYS_GPR494
+ , HW_H_SYS_GPR495, HW_H_SYS_GPR496, HW_H_SYS_GPR497, HW_H_SYS_GPR498
+ , HW_H_SYS_GPR499, HW_H_SYS_GPR500, HW_H_SYS_GPR501, HW_H_SYS_GPR502
+ , HW_H_SYS_GPR503, HW_H_SYS_GPR504, HW_H_SYS_GPR505, HW_H_SYS_GPR506
+ , HW_H_SYS_GPR507, HW_H_SYS_GPR508, HW_H_SYS_GPR509, HW_H_SYS_GPR510
+ , HW_H_SYS_GPR511, HW_H_MAC_MACLO, HW_H_MAC_MACHI, HW_H_TICK_TTMR
+ , HW_H_SYS_VR_REV, HW_H_SYS_VR_CFG, HW_H_SYS_VR_VER, HW_H_SYS_UPR_UP
+ , HW_H_SYS_UPR_DCP, HW_H_SYS_UPR_ICP, HW_H_SYS_UPR_DMP, HW_H_SYS_UPR_MP
+ , HW_H_SYS_UPR_IMP, HW_H_SYS_UPR_DUP, HW_H_SYS_UPR_PCUP, HW_H_SYS_UPR_PICP
+ , HW_H_SYS_UPR_PMP, HW_H_SYS_UPR_TTP, HW_H_SYS_UPR_CUP, HW_H_SYS_CPUCFGR_NSGR
+ , HW_H_SYS_CPUCFGR_CGF, HW_H_SYS_CPUCFGR_OB32S, HW_H_SYS_CPUCFGR_OB64S, HW_H_SYS_CPUCFGR_OF32S
+ , HW_H_SYS_CPUCFGR_OF64S, HW_H_SYS_CPUCFGR_OV64S, HW_H_SYS_CPUCFGR_ND, HW_H_SYS_SR_SM
+ , HW_H_SYS_SR_TEE, HW_H_SYS_SR_IEE, HW_H_SYS_SR_DCE, HW_H_SYS_SR_ICE
+ , HW_H_SYS_SR_DME, HW_H_SYS_SR_IME, HW_H_SYS_SR_LEE, HW_H_SYS_SR_CE
+ , HW_H_SYS_SR_F, HW_H_SYS_SR_CY, HW_H_SYS_SR_OV, HW_H_SYS_SR_OVE
+ , HW_H_SYS_SR_DSX, HW_H_SYS_SR_EPH, HW_H_SYS_SR_FO, HW_H_SYS_SR_SUMRA
+ , HW_H_SYS_SR_CID, HW_H_SYS_FPCSR_FPEE, HW_H_SYS_FPCSR_RM, HW_H_SYS_FPCSR_OVF
+ , HW_H_SYS_FPCSR_UNF, HW_H_SYS_FPCSR_SNF, HW_H_SYS_FPCSR_QNF, HW_H_SYS_FPCSR_ZF
+ , HW_H_SYS_FPCSR_IXF, HW_H_SYS_FPCSR_IVF, HW_H_SYS_FPCSR_INF, HW_H_SYS_FPCSR_DZF
+ , HW_H_SIMM16, HW_H_UIMM16, HW_H_UIMM6, HW_H_ATOMIC_RESERVE
+ , HW_H_ATOMIC_ADDRESS, HW_MAX
 } CGEN_HW_TYPE;
 
 #define MAX_HW ((int) HW_MAX)
@@ -626,11 +627,12 @@ typedef enum cgen_operand_type {
  , OR1K_OPERAND_DISP26, OR1K_OPERAND_DISP21, OR1K_OPERAND_SIMM16, OR1K_OPERAND_UIMM16
  , OR1K_OPERAND_SIMM16_SPLIT, OR1K_OPERAND_UIMM16_SPLIT, OR1K_OPERAND_RDSF, OR1K_OPERAND_RASF
  , OR1K_OPERAND_RBSF, OR1K_OPERAND_RDDF, OR1K_OPERAND_RADF, OR1K_OPERAND_RBDF
- , OR1K_OPERAND_MAX
+ , OR1K_OPERAND_RDD32F, OR1K_OPERAND_RAD32F, OR1K_OPERAND_RBD32F, OR1K_OPERAND_RDDI
+ , OR1K_OPERAND_RADI, OR1K_OPERAND_MAX
 } CGEN_OPERAND_TYPE;
 
 /* Number of operands types.  */
-#define MAX_OPERANDS 32
+#define MAX_OPERANDS 37
 
 /* Maximum number of operands referenced by any insn.  */
 #define MAX_OPERAND_INSTANCES 10
@@ -678,9 +680,11 @@ extern const CGEN_ATTR_TABLE or1k_cgen_insn_attr_table[];
 
 /* Hardware decls.  */
 
+extern CGEN_KEYWORD or1k_cgen_opval_h_gpr;
 extern CGEN_KEYWORD or1k_cgen_opval_h_fsr;
 extern CGEN_KEYWORD or1k_cgen_opval_h_fdr;
-extern CGEN_KEYWORD or1k_cgen_opval_h_gpr;
+extern CGEN_KEYWORD or1k_cgen_opval_h_fd32r;
+extern CGEN_KEYWORD or1k_cgen_opval_h_i64r;
 
 extern const CGEN_HW_ENTRY or1k_cgen_hw_table[];
 
diff --git a/opcodes/or1k-dis.c b/opcodes/or1k-dis.c
index f14c56fec4..c7a80ba4c9 100644
--- a/opcodes/or1k-dis.c
+++ b/opcodes/or1k-dis.c
@@ -99,8 +99,14 @@ or1k_cgen_print_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RA :
       print_keyword (cd, info, & or1k_cgen_opval_h_gpr, fields->f_r2, 0);
       break;
+    case OR1K_OPERAND_RAD32F :
+      print_keyword (cd, info, & or1k_cgen_opval_h_fd32r, fields->f_r2, 0);
+      break;
     case OR1K_OPERAND_RADF :
-      print_keyword (cd, info, & or1k_cgen_opval_h_fdr, fields->f_r1, 0);
+      print_keyword (cd, info, & or1k_cgen_opval_h_fdr, fields->f_r2, 0);
+      break;
+    case OR1K_OPERAND_RADI :
+      print_keyword (cd, info, & or1k_cgen_opval_h_i64r, fields->f_r2, 0);
       break;
     case OR1K_OPERAND_RASF :
       print_keyword (cd, info, & or1k_cgen_opval_h_fsr, fields->f_r2, 0);
@@ -108,8 +114,11 @@ or1k_cgen_print_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RB :
       print_keyword (cd, info, & or1k_cgen_opval_h_gpr, fields->f_r3, 0);
       break;
+    case OR1K_OPERAND_RBD32F :
+      print_keyword (cd, info, & or1k_cgen_opval_h_fd32r, fields->f_r3, 0);
+      break;
     case OR1K_OPERAND_RBDF :
-      print_keyword (cd, info, & or1k_cgen_opval_h_fdr, fields->f_r1, 0);
+      print_keyword (cd, info, & or1k_cgen_opval_h_fdr, fields->f_r3, 0);
       break;
     case OR1K_OPERAND_RBSF :
       print_keyword (cd, info, & or1k_cgen_opval_h_fsr, fields->f_r3, 0);
@@ -117,9 +126,15 @@ or1k_cgen_print_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RD :
       print_keyword (cd, info, & or1k_cgen_opval_h_gpr, fields->f_r1, 0);
       break;
+    case OR1K_OPERAND_RDD32F :
+      print_keyword (cd, info, & or1k_cgen_opval_h_fd32r, fields->f_r1, 0);
+      break;
     case OR1K_OPERAND_RDDF :
       print_keyword (cd, info, & or1k_cgen_opval_h_fdr, fields->f_r1, 0);
       break;
+    case OR1K_OPERAND_RDDI :
+      print_keyword (cd, info, & or1k_cgen_opval_h_i64r, fields->f_r1, 0);
+      break;
     case OR1K_OPERAND_RDSF :
       print_keyword (cd, info, & or1k_cgen_opval_h_fsr, fields->f_r1, 0);
       break;
diff --git a/opcodes/or1k-ibld.c b/opcodes/or1k-ibld.c
index 964ec33ee8..f60540e7de 100644
--- a/opcodes/or1k-ibld.c
+++ b/opcodes/or1k-ibld.c
@@ -590,8 +590,14 @@ or1k_cgen_insert_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RA :
       errmsg = insert_normal (cd, fields->f_r2, 0, 0, 20, 5, 32, total_length, buffer);
       break;
+    case OR1K_OPERAND_RAD32F :
+      errmsg = insert_normal (cd, fields->f_r2, 0, 0, 20, 5, 32, total_length, buffer);
+      break;
     case OR1K_OPERAND_RADF :
-      errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
+      errmsg = insert_normal (cd, fields->f_r2, 0, 0, 20, 5, 32, total_length, buffer);
+      break;
+    case OR1K_OPERAND_RADI :
+      errmsg = insert_normal (cd, fields->f_r2, 0, 0, 20, 5, 32, total_length, buffer);
       break;
     case OR1K_OPERAND_RASF :
       errmsg = insert_normal (cd, fields->f_r2, 0, 0, 20, 5, 32, total_length, buffer);
@@ -599,8 +605,11 @@ or1k_cgen_insert_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RB :
       errmsg = insert_normal (cd, fields->f_r3, 0, 0, 15, 5, 32, total_length, buffer);
       break;
+    case OR1K_OPERAND_RBD32F :
+      errmsg = insert_normal (cd, fields->f_r3, 0, 0, 15, 5, 32, total_length, buffer);
+      break;
     case OR1K_OPERAND_RBDF :
-      errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
+      errmsg = insert_normal (cd, fields->f_r3, 0, 0, 15, 5, 32, total_length, buffer);
       break;
     case OR1K_OPERAND_RBSF :
       errmsg = insert_normal (cd, fields->f_r3, 0, 0, 15, 5, 32, total_length, buffer);
@@ -608,9 +617,15 @@ or1k_cgen_insert_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RD :
       errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
       break;
+    case OR1K_OPERAND_RDD32F :
+      errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
+      break;
     case OR1K_OPERAND_RDDF :
       errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
       break;
+    case OR1K_OPERAND_RDDI :
+      errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
+      break;
     case OR1K_OPERAND_RDSF :
       errmsg = insert_normal (cd, fields->f_r1, 0, 0, 25, 5, 32, total_length, buffer);
       break;
@@ -714,8 +729,14 @@ or1k_cgen_extract_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RA :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 20, 5, 32, total_length, pc, & fields->f_r2);
       break;
+    case OR1K_OPERAND_RAD32F :
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 20, 5, 32, total_length, pc, & fields->f_r2);
+      break;
     case OR1K_OPERAND_RADF :
-      length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 20, 5, 32, total_length, pc, & fields->f_r2);
+      break;
+    case OR1K_OPERAND_RADI :
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 20, 5, 32, total_length, pc, & fields->f_r2);
       break;
     case OR1K_OPERAND_RASF :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 20, 5, 32, total_length, pc, & fields->f_r2);
@@ -723,8 +744,11 @@ or1k_cgen_extract_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RB :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 15, 5, 32, total_length, pc, & fields->f_r3);
       break;
+    case OR1K_OPERAND_RBD32F :
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 15, 5, 32, total_length, pc, & fields->f_r3);
+      break;
     case OR1K_OPERAND_RBDF :
-      length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 15, 5, 32, total_length, pc, & fields->f_r3);
       break;
     case OR1K_OPERAND_RBSF :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 15, 5, 32, total_length, pc, & fields->f_r3);
@@ -732,9 +756,15 @@ or1k_cgen_extract_operand (CGEN_CPU_DESC cd,
     case OR1K_OPERAND_RD :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
       break;
+    case OR1K_OPERAND_RDD32F :
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
+      break;
     case OR1K_OPERAND_RDDF :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
       break;
+    case OR1K_OPERAND_RDDI :
+      length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
+      break;
     case OR1K_OPERAND_RDSF :
       length = extract_normal (cd, ex_info, insn_value, 0, 0, 25, 5, 32, total_length, pc, & fields->f_r1);
       break;
@@ -813,8 +843,14 @@ or1k_cgen_get_int_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RA :
       value = fields->f_r2;
       break;
+    case OR1K_OPERAND_RAD32F :
+      value = fields->f_r2;
+      break;
     case OR1K_OPERAND_RADF :
-      value = fields->f_r1;
+      value = fields->f_r2;
+      break;
+    case OR1K_OPERAND_RADI :
+      value = fields->f_r2;
       break;
     case OR1K_OPERAND_RASF :
       value = fields->f_r2;
@@ -822,8 +858,11 @@ or1k_cgen_get_int_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RB :
       value = fields->f_r3;
       break;
+    case OR1K_OPERAND_RBD32F :
+      value = fields->f_r3;
+      break;
     case OR1K_OPERAND_RBDF :
-      value = fields->f_r1;
+      value = fields->f_r3;
       break;
     case OR1K_OPERAND_RBSF :
       value = fields->f_r3;
@@ -831,9 +870,15 @@ or1k_cgen_get_int_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RD :
       value = fields->f_r1;
       break;
+    case OR1K_OPERAND_RDD32F :
+      value = fields->f_r1;
+      break;
     case OR1K_OPERAND_RDDF :
       value = fields->f_r1;
       break;
+    case OR1K_OPERAND_RDDI :
+      value = fields->f_r1;
+      break;
     case OR1K_OPERAND_RDSF :
       value = fields->f_r1;
       break;
@@ -882,8 +927,14 @@ or1k_cgen_get_vma_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RA :
       value = fields->f_r2;
       break;
+    case OR1K_OPERAND_RAD32F :
+      value = fields->f_r2;
+      break;
     case OR1K_OPERAND_RADF :
-      value = fields->f_r1;
+      value = fields->f_r2;
+      break;
+    case OR1K_OPERAND_RADI :
+      value = fields->f_r2;
       break;
     case OR1K_OPERAND_RASF :
       value = fields->f_r2;
@@ -891,8 +942,11 @@ or1k_cgen_get_vma_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RB :
       value = fields->f_r3;
       break;
+    case OR1K_OPERAND_RBD32F :
+      value = fields->f_r3;
+      break;
     case OR1K_OPERAND_RBDF :
-      value = fields->f_r1;
+      value = fields->f_r3;
       break;
     case OR1K_OPERAND_RBSF :
       value = fields->f_r3;
@@ -900,9 +954,15 @@ or1k_cgen_get_vma_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RD :
       value = fields->f_r1;
       break;
+    case OR1K_OPERAND_RDD32F :
+      value = fields->f_r1;
+      break;
     case OR1K_OPERAND_RDDF :
       value = fields->f_r1;
       break;
+    case OR1K_OPERAND_RDDI :
+      value = fields->f_r1;
+      break;
     case OR1K_OPERAND_RDSF :
       value = fields->f_r1;
       break;
@@ -958,8 +1018,14 @@ or1k_cgen_set_int_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RA :
       fields->f_r2 = value;
       break;
+    case OR1K_OPERAND_RAD32F :
+      fields->f_r2 = value;
+      break;
     case OR1K_OPERAND_RADF :
-      fields->f_r1 = value;
+      fields->f_r2 = value;
+      break;
+    case OR1K_OPERAND_RADI :
+      fields->f_r2 = value;
       break;
     case OR1K_OPERAND_RASF :
       fields->f_r2 = value;
@@ -967,8 +1033,11 @@ or1k_cgen_set_int_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RB :
       fields->f_r3 = value;
       break;
+    case OR1K_OPERAND_RBD32F :
+      fields->f_r3 = value;
+      break;
     case OR1K_OPERAND_RBDF :
-      fields->f_r1 = value;
+      fields->f_r3 = value;
       break;
     case OR1K_OPERAND_RBSF :
       fields->f_r3 = value;
@@ -976,9 +1045,15 @@ or1k_cgen_set_int_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RD :
       fields->f_r1 = value;
       break;
+    case OR1K_OPERAND_RDD32F :
+      fields->f_r1 = value;
+      break;
     case OR1K_OPERAND_RDDF :
       fields->f_r1 = value;
       break;
+    case OR1K_OPERAND_RDDI :
+      fields->f_r1 = value;
+      break;
     case OR1K_OPERAND_RDSF :
       fields->f_r1 = value;
       break;
@@ -1024,8 +1099,14 @@ or1k_cgen_set_vma_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RA :
       fields->f_r2 = value;
       break;
+    case OR1K_OPERAND_RAD32F :
+      fields->f_r2 = value;
+      break;
     case OR1K_OPERAND_RADF :
-      fields->f_r1 = value;
+      fields->f_r2 = value;
+      break;
+    case OR1K_OPERAND_RADI :
+      fields->f_r2 = value;
       break;
     case OR1K_OPERAND_RASF :
       fields->f_r2 = value;
@@ -1033,8 +1114,11 @@ or1k_cgen_set_vma_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RB :
       fields->f_r3 = value;
       break;
+    case OR1K_OPERAND_RBD32F :
+      fields->f_r3 = value;
+      break;
     case OR1K_OPERAND_RBDF :
-      fields->f_r1 = value;
+      fields->f_r3 = value;
       break;
     case OR1K_OPERAND_RBSF :
       fields->f_r3 = value;
@@ -1042,9 +1126,15 @@ or1k_cgen_set_vma_operand (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
     case OR1K_OPERAND_RD :
       fields->f_r1 = value;
       break;
+    case OR1K_OPERAND_RDD32F :
+      fields->f_r1 = value;
+      break;
     case OR1K_OPERAND_RDDF :
       fields->f_r1 = value;
       break;
+    case OR1K_OPERAND_RDDI :
+      fields->f_r1 = value;
+      break;
     case OR1K_OPERAND_RDSF :
       fields->f_r1 = value;
       break;
diff --git a/opcodes/or1k-opc.c b/opcodes/or1k-opc.c
index 36aed256d6..f7b3caec5d 100644
--- a/opcodes/or1k-opc.c
+++ b/opcodes/or1k-opc.c
@@ -149,31 +149,59 @@ static const CGEN_IFMT ifmt_lf_add_s ATTRIBUTE_UNUSED = {
 };
 
 static const CGEN_IFMT ifmt_lf_add_d ATTRIBUTE_UNUSED = {
-  32, 32, 0xfc0007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R1) }, { F (F_R1) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+  32, 32, 0xfc0007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
+static const CGEN_IFMT ifmt_lf_add_d32 ATTRIBUTE_UNUSED = {
+  32, 32, 0xfc0007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
 static const CGEN_IFMT ifmt_lf_itof_s ATTRIBUTE_UNUSED = {
   32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
+static const CGEN_IFMT ifmt_lf_itof_d ATTRIBUTE_UNUSED = {
+  32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
+static const CGEN_IFMT ifmt_lf_itof_d32 ATTRIBUTE_UNUSED = {
+  32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
 static const CGEN_IFMT ifmt_lf_ftoi_s ATTRIBUTE_UNUSED = {
   32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
 static const CGEN_IFMT ifmt_lf_ftoi_d ATTRIBUTE_UNUSED = {
-  32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R1) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+  32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
+static const CGEN_IFMT ifmt_lf_ftoi_d32 ATTRIBUTE_UNUSED = {
+  32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
 static const CGEN_IFMT ifmt_lf_eq_s ATTRIBUTE_UNUSED = {
   32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
+static const CGEN_IFMT ifmt_lf_eq_d ATTRIBUTE_UNUSED = {
+  32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
+static const CGEN_IFMT ifmt_lf_eq_d32 ATTRIBUTE_UNUSED = {
+  32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
 static const CGEN_IFMT ifmt_lf_cust1_s ATTRIBUTE_UNUSED = {
   32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_RESV_25_5) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
 static const CGEN_IFMT ifmt_lf_cust1_d ATTRIBUTE_UNUSED = {
-  32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_RESV_25_5) }, { F (F_R1) }, { F (F_R1) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+  32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_RESV_25_5) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
+};
+
+static const CGEN_IFMT ifmt_lf_cust1_d32 ATTRIBUTE_UNUSED = {
+  32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_RESV_25_5) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_3) }, { F (F_OP_7_8) }, { 0 } }
 };
 
 #undef F
@@ -791,6 +819,12 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RDDF), ',', OP (RADF), ',', OP (RBDF), 0 } },
     & ifmt_lf_add_d, { 0xc8000010 }
   },
+/* lf.add.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_add_d32, { 0xc8000010 }
+  },
 /* lf.sub.s $rDSF,$rASF,$rBSF */
   {
     { 0, 0, 0, 0 },
@@ -803,6 +837,12 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RDDF), ',', OP (RADF), ',', OP (RBDF), 0 } },
     & ifmt_lf_add_d, { 0xc8000011 }
   },
+/* lf.sub.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_add_d32, { 0xc8000011 }
+  },
 /* lf.mul.s $rDSF,$rASF,$rBSF */
   {
     { 0, 0, 0, 0 },
@@ -815,6 +855,12 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RDDF), ',', OP (RADF), ',', OP (RBDF), 0 } },
     & ifmt_lf_add_d, { 0xc8000012 }
   },
+/* lf.mul.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_add_d32, { 0xc8000012 }
+  },
 /* lf.div.s $rDSF,$rASF,$rBSF */
   {
     { 0, 0, 0, 0 },
@@ -827,6 +873,12 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RDDF), ',', OP (RADF), ',', OP (RBDF), 0 } },
     & ifmt_lf_add_d, { 0xc8000013 }
   },
+/* lf.div.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_add_d32, { 0xc8000013 }
+  },
 /* lf.rem.s $rDSF,$rASF,$rBSF */
   {
     { 0, 0, 0, 0 },
@@ -839,17 +891,29 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RDDF), ',', OP (RADF), ',', OP (RBDF), 0 } },
     & ifmt_lf_add_d, { 0xc8000016 }
   },
+/* lf.rem.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_add_d32, { 0xc8000016 }
+  },
 /* lf.itof.s $rDSF,$rA */
   {
     { 0, 0, 0, 0 },
     { { MNEM, ' ', OP (RDSF), ',', OP (RA), 0 } },
     & ifmt_lf_itof_s, { 0xc8000004 }
   },
-/* lf.itof.d $rDSF,$rA */
+/* lf.itof.d $rDDF,$rA */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RDSF), ',', OP (RA), 0 } },
-    & ifmt_lf_itof_s, { 0xc8000014 }
+    { { MNEM, ' ', OP (RDDF), ',', OP (RA), 0 } },
+    & ifmt_lf_itof_d, { 0xc8000014 }
+  },
+/* lf.itof.d $rDD32F,$rADI */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RADI), 0 } },
+    & ifmt_lf_itof_d32, { 0xc8000014 }
   },
 /* lf.ftoi.s $rD,$rASF */
   {
@@ -863,17 +927,29 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RD), ',', OP (RADF), 0 } },
     & ifmt_lf_ftoi_d, { 0xc8000015 }
   },
+/* lf.ftoi.d $rDDI,$rAD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDDI), ',', OP (RAD32F), 0 } },
+    & ifmt_lf_ftoi_d32, { 0xc8000015 }
+  },
 /* lf.sfeq.s $rASF,$rBSF */
   {
     { 0, 0, 0, 0 },
     { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
     & ifmt_lf_eq_s, { 0xc8000008 }
   },
-/* lf.sfeq.d $rASF,$rBSF */
+/* lf.sfeq.d $rADF,$rBDF */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
-    & ifmt_lf_eq_s, { 0xc8000018 }
+    { { MNEM, ' ', OP (RADF), ',', OP (RBDF), 0 } },
+    & ifmt_lf_eq_d, { 0xc8000018 }
+  },
+/* lf.sfeq.d $rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_eq_d32, { 0xc8000018 }
   },
 /* lf.sfne.s $rASF,$rBSF */
   {
@@ -881,11 +957,17 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
     & ifmt_lf_eq_s, { 0xc8000009 }
   },
-/* lf.sfne.d $rASF,$rBSF */
+/* lf.sfne.d $rADF,$rBDF */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
-    & ifmt_lf_eq_s, { 0xc8000019 }
+    { { MNEM, ' ', OP (RADF), ',', OP (RBDF), 0 } },
+    & ifmt_lf_eq_d, { 0xc8000019 }
+  },
+/* lf.sfne.d $rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_eq_d32, { 0xc8000019 }
   },
 /* lf.sfge.s $rASF,$rBSF */
   {
@@ -893,11 +975,17 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
     & ifmt_lf_eq_s, { 0xc800000b }
   },
-/* lf.sfge.d $rASF,$rBSF */
+/* lf.sfge.d $rADF,$rBDF */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
-    & ifmt_lf_eq_s, { 0xc800001b }
+    { { MNEM, ' ', OP (RADF), ',', OP (RBDF), 0 } },
+    & ifmt_lf_eq_d, { 0xc800001b }
+  },
+/* lf.sfge.d $rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_eq_d32, { 0xc800001b }
   },
 /* lf.sfgt.s $rASF,$rBSF */
   {
@@ -905,11 +993,17 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
     & ifmt_lf_eq_s, { 0xc800000a }
   },
-/* lf.sfgt.d $rASF,$rBSF */
+/* lf.sfgt.d $rADF,$rBDF */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
-    & ifmt_lf_eq_s, { 0xc800001a }
+    { { MNEM, ' ', OP (RADF), ',', OP (RBDF), 0 } },
+    & ifmt_lf_eq_d, { 0xc800001a }
+  },
+/* lf.sfgt.d $rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_eq_d32, { 0xc800001a }
   },
 /* lf.sflt.s $rASF,$rBSF */
   {
@@ -917,11 +1011,17 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
     & ifmt_lf_eq_s, { 0xc800000c }
   },
-/* lf.sflt.d $rASF,$rBSF */
+/* lf.sflt.d $rADF,$rBDF */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
-    & ifmt_lf_eq_s, { 0xc800001c }
+    { { MNEM, ' ', OP (RADF), ',', OP (RBDF), 0 } },
+    & ifmt_lf_eq_d, { 0xc800001c }
+  },
+/* lf.sflt.d $rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_eq_d32, { 0xc800001c }
   },
 /* lf.sfle.s $rASF,$rBSF */
   {
@@ -929,11 +1029,17 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
     & ifmt_lf_eq_s, { 0xc800000d }
   },
-/* lf.sfle.d $rASF,$rBSF */
+/* lf.sfle.d $rADF,$rBDF */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RASF), ',', OP (RBSF), 0 } },
-    & ifmt_lf_eq_s, { 0xc800001d }
+    { { MNEM, ' ', OP (RADF), ',', OP (RBDF), 0 } },
+    & ifmt_lf_eq_d, { 0xc800001d }
+  },
+/* lf.sfle.d $rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_eq_d32, { 0xc800001d }
   },
 /* lf.madd.s $rDSF,$rASF,$rBSF */
   {
@@ -947,6 +1053,12 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RDDF), ',', OP (RADF), ',', OP (RBDF), 0 } },
     & ifmt_lf_add_d, { 0xc8000017 }
   },
+/* lf.madd.d $rDD32F,$rAD32F,$rBD32F */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RDD32F), ',', OP (RAD32F), ',', OP (RBD32F), 0 } },
+    & ifmt_lf_add_d32, { 0xc8000017 }
+  },
 /* lf.cust1.s $rASF,$rBSF */
   {
     { 0, 0, 0, 0 },
@@ -959,6 +1071,12 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, 0 } },
     & ifmt_lf_cust1_d, { 0xc80000e0 }
   },
+/* lf.cust1.d */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, 0 } },
+    & ifmt_lf_cust1_d32, { 0xc80000e0 }
+  },
 };
 
 #undef A
diff --git a/opcodes/or1k-opc.h b/opcodes/or1k-opc.h
index 78ed425332..54fc31fabc 100644
--- a/opcodes/or1k-opc.h
+++ b/opcodes/or1k-opc.h
@@ -65,21 +65,24 @@ typedef enum cgen_insn_type {
  , OR1K_INSN_L_MACU, OR1K_INSN_L_MSB, OR1K_INSN_L_MSBU, OR1K_INSN_L_CUST1
  , OR1K_INSN_L_CUST2, OR1K_INSN_L_CUST3, OR1K_INSN_L_CUST4, OR1K_INSN_L_CUST5
  , OR1K_INSN_L_CUST6, OR1K_INSN_L_CUST7, OR1K_INSN_L_CUST8, OR1K_INSN_LF_ADD_S
- , OR1K_INSN_LF_ADD_D, OR1K_INSN_LF_SUB_S, OR1K_INSN_LF_SUB_D, OR1K_INSN_LF_MUL_S
- , OR1K_INSN_LF_MUL_D, OR1K_INSN_LF_DIV_S, OR1K_INSN_LF_DIV_D, OR1K_INSN_LF_REM_S
- , OR1K_INSN_LF_REM_D, OR1K_INSN_LF_ITOF_S, OR1K_INSN_LF_ITOF_D, OR1K_INSN_LF_FTOI_S
- , OR1K_INSN_LF_FTOI_D, OR1K_INSN_LF_EQ_S, OR1K_INSN_LF_EQ_D, OR1K_INSN_LF_NE_S
- , OR1K_INSN_LF_NE_D, OR1K_INSN_LF_GE_S, OR1K_INSN_LF_GE_D, OR1K_INSN_LF_GT_S
- , OR1K_INSN_LF_GT_D, OR1K_INSN_LF_LT_S, OR1K_INSN_LF_LT_D, OR1K_INSN_LF_LE_S
- , OR1K_INSN_LF_LE_D, OR1K_INSN_LF_MADD_S, OR1K_INSN_LF_MADD_D, OR1K_INSN_LF_CUST1_S
- , OR1K_INSN_LF_CUST1_D
+ , OR1K_INSN_LF_ADD_D, OR1K_INSN_LF_ADD_D32, OR1K_INSN_LF_SUB_S, OR1K_INSN_LF_SUB_D
+ , OR1K_INSN_LF_SUB_D32, OR1K_INSN_LF_MUL_S, OR1K_INSN_LF_MUL_D, OR1K_INSN_LF_MUL_D32
+ , OR1K_INSN_LF_DIV_S, OR1K_INSN_LF_DIV_D, OR1K_INSN_LF_DIV_D32, OR1K_INSN_LF_REM_S
+ , OR1K_INSN_LF_REM_D, OR1K_INSN_LF_REM_D32, OR1K_INSN_LF_ITOF_S, OR1K_INSN_LF_ITOF_D
+ , OR1K_INSN_LF_ITOF_D32, OR1K_INSN_LF_FTOI_S, OR1K_INSN_LF_FTOI_D, OR1K_INSN_LF_FTOI_D32
+ , OR1K_INSN_LF_EQ_S, OR1K_INSN_LF_EQ_D, OR1K_INSN_LF_EQ_D32, OR1K_INSN_LF_NE_S
+ , OR1K_INSN_LF_NE_D, OR1K_INSN_LF_NE_D32, OR1K_INSN_LF_GE_S, OR1K_INSN_LF_GE_D
+ , OR1K_INSN_LF_GE_D32, OR1K_INSN_LF_GT_S, OR1K_INSN_LF_GT_D, OR1K_INSN_LF_GT_D32
+ , OR1K_INSN_LF_LT_S, OR1K_INSN_LF_LT_D, OR1K_INSN_LF_LT_D32, OR1K_INSN_LF_LE_S
+ , OR1K_INSN_LF_LE_D, OR1K_INSN_LF_LE_D32, OR1K_INSN_LF_MADD_S, OR1K_INSN_LF_MADD_D
+ , OR1K_INSN_LF_MADD_D32, OR1K_INSN_LF_CUST1_S, OR1K_INSN_LF_CUST1_D, OR1K_INSN_LF_CUST1_D32
 } CGEN_INSN_TYPE;
 
 /* Index of `invalid' insn place holder.  */
 #define CGEN_INSN_INVALID OR1K_INSN_INVALID
 
 /* Total number of insns in table.  */
-#define MAX_INSNS ((int) OR1K_INSN_LF_CUST1_D + 1)
+#define MAX_INSNS ((int) OR1K_INSN_LF_CUST1_D32 + 1)
 
 /* This struct records data prior to insertion or after extraction.  */
 struct cgen_fields
diff --git a/opcodes/or1k-opinst.c b/opcodes/or1k-opinst.c
index 6b18dab986..ff7593ac74 100644
--- a/opcodes/or1k-opinst.c
+++ b/opcodes/or1k-opinst.c
@@ -461,6 +461,13 @@ static const CGEN_OPINST sfmt_lf_add_d_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
+static const CGEN_OPINST sfmt_lf_add_d32_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "rAD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RAD32F), 0, 0 },
+  { INPUT, "rBD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RBD32F), 0, 0 },
+  { OUTPUT, "rDD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RDD32F), 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
 static const CGEN_OPINST sfmt_lf_itof_s_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
   { INPUT, "sys_fpcsr_rm", HW_H_SYS_FPCSR_RM, CGEN_MODE_UDI, 0, 0, 0 },
@@ -475,6 +482,13 @@ static const CGEN_OPINST sfmt_lf_itof_d_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
+static const CGEN_OPINST sfmt_lf_itof_d32_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "rADI", HW_H_I64R, CGEN_MODE_DI, OP_ENT (RADI), 0, 0 },
+  { INPUT, "sys_fpcsr_rm", HW_H_SYS_FPCSR_RM, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "rDD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RDD32F), 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
 static const CGEN_OPINST sfmt_lf_ftoi_s_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "rASF", HW_H_FSR, CGEN_MODE_SF, OP_ENT (RASF), 0, 0 },
   { INPUT, "sys_fpcsr_rm", HW_H_SYS_FPCSR_RM, CGEN_MODE_UDI, 0, 0, 0 },
@@ -489,6 +503,13 @@ static const CGEN_OPINST sfmt_lf_ftoi_d_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
+static const CGEN_OPINST sfmt_lf_ftoi_d32_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "rAD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RAD32F), 0, 0 },
+  { INPUT, "sys_fpcsr_rm", HW_H_SYS_FPCSR_RM, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "rDDI", HW_H_I64R, CGEN_MODE_DI, OP_ENT (RDDI), 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
 static const CGEN_OPINST sfmt_lf_eq_s_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "rASF", HW_H_FSR, CGEN_MODE_SF, OP_ENT (RASF), 0, 0 },
   { INPUT, "rBSF", HW_H_FSR, CGEN_MODE_SF, OP_ENT (RBSF), 0, 0 },
@@ -503,6 +524,13 @@ static const CGEN_OPINST sfmt_lf_eq_d_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
+static const CGEN_OPINST sfmt_lf_eq_d32_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "rAD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RAD32F), 0, 0 },
+  { INPUT, "rBD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RBD32F), 0, 0 },
+  { OUTPUT, "sys_sr_f", HW_H_SYS_SR_F, CGEN_MODE_UDI, 0, 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
 static const CGEN_OPINST sfmt_lf_madd_s_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "rASF", HW_H_FSR, CGEN_MODE_SF, OP_ENT (RASF), 0, 0 },
   { INPUT, "rBSF", HW_H_FSR, CGEN_MODE_SF, OP_ENT (RBSF), 0, 0 },
@@ -519,6 +547,14 @@ static const CGEN_OPINST sfmt_lf_madd_d_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
+static const CGEN_OPINST sfmt_lf_madd_d32_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "rAD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RAD32F), 0, 0 },
+  { INPUT, "rBD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RBD32F), 0, 0 },
+  { INPUT, "rDD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RDD32F), 0, 0 },
+  { OUTPUT, "rDD32F", HW_H_FD32R, CGEN_MODE_DF, OP_ENT (RDD32F), 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
 #undef OP_ENT
 #undef INPUT
 #undef OUTPUT
@@ -629,32 +665,47 @@ static const CGEN_OPINST *or1k_cgen_opinst_table[MAX_INSNS] = {
   & sfmt_l_msync_ops[0],
   & sfmt_lf_add_s_ops[0],
   & sfmt_lf_add_d_ops[0],
+  & sfmt_lf_add_d32_ops[0],
   & sfmt_lf_add_s_ops[0],
   & sfmt_lf_add_d_ops[0],
+  & sfmt_lf_add_d32_ops[0],
   & sfmt_lf_add_s_ops[0],
   & sfmt_lf_add_d_ops[0],
+  & sfmt_lf_add_d32_ops[0],
   & sfmt_lf_add_s_ops[0],
   & sfmt_lf_add_d_ops[0],
+  & sfmt_lf_add_d32_ops[0],
   & sfmt_lf_add_s_ops[0],
   & sfmt_lf_add_d_ops[0],
+  & sfmt_lf_add_d32_ops[0],
   & sfmt_lf_itof_s_ops[0],
   & sfmt_lf_itof_d_ops[0],
+  & sfmt_lf_itof_d32_ops[0],
   & sfmt_lf_ftoi_s_ops[0],
   & sfmt_lf_ftoi_d_ops[0],
+  & sfmt_lf_ftoi_d32_ops[0],
   & sfmt_lf_eq_s_ops[0],
   & sfmt_lf_eq_d_ops[0],
+  & sfmt_lf_eq_d32_ops[0],
   & sfmt_lf_eq_s_ops[0],
   & sfmt_lf_eq_d_ops[0],
+  & sfmt_lf_eq_d32_ops[0],
   & sfmt_lf_eq_s_ops[0],
   & sfmt_lf_eq_d_ops[0],
+  & sfmt_lf_eq_d32_ops[0],
   & sfmt_lf_eq_s_ops[0],
   & sfmt_lf_eq_d_ops[0],
+  & sfmt_lf_eq_d32_ops[0],
   & sfmt_lf_eq_s_ops[0],
   & sfmt_lf_eq_d_ops[0],
+  & sfmt_lf_eq_d32_ops[0],
   & sfmt_lf_eq_s_ops[0],
   & sfmt_lf_eq_d_ops[0],
+  & sfmt_lf_eq_d32_ops[0],
   & sfmt_lf_madd_s_ops[0],
   & sfmt_lf_madd_d_ops[0],
+  & sfmt_lf_madd_d32_ops[0],
+  & sfmt_l_msync_ops[0],
   & sfmt_l_msync_ops[0],
   & sfmt_l_msync_ops[0],
 };
-- 
2.19.1

