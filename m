From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:23 +0900
Subject: [OpenRISC] [PATCH 09/18] sim: or1k: regenerate sim files
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-10-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/or1k/ChangeLog:

	* cpu32.c: regenerate
	* cpu32.h: ditto
	* cpu64.c: ditto
	* cpu64.h: ditto
	* decode32.c: ditto
	* decode32.h: ditto
	* decode64.c: ditto
	* decode64.h: ditto
	* model32.c: ditto
	* sem32.c: ditto
	* sem32-switch.c: ditto
	* sem64.c: ditto
	* sem64-switch.c: ditto
---
 sim/or1k/ChangeLog      |  16 ++++
 sim/or1k/cpu32.c        |  16 ++++
 sim/or1k/cpu32.h        |  36 ++++-----
 sim/or1k/cpu64.c        |  16 ++++
 sim/or1k/cpu64.h        |  36 ++++-----
 sim/or1k/decode32.c     | 197 ++++++++++++++++++-----------------------------
 sim/or1k/decode32.h     |  31 ++++----
 sim/or1k/decode64.c     | 201 +++++++++++++++++++-----------------------------
 sim/or1k/decode64.h     |  33 ++++----
 sim/or1k/model32.c      | 152 ++++++++++++++++++------------------
 sim/or1k/sem32-switch.c | 138 ++++++++++++++++-----------------
 sim/or1k/sem32.c        | 170 ++++++++++++++++++++--------------------
 sim/or1k/sem64-switch.c | 138 ++++++++++++++++-----------------
 sim/or1k/sem64.c        | 170 ++++++++++++++++++++--------------------
 14 files changed, 633 insertions(+), 717 deletions(-)

diff --git a/sim/or1k/ChangeLog b/sim/or1k/ChangeLog
index 5d120fe..c1038c3 100644
--- a/sim/or1k/ChangeLog
+++ b/sim/or1k/ChangeLog
@@ -1,5 +1,21 @@
 2012-06-22  Peter Gavin  <pgavin@gmail.com>
 
+	* cpu32.c: regenerate
+	* cpu32.h: ditto
+	* cpu64.c: ditto
+	* cpu64.h: ditto
+	* decode32.c: ditto
+	* decode32.h: ditto
+	* decode64.c: ditto
+	* decode64.h: ditto
+	* model32.c: ditto
+	* sem32.c: ditto
+	* sem32-switch.c: ditto
+	* sem64.c: ditto
+	* sem64-switch.c: ditto
+
+2012-06-22  Peter Gavin  <pgavin@gmail.com>
+
 	* or1k.c:
 	(or1k32bf_fl1) fix bug
 
diff --git a/sim/or1k/cpu32.c b/sim/or1k/cpu32.c
index d503534..36b4040 100644
--- a/sim/or1k/cpu32.c
+++ b/sim/or1k/cpu32.c
@@ -9292,6 +9292,22 @@ or1k32bf_h_mac_machi_set (SIM_CPU *current_cpu, USI newval)
   SET_H_MAC_MACHI (newval);
 }
 
+/* Get the value of h-tick-ttmr.  */
+
+USI
+or1k32bf_h_tick_ttmr_get (SIM_CPU *current_cpu)
+{
+  return GET_H_TICK_TTMR ();
+}
+
+/* Set a value for h-tick-ttmr.  */
+
+void
+or1k32bf_h_tick_ttmr_set (SIM_CPU *current_cpu, USI newval)
+{
+  SET_H_TICK_TTMR (newval);
+}
+
 /* Get the value of h-sys-vr-rev.  */
 
 USI
diff --git a/sim/or1k/cpu32.h b/sim/or1k/cpu32.h
index e3a8276..a31a935 100644
--- a/sim/or1k/cpu32.h
+++ b/sim/or1k/cpu32.h
@@ -2944,6 +2944,11 @@ SET_H_SPR (ORSI (SLLSI (SPR_GROUP_MAC, 11), SPR_INDEX_MAC_MACLO), (x));\
 do { \
 SET_H_SPR (ORSI (SLLSI (SPR_GROUP_MAC, 11), SPR_INDEX_MAC_MACHI), (x));\
 ;} while (0)
+#define GET_H_TICK_TTMR() GET_H_SPR (ORSI (SLLSI (SPR_GROUP_TICK, 11), SPR_INDEX_TICK_TTMR))
+#define SET_H_TICK_TTMR(x) \
+do { \
+SET_H_SPR (ORSI (SLLSI (SPR_GROUP_TICK, 11), SPR_INDEX_TICK_TTMR), (x));\
+;} while (0)
 #define GET_H_SYS_VR_REV() or1k32bf_h_spr_field_get_raw (current_cpu, ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_VR), 5, 0)
 #define SET_H_SYS_VR_REV(x) \
 do { \
@@ -4364,6 +4369,8 @@ USI or1k32bf_h_mac_maclo_get (SIM_CPU *);
 void or1k32bf_h_mac_maclo_set (SIM_CPU *, USI);
 USI or1k32bf_h_mac_machi_get (SIM_CPU *);
 void or1k32bf_h_mac_machi_set (SIM_CPU *, USI);
+USI or1k32bf_h_tick_ttmr_get (SIM_CPU *);
+void or1k32bf_h_tick_ttmr_set (SIM_CPU *, USI);
 USI or1k32bf_h_sys_vr_rev_get (SIM_CPU *);
 void or1k32bf_h_sys_vr_rev_set (SIM_CPU *, USI);
 USI or1k32bf_h_sys_vr_cfg_get (SIM_CPU *);
@@ -4822,14 +4829,14 @@ struct scache {
   f_resv_7_4 = EXTRACT_LSB0_UINT (insn, 32, 7, 4); \
   f_op_3_4 = EXTRACT_LSB0_UINT (insn, 32, 3, 4); \
 
-#define EXTRACT_IFMT_L_SFGTU_VARS \
+#define EXTRACT_IFMT_L_SFGTS_VARS \
   UINT f_opcode; \
   UINT f_op_25_5; \
   UINT f_r2; \
   UINT f_r3; \
   UINT f_resv_10_11; \
   unsigned int length;
-#define EXTRACT_IFMT_L_SFGTU_CODE \
+#define EXTRACT_IFMT_L_SFGTS_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
   f_op_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
@@ -4837,19 +4844,6 @@ struct scache {
   f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
   f_resv_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11); \
 
-#define EXTRACT_IFMT_L_SFGTUI_VARS \
-  UINT f_opcode; \
-  UINT f_op_25_5; \
-  UINT f_r2; \
-  UINT f_uimm16; \
-  unsigned int length;
-#define EXTRACT_IFMT_L_SFGTUI_CODE \
-  length = 4; \
-  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
-  f_op_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
-  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
-  f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16); \
-
 #define EXTRACT_IFMT_L_SFGTSI_VARS \
   UINT f_opcode; \
   UINT f_op_25_5; \
@@ -4882,20 +4876,16 @@ struct scache {
 
 #define EXTRACT_IFMT_L_MACI_VARS \
   UINT f_opcode; \
-  UINT f_resv_20_5; \
+  UINT f_resv_25_5; \
   UINT f_r2; \
-  UINT f_imm16_25_5; \
-  UINT f_imm16_10_11; \
-  INT f_simm16_split; \
+  INT f_simm16; \
   unsigned int length;
 #define EXTRACT_IFMT_L_MACI_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
-  f_resv_20_5 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_resv_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
   f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
-  f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
-  f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11); \
-  f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));\
+  f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16); \
 
 #define EXTRACT_IFMT_LF_ADD_S_VARS \
   UINT f_opcode; \
diff --git a/sim/or1k/cpu64.c b/sim/or1k/cpu64.c
index 1cb4487..cd25e89 100644
--- a/sim/or1k/cpu64.c
+++ b/sim/or1k/cpu64.c
@@ -9308,6 +9308,22 @@ or1k64bf_h_mac_machi_set (SIM_CPU *current_cpu, UDI newval)
   SET_H_MAC_MACHI (newval);
 }
 
+/* Get the value of h-tick-ttmr.  */
+
+UDI
+or1k64bf_h_tick_ttmr_get (SIM_CPU *current_cpu)
+{
+  return GET_H_TICK_TTMR ();
+}
+
+/* Set a value for h-tick-ttmr.  */
+
+void
+or1k64bf_h_tick_ttmr_set (SIM_CPU *current_cpu, UDI newval)
+{
+  SET_H_TICK_TTMR (newval);
+}
+
 /* Get the value of h-sys-vr-rev.  */
 
 UDI
diff --git a/sim/or1k/cpu64.h b/sim/or1k/cpu64.h
index c17c960..5bfbf9e 100644
--- a/sim/or1k/cpu64.h
+++ b/sim/or1k/cpu64.h
@@ -2949,6 +2949,11 @@ SET_H_SPR (ORDI (SLLDI (SPR_GROUP_MAC, 11), SPR_INDEX_MAC_MACLO), (x));\
 do { \
 SET_H_SPR (ORDI (SLLDI (SPR_GROUP_MAC, 11), SPR_INDEX_MAC_MACHI), (x));\
 ;} while (0)
+#define GET_H_TICK_TTMR() GET_H_SPR (ORDI (SLLDI (SPR_GROUP_TICK, 11), SPR_INDEX_TICK_TTMR))
+#define SET_H_TICK_TTMR(x) \
+do { \
+SET_H_SPR (ORDI (SLLDI (SPR_GROUP_TICK, 11), SPR_INDEX_TICK_TTMR), (x));\
+;} while (0)
 #define GET_H_SYS_VR_REV() or1k64bf_h_spr_field_get_raw (current_cpu, ORDI (SLLDI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_VR), 5, 0)
 #define SET_H_SYS_VR_REV(x) \
 do { \
@@ -4371,6 +4376,8 @@ UDI or1k64bf_h_mac_maclo_get (SIM_CPU *);
 void or1k64bf_h_mac_maclo_set (SIM_CPU *, UDI);
 UDI or1k64bf_h_mac_machi_get (SIM_CPU *);
 void or1k64bf_h_mac_machi_set (SIM_CPU *, UDI);
+UDI or1k64bf_h_tick_ttmr_get (SIM_CPU *);
+void or1k64bf_h_tick_ttmr_set (SIM_CPU *, UDI);
 UDI or1k64bf_h_sys_vr_rev_get (SIM_CPU *);
 void or1k64bf_h_sys_vr_rev_set (SIM_CPU *, UDI);
 UDI or1k64bf_h_sys_vr_cfg_get (SIM_CPU *);
@@ -4821,14 +4828,14 @@ struct scache {
   f_resv_7_4 = EXTRACT_LSB0_UINT (insn, 32, 7, 4); \
   f_op_3_4 = EXTRACT_LSB0_UINT (insn, 32, 3, 4); \
 
-#define EXTRACT_IFMT_L_SFGTU_VARS \
+#define EXTRACT_IFMT_L_SFGTS_VARS \
   UINT f_opcode; \
   UINT f_op_25_5; \
   UINT f_r2; \
   UINT f_r3; \
   UINT f_resv_10_11; \
   unsigned int length;
-#define EXTRACT_IFMT_L_SFGTU_CODE \
+#define EXTRACT_IFMT_L_SFGTS_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
   f_op_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
@@ -4836,19 +4843,6 @@ struct scache {
   f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
   f_resv_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11); \
 
-#define EXTRACT_IFMT_L_SFGTUI_VARS \
-  UINT f_opcode; \
-  UINT f_op_25_5; \
-  UINT f_r2; \
-  UINT f_uimm16; \
-  unsigned int length;
-#define EXTRACT_IFMT_L_SFGTUI_CODE \
-  length = 4; \
-  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
-  f_op_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
-  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
-  f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16); \
-
 #define EXTRACT_IFMT_L_SFGTSI_VARS \
   UINT f_opcode; \
   UINT f_op_25_5; \
@@ -4881,20 +4875,16 @@ struct scache {
 
 #define EXTRACT_IFMT_L_MACI_VARS \
   UINT f_opcode; \
-  UINT f_resv_20_5; \
+  UINT f_resv_25_5; \
   UINT f_r2; \
-  UINT f_imm16_25_5; \
-  UINT f_imm16_10_11; \
-  INT f_simm16_split; \
+  INT f_simm16; \
   unsigned int length;
 #define EXTRACT_IFMT_L_MACI_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
-  f_resv_20_5 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_resv_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
   f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
-  f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
-  f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11); \
-  f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));\
+  f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16); \
 
 #define EXTRACT_IFMT_LF_ADD_S_VARS \
   UINT f_opcode; \
diff --git a/sim/or1k/decode32.c b/sim/or1k/decode32.c
index b04bfb4..04b29f4 100644
--- a/sim/or1k/decode32.c
+++ b/sim/or1k/decode32.c
@@ -54,7 +54,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_BF, OR1K32BF_INSN_L_BF, OR1K32BF_SFMT_L_BNF },
   { OR1K_INSN_L_TRAP, OR1K32BF_INSN_L_TRAP, OR1K32BF_SFMT_L_TRAP },
   { OR1K_INSN_L_SYS, OR1K32BF_INSN_L_SYS, OR1K32BF_SFMT_L_TRAP },
-  { OR1K_INSN_L_RFE, OR1K32BF_INSN_L_RFE, OR1K32BF_SFMT_L_TRAP },
+  { OR1K_INSN_L_RFE, OR1K32BF_INSN_L_RFE, OR1K32BF_SFMT_L_RFE },
   { OR1K_INSN_L_NOP_IMM, OR1K32BF_INSN_L_NOP_IMM, OR1K32BF_SFMT_L_NOP_IMM },
   { OR1K_INSN_L_MOVHI, OR1K32BF_INSN_L_MOVHI, OR1K32BF_SFMT_L_MOVHI },
   { OR1K_INSN_L_MACRC, OR1K32BF_INSN_L_MACRC, OR1K32BF_SFMT_L_MACRC },
@@ -89,8 +89,8 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_DIVU, OR1K32BF_INSN_L_DIVU, OR1K32BF_SFMT_L_DIV },
   { OR1K_INSN_L_FF1, OR1K32BF_INSN_L_FF1, OR1K32BF_SFMT_L_FF1 },
   { OR1K_INSN_L_FL1, OR1K32BF_INSN_L_FL1, OR1K32BF_SFMT_L_FF1 },
-  { OR1K_INSN_L_ANDI, OR1K32BF_INSN_L_ANDI, OR1K32BF_SFMT_L_ANDI },
-  { OR1K_INSN_L_ORI, OR1K32BF_INSN_L_ORI, OR1K32BF_SFMT_L_ANDI },
+  { OR1K_INSN_L_ANDI, OR1K32BF_INSN_L_ANDI, OR1K32BF_SFMT_L_MFSPR },
+  { OR1K_INSN_L_ORI, OR1K32BF_INSN_L_ORI, OR1K32BF_SFMT_L_MFSPR },
   { OR1K_INSN_L_XORI, OR1K32BF_INSN_L_XORI, OR1K32BF_SFMT_L_XORI },
   { OR1K_INSN_L_ADDI, OR1K32BF_INSN_L_ADDI, OR1K32BF_SFMT_L_ADDI },
   { OR1K_INSN_L_ADDIC, OR1K32BF_INSN_L_ADDIC, OR1K32BF_SFMT_L_ADDIC },
@@ -102,37 +102,37 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_EXTWS, OR1K32BF_INSN_L_EXTWS, OR1K32BF_SFMT_L_EXTHS },
   { OR1K_INSN_L_EXTWZ, OR1K32BF_INSN_L_EXTWZ, OR1K32BF_SFMT_L_EXTHS },
   { OR1K_INSN_L_CMOV, OR1K32BF_INSN_L_CMOV, OR1K32BF_SFMT_L_CMOV },
-  { OR1K_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTU, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEU, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTU, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEU, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGTS, OR1K32BF_INSN_L_SFGTS, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGES, OR1K32BF_INSN_L_SFGES, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLTS, OR1K32BF_INSN_L_SFLTS, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLES, OR1K32BF_INSN_L_SFLES, OR1K32BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_SFMT_L_SFGTUI },
-  { OR1K_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_SFMT_L_SFGTUI },
-  { OR1K_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_SFMT_L_SFGTUI },
-  { OR1K_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_SFMT_L_SFGTUI },
+  { OR1K_INSN_L_SFGTS, OR1K32BF_INSN_L_SFGTS, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFGTSI, OR1K32BF_INSN_L_SFGTSI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTU, OR1K32BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFGES, OR1K32BF_INSN_L_SFGES, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFGESI, OR1K32BF_INSN_L_SFGESI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEU, OR1K32BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFLTS, OR1K32BF_INSN_L_SFLTS, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFLTSI, OR1K32BF_INSN_L_SFLTSI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTU, OR1K32BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFLES, OR1K32BF_INSN_L_SFLES, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFLESI, OR1K32BF_INSN_L_SFLESI, OR1K32BF_SFMT_L_SFGTSI },
-  { OR1K_INSN_L_SFEQ, OR1K32BF_INSN_L_SFEQ, OR1K32BF_SFMT_L_SFGTU },
+  { OR1K_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEU, OR1K32BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFEQ, OR1K32BF_INSN_L_SFEQ, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFEQI, OR1K32BF_INSN_L_SFEQI, OR1K32BF_SFMT_L_SFGTSI },
-  { OR1K_INSN_L_SFNE, OR1K32BF_INSN_L_SFNE, OR1K32BF_SFMT_L_SFGTU },
+  { OR1K_INSN_L_SFNE, OR1K32BF_INSN_L_SFNE, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFNEI, OR1K32BF_INSN_L_SFNEI, OR1K32BF_SFMT_L_SFGTSI },
   { OR1K_INSN_L_MAC, OR1K32BF_INSN_L_MAC, OR1K32BF_SFMT_L_MAC },
   { OR1K_INSN_L_MSB, OR1K32BF_INSN_L_MSB, OR1K32BF_SFMT_L_MAC },
   { OR1K_INSN_L_MACI, OR1K32BF_INSN_L_MACI, OR1K32BF_SFMT_L_MACI },
-  { OR1K_INSN_L_CUST1, OR1K32BF_INSN_L_CUST1, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST2, OR1K32BF_INSN_L_CUST2, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST3, OR1K32BF_INSN_L_CUST3, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST4, OR1K32BF_INSN_L_CUST4, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST5, OR1K32BF_INSN_L_CUST5, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST6, OR1K32BF_INSN_L_CUST6, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST7, OR1K32BF_INSN_L_CUST7, OR1K32BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST8, OR1K32BF_INSN_L_CUST8, OR1K32BF_SFMT_L_CUST1 },
+  { OR1K_INSN_L_CUST1, OR1K32BF_INSN_L_CUST1, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST2, OR1K32BF_INSN_L_CUST2, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST3, OR1K32BF_INSN_L_CUST3, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST4, OR1K32BF_INSN_L_CUST4, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST5, OR1K32BF_INSN_L_CUST5, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST6, OR1K32BF_INSN_L_CUST6, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST7, OR1K32BF_INSN_L_CUST7, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST8, OR1K32BF_INSN_L_CUST8, OR1K32BF_SFMT_L_RFE },
   { OR1K_INSN_LF_ADD_S, OR1K32BF_INSN_LF_ADD_S, OR1K32BF_SFMT_LF_ADD_S },
   { OR1K_INSN_LF_SUB_S, OR1K32BF_INSN_LF_SUB_S, OR1K32BF_SFMT_LF_ADD_S },
   { OR1K_INSN_LF_MUL_S, OR1K32BF_INSN_LF_MUL_S, OR1K32BF_SFMT_LF_ADD_S },
@@ -147,7 +147,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_LF_LT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_SFMT_LF_EQ_S },
   { OR1K_INSN_LF_LE_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_SFMT_LF_EQ_S },
   { OR1K_INSN_LF_MADD_S, OR1K32BF_INSN_LF_MADD_S, OR1K32BF_SFMT_LF_MADD_S },
-  { OR1K_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_SFMT_L_CUST1 },
+  { OR1K_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_SFMT_L_RFE },
 };
 
 static const struct insn_sem or1k32bf_insn_sem_invalid =
@@ -490,7 +490,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         }
       case 288 :
         if ((entire_insn & 0xffffffff) == 0x24000000)
-          { itype = OR1K32BF_INSN_L_RFE; goto extract_sfmt_l_trap; }
+          { itype = OR1K32BF_INSN_L_RFE; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 544 :
         if ((entire_insn & 0xffff07ff) == 0x44000000)
@@ -532,24 +532,24 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 637 : /* fall through */
       case 638 : /* fall through */
       case 639 :
-        if ((entire_insn & 0xfc1f0000) == 0x4c000000)
+        if ((entire_insn & 0xffe00000) == 0x4c000000)
           { itype = OR1K32BF_INSN_L_MACI; goto extract_sfmt_l_maci; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 896 :
         if ((entire_insn & 0xffffffff) == 0x70000000)
-          { itype = OR1K32BF_INSN_L_CUST1; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST1; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 928 :
         if ((entire_insn & 0xffffffff) == 0x74000000)
-          { itype = OR1K32BF_INSN_L_CUST2; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST2; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 960 :
         if ((entire_insn & 0xffffffff) == 0x78000000)
-          { itype = OR1K32BF_INSN_L_CUST3; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST3; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 992 :
         if ((entire_insn & 0xffffffff) == 0x7c000000)
-          { itype = OR1K32BF_INSN_L_CUST4; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST4; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1056 : /* fall through */
       case 1057 : /* fall through */
@@ -838,7 +838,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1340 : /* fall through */
       case 1341 : /* fall through */
       case 1342 : /* fall through */
-      case 1343 : itype = OR1K32BF_INSN_L_ANDI; goto extract_sfmt_l_andi;
+      case 1343 : itype = OR1K32BF_INSN_L_ANDI; goto extract_sfmt_l_mfspr;
       case 1344 : /* fall through */
       case 1345 : /* fall through */
       case 1346 : /* fall through */
@@ -870,7 +870,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1372 : /* fall through */
       case 1373 : /* fall through */
       case 1374 : /* fall through */
-      case 1375 : itype = OR1K32BF_INSN_L_ORI; goto extract_sfmt_l_andi;
+      case 1375 : itype = OR1K32BF_INSN_L_ORI; goto extract_sfmt_l_mfspr;
       case 1376 : /* fall through */
       case 1377 : /* fall through */
       case 1378 : /* fall through */
@@ -1075,19 +1075,19 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 2 :
             if ((entire_insn & 0xffe00000) == 0xbc400000)
-              { itype = OR1K32BF_INSN_L_SFGTUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K32BF_INSN_L_SFGTUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 3 :
             if ((entire_insn & 0xffe00000) == 0xbc600000)
-              { itype = OR1K32BF_INSN_L_SFGEUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K32BF_INSN_L_SFGEUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 4 :
             if ((entire_insn & 0xffe00000) == 0xbc800000)
-              { itype = OR1K32BF_INSN_L_SFLTUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K32BF_INSN_L_SFLTUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 5 :
             if ((entire_insn & 0xffe00000) == 0xbca00000)
-              { itype = OR1K32BF_INSN_L_SFLEUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K32BF_INSN_L_SFLEUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 10 :
             if ((entire_insn & 0xffe00000) == 0xbd400000)
@@ -1206,7 +1206,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1616 :
         if ((entire_insn & 0xffe007ff) == 0xc80000d0)
-          { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1696 : /* fall through */
       case 1697 : /* fall through */
@@ -1443,62 +1443,62 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
           {
           case 0 :
             if ((entire_insn & 0xffe007ff) == 0xe4000000)
-              { itype = OR1K32BF_INSN_L_SFEQ; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFEQ; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 1 :
             if ((entire_insn & 0xffe007ff) == 0xe4200000)
-              { itype = OR1K32BF_INSN_L_SFNE; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFNE; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 2 :
             if ((entire_insn & 0xffe007ff) == 0xe4400000)
-              { itype = OR1K32BF_INSN_L_SFGTU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFGTU; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 3 :
             if ((entire_insn & 0xffe007ff) == 0xe4600000)
-              { itype = OR1K32BF_INSN_L_SFGEU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFGEU; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 4 :
             if ((entire_insn & 0xffe007ff) == 0xe4800000)
-              { itype = OR1K32BF_INSN_L_SFLTU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFLTU; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 5 :
             if ((entire_insn & 0xffe007ff) == 0xe4a00000)
-              { itype = OR1K32BF_INSN_L_SFLEU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFLEU; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 10 :
             if ((entire_insn & 0xffe007ff) == 0xe5400000)
-              { itype = OR1K32BF_INSN_L_SFGTS; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFGTS; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 11 :
             if ((entire_insn & 0xffe007ff) == 0xe5600000)
-              { itype = OR1K32BF_INSN_L_SFGES; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFGES; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 12 :
             if ((entire_insn & 0xffe007ff) == 0xe5800000)
-              { itype = OR1K32BF_INSN_L_SFLTS; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFLTS; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 13 :
             if ((entire_insn & 0xffe007ff) == 0xe5a00000)
-              { itype = OR1K32BF_INSN_L_SFLES; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K32BF_INSN_L_SFLES; goto extract_sfmt_l_sfgts; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
         }
       case 1920 :
         if ((entire_insn & 0xffffffff) == 0xf0000000)
-          { itype = OR1K32BF_INSN_L_CUST5; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST5; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1952 :
         if ((entire_insn & 0xffffffff) == 0xf4000000)
-          { itype = OR1K32BF_INSN_L_CUST6; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST6; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1984 :
         if ((entire_insn & 0xffffffff) == 0xf8000000)
-          { itype = OR1K32BF_INSN_L_CUST7; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST7; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 2016 :
         if ((entire_insn & 0xffffffff) == 0xfc000000)
-          { itype = OR1K32BF_INSN_L_CUST8; goto extract_sfmt_l_cust1; }
+          { itype = OR1K32BF_INSN_L_CUST8; goto extract_sfmt_l_rfe; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       }
@@ -1618,6 +1618,19 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
+ extract_sfmt_l_rfe:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+#define FLD(f) abuf->fields.sfmt_empty.f
+
+
+  /* Record the fields for the semantic handler.  */
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_rfe", (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
  extract_sfmt_l_nop_imm:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
@@ -1686,10 +1699,10 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16);
 
   /* Record the fields for the semantic handler.  */
-  FLD (f_r1) = f_r1;
   FLD (f_r2) = f_r2;
   FLD (f_uimm16) = f_uimm16;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_mfspr", "f_r1 0x%x", 'x', f_r1, "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, (char *) 0));
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_mfspr", "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
 #undef FLD
     return idesc;
@@ -2099,29 +2112,6 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_l_andi:
-  {
-    const IDESC *idesc = &or1k32bf_insn_data[itype];
-    CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
-    UINT f_r1;
-    UINT f_r2;
-    UINT f_uimm16;
-
-    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
-    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
-    f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16);
-
-  /* Record the fields for the semantic handler.  */
-  FLD (f_r2) = f_r2;
-  FLD (f_uimm16) = f_uimm16;
-  FLD (f_r1) = f_r1;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_andi", "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
-
-#undef FLD
-    return idesc;
-  }
-
  extract_sfmt_l_xori:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
@@ -2234,7 +2224,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_l_sfgtu:
+ extract_sfmt_l_sfgts:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
     CGEN_INSN_WORD insn = entire_insn;
@@ -2248,27 +2238,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   /* Record the fields for the semantic handler.  */
   FLD (f_r2) = f_r2;
   FLD (f_r3) = f_r3;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_sfgtu", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
-
-#undef FLD
-    return idesc;
-  }
-
- extract_sfmt_l_sfgtui:
-  {
-    const IDESC *idesc = &or1k32bf_insn_data[itype];
-    CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
-    UINT f_r2;
-    UINT f_uimm16;
-
-    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
-    f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16);
-
-  /* Record the fields for the semantic handler.  */
-  FLD (f_r2) = f_r2;
-  FLD (f_uimm16) = f_uimm16;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_sfgtui", "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, (char *) 0));
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_sfgts", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
 
 #undef FLD
     return idesc;
@@ -2318,34 +2288,17 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
     CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_sw.f
-    UINT f_imm16_25_5;
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
     UINT f_r2;
-    UINT f_imm16_10_11;
-    INT f_simm16_split;
+    INT f_simm16;
 
-    f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
     f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
-    f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11);
-  f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));
+    f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16);
 
   /* Record the fields for the semantic handler.  */
   FLD (f_r2) = f_r2;
-  FLD (f_simm16_split) = f_simm16_split;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_maci", "f_r2 0x%x", 'x', f_r2, "f_simm16_split 0x%x", 'x', f_simm16_split, (char *) 0));
-
-#undef FLD
-    return idesc;
-  }
-
- extract_sfmt_l_cust1:
-  {
-    const IDESC *idesc = &or1k32bf_insn_data[itype];
-#define FLD(f) abuf->fields.sfmt_empty.f
-
-
-  /* Record the fields for the semantic handler.  */
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_cust1", (char *) 0));
+  FLD (f_simm16) = f_simm16;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_maci", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, (char *) 0));
 
 #undef FLD
     return idesc;
diff --git a/sim/or1k/decode32.h b/sim/or1k/decode32.h
index 56f4669..a854856 100644
--- a/sim/or1k/decode32.h
+++ b/sim/or1k/decode32.h
@@ -49,11 +49,11 @@ typedef enum or1k32bf_insn_type {
  , OR1K32BF_INSN_L_FL1, OR1K32BF_INSN_L_ANDI, OR1K32BF_INSN_L_ORI, OR1K32BF_INSN_L_XORI
  , OR1K32BF_INSN_L_ADDI, OR1K32BF_INSN_L_ADDIC, OR1K32BF_INSN_L_MULI, OR1K32BF_INSN_L_EXTHS
  , OR1K32BF_INSN_L_EXTBS, OR1K32BF_INSN_L_EXTHZ, OR1K32BF_INSN_L_EXTBZ, OR1K32BF_INSN_L_EXTWS
- , OR1K32BF_INSN_L_EXTWZ, OR1K32BF_INSN_L_CMOV, OR1K32BF_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGEU
- , OR1K32BF_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLEU, OR1K32BF_INSN_L_SFGTS, OR1K32BF_INSN_L_SFGES
- , OR1K32BF_INSN_L_SFLTS, OR1K32BF_INSN_L_SFLES, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGEUI
- , OR1K32BF_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFGTSI, OR1K32BF_INSN_L_SFGESI
- , OR1K32BF_INSN_L_SFLTSI, OR1K32BF_INSN_L_SFLESI, OR1K32BF_INSN_L_SFEQ, OR1K32BF_INSN_L_SFEQI
+ , OR1K32BF_INSN_L_EXTWZ, OR1K32BF_INSN_L_CMOV, OR1K32BF_INSN_L_SFGTS, OR1K32BF_INSN_L_SFGTSI
+ , OR1K32BF_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGES, OR1K32BF_INSN_L_SFGESI
+ , OR1K32BF_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFLTS, OR1K32BF_INSN_L_SFLTSI
+ , OR1K32BF_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLES, OR1K32BF_INSN_L_SFLESI
+ , OR1K32BF_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFEQ, OR1K32BF_INSN_L_SFEQI
  , OR1K32BF_INSN_L_SFNE, OR1K32BF_INSN_L_SFNEI, OR1K32BF_INSN_L_MAC, OR1K32BF_INSN_L_MSB
  , OR1K32BF_INSN_L_MACI, OR1K32BF_INSN_L_CUST1, OR1K32BF_INSN_L_CUST2, OR1K32BF_INSN_L_CUST3
  , OR1K32BF_INSN_L_CUST4, OR1K32BF_INSN_L_CUST5, OR1K32BF_INSN_L_CUST6, OR1K32BF_INSN_L_CUST7
@@ -67,17 +67,16 @@ typedef enum or1k32bf_insn_type {
 /* Enum declaration for semantic formats in cpu family or1k32bf.  */
 typedef enum or1k32bf_sfmt_type {
   OR1K32BF_SFMT_EMPTY, OR1K32BF_SFMT_L_J, OR1K32BF_SFMT_L_JAL, OR1K32BF_SFMT_L_JR
- , OR1K32BF_SFMT_L_JALR, OR1K32BF_SFMT_L_BNF, OR1K32BF_SFMT_L_TRAP, OR1K32BF_SFMT_L_NOP_IMM
- , OR1K32BF_SFMT_L_MOVHI, OR1K32BF_SFMT_L_MACRC, OR1K32BF_SFMT_L_MFSPR, OR1K32BF_SFMT_L_MTSPR
- , OR1K32BF_SFMT_L_LWZ, OR1K32BF_SFMT_L_LWS, OR1K32BF_SFMT_L_LBZ, OR1K32BF_SFMT_L_LBS
- , OR1K32BF_SFMT_L_LHZ, OR1K32BF_SFMT_L_LHS, OR1K32BF_SFMT_L_SW, OR1K32BF_SFMT_L_SB
- , OR1K32BF_SFMT_L_SH, OR1K32BF_SFMT_L_SLL, OR1K32BF_SFMT_L_SLLI, OR1K32BF_SFMT_L_AND
- , OR1K32BF_SFMT_L_ADD, OR1K32BF_SFMT_L_ADDC, OR1K32BF_SFMT_L_DIV, OR1K32BF_SFMT_L_FF1
- , OR1K32BF_SFMT_L_ANDI, OR1K32BF_SFMT_L_XORI, OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC
- , OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV, OR1K32BF_SFMT_L_SFGTU, OR1K32BF_SFMT_L_SFGTUI
- , OR1K32BF_SFMT_L_SFGTSI, OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI, OR1K32BF_SFMT_L_CUST1
- , OR1K32BF_SFMT_LF_ADD_S, OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S
- , OR1K32BF_SFMT_LF_MADD_S
+ , OR1K32BF_SFMT_L_JALR, OR1K32BF_SFMT_L_BNF, OR1K32BF_SFMT_L_TRAP, OR1K32BF_SFMT_L_RFE
+ , OR1K32BF_SFMT_L_NOP_IMM, OR1K32BF_SFMT_L_MOVHI, OR1K32BF_SFMT_L_MACRC, OR1K32BF_SFMT_L_MFSPR
+ , OR1K32BF_SFMT_L_MTSPR, OR1K32BF_SFMT_L_LWZ, OR1K32BF_SFMT_L_LWS, OR1K32BF_SFMT_L_LBZ
+ , OR1K32BF_SFMT_L_LBS, OR1K32BF_SFMT_L_LHZ, OR1K32BF_SFMT_L_LHS, OR1K32BF_SFMT_L_SW
+ , OR1K32BF_SFMT_L_SB, OR1K32BF_SFMT_L_SH, OR1K32BF_SFMT_L_SLL, OR1K32BF_SFMT_L_SLLI
+ , OR1K32BF_SFMT_L_AND, OR1K32BF_SFMT_L_ADD, OR1K32BF_SFMT_L_ADDC, OR1K32BF_SFMT_L_DIV
+ , OR1K32BF_SFMT_L_FF1, OR1K32BF_SFMT_L_XORI, OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC
+ , OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV, OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI
+ , OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI, OR1K32BF_SFMT_LF_ADD_S, OR1K32BF_SFMT_LF_ITOF_S
+ , OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S, OR1K32BF_SFMT_LF_MADD_S
 } OR1K32BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/decode64.c b/sim/or1k/decode64.c
index b3c774d9..752fa13 100644
--- a/sim/or1k/decode64.c
+++ b/sim/or1k/decode64.c
@@ -54,7 +54,7 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_BF, OR1K64BF_INSN_L_BF, OR1K64BF_SFMT_L_BNF },
   { OR1K_INSN_L_TRAP, OR1K64BF_INSN_L_TRAP, OR1K64BF_SFMT_L_TRAP },
   { OR1K_INSN_L_SYS, OR1K64BF_INSN_L_SYS, OR1K64BF_SFMT_L_TRAP },
-  { OR1K_INSN_L_RFE, OR1K64BF_INSN_L_RFE, OR1K64BF_SFMT_L_TRAP },
+  { OR1K_INSN_L_RFE, OR1K64BF_INSN_L_RFE, OR1K64BF_SFMT_L_RFE },
   { OR1K_INSN_L_NOP_IMM, OR1K64BF_INSN_L_NOP_IMM, OR1K64BF_SFMT_L_NOP_IMM },
   { OR1K_INSN_L_MOVHI, OR1K64BF_INSN_L_MOVHI, OR1K64BF_SFMT_L_MOVHI },
   { OR1K_INSN_L_MACRC, OR1K64BF_INSN_L_MACRC, OR1K64BF_SFMT_L_MACRC },
@@ -89,8 +89,8 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_DIVU, OR1K64BF_INSN_L_DIVU, OR1K64BF_SFMT_L_DIV },
   { OR1K_INSN_L_FF1, OR1K64BF_INSN_L_FF1, OR1K64BF_SFMT_L_FF1 },
   { OR1K_INSN_L_FL1, OR1K64BF_INSN_L_FL1, OR1K64BF_SFMT_L_FF1 },
-  { OR1K_INSN_L_ANDI, OR1K64BF_INSN_L_ANDI, OR1K64BF_SFMT_L_ANDI },
-  { OR1K_INSN_L_ORI, OR1K64BF_INSN_L_ORI, OR1K64BF_SFMT_L_ANDI },
+  { OR1K_INSN_L_ANDI, OR1K64BF_INSN_L_ANDI, OR1K64BF_SFMT_L_MFSPR },
+  { OR1K_INSN_L_ORI, OR1K64BF_INSN_L_ORI, OR1K64BF_SFMT_L_MFSPR },
   { OR1K_INSN_L_XORI, OR1K64BF_INSN_L_XORI, OR1K64BF_SFMT_L_XORI },
   { OR1K_INSN_L_ADDI, OR1K64BF_INSN_L_ADDI, OR1K64BF_SFMT_L_ADDI },
   { OR1K_INSN_L_ADDIC, OR1K64BF_INSN_L_ADDIC, OR1K64BF_SFMT_L_ADDIC },
@@ -102,37 +102,37 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_EXTWS, OR1K64BF_INSN_L_EXTWS, OR1K64BF_SFMT_L_EXTHS },
   { OR1K_INSN_L_EXTWZ, OR1K64BF_INSN_L_EXTWZ, OR1K64BF_SFMT_L_EXTHS },
   { OR1K_INSN_L_CMOV, OR1K64BF_INSN_L_CMOV, OR1K64BF_SFMT_L_CMOV },
-  { OR1K_INSN_L_SFGTU, OR1K64BF_INSN_L_SFGTU, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGEU, OR1K64BF_INSN_L_SFGEU, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLTU, OR1K64BF_INSN_L_SFLTU, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLEU, OR1K64BF_INSN_L_SFLEU, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGTS, OR1K64BF_INSN_L_SFGTS, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGES, OR1K64BF_INSN_L_SFGES, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLTS, OR1K64BF_INSN_L_SFLTS, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFLES, OR1K64BF_INSN_L_SFLES, OR1K64BF_SFMT_L_SFGTU },
-  { OR1K_INSN_L_SFGTUI, OR1K64BF_INSN_L_SFGTUI, OR1K64BF_SFMT_L_SFGTUI },
-  { OR1K_INSN_L_SFGEUI, OR1K64BF_INSN_L_SFGEUI, OR1K64BF_SFMT_L_SFGTUI },
-  { OR1K_INSN_L_SFLTUI, OR1K64BF_INSN_L_SFLTUI, OR1K64BF_SFMT_L_SFGTUI },
-  { OR1K_INSN_L_SFLEUI, OR1K64BF_INSN_L_SFLEUI, OR1K64BF_SFMT_L_SFGTUI },
+  { OR1K_INSN_L_SFGTS, OR1K64BF_INSN_L_SFGTS, OR1K64BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFGTSI, OR1K64BF_INSN_L_SFGTSI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFGTU, OR1K64BF_INSN_L_SFGTU, OR1K64BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFGTUI, OR1K64BF_INSN_L_SFGTUI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFGES, OR1K64BF_INSN_L_SFGES, OR1K64BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFGESI, OR1K64BF_INSN_L_SFGESI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFGEU, OR1K64BF_INSN_L_SFGEU, OR1K64BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFGEUI, OR1K64BF_INSN_L_SFGEUI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFLTS, OR1K64BF_INSN_L_SFLTS, OR1K64BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFLTSI, OR1K64BF_INSN_L_SFLTSI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFLTU, OR1K64BF_INSN_L_SFLTU, OR1K64BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFLTUI, OR1K64BF_INSN_L_SFLTUI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFLES, OR1K64BF_INSN_L_SFLES, OR1K64BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFLESI, OR1K64BF_INSN_L_SFLESI, OR1K64BF_SFMT_L_SFGTSI },
-  { OR1K_INSN_L_SFEQ, OR1K64BF_INSN_L_SFEQ, OR1K64BF_SFMT_L_SFGTU },
+  { OR1K_INSN_L_SFLEU, OR1K64BF_INSN_L_SFLEU, OR1K64BF_SFMT_L_SFGTS },
+  { OR1K_INSN_L_SFLEUI, OR1K64BF_INSN_L_SFLEUI, OR1K64BF_SFMT_L_SFGTSI },
+  { OR1K_INSN_L_SFEQ, OR1K64BF_INSN_L_SFEQ, OR1K64BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFEQI, OR1K64BF_INSN_L_SFEQI, OR1K64BF_SFMT_L_SFGTSI },
-  { OR1K_INSN_L_SFNE, OR1K64BF_INSN_L_SFNE, OR1K64BF_SFMT_L_SFGTU },
+  { OR1K_INSN_L_SFNE, OR1K64BF_INSN_L_SFNE, OR1K64BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFNEI, OR1K64BF_INSN_L_SFNEI, OR1K64BF_SFMT_L_SFGTSI },
   { OR1K_INSN_L_MAC, OR1K64BF_INSN_L_MAC, OR1K64BF_SFMT_L_MAC },
   { OR1K_INSN_L_MSB, OR1K64BF_INSN_L_MSB, OR1K64BF_SFMT_L_MAC },
   { OR1K_INSN_L_MACI, OR1K64BF_INSN_L_MACI, OR1K64BF_SFMT_L_MACI },
-  { OR1K_INSN_L_CUST1, OR1K64BF_INSN_L_CUST1, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST2, OR1K64BF_INSN_L_CUST2, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST3, OR1K64BF_INSN_L_CUST3, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST4, OR1K64BF_INSN_L_CUST4, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST5, OR1K64BF_INSN_L_CUST5, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST6, OR1K64BF_INSN_L_CUST6, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST7, OR1K64BF_INSN_L_CUST7, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_L_CUST8, OR1K64BF_INSN_L_CUST8, OR1K64BF_SFMT_L_CUST1 },
+  { OR1K_INSN_L_CUST1, OR1K64BF_INSN_L_CUST1, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST2, OR1K64BF_INSN_L_CUST2, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST3, OR1K64BF_INSN_L_CUST3, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST4, OR1K64BF_INSN_L_CUST4, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST5, OR1K64BF_INSN_L_CUST5, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST6, OR1K64BF_INSN_L_CUST6, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST7, OR1K64BF_INSN_L_CUST7, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST8, OR1K64BF_INSN_L_CUST8, OR1K64BF_SFMT_L_RFE },
   { OR1K_INSN_LF_ADD_S, OR1K64BF_INSN_LF_ADD_S, OR1K64BF_SFMT_LF_ADD_S },
   { OR1K_INSN_LF_ADD_D, OR1K64BF_INSN_LF_ADD_D, OR1K64BF_SFMT_LF_ADD_D },
   { OR1K_INSN_LF_SUB_S, OR1K64BF_INSN_LF_SUB_S, OR1K64BF_SFMT_LF_ADD_S },
@@ -161,8 +161,8 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_LF_LE_D, OR1K64BF_INSN_LF_LE_D, OR1K64BF_SFMT_LF_EQ_D },
   { OR1K_INSN_LF_MADD_S, OR1K64BF_INSN_LF_MADD_S, OR1K64BF_SFMT_LF_MADD_S },
   { OR1K_INSN_LF_MADD_D, OR1K64BF_INSN_LF_MADD_D, OR1K64BF_SFMT_LF_MADD_D },
-  { OR1K_INSN_LF_CUST1_S, OR1K64BF_INSN_LF_CUST1_S, OR1K64BF_SFMT_L_CUST1 },
-  { OR1K_INSN_LF_CUST1_D, OR1K64BF_INSN_LF_CUST1_D, OR1K64BF_SFMT_L_CUST1 },
+  { OR1K_INSN_LF_CUST1_S, OR1K64BF_INSN_LF_CUST1_S, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_LF_CUST1_D, OR1K64BF_INSN_LF_CUST1_D, OR1K64BF_SFMT_L_RFE },
 };
 
 static const struct insn_sem or1k64bf_insn_sem_invalid =
@@ -505,7 +505,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
         }
       case 288 :
         if ((entire_insn & 0xffffffff) == 0x24000000)
-          { itype = OR1K64BF_INSN_L_RFE; goto extract_sfmt_l_trap; }
+          { itype = OR1K64BF_INSN_L_RFE; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 544 :
         if ((entire_insn & 0xffff07ff) == 0x44000000)
@@ -547,24 +547,24 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 637 : /* fall through */
       case 638 : /* fall through */
       case 639 :
-        if ((entire_insn & 0xfc1f0000) == 0x4c000000)
+        if ((entire_insn & 0xffe00000) == 0x4c000000)
           { itype = OR1K64BF_INSN_L_MACI; goto extract_sfmt_l_maci; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 896 :
         if ((entire_insn & 0xffffffff) == 0x70000000)
-          { itype = OR1K64BF_INSN_L_CUST1; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST1; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 928 :
         if ((entire_insn & 0xffffffff) == 0x74000000)
-          { itype = OR1K64BF_INSN_L_CUST2; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST2; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 960 :
         if ((entire_insn & 0xffffffff) == 0x78000000)
-          { itype = OR1K64BF_INSN_L_CUST3; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST3; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 992 :
         if ((entire_insn & 0xffffffff) == 0x7c000000)
-          { itype = OR1K64BF_INSN_L_CUST4; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST4; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1056 : /* fall through */
       case 1057 : /* fall through */
@@ -853,7 +853,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1340 : /* fall through */
       case 1341 : /* fall through */
       case 1342 : /* fall through */
-      case 1343 : itype = OR1K64BF_INSN_L_ANDI; goto extract_sfmt_l_andi;
+      case 1343 : itype = OR1K64BF_INSN_L_ANDI; goto extract_sfmt_l_mfspr;
       case 1344 : /* fall through */
       case 1345 : /* fall through */
       case 1346 : /* fall through */
@@ -885,7 +885,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1372 : /* fall through */
       case 1373 : /* fall through */
       case 1374 : /* fall through */
-      case 1375 : itype = OR1K64BF_INSN_L_ORI; goto extract_sfmt_l_andi;
+      case 1375 : itype = OR1K64BF_INSN_L_ORI; goto extract_sfmt_l_mfspr;
       case 1376 : /* fall through */
       case 1377 : /* fall through */
       case 1378 : /* fall through */
@@ -1083,19 +1083,19 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 2 :
             if ((entire_insn & 0xffe00000) == 0xbc400000)
-              { itype = OR1K64BF_INSN_L_SFGTUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K64BF_INSN_L_SFGTUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 3 :
             if ((entire_insn & 0xffe00000) == 0xbc600000)
-              { itype = OR1K64BF_INSN_L_SFGEUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K64BF_INSN_L_SFGEUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 4 :
             if ((entire_insn & 0xffe00000) == 0xbc800000)
-              { itype = OR1K64BF_INSN_L_SFLTUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K64BF_INSN_L_SFLTUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 5 :
             if ((entire_insn & 0xffe00000) == 0xbca00000)
-              { itype = OR1K64BF_INSN_L_SFLEUI; goto extract_sfmt_l_sfgtui; }
+              { itype = OR1K64BF_INSN_L_SFLEUI; goto extract_sfmt_l_sfgtsi; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 10 :
             if ((entire_insn & 0xffe00000) == 0xbd400000)
@@ -1167,7 +1167,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 7 :
             if ((entire_insn & 0xffe007ff) == 0xc80000e0)
-              { itype = OR1K64BF_INSN_LF_CUST1_D; goto extract_sfmt_l_cust1; }
+              { itype = OR1K64BF_INSN_LF_CUST1_D; goto extract_sfmt_l_rfe; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
@@ -1235,7 +1235,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 3 :
             if ((entire_insn & 0xffe007ff) == 0xc80000d0)
-              { itype = OR1K64BF_INSN_LF_CUST1_S; goto extract_sfmt_l_cust1; }
+              { itype = OR1K64BF_INSN_LF_CUST1_S; goto extract_sfmt_l_rfe; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
@@ -1519,62 +1519,62 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
           {
           case 0 :
             if ((entire_insn & 0xffe007ff) == 0xe4000000)
-              { itype = OR1K64BF_INSN_L_SFEQ; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFEQ; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 1 :
             if ((entire_insn & 0xffe007ff) == 0xe4200000)
-              { itype = OR1K64BF_INSN_L_SFNE; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFNE; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 2 :
             if ((entire_insn & 0xffe007ff) == 0xe4400000)
-              { itype = OR1K64BF_INSN_L_SFGTU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFGTU; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 3 :
             if ((entire_insn & 0xffe007ff) == 0xe4600000)
-              { itype = OR1K64BF_INSN_L_SFGEU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFGEU; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 4 :
             if ((entire_insn & 0xffe007ff) == 0xe4800000)
-              { itype = OR1K64BF_INSN_L_SFLTU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFLTU; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 5 :
             if ((entire_insn & 0xffe007ff) == 0xe4a00000)
-              { itype = OR1K64BF_INSN_L_SFLEU; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFLEU; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 10 :
             if ((entire_insn & 0xffe007ff) == 0xe5400000)
-              { itype = OR1K64BF_INSN_L_SFGTS; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFGTS; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 11 :
             if ((entire_insn & 0xffe007ff) == 0xe5600000)
-              { itype = OR1K64BF_INSN_L_SFGES; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFGES; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 12 :
             if ((entire_insn & 0xffe007ff) == 0xe5800000)
-              { itype = OR1K64BF_INSN_L_SFLTS; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFLTS; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 13 :
             if ((entire_insn & 0xffe007ff) == 0xe5a00000)
-              { itype = OR1K64BF_INSN_L_SFLES; goto extract_sfmt_l_sfgtu; }
+              { itype = OR1K64BF_INSN_L_SFLES; goto extract_sfmt_l_sfgts; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
         }
       case 1920 :
         if ((entire_insn & 0xffffffff) == 0xf0000000)
-          { itype = OR1K64BF_INSN_L_CUST5; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST5; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1952 :
         if ((entire_insn & 0xffffffff) == 0xf4000000)
-          { itype = OR1K64BF_INSN_L_CUST6; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST6; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1984 :
         if ((entire_insn & 0xffffffff) == 0xf8000000)
-          { itype = OR1K64BF_INSN_L_CUST7; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST7; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 2016 :
         if ((entire_insn & 0xffffffff) == 0xfc000000)
-          { itype = OR1K64BF_INSN_L_CUST8; goto extract_sfmt_l_cust1; }
+          { itype = OR1K64BF_INSN_L_CUST8; goto extract_sfmt_l_rfe; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       }
@@ -1694,6 +1694,19 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
+ extract_sfmt_l_rfe:
+  {
+    const IDESC *idesc = &or1k64bf_insn_data[itype];
+#define FLD(f) abuf->fields.sfmt_empty.f
+
+
+  /* Record the fields for the semantic handler.  */
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_rfe", (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
  extract_sfmt_l_nop_imm:
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
@@ -1762,10 +1775,10 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16);
 
   /* Record the fields for the semantic handler.  */
-  FLD (f_r1) = f_r1;
   FLD (f_r2) = f_r2;
   FLD (f_uimm16) = f_uimm16;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_mfspr", "f_r1 0x%x", 'x', f_r1, "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, (char *) 0));
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_mfspr", "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
 #undef FLD
     return idesc;
@@ -2175,29 +2188,6 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_l_andi:
-  {
-    const IDESC *idesc = &or1k64bf_insn_data[itype];
-    CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
-    UINT f_r1;
-    UINT f_r2;
-    UINT f_uimm16;
-
-    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
-    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
-    f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16);
-
-  /* Record the fields for the semantic handler.  */
-  FLD (f_r2) = f_r2;
-  FLD (f_uimm16) = f_uimm16;
-  FLD (f_r1) = f_r1;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_andi", "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
-
-#undef FLD
-    return idesc;
-  }
-
  extract_sfmt_l_xori:
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
@@ -2310,7 +2300,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_l_sfgtu:
+ extract_sfmt_l_sfgts:
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
     CGEN_INSN_WORD insn = entire_insn;
@@ -2324,27 +2314,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
   /* Record the fields for the semantic handler.  */
   FLD (f_r2) = f_r2;
   FLD (f_r3) = f_r3;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_sfgtu", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
-
-#undef FLD
-    return idesc;
-  }
-
- extract_sfmt_l_sfgtui:
-  {
-    const IDESC *idesc = &or1k64bf_insn_data[itype];
-    CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
-    UINT f_r2;
-    UINT f_uimm16;
-
-    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
-    f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16);
-
-  /* Record the fields for the semantic handler.  */
-  FLD (f_r2) = f_r2;
-  FLD (f_uimm16) = f_uimm16;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_sfgtui", "f_r2 0x%x", 'x', f_r2, "f_uimm16 0x%x", 'x', f_uimm16, (char *) 0));
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_sfgts", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
 
 #undef FLD
     return idesc;
@@ -2394,34 +2364,17 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
     CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_sw.f
-    UINT f_imm16_25_5;
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
     UINT f_r2;
-    UINT f_imm16_10_11;
-    INT f_simm16_split;
+    INT f_simm16;
 
-    f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
     f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
-    f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11);
-  f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));
+    f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16);
 
   /* Record the fields for the semantic handler.  */
   FLD (f_r2) = f_r2;
-  FLD (f_simm16_split) = f_simm16_split;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_maci", "f_r2 0x%x", 'x', f_r2, "f_simm16_split 0x%x", 'x', f_simm16_split, (char *) 0));
-
-#undef FLD
-    return idesc;
-  }
-
- extract_sfmt_l_cust1:
-  {
-    const IDESC *idesc = &or1k64bf_insn_data[itype];
-#define FLD(f) abuf->fields.sfmt_empty.f
-
-
-  /* Record the fields for the semantic handler.  */
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_cust1", (char *) 0));
+  FLD (f_simm16) = f_simm16;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_maci", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, (char *) 0));
 
 #undef FLD
     return idesc;
diff --git a/sim/or1k/decode64.h b/sim/or1k/decode64.h
index a5f5806..db5f56f 100644
--- a/sim/or1k/decode64.h
+++ b/sim/or1k/decode64.h
@@ -49,11 +49,11 @@ typedef enum or1k64bf_insn_type {
  , OR1K64BF_INSN_L_FL1, OR1K64BF_INSN_L_ANDI, OR1K64BF_INSN_L_ORI, OR1K64BF_INSN_L_XORI
  , OR1K64BF_INSN_L_ADDI, OR1K64BF_INSN_L_ADDIC, OR1K64BF_INSN_L_MULI, OR1K64BF_INSN_L_EXTHS
  , OR1K64BF_INSN_L_EXTBS, OR1K64BF_INSN_L_EXTHZ, OR1K64BF_INSN_L_EXTBZ, OR1K64BF_INSN_L_EXTWS
- , OR1K64BF_INSN_L_EXTWZ, OR1K64BF_INSN_L_CMOV, OR1K64BF_INSN_L_SFGTU, OR1K64BF_INSN_L_SFGEU
- , OR1K64BF_INSN_L_SFLTU, OR1K64BF_INSN_L_SFLEU, OR1K64BF_INSN_L_SFGTS, OR1K64BF_INSN_L_SFGES
- , OR1K64BF_INSN_L_SFLTS, OR1K64BF_INSN_L_SFLES, OR1K64BF_INSN_L_SFGTUI, OR1K64BF_INSN_L_SFGEUI
- , OR1K64BF_INSN_L_SFLTUI, OR1K64BF_INSN_L_SFLEUI, OR1K64BF_INSN_L_SFGTSI, OR1K64BF_INSN_L_SFGESI
- , OR1K64BF_INSN_L_SFLTSI, OR1K64BF_INSN_L_SFLESI, OR1K64BF_INSN_L_SFEQ, OR1K64BF_INSN_L_SFEQI
+ , OR1K64BF_INSN_L_EXTWZ, OR1K64BF_INSN_L_CMOV, OR1K64BF_INSN_L_SFGTS, OR1K64BF_INSN_L_SFGTSI
+ , OR1K64BF_INSN_L_SFGTU, OR1K64BF_INSN_L_SFGTUI, OR1K64BF_INSN_L_SFGES, OR1K64BF_INSN_L_SFGESI
+ , OR1K64BF_INSN_L_SFGEU, OR1K64BF_INSN_L_SFGEUI, OR1K64BF_INSN_L_SFLTS, OR1K64BF_INSN_L_SFLTSI
+ , OR1K64BF_INSN_L_SFLTU, OR1K64BF_INSN_L_SFLTUI, OR1K64BF_INSN_L_SFLES, OR1K64BF_INSN_L_SFLESI
+ , OR1K64BF_INSN_L_SFLEU, OR1K64BF_INSN_L_SFLEUI, OR1K64BF_INSN_L_SFEQ, OR1K64BF_INSN_L_SFEQI
  , OR1K64BF_INSN_L_SFNE, OR1K64BF_INSN_L_SFNEI, OR1K64BF_INSN_L_MAC, OR1K64BF_INSN_L_MSB
  , OR1K64BF_INSN_L_MACI, OR1K64BF_INSN_L_CUST1, OR1K64BF_INSN_L_CUST2, OR1K64BF_INSN_L_CUST3
  , OR1K64BF_INSN_L_CUST4, OR1K64BF_INSN_L_CUST5, OR1K64BF_INSN_L_CUST6, OR1K64BF_INSN_L_CUST7
@@ -70,18 +70,17 @@ typedef enum or1k64bf_insn_type {
 /* Enum declaration for semantic formats in cpu family or1k64bf.  */
 typedef enum or1k64bf_sfmt_type {
   OR1K64BF_SFMT_EMPTY, OR1K64BF_SFMT_L_J, OR1K64BF_SFMT_L_JAL, OR1K64BF_SFMT_L_JR
- , OR1K64BF_SFMT_L_JALR, OR1K64BF_SFMT_L_BNF, OR1K64BF_SFMT_L_TRAP, OR1K64BF_SFMT_L_NOP_IMM
- , OR1K64BF_SFMT_L_MOVHI, OR1K64BF_SFMT_L_MACRC, OR1K64BF_SFMT_L_MFSPR, OR1K64BF_SFMT_L_MTSPR
- , OR1K64BF_SFMT_L_LWZ, OR1K64BF_SFMT_L_LWS, OR1K64BF_SFMT_L_LBZ, OR1K64BF_SFMT_L_LBS
- , OR1K64BF_SFMT_L_LHZ, OR1K64BF_SFMT_L_LHS, OR1K64BF_SFMT_L_SW, OR1K64BF_SFMT_L_SB
- , OR1K64BF_SFMT_L_SH, OR1K64BF_SFMT_L_SLL, OR1K64BF_SFMT_L_SLLI, OR1K64BF_SFMT_L_AND
- , OR1K64BF_SFMT_L_ADD, OR1K64BF_SFMT_L_ADDC, OR1K64BF_SFMT_L_DIV, OR1K64BF_SFMT_L_FF1
- , OR1K64BF_SFMT_L_ANDI, OR1K64BF_SFMT_L_XORI, OR1K64BF_SFMT_L_ADDI, OR1K64BF_SFMT_L_ADDIC
- , OR1K64BF_SFMT_L_EXTHS, OR1K64BF_SFMT_L_CMOV, OR1K64BF_SFMT_L_SFGTU, OR1K64BF_SFMT_L_SFGTUI
- , OR1K64BF_SFMT_L_SFGTSI, OR1K64BF_SFMT_L_MAC, OR1K64BF_SFMT_L_MACI, OR1K64BF_SFMT_L_CUST1
- , OR1K64BF_SFMT_LF_ADD_S, OR1K64BF_SFMT_LF_ADD_D, OR1K64BF_SFMT_LF_ITOF_S, OR1K64BF_SFMT_LF_ITOF_D
- , OR1K64BF_SFMT_LF_FTOI_S, OR1K64BF_SFMT_LF_FTOI_D, OR1K64BF_SFMT_LF_EQ_S, OR1K64BF_SFMT_LF_EQ_D
- , OR1K64BF_SFMT_LF_MADD_S, OR1K64BF_SFMT_LF_MADD_D
+ , OR1K64BF_SFMT_L_JALR, OR1K64BF_SFMT_L_BNF, OR1K64BF_SFMT_L_TRAP, OR1K64BF_SFMT_L_RFE
+ , OR1K64BF_SFMT_L_NOP_IMM, OR1K64BF_SFMT_L_MOVHI, OR1K64BF_SFMT_L_MACRC, OR1K64BF_SFMT_L_MFSPR
+ , OR1K64BF_SFMT_L_MTSPR, OR1K64BF_SFMT_L_LWZ, OR1K64BF_SFMT_L_LWS, OR1K64BF_SFMT_L_LBZ
+ , OR1K64BF_SFMT_L_LBS, OR1K64BF_SFMT_L_LHZ, OR1K64BF_SFMT_L_LHS, OR1K64BF_SFMT_L_SW
+ , OR1K64BF_SFMT_L_SB, OR1K64BF_SFMT_L_SH, OR1K64BF_SFMT_L_SLL, OR1K64BF_SFMT_L_SLLI
+ , OR1K64BF_SFMT_L_AND, OR1K64BF_SFMT_L_ADD, OR1K64BF_SFMT_L_ADDC, OR1K64BF_SFMT_L_DIV
+ , OR1K64BF_SFMT_L_FF1, OR1K64BF_SFMT_L_XORI, OR1K64BF_SFMT_L_ADDI, OR1K64BF_SFMT_L_ADDIC
+ , OR1K64BF_SFMT_L_EXTHS, OR1K64BF_SFMT_L_CMOV, OR1K64BF_SFMT_L_SFGTS, OR1K64BF_SFMT_L_SFGTSI
+ , OR1K64BF_SFMT_L_MAC, OR1K64BF_SFMT_L_MACI, OR1K64BF_SFMT_LF_ADD_S, OR1K64BF_SFMT_LF_ADD_D
+ , OR1K64BF_SFMT_LF_ITOF_S, OR1K64BF_SFMT_LF_ITOF_D, OR1K64BF_SFMT_LF_FTOI_S, OR1K64BF_SFMT_LF_FTOI_D
+ , OR1K64BF_SFMT_LF_EQ_S, OR1K64BF_SFMT_LF_EQ_D, OR1K64BF_SFMT_LF_MADD_S, OR1K64BF_SFMT_LF_MADD_D
 } OR1K64BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/model32.c b/sim/or1k/model32.c
index 7a1a1b6..72c0d61 100644
--- a/sim/or1k/model32.c
+++ b/sim/or1k/model32.c
@@ -931,7 +931,7 @@ model_or1200_l_cmov (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -947,9 +947,9 @@ model_or1200_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -963,7 +963,7 @@ model_or1200_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -979,9 +979,9 @@ model_or1200_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -995,7 +995,7 @@ model_or1200_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1011,9 +1011,9 @@ model_or1200_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1027,7 +1027,7 @@ model_or1200_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1043,9 +1043,9 @@ model_or1200_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1059,9 +1059,9 @@ model_or1200_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1075,9 +1075,9 @@ model_or1200_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1091,9 +1091,9 @@ model_or1200_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1107,9 +1107,9 @@ model_or1200_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1123,9 +1123,9 @@ model_or1200_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1139,7 +1139,7 @@ model_or1200_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1155,9 +1155,9 @@ model_or1200_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1171,7 +1171,7 @@ model_or1200_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1285,7 +1285,7 @@ model_or1200_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 static int
 model_or1200_l_maci (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2563,7 +2563,7 @@ model_or1200nd_l_cmov (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2579,9 +2579,9 @@ model_or1200nd_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2595,7 +2595,7 @@ model_or1200nd_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2611,9 +2611,9 @@ model_or1200nd_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2627,7 +2627,7 @@ model_or1200nd_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2643,9 +2643,9 @@ model_or1200nd_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2659,7 +2659,7 @@ model_or1200nd_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2675,9 +2675,9 @@ model_or1200nd_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2691,9 +2691,9 @@ model_or1200nd_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2707,9 +2707,9 @@ model_or1200nd_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2723,9 +2723,9 @@ model_or1200nd_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2739,9 +2739,9 @@ model_or1200nd_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2755,9 +2755,9 @@ model_or1200nd_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2771,7 +2771,7 @@ model_or1200nd_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2787,9 +2787,9 @@ model_or1200nd_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2803,7 +2803,7 @@ model_or1200nd_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2917,7 +2917,7 @@ model_or1200nd_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 static int
 model_or1200nd_l_maci (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3366,22 +3366,22 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_EXTWS, model_or1200_l_extws, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_EXTWZ, model_or1200_l_extwz, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CMOV, model_or1200_l_cmov, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGTU, model_or1200_l_sfgtu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGEU, model_or1200_l_sfgeu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLTU, model_or1200_l_sfltu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLEU, model_or1200_l_sfleu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFGTS, model_or1200_l_sfgts, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGES, model_or1200_l_sfges, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLTS, model_or1200_l_sflts, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLES, model_or1200_l_sfles, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGTUI, model_or1200_l_sfgtui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGEUI, model_or1200_l_sfgeui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLTUI, model_or1200_l_sfltui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLEUI, model_or1200_l_sfleui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFGTSI, model_or1200_l_sfgtsi, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGTU, model_or1200_l_sfgtu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGTUI, model_or1200_l_sfgtui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGES, model_or1200_l_sfges, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFGESI, model_or1200_l_sfgesi, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGEU, model_or1200_l_sfgeu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGEUI, model_or1200_l_sfgeui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLTS, model_or1200_l_sflts, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFLTSI, model_or1200_l_sfltsi, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLTU, model_or1200_l_sfltu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLTUI, model_or1200_l_sfltui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLES, model_or1200_l_sfles, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFLESI, model_or1200_l_sflesi, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLEU, model_or1200_l_sfleu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLEUI, model_or1200_l_sfleui, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFEQ, model_or1200_l_sfeq, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFEQI, model_or1200_l_sfeqi, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFNE, model_or1200_l_sfne, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3479,22 +3479,22 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_EXTWS, model_or1200nd_l_extws, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_EXTWZ, model_or1200nd_l_extwz, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CMOV, model_or1200nd_l_cmov, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGTU, model_or1200nd_l_sfgtu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGEU, model_or1200nd_l_sfgeu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLTU, model_or1200nd_l_sfltu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLEU, model_or1200nd_l_sfleu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFGTS, model_or1200nd_l_sfgts, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGES, model_or1200nd_l_sfges, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLTS, model_or1200nd_l_sflts, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLES, model_or1200nd_l_sfles, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGTUI, model_or1200nd_l_sfgtui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFGEUI, model_or1200nd_l_sfgeui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLTUI, model_or1200nd_l_sfltui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_SFLEUI, model_or1200nd_l_sfleui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFGTSI, model_or1200nd_l_sfgtsi, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGTU, model_or1200nd_l_sfgtu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGTUI, model_or1200nd_l_sfgtui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGES, model_or1200nd_l_sfges, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFGESI, model_or1200nd_l_sfgesi, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGEU, model_or1200nd_l_sfgeu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFGEUI, model_or1200nd_l_sfgeui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLTS, model_or1200nd_l_sflts, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFLTSI, model_or1200nd_l_sfltsi, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLTU, model_or1200nd_l_sfltu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLTUI, model_or1200nd_l_sfltui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLES, model_or1200nd_l_sfles, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFLESI, model_or1200nd_l_sflesi, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLEU, model_or1200nd_l_sfleu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SFLEUI, model_or1200nd_l_sfleui, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFEQ, model_or1200nd_l_sfeq, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFEQI, model_or1200nd_l_sfeqi, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFNE, model_or1200nd_l_sfne, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
diff --git a/sim/or1k/sem32-switch.c b/sim/or1k/sem32-switch.c
index e708fe1..7d3d97f 100644
--- a/sim/or1k/sem32-switch.c
+++ b/sim/or1k/sem32-switch.c
@@ -94,22 +94,22 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_EXTWS, && case_sem_INSN_L_EXTWS },
     { OR1K32BF_INSN_L_EXTWZ, && case_sem_INSN_L_EXTWZ },
     { OR1K32BF_INSN_L_CMOV, && case_sem_INSN_L_CMOV },
-    { OR1K32BF_INSN_L_SFGTU, && case_sem_INSN_L_SFGTU },
-    { OR1K32BF_INSN_L_SFGEU, && case_sem_INSN_L_SFGEU },
-    { OR1K32BF_INSN_L_SFLTU, && case_sem_INSN_L_SFLTU },
-    { OR1K32BF_INSN_L_SFLEU, && case_sem_INSN_L_SFLEU },
     { OR1K32BF_INSN_L_SFGTS, && case_sem_INSN_L_SFGTS },
-    { OR1K32BF_INSN_L_SFGES, && case_sem_INSN_L_SFGES },
-    { OR1K32BF_INSN_L_SFLTS, && case_sem_INSN_L_SFLTS },
-    { OR1K32BF_INSN_L_SFLES, && case_sem_INSN_L_SFLES },
-    { OR1K32BF_INSN_L_SFGTUI, && case_sem_INSN_L_SFGTUI },
-    { OR1K32BF_INSN_L_SFGEUI, && case_sem_INSN_L_SFGEUI },
-    { OR1K32BF_INSN_L_SFLTUI, && case_sem_INSN_L_SFLTUI },
-    { OR1K32BF_INSN_L_SFLEUI, && case_sem_INSN_L_SFLEUI },
     { OR1K32BF_INSN_L_SFGTSI, && case_sem_INSN_L_SFGTSI },
+    { OR1K32BF_INSN_L_SFGTU, && case_sem_INSN_L_SFGTU },
+    { OR1K32BF_INSN_L_SFGTUI, && case_sem_INSN_L_SFGTUI },
+    { OR1K32BF_INSN_L_SFGES, && case_sem_INSN_L_SFGES },
     { OR1K32BF_INSN_L_SFGESI, && case_sem_INSN_L_SFGESI },
+    { OR1K32BF_INSN_L_SFGEU, && case_sem_INSN_L_SFGEU },
+    { OR1K32BF_INSN_L_SFGEUI, && case_sem_INSN_L_SFGEUI },
+    { OR1K32BF_INSN_L_SFLTS, && case_sem_INSN_L_SFLTS },
     { OR1K32BF_INSN_L_SFLTSI, && case_sem_INSN_L_SFLTSI },
+    { OR1K32BF_INSN_L_SFLTU, && case_sem_INSN_L_SFLTU },
+    { OR1K32BF_INSN_L_SFLTUI, && case_sem_INSN_L_SFLTUI },
+    { OR1K32BF_INSN_L_SFLES, && case_sem_INSN_L_SFLES },
     { OR1K32BF_INSN_L_SFLESI, && case_sem_INSN_L_SFLESI },
+    { OR1K32BF_INSN_L_SFLEU, && case_sem_INSN_L_SFLEU },
+    { OR1K32BF_INSN_L_SFLEUI, && case_sem_INSN_L_SFLEUI },
     { OR1K32BF_INSN_L_SFEQ, && case_sem_INSN_L_SFEQ },
     { OR1K32BF_INSN_L_SFEQI, && case_sem_INSN_L_SFEQI },
     { OR1K32BF_INSN_L_SFNE, && case_sem_INSN_L_SFNE },
@@ -596,7 +596,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_SYSCALL);
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k32bf_rfe (current_cpu, pc);
+or1k32bf_rfe (current_cpu);
 
 #undef FLD
 }
@@ -646,22 +646,18 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  USI temp0;USI temp1;USI temp2;
-  temp0 = GET_H_MAC_MACLO ();
-  temp1 = 0;
-  temp2 = 0;
   {
-    USI opval = temp0;
+    USI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
   {
-    USI opval = temp1;
+    USI opval = 0;
     SET_H_MAC_MACLO (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
   {
-    USI opval = temp2;
+    USI opval = 0;
     SET_H_MAC_MACHI (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
@@ -681,7 +677,7 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = or1k32bf_mfspr (current_cpu, pc, FLD (f_r1), ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16))));
+    USI opval = or1k32bf_mfspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
@@ -699,7 +695,7 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k32bf_mtspr (current_cpu, pc, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
+or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
 
 #undef FLD
 }
@@ -1171,12 +1167,12 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1334,7 +1330,7 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    USI opval = DIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = UDIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
@@ -1508,12 +1504,12 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1712,7 +1708,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTU) : /* l.sfgtu $rA,$rB */
+  CASE (sem, INSN_L_SFGTS) : /* l.sfgts $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1722,7 +1718,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1731,17 +1727,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGEU) : /* l.sfgeu $rA,$rB */
+  CASE (sem, INSN_L_SFGTSI) : /* l.sfgtsi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1750,7 +1746,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTU) : /* l.sfltu $rA,$rB */
+  CASE (sem, INSN_L_SFGTU) : /* l.sfgtu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1760,7 +1756,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1769,17 +1765,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLEU) : /* l.sfleu $rA,$rB */
+  CASE (sem, INSN_L_SFGTUI) : /* l.sfgtui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1788,7 +1784,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTS) : /* l.sfgts $rA,$rB */
+  CASE (sem, INSN_L_SFGES) : /* l.sfges $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1798,7 +1794,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1807,17 +1803,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGES) : /* l.sfges $rA,$rB */
+  CASE (sem, INSN_L_SFGESI) : /* l.sfgesi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1826,7 +1822,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTS) : /* l.sflts $rA,$rB */
+  CASE (sem, INSN_L_SFGEU) : /* l.sfgeu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1836,7 +1832,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1845,17 +1841,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLES) : /* l.sfles $rA,$rB */
+  CASE (sem, INSN_L_SFGEUI) : /* l.sfgeui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1864,17 +1860,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTUI) : /* l.sfgtui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTS) : /* l.sflts $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1883,17 +1879,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGEUI) : /* l.sfgeui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTSI) : /* l.sfltsi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1902,17 +1898,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTUI) : /* l.sfltui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTU) : /* l.sfltu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1921,17 +1917,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLEUI) : /* l.sfleui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTUI) : /* l.sfltui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1940,17 +1936,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTSI) : /* l.sfgtsi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLES) : /* l.sfles $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1959,7 +1955,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGESI) : /* l.sfgesi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLESI) : /* l.sflesi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1969,7 +1965,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1978,17 +1974,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTSI) : /* l.sfltsi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLEU) : /* l.sfleu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1997,7 +1993,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLESI) : /* l.sflesi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLEUI) : /* l.sfleui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2007,7 +2003,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -2152,11 +2148,11 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_MACI) : /* l.maci $rA,${simm16-split} */
+  CASE (sem, INSN_L_MACI) : /* l.maci $rA,${simm16} */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
@@ -2164,7 +2160,7 @@ if (GET_H_SYS_SR_F ()) {
 {
   SI tmp_prod;
   DI tmp_result;
-  tmp_prod = MULSI (EXTSISI (FLD (f_simm16_split)), GET_H_GPR (FLD (f_r2)));
+  tmp_prod = MULSI (EXTSISI (FLD (f_simm16)), GET_H_GPR (FLD (f_r2)));
   tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
diff --git a/sim/or1k/sem32.c b/sim/or1k/sem32.c
index 0ea1db3..e8cbcc9 100644
--- a/sim/or1k/sem32.c
+++ b/sim/or1k/sem32.c
@@ -472,7 +472,7 @@ SEM_FN_NAME (or1k32bf,l_rfe) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k32bf_rfe (current_cpu, pc);
+or1k32bf_rfe (current_cpu);
 
   return vpc;
 #undef FLD
@@ -528,22 +528,18 @@ SEM_FN_NAME (or1k32bf,l_macrc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  USI temp0;USI temp1;USI temp2;
-  temp0 = GET_H_MAC_MACLO ();
-  temp1 = 0;
-  temp2 = 0;
   {
-    USI opval = temp0;
+    USI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
   {
-    USI opval = temp1;
+    USI opval = 0;
     SET_H_MAC_MACLO (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
   {
-    USI opval = temp2;
+    USI opval = 0;
     SET_H_MAC_MACHI (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
@@ -565,7 +561,7 @@ SEM_FN_NAME (or1k32bf,l_mfspr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = or1k32bf_mfspr (current_cpu, pc, FLD (f_r1), ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16))));
+    USI opval = or1k32bf_mfspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
@@ -585,7 +581,7 @@ SEM_FN_NAME (or1k32bf,l_mtspr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k32bf_mtspr (current_cpu, pc, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
+or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
 
   return vpc;
 #undef FLD
@@ -1103,12 +1099,12 @@ SEM_FN_NAME (or1k32bf,l_addc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1274,7 +1270,7 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    USI opval = DIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = UDIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
@@ -1462,12 +1458,12 @@ SEM_FN_NAME (or1k32bf,l_addic) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1682,10 +1678,10 @@ if (GET_H_SYS_SR_F ()) {
 #undef FLD
 }
 
-/* l-sfgtu: l.sfgtu $rA,$rB */
+/* l-sfgts: l.sfgts $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1694,7 +1690,7 @@ SEM_FN_NAME (or1k32bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1703,19 +1699,19 @@ SEM_FN_NAME (or1k32bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgeu: l.sfgeu $rA,$rB */
+/* l-sfgtsi: l.sfgtsi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1724,10 +1720,10 @@ SEM_FN_NAME (or1k32bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfltu: l.sfltu $rA,$rB */
+/* l-sfgtu: l.sfgtu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1736,7 +1732,7 @@ SEM_FN_NAME (or1k32bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1745,19 +1741,19 @@ SEM_FN_NAME (or1k32bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfleu: l.sfleu $rA,$rB */
+/* l-sfgtui: l.sfgtui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1766,10 +1762,10 @@ SEM_FN_NAME (or1k32bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgts: l.sfgts $rA,$rB */
+/* l-sfges: l.sfges $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1778,7 +1774,7 @@ SEM_FN_NAME (or1k32bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1787,19 +1783,19 @@ SEM_FN_NAME (or1k32bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfges: l.sfges $rA,$rB */
+/* l-sfgesi: l.sfgesi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1808,10 +1804,10 @@ SEM_FN_NAME (or1k32bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sflts: l.sflts $rA,$rB */
+/* l-sfgeu: l.sfgeu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1820,7 +1816,7 @@ SEM_FN_NAME (or1k32bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1829,19 +1825,19 @@ SEM_FN_NAME (or1k32bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfles: l.sfles $rA,$rB */
+/* l-sfgeui: l.sfgeui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1850,19 +1846,19 @@ SEM_FN_NAME (or1k32bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgtui: l.sfgtui $rA,$uimm16 */
+/* l-sflts: l.sflts $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1871,19 +1867,19 @@ SEM_FN_NAME (or1k32bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgeui: l.sfgeui $rA,$uimm16 */
+/* l-sfltsi: l.sfltsi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1892,19 +1888,19 @@ SEM_FN_NAME (or1k32bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfltui: l.sfltui $rA,$uimm16 */
+/* l-sfltu: l.sfltu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1913,19 +1909,19 @@ SEM_FN_NAME (or1k32bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfleui: l.sfleui $rA,$uimm16 */
+/* l-sfltui: l.sfltui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
+    USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1934,19 +1930,19 @@ SEM_FN_NAME (or1k32bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgtsi: l.sfgtsi $rA,${simm16} */
+/* l-sfles: l.sfles $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1955,10 +1951,10 @@ SEM_FN_NAME (or1k32bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgesi: l.sfgesi $rA,${simm16} */
+/* l-sflesi: l.sflesi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1967,7 +1963,7 @@ SEM_FN_NAME (or1k32bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = GESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1976,19 +1972,19 @@ SEM_FN_NAME (or1k32bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfltsi: l.sfltsi $rA,${simm16} */
+/* l-sfleu: l.sfleu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -1997,10 +1993,10 @@ SEM_FN_NAME (or1k32bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sflesi: l.sflesi $rA,${simm16} */
+/* l-sfleui: l.sfleui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2009,7 +2005,7 @@ SEM_FN_NAME (or1k32bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    USI opval = LESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
+    USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
@@ -2166,12 +2162,12 @@ SEM_FN_NAME (or1k32bf,l_msb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-maci: l.maci $rA,${simm16-split} */
+/* l-maci: l.maci $rA,${simm16} */
 
 static SEM_PC
 SEM_FN_NAME (or1k32bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
@@ -2180,7 +2176,7 @@ SEM_FN_NAME (or1k32bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
   SI tmp_prod;
   DI tmp_result;
-  tmp_prod = MULSI (EXTSISI (FLD (f_simm16_split)), GET_H_GPR (FLD (f_r2)));
+  tmp_prod = MULSI (EXTSISI (FLD (f_simm16)), GET_H_GPR (FLD (f_r2)));
   tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
@@ -2710,22 +2706,22 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_EXTWS, SEM_FN_NAME (or1k32bf,l_extws) },
   { OR1K32BF_INSN_L_EXTWZ, SEM_FN_NAME (or1k32bf,l_extwz) },
   { OR1K32BF_INSN_L_CMOV, SEM_FN_NAME (or1k32bf,l_cmov) },
-  { OR1K32BF_INSN_L_SFGTU, SEM_FN_NAME (or1k32bf,l_sfgtu) },
-  { OR1K32BF_INSN_L_SFGEU, SEM_FN_NAME (or1k32bf,l_sfgeu) },
-  { OR1K32BF_INSN_L_SFLTU, SEM_FN_NAME (or1k32bf,l_sfltu) },
-  { OR1K32BF_INSN_L_SFLEU, SEM_FN_NAME (or1k32bf,l_sfleu) },
   { OR1K32BF_INSN_L_SFGTS, SEM_FN_NAME (or1k32bf,l_sfgts) },
-  { OR1K32BF_INSN_L_SFGES, SEM_FN_NAME (or1k32bf,l_sfges) },
-  { OR1K32BF_INSN_L_SFLTS, SEM_FN_NAME (or1k32bf,l_sflts) },
-  { OR1K32BF_INSN_L_SFLES, SEM_FN_NAME (or1k32bf,l_sfles) },
-  { OR1K32BF_INSN_L_SFGTUI, SEM_FN_NAME (or1k32bf,l_sfgtui) },
-  { OR1K32BF_INSN_L_SFGEUI, SEM_FN_NAME (or1k32bf,l_sfgeui) },
-  { OR1K32BF_INSN_L_SFLTUI, SEM_FN_NAME (or1k32bf,l_sfltui) },
-  { OR1K32BF_INSN_L_SFLEUI, SEM_FN_NAME (or1k32bf,l_sfleui) },
   { OR1K32BF_INSN_L_SFGTSI, SEM_FN_NAME (or1k32bf,l_sfgtsi) },
+  { OR1K32BF_INSN_L_SFGTU, SEM_FN_NAME (or1k32bf,l_sfgtu) },
+  { OR1K32BF_INSN_L_SFGTUI, SEM_FN_NAME (or1k32bf,l_sfgtui) },
+  { OR1K32BF_INSN_L_SFGES, SEM_FN_NAME (or1k32bf,l_sfges) },
   { OR1K32BF_INSN_L_SFGESI, SEM_FN_NAME (or1k32bf,l_sfgesi) },
+  { OR1K32BF_INSN_L_SFGEU, SEM_FN_NAME (or1k32bf,l_sfgeu) },
+  { OR1K32BF_INSN_L_SFGEUI, SEM_FN_NAME (or1k32bf,l_sfgeui) },
+  { OR1K32BF_INSN_L_SFLTS, SEM_FN_NAME (or1k32bf,l_sflts) },
   { OR1K32BF_INSN_L_SFLTSI, SEM_FN_NAME (or1k32bf,l_sfltsi) },
+  { OR1K32BF_INSN_L_SFLTU, SEM_FN_NAME (or1k32bf,l_sfltu) },
+  { OR1K32BF_INSN_L_SFLTUI, SEM_FN_NAME (or1k32bf,l_sfltui) },
+  { OR1K32BF_INSN_L_SFLES, SEM_FN_NAME (or1k32bf,l_sfles) },
   { OR1K32BF_INSN_L_SFLESI, SEM_FN_NAME (or1k32bf,l_sflesi) },
+  { OR1K32BF_INSN_L_SFLEU, SEM_FN_NAME (or1k32bf,l_sfleu) },
+  { OR1K32BF_INSN_L_SFLEUI, SEM_FN_NAME (or1k32bf,l_sfleui) },
   { OR1K32BF_INSN_L_SFEQ, SEM_FN_NAME (or1k32bf,l_sfeq) },
   { OR1K32BF_INSN_L_SFEQI, SEM_FN_NAME (or1k32bf,l_sfeqi) },
   { OR1K32BF_INSN_L_SFNE, SEM_FN_NAME (or1k32bf,l_sfne) },
diff --git a/sim/or1k/sem64-switch.c b/sim/or1k/sem64-switch.c
index 3a60670..9de4e16 100644
--- a/sim/or1k/sem64-switch.c
+++ b/sim/or1k/sem64-switch.c
@@ -94,22 +94,22 @@ This file is part of the GNU simulators.
     { OR1K64BF_INSN_L_EXTWS, && case_sem_INSN_L_EXTWS },
     { OR1K64BF_INSN_L_EXTWZ, && case_sem_INSN_L_EXTWZ },
     { OR1K64BF_INSN_L_CMOV, && case_sem_INSN_L_CMOV },
-    { OR1K64BF_INSN_L_SFGTU, && case_sem_INSN_L_SFGTU },
-    { OR1K64BF_INSN_L_SFGEU, && case_sem_INSN_L_SFGEU },
-    { OR1K64BF_INSN_L_SFLTU, && case_sem_INSN_L_SFLTU },
-    { OR1K64BF_INSN_L_SFLEU, && case_sem_INSN_L_SFLEU },
     { OR1K64BF_INSN_L_SFGTS, && case_sem_INSN_L_SFGTS },
-    { OR1K64BF_INSN_L_SFGES, && case_sem_INSN_L_SFGES },
-    { OR1K64BF_INSN_L_SFLTS, && case_sem_INSN_L_SFLTS },
-    { OR1K64BF_INSN_L_SFLES, && case_sem_INSN_L_SFLES },
-    { OR1K64BF_INSN_L_SFGTUI, && case_sem_INSN_L_SFGTUI },
-    { OR1K64BF_INSN_L_SFGEUI, && case_sem_INSN_L_SFGEUI },
-    { OR1K64BF_INSN_L_SFLTUI, && case_sem_INSN_L_SFLTUI },
-    { OR1K64BF_INSN_L_SFLEUI, && case_sem_INSN_L_SFLEUI },
     { OR1K64BF_INSN_L_SFGTSI, && case_sem_INSN_L_SFGTSI },
+    { OR1K64BF_INSN_L_SFGTU, && case_sem_INSN_L_SFGTU },
+    { OR1K64BF_INSN_L_SFGTUI, && case_sem_INSN_L_SFGTUI },
+    { OR1K64BF_INSN_L_SFGES, && case_sem_INSN_L_SFGES },
     { OR1K64BF_INSN_L_SFGESI, && case_sem_INSN_L_SFGESI },
+    { OR1K64BF_INSN_L_SFGEU, && case_sem_INSN_L_SFGEU },
+    { OR1K64BF_INSN_L_SFGEUI, && case_sem_INSN_L_SFGEUI },
+    { OR1K64BF_INSN_L_SFLTS, && case_sem_INSN_L_SFLTS },
     { OR1K64BF_INSN_L_SFLTSI, && case_sem_INSN_L_SFLTSI },
+    { OR1K64BF_INSN_L_SFLTU, && case_sem_INSN_L_SFLTU },
+    { OR1K64BF_INSN_L_SFLTUI, && case_sem_INSN_L_SFLTUI },
+    { OR1K64BF_INSN_L_SFLES, && case_sem_INSN_L_SFLES },
     { OR1K64BF_INSN_L_SFLESI, && case_sem_INSN_L_SFLESI },
+    { OR1K64BF_INSN_L_SFLEU, && case_sem_INSN_L_SFLEU },
+    { OR1K64BF_INSN_L_SFLEUI, && case_sem_INSN_L_SFLEUI },
     { OR1K64BF_INSN_L_SFEQ, && case_sem_INSN_L_SFEQ },
     { OR1K64BF_INSN_L_SFEQI, && case_sem_INSN_L_SFEQI },
     { OR1K64BF_INSN_L_SFNE, && case_sem_INSN_L_SFNE },
@@ -611,7 +611,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_SYSCALL);
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k64bf_rfe (current_cpu, pc);
+or1k64bf_rfe (current_cpu);
 
 #undef FLD
 }
@@ -661,22 +661,18 @@ or1k64bf_nop (current_cpu, ZEXTSIDI (FLD (f_uimm16)));
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  UDI temp0;UDI temp1;UDI temp2;
-  temp0 = GET_H_MAC_MACLO ();
-  temp1 = 0;
-  temp2 = 0;
   {
-    UDI opval = temp0;
+    UDI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
   {
-    UDI opval = temp1;
+    UDI opval = 0;
     SET_H_MAC_MACLO (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'D', opval);
   }
   {
-    UDI opval = temp2;
+    UDI opval = 0;
     SET_H_MAC_MACHI (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-machi", 'D', opval);
   }
@@ -696,7 +692,7 @@ or1k64bf_nop (current_cpu, ZEXTSIDI (FLD (f_uimm16)));
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = or1k64bf_mfspr (current_cpu, pc, FLD (f_r1), ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16))));
+    UDI opval = or1k64bf_mfspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
@@ -714,7 +710,7 @@ or1k64bf_nop (current_cpu, ZEXTSIDI (FLD (f_uimm16)));
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k64bf_mtspr (current_cpu, pc, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
+or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
 
 #undef FLD
 }
@@ -1186,12 +1182,12 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1349,7 +1345,7 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    UDI opval = DIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = UDIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
@@ -1523,12 +1519,12 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1727,7 +1723,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTU) : /* l.sfgtu $rA,$rB */
+  CASE (sem, INSN_L_SFGTS) : /* l.sfgts $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1737,7 +1733,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1746,17 +1742,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGEU) : /* l.sfgeu $rA,$rB */
+  CASE (sem, INSN_L_SFGTSI) : /* l.sfgtsi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1765,7 +1761,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTU) : /* l.sfltu $rA,$rB */
+  CASE (sem, INSN_L_SFGTU) : /* l.sfgtu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1775,7 +1771,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1784,17 +1780,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLEU) : /* l.sfleu $rA,$rB */
+  CASE (sem, INSN_L_SFGTUI) : /* l.sfgtui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1803,7 +1799,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTS) : /* l.sfgts $rA,$rB */
+  CASE (sem, INSN_L_SFGES) : /* l.sfges $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1813,7 +1809,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1822,17 +1818,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGES) : /* l.sfges $rA,$rB */
+  CASE (sem, INSN_L_SFGESI) : /* l.sfgesi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1841,7 +1837,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTS) : /* l.sflts $rA,$rB */
+  CASE (sem, INSN_L_SFGEU) : /* l.sfgeu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1851,7 +1847,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1860,17 +1856,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLES) : /* l.sfles $rA,$rB */
+  CASE (sem, INSN_L_SFGEUI) : /* l.sfgeui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1879,17 +1875,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTUI) : /* l.sfgtui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTS) : /* l.sflts $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1898,17 +1894,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGEUI) : /* l.sfgeui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTSI) : /* l.sfltsi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1917,17 +1913,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTUI) : /* l.sfltui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTU) : /* l.sfltu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1936,17 +1932,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLEUI) : /* l.sfleui $rA,$uimm16 */
+  CASE (sem, INSN_L_SFLTUI) : /* l.sfltui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1955,17 +1951,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGTSI) : /* l.sfgtsi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLES) : /* l.sfles $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1974,7 +1970,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFGESI) : /* l.sfgesi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLESI) : /* l.sflesi $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1984,7 +1980,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1993,17 +1989,17 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLTSI) : /* l.sfltsi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLEU) : /* l.sfleu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -2012,7 +2008,7 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_SFLESI) : /* l.sflesi $rA,${simm16} */
+  CASE (sem, INSN_L_SFLEUI) : /* l.sfleui $rA,$simm16 */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2022,7 +2018,7 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -2167,11 +2163,11 @@ if (GET_H_SYS_SR_F ()) {
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_MACI) : /* l.maci $rA,${simm16-split} */
+  CASE (sem, INSN_L_MACI) : /* l.maci $rA,${simm16} */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
@@ -2179,7 +2175,7 @@ if (GET_H_SYS_SR_F ()) {
 {
   DI tmp_prod;
   DI tmp_result;
-  tmp_prod = MULDI (EXTSIDI (FLD (f_simm16_split)), GET_H_GPR (FLD (f_r2)));
+  tmp_prod = MULDI (EXTSIDI (FLD (f_simm16)), GET_H_GPR (FLD (f_r2)));
   tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTDIDI (tmp_prod));
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
diff --git a/sim/or1k/sem64.c b/sim/or1k/sem64.c
index 12dd361..08bc8bb 100644
--- a/sim/or1k/sem64.c
+++ b/sim/or1k/sem64.c
@@ -472,7 +472,7 @@ SEM_FN_NAME (or1k64bf,l_rfe) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k64bf_rfe (current_cpu, pc);
+or1k64bf_rfe (current_cpu);
 
   return vpc;
 #undef FLD
@@ -528,22 +528,18 @@ SEM_FN_NAME (or1k64bf,l_macrc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  UDI temp0;UDI temp1;UDI temp2;
-  temp0 = GET_H_MAC_MACLO ();
-  temp1 = 0;
-  temp2 = 0;
   {
-    UDI opval = temp0;
+    UDI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
   {
-    UDI opval = temp1;
+    UDI opval = 0;
     SET_H_MAC_MACLO (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'D', opval);
   }
   {
-    UDI opval = temp2;
+    UDI opval = 0;
     SET_H_MAC_MACHI (opval);
     TRACE_RESULT (current_cpu, abuf, "mac-machi", 'D', opval);
   }
@@ -565,7 +561,7 @@ SEM_FN_NAME (or1k64bf,l_mfspr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = or1k64bf_mfspr (current_cpu, pc, FLD (f_r1), ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16))));
+    UDI opval = or1k64bf_mfspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
@@ -585,7 +581,7 @@ SEM_FN_NAME (or1k64bf,l_mtspr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-or1k64bf_mtspr (current_cpu, pc, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
+or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16_split))), GET_H_GPR (FLD (f_r3)));
 
   return vpc;
 #undef FLD
@@ -1103,12 +1099,12 @@ SEM_FN_NAME (or1k64bf,l_addc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1274,7 +1270,7 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    UDI opval = DIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = UDIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
     TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
@@ -1462,12 +1458,12 @@ SEM_FN_NAME (or1k64bf,l_addic) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   BI tmp_tmp_sys_sr_cy;
   tmp_tmp_sys_sr_cy = GET_H_SYS_SR_CY ();
   {
-    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
-    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), GET_H_SYS_SR_CY ());
+    BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
@@ -1682,10 +1678,10 @@ if (GET_H_SYS_SR_F ()) {
 #undef FLD
 }
 
-/* l-sfgtu: l.sfgtu $rA,$rB */
+/* l-sfgts: l.sfgts $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1694,7 +1690,7 @@ SEM_FN_NAME (or1k64bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1703,19 +1699,19 @@ SEM_FN_NAME (or1k64bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgeu: l.sfgeu $rA,$rB */
+/* l-sfgtsi: l.sfgtsi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1724,10 +1720,10 @@ SEM_FN_NAME (or1k64bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfltu: l.sfltu $rA,$rB */
+/* l-sfgtu: l.sfgtu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1736,7 +1732,7 @@ SEM_FN_NAME (or1k64bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1745,19 +1741,19 @@ SEM_FN_NAME (or1k64bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfleu: l.sfleu $rA,$rB */
+/* l-sfgtui: l.sfgtui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1766,10 +1762,10 @@ SEM_FN_NAME (or1k64bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgts: l.sfgts $rA,$rB */
+/* l-sfges: l.sfges $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1778,7 +1774,7 @@ SEM_FN_NAME (or1k64bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1787,19 +1783,19 @@ SEM_FN_NAME (or1k64bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfges: l.sfges $rA,$rB */
+/* l-sfgesi: l.sfgesi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1808,10 +1804,10 @@ SEM_FN_NAME (or1k64bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sflts: l.sflts $rA,$rB */
+/* l-sfgeu: l.sfgeu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1820,7 +1816,7 @@ SEM_FN_NAME (or1k64bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1829,19 +1825,19 @@ SEM_FN_NAME (or1k64bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfles: l.sfles $rA,$rB */
+/* l-sfgeui: l.sfgeui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
+    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1850,19 +1846,19 @@ SEM_FN_NAME (or1k64bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgtui: l.sfgtui $rA,$uimm16 */
+/* l-sflts: l.sflts $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1871,19 +1867,19 @@ SEM_FN_NAME (or1k64bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgeui: l.sfgeui $rA,$uimm16 */
+/* l-sfltsi: l.sfltsi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1892,19 +1888,19 @@ SEM_FN_NAME (or1k64bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfltui: l.sfltui $rA,$uimm16 */
+/* l-sfltu: l.sfltu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1913,19 +1909,19 @@ SEM_FN_NAME (or1k64bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfleui: l.sfleui $rA,$uimm16 */
+/* l-sfltui: l.sfltui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
+    UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1934,19 +1930,19 @@ SEM_FN_NAME (or1k64bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgtsi: l.sfgtsi $rA,${simm16} */
+/* l-sfles: l.sfles $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1955,10 +1951,10 @@ SEM_FN_NAME (or1k64bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfgesi: l.sfgesi $rA,${simm16} */
+/* l-sflesi: l.sflesi $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1967,7 +1963,7 @@ SEM_FN_NAME (or1k64bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1976,19 +1972,19 @@ SEM_FN_NAME (or1k64bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sfltsi: l.sfltsi $rA,${simm16} */
+/* l-sfleu: l.sfleu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -1997,10 +1993,10 @@ SEM_FN_NAME (or1k64bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-sflesi: l.sflesi $rA,${simm16} */
+/* l-sfleui: l.sfleui $rA,$simm16 */
 
 static SEM_PC
-SEM_FN_NAME (or1k64bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k64bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2009,7 +2005,7 @@ SEM_FN_NAME (or1k64bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
   {
-    UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
+    UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
     TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
@@ -2166,12 +2162,12 @@ SEM_FN_NAME (or1k64bf,l_msb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* l-maci: l.maci $rA,${simm16-split} */
+/* l-maci: l.maci $rA,${simm16} */
 
 static SEM_PC
 SEM_FN_NAME (or1k64bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
@@ -2180,7 +2176,7 @@ SEM_FN_NAME (or1k64bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
   DI tmp_prod;
   DI tmp_result;
-  tmp_prod = MULDI (EXTSIDI (FLD (f_simm16_split)), GET_H_GPR (FLD (f_r2)));
+  tmp_prod = MULDI (EXTSIDI (FLD (f_simm16)), GET_H_GPR (FLD (f_r2)));
   tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTDIDI (tmp_prod));
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
@@ -3021,22 +3017,22 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K64BF_INSN_L_EXTWS, SEM_FN_NAME (or1k64bf,l_extws) },
   { OR1K64BF_INSN_L_EXTWZ, SEM_FN_NAME (or1k64bf,l_extwz) },
   { OR1K64BF_INSN_L_CMOV, SEM_FN_NAME (or1k64bf,l_cmov) },
-  { OR1K64BF_INSN_L_SFGTU, SEM_FN_NAME (or1k64bf,l_sfgtu) },
-  { OR1K64BF_INSN_L_SFGEU, SEM_FN_NAME (or1k64bf,l_sfgeu) },
-  { OR1K64BF_INSN_L_SFLTU, SEM_FN_NAME (or1k64bf,l_sfltu) },
-  { OR1K64BF_INSN_L_SFLEU, SEM_FN_NAME (or1k64bf,l_sfleu) },
   { OR1K64BF_INSN_L_SFGTS, SEM_FN_NAME (or1k64bf,l_sfgts) },
-  { OR1K64BF_INSN_L_SFGES, SEM_FN_NAME (or1k64bf,l_sfges) },
-  { OR1K64BF_INSN_L_SFLTS, SEM_FN_NAME (or1k64bf,l_sflts) },
-  { OR1K64BF_INSN_L_SFLES, SEM_FN_NAME (or1k64bf,l_sfles) },
-  { OR1K64BF_INSN_L_SFGTUI, SEM_FN_NAME (or1k64bf,l_sfgtui) },
-  { OR1K64BF_INSN_L_SFGEUI, SEM_FN_NAME (or1k64bf,l_sfgeui) },
-  { OR1K64BF_INSN_L_SFLTUI, SEM_FN_NAME (or1k64bf,l_sfltui) },
-  { OR1K64BF_INSN_L_SFLEUI, SEM_FN_NAME (or1k64bf,l_sfleui) },
   { OR1K64BF_INSN_L_SFGTSI, SEM_FN_NAME (or1k64bf,l_sfgtsi) },
+  { OR1K64BF_INSN_L_SFGTU, SEM_FN_NAME (or1k64bf,l_sfgtu) },
+  { OR1K64BF_INSN_L_SFGTUI, SEM_FN_NAME (or1k64bf,l_sfgtui) },
+  { OR1K64BF_INSN_L_SFGES, SEM_FN_NAME (or1k64bf,l_sfges) },
   { OR1K64BF_INSN_L_SFGESI, SEM_FN_NAME (or1k64bf,l_sfgesi) },
+  { OR1K64BF_INSN_L_SFGEU, SEM_FN_NAME (or1k64bf,l_sfgeu) },
+  { OR1K64BF_INSN_L_SFGEUI, SEM_FN_NAME (or1k64bf,l_sfgeui) },
+  { OR1K64BF_INSN_L_SFLTS, SEM_FN_NAME (or1k64bf,l_sflts) },
   { OR1K64BF_INSN_L_SFLTSI, SEM_FN_NAME (or1k64bf,l_sfltsi) },
+  { OR1K64BF_INSN_L_SFLTU, SEM_FN_NAME (or1k64bf,l_sfltu) },
+  { OR1K64BF_INSN_L_SFLTUI, SEM_FN_NAME (or1k64bf,l_sfltui) },
+  { OR1K64BF_INSN_L_SFLES, SEM_FN_NAME (or1k64bf,l_sfles) },
   { OR1K64BF_INSN_L_SFLESI, SEM_FN_NAME (or1k64bf,l_sflesi) },
+  { OR1K64BF_INSN_L_SFLEU, SEM_FN_NAME (or1k64bf,l_sfleu) },
+  { OR1K64BF_INSN_L_SFLEUI, SEM_FN_NAME (or1k64bf,l_sfleui) },
   { OR1K64BF_INSN_L_SFEQ, SEM_FN_NAME (or1k64bf,l_sfeq) },
   { OR1K64BF_INSN_L_SFEQI, SEM_FN_NAME (or1k64bf,l_sfeqi) },
   { OR1K64BF_INSN_L_SFNE, SEM_FN_NAME (or1k64bf,l_sfne) },
-- 
2.7.4


