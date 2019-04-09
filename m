From: Stafford Horne <shorne@gmail.com>
Date: Wed, 10 Apr 2019 06:39:22 +0900
Subject: [OpenRISC] [PATCH v2 3/6] sim/or1k: Regenerate sim for orfp64a32
 spec
In-Reply-To: <20190409213925.32699-1-shorne@gmail.com>
References: <20190409213925.32699-1-shorne@gmail.com>
Message-ID: <20190409213925.32699-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

sim/ChangeLog:

	* or1k/cpu.c: Regenerate.
	* or1k/cpu.h: Regenerate.
	* or1k/decode.c: Regenerate.
	* or1k/decode.h: Regenerate.
	* or1k/model.c: Regenerate.
	* or1k/sem-switch.c: Regenerate.
	* or1k/sem.c: Regenerate.
---
 sim/or1k/cpu.c        |  60 +++--
 sim/or1k/cpu.h        | 115 +++++++++-
 sim/or1k/decode.c     | 302 +++++++++++++++++++------
 sim/or1k/decode.h     |  16 +-
 sim/or1k/model.c      | 510 ++++++++++++++++++++++++++++++++++++++++++
 sim/or1k/sem-switch.c | 296 ++++++++++++++++++++++++
 sim/or1k/sem.c        | 326 +++++++++++++++++++++++++++
 7 files changed, 1537 insertions(+), 88 deletions(-)

diff --git a/sim/or1k/cpu.c b/sim/or1k/cpu.c
index f93b51276e..a0ee763813 100644
--- a/sim/or1k/cpu.c
+++ b/sim/or1k/cpu.c
@@ -44,6 +44,38 @@ or1k32bf_h_pc_set (SIM_CPU *current_cpu, USI newval)
   SET_H_PC (newval);
 }
 
+/* Get the value of h-spr.  */
+
+USI
+or1k32bf_h_spr_get (SIM_CPU *current_cpu, UINT regno)
+{
+  return GET_H_SPR (regno);
+}
+
+/* Set a value for h-spr.  */
+
+void
+or1k32bf_h_spr_set (SIM_CPU *current_cpu, UINT regno, USI newval)
+{
+  SET_H_SPR (regno, newval);
+}
+
+/* Get the value of h-gpr.  */
+
+USI
+or1k32bf_h_gpr_get (SIM_CPU *current_cpu, UINT regno)
+{
+  return GET_H_GPR (regno);
+}
+
+/* Set a value for h-gpr.  */
+
+void
+or1k32bf_h_gpr_set (SIM_CPU *current_cpu, UINT regno, USI newval)
+{
+  SET_H_GPR (regno, newval);
+}
+
 /* Get the value of h-fsr.  */
 
 SF
@@ -60,36 +92,36 @@ or1k32bf_h_fsr_set (SIM_CPU *current_cpu, UINT regno, SF newval)
   SET_H_FSR (regno, newval);
 }
 
-/* Get the value of h-spr.  */
+/* Get the value of h-fd32r.  */
 
-USI
-or1k32bf_h_spr_get (SIM_CPU *current_cpu, UINT regno)
+DF
+or1k32bf_h_fd32r_get (SIM_CPU *current_cpu, UINT regno)
 {
-  return GET_H_SPR (regno);
+  return GET_H_FD32R (regno);
 }
 
-/* Set a value for h-spr.  */
+/* Set a value for h-fd32r.  */
 
 void
-or1k32bf_h_spr_set (SIM_CPU *current_cpu, UINT regno, USI newval)
+or1k32bf_h_fd32r_set (SIM_CPU *current_cpu, UINT regno, DF newval)
 {
-  SET_H_SPR (regno, newval);
+  SET_H_FD32R (regno, newval);
 }
 
-/* Get the value of h-gpr.  */
+/* Get the value of h-i64r.  */
 
-USI
-or1k32bf_h_gpr_get (SIM_CPU *current_cpu, UINT regno)
+DI
+or1k32bf_h_i64r_get (SIM_CPU *current_cpu, UINT regno)
 {
-  return GET_H_GPR (regno);
+  return GET_H_I64R (regno);
 }
 
-/* Set a value for h-gpr.  */
+/* Set a value for h-i64r.  */
 
 void
-or1k32bf_h_gpr_set (SIM_CPU *current_cpu, UINT regno, USI newval)
+or1k32bf_h_i64r_set (SIM_CPU *current_cpu, UINT regno, DI newval)
 {
-  SET_H_GPR (regno, newval);
+  SET_H_I64R (regno, newval);
 }
 
 /* Get the value of h-sys-vr.  */
diff --git a/sim/or1k/cpu.h b/sim/or1k/cpu.h
index 199c93bce3..7a16c3f6ec 100644
--- a/sim/or1k/cpu.h
+++ b/sim/or1k/cpu.h
@@ -73,15 +73,31 @@ SET_H_SPR ((((index)) + (ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_GPR0))),
 
 /* Virtual regs.  */
 
+#define GET_H_SPR(index) or1k32bf_h_spr_get_raw (current_cpu, index)
+#define SET_H_SPR(index, x) \
+do { \
+or1k32bf_h_spr_set_raw (current_cpu, (index), (x));\
+;} while (0)
 #define GET_H_FSR(index) SUBWORDSISF (TRUNCSISI (GET_H_GPR (index)))
 #define SET_H_FSR(index, x) \
 do { \
 SET_H_GPR ((index), ZEXTSISI (SUBWORDSFSI ((x))));\
 ;} while (0)
-#define GET_H_SPR(index) or1k32bf_h_spr_get_raw (current_cpu, index)
-#define SET_H_SPR(index, x) \
+#define GET_H_FD32R(index) JOINSIDF (GET_H_GPR (index), GET_H_GPR (((index) + (((((index) > (15))) ? (2) : (1))))))
+#define SET_H_FD32R(index, x) \
 do { \
-or1k32bf_h_spr_set_raw (current_cpu, (index), (x));\
+{\
+SET_H_GPR ((index), SUBWORDDFSI ((x), 0));\
+SET_H_GPR ((((index)) + ((((((index)) > (15))) ? (2) : (1)))), SUBWORDDFSI ((x), 1));\
+}\
+;} while (0)
+#define GET_H_I64R(index) JOINSIDI (GET_H_GPR (index), GET_H_GPR (((index) + (((((index) > (15))) ? (2) : (1))))))
+#define SET_H_I64R(index, x) \
+do { \
+{\
+SET_H_GPR ((index), SUBWORDDISI ((x), 0));\
+SET_H_GPR ((((index)) + ((((((index)) > (15))) ? (2) : (1)))), SUBWORDDISI ((x), 1));\
+}\
 ;} while (0)
 #define GET_H_SYS_VR() GET_H_SPR (ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_VR))
 #define SET_H_SYS_VR(x) \
@@ -3227,12 +3243,16 @@ or1k32bf_h_spr_field_set_raw (current_cpu, ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_
 /* Cover fns for register access.  */
 USI or1k32bf_h_pc_get (SIM_CPU *);
 void or1k32bf_h_pc_set (SIM_CPU *, USI);
-SF or1k32bf_h_fsr_get (SIM_CPU *, UINT);
-void or1k32bf_h_fsr_set (SIM_CPU *, UINT, SF);
 USI or1k32bf_h_spr_get (SIM_CPU *, UINT);
 void or1k32bf_h_spr_set (SIM_CPU *, UINT, USI);
 USI or1k32bf_h_gpr_get (SIM_CPU *, UINT);
 void or1k32bf_h_gpr_set (SIM_CPU *, UINT, USI);
+SF or1k32bf_h_fsr_get (SIM_CPU *, UINT);
+void or1k32bf_h_fsr_set (SIM_CPU *, UINT, SF);
+DF or1k32bf_h_fd32r_get (SIM_CPU *, UINT);
+void or1k32bf_h_fd32r_set (SIM_CPU *, UINT, DF);
+DI or1k32bf_h_i64r_get (SIM_CPU *, UINT);
+void or1k32bf_h_i64r_set (SIM_CPU *, UINT, DI);
 USI or1k32bf_h_sys_vr_get (SIM_CPU *);
 void or1k32bf_h_sys_vr_set (SIM_CPU *, USI);
 USI or1k32bf_h_sys_upr_get (SIM_CPU *);
@@ -4978,6 +4998,23 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_ADD_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  UINT f_r2; \
+  UINT f_r3; \
+  UINT f_resv_10_3; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_ADD_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_ITOF_S_VARS \
   UINT f_opcode; \
   UINT f_r1; \
@@ -4995,6 +5032,23 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_ITOF_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  UINT f_r2; \
+  UINT f_r3; \
+  UINT f_resv_10_3; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_ITOF_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_FTOI_S_VARS \
   UINT f_opcode; \
   UINT f_r1; \
@@ -5012,6 +5066,23 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_FTOI_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  UINT f_r2; \
+  UINT f_r3; \
+  UINT f_resv_10_3; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_FTOI_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_EQ_S_VARS \
   UINT f_opcode; \
   UINT f_r1; \
@@ -5029,6 +5100,23 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_EQ_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  UINT f_r2; \
+  UINT f_r3; \
+  UINT f_resv_10_3; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_EQ_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_CUST1_S_VARS \
   UINT f_opcode; \
   UINT f_resv_25_5; \
@@ -5046,6 +5134,23 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_CUST1_D32_VARS \
+  UINT f_opcode; \
+  UINT f_resv_25_5; \
+  UINT f_r2; \
+  UINT f_r3; \
+  UINT f_resv_10_3; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_CUST1_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_resv_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 /* Collection of various things for the trace handler to use.  */
 
 typedef struct trace_record {
diff --git a/sim/or1k/decode.c b/sim/or1k/decode.c
index 153e00f82f..d619910aa7 100644
--- a/sim/or1k/decode.c
+++ b/sim/or1k/decode.c
@@ -144,20 +144,35 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_CUST7, OR1K32BF_INSN_L_CUST7, OR1K32BF_SFMT_L_MSYNC },
   { OR1K_INSN_L_CUST8, OR1K32BF_INSN_L_CUST8, OR1K32BF_SFMT_L_MSYNC },
   { OR1K_INSN_LF_ADD_S, OR1K32BF_INSN_LF_ADD_S, OR1K32BF_SFMT_LF_ADD_S },
+  { OR1K_INSN_LF_ADD_D32, OR1K32BF_INSN_LF_ADD_D32, OR1K32BF_SFMT_LF_ADD_D32 },
   { OR1K_INSN_LF_SUB_S, OR1K32BF_INSN_LF_SUB_S, OR1K32BF_SFMT_LF_ADD_S },
+  { OR1K_INSN_LF_SUB_D32, OR1K32BF_INSN_LF_SUB_D32, OR1K32BF_SFMT_LF_ADD_D32 },
   { OR1K_INSN_LF_MUL_S, OR1K32BF_INSN_LF_MUL_S, OR1K32BF_SFMT_LF_ADD_S },
+  { OR1K_INSN_LF_MUL_D32, OR1K32BF_INSN_LF_MUL_D32, OR1K32BF_SFMT_LF_ADD_D32 },
   { OR1K_INSN_LF_DIV_S, OR1K32BF_INSN_LF_DIV_S, OR1K32BF_SFMT_LF_ADD_S },
+  { OR1K_INSN_LF_DIV_D32, OR1K32BF_INSN_LF_DIV_D32, OR1K32BF_SFMT_LF_ADD_D32 },
   { OR1K_INSN_LF_REM_S, OR1K32BF_INSN_LF_REM_S, OR1K32BF_SFMT_LF_ADD_S },
+  { OR1K_INSN_LF_REM_D32, OR1K32BF_INSN_LF_REM_D32, OR1K32BF_SFMT_LF_ADD_D32 },
   { OR1K_INSN_LF_ITOF_S, OR1K32BF_INSN_LF_ITOF_S, OR1K32BF_SFMT_LF_ITOF_S },
+  { OR1K_INSN_LF_ITOF_D32, OR1K32BF_INSN_LF_ITOF_D32, OR1K32BF_SFMT_LF_ITOF_D32 },
   { OR1K_INSN_LF_FTOI_S, OR1K32BF_INSN_LF_FTOI_S, OR1K32BF_SFMT_LF_FTOI_S },
+  { OR1K_INSN_LF_FTOI_D32, OR1K32BF_INSN_LF_FTOI_D32, OR1K32BF_SFMT_LF_FTOI_D32 },
   { OR1K_INSN_LF_EQ_S, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_EQ_D32, OR1K32BF_INSN_LF_EQ_D32, OR1K32BF_SFMT_LF_EQ_D32 },
   { OR1K_INSN_LF_NE_S, OR1K32BF_INSN_LF_NE_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_NE_D32, OR1K32BF_INSN_LF_NE_D32, OR1K32BF_SFMT_LF_EQ_D32 },
   { OR1K_INSN_LF_GE_S, OR1K32BF_INSN_LF_GE_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_GE_D32, OR1K32BF_INSN_LF_GE_D32, OR1K32BF_SFMT_LF_EQ_D32 },
   { OR1K_INSN_LF_GT_S, OR1K32BF_INSN_LF_GT_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_GT_D32, OR1K32BF_INSN_LF_GT_D32, OR1K32BF_SFMT_LF_EQ_D32 },
   { OR1K_INSN_LF_LT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_LT_D32, OR1K32BF_INSN_LF_LT_D32, OR1K32BF_SFMT_LF_EQ_D32 },
   { OR1K_INSN_LF_LE_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_LE_D32, OR1K32BF_INSN_LF_LE_D32, OR1K32BF_SFMT_LF_EQ_D32 },
   { OR1K_INSN_LF_MADD_S, OR1K32BF_INSN_LF_MADD_S, OR1K32BF_SFMT_LF_MADD_S },
+  { OR1K_INSN_LF_MADD_D32, OR1K32BF_INSN_LF_MADD_D32, OR1K32BF_SFMT_LF_MADD_D32 },
   { OR1K_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_LF_CUST1_D32, OR1K32BF_INSN_LF_CUST1_D32, OR1K32BF_SFMT_L_MSYNC },
 };
 
 static const struct insn_sem or1k32bf_insn_sem_invalid =
@@ -235,7 +250,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     CGEN_INSN_WORD insn = base_insn;
 
     {
-      unsigned int val = (((insn >> 21) & (63 << 5)) | ((insn >> 2) & (1 << 4)) | ((insn >> 0) & (15 << 0)));
+      unsigned int val = (((insn >> 21) & (63 << 5)) | ((insn >> 0) & (31 << 0)));
       switch (val)
       {
       case 0 : /* fall through */
@@ -1083,22 +1098,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1484 : /* fall through */
       case 1485 : /* fall through */
       case 1486 : /* fall through */
-      case 1487 :
-        {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
-          switch (val)
-          {
-          case 0 :
-            if ((entire_insn & 0xfc00ffc0) == 0xb8000000)
-              { itype = OR1K32BF_INSN_L_SLLI; goto extract_sfmt_l_slli; }
-            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          case 1 :
-            if ((entire_insn & 0xfc00ffc0) == 0xb8000080)
-              { itype = OR1K32BF_INSN_L_SRAI; goto extract_sfmt_l_slli; }
-            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          }
-        }
+      case 1487 : /* fall through */
       case 1488 : /* fall through */
       case 1489 : /* fall through */
       case 1490 : /* fall through */
@@ -1116,14 +1116,22 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1502 : /* fall through */
       case 1503 :
         {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
+          unsigned int val = (((insn >> 6) & (3 << 0)));
           switch (val)
           {
           case 0 :
+            if ((entire_insn & 0xfc00ffc0) == 0xb8000000)
+              { itype = OR1K32BF_INSN_L_SLLI; goto extract_sfmt_l_slli; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
             if ((entire_insn & 0xfc00ffc0) == 0xb8000040)
               { itype = OR1K32BF_INSN_L_SRLI; goto extract_sfmt_l_slli; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          case 1 :
+          case 2 :
+            if ((entire_insn & 0xfc00ffc0) == 0xb8000080)
+              { itype = OR1K32BF_INSN_L_SRAI; goto extract_sfmt_l_slli; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 3 :
             if ((entire_insn & 0xfc00ffc0) == 0xb80000c0)
               { itype = OR1K32BF_INSN_L_RORI; goto extract_sfmt_l_slli; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
@@ -1258,9 +1266,21 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
           { itype = OR1K32BF_INSN_L_MSBU; goto extract_sfmt_l_macu; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1600 :
-        if ((entire_insn & 0xfc0007ff) == 0xc8000000)
-          { itype = OR1K32BF_INSN_LF_ADD_S; goto extract_sfmt_lf_add_s; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 5) & (7 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xfc0007ff) == 0xc8000000)
+              { itype = OR1K32BF_INSN_LF_ADD_S; goto extract_sfmt_lf_add_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 7 :
+            if ((entire_insn & 0xffe007ff) == 0xc80000e0)
+              { itype = OR1K32BF_INSN_LF_CUST1_D32; goto extract_sfmt_l_msync; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1601 :
         if ((entire_insn & 0xfc0007ff) == 0xc8000001)
           { itype = OR1K32BF_INSN_LF_SUB_S; goto extract_sfmt_lf_add_s; }
@@ -1314,8 +1334,72 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
           { itype = OR1K32BF_INSN_LF_LE_S; goto extract_sfmt_lf_eq_s; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1616 :
-        if ((entire_insn & 0xffe007ff) == 0xc80000d0)
-          { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_msync; }
+        {
+          unsigned int val = (((insn >> 6) & (3 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xfc0007ff) == 0xc8000010)
+              { itype = OR1K32BF_INSN_LF_ADD_D32; goto extract_sfmt_lf_add_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 3 :
+            if ((entire_insn & 0xffe007ff) == 0xc80000d0)
+              { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_msync; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1617 :
+        if ((entire_insn & 0xfc0007ff) == 0xc8000011)
+          { itype = OR1K32BF_INSN_LF_SUB_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1618 :
+        if ((entire_insn & 0xfc0007ff) == 0xc8000012)
+          { itype = OR1K32BF_INSN_LF_MUL_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1619 :
+        if ((entire_insn & 0xfc0007ff) == 0xc8000013)
+          { itype = OR1K32BF_INSN_LF_DIV_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1620 :
+        if ((entire_insn & 0xfc00ffff) == 0xc8000014)
+          { itype = OR1K32BF_INSN_LF_ITOF_D32; goto extract_sfmt_lf_itof_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1621 :
+        if ((entire_insn & 0xfc00ffff) == 0xc8000015)
+          { itype = OR1K32BF_INSN_LF_FTOI_D32; goto extract_sfmt_lf_ftoi_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1622 :
+        if ((entire_insn & 0xfc0007ff) == 0xc8000016)
+          { itype = OR1K32BF_INSN_LF_REM_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1623 :
+        if ((entire_insn & 0xfc0007ff) == 0xc8000017)
+          { itype = OR1K32BF_INSN_LF_MADD_D32; goto extract_sfmt_lf_madd_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1624 :
+        if ((entire_insn & 0xffe007ff) == 0xc8000018)
+          { itype = OR1K32BF_INSN_LF_EQ_D32; goto extract_sfmt_lf_eq_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1625 :
+        if ((entire_insn & 0xffe007ff) == 0xc8000019)
+          { itype = OR1K32BF_INSN_LF_NE_D32; goto extract_sfmt_lf_eq_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1626 :
+        if ((entire_insn & 0xffe007ff) == 0xc800001a)
+          { itype = OR1K32BF_INSN_LF_GT_D32; goto extract_sfmt_lf_eq_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1627 :
+        if ((entire_insn & 0xffe007ff) == 0xc800001b)
+          { itype = OR1K32BF_INSN_LF_GE_D32; goto extract_sfmt_lf_eq_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1628 :
+        if ((entire_insn & 0xffe007ff) == 0xc800001c)
+          { itype = OR1K32BF_INSN_LF_LT_D32; goto extract_sfmt_lf_eq_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1629 :
+        if ((entire_insn & 0xffe007ff) == 0xc800001d)
+          { itype = OR1K32BF_INSN_LF_LE_D32; goto extract_sfmt_lf_eq_d32; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1632 : /* fall through */
       case 1633 : /* fall through */
@@ -1479,7 +1563,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1800 :
         {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
+          unsigned int val = (((insn >> 6) & (3 << 0)));
           switch (val)
           {
           case 0 :
@@ -1487,9 +1571,17 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
               { itype = OR1K32BF_INSN_L_SLL; goto extract_sfmt_l_sll; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 1 :
+            if ((entire_insn & 0xfc0007ff) == 0xe0000048)
+              { itype = OR1K32BF_INSN_L_SRL; goto extract_sfmt_l_sll; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 2 :
             if ((entire_insn & 0xfc0007ff) == 0xe0000088)
               { itype = OR1K32BF_INSN_L_SRA; goto extract_sfmt_l_sll; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 3 :
+            if ((entire_insn & 0xfc0007ff) == 0xe00000c8)
+              { itype = OR1K32BF_INSN_L_ROR; goto extract_sfmt_l_sll; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
         }
@@ -1507,7 +1599,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1804 :
         {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
+          unsigned int val = (((insn >> 6) & (3 << 0)));
           switch (val)
           {
           case 0 :
@@ -1515,22 +1607,34 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
               { itype = OR1K32BF_INSN_L_EXTHS; goto extract_sfmt_l_exths; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 1 :
+            if ((entire_insn & 0xfc00ffff) == 0xe000004c)
+              { itype = OR1K32BF_INSN_L_EXTBS; goto extract_sfmt_l_exths; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 2 :
             if ((entire_insn & 0xfc00ffff) == 0xe000008c)
               { itype = OR1K32BF_INSN_L_EXTHZ; goto extract_sfmt_l_exths; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 3 :
+            if ((entire_insn & 0xfc00ffff) == 0xe00000cc)
+              { itype = OR1K32BF_INSN_L_EXTBZ; goto extract_sfmt_l_exths; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
         }
       case 1805 :
         {
-          unsigned int val = (((insn >> 8) & (3 << 0)));
+          unsigned int val = (((insn >> 7) & (3 << 1)) | ((insn >> 6) & (1 << 0)));
           switch (val)
           {
           case 0 :
             if ((entire_insn & 0xfc00ffff) == 0xe000000d)
               { itype = OR1K32BF_INSN_L_EXTWS; goto extract_sfmt_l_exths; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          case 3 :
+          case 1 :
+            if ((entire_insn & 0xfc00ffff) == 0xe000004d)
+              { itype = OR1K32BF_INSN_L_EXTWZ; goto extract_sfmt_l_exths; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 6 :
             if ((entire_insn & 0xffe007ff) == 0xe000030d)
               { itype = OR1K32BF_INSN_L_MULDU; goto extract_sfmt_l_muld; }
             itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
@@ -1557,42 +1661,6 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
           default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
         }
-      case 1816 :
-        {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
-          switch (val)
-          {
-          case 0 :
-            if ((entire_insn & 0xfc0007ff) == 0xe0000048)
-              { itype = OR1K32BF_INSN_L_SRL; goto extract_sfmt_l_sll; }
-            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          case 1 :
-            if ((entire_insn & 0xfc0007ff) == 0xe00000c8)
-              { itype = OR1K32BF_INSN_L_ROR; goto extract_sfmt_l_sll; }
-            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          }
-        }
-      case 1820 :
-        {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
-          switch (val)
-          {
-          case 0 :
-            if ((entire_insn & 0xfc00ffff) == 0xe000004c)
-              { itype = OR1K32BF_INSN_L_EXTBS; goto extract_sfmt_l_exths; }
-            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          case 1 :
-            if ((entire_insn & 0xfc00ffff) == 0xe00000cc)
-              { itype = OR1K32BF_INSN_L_EXTBZ; goto extract_sfmt_l_exths; }
-            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-          }
-        }
-      case 1821 :
-        if ((entire_insn & 0xfc00ffff) == 0xe000004d)
-          { itype = OR1K32BF_INSN_L_EXTWZ; goto extract_sfmt_l_exths; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1824 :
         {
           unsigned int val = (((insn >> 21) & (15 << 0)));
@@ -2682,6 +2750,29 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_add_s", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_add_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_add_d32", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2702,6 +2793,26 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_itof_s", "f_r2 0x%x", 'x', f_r2, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_itof_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+    UINT f_r1;
+    UINT f_r2;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_itof_d32", "f_r2 0x%x", 'x', f_r2, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2722,6 +2833,26 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_ftoi_s", "f_r2 0x%x", 'x', f_r2, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_ftoi_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+    UINT f_r1;
+    UINT f_r2;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_ftoi_d32", "f_r2 0x%x", 'x', f_r2, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2742,6 +2873,26 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r3) = f_r3;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_eq_s", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_eq_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_eq_d32", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2765,6 +2916,29 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_madd_s", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_madd_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_madd_d32", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
diff --git a/sim/or1k/decode.h b/sim/or1k/decode.h
index 8650bdfa0e..76c2c667ac 100644
--- a/sim/or1k/decode.h
+++ b/sim/or1k/decode.h
@@ -60,10 +60,14 @@ typedef enum or1k32bf_insn_type {
  , OR1K32BF_INSN_L_MACU, OR1K32BF_INSN_L_MSB, OR1K32BF_INSN_L_MSBU, OR1K32BF_INSN_L_CUST1
  , OR1K32BF_INSN_L_CUST2, OR1K32BF_INSN_L_CUST3, OR1K32BF_INSN_L_CUST4, OR1K32BF_INSN_L_CUST5
  , OR1K32BF_INSN_L_CUST6, OR1K32BF_INSN_L_CUST7, OR1K32BF_INSN_L_CUST8, OR1K32BF_INSN_LF_ADD_S
- , OR1K32BF_INSN_LF_SUB_S, OR1K32BF_INSN_LF_MUL_S, OR1K32BF_INSN_LF_DIV_S, OR1K32BF_INSN_LF_REM_S
- , OR1K32BF_INSN_LF_ITOF_S, OR1K32BF_INSN_LF_FTOI_S, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_INSN_LF_NE_S
- , OR1K32BF_INSN_LF_GE_S, OR1K32BF_INSN_LF_GT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_INSN_LF_LE_S
- , OR1K32BF_INSN_LF_MADD_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_INSN__MAX
+ , OR1K32BF_INSN_LF_ADD_D32, OR1K32BF_INSN_LF_SUB_S, OR1K32BF_INSN_LF_SUB_D32, OR1K32BF_INSN_LF_MUL_S
+ , OR1K32BF_INSN_LF_MUL_D32, OR1K32BF_INSN_LF_DIV_S, OR1K32BF_INSN_LF_DIV_D32, OR1K32BF_INSN_LF_REM_S
+ , OR1K32BF_INSN_LF_REM_D32, OR1K32BF_INSN_LF_ITOF_S, OR1K32BF_INSN_LF_ITOF_D32, OR1K32BF_INSN_LF_FTOI_S
+ , OR1K32BF_INSN_LF_FTOI_D32, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_INSN_LF_EQ_D32, OR1K32BF_INSN_LF_NE_S
+ , OR1K32BF_INSN_LF_NE_D32, OR1K32BF_INSN_LF_GE_S, OR1K32BF_INSN_LF_GE_D32, OR1K32BF_INSN_LF_GT_S
+ , OR1K32BF_INSN_LF_GT_D32, OR1K32BF_INSN_LF_LT_S, OR1K32BF_INSN_LF_LT_D32, OR1K32BF_INSN_LF_LE_S
+ , OR1K32BF_INSN_LF_LE_D32, OR1K32BF_INSN_LF_MADD_S, OR1K32BF_INSN_LF_MADD_D32, OR1K32BF_INSN_LF_CUST1_S
+ , OR1K32BF_INSN_LF_CUST1_D32, OR1K32BF_INSN__MAX
 } OR1K32BF_INSN_TYPE;
 
 /* Enum declaration for semantic formats in cpu family or1k32bf.  */
@@ -80,7 +84,9 @@ typedef enum or1k32bf_sfmt_type {
  , OR1K32BF_SFMT_L_XORI, OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC, OR1K32BF_SFMT_L_MULI
  , OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV, OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI
  , OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI, OR1K32BF_SFMT_L_MACU, OR1K32BF_SFMT_LF_ADD_S
- , OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S, OR1K32BF_SFMT_LF_MADD_S
+ , OR1K32BF_SFMT_LF_ADD_D32, OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_ITOF_D32, OR1K32BF_SFMT_LF_FTOI_S
+ , OR1K32BF_SFMT_LF_FTOI_D32, OR1K32BF_SFMT_LF_EQ_S, OR1K32BF_SFMT_LF_EQ_D32, OR1K32BF_SFMT_LF_MADD_S
+ , OR1K32BF_SFMT_LF_MADD_D32
 } OR1K32BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/model.c b/sim/or1k/model.c
index 461ba4bb00..44da5b9019 100644
--- a/sim/or1k/model.c
+++ b/sim/or1k/model.c
@@ -1602,6 +1602,22 @@ model_or1200_lf_add_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_add_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1618,6 +1634,22 @@ model_or1200_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_sub_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1634,6 +1666,22 @@ model_or1200_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_mul_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1650,6 +1698,22 @@ model_or1200_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_div_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1666,6 +1730,22 @@ model_or1200_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_rem_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1682,6 +1762,22 @@ model_or1200_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_itof_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1698,6 +1794,22 @@ model_or1200_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_ftoi_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1714,6 +1826,22 @@ model_or1200_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_eq_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1730,6 +1858,22 @@ model_or1200_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_ne_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1746,6 +1890,22 @@ model_or1200_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_ge_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1762,6 +1922,22 @@ model_or1200_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_gt_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1778,6 +1954,22 @@ model_or1200_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_lt_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1794,6 +1986,22 @@ model_or1200_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_le_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1810,6 +2018,22 @@ model_or1200_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_madd_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1826,6 +2050,22 @@ model_or1200_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_cust1_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_empty.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_l_j (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3394,6 +3634,22 @@ model_or1200nd_lf_add_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_add_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3410,6 +3666,22 @@ model_or1200nd_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_sub_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3426,6 +3698,22 @@ model_or1200nd_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_mul_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3442,6 +3730,22 @@ model_or1200nd_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_div_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3458,6 +3762,22 @@ model_or1200nd_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_rem_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3474,6 +3794,22 @@ model_or1200nd_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_itof_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3490,6 +3826,22 @@ model_or1200nd_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_ftoi_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3506,6 +3858,22 @@ model_or1200nd_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_eq_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3522,6 +3890,22 @@ model_or1200nd_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_ne_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3538,6 +3922,22 @@ model_or1200nd_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_ge_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3554,6 +3954,22 @@ model_or1200nd_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_gt_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3570,6 +3986,22 @@ model_or1200nd_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_lt_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3586,6 +4018,22 @@ model_or1200nd_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_le_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3602,6 +4050,22 @@ model_or1200nd_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_madd_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3618,6 +4082,22 @@ model_or1200nd_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_lf_cust1_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_empty.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 /* We assume UNIT_NONE == 0 because the tables don't always terminate
    entries with it.  */
 
@@ -3728,20 +4208,35 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_CUST7, model_or1200_l_cust7, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST8, model_or1200_l_cust8, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_ADD_S, model_or1200_lf_add_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_ADD_D32, model_or1200_lf_add_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_SUB_S, model_or1200_lf_sub_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SUB_D32, model_or1200_lf_sub_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_MUL_S, model_or1200_lf_mul_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_MUL_D32, model_or1200_lf_mul_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_DIV_S, model_or1200_lf_div_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_DIV_D32, model_or1200_lf_div_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_REM_S, model_or1200_lf_rem_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_REM_D32, model_or1200_lf_rem_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_ITOF_S, model_or1200_lf_itof_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_ITOF_D32, model_or1200_lf_itof_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_FTOI_S, model_or1200_lf_ftoi_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_FTOI_D32, model_or1200_lf_ftoi_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_EQ_S, model_or1200_lf_eq_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_EQ_D32, model_or1200_lf_eq_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_NE_S, model_or1200_lf_ne_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_NE_D32, model_or1200_lf_ne_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_GE_S, model_or1200_lf_ge_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_GE_D32, model_or1200_lf_ge_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_GT_S, model_or1200_lf_gt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_GT_D32, model_or1200_lf_gt_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_LT_S, model_or1200_lf_lt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_LT_D32, model_or1200_lf_lt_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_LE_S, model_or1200_lf_le_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_LE_D32, model_or1200_lf_le_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_MADD_S, model_or1200_lf_madd_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_MADD_D32, model_or1200_lf_madd_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_CUST1_S, model_or1200_lf_cust1_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_CUST1_D32, model_or1200_lf_cust1_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
 };
 
 /* Model timing data for `or1200nd'.  */
@@ -3851,20 +4346,35 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_CUST7, model_or1200nd_l_cust7, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST8, model_or1200nd_l_cust8, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_ADD_S, model_or1200nd_lf_add_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_ADD_D32, model_or1200nd_lf_add_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_SUB_S, model_or1200nd_lf_sub_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SUB_D32, model_or1200nd_lf_sub_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_MUL_S, model_or1200nd_lf_mul_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_MUL_D32, model_or1200nd_lf_mul_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_DIV_S, model_or1200nd_lf_div_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_DIV_D32, model_or1200nd_lf_div_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_REM_S, model_or1200nd_lf_rem_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_REM_D32, model_or1200nd_lf_rem_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_ITOF_S, model_or1200nd_lf_itof_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_ITOF_D32, model_or1200nd_lf_itof_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_FTOI_S, model_or1200nd_lf_ftoi_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_FTOI_D32, model_or1200nd_lf_ftoi_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_EQ_S, model_or1200nd_lf_eq_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_EQ_D32, model_or1200nd_lf_eq_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_NE_S, model_or1200nd_lf_ne_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_NE_D32, model_or1200nd_lf_ne_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_GE_S, model_or1200nd_lf_ge_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_GE_D32, model_or1200nd_lf_ge_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_GT_S, model_or1200nd_lf_gt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_GT_D32, model_or1200nd_lf_gt_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_LT_S, model_or1200nd_lf_lt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_LT_D32, model_or1200nd_lf_lt_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_LE_S, model_or1200nd_lf_le_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_LE_D32, model_or1200nd_lf_le_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_MADD_S, model_or1200nd_lf_madd_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_MADD_D32, model_or1200nd_lf_madd_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_CUST1_S, model_or1200nd_lf_cust1_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_CUST1_D32, model_or1200nd_lf_cust1_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
 };
 
 #endif /* WITH_PROFILE_MODEL_P */
diff --git a/sim/or1k/sem-switch.c b/sim/or1k/sem-switch.c
index e250e45c60..203f619253 100644
--- a/sim/or1k/sem-switch.c
+++ b/sim/or1k/sem-switch.c
@@ -136,20 +136,35 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_CUST7, && case_sem_INSN_L_CUST7 },
     { OR1K32BF_INSN_L_CUST8, && case_sem_INSN_L_CUST8 },
     { OR1K32BF_INSN_LF_ADD_S, && case_sem_INSN_LF_ADD_S },
+    { OR1K32BF_INSN_LF_ADD_D32, && case_sem_INSN_LF_ADD_D32 },
     { OR1K32BF_INSN_LF_SUB_S, && case_sem_INSN_LF_SUB_S },
+    { OR1K32BF_INSN_LF_SUB_D32, && case_sem_INSN_LF_SUB_D32 },
     { OR1K32BF_INSN_LF_MUL_S, && case_sem_INSN_LF_MUL_S },
+    { OR1K32BF_INSN_LF_MUL_D32, && case_sem_INSN_LF_MUL_D32 },
     { OR1K32BF_INSN_LF_DIV_S, && case_sem_INSN_LF_DIV_S },
+    { OR1K32BF_INSN_LF_DIV_D32, && case_sem_INSN_LF_DIV_D32 },
     { OR1K32BF_INSN_LF_REM_S, && case_sem_INSN_LF_REM_S },
+    { OR1K32BF_INSN_LF_REM_D32, && case_sem_INSN_LF_REM_D32 },
     { OR1K32BF_INSN_LF_ITOF_S, && case_sem_INSN_LF_ITOF_S },
+    { OR1K32BF_INSN_LF_ITOF_D32, && case_sem_INSN_LF_ITOF_D32 },
     { OR1K32BF_INSN_LF_FTOI_S, && case_sem_INSN_LF_FTOI_S },
+    { OR1K32BF_INSN_LF_FTOI_D32, && case_sem_INSN_LF_FTOI_D32 },
     { OR1K32BF_INSN_LF_EQ_S, && case_sem_INSN_LF_EQ_S },
+    { OR1K32BF_INSN_LF_EQ_D32, && case_sem_INSN_LF_EQ_D32 },
     { OR1K32BF_INSN_LF_NE_S, && case_sem_INSN_LF_NE_S },
+    { OR1K32BF_INSN_LF_NE_D32, && case_sem_INSN_LF_NE_D32 },
     { OR1K32BF_INSN_LF_GE_S, && case_sem_INSN_LF_GE_S },
+    { OR1K32BF_INSN_LF_GE_D32, && case_sem_INSN_LF_GE_D32 },
     { OR1K32BF_INSN_LF_GT_S, && case_sem_INSN_LF_GT_S },
+    { OR1K32BF_INSN_LF_GT_D32, && case_sem_INSN_LF_GT_D32 },
     { OR1K32BF_INSN_LF_LT_S, && case_sem_INSN_LF_LT_S },
+    { OR1K32BF_INSN_LF_LT_D32, && case_sem_INSN_LF_LT_D32 },
     { OR1K32BF_INSN_LF_LE_S, && case_sem_INSN_LF_LE_S },
+    { OR1K32BF_INSN_LF_LE_D32, && case_sem_INSN_LF_LE_D32 },
     { OR1K32BF_INSN_LF_MADD_S, && case_sem_INSN_LF_MADD_S },
+    { OR1K32BF_INSN_LF_MADD_D32, && case_sem_INSN_LF_MADD_D32 },
     { OR1K32BF_INSN_LF_CUST1_S, && case_sem_INSN_LF_CUST1_S },
+    { OR1K32BF_INSN_LF_CUST1_D32, && case_sem_INSN_LF_CUST1_D32 },
     { 0, 0 }
   };
   int i;
@@ -2646,6 +2661,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_ADD_D32) : /* lf.add.d $rDD32F,$rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2665,6 +2699,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SUB_D32) : /* lf.sub.d $rDD32F,$rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->subdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2684,6 +2737,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_MUL_D32) : /* lf.mul.d $rDD32F,$rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2703,6 +2775,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_DIV_D32) : /* lf.div.d $rDD32F,$rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->divdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2722,6 +2813,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_REM_D32) : /* lf.rem.d $rDD32F,$rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->remdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2741,6 +2851,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_ITOF_D32) : /* lf.itof.d $rDD32F,$rADI */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->floatdidf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_I64R (FLD (f_r2)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2760,6 +2889,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_FTOI_D32) : /* lf.ftoi.d $rDDI,$rAD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DI opval = CGEN_CPU_FPU (current_cpu)->ops->fixdfdi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FD32R (FLD (f_r2)));
+    SET_H_I64R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "i64r", 'D', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2779,6 +2927,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_EQ_D32) : /* lf.sfeq.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2798,6 +2965,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_NE_D32) : /* lf.sfne.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2817,6 +3003,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_GE_D32) : /* lf.sfge.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2836,6 +3041,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_GT_D32) : /* lf.sfgt.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2855,6 +3079,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_LT_D32) : /* lf.sflt.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2874,6 +3117,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_LE_D32) : /* lf.sfle.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2893,6 +3155,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_MADD_D32) : /* lf.madd.d $rDD32F,$rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3))), GET_H_FD32R (FLD (f_r1)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2908,6 +3189,21 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 
 ((void) 0); /*nop*/
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_CUST1_D32) : /* lf.cust1.d */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_empty.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+((void) 0); /*nop*/
+
 #undef FLD
 }
   NEXT (vpc);
diff --git a/sim/or1k/sem.c b/sim/or1k/sem.c
index 15ef24c079..7cfa998dbd 100644
--- a/sim/or1k/sem.c
+++ b/sim/or1k/sem.c
@@ -2694,6 +2694,27 @@ SEM_FN_NAME (or1k32bf,lf_add_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-add-d32: lf.add.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_add_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-sub-s: lf.sub.s $rDSF,$rASF,$rBSF */
 
 static SEM_PC
@@ -2715,6 +2736,27 @@ SEM_FN_NAME (or1k32bf,lf_sub_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-sub-d32: lf.sub.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sub_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->subdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-mul-s: lf.mul.s $rDSF,$rASF,$rBSF */
 
 static SEM_PC
@@ -2736,6 +2778,27 @@ SEM_FN_NAME (or1k32bf,lf_mul_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-mul-d32: lf.mul.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_mul_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-div-s: lf.div.s $rDSF,$rASF,$rBSF */
 
 static SEM_PC
@@ -2757,6 +2820,27 @@ SEM_FN_NAME (or1k32bf,lf_div_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-div-d32: lf.div.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_div_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->divdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-rem-s: lf.rem.s $rDSF,$rASF,$rBSF */
 
 static SEM_PC
@@ -2778,6 +2862,27 @@ SEM_FN_NAME (or1k32bf,lf_rem_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-rem-d32: lf.rem.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_rem_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->remdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-itof-s: lf.itof.s $rDSF,$rA */
 
 static SEM_PC
@@ -2799,6 +2904,27 @@ SEM_FN_NAME (or1k32bf,lf_itof_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-itof-d32: lf.itof.d $rDD32F,$rADI */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_itof_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->floatdidf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_I64R (FLD (f_r2)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-ftoi-s: lf.ftoi.s $rD,$rASF */
 
 static SEM_PC
@@ -2820,6 +2946,27 @@ SEM_FN_NAME (or1k32bf,lf_ftoi_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-ftoi-d32: lf.ftoi.d $rDDI,$rAD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_ftoi_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_slli.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DI opval = CGEN_CPU_FPU (current_cpu)->ops->fixdfdi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FD32R (FLD (f_r2)));
+    SET_H_I64R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "i64r", 'D', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-eq-s: lf.sfeq.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2841,6 +2988,27 @@ SEM_FN_NAME (or1k32bf,lf_eq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-eq-d32: lf.sfeq.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_eq_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-ne-s: lf.sfne.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2862,6 +3030,27 @@ SEM_FN_NAME (or1k32bf,lf_ne_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-ne-d32: lf.sfne.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_ne_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-ge-s: lf.sfge.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2883,6 +3072,27 @@ SEM_FN_NAME (or1k32bf,lf_ge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-ge-d32: lf.sfge.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_ge_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-gt-s: lf.sfgt.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2904,6 +3114,27 @@ SEM_FN_NAME (or1k32bf,lf_gt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-gt-d32: lf.sfgt.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_gt_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-lt-s: lf.sflt.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2925,6 +3156,27 @@ SEM_FN_NAME (or1k32bf,lf_lt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-lt-d32: lf.sflt.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_lt_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-le-s: lf.sfle.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2946,6 +3198,27 @@ SEM_FN_NAME (or1k32bf,lf_le_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-le-d32: lf.sfle.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_le_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-madd-s: lf.madd.s $rDSF,$rASF,$rBSF */
 
 static SEM_PC
@@ -2967,6 +3240,27 @@ SEM_FN_NAME (or1k32bf,lf_madd_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-madd-d32: lf.madd.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_madd_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_r2)), GET_H_FD32R (FLD (f_r3))), GET_H_FD32R (FLD (f_r1)));
+    SET_H_FD32R (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-cust1-s: lf.cust1.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2984,6 +3278,23 @@ SEM_FN_NAME (or1k32bf,lf_cust1_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-cust1-d32: lf.cust1.d */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_cust1_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_empty.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+((void) 0); /*nop*/
+
+  return vpc;
+#undef FLD
+}
+
 /* Table of all semantic fns.  */
 
 static const struct sem_fn_desc sem_fns[] = {
@@ -3091,20 +3402,35 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_CUST7, SEM_FN_NAME (or1k32bf,l_cust7) },
   { OR1K32BF_INSN_L_CUST8, SEM_FN_NAME (or1k32bf,l_cust8) },
   { OR1K32BF_INSN_LF_ADD_S, SEM_FN_NAME (or1k32bf,lf_add_s) },
+  { OR1K32BF_INSN_LF_ADD_D32, SEM_FN_NAME (or1k32bf,lf_add_d32) },
   { OR1K32BF_INSN_LF_SUB_S, SEM_FN_NAME (or1k32bf,lf_sub_s) },
+  { OR1K32BF_INSN_LF_SUB_D32, SEM_FN_NAME (or1k32bf,lf_sub_d32) },
   { OR1K32BF_INSN_LF_MUL_S, SEM_FN_NAME (or1k32bf,lf_mul_s) },
+  { OR1K32BF_INSN_LF_MUL_D32, SEM_FN_NAME (or1k32bf,lf_mul_d32) },
   { OR1K32BF_INSN_LF_DIV_S, SEM_FN_NAME (or1k32bf,lf_div_s) },
+  { OR1K32BF_INSN_LF_DIV_D32, SEM_FN_NAME (or1k32bf,lf_div_d32) },
   { OR1K32BF_INSN_LF_REM_S, SEM_FN_NAME (or1k32bf,lf_rem_s) },
+  { OR1K32BF_INSN_LF_REM_D32, SEM_FN_NAME (or1k32bf,lf_rem_d32) },
   { OR1K32BF_INSN_LF_ITOF_S, SEM_FN_NAME (or1k32bf,lf_itof_s) },
+  { OR1K32BF_INSN_LF_ITOF_D32, SEM_FN_NAME (or1k32bf,lf_itof_d32) },
   { OR1K32BF_INSN_LF_FTOI_S, SEM_FN_NAME (or1k32bf,lf_ftoi_s) },
+  { OR1K32BF_INSN_LF_FTOI_D32, SEM_FN_NAME (or1k32bf,lf_ftoi_d32) },
   { OR1K32BF_INSN_LF_EQ_S, SEM_FN_NAME (or1k32bf,lf_eq_s) },
+  { OR1K32BF_INSN_LF_EQ_D32, SEM_FN_NAME (or1k32bf,lf_eq_d32) },
   { OR1K32BF_INSN_LF_NE_S, SEM_FN_NAME (or1k32bf,lf_ne_s) },
+  { OR1K32BF_INSN_LF_NE_D32, SEM_FN_NAME (or1k32bf,lf_ne_d32) },
   { OR1K32BF_INSN_LF_GE_S, SEM_FN_NAME (or1k32bf,lf_ge_s) },
+  { OR1K32BF_INSN_LF_GE_D32, SEM_FN_NAME (or1k32bf,lf_ge_d32) },
   { OR1K32BF_INSN_LF_GT_S, SEM_FN_NAME (or1k32bf,lf_gt_s) },
+  { OR1K32BF_INSN_LF_GT_D32, SEM_FN_NAME (or1k32bf,lf_gt_d32) },
   { OR1K32BF_INSN_LF_LT_S, SEM_FN_NAME (or1k32bf,lf_lt_s) },
+  { OR1K32BF_INSN_LF_LT_D32, SEM_FN_NAME (or1k32bf,lf_lt_d32) },
   { OR1K32BF_INSN_LF_LE_S, SEM_FN_NAME (or1k32bf,lf_le_s) },
+  { OR1K32BF_INSN_LF_LE_D32, SEM_FN_NAME (or1k32bf,lf_le_d32) },
   { OR1K32BF_INSN_LF_MADD_S, SEM_FN_NAME (or1k32bf,lf_madd_s) },
+  { OR1K32BF_INSN_LF_MADD_D32, SEM_FN_NAME (or1k32bf,lf_madd_d32) },
   { OR1K32BF_INSN_LF_CUST1_S, SEM_FN_NAME (or1k32bf,lf_cust1_s) },
+  { OR1K32BF_INSN_LF_CUST1_D32, SEM_FN_NAME (or1k32bf,lf_cust1_d32) },
   { 0, 0 }
 };
 
-- 
2.19.1

