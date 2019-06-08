From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:22 +0900
Subject: [OpenRISC] [PATCH v3 06/11] sim/or1k: Regenerate sim
In-Reply-To: <20190608213225.3230-1-shorne@gmail.com>
References: <20190608213225.3230-1-shorne@gmail.com>
Message-ID: <20190608213225.3230-7-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This picks up changes for:

 - new orfpx64a32 spec
 - new unordered instructions
 - documentation and symbol updates

sim/ChangeLog:

	* or1k/cpu.c: Regenerate.
	* or1k/cpu.h: Regenerate.
	* or1k/decode.c: Regenerate.
	* or1k/decode.h: Regenerate.
	* or1k/model.c: Regenerate.
	* or1k/sem-switch.c: Regenerate.
	* or1k/sem.c: Regenerate.
---
Changes since v2:
 - Now regenerating for new unordered instructions and documentation.

 sim/or1k/arch.c       |    2 +-
 sim/or1k/arch.h       |    2 +-
 sim/or1k/cpu.c        |   78 ++-
 sim/or1k/cpu.h        |  174 ++++-
 sim/or1k/cpuall.h     |    2 +-
 sim/or1k/decode.c     |  568 +++++++++++++---
 sim/or1k/decode.h     |   21 +-
 sim/or1k/model.c      | 1456 ++++++++++++++++++++++++++++++++++-------
 sim/or1k/sem-switch.c |  602 ++++++++++++++++-
 sim/or1k/sem.c        |  672 ++++++++++++++++++-
 10 files changed, 3188 insertions(+), 389 deletions(-)

diff --git a/sim/or1k/arch.c b/sim/or1k/arch.c
index 8ff891d96d..ad317d6a90 100644
--- a/sim/or1k/arch.c
+++ b/sim/or1k/arch.c
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
diff --git a/sim/or1k/arch.h b/sim/or1k/arch.h
index 66a41b9c62..1e8f90a561 100644
--- a/sim/or1k/arch.h
+++ b/sim/or1k/arch.h
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
diff --git a/sim/or1k/cpu.c b/sim/or1k/cpu.c
index f93b51276e..a668ac4811 100644
--- a/sim/or1k/cpu.c
+++ b/sim/or1k/cpu.c
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
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
@@ -10172,6 +10204,22 @@ or1k32bf_h_atomic_address_set (SIM_CPU *current_cpu, SI newval)
   CPU (h_atomic_address) = newval;
 }
 
+/* Get the value of h-roff1.  */
+
+BI
+or1k32bf_h_roff1_get (SIM_CPU *current_cpu)
+{
+  return CPU (h_roff1);
+}
+
+/* Set a value for h-roff1.  */
+
+void
+or1k32bf_h_roff1_set (SIM_CPU *current_cpu, BI newval)
+{
+  CPU (h_roff1) = newval;
+}
+
 /* Record trace results for INSN.  */
 
 void
diff --git a/sim/or1k/cpu.h b/sim/or1k/cpu.h
index 199c93bce3..730392f411 100644
--- a/sim/or1k/cpu.h
+++ b/sim/or1k/cpu.h
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
@@ -67,21 +67,41 @@ SET_H_SPR ((((index)) + (ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_GPR0))),
   SI h_atomic_address;
 #define GET_H_ATOMIC_ADDRESS() CPU (h_atomic_address)
 #define SET_H_ATOMIC_ADDRESS(x) (CPU (h_atomic_address) = (x))
+  /* 1-bit offset flag */
+  BI h_roff1;
+#define GET_H_ROFF1() CPU (h_roff1)
+#define SET_H_ROFF1(x) (CPU (h_roff1) = (x))
   } hardware;
 #define CPU_CGEN_HW(cpu) (& (cpu)->cpu_data.hardware)
 } OR1K32BF_CPU_DATA;
 
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
+#define GET_H_FD32R(index) JOINSIDF (GET_H_GPR (((index) & (31))), GET_H_GPR (((((index) & (31))) + (((((((INT) (index) >> (5))) == (1))) ? (2) : (1))))))
+#define SET_H_FD32R(index, x) \
 do { \
-or1k32bf_h_spr_set_raw (current_cpu, (index), (x));\
+{\
+SET_H_GPR ((((index)) & (31)), SUBWORDDFSI ((x), 0));\
+SET_H_GPR ((((((index)) & (31))) + (((((((INT) ((index)) >> (5))) == (1))) ? (2) : (1)))), SUBWORDDFSI ((x), 1));\
+}\
+;} while (0)
+#define GET_H_I64R(index) JOINSIDI (GET_H_GPR (((index) & (31))), GET_H_GPR (((((index) & (31))) + (((((((INT) (index) >> (5))) == (1))) ? (2) : (1))))))
+#define SET_H_I64R(index, x) \
+do { \
+{\
+SET_H_GPR ((((index)) & (31)), SUBWORDDISI ((x), 0));\
+SET_H_GPR ((((((index)) & (31))) + (((((((INT) ((index)) >> (5))) == (1))) ? (2) : (1)))), SUBWORDDISI ((x), 1));\
+}\
 ;} while (0)
 #define GET_H_SYS_VR() GET_H_SPR (ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_VR))
 #define SET_H_SYS_VR(x) \
@@ -3227,12 +3247,16 @@ or1k32bf_h_spr_field_set_raw (current_cpu, ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_
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
@@ -4493,6 +4517,8 @@ BI or1k32bf_h_atomic_reserve_get (SIM_CPU *);
 void or1k32bf_h_atomic_reserve_set (SIM_CPU *, BI);
 SI or1k32bf_h_atomic_address_get (SIM_CPU *);
 void or1k32bf_h_atomic_address_set (SIM_CPU *, SI);
+BI or1k32bf_h_roff1_get (SIM_CPU *);
+void or1k32bf_h_roff1_set (SIM_CPU *, BI);
 
 /* These must be hand-written.  */
 extern CPUREG_FETCH_FN or1k32bf_fetch_register;
@@ -4519,6 +4545,11 @@ union sem_fields {
     IADDR i_disp21;
     UINT f_r1;
   } sfmt_l_adrp;
+  struct { /*  */
+    SI f_rad32;
+    SI f_rbd32;
+    SI f_rdd32;
+  } sfmt_lf_add_d32;
   struct { /*  */
     UINT f_r1;
     UINT f_r2;
@@ -4978,6 +5009,33 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_ADD_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  UINT f_rdoff_10_1; \
+  SI f_rdd32; \
+  UINT f_r2; \
+  UINT f_raoff_9_1; \
+  SI f_rad32; \
+  UINT f_r3; \
+  UINT f_rboff_8_1; \
+  SI f_rbd32; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_ADD_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1); \
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));\
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1); \
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));\
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_rboff_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1); \
+  f_rbd32 = ((f_r3) | (((f_rboff_8_1) << (5))));\
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_ITOF_S_VARS \
   UINT f_opcode; \
   UINT f_r1; \
@@ -4995,6 +5053,31 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_ITOF_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r3; \
+  UINT f_r1; \
+  UINT f_rdoff_10_1; \
+  SI f_rdd32; \
+  UINT f_r2; \
+  UINT f_raoff_9_1; \
+  SI f_rad32; \
+  UINT f_resv_8_1; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_ITOF_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1); \
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));\
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1); \
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));\
+  f_resv_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_FTOI_S_VARS \
   UINT f_opcode; \
   UINT f_r1; \
@@ -5012,7 +5095,32 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
-#define EXTRACT_IFMT_LF_EQ_S_VARS \
+#define EXTRACT_IFMT_LF_FTOI_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r3; \
+  UINT f_r1; \
+  UINT f_rdoff_10_1; \
+  SI f_rdd32; \
+  UINT f_r2; \
+  UINT f_raoff_9_1; \
+  SI f_rad32; \
+  UINT f_resv_8_1; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_FTOI_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1); \
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));\
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1); \
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));\
+  f_resv_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1); \
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
+#define EXTRACT_IFMT_LF_SFEQ_S_VARS \
   UINT f_opcode; \
   UINT f_r1; \
   UINT f_r2; \
@@ -5020,7 +5128,7 @@ struct scache {
   UINT f_resv_10_3; \
   UINT f_op_7_8; \
   unsigned int length;
-#define EXTRACT_IFMT_LF_EQ_S_CODE \
+#define EXTRACT_IFMT_LF_SFEQ_S_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
   f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
@@ -5029,6 +5137,31 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_SFEQ_D32_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  UINT f_resv_10_1; \
+  UINT f_r2; \
+  UINT f_raoff_9_1; \
+  SI f_rad32; \
+  UINT f_r3; \
+  UINT f_rboff_8_1; \
+  SI f_rbd32; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_SFEQ_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_resv_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1); \
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));\
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_rboff_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1); \
+  f_rbd32 = ((f_r3) | (((f_rboff_8_1) << (5))));\
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 #define EXTRACT_IFMT_LF_CUST1_S_VARS \
   UINT f_opcode; \
   UINT f_resv_25_5; \
@@ -5046,6 +5179,31 @@ struct scache {
   f_resv_10_3 = EXTRACT_LSB0_UINT (insn, 32, 10, 3); \
   f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
 
+#define EXTRACT_IFMT_LF_CUST1_D32_VARS \
+  UINT f_opcode; \
+  UINT f_resv_25_5; \
+  UINT f_resv_10_1; \
+  UINT f_r2; \
+  UINT f_raoff_9_1; \
+  SI f_rad32; \
+  UINT f_r3; \
+  UINT f_rboff_8_1; \
+  SI f_rbd32; \
+  UINT f_op_7_8; \
+  unsigned int length;
+#define EXTRACT_IFMT_LF_CUST1_D32_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_resv_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_resv_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1); \
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));\
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_rboff_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1); \
+  f_rbd32 = ((f_r3) | (((f_rboff_8_1) << (5))));\
+  f_op_7_8 = EXTRACT_LSB0_UINT (insn, 32, 7, 8); \
+
 /* Collection of various things for the trace handler to use.  */
 
 typedef struct trace_record {
diff --git a/sim/or1k/cpuall.h b/sim/or1k/cpuall.h
index 8fc8eef61a..a6371ccb3f 100644
--- a/sim/or1k/cpuall.h
+++ b/sim/or1k/cpuall.h
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
diff --git a/sim/or1k/decode.c b/sim/or1k/decode.c
index 153e00f82f..779594b6cf 100644
--- a/sim/or1k/decode.c
+++ b/sim/or1k/decode.c
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
@@ -144,20 +144,49 @@ static const struct insn_sem or1k32bf_insn_sem[] =
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
-  { OR1K_INSN_LF_EQ_S, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_SFMT_LF_EQ_S },
-  { OR1K_INSN_LF_NE_S, OR1K32BF_INSN_LF_NE_S, OR1K32BF_SFMT_LF_EQ_S },
-  { OR1K_INSN_LF_GE_S, OR1K32BF_INSN_LF_GE_S, OR1K32BF_SFMT_LF_EQ_S },
-  { OR1K_INSN_LF_GT_S, OR1K32BF_INSN_LF_GT_S, OR1K32BF_SFMT_LF_EQ_S },
-  { OR1K_INSN_LF_LT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_SFMT_LF_EQ_S },
-  { OR1K_INSN_LF_LE_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_SFMT_LF_EQ_S },
+  { OR1K_INSN_LF_FTOI_D32, OR1K32BF_INSN_LF_FTOI_D32, OR1K32BF_SFMT_LF_FTOI_D32 },
+  { OR1K_INSN_LF_SFEQ_S, OR1K32BF_INSN_LF_SFEQ_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFEQ_D32, OR1K32BF_INSN_LF_SFEQ_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFNE_S, OR1K32BF_INSN_LF_SFNE_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFNE_D32, OR1K32BF_INSN_LF_SFNE_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFGE_S, OR1K32BF_INSN_LF_SFGE_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFGE_D32, OR1K32BF_INSN_LF_SFGE_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFGT_S, OR1K32BF_INSN_LF_SFGT_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFGT_D32, OR1K32BF_INSN_LF_SFGT_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFLT_S, OR1K32BF_INSN_LF_SFLT_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFLT_D32, OR1K32BF_INSN_LF_SFLT_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFLE_S, OR1K32BF_INSN_LF_SFLE_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFLE_D32, OR1K32BF_INSN_LF_SFLE_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFUEQ_S, OR1K32BF_INSN_LF_SFUEQ_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFUEQ_D32, OR1K32BF_INSN_LF_SFUEQ_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFUNE_S, OR1K32BF_INSN_LF_SFUNE_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFUNE_D32, OR1K32BF_INSN_LF_SFUNE_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFUGT_S, OR1K32BF_INSN_LF_SFUGT_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFUGT_D32, OR1K32BF_INSN_LF_SFUGT_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFUGE_S, OR1K32BF_INSN_LF_SFUGE_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFUGE_D32, OR1K32BF_INSN_LF_SFUGE_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFULT_S, OR1K32BF_INSN_LF_SFULT_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFULT_D32, OR1K32BF_INSN_LF_SFULT_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFULE_S, OR1K32BF_INSN_LF_SFULE_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFULE_D32, OR1K32BF_INSN_LF_SFULE_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
+  { OR1K_INSN_LF_SFUN_S, OR1K32BF_INSN_LF_SFUN_S, OR1K32BF_SFMT_LF_SFEQ_S },
+  { OR1K_INSN_LF_SFUN_D32, OR1K32BF_INSN_LF_SFUN_D32, OR1K32BF_SFMT_LF_SFEQ_D32 },
   { OR1K_INSN_LF_MADD_S, OR1K32BF_INSN_LF_MADD_S, OR1K32BF_SFMT_LF_MADD_S },
+  { OR1K_INSN_LF_MADD_D32, OR1K32BF_INSN_LF_MADD_D32, OR1K32BF_SFMT_LF_MADD_D32 },
   { OR1K_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_LF_CUST1_D32, OR1K32BF_INSN_LF_CUST1_D32, OR1K32BF_SFMT_L_MSYNC },
 };
 
 static const struct insn_sem or1k32bf_insn_sem_invalid =
@@ -235,7 +264,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     CGEN_INSN_WORD insn = base_insn;
 
     {
-      unsigned int val = (((insn >> 21) & (63 << 5)) | ((insn >> 2) & (1 << 4)) | ((insn >> 0) & (15 << 0)));
+      unsigned int val = (((insn >> 21) & (63 << 5)) | ((insn >> 0) & (31 << 0)));
       switch (val)
       {
       case 0 : /* fall through */
@@ -1083,22 +1112,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
@@ -1116,14 +1130,22 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
@@ -1258,9 +1280,21 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
+            if ((entire_insn & 0xffe004ff) == 0xc80000e0)
+              { itype = OR1K32BF_INSN_LF_CUST1_D32; goto extract_sfmt_l_msync; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1601 :
         if ((entire_insn & 0xfc0007ff) == 0xc8000001)
           { itype = OR1K32BF_INSN_LF_SUB_S; goto extract_sfmt_lf_add_s; }
@@ -1290,32 +1324,248 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
           { itype = OR1K32BF_INSN_LF_MADD_S; goto extract_sfmt_lf_madd_s; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1608 :
-        if ((entire_insn & 0xffe007ff) == 0xc8000008)
-          { itype = OR1K32BF_INSN_LF_EQ_S; goto extract_sfmt_lf_eq_s; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe007ff) == 0xc8000008)
+              { itype = OR1K32BF_INSN_LF_SFEQ_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe007ff) == 0xc8000028)
+              { itype = OR1K32BF_INSN_LF_SFUEQ_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1609 :
-        if ((entire_insn & 0xffe007ff) == 0xc8000009)
-          { itype = OR1K32BF_INSN_LF_NE_S; goto extract_sfmt_lf_eq_s; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe007ff) == 0xc8000009)
+              { itype = OR1K32BF_INSN_LF_SFNE_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe007ff) == 0xc8000029)
+              { itype = OR1K32BF_INSN_LF_SFUNE_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1610 :
-        if ((entire_insn & 0xffe007ff) == 0xc800000a)
-          { itype = OR1K32BF_INSN_LF_GT_S; goto extract_sfmt_lf_eq_s; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe007ff) == 0xc800000a)
+              { itype = OR1K32BF_INSN_LF_SFGT_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe007ff) == 0xc800002a)
+              { itype = OR1K32BF_INSN_LF_SFUGT_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1611 :
-        if ((entire_insn & 0xffe007ff) == 0xc800000b)
-          { itype = OR1K32BF_INSN_LF_GE_S; goto extract_sfmt_lf_eq_s; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe007ff) == 0xc800000b)
+              { itype = OR1K32BF_INSN_LF_SFGE_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe007ff) == 0xc800002b)
+              { itype = OR1K32BF_INSN_LF_SFUGE_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1612 :
-        if ((entire_insn & 0xffe007ff) == 0xc800000c)
-          { itype = OR1K32BF_INSN_LF_LT_S; goto extract_sfmt_lf_eq_s; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe007ff) == 0xc800000c)
+              { itype = OR1K32BF_INSN_LF_SFLT_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe007ff) == 0xc800002c)
+              { itype = OR1K32BF_INSN_LF_SFULT_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1613 :
-        if ((entire_insn & 0xffe007ff) == 0xc800000d)
-          { itype = OR1K32BF_INSN_LF_LE_S; goto extract_sfmt_lf_eq_s; }
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe007ff) == 0xc800000d)
+              { itype = OR1K32BF_INSN_LF_SFLE_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe007ff) == 0xc800002d)
+              { itype = OR1K32BF_INSN_LF_SFULE_S; goto extract_sfmt_lf_sfeq_s; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1614 :
+        if ((entire_insn & 0xffe007ff) == 0xc800002e)
+          { itype = OR1K32BF_INSN_LF_SFUN_S; goto extract_sfmt_lf_sfeq_s; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1616 :
-        if ((entire_insn & 0xffe007ff) == 0xc80000d0)
-          { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_msync; }
+        {
+          unsigned int val = (((insn >> 6) & (3 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xfc0000ff) == 0xc8000010)
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
+        if ((entire_insn & 0xfc0000ff) == 0xc8000011)
+          { itype = OR1K32BF_INSN_LF_SUB_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1618 :
+        if ((entire_insn & 0xfc0000ff) == 0xc8000012)
+          { itype = OR1K32BF_INSN_LF_MUL_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1619 :
+        if ((entire_insn & 0xfc0000ff) == 0xc8000013)
+          { itype = OR1K32BF_INSN_LF_DIV_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1620 :
+        if ((entire_insn & 0xfc00f9ff) == 0xc8000014)
+          { itype = OR1K32BF_INSN_LF_ITOF_D32; goto extract_sfmt_lf_itof_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1621 :
+        if ((entire_insn & 0xfc00f9ff) == 0xc8000015)
+          { itype = OR1K32BF_INSN_LF_FTOI_D32; goto extract_sfmt_lf_ftoi_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1622 :
+        if ((entire_insn & 0xfc0000ff) == 0xc8000016)
+          { itype = OR1K32BF_INSN_LF_REM_D32; goto extract_sfmt_lf_add_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1623 :
+        if ((entire_insn & 0xfc0000ff) == 0xc8000017)
+          { itype = OR1K32BF_INSN_LF_MADD_D32; goto extract_sfmt_lf_madd_d32; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1624 :
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe004ff) == 0xc8000018)
+              { itype = OR1K32BF_INSN_LF_SFEQ_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe004ff) == 0xc8000038)
+              { itype = OR1K32BF_INSN_LF_SFUEQ_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1625 :
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe004ff) == 0xc8000019)
+              { itype = OR1K32BF_INSN_LF_SFNE_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe004ff) == 0xc8000039)
+              { itype = OR1K32BF_INSN_LF_SFUNE_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1626 :
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe004ff) == 0xc800001a)
+              { itype = OR1K32BF_INSN_LF_SFGT_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe004ff) == 0xc800003a)
+              { itype = OR1K32BF_INSN_LF_SFUGT_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1627 :
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe004ff) == 0xc800001b)
+              { itype = OR1K32BF_INSN_LF_SFGE_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe004ff) == 0xc800003b)
+              { itype = OR1K32BF_INSN_LF_SFUGE_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1628 :
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe004ff) == 0xc800001c)
+              { itype = OR1K32BF_INSN_LF_SFLT_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe004ff) == 0xc800003c)
+              { itype = OR1K32BF_INSN_LF_SFULT_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1629 :
+        {
+          unsigned int val = (((insn >> 5) & (1 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffe004ff) == 0xc800001d)
+              { itype = OR1K32BF_INSN_LF_SFLE_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 1 :
+            if ((entire_insn & 0xffe004ff) == 0xc800003d)
+              { itype = OR1K32BF_INSN_LF_SFULE_D32; goto extract_sfmt_lf_sfeq_d32; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
+      case 1630 :
+        if ((entire_insn & 0xffe004ff) == 0xc800003e)
+          { itype = OR1K32BF_INSN_LF_SFUN_D32; goto extract_sfmt_lf_sfeq_d32; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1632 : /* fall through */
       case 1633 : /* fall through */
@@ -1479,7 +1729,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1800 :
         {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
+          unsigned int val = (((insn >> 6) & (3 << 0)));
           switch (val)
           {
           case 0 :
@@ -1487,9 +1737,17 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
@@ -1507,7 +1765,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1804 :
         {
-          unsigned int val = (((insn >> 7) & (1 << 0)));
+          unsigned int val = (((insn >> 6) & (3 << 0)));
           switch (val)
           {
           case 0 :
@@ -1515,22 +1773,34 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
@@ -1557,42 +1827,6 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
@@ -2682,6 +2916,41 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+    UINT f_rdoff_10_1;
+    UINT f_raoff_9_1;
+    UINT f_rboff_8_1;
+    SI f_rdd32;
+    SI f_rad32;
+    SI f_rbd32;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+    f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1);
+    f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1);
+    f_rboff_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1);
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));
+  f_rbd32 = ((f_r3) | (((f_rboff_8_1) << (5))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_rad32) = f_rad32;
+  FLD (f_rbd32) = f_rbd32;
+  FLD (f_rdd32) = f_rdd32;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_add_d32", "f_rad32 0x%x", 'x', f_rad32, "f_rbd32 0x%x", 'x', f_rbd32, "f_rdd32 0x%x", 'x', f_rdd32, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2702,6 +2971,34 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_rdoff_10_1;
+    UINT f_raoff_9_1;
+    SI f_rdd32;
+    SI f_rad32;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1);
+    f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1);
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_rad32) = f_rad32;
+  FLD (f_rdd32) = f_rdd32;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_itof_d32", "f_rad32 0x%x", 'x', f_rad32, "f_rdd32 0x%x", 'x', f_rdd32, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2726,7 +3023,35 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_lf_eq_s:
+ extract_sfmt_lf_ftoi_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_rdoff_10_1;
+    UINT f_raoff_9_1;
+    SI f_rdd32;
+    SI f_rad32;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1);
+    f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1);
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_rad32) = f_rad32;
+  FLD (f_rdd32) = f_rdd32;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_ftoi_d32", "f_rad32 0x%x", 'x', f_rad32, "f_rdd32 0x%x", 'x', f_rdd32, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_sfeq_s:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
     CGEN_INSN_WORD insn = entire_insn;
@@ -2740,7 +3065,35 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   /* Record the fields for the semantic handler.  */
   FLD (f_r2) = f_r2;
   FLD (f_r3) = f_r3;
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_eq_s", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_sfeq_s", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_lf_sfeq_d32:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+    UINT f_r2;
+    UINT f_r3;
+    UINT f_raoff_9_1;
+    UINT f_rboff_8_1;
+    SI f_rad32;
+    SI f_rbd32;
+
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+    f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1);
+    f_rboff_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1);
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));
+  f_rbd32 = ((f_r3) | (((f_rboff_8_1) << (5))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_rad32) = f_rad32;
+  FLD (f_rbd32) = f_rbd32;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_sfeq_d32", "f_rad32 0x%x", 'x', f_rad32, "f_rbd32 0x%x", 'x', f_rbd32, (char *) 0));
 
 #undef FLD
     return idesc;
@@ -2765,6 +3118,41 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+    UINT f_rdoff_10_1;
+    UINT f_raoff_9_1;
+    UINT f_rboff_8_1;
+    SI f_rdd32;
+    SI f_rad32;
+    SI f_rbd32;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+    f_rdoff_10_1 = EXTRACT_LSB0_UINT (insn, 32, 10, 1);
+    f_raoff_9_1 = EXTRACT_LSB0_UINT (insn, 32, 9, 1);
+    f_rboff_8_1 = EXTRACT_LSB0_UINT (insn, 32, 8, 1);
+  f_rdd32 = ((f_r1) | (((f_rdoff_10_1) << (5))));
+  f_rad32 = ((f_r2) | (((f_raoff_9_1) << (5))));
+  f_rbd32 = ((f_r3) | (((f_rboff_8_1) << (5))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_rad32) = f_rad32;
+  FLD (f_rbd32) = f_rbd32;
+  FLD (f_rdd32) = f_rdd32;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_lf_madd_d32", "f_rad32 0x%x", 'x', f_rad32, "f_rbd32 0x%x", 'x', f_rbd32, "f_rdd32 0x%x", 'x', f_rdd32, (char *) 0));
+
 #undef FLD
     return idesc;
   }
diff --git a/sim/or1k/decode.h b/sim/or1k/decode.h
index 8650bdfa0e..b338ba69c2 100644
--- a/sim/or1k/decode.h
+++ b/sim/or1k/decode.h
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
@@ -60,10 +60,17 @@ typedef enum or1k32bf_insn_type {
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
+ , OR1K32BF_INSN_LF_FTOI_D32, OR1K32BF_INSN_LF_SFEQ_S, OR1K32BF_INSN_LF_SFEQ_D32, OR1K32BF_INSN_LF_SFNE_S
+ , OR1K32BF_INSN_LF_SFNE_D32, OR1K32BF_INSN_LF_SFGE_S, OR1K32BF_INSN_LF_SFGE_D32, OR1K32BF_INSN_LF_SFGT_S
+ , OR1K32BF_INSN_LF_SFGT_D32, OR1K32BF_INSN_LF_SFLT_S, OR1K32BF_INSN_LF_SFLT_D32, OR1K32BF_INSN_LF_SFLE_S
+ , OR1K32BF_INSN_LF_SFLE_D32, OR1K32BF_INSN_LF_SFUEQ_S, OR1K32BF_INSN_LF_SFUEQ_D32, OR1K32BF_INSN_LF_SFUNE_S
+ , OR1K32BF_INSN_LF_SFUNE_D32, OR1K32BF_INSN_LF_SFUGT_S, OR1K32BF_INSN_LF_SFUGT_D32, OR1K32BF_INSN_LF_SFUGE_S
+ , OR1K32BF_INSN_LF_SFUGE_D32, OR1K32BF_INSN_LF_SFULT_S, OR1K32BF_INSN_LF_SFULT_D32, OR1K32BF_INSN_LF_SFULE_S
+ , OR1K32BF_INSN_LF_SFULE_D32, OR1K32BF_INSN_LF_SFUN_S, OR1K32BF_INSN_LF_SFUN_D32, OR1K32BF_INSN_LF_MADD_S
+ , OR1K32BF_INSN_LF_MADD_D32, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_D32, OR1K32BF_INSN__MAX
 } OR1K32BF_INSN_TYPE;
 
 /* Enum declaration for semantic formats in cpu family or1k32bf.  */
@@ -80,7 +87,9 @@ typedef enum or1k32bf_sfmt_type {
  , OR1K32BF_SFMT_L_XORI, OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC, OR1K32BF_SFMT_L_MULI
  , OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV, OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI
  , OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI, OR1K32BF_SFMT_L_MACU, OR1K32BF_SFMT_LF_ADD_S
- , OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S, OR1K32BF_SFMT_LF_MADD_S
+ , OR1K32BF_SFMT_LF_ADD_D32, OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_ITOF_D32, OR1K32BF_SFMT_LF_FTOI_S
+ , OR1K32BF_SFMT_LF_FTOI_D32, OR1K32BF_SFMT_LF_SFEQ_S, OR1K32BF_SFMT_LF_SFEQ_D32, OR1K32BF_SFMT_LF_MADD_S
+ , OR1K32BF_SFMT_LF_MADD_D32
 } OR1K32BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/model.c b/sim/or1k/model.c
index 461ba4bb00..255023d4c2 100644
--- a/sim/or1k/model.c
+++ b/sim/or1k/model.c
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
@@ -1602,6 +1602,22 @@ model_or1200_lf_add_s (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_lf_add_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
@@ -1699,9 +1795,9 @@ model_or1200_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_ftoi_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1715,7 +1811,7 @@ model_or1200_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfeq_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1731,9 +1827,9 @@ model_or1200_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfeq_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1747,7 +1843,7 @@ model_or1200_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfne_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1763,7 +1859,23 @@ model_or1200_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfne_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+static int
+model_or1200_lf_sfge_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1779,7 +1891,23 @@ model_or1200_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfge_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+static int
+model_or1200_lf_sfgt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1795,7 +1923,23 @@ model_or1200_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfgt_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+static int
+model_or1200_lf_sflt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1811,9 +1955,9 @@ model_or1200_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sflt_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1827,55 +1971,71 @@ model_or1200_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_j (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfle_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_j.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_adrp (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfle_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_adrp.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_jal (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfueq_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_j.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_jr (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfueq_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+static int
+model_or1200_lf_sfune_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1884,14 +2044,30 @@ model_or1200nd_l_jr (SIM_CPU *current_cpu, void *sem_arg)
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_jalr (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfune_d32 (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
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
+static int
+model_or1200_lf_sfugt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -1900,208 +2076,224 @@ model_or1200nd_l_jalr (SIM_CPU *current_cpu, void *sem_arg)
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_bnf (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfugt_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_j.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_bf (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfuge_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_j.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_trap (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfuge_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_sys (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfult_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_msync (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfult_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_psync (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfule_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_csync (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfule_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_rfe (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfun_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_nop_imm (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_sfun_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_movhi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_macrc (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_madd_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_adrp.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_mfspr (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
   {
     int referenced = 0;
     int UNUSED insn_referenced = abuf->written;
-    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
   }
   return cycles;
 #undef FLD
 }
 
 static int
-model_or1200nd_l_mtspr (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_lf_cust1_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mtspr.f
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
+static int
+model_or1200nd_l_j (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_j.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2115,7 +2307,375 @@ model_or1200nd_l_mtspr (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lwz (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_adrp (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
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
+static int
+model_or1200nd_l_jal (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_j.f
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
+static int
+model_or1200nd_l_jr (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_jalr (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_bnf (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_j.f
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
+static int
+model_or1200nd_l_bf (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_j.f
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
+static int
+model_or1200nd_l_trap (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_sys (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_msync (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_psync (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_csync (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_rfe (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_nop_imm (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_mfspr.f
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
+static int
+model_or1200nd_l_movhi (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_mfspr.f
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
+static int
+model_or1200nd_l_macrc (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
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
+static int
+model_or1200nd_l_mfspr (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_mfspr.f
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
+static int
+model_or1200nd_l_mtspr (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_mtspr.f
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
+static int
+model_or1200nd_l_lwz (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
+static int
+model_or1200nd_l_lws (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
+static int
+model_or1200nd_l_lwa (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
+static int
+model_or1200nd_l_lbz (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
+static int
+model_or1200nd_l_lbs (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
+static int
+model_or1200nd_l_lhz (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
+static int
+model_or1200nd_l_lhs (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2131,9 +2691,377 @@ model_or1200nd_l_lwz (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lws (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sw (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
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
+static int
+model_or1200nd_l_sb (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
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
+static int
+model_or1200nd_l_sh (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
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
+static int
+model_or1200nd_l_swa (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
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
+static int
+model_or1200nd_l_sll (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_slli (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_srl (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_srli (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_sra (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_srai (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_ror (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_rori (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_and (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_or (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_xor (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_add (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_sub (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_addc (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_mul (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_muld (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_muldu (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_div (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200nd_l_divu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2147,9 +3075,9 @@ model_or1200nd_l_lws (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lwa (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_ff1 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2163,9 +3091,9 @@ model_or1200nd_l_lwa (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lbz (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_fl1 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2179,9 +3107,9 @@ model_or1200nd_l_lbz (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lbs (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_andi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_mfspr.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2195,9 +3123,9 @@ model_or1200nd_l_lbs (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lhz (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_ori (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_mfspr.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2211,7 +3139,7 @@ model_or1200nd_l_lhz (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_lhs (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_xori (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2227,9 +3155,9 @@ model_or1200nd_l_lhs (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sw (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_addi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2243,9 +3171,9 @@ model_or1200nd_l_sw (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sb (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_addic (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2259,9 +3187,9 @@ model_or1200nd_l_sb (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sh (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_muli (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2275,9 +3203,9 @@ model_or1200nd_l_sh (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_swa (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_exths (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sw.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2291,9 +3219,9 @@ model_or1200nd_l_swa (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sll (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_extbs (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2307,7 +3235,7 @@ model_or1200nd_l_sll (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_slli (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_exthz (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2323,9 +3251,9 @@ model_or1200nd_l_slli (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_srl (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_extbz (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2339,7 +3267,7 @@ model_or1200nd_l_srl (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_srli (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_extws (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2355,9 +3283,9 @@ model_or1200nd_l_srli (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sra (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_extwz (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2371,9 +3299,9 @@ model_or1200nd_l_sra (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_srai (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cmov (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2387,7 +3315,7 @@ model_or1200nd_l_srai (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_ror (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2403,9 +3331,9 @@ model_or1200nd_l_ror (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_rori (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2419,7 +3347,7 @@ model_or1200nd_l_rori (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_and (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2435,9 +3363,9 @@ model_or1200nd_l_and (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_or (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2451,7 +3379,7 @@ model_or1200nd_l_or (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_xor (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2467,9 +3395,9 @@ model_or1200nd_l_xor (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_add (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2483,7 +3411,7 @@ model_or1200nd_l_add (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sub (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2499,9 +3427,9 @@ model_or1200nd_l_sub (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_addc (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2515,7 +3443,7 @@ model_or1200nd_l_addc (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_mul (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2531,9 +3459,9 @@ model_or1200nd_l_mul (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_muld (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2547,7 +3475,7 @@ model_or1200nd_l_muld (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2563,9 +3491,9 @@ model_or1200nd_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_muldu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2579,7 +3507,7 @@ model_or1200nd_l_muldu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_div (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2595,9 +3523,9 @@ model_or1200nd_l_div (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_divu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2611,9 +3539,9 @@ model_or1200nd_l_divu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_ff1 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2627,9 +3555,9 @@ model_or1200nd_l_ff1 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_fl1 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2643,9 +3571,9 @@ model_or1200nd_l_fl1 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_andi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfeq (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2659,9 +3587,9 @@ model_or1200nd_l_andi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_ori (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfeqi (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_mfspr.f
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2675,9 +3603,9 @@ model_or1200nd_l_ori (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_xori (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfne (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2691,7 +3619,7 @@ model_or1200nd_l_xori (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_addi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_sfnei (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2707,9 +3635,9 @@ model_or1200nd_l_addi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_addic (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_mac (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2723,7 +3651,7 @@ model_or1200nd_l_addic (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_muli (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_maci (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2739,9 +3667,9 @@ model_or1200nd_l_muli (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_exths (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_macu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2755,9 +3683,9 @@ model_or1200nd_l_exths (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_extbs (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2771,9 +3699,9 @@ model_or1200nd_l_extbs (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_exthz (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_msbu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2787,9 +3715,9 @@ model_or1200nd_l_exthz (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_extbz (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust1 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2803,9 +3731,9 @@ model_or1200nd_l_extbz (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_extws (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust2 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2819,9 +3747,9 @@ model_or1200nd_l_extws (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_extwz (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust3 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2835,9 +3763,9 @@ model_or1200nd_l_extwz (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cmov (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust4 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2851,9 +3779,9 @@ model_or1200nd_l_cmov (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust5 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2867,9 +3795,9 @@ model_or1200nd_l_sfgts (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust6 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2883,9 +3811,9 @@ model_or1200nd_l_sfgtsi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust7 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2899,9 +3827,9 @@ model_or1200nd_l_sfgtu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_cust8 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2915,7 +3843,7 @@ model_or1200nd_l_sfgtui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_add_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2931,9 +3859,9 @@ model_or1200nd_l_sfges (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_add_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2947,7 +3875,7 @@ model_or1200nd_l_sfgesi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2963,9 +3891,9 @@ model_or1200nd_l_sfgeu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sub_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2979,7 +3907,7 @@ model_or1200nd_l_sfgeui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -2995,9 +3923,9 @@ model_or1200nd_l_sflts (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_mul_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3011,7 +3939,7 @@ model_or1200nd_l_sfltsi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3027,9 +3955,9 @@ model_or1200nd_l_sfltu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_div_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3043,7 +3971,7 @@ model_or1200nd_l_sfltui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3059,9 +3987,9 @@ model_or1200nd_l_sfles (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_rem_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3075,9 +4003,9 @@ model_or1200nd_l_sflesi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3091,9 +4019,9 @@ model_or1200nd_l_sfleu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_itof_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3107,9 +4035,9 @@ model_or1200nd_l_sfleui (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfeq (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_l_slli.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3123,9 +4051,9 @@ model_or1200nd_l_sfeq (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfeqi (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_ftoi_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3139,7 +4067,7 @@ model_or1200nd_l_sfeqi (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfne (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfeq_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3155,9 +4083,9 @@ model_or1200nd_l_sfne (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_sfnei (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfeq_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3171,7 +4099,7 @@ model_or1200nd_l_sfnei (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_mac (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfne_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3187,9 +4115,9 @@ model_or1200nd_l_mac (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_maci (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfne_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3203,7 +4131,7 @@ model_or1200nd_l_maci (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_macu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfge_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3219,9 +4147,9 @@ model_or1200nd_l_macu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_msb (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfge_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3235,7 +4163,7 @@ model_or1200nd_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_msbu (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfgt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3251,9 +4179,9 @@ model_or1200nd_l_msbu (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust1 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfgt_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3267,9 +4195,9 @@ model_or1200nd_l_cust1 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust2 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sflt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3283,9 +4211,9 @@ model_or1200nd_l_cust2 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust3 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sflt_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3299,9 +4227,9 @@ model_or1200nd_l_cust3 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust4 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfle_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3315,9 +4243,9 @@ model_or1200nd_l_cust4 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust5 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfle_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3331,9 +4259,9 @@ model_or1200nd_l_cust5 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust6 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfueq_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3347,9 +4275,9 @@ model_or1200nd_l_cust6 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust7 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfueq_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3363,9 +4291,9 @@ model_or1200nd_l_cust7 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_cust8 (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfune_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_empty.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3379,9 +4307,9 @@ model_or1200nd_l_cust8 (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_add_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfune_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3395,7 +4323,7 @@ model_or1200nd_lf_add_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfugt_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3411,9 +4339,9 @@ model_or1200nd_lf_sub_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfugt_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3427,7 +4355,7 @@ model_or1200nd_lf_mul_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfuge_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3443,9 +4371,9 @@ model_or1200nd_lf_div_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfuge_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3459,9 +4387,9 @@ model_or1200nd_lf_rem_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfult_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3475,9 +4403,9 @@ model_or1200nd_lf_itof_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfult_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3491,7 +4419,7 @@ model_or1200nd_lf_ftoi_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfule_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3507,9 +4435,9 @@ model_or1200nd_lf_eq_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfule_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3523,7 +4451,7 @@ model_or1200nd_lf_ne_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfun_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3539,9 +4467,9 @@ model_or1200nd_lf_ge_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_sfun_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3555,7 +4483,7 @@ model_or1200nd_lf_gt_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3571,9 +4499,9 @@ model_or1200nd_lf_lt_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_madd_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3587,9 +4515,9 @@ model_or1200nd_lf_le_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_sll.f
+#define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3603,7 +4531,7 @@ model_or1200nd_lf_madd_s (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_lf_cust1_s (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_lf_cust1_d32 (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_empty.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
@@ -3728,20 +4656,49 @@ static const INSN_TIMING or1200_timing[] = {
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
-  { OR1K32BF_INSN_LF_EQ_S, model_or1200_lf_eq_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_NE_S, model_or1200_lf_ne_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_GE_S, model_or1200_lf_ge_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_GT_S, model_or1200_lf_gt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_LT_S, model_or1200_lf_lt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_LE_S, model_or1200_lf_le_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_FTOI_D32, model_or1200_lf_ftoi_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFEQ_S, model_or1200_lf_sfeq_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFEQ_D32, model_or1200_lf_sfeq_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFNE_S, model_or1200_lf_sfne_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFNE_D32, model_or1200_lf_sfne_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGE_S, model_or1200_lf_sfge_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGE_D32, model_or1200_lf_sfge_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGT_S, model_or1200_lf_sfgt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGT_D32, model_or1200_lf_sfgt_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLT_S, model_or1200_lf_sflt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLT_D32, model_or1200_lf_sflt_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLE_S, model_or1200_lf_sfle_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLE_D32, model_or1200_lf_sfle_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUEQ_S, model_or1200_lf_sfueq_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUEQ_D32, model_or1200_lf_sfueq_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUNE_S, model_or1200_lf_sfune_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUNE_D32, model_or1200_lf_sfune_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGT_S, model_or1200_lf_sfugt_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGT_D32, model_or1200_lf_sfugt_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGE_S, model_or1200_lf_sfuge_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGE_D32, model_or1200_lf_sfuge_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULT_S, model_or1200_lf_sfult_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULT_D32, model_or1200_lf_sfult_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULE_S, model_or1200_lf_sfule_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULE_D32, model_or1200_lf_sfule_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUN_S, model_or1200_lf_sfun_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUN_D32, model_or1200_lf_sfun_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_MADD_S, model_or1200_lf_madd_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_MADD_D32, model_or1200_lf_madd_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_CUST1_S, model_or1200_lf_cust1_s, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_CUST1_D32, model_or1200_lf_cust1_d32, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
 };
 
 /* Model timing data for `or1200nd'.  */
@@ -3851,20 +4808,49 @@ static const INSN_TIMING or1200nd_timing[] = {
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
-  { OR1K32BF_INSN_LF_EQ_S, model_or1200nd_lf_eq_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_NE_S, model_or1200nd_lf_ne_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_GE_S, model_or1200nd_lf_ge_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_GT_S, model_or1200nd_lf_gt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_LT_S, model_or1200nd_lf_lt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_LF_LE_S, model_or1200nd_lf_le_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_FTOI_D32, model_or1200nd_lf_ftoi_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFEQ_S, model_or1200nd_lf_sfeq_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFEQ_D32, model_or1200nd_lf_sfeq_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFNE_S, model_or1200nd_lf_sfne_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFNE_D32, model_or1200nd_lf_sfne_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGE_S, model_or1200nd_lf_sfge_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGE_D32, model_or1200nd_lf_sfge_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGT_S, model_or1200nd_lf_sfgt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFGT_D32, model_or1200nd_lf_sfgt_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLT_S, model_or1200nd_lf_sflt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLT_D32, model_or1200nd_lf_sflt_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLE_S, model_or1200nd_lf_sfle_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFLE_D32, model_or1200nd_lf_sfle_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUEQ_S, model_or1200nd_lf_sfueq_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUEQ_D32, model_or1200nd_lf_sfueq_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUNE_S, model_or1200nd_lf_sfune_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUNE_D32, model_or1200nd_lf_sfune_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGT_S, model_or1200nd_lf_sfugt_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGT_D32, model_or1200nd_lf_sfugt_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGE_S, model_or1200nd_lf_sfuge_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUGE_D32, model_or1200nd_lf_sfuge_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULT_S, model_or1200nd_lf_sfult_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULT_D32, model_or1200nd_lf_sfult_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULE_S, model_or1200nd_lf_sfule_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFULE_D32, model_or1200nd_lf_sfule_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUN_S, model_or1200nd_lf_sfun_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_SFUN_D32, model_or1200nd_lf_sfun_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_MADD_S, model_or1200nd_lf_madd_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_MADD_D32, model_or1200nd_lf_madd_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_LF_CUST1_S, model_or1200nd_lf_cust1_s, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_LF_CUST1_D32, model_or1200nd_lf_cust1_d32, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
 };
 
 #endif /* WITH_PROFILE_MODEL_P */
diff --git a/sim/or1k/sem-switch.c b/sim/or1k/sem-switch.c
index e250e45c60..ac29177057 100644
--- a/sim/or1k/sem-switch.c
+++ b/sim/or1k/sem-switch.c
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
@@ -136,20 +136,49 @@ This file is part of the GNU simulators.
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
-    { OR1K32BF_INSN_LF_EQ_S, && case_sem_INSN_LF_EQ_S },
-    { OR1K32BF_INSN_LF_NE_S, && case_sem_INSN_LF_NE_S },
-    { OR1K32BF_INSN_LF_GE_S, && case_sem_INSN_LF_GE_S },
-    { OR1K32BF_INSN_LF_GT_S, && case_sem_INSN_LF_GT_S },
-    { OR1K32BF_INSN_LF_LT_S, && case_sem_INSN_LF_LT_S },
-    { OR1K32BF_INSN_LF_LE_S, && case_sem_INSN_LF_LE_S },
+    { OR1K32BF_INSN_LF_FTOI_D32, && case_sem_INSN_LF_FTOI_D32 },
+    { OR1K32BF_INSN_LF_SFEQ_S, && case_sem_INSN_LF_SFEQ_S },
+    { OR1K32BF_INSN_LF_SFEQ_D32, && case_sem_INSN_LF_SFEQ_D32 },
+    { OR1K32BF_INSN_LF_SFNE_S, && case_sem_INSN_LF_SFNE_S },
+    { OR1K32BF_INSN_LF_SFNE_D32, && case_sem_INSN_LF_SFNE_D32 },
+    { OR1K32BF_INSN_LF_SFGE_S, && case_sem_INSN_LF_SFGE_S },
+    { OR1K32BF_INSN_LF_SFGE_D32, && case_sem_INSN_LF_SFGE_D32 },
+    { OR1K32BF_INSN_LF_SFGT_S, && case_sem_INSN_LF_SFGT_S },
+    { OR1K32BF_INSN_LF_SFGT_D32, && case_sem_INSN_LF_SFGT_D32 },
+    { OR1K32BF_INSN_LF_SFLT_S, && case_sem_INSN_LF_SFLT_S },
+    { OR1K32BF_INSN_LF_SFLT_D32, && case_sem_INSN_LF_SFLT_D32 },
+    { OR1K32BF_INSN_LF_SFLE_S, && case_sem_INSN_LF_SFLE_S },
+    { OR1K32BF_INSN_LF_SFLE_D32, && case_sem_INSN_LF_SFLE_D32 },
+    { OR1K32BF_INSN_LF_SFUEQ_S, && case_sem_INSN_LF_SFUEQ_S },
+    { OR1K32BF_INSN_LF_SFUEQ_D32, && case_sem_INSN_LF_SFUEQ_D32 },
+    { OR1K32BF_INSN_LF_SFUNE_S, && case_sem_INSN_LF_SFUNE_S },
+    { OR1K32BF_INSN_LF_SFUNE_D32, && case_sem_INSN_LF_SFUNE_D32 },
+    { OR1K32BF_INSN_LF_SFUGT_S, && case_sem_INSN_LF_SFUGT_S },
+    { OR1K32BF_INSN_LF_SFUGT_D32, && case_sem_INSN_LF_SFUGT_D32 },
+    { OR1K32BF_INSN_LF_SFUGE_S, && case_sem_INSN_LF_SFUGE_S },
+    { OR1K32BF_INSN_LF_SFUGE_D32, && case_sem_INSN_LF_SFUGE_D32 },
+    { OR1K32BF_INSN_LF_SFULT_S, && case_sem_INSN_LF_SFULT_S },
+    { OR1K32BF_INSN_LF_SFULT_D32, && case_sem_INSN_LF_SFULT_D32 },
+    { OR1K32BF_INSN_LF_SFULE_S, && case_sem_INSN_LF_SFULE_S },
+    { OR1K32BF_INSN_LF_SFULE_D32, && case_sem_INSN_LF_SFULE_D32 },
+    { OR1K32BF_INSN_LF_SFUN_S, && case_sem_INSN_LF_SFUN_S },
+    { OR1K32BF_INSN_LF_SFUN_D32, && case_sem_INSN_LF_SFUN_D32 },
     { OR1K32BF_INSN_LF_MADD_S, && case_sem_INSN_LF_MADD_S },
+    { OR1K32BF_INSN_LF_MADD_D32, && case_sem_INSN_LF_MADD_D32 },
     { OR1K32BF_INSN_LF_CUST1_S, && case_sem_INSN_LF_CUST1_S },
+    { OR1K32BF_INSN_LF_CUST1_D32, && case_sem_INSN_LF_CUST1_D32 },
     { 0, 0 }
   };
   int i;
@@ -2646,6 +2675,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2665,6 +2713,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->subdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2684,6 +2751,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2703,6 +2789,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->divdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2722,6 +2827,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->remdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2741,6 +2865,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->floatdidf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_I64R (FLD (f_rad32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2764,7 +2907,26 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_LF_EQ_S) : /* lf.sfeq.s $rASF,$rBSF */
+  CASE (sem, INSN_LF_FTOI_D32) : /* lf.ftoi.d $rDDI,$rAD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DI opval = CGEN_CPU_FPU (current_cpu)->ops->fixdfdi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FD32R (FLD (f_rad32)));
+    SET_H_I64R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "i64r", 'D', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFEQ_S) : /* lf.sfeq.s $rASF,$rBSF */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2783,7 +2945,26 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_LF_NE_S) : /* lf.sfne.s $rASF,$rBSF */
+  CASE (sem, INSN_LF_SFEQ_D32) : /* lf.sfeq.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFNE_S) : /* lf.sfne.s $rASF,$rBSF */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2802,7 +2983,26 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_LF_GE_S) : /* lf.sfge.s $rASF,$rBSF */
+  CASE (sem, INSN_LF_SFNE_D32) : /* lf.sfne.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFGE_S) : /* lf.sfge.s $rASF,$rBSF */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2821,7 +3021,26 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_LF_GT_S) : /* lf.sfgt.s $rASF,$rBSF */
+  CASE (sem, INSN_LF_SFGE_D32) : /* lf.sfge.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFGT_S) : /* lf.sfgt.s $rASF,$rBSF */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2840,7 +3059,26 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_LF_LT_S) : /* lf.sflt.s $rASF,$rBSF */
+  CASE (sem, INSN_LF_SFGT_D32) : /* lf.sfgt.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFLT_S) : /* lf.sflt.s $rASF,$rBSF */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2859,7 +3097,26 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_LF_LE_S) : /* lf.sfle.s $rASF,$rBSF */
+  CASE (sem, INSN_LF_SFLT_D32) : /* lf.sflt.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFLE_S) : /* lf.sfle.s $rASF,$rBSF */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2874,6 +3131,291 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFLE_D32) : /* lf.sfle.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUEQ_S) : /* lf.sfueq.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->eqsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUEQ_D32) : /* lf.sfueq.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUNE_S) : /* lf.sfune.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->nesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUNE_D32) : /* lf.sfune.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUGT_S) : /* lf.sfugt.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->gtsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUGT_D32) : /* lf.sfugt.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUGE_S) : /* lf.sfuge.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->gesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUGE_D32) : /* lf.sfuge.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFULT_S) : /* lf.sfult.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->ltsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFULT_D32) : /* lf.sfult.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFULE_S) : /* lf.sfule.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->lesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFULE_D32) : /* lf.sfule.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUN_S) : /* lf.sfun.s $rASF,$rBSF */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_LF_SFUN_D32) : /* lf.sfun.d $rAD32F,$rBD32F */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2893,6 +3435,25 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), GET_H_FD32R (FLD (f_rdd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
 #undef FLD
 }
   NEXT (vpc);
@@ -2908,6 +3469,21 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 
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
index 15ef24c079..ff3886b8a5 100644
--- a/sim/or1k/sem.c
+++ b/sim/or1k/sem.c
@@ -2,7 +2,7 @@
 
 THIS FILE IS MACHINE GENERATED WITH CGEN.
 
-Copyright 1996-2019 Free Software Foundation, Inc.
+Copyright (C) 1996-2019 Free Software Foundation, Inc.
 
 This file is part of the GNU simulators.
 
@@ -2694,6 +2694,27 @@ SEM_FN_NAME (or1k32bf,lf_add_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-add-d32: lf.add.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_add_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->subdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->divdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->remdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
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
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->floatdidf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_I64R (FLD (f_rad32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-ftoi-s: lf.ftoi.s $rD,$rASF */
 
 static SEM_PC
@@ -2820,10 +2946,31 @@ SEM_FN_NAME (or1k32bf,lf_ftoi_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* lf-eq-s: lf.sfeq.s $rASF,$rBSF */
+/* lf-ftoi-d32: lf.ftoi.d $rDDI,$rAD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_ftoi_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DI opval = CGEN_CPU_FPU (current_cpu)->ops->fixdfdi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FD32R (FLD (f_rad32)));
+    SET_H_I64R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "i64r", 'D', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfeq-s: lf.sfeq.s $rASF,$rBSF */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,lf_eq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,lf_sfeq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2841,10 +2988,31 @@ SEM_FN_NAME (or1k32bf,lf_eq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* lf-ne-s: lf.sfne.s $rASF,$rBSF */
+/* lf-sfeq-d32: lf.sfeq.d $rAD32F,$rBD32F */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,lf_ne_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,lf_sfeq_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfne-s: lf.sfne.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfne_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2862,10 +3030,31 @@ SEM_FN_NAME (or1k32bf,lf_ne_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* lf-ge-s: lf.sfge.s $rASF,$rBSF */
+/* lf-sfne-d32: lf.sfne.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfne_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfge-s: lf.sfge.s $rASF,$rBSF */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,lf_ge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,lf_sfge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2883,10 +3072,31 @@ SEM_FN_NAME (or1k32bf,lf_ge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* lf-gt-s: lf.sfgt.s $rASF,$rBSF */
+/* lf-sfge-d32: lf.sfge.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfge_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfgt-s: lf.sfgt.s $rASF,$rBSF */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,lf_gt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,lf_sfgt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2904,10 +3114,31 @@ SEM_FN_NAME (or1k32bf,lf_gt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* lf-lt-s: lf.sflt.s $rASF,$rBSF */
+/* lf-sfgt-d32: lf.sfgt.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfgt_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sflt-s: lf.sflt.s $rASF,$rBSF */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,lf_lt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,lf_sflt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2925,10 +3156,31 @@ SEM_FN_NAME (or1k32bf,lf_lt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
-/* lf-le-s: lf.sfle.s $rASF,$rBSF */
+/* lf-sflt-d32: lf.sflt.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sflt_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfle-s: lf.sfle.s $rASF,$rBSF */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,lf_le_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,lf_sfle_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -2946,6 +3198,321 @@ SEM_FN_NAME (or1k32bf,lf_le_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-sfle-d32: lf.sfle.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfle_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfueq-s: lf.sfueq.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfueq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->eqsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfueq-d32: lf.sfueq.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfueq_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfune-s: lf.sfune.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfune_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->nesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfune-d32: lf.sfune.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfune_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfugt-s: lf.sfugt.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfugt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->gtsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfugt-d32: lf.sfugt.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfugt_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfuge-s: lf.sfuge.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfuge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->gesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfuge-d32: lf.sfuge.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfuge_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfult-s: lf.sfult.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfult_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->ltsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfult-d32: lf.sfult.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfult_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfule-s: lf.sfule.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfule_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), CGEN_CPU_FPU (current_cpu)->ops->lesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfule-d32: lf.sfule.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfule_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = ORBI (CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfun-s: lf.sfun.s $rASF,$rBSF */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfun_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->unorderedsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* lf-sfun-d32: lf.sfun.d $rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_sfun_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    BI opval = CGEN_CPU_FPU (current_cpu)->ops->unordereddf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32)));
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
@@ -2967,6 +3534,27 @@ SEM_FN_NAME (or1k32bf,lf_madd_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 #undef FLD
 }
 
+/* lf-madd-d32: lf.madd.d $rDD32F,$rAD32F,$rBD32F */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,lf_madd_d32) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_lf_add_d32.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FD32R (FLD (f_rad32)), GET_H_FD32R (FLD (f_rbd32))), GET_H_FD32R (FLD (f_rdd32)));
+    SET_H_FD32R (FLD (f_rdd32), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fd32r", 'f', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* lf-cust1-s: lf.cust1.s $rASF,$rBSF */
 
 static SEM_PC
@@ -2984,6 +3572,23 @@ SEM_FN_NAME (or1k32bf,lf_cust1_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
@@ -3091,20 +3696,49 @@ static const struct sem_fn_desc sem_fns[] = {
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
-  { OR1K32BF_INSN_LF_EQ_S, SEM_FN_NAME (or1k32bf,lf_eq_s) },
-  { OR1K32BF_INSN_LF_NE_S, SEM_FN_NAME (or1k32bf,lf_ne_s) },
-  { OR1K32BF_INSN_LF_GE_S, SEM_FN_NAME (or1k32bf,lf_ge_s) },
-  { OR1K32BF_INSN_LF_GT_S, SEM_FN_NAME (or1k32bf,lf_gt_s) },
-  { OR1K32BF_INSN_LF_LT_S, SEM_FN_NAME (or1k32bf,lf_lt_s) },
-  { OR1K32BF_INSN_LF_LE_S, SEM_FN_NAME (or1k32bf,lf_le_s) },
+  { OR1K32BF_INSN_LF_FTOI_D32, SEM_FN_NAME (or1k32bf,lf_ftoi_d32) },
+  { OR1K32BF_INSN_LF_SFEQ_S, SEM_FN_NAME (or1k32bf,lf_sfeq_s) },
+  { OR1K32BF_INSN_LF_SFEQ_D32, SEM_FN_NAME (or1k32bf,lf_sfeq_d32) },
+  { OR1K32BF_INSN_LF_SFNE_S, SEM_FN_NAME (or1k32bf,lf_sfne_s) },
+  { OR1K32BF_INSN_LF_SFNE_D32, SEM_FN_NAME (or1k32bf,lf_sfne_d32) },
+  { OR1K32BF_INSN_LF_SFGE_S, SEM_FN_NAME (or1k32bf,lf_sfge_s) },
+  { OR1K32BF_INSN_LF_SFGE_D32, SEM_FN_NAME (or1k32bf,lf_sfge_d32) },
+  { OR1K32BF_INSN_LF_SFGT_S, SEM_FN_NAME (or1k32bf,lf_sfgt_s) },
+  { OR1K32BF_INSN_LF_SFGT_D32, SEM_FN_NAME (or1k32bf,lf_sfgt_d32) },
+  { OR1K32BF_INSN_LF_SFLT_S, SEM_FN_NAME (or1k32bf,lf_sflt_s) },
+  { OR1K32BF_INSN_LF_SFLT_D32, SEM_FN_NAME (or1k32bf,lf_sflt_d32) },
+  { OR1K32BF_INSN_LF_SFLE_S, SEM_FN_NAME (or1k32bf,lf_sfle_s) },
+  { OR1K32BF_INSN_LF_SFLE_D32, SEM_FN_NAME (or1k32bf,lf_sfle_d32) },
+  { OR1K32BF_INSN_LF_SFUEQ_S, SEM_FN_NAME (or1k32bf,lf_sfueq_s) },
+  { OR1K32BF_INSN_LF_SFUEQ_D32, SEM_FN_NAME (or1k32bf,lf_sfueq_d32) },
+  { OR1K32BF_INSN_LF_SFUNE_S, SEM_FN_NAME (or1k32bf,lf_sfune_s) },
+  { OR1K32BF_INSN_LF_SFUNE_D32, SEM_FN_NAME (or1k32bf,lf_sfune_d32) },
+  { OR1K32BF_INSN_LF_SFUGT_S, SEM_FN_NAME (or1k32bf,lf_sfugt_s) },
+  { OR1K32BF_INSN_LF_SFUGT_D32, SEM_FN_NAME (or1k32bf,lf_sfugt_d32) },
+  { OR1K32BF_INSN_LF_SFUGE_S, SEM_FN_NAME (or1k32bf,lf_sfuge_s) },
+  { OR1K32BF_INSN_LF_SFUGE_D32, SEM_FN_NAME (or1k32bf,lf_sfuge_d32) },
+  { OR1K32BF_INSN_LF_SFULT_S, SEM_FN_NAME (or1k32bf,lf_sfult_s) },
+  { OR1K32BF_INSN_LF_SFULT_D32, SEM_FN_NAME (or1k32bf,lf_sfult_d32) },
+  { OR1K32BF_INSN_LF_SFULE_S, SEM_FN_NAME (or1k32bf,lf_sfule_s) },
+  { OR1K32BF_INSN_LF_SFULE_D32, SEM_FN_NAME (or1k32bf,lf_sfule_d32) },
+  { OR1K32BF_INSN_LF_SFUN_S, SEM_FN_NAME (or1k32bf,lf_sfun_s) },
+  { OR1K32BF_INSN_LF_SFUN_D32, SEM_FN_NAME (or1k32bf,lf_sfun_d32) },
   { OR1K32BF_INSN_LF_MADD_S, SEM_FN_NAME (or1k32bf,lf_madd_s) },
+  { OR1K32BF_INSN_LF_MADD_D32, SEM_FN_NAME (or1k32bf,lf_madd_d32) },
   { OR1K32BF_INSN_LF_CUST1_S, SEM_FN_NAME (or1k32bf,lf_cust1_s) },
+  { OR1K32BF_INSN_LF_CUST1_D32, SEM_FN_NAME (or1k32bf,lf_cust1_d32) },
   { 0, 0 }
 };
 
-- 
2.21.0

