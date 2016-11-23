From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:27 +0900
Subject: [OpenRISC] [PATCH 13/18] sim: or1k: Regenerate cgen files
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-14-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

These files have been regenerated using latest cgen which has been
updated to generate code that is compatible with the current sim
common api.
---
 sim/or1k/arch32.c       |   2 +-
 sim/or1k/arch64.c       |   2 +-
 sim/or1k/cpu32.c        |  32 ++++
 sim/or1k/cpu32.h        |  40 ++++-
 sim/or1k/cpu64.c        |  32 ++++
 sim/or1k/cpu64.h        |  40 ++++-
 sim/or1k/cpuall32.h     |   4 +-
 sim/or1k/cpuall64.h     |   4 +-
 sim/or1k/decode32.c     | 192 ++++++++++++++++++---
 sim/or1k/decode32.h     |  68 ++++----
 sim/or1k/decode64.c     | 196 ++++++++++++++++++---
 sim/or1k/decode64.h     |  77 +++++----
 sim/or1k/model32.c      | 180 ++++++++++++++++++-
 sim/or1k/model64.c      |  10 +-
 sim/or1k/or1k32-opc.h   | 129 --------------
 sim/or1k/or1k64-opc.h   | 133 ---------------
 sim/or1k/sem32-switch.c | 408 +++++++++++++++++++++++++++++--------------
 sim/or1k/sem32.c        | 418 +++++++++++++++++++++++++++++++--------------
 sim/or1k/sem64-switch.c | 436 +++++++++++++++++++++++++++++++---------------
 sim/or1k/sem64.c        | 446 +++++++++++++++++++++++++++++++++---------------
 20 files changed, 1921 insertions(+), 928 deletions(-)
 delete mode 100644 sim/or1k/or1k32-opc.h
 delete mode 100644 sim/or1k/or1k64-opc.h

diff --git a/sim/or1k/arch32.c b/sim/or1k/arch32.c
index 769f54c..83a9815 100644
--- a/sim/or1k/arch32.c
+++ b/sim/or1k/arch32.c
@@ -25,7 +25,7 @@ This file is part of the GNU simulators.
 #include "sim-main.h"
 #include "bfd.h"
 
-const MACH *sim_machs[] =
+const SIM_MACH *sim_machs[] =
 {
 #ifdef HAVE_CPU_OR1K32BF
   & or32_mach,
diff --git a/sim/or1k/arch64.c b/sim/or1k/arch64.c
index e73f37b..c3f7597 100644
--- a/sim/or1k/arch64.c
+++ b/sim/or1k/arch64.c
@@ -25,7 +25,7 @@ This file is part of the GNU simulators.
 #include "sim-main.h"
 #include "bfd.h"
 
-const MACH *sim_machs[] =
+const SIM_MACH *sim_machs[] =
 {
 #ifdef HAVE_CPU_OR1K64BF
   & or64_mach,
diff --git a/sim/or1k/cpu32.c b/sim/or1k/cpu32.c
index 36b4040..14e11ec 100644
--- a/sim/or1k/cpu32.c
+++ b/sim/or1k/cpu32.c
@@ -10140,6 +10140,38 @@ or1k32bf_h_sys_fpcsr_dzf_set (SIM_CPU *current_cpu, USI newval)
   SET_H_SYS_FPCSR_DZF (newval);
 }
 
+/* Get the value of h-atomic-reserve.  */
+
+BI
+or1k32bf_h_atomic_reserve_get (SIM_CPU *current_cpu)
+{
+  return CPU (h_atomic_reserve);
+}
+
+/* Set a value for h-atomic-reserve.  */
+
+void
+or1k32bf_h_atomic_reserve_set (SIM_CPU *current_cpu, BI newval)
+{
+  CPU (h_atomic_reserve) = newval;
+}
+
+/* Get the value of h-atomic-address.  */
+
+SI
+or1k32bf_h_atomic_address_get (SIM_CPU *current_cpu)
+{
+  return CPU (h_atomic_address);
+}
+
+/* Set a value for h-atomic-address.  */
+
+void
+or1k32bf_h_atomic_address_set (SIM_CPU *current_cpu, SI newval)
+{
+  CPU (h_atomic_address) = newval;
+}
+
 /* Record trace results for INSN.  */
 
 void
diff --git a/sim/or1k/cpu32.h b/sim/or1k/cpu32.h
index a31a935..771fcdc 100644
--- a/sim/or1k/cpu32.h
+++ b/sim/or1k/cpu32.h
@@ -53,6 +53,14 @@ typedef struct {
 do { \
 SET_H_SPR ((((index)) + (ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_GPR0))), (x));\
 ;} while (0)
+  /* atomic reserve flag */
+  BI h_atomic_reserve;
+#define GET_H_ATOMIC_RESERVE() CPU (h_atomic_reserve)
+#define SET_H_ATOMIC_RESERVE(x) (CPU (h_atomic_reserve) = (x))
+  /* atomic reserve address */
+  SI h_atomic_address;
+#define GET_H_ATOMIC_ADDRESS() CPU (h_atomic_address)
+#define SET_H_ATOMIC_ADDRESS(x) (CPU (h_atomic_address) = (x))
   } hardware;
 #define CPU_CGEN_HW(cpu) (& (cpu)->cpu_data.hardware)
 } OR1K32BF_CPU_DATA;
@@ -4475,6 +4483,10 @@ USI or1k32bf_h_sys_fpcsr_inf_get (SIM_CPU *);
 void or1k32bf_h_sys_fpcsr_inf_set (SIM_CPU *, USI);
 USI or1k32bf_h_sys_fpcsr_dzf_get (SIM_CPU *);
 void or1k32bf_h_sys_fpcsr_dzf_set (SIM_CPU *, USI);
+BI or1k32bf_h_atomic_reserve_get (SIM_CPU *);
+void or1k32bf_h_atomic_reserve_set (SIM_CPU *, BI);
+SI or1k32bf_h_atomic_address_get (SIM_CPU *);
+void or1k32bf_h_atomic_address_set (SIM_CPU *, SI);
 
 /* These must be hand-written.  */
 extern CPUREG_FETCH_FN or1k32bf_fetch_register;
@@ -4622,6 +4634,17 @@ struct scache {
   f_resv_20_5 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
   f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16); \
 
+#define EXTRACT_IFMT_L_MSYNC_VARS \
+  UINT f_opcode; \
+  UINT f_op_25_5; \
+  UINT f_resv_20_21; \
+  unsigned int length;
+#define EXTRACT_IFMT_L_MSYNC_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_op_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_resv_20_21 = EXTRACT_LSB0_UINT (insn, 32, 20, 21); \
+
 #define EXTRACT_IFMT_L_RFE_VARS \
   UINT f_opcode; \
   UINT f_resv_25_26; \
@@ -4719,7 +4742,7 @@ struct scache {
 
 #define EXTRACT_IFMT_L_SW_VARS \
   UINT f_opcode; \
-  UINT f_r1; \
+  UINT f_r2; \
   UINT f_r3; \
   UINT f_imm16_25_5; \
   UINT f_imm16_10_11; \
@@ -4728,12 +4751,25 @@ struct scache {
 #define EXTRACT_IFMT_L_SW_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
-  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
   f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
   f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
   f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11); \
   f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));\
 
+#define EXTRACT_IFMT_L_SWA_VARS \
+  UINT f_opcode; \
+  UINT f_r2; \
+  UINT f_r3; \
+  INT f_simm16; \
+  unsigned int length;
+#define EXTRACT_IFMT_L_SWA_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16); \
+
 #define EXTRACT_IFMT_L_SLL_VARS \
   UINT f_opcode; \
   UINT f_r1; \
diff --git a/sim/or1k/cpu64.c b/sim/or1k/cpu64.c
index cd25e89..5f5d605 100644
--- a/sim/or1k/cpu64.c
+++ b/sim/or1k/cpu64.c
@@ -10156,6 +10156,38 @@ or1k64bf_h_sys_fpcsr_dzf_set (SIM_CPU *current_cpu, UDI newval)
   SET_H_SYS_FPCSR_DZF (newval);
 }
 
+/* Get the value of h-atomic-reserve.  */
+
+BI
+or1k64bf_h_atomic_reserve_get (SIM_CPU *current_cpu)
+{
+  return CPU (h_atomic_reserve);
+}
+
+/* Set a value for h-atomic-reserve.  */
+
+void
+or1k64bf_h_atomic_reserve_set (SIM_CPU *current_cpu, BI newval)
+{
+  CPU (h_atomic_reserve) = newval;
+}
+
+/* Get the value of h-atomic-address.  */
+
+SI
+or1k64bf_h_atomic_address_get (SIM_CPU *current_cpu)
+{
+  return CPU (h_atomic_address);
+}
+
+/* Set a value for h-atomic-address.  */
+
+void
+or1k64bf_h_atomic_address_set (SIM_CPU *current_cpu, SI newval)
+{
+  CPU (h_atomic_address) = newval;
+}
+
 /* Record trace results for INSN.  */
 
 void
diff --git a/sim/or1k/cpu64.h b/sim/or1k/cpu64.h
index 5bfbf9e..d3a93e7 100644
--- a/sim/or1k/cpu64.h
+++ b/sim/or1k/cpu64.h
@@ -53,6 +53,14 @@ typedef struct {
 do { \
 SET_H_SPR ((((index)) + (ORDI (SLLDI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_GPR0))), (x));\
 ;} while (0)
+  /* atomic reserve flag */
+  BI h_atomic_reserve;
+#define GET_H_ATOMIC_RESERVE() CPU (h_atomic_reserve)
+#define SET_H_ATOMIC_RESERVE(x) (CPU (h_atomic_reserve) = (x))
+  /* atomic reserve address */
+  SI h_atomic_address;
+#define GET_H_ATOMIC_ADDRESS() CPU (h_atomic_address)
+#define SET_H_ATOMIC_ADDRESS(x) (CPU (h_atomic_address) = (x))
   } hardware;
 #define CPU_CGEN_HW(cpu) (& (cpu)->cpu_data.hardware)
 } OR1K64BF_CPU_DATA;
@@ -4482,6 +4490,10 @@ UDI or1k64bf_h_sys_fpcsr_inf_get (SIM_CPU *);
 void or1k64bf_h_sys_fpcsr_inf_set (SIM_CPU *, UDI);
 UDI or1k64bf_h_sys_fpcsr_dzf_get (SIM_CPU *);
 void or1k64bf_h_sys_fpcsr_dzf_set (SIM_CPU *, UDI);
+BI or1k64bf_h_atomic_reserve_get (SIM_CPU *);
+void or1k64bf_h_atomic_reserve_set (SIM_CPU *, BI);
+SI or1k64bf_h_atomic_address_get (SIM_CPU *);
+void or1k64bf_h_atomic_address_set (SIM_CPU *, SI);
 
 /* These must be hand-written.  */
 extern CPUREG_FETCH_FN or1k64bf_fetch_register;
@@ -4621,6 +4633,17 @@ struct scache {
   f_resv_20_5 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
   f_uimm16 = EXTRACT_LSB0_UINT (insn, 32, 15, 16); \
 
+#define EXTRACT_IFMT_L_MSYNC_VARS \
+  UINT f_opcode; \
+  UINT f_op_25_5; \
+  UINT f_resv_20_21; \
+  unsigned int length;
+#define EXTRACT_IFMT_L_MSYNC_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_op_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_resv_20_21 = EXTRACT_LSB0_UINT (insn, 32, 20, 21); \
+
 #define EXTRACT_IFMT_L_RFE_VARS \
   UINT f_opcode; \
   UINT f_resv_25_26; \
@@ -4718,7 +4741,7 @@ struct scache {
 
 #define EXTRACT_IFMT_L_SW_VARS \
   UINT f_opcode; \
-  UINT f_r1; \
+  UINT f_r2; \
   UINT f_r3; \
   UINT f_imm16_25_5; \
   UINT f_imm16_10_11; \
@@ -4727,12 +4750,25 @@ struct scache {
 #define EXTRACT_IFMT_L_SW_CODE \
   length = 4; \
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
-  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
   f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
   f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
   f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11); \
   f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));\
 
+#define EXTRACT_IFMT_L_SWA_VARS \
+  UINT f_opcode; \
+  UINT f_r2; \
+  UINT f_r3; \
+  INT f_simm16; \
+  unsigned int length;
+#define EXTRACT_IFMT_L_SWA_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16); \
+
 #define EXTRACT_IFMT_L_SLL_VARS \
   UINT f_opcode; \
   UINT f_r1; \
diff --git a/sim/or1k/cpuall32.h b/sim/or1k/cpuall32.h
index 182bc74..7e792fa 100644
--- a/sim/or1k/cpuall32.h
+++ b/sim/or1k/cpuall32.h
@@ -33,8 +33,8 @@ This file is part of the GNU simulators.
 #include "decode.h"
 #endif
 
-extern const MACH or32_mach;
-extern const MACH or32nd_mach;
+extern const SIM_MACH or32_mach;
+extern const SIM_MACH or32nd_mach;
 
 #ifndef WANT_CPU
 /* The ARGBUF struct.  */
diff --git a/sim/or1k/cpuall64.h b/sim/or1k/cpuall64.h
index 8207d8b..7a58a18 100644
--- a/sim/or1k/cpuall64.h
+++ b/sim/or1k/cpuall64.h
@@ -33,8 +33,8 @@ This file is part of the GNU simulators.
 #include "decode64.h"
 #endif
 
-extern const MACH or64_mach;
-extern const MACH or64nd_mach;
+extern const SIM_MACH or64_mach;
+extern const SIM_MACH or64nd_mach;
 
 #ifndef WANT_CPU
 /* The ARGBUF struct.  */
diff --git a/sim/or1k/decode32.c b/sim/or1k/decode32.c
index 04b29f4..890a50b 100644
--- a/sim/or1k/decode32.c
+++ b/sim/or1k/decode32.c
@@ -54,7 +54,10 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_BF, OR1K32BF_INSN_L_BF, OR1K32BF_SFMT_L_BNF },
   { OR1K_INSN_L_TRAP, OR1K32BF_INSN_L_TRAP, OR1K32BF_SFMT_L_TRAP },
   { OR1K_INSN_L_SYS, OR1K32BF_INSN_L_SYS, OR1K32BF_SFMT_L_TRAP },
-  { OR1K_INSN_L_RFE, OR1K32BF_INSN_L_RFE, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_MSYNC, OR1K32BF_INSN_L_MSYNC, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_PSYNC, OR1K32BF_INSN_L_PSYNC, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CSYNC, OR1K32BF_INSN_L_CSYNC, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_RFE, OR1K32BF_INSN_L_RFE, OR1K32BF_SFMT_L_MSYNC },
   { OR1K_INSN_L_NOP_IMM, OR1K32BF_INSN_L_NOP_IMM, OR1K32BF_SFMT_L_NOP_IMM },
   { OR1K_INSN_L_MOVHI, OR1K32BF_INSN_L_MOVHI, OR1K32BF_SFMT_L_MOVHI },
   { OR1K_INSN_L_MACRC, OR1K32BF_INSN_L_MACRC, OR1K32BF_SFMT_L_MACRC },
@@ -62,6 +65,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_MTSPR, OR1K32BF_INSN_L_MTSPR, OR1K32BF_SFMT_L_MTSPR },
   { OR1K_INSN_L_LWZ, OR1K32BF_INSN_L_LWZ, OR1K32BF_SFMT_L_LWZ },
   { OR1K_INSN_L_LWS, OR1K32BF_INSN_L_LWS, OR1K32BF_SFMT_L_LWS },
+  { OR1K_INSN_L_LWA, OR1K32BF_INSN_L_LWA, OR1K32BF_SFMT_L_LWA },
   { OR1K_INSN_L_LBZ, OR1K32BF_INSN_L_LBZ, OR1K32BF_SFMT_L_LBZ },
   { OR1K_INSN_L_LBS, OR1K32BF_INSN_L_LBS, OR1K32BF_SFMT_L_LBS },
   { OR1K_INSN_L_LHZ, OR1K32BF_INSN_L_LHZ, OR1K32BF_SFMT_L_LHZ },
@@ -69,6 +73,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_SW, OR1K32BF_INSN_L_SW, OR1K32BF_SFMT_L_SW },
   { OR1K_INSN_L_SB, OR1K32BF_INSN_L_SB, OR1K32BF_SFMT_L_SB },
   { OR1K_INSN_L_SH, OR1K32BF_INSN_L_SH, OR1K32BF_SFMT_L_SH },
+  { OR1K_INSN_L_SWA, OR1K32BF_INSN_L_SWA, OR1K32BF_SFMT_L_SWA },
   { OR1K_INSN_L_SLL, OR1K32BF_INSN_L_SLL, OR1K32BF_SFMT_L_SLL },
   { OR1K_INSN_L_SLLI, OR1K32BF_INSN_L_SLLI, OR1K32BF_SFMT_L_SLLI },
   { OR1K_INSN_L_SRL, OR1K32BF_INSN_L_SRL, OR1K32BF_SFMT_L_SLL },
@@ -125,14 +130,14 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_MAC, OR1K32BF_INSN_L_MAC, OR1K32BF_SFMT_L_MAC },
   { OR1K_INSN_L_MSB, OR1K32BF_INSN_L_MSB, OR1K32BF_SFMT_L_MAC },
   { OR1K_INSN_L_MACI, OR1K32BF_INSN_L_MACI, OR1K32BF_SFMT_L_MACI },
-  { OR1K_INSN_L_CUST1, OR1K32BF_INSN_L_CUST1, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST2, OR1K32BF_INSN_L_CUST2, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST3, OR1K32BF_INSN_L_CUST3, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST4, OR1K32BF_INSN_L_CUST4, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST5, OR1K32BF_INSN_L_CUST5, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST6, OR1K32BF_INSN_L_CUST6, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST7, OR1K32BF_INSN_L_CUST7, OR1K32BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST8, OR1K32BF_INSN_L_CUST8, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST1, OR1K32BF_INSN_L_CUST1, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST2, OR1K32BF_INSN_L_CUST2, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST3, OR1K32BF_INSN_L_CUST3, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST4, OR1K32BF_INSN_L_CUST4, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST5, OR1K32BF_INSN_L_CUST5, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST6, OR1K32BF_INSN_L_CUST6, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST7, OR1K32BF_INSN_L_CUST7, OR1K32BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST8, OR1K32BF_INSN_L_CUST8, OR1K32BF_SFMT_L_MSYNC },
   { OR1K_INSN_LF_ADD_S, OR1K32BF_INSN_LF_ADD_S, OR1K32BF_SFMT_LF_ADD_S },
   { OR1K_INSN_LF_SUB_S, OR1K32BF_INSN_LF_SUB_S, OR1K32BF_SFMT_LF_ADD_S },
   { OR1K_INSN_LF_MUL_S, OR1K32BF_INSN_LF_MUL_S, OR1K32BF_SFMT_LF_ADD_S },
@@ -147,7 +152,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_LF_LT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_SFMT_LF_EQ_S },
   { OR1K_INSN_LF_LE_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_SFMT_LF_EQ_S },
   { OR1K_INSN_LF_MADD_S, OR1K32BF_INSN_LF_MADD_S, OR1K32BF_SFMT_LF_MADD_S },
-  { OR1K_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_SFMT_L_RFE },
+  { OR1K_INSN_LF_CUST1_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_SFMT_L_MSYNC },
 };
 
 static const struct insn_sem or1k32bf_insn_sem_invalid =
@@ -441,7 +446,34 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         if ((entire_insn & 0xfc1f0000) == 0x18000000)
           { itype = OR1K32BF_INSN_L_MOVHI; goto extract_sfmt_l_movhi; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
-      case 256 : /* fall through */
+      case 256 :
+        {
+          unsigned int val = (((insn >> 23) & (7 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffff0000) == 0x20000000)
+              { itype = OR1K32BF_INSN_L_SYS; goto extract_sfmt_l_trap; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 2 :
+            if ((entire_insn & 0xffff0000) == 0x21000000)
+              { itype = OR1K32BF_INSN_L_TRAP; goto extract_sfmt_l_trap; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 4 :
+            if ((entire_insn & 0xffffffff) == 0x22000000)
+              { itype = OR1K32BF_INSN_L_MSYNC; goto extract_sfmt_l_msync; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 5 :
+            if ((entire_insn & 0xffffffff) == 0x22800000)
+              { itype = OR1K32BF_INSN_L_PSYNC; goto extract_sfmt_l_msync; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 6 :
+            if ((entire_insn & 0xffffffff) == 0x23000000)
+              { itype = OR1K32BF_INSN_L_CSYNC; goto extract_sfmt_l_msync; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 257 : /* fall through */
       case 258 : /* fall through */
       case 259 : /* fall through */
@@ -490,7 +522,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         }
       case 288 :
         if ((entire_insn & 0xffffffff) == 0x24000000)
-          { itype = OR1K32BF_INSN_L_RFE; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_RFE; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 544 :
         if ((entire_insn & 0xffff07ff) == 0x44000000)
@@ -535,21 +567,53 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         if ((entire_insn & 0xffe00000) == 0x4c000000)
           { itype = OR1K32BF_INSN_L_MACI; goto extract_sfmt_l_maci; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 864 : /* fall through */
+      case 865 : /* fall through */
+      case 866 : /* fall through */
+      case 867 : /* fall through */
+      case 868 : /* fall through */
+      case 869 : /* fall through */
+      case 870 : /* fall through */
+      case 871 : /* fall through */
+      case 872 : /* fall through */
+      case 873 : /* fall through */
+      case 874 : /* fall through */
+      case 875 : /* fall through */
+      case 876 : /* fall through */
+      case 877 : /* fall through */
+      case 878 : /* fall through */
+      case 879 : /* fall through */
+      case 880 : /* fall through */
+      case 881 : /* fall through */
+      case 882 : /* fall through */
+      case 883 : /* fall through */
+      case 884 : /* fall through */
+      case 885 : /* fall through */
+      case 886 : /* fall through */
+      case 887 : /* fall through */
+      case 888 : /* fall through */
+      case 889 : /* fall through */
+      case 890 : /* fall through */
+      case 891 : /* fall through */
+      case 892 : /* fall through */
+      case 893 : /* fall through */
+      case 894 : /* fall through */
+      case 895 : itype = OR1K32BF_INSN_L_LWA; goto extract_sfmt_l_lwa;
       case 896 :
         if ((entire_insn & 0xffffffff) == 0x70000000)
-          { itype = OR1K32BF_INSN_L_CUST1; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST1; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 928 :
         if ((entire_insn & 0xffffffff) == 0x74000000)
-          { itype = OR1K32BF_INSN_L_CUST2; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST2; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 960 :
         if ((entire_insn & 0xffffffff) == 0x78000000)
-          { itype = OR1K32BF_INSN_L_CUST3; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST3; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 992 :
         if ((entire_insn & 0xffffffff) == 0x7c000000)
-          { itype = OR1K32BF_INSN_L_CUST4; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST4; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1056 : /* fall through */
       case 1057 : /* fall through */
@@ -1206,8 +1270,40 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1616 :
         if ((entire_insn & 0xffe007ff) == 0xc80000d0)
-          { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_LF_CUST1_S; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1632 : /* fall through */
+      case 1633 : /* fall through */
+      case 1634 : /* fall through */
+      case 1635 : /* fall through */
+      case 1636 : /* fall through */
+      case 1637 : /* fall through */
+      case 1638 : /* fall through */
+      case 1639 : /* fall through */
+      case 1640 : /* fall through */
+      case 1641 : /* fall through */
+      case 1642 : /* fall through */
+      case 1643 : /* fall through */
+      case 1644 : /* fall through */
+      case 1645 : /* fall through */
+      case 1646 : /* fall through */
+      case 1647 : /* fall through */
+      case 1648 : /* fall through */
+      case 1649 : /* fall through */
+      case 1650 : /* fall through */
+      case 1651 : /* fall through */
+      case 1652 : /* fall through */
+      case 1653 : /* fall through */
+      case 1654 : /* fall through */
+      case 1655 : /* fall through */
+      case 1656 : /* fall through */
+      case 1657 : /* fall through */
+      case 1658 : /* fall through */
+      case 1659 : /* fall through */
+      case 1660 : /* fall through */
+      case 1661 : /* fall through */
+      case 1662 : /* fall through */
+      case 1663 : itype = OR1K32BF_INSN_L_SWA; goto extract_sfmt_l_swa;
       case 1696 : /* fall through */
       case 1697 : /* fall through */
       case 1698 : /* fall through */
@@ -1486,19 +1582,19 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         }
       case 1920 :
         if ((entire_insn & 0xffffffff) == 0xf0000000)
-          { itype = OR1K32BF_INSN_L_CUST5; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST5; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1952 :
         if ((entire_insn & 0xffffffff) == 0xf4000000)
-          { itype = OR1K32BF_INSN_L_CUST6; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST6; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1984 :
         if ((entire_insn & 0xffffffff) == 0xf8000000)
-          { itype = OR1K32BF_INSN_L_CUST7; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST7; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 2016 :
         if ((entire_insn & 0xffffffff) == 0xfc000000)
-          { itype = OR1K32BF_INSN_L_CUST8; goto extract_sfmt_l_rfe; }
+          { itype = OR1K32BF_INSN_L_CUST8; goto extract_sfmt_l_msync; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       }
@@ -1618,14 +1714,14 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_l_rfe:
+ extract_sfmt_l_msync:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
 #define FLD(f) abuf->fields.sfmt_empty.f
 
 
   /* Record the fields for the semantic handler.  */
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_rfe", (char *) 0));
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_msync", (char *) 0));
 
 #undef FLD
     return idesc;
@@ -1781,6 +1877,29 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
+ extract_sfmt_l_lwa:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+    UINT f_r1;
+    UINT f_r2;
+    INT f_simm16;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_simm16) = f_simm16;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_lwa", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
  extract_sfmt_l_lbz:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
@@ -1954,6 +2073,33 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
+ extract_sfmt_l_swa:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sw.f
+    UINT f_imm16_25_5;
+    UINT f_r2;
+    UINT f_r3;
+    UINT f_imm16_10_11;
+    INT f_simm16_split;
+
+    f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+    f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11);
+  f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_simm16_split) = f_simm16_split;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_swa", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_simm16_split 0x%x", 'x', f_simm16_split, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
  extract_sfmt_l_sll:
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
diff --git a/sim/or1k/decode32.h b/sim/or1k/decode32.h
index a854856..5511bcc 100644
--- a/sim/or1k/decode32.h
+++ b/sim/or1k/decode32.h
@@ -37,46 +37,48 @@ typedef enum or1k32bf_insn_type {
   OR1K32BF_INSN_X_INVALID, OR1K32BF_INSN_X_AFTER, OR1K32BF_INSN_X_BEFORE, OR1K32BF_INSN_X_CTI_CHAIN
  , OR1K32BF_INSN_X_CHAIN, OR1K32BF_INSN_X_BEGIN, OR1K32BF_INSN_L_J, OR1K32BF_INSN_L_JAL
  , OR1K32BF_INSN_L_JR, OR1K32BF_INSN_L_JALR, OR1K32BF_INSN_L_BNF, OR1K32BF_INSN_L_BF
- , OR1K32BF_INSN_L_TRAP, OR1K32BF_INSN_L_SYS, OR1K32BF_INSN_L_RFE, OR1K32BF_INSN_L_NOP_IMM
- , OR1K32BF_INSN_L_MOVHI, OR1K32BF_INSN_L_MACRC, OR1K32BF_INSN_L_MFSPR, OR1K32BF_INSN_L_MTSPR
- , OR1K32BF_INSN_L_LWZ, OR1K32BF_INSN_L_LWS, OR1K32BF_INSN_L_LBZ, OR1K32BF_INSN_L_LBS
+ , OR1K32BF_INSN_L_TRAP, OR1K32BF_INSN_L_SYS, OR1K32BF_INSN_L_MSYNC, OR1K32BF_INSN_L_PSYNC
+ , OR1K32BF_INSN_L_CSYNC, OR1K32BF_INSN_L_RFE, OR1K32BF_INSN_L_NOP_IMM, OR1K32BF_INSN_L_MOVHI
+ , OR1K32BF_INSN_L_MACRC, OR1K32BF_INSN_L_MFSPR, OR1K32BF_INSN_L_MTSPR, OR1K32BF_INSN_L_LWZ
+ , OR1K32BF_INSN_L_LWS, OR1K32BF_INSN_L_LWA, OR1K32BF_INSN_L_LBZ, OR1K32BF_INSN_L_LBS
  , OR1K32BF_INSN_L_LHZ, OR1K32BF_INSN_L_LHS, OR1K32BF_INSN_L_SW, OR1K32BF_INSN_L_SB
- , OR1K32BF_INSN_L_SH, OR1K32BF_INSN_L_SLL, OR1K32BF_INSN_L_SLLI, OR1K32BF_INSN_L_SRL
- , OR1K32BF_INSN_L_SRLI, OR1K32BF_INSN_L_SRA, OR1K32BF_INSN_L_SRAI, OR1K32BF_INSN_L_ROR
- , OR1K32BF_INSN_L_RORI, OR1K32BF_INSN_L_AND, OR1K32BF_INSN_L_OR, OR1K32BF_INSN_L_XOR
- , OR1K32BF_INSN_L_ADD, OR1K32BF_INSN_L_SUB, OR1K32BF_INSN_L_ADDC, OR1K32BF_INSN_L_MUL
- , OR1K32BF_INSN_L_MULU, OR1K32BF_INSN_L_DIV, OR1K32BF_INSN_L_DIVU, OR1K32BF_INSN_L_FF1
- , OR1K32BF_INSN_L_FL1, OR1K32BF_INSN_L_ANDI, OR1K32BF_INSN_L_ORI, OR1K32BF_INSN_L_XORI
- , OR1K32BF_INSN_L_ADDI, OR1K32BF_INSN_L_ADDIC, OR1K32BF_INSN_L_MULI, OR1K32BF_INSN_L_EXTHS
- , OR1K32BF_INSN_L_EXTBS, OR1K32BF_INSN_L_EXTHZ, OR1K32BF_INSN_L_EXTBZ, OR1K32BF_INSN_L_EXTWS
- , OR1K32BF_INSN_L_EXTWZ, OR1K32BF_INSN_L_CMOV, OR1K32BF_INSN_L_SFGTS, OR1K32BF_INSN_L_SFGTSI
- , OR1K32BF_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGES, OR1K32BF_INSN_L_SFGESI
- , OR1K32BF_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFLTS, OR1K32BF_INSN_L_SFLTSI
- , OR1K32BF_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLES, OR1K32BF_INSN_L_SFLESI
- , OR1K32BF_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFEQ, OR1K32BF_INSN_L_SFEQI
- , OR1K32BF_INSN_L_SFNE, OR1K32BF_INSN_L_SFNEI, OR1K32BF_INSN_L_MAC, OR1K32BF_INSN_L_MSB
- , OR1K32BF_INSN_L_MACI, OR1K32BF_INSN_L_CUST1, OR1K32BF_INSN_L_CUST2, OR1K32BF_INSN_L_CUST3
- , OR1K32BF_INSN_L_CUST4, OR1K32BF_INSN_L_CUST5, OR1K32BF_INSN_L_CUST6, OR1K32BF_INSN_L_CUST7
- , OR1K32BF_INSN_L_CUST8, OR1K32BF_INSN_LF_ADD_S, OR1K32BF_INSN_LF_SUB_S, OR1K32BF_INSN_LF_MUL_S
- , OR1K32BF_INSN_LF_DIV_S, OR1K32BF_INSN_LF_REM_S, OR1K32BF_INSN_LF_ITOF_S, OR1K32BF_INSN_LF_FTOI_S
- , OR1K32BF_INSN_LF_EQ_S, OR1K32BF_INSN_LF_NE_S, OR1K32BF_INSN_LF_GE_S, OR1K32BF_INSN_LF_GT_S
- , OR1K32BF_INSN_LF_LT_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_INSN_LF_MADD_S, OR1K32BF_INSN_LF_CUST1_S
- , OR1K32BF_INSN__MAX
+ , OR1K32BF_INSN_L_SH, OR1K32BF_INSN_L_SWA, OR1K32BF_INSN_L_SLL, OR1K32BF_INSN_L_SLLI
+ , OR1K32BF_INSN_L_SRL, OR1K32BF_INSN_L_SRLI, OR1K32BF_INSN_L_SRA, OR1K32BF_INSN_L_SRAI
+ , OR1K32BF_INSN_L_ROR, OR1K32BF_INSN_L_RORI, OR1K32BF_INSN_L_AND, OR1K32BF_INSN_L_OR
+ , OR1K32BF_INSN_L_XOR, OR1K32BF_INSN_L_ADD, OR1K32BF_INSN_L_SUB, OR1K32BF_INSN_L_ADDC
+ , OR1K32BF_INSN_L_MUL, OR1K32BF_INSN_L_MULU, OR1K32BF_INSN_L_DIV, OR1K32BF_INSN_L_DIVU
+ , OR1K32BF_INSN_L_FF1, OR1K32BF_INSN_L_FL1, OR1K32BF_INSN_L_ANDI, OR1K32BF_INSN_L_ORI
+ , OR1K32BF_INSN_L_XORI, OR1K32BF_INSN_L_ADDI, OR1K32BF_INSN_L_ADDIC, OR1K32BF_INSN_L_MULI
+ , OR1K32BF_INSN_L_EXTHS, OR1K32BF_INSN_L_EXTBS, OR1K32BF_INSN_L_EXTHZ, OR1K32BF_INSN_L_EXTBZ
+ , OR1K32BF_INSN_L_EXTWS, OR1K32BF_INSN_L_EXTWZ, OR1K32BF_INSN_L_CMOV, OR1K32BF_INSN_L_SFGTS
+ , OR1K32BF_INSN_L_SFGTSI, OR1K32BF_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGES
+ , OR1K32BF_INSN_L_SFGESI, OR1K32BF_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFLTS
+ , OR1K32BF_INSN_L_SFLTSI, OR1K32BF_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLES
+ , OR1K32BF_INSN_L_SFLESI, OR1K32BF_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFEQ
+ , OR1K32BF_INSN_L_SFEQI, OR1K32BF_INSN_L_SFNE, OR1K32BF_INSN_L_SFNEI, OR1K32BF_INSN_L_MAC
+ , OR1K32BF_INSN_L_MSB, OR1K32BF_INSN_L_MACI, OR1K32BF_INSN_L_CUST1, OR1K32BF_INSN_L_CUST2
+ , OR1K32BF_INSN_L_CUST3, OR1K32BF_INSN_L_CUST4, OR1K32BF_INSN_L_CUST5, OR1K32BF_INSN_L_CUST6
+ , OR1K32BF_INSN_L_CUST7, OR1K32BF_INSN_L_CUST8, OR1K32BF_INSN_LF_ADD_S, OR1K32BF_INSN_LF_SUB_S
+ , OR1K32BF_INSN_LF_MUL_S, OR1K32BF_INSN_LF_DIV_S, OR1K32BF_INSN_LF_REM_S, OR1K32BF_INSN_LF_ITOF_S
+ , OR1K32BF_INSN_LF_FTOI_S, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_INSN_LF_NE_S, OR1K32BF_INSN_LF_GE_S
+ , OR1K32BF_INSN_LF_GT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_INSN_LF_MADD_S
+ , OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_INSN__MAX
 } OR1K32BF_INSN_TYPE;
 
 /* Enum declaration for semantic formats in cpu family or1k32bf.  */
 typedef enum or1k32bf_sfmt_type {
   OR1K32BF_SFMT_EMPTY, OR1K32BF_SFMT_L_J, OR1K32BF_SFMT_L_JAL, OR1K32BF_SFMT_L_JR
- , OR1K32BF_SFMT_L_JALR, OR1K32BF_SFMT_L_BNF, OR1K32BF_SFMT_L_TRAP, OR1K32BF_SFMT_L_RFE
+ , OR1K32BF_SFMT_L_JALR, OR1K32BF_SFMT_L_BNF, OR1K32BF_SFMT_L_TRAP, OR1K32BF_SFMT_L_MSYNC
  , OR1K32BF_SFMT_L_NOP_IMM, OR1K32BF_SFMT_L_MOVHI, OR1K32BF_SFMT_L_MACRC, OR1K32BF_SFMT_L_MFSPR
- , OR1K32BF_SFMT_L_MTSPR, OR1K32BF_SFMT_L_LWZ, OR1K32BF_SFMT_L_LWS, OR1K32BF_SFMT_L_LBZ
- , OR1K32BF_SFMT_L_LBS, OR1K32BF_SFMT_L_LHZ, OR1K32BF_SFMT_L_LHS, OR1K32BF_SFMT_L_SW
- , OR1K32BF_SFMT_L_SB, OR1K32BF_SFMT_L_SH, OR1K32BF_SFMT_L_SLL, OR1K32BF_SFMT_L_SLLI
- , OR1K32BF_SFMT_L_AND, OR1K32BF_SFMT_L_ADD, OR1K32BF_SFMT_L_ADDC, OR1K32BF_SFMT_L_DIV
- , OR1K32BF_SFMT_L_FF1, OR1K32BF_SFMT_L_XORI, OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC
- , OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV, OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI
- , OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI, OR1K32BF_SFMT_LF_ADD_S, OR1K32BF_SFMT_LF_ITOF_S
- , OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S, OR1K32BF_SFMT_LF_MADD_S
+ , OR1K32BF_SFMT_L_MTSPR, OR1K32BF_SFMT_L_LWZ, OR1K32BF_SFMT_L_LWS, OR1K32BF_SFMT_L_LWA
+ , OR1K32BF_SFMT_L_LBZ, OR1K32BF_SFMT_L_LBS, OR1K32BF_SFMT_L_LHZ, OR1K32BF_SFMT_L_LHS
+ , OR1K32BF_SFMT_L_SW, OR1K32BF_SFMT_L_SB, OR1K32BF_SFMT_L_SH, OR1K32BF_SFMT_L_SWA
+ , OR1K32BF_SFMT_L_SLL, OR1K32BF_SFMT_L_SLLI, OR1K32BF_SFMT_L_AND, OR1K32BF_SFMT_L_ADD
+ , OR1K32BF_SFMT_L_ADDC, OR1K32BF_SFMT_L_DIV, OR1K32BF_SFMT_L_FF1, OR1K32BF_SFMT_L_XORI
+ , OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC, OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV
+ , OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI, OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI
+ , OR1K32BF_SFMT_LF_ADD_S, OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S
+ , OR1K32BF_SFMT_LF_MADD_S
 } OR1K32BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/decode64.c b/sim/or1k/decode64.c
index 752fa13..4065010 100644
--- a/sim/or1k/decode64.c
+++ b/sim/or1k/decode64.c
@@ -54,7 +54,10 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_BF, OR1K64BF_INSN_L_BF, OR1K64BF_SFMT_L_BNF },
   { OR1K_INSN_L_TRAP, OR1K64BF_INSN_L_TRAP, OR1K64BF_SFMT_L_TRAP },
   { OR1K_INSN_L_SYS, OR1K64BF_INSN_L_SYS, OR1K64BF_SFMT_L_TRAP },
-  { OR1K_INSN_L_RFE, OR1K64BF_INSN_L_RFE, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_MSYNC, OR1K64BF_INSN_L_MSYNC, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_PSYNC, OR1K64BF_INSN_L_PSYNC, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CSYNC, OR1K64BF_INSN_L_CSYNC, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_RFE, OR1K64BF_INSN_L_RFE, OR1K64BF_SFMT_L_MSYNC },
   { OR1K_INSN_L_NOP_IMM, OR1K64BF_INSN_L_NOP_IMM, OR1K64BF_SFMT_L_NOP_IMM },
   { OR1K_INSN_L_MOVHI, OR1K64BF_INSN_L_MOVHI, OR1K64BF_SFMT_L_MOVHI },
   { OR1K_INSN_L_MACRC, OR1K64BF_INSN_L_MACRC, OR1K64BF_SFMT_L_MACRC },
@@ -62,6 +65,7 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_MTSPR, OR1K64BF_INSN_L_MTSPR, OR1K64BF_SFMT_L_MTSPR },
   { OR1K_INSN_L_LWZ, OR1K64BF_INSN_L_LWZ, OR1K64BF_SFMT_L_LWZ },
   { OR1K_INSN_L_LWS, OR1K64BF_INSN_L_LWS, OR1K64BF_SFMT_L_LWS },
+  { OR1K_INSN_L_LWA, OR1K64BF_INSN_L_LWA, OR1K64BF_SFMT_L_LWA },
   { OR1K_INSN_L_LBZ, OR1K64BF_INSN_L_LBZ, OR1K64BF_SFMT_L_LBZ },
   { OR1K_INSN_L_LBS, OR1K64BF_INSN_L_LBS, OR1K64BF_SFMT_L_LBS },
   { OR1K_INSN_L_LHZ, OR1K64BF_INSN_L_LHZ, OR1K64BF_SFMT_L_LHZ },
@@ -69,6 +73,7 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_SW, OR1K64BF_INSN_L_SW, OR1K64BF_SFMT_L_SW },
   { OR1K_INSN_L_SB, OR1K64BF_INSN_L_SB, OR1K64BF_SFMT_L_SB },
   { OR1K_INSN_L_SH, OR1K64BF_INSN_L_SH, OR1K64BF_SFMT_L_SH },
+  { OR1K_INSN_L_SWA, OR1K64BF_INSN_L_SWA, OR1K64BF_SFMT_L_SWA },
   { OR1K_INSN_L_SLL, OR1K64BF_INSN_L_SLL, OR1K64BF_SFMT_L_SLL },
   { OR1K_INSN_L_SLLI, OR1K64BF_INSN_L_SLLI, OR1K64BF_SFMT_L_SLLI },
   { OR1K_INSN_L_SRL, OR1K64BF_INSN_L_SRL, OR1K64BF_SFMT_L_SLL },
@@ -125,14 +130,14 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_L_MAC, OR1K64BF_INSN_L_MAC, OR1K64BF_SFMT_L_MAC },
   { OR1K_INSN_L_MSB, OR1K64BF_INSN_L_MSB, OR1K64BF_SFMT_L_MAC },
   { OR1K_INSN_L_MACI, OR1K64BF_INSN_L_MACI, OR1K64BF_SFMT_L_MACI },
-  { OR1K_INSN_L_CUST1, OR1K64BF_INSN_L_CUST1, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST2, OR1K64BF_INSN_L_CUST2, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST3, OR1K64BF_INSN_L_CUST3, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST4, OR1K64BF_INSN_L_CUST4, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST5, OR1K64BF_INSN_L_CUST5, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST6, OR1K64BF_INSN_L_CUST6, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST7, OR1K64BF_INSN_L_CUST7, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_L_CUST8, OR1K64BF_INSN_L_CUST8, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_L_CUST1, OR1K64BF_INSN_L_CUST1, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST2, OR1K64BF_INSN_L_CUST2, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST3, OR1K64BF_INSN_L_CUST3, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST4, OR1K64BF_INSN_L_CUST4, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST5, OR1K64BF_INSN_L_CUST5, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST6, OR1K64BF_INSN_L_CUST6, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST7, OR1K64BF_INSN_L_CUST7, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_L_CUST8, OR1K64BF_INSN_L_CUST8, OR1K64BF_SFMT_L_MSYNC },
   { OR1K_INSN_LF_ADD_S, OR1K64BF_INSN_LF_ADD_S, OR1K64BF_SFMT_LF_ADD_S },
   { OR1K_INSN_LF_ADD_D, OR1K64BF_INSN_LF_ADD_D, OR1K64BF_SFMT_LF_ADD_D },
   { OR1K_INSN_LF_SUB_S, OR1K64BF_INSN_LF_SUB_S, OR1K64BF_SFMT_LF_ADD_S },
@@ -161,8 +166,8 @@ static const struct insn_sem or1k64bf_insn_sem[] =
   { OR1K_INSN_LF_LE_D, OR1K64BF_INSN_LF_LE_D, OR1K64BF_SFMT_LF_EQ_D },
   { OR1K_INSN_LF_MADD_S, OR1K64BF_INSN_LF_MADD_S, OR1K64BF_SFMT_LF_MADD_S },
   { OR1K_INSN_LF_MADD_D, OR1K64BF_INSN_LF_MADD_D, OR1K64BF_SFMT_LF_MADD_D },
-  { OR1K_INSN_LF_CUST1_S, OR1K64BF_INSN_LF_CUST1_S, OR1K64BF_SFMT_L_RFE },
-  { OR1K_INSN_LF_CUST1_D, OR1K64BF_INSN_LF_CUST1_D, OR1K64BF_SFMT_L_RFE },
+  { OR1K_INSN_LF_CUST1_S, OR1K64BF_INSN_LF_CUST1_S, OR1K64BF_SFMT_L_MSYNC },
+  { OR1K_INSN_LF_CUST1_D, OR1K64BF_INSN_LF_CUST1_D, OR1K64BF_SFMT_L_MSYNC },
 };
 
 static const struct insn_sem or1k64bf_insn_sem_invalid =
@@ -456,7 +461,34 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
         if ((entire_insn & 0xfc1f0000) == 0x18000000)
           { itype = OR1K64BF_INSN_L_MOVHI; goto extract_sfmt_l_movhi; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
-      case 256 : /* fall through */
+      case 256 :
+        {
+          unsigned int val = (((insn >> 23) & (7 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xffff0000) == 0x20000000)
+              { itype = OR1K64BF_INSN_L_SYS; goto extract_sfmt_l_trap; }
+            itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 2 :
+            if ((entire_insn & 0xffff0000) == 0x21000000)
+              { itype = OR1K64BF_INSN_L_TRAP; goto extract_sfmt_l_trap; }
+            itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 4 :
+            if ((entire_insn & 0xffffffff) == 0x22000000)
+              { itype = OR1K64BF_INSN_L_MSYNC; goto extract_sfmt_l_msync; }
+            itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 5 :
+            if ((entire_insn & 0xffffffff) == 0x22800000)
+              { itype = OR1K64BF_INSN_L_PSYNC; goto extract_sfmt_l_msync; }
+            itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 6 :
+            if ((entire_insn & 0xffffffff) == 0x23000000)
+              { itype = OR1K64BF_INSN_L_CSYNC; goto extract_sfmt_l_msync; }
+            itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 257 : /* fall through */
       case 258 : /* fall through */
       case 259 : /* fall through */
@@ -505,7 +537,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
         }
       case 288 :
         if ((entire_insn & 0xffffffff) == 0x24000000)
-          { itype = OR1K64BF_INSN_L_RFE; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_RFE; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 544 :
         if ((entire_insn & 0xffff07ff) == 0x44000000)
@@ -550,21 +582,53 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
         if ((entire_insn & 0xffe00000) == 0x4c000000)
           { itype = OR1K64BF_INSN_L_MACI; goto extract_sfmt_l_maci; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 864 : /* fall through */
+      case 865 : /* fall through */
+      case 866 : /* fall through */
+      case 867 : /* fall through */
+      case 868 : /* fall through */
+      case 869 : /* fall through */
+      case 870 : /* fall through */
+      case 871 : /* fall through */
+      case 872 : /* fall through */
+      case 873 : /* fall through */
+      case 874 : /* fall through */
+      case 875 : /* fall through */
+      case 876 : /* fall through */
+      case 877 : /* fall through */
+      case 878 : /* fall through */
+      case 879 : /* fall through */
+      case 880 : /* fall through */
+      case 881 : /* fall through */
+      case 882 : /* fall through */
+      case 883 : /* fall through */
+      case 884 : /* fall through */
+      case 885 : /* fall through */
+      case 886 : /* fall through */
+      case 887 : /* fall through */
+      case 888 : /* fall through */
+      case 889 : /* fall through */
+      case 890 : /* fall through */
+      case 891 : /* fall through */
+      case 892 : /* fall through */
+      case 893 : /* fall through */
+      case 894 : /* fall through */
+      case 895 : itype = OR1K64BF_INSN_L_LWA; goto extract_sfmt_l_lwa;
       case 896 :
         if ((entire_insn & 0xffffffff) == 0x70000000)
-          { itype = OR1K64BF_INSN_L_CUST1; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST1; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 928 :
         if ((entire_insn & 0xffffffff) == 0x74000000)
-          { itype = OR1K64BF_INSN_L_CUST2; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST2; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 960 :
         if ((entire_insn & 0xffffffff) == 0x78000000)
-          { itype = OR1K64BF_INSN_L_CUST3; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST3; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 992 :
         if ((entire_insn & 0xffffffff) == 0x7c000000)
-          { itype = OR1K64BF_INSN_L_CUST4; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST4; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1056 : /* fall through */
       case 1057 : /* fall through */
@@ -1167,7 +1231,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 7 :
             if ((entire_insn & 0xffe007ff) == 0xc80000e0)
-              { itype = OR1K64BF_INSN_LF_CUST1_D; goto extract_sfmt_l_rfe; }
+              { itype = OR1K64BF_INSN_LF_CUST1_D; goto extract_sfmt_l_msync; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
@@ -1235,7 +1299,7 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           case 3 :
             if ((entire_insn & 0xffe007ff) == 0xc80000d0)
-              { itype = OR1K64BF_INSN_LF_CUST1_S; goto extract_sfmt_l_rfe; }
+              { itype = OR1K64BF_INSN_LF_CUST1_S; goto extract_sfmt_l_msync; }
             itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
           }
@@ -1292,6 +1356,38 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
         if ((entire_insn & 0xffe007ff) == 0xc800001d)
           { itype = OR1K64BF_INSN_LF_LE_D; goto extract_sfmt_lf_eq_d; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1632 : /* fall through */
+      case 1633 : /* fall through */
+      case 1634 : /* fall through */
+      case 1635 : /* fall through */
+      case 1636 : /* fall through */
+      case 1637 : /* fall through */
+      case 1638 : /* fall through */
+      case 1639 : /* fall through */
+      case 1640 : /* fall through */
+      case 1641 : /* fall through */
+      case 1642 : /* fall through */
+      case 1643 : /* fall through */
+      case 1644 : /* fall through */
+      case 1645 : /* fall through */
+      case 1646 : /* fall through */
+      case 1647 : /* fall through */
+      case 1648 : /* fall through */
+      case 1649 : /* fall through */
+      case 1650 : /* fall through */
+      case 1651 : /* fall through */
+      case 1652 : /* fall through */
+      case 1653 : /* fall through */
+      case 1654 : /* fall through */
+      case 1655 : /* fall through */
+      case 1656 : /* fall through */
+      case 1657 : /* fall through */
+      case 1658 : /* fall through */
+      case 1659 : /* fall through */
+      case 1660 : /* fall through */
+      case 1661 : /* fall through */
+      case 1662 : /* fall through */
+      case 1663 : itype = OR1K64BF_INSN_L_SWA; goto extract_sfmt_l_swa;
       case 1696 : /* fall through */
       case 1697 : /* fall through */
       case 1698 : /* fall through */
@@ -1562,19 +1658,19 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
         }
       case 1920 :
         if ((entire_insn & 0xffffffff) == 0xf0000000)
-          { itype = OR1K64BF_INSN_L_CUST5; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST5; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1952 :
         if ((entire_insn & 0xffffffff) == 0xf4000000)
-          { itype = OR1K64BF_INSN_L_CUST6; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST6; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1984 :
         if ((entire_insn & 0xffffffff) == 0xf8000000)
-          { itype = OR1K64BF_INSN_L_CUST7; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST7; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 2016 :
         if ((entire_insn & 0xffffffff) == 0xfc000000)
-          { itype = OR1K64BF_INSN_L_CUST8; goto extract_sfmt_l_rfe; }
+          { itype = OR1K64BF_INSN_L_CUST8; goto extract_sfmt_l_msync; }
         itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       default : itype = OR1K64BF_INSN_X_INVALID; goto extract_sfmt_empty;
       }
@@ -1694,14 +1790,14 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
- extract_sfmt_l_rfe:
+ extract_sfmt_l_msync:
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
 #define FLD(f) abuf->fields.sfmt_empty.f
 
 
   /* Record the fields for the semantic handler.  */
-  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_rfe", (char *) 0));
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_msync", (char *) 0));
 
 #undef FLD
     return idesc;
@@ -1857,6 +1953,29 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
+ extract_sfmt_l_lwa:
+  {
+    const IDESC *idesc = &or1k64bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+    UINT f_r1;
+    UINT f_r2;
+    INT f_simm16;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_simm16) = f_simm16;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_lwa", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
  extract_sfmt_l_lbz:
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
@@ -2030,6 +2149,33 @@ or1k64bf_decode (SIM_CPU *current_cpu, IADDR pc,
     return idesc;
   }
 
+ extract_sfmt_l_swa:
+  {
+    const IDESC *idesc = &or1k64bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sw.f
+    UINT f_imm16_25_5;
+    UINT f_r2;
+    UINT f_r3;
+    UINT f_imm16_10_11;
+    INT f_simm16_split;
+
+    f_imm16_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+    f_imm16_10_11 = EXTRACT_LSB0_UINT (insn, 32, 10, 11);
+  f_simm16_split = ((HI) (UINT) (((((f_imm16_25_5) << (11))) | (f_imm16_10_11))));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_simm16_split) = f_simm16_split;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_swa", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_simm16_split 0x%x", 'x', f_simm16_split, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
  extract_sfmt_l_sll:
   {
     const IDESC *idesc = &or1k64bf_insn_data[itype];
diff --git a/sim/or1k/decode64.h b/sim/or1k/decode64.h
index db5f56f..b43e6ee 100644
--- a/sim/or1k/decode64.h
+++ b/sim/or1k/decode64.h
@@ -37,50 +37,53 @@ typedef enum or1k64bf_insn_type {
   OR1K64BF_INSN_X_INVALID, OR1K64BF_INSN_X_AFTER, OR1K64BF_INSN_X_BEFORE, OR1K64BF_INSN_X_CTI_CHAIN
  , OR1K64BF_INSN_X_CHAIN, OR1K64BF_INSN_X_BEGIN, OR1K64BF_INSN_L_J, OR1K64BF_INSN_L_JAL
  , OR1K64BF_INSN_L_JR, OR1K64BF_INSN_L_JALR, OR1K64BF_INSN_L_BNF, OR1K64BF_INSN_L_BF
- , OR1K64BF_INSN_L_TRAP, OR1K64BF_INSN_L_SYS, OR1K64BF_INSN_L_RFE, OR1K64BF_INSN_L_NOP_IMM
- , OR1K64BF_INSN_L_MOVHI, OR1K64BF_INSN_L_MACRC, OR1K64BF_INSN_L_MFSPR, OR1K64BF_INSN_L_MTSPR
- , OR1K64BF_INSN_L_LWZ, OR1K64BF_INSN_L_LWS, OR1K64BF_INSN_L_LBZ, OR1K64BF_INSN_L_LBS
+ , OR1K64BF_INSN_L_TRAP, OR1K64BF_INSN_L_SYS, OR1K64BF_INSN_L_MSYNC, OR1K64BF_INSN_L_PSYNC
+ , OR1K64BF_INSN_L_CSYNC, OR1K64BF_INSN_L_RFE, OR1K64BF_INSN_L_NOP_IMM, OR1K64BF_INSN_L_MOVHI
+ , OR1K64BF_INSN_L_MACRC, OR1K64BF_INSN_L_MFSPR, OR1K64BF_INSN_L_MTSPR, OR1K64BF_INSN_L_LWZ
+ , OR1K64BF_INSN_L_LWS, OR1K64BF_INSN_L_LWA, OR1K64BF_INSN_L_LBZ, OR1K64BF_INSN_L_LBS
  , OR1K64BF_INSN_L_LHZ, OR1K64BF_INSN_L_LHS, OR1K64BF_INSN_L_SW, OR1K64BF_INSN_L_SB
- , OR1K64BF_INSN_L_SH, OR1K64BF_INSN_L_SLL, OR1K64BF_INSN_L_SLLI, OR1K64BF_INSN_L_SRL
- , OR1K64BF_INSN_L_SRLI, OR1K64BF_INSN_L_SRA, OR1K64BF_INSN_L_SRAI, OR1K64BF_INSN_L_ROR
- , OR1K64BF_INSN_L_RORI, OR1K64BF_INSN_L_AND, OR1K64BF_INSN_L_OR, OR1K64BF_INSN_L_XOR
- , OR1K64BF_INSN_L_ADD, OR1K64BF_INSN_L_SUB, OR1K64BF_INSN_L_ADDC, OR1K64BF_INSN_L_MUL
- , OR1K64BF_INSN_L_MULU, OR1K64BF_INSN_L_DIV, OR1K64BF_INSN_L_DIVU, OR1K64BF_INSN_L_FF1
- , OR1K64BF_INSN_L_FL1, OR1K64BF_INSN_L_ANDI, OR1K64BF_INSN_L_ORI, OR1K64BF_INSN_L_XORI
- , OR1K64BF_INSN_L_ADDI, OR1K64BF_INSN_L_ADDIC, OR1K64BF_INSN_L_MULI, OR1K64BF_INSN_L_EXTHS
- , OR1K64BF_INSN_L_EXTBS, OR1K64BF_INSN_L_EXTHZ, OR1K64BF_INSN_L_EXTBZ, OR1K64BF_INSN_L_EXTWS
- , OR1K64BF_INSN_L_EXTWZ, OR1K64BF_INSN_L_CMOV, OR1K64BF_INSN_L_SFGTS, OR1K64BF_INSN_L_SFGTSI
- , OR1K64BF_INSN_L_SFGTU, OR1K64BF_INSN_L_SFGTUI, OR1K64BF_INSN_L_SFGES, OR1K64BF_INSN_L_SFGESI
- , OR1K64BF_INSN_L_SFGEU, OR1K64BF_INSN_L_SFGEUI, OR1K64BF_INSN_L_SFLTS, OR1K64BF_INSN_L_SFLTSI
- , OR1K64BF_INSN_L_SFLTU, OR1K64BF_INSN_L_SFLTUI, OR1K64BF_INSN_L_SFLES, OR1K64BF_INSN_L_SFLESI
- , OR1K64BF_INSN_L_SFLEU, OR1K64BF_INSN_L_SFLEUI, OR1K64BF_INSN_L_SFEQ, OR1K64BF_INSN_L_SFEQI
- , OR1K64BF_INSN_L_SFNE, OR1K64BF_INSN_L_SFNEI, OR1K64BF_INSN_L_MAC, OR1K64BF_INSN_L_MSB
- , OR1K64BF_INSN_L_MACI, OR1K64BF_INSN_L_CUST1, OR1K64BF_INSN_L_CUST2, OR1K64BF_INSN_L_CUST3
- , OR1K64BF_INSN_L_CUST4, OR1K64BF_INSN_L_CUST5, OR1K64BF_INSN_L_CUST6, OR1K64BF_INSN_L_CUST7
- , OR1K64BF_INSN_L_CUST8, OR1K64BF_INSN_LF_ADD_S, OR1K64BF_INSN_LF_ADD_D, OR1K64BF_INSN_LF_SUB_S
- , OR1K64BF_INSN_LF_SUB_D, OR1K64BF_INSN_LF_MUL_S, OR1K64BF_INSN_LF_MUL_D, OR1K64BF_INSN_LF_DIV_S
- , OR1K64BF_INSN_LF_DIV_D, OR1K64BF_INSN_LF_REM_S, OR1K64BF_INSN_LF_REM_D, OR1K64BF_INSN_LF_ITOF_S
- , OR1K64BF_INSN_LF_ITOF_D, OR1K64BF_INSN_LF_FTOI_S, OR1K64BF_INSN_LF_FTOI_D, OR1K64BF_INSN_LF_EQ_S
- , OR1K64BF_INSN_LF_EQ_D, OR1K64BF_INSN_LF_NE_S, OR1K64BF_INSN_LF_NE_D, OR1K64BF_INSN_LF_GE_S
- , OR1K64BF_INSN_LF_GE_D, OR1K64BF_INSN_LF_GT_S, OR1K64BF_INSN_LF_GT_D, OR1K64BF_INSN_LF_LT_S
- , OR1K64BF_INSN_LF_LT_D, OR1K64BF_INSN_LF_LE_S, OR1K64BF_INSN_LF_LE_D, OR1K64BF_INSN_LF_MADD_S
- , OR1K64BF_INSN_LF_MADD_D, OR1K64BF_INSN_LF_CUST1_S, OR1K64BF_INSN_LF_CUST1_D, OR1K64BF_INSN__MAX
+ , OR1K64BF_INSN_L_SH, OR1K64BF_INSN_L_SWA, OR1K64BF_INSN_L_SLL, OR1K64BF_INSN_L_SLLI
+ , OR1K64BF_INSN_L_SRL, OR1K64BF_INSN_L_SRLI, OR1K64BF_INSN_L_SRA, OR1K64BF_INSN_L_SRAI
+ , OR1K64BF_INSN_L_ROR, OR1K64BF_INSN_L_RORI, OR1K64BF_INSN_L_AND, OR1K64BF_INSN_L_OR
+ , OR1K64BF_INSN_L_XOR, OR1K64BF_INSN_L_ADD, OR1K64BF_INSN_L_SUB, OR1K64BF_INSN_L_ADDC
+ , OR1K64BF_INSN_L_MUL, OR1K64BF_INSN_L_MULU, OR1K64BF_INSN_L_DIV, OR1K64BF_INSN_L_DIVU
+ , OR1K64BF_INSN_L_FF1, OR1K64BF_INSN_L_FL1, OR1K64BF_INSN_L_ANDI, OR1K64BF_INSN_L_ORI
+ , OR1K64BF_INSN_L_XORI, OR1K64BF_INSN_L_ADDI, OR1K64BF_INSN_L_ADDIC, OR1K64BF_INSN_L_MULI
+ , OR1K64BF_INSN_L_EXTHS, OR1K64BF_INSN_L_EXTBS, OR1K64BF_INSN_L_EXTHZ, OR1K64BF_INSN_L_EXTBZ
+ , OR1K64BF_INSN_L_EXTWS, OR1K64BF_INSN_L_EXTWZ, OR1K64BF_INSN_L_CMOV, OR1K64BF_INSN_L_SFGTS
+ , OR1K64BF_INSN_L_SFGTSI, OR1K64BF_INSN_L_SFGTU, OR1K64BF_INSN_L_SFGTUI, OR1K64BF_INSN_L_SFGES
+ , OR1K64BF_INSN_L_SFGESI, OR1K64BF_INSN_L_SFGEU, OR1K64BF_INSN_L_SFGEUI, OR1K64BF_INSN_L_SFLTS
+ , OR1K64BF_INSN_L_SFLTSI, OR1K64BF_INSN_L_SFLTU, OR1K64BF_INSN_L_SFLTUI, OR1K64BF_INSN_L_SFLES
+ , OR1K64BF_INSN_L_SFLESI, OR1K64BF_INSN_L_SFLEU, OR1K64BF_INSN_L_SFLEUI, OR1K64BF_INSN_L_SFEQ
+ , OR1K64BF_INSN_L_SFEQI, OR1K64BF_INSN_L_SFNE, OR1K64BF_INSN_L_SFNEI, OR1K64BF_INSN_L_MAC
+ , OR1K64BF_INSN_L_MSB, OR1K64BF_INSN_L_MACI, OR1K64BF_INSN_L_CUST1, OR1K64BF_INSN_L_CUST2
+ , OR1K64BF_INSN_L_CUST3, OR1K64BF_INSN_L_CUST4, OR1K64BF_INSN_L_CUST5, OR1K64BF_INSN_L_CUST6
+ , OR1K64BF_INSN_L_CUST7, OR1K64BF_INSN_L_CUST8, OR1K64BF_INSN_LF_ADD_S, OR1K64BF_INSN_LF_ADD_D
+ , OR1K64BF_INSN_LF_SUB_S, OR1K64BF_INSN_LF_SUB_D, OR1K64BF_INSN_LF_MUL_S, OR1K64BF_INSN_LF_MUL_D
+ , OR1K64BF_INSN_LF_DIV_S, OR1K64BF_INSN_LF_DIV_D, OR1K64BF_INSN_LF_REM_S, OR1K64BF_INSN_LF_REM_D
+ , OR1K64BF_INSN_LF_ITOF_S, OR1K64BF_INSN_LF_ITOF_D, OR1K64BF_INSN_LF_FTOI_S, OR1K64BF_INSN_LF_FTOI_D
+ , OR1K64BF_INSN_LF_EQ_S, OR1K64BF_INSN_LF_EQ_D, OR1K64BF_INSN_LF_NE_S, OR1K64BF_INSN_LF_NE_D
+ , OR1K64BF_INSN_LF_GE_S, OR1K64BF_INSN_LF_GE_D, OR1K64BF_INSN_LF_GT_S, OR1K64BF_INSN_LF_GT_D
+ , OR1K64BF_INSN_LF_LT_S, OR1K64BF_INSN_LF_LT_D, OR1K64BF_INSN_LF_LE_S, OR1K64BF_INSN_LF_LE_D
+ , OR1K64BF_INSN_LF_MADD_S, OR1K64BF_INSN_LF_MADD_D, OR1K64BF_INSN_LF_CUST1_S, OR1K64BF_INSN_LF_CUST1_D
+ , OR1K64BF_INSN__MAX
 } OR1K64BF_INSN_TYPE;
 
 /* Enum declaration for semantic formats in cpu family or1k64bf.  */
 typedef enum or1k64bf_sfmt_type {
   OR1K64BF_SFMT_EMPTY, OR1K64BF_SFMT_L_J, OR1K64BF_SFMT_L_JAL, OR1K64BF_SFMT_L_JR
- , OR1K64BF_SFMT_L_JALR, OR1K64BF_SFMT_L_BNF, OR1K64BF_SFMT_L_TRAP, OR1K64BF_SFMT_L_RFE
+ , OR1K64BF_SFMT_L_JALR, OR1K64BF_SFMT_L_BNF, OR1K64BF_SFMT_L_TRAP, OR1K64BF_SFMT_L_MSYNC
  , OR1K64BF_SFMT_L_NOP_IMM, OR1K64BF_SFMT_L_MOVHI, OR1K64BF_SFMT_L_MACRC, OR1K64BF_SFMT_L_MFSPR
- , OR1K64BF_SFMT_L_MTSPR, OR1K64BF_SFMT_L_LWZ, OR1K64BF_SFMT_L_LWS, OR1K64BF_SFMT_L_LBZ
- , OR1K64BF_SFMT_L_LBS, OR1K64BF_SFMT_L_LHZ, OR1K64BF_SFMT_L_LHS, OR1K64BF_SFMT_L_SW
- , OR1K64BF_SFMT_L_SB, OR1K64BF_SFMT_L_SH, OR1K64BF_SFMT_L_SLL, OR1K64BF_SFMT_L_SLLI
- , OR1K64BF_SFMT_L_AND, OR1K64BF_SFMT_L_ADD, OR1K64BF_SFMT_L_ADDC, OR1K64BF_SFMT_L_DIV
- , OR1K64BF_SFMT_L_FF1, OR1K64BF_SFMT_L_XORI, OR1K64BF_SFMT_L_ADDI, OR1K64BF_SFMT_L_ADDIC
- , OR1K64BF_SFMT_L_EXTHS, OR1K64BF_SFMT_L_CMOV, OR1K64BF_SFMT_L_SFGTS, OR1K64BF_SFMT_L_SFGTSI
- , OR1K64BF_SFMT_L_MAC, OR1K64BF_SFMT_L_MACI, OR1K64BF_SFMT_LF_ADD_S, OR1K64BF_SFMT_LF_ADD_D
- , OR1K64BF_SFMT_LF_ITOF_S, OR1K64BF_SFMT_LF_ITOF_D, OR1K64BF_SFMT_LF_FTOI_S, OR1K64BF_SFMT_LF_FTOI_D
- , OR1K64BF_SFMT_LF_EQ_S, OR1K64BF_SFMT_LF_EQ_D, OR1K64BF_SFMT_LF_MADD_S, OR1K64BF_SFMT_LF_MADD_D
+ , OR1K64BF_SFMT_L_MTSPR, OR1K64BF_SFMT_L_LWZ, OR1K64BF_SFMT_L_LWS, OR1K64BF_SFMT_L_LWA
+ , OR1K64BF_SFMT_L_LBZ, OR1K64BF_SFMT_L_LBS, OR1K64BF_SFMT_L_LHZ, OR1K64BF_SFMT_L_LHS
+ , OR1K64BF_SFMT_L_SW, OR1K64BF_SFMT_L_SB, OR1K64BF_SFMT_L_SH, OR1K64BF_SFMT_L_SWA
+ , OR1K64BF_SFMT_L_SLL, OR1K64BF_SFMT_L_SLLI, OR1K64BF_SFMT_L_AND, OR1K64BF_SFMT_L_ADD
+ , OR1K64BF_SFMT_L_ADDC, OR1K64BF_SFMT_L_DIV, OR1K64BF_SFMT_L_FF1, OR1K64BF_SFMT_L_XORI
+ , OR1K64BF_SFMT_L_ADDI, OR1K64BF_SFMT_L_ADDIC, OR1K64BF_SFMT_L_EXTHS, OR1K64BF_SFMT_L_CMOV
+ , OR1K64BF_SFMT_L_SFGTS, OR1K64BF_SFMT_L_SFGTSI, OR1K64BF_SFMT_L_MAC, OR1K64BF_SFMT_L_MACI
+ , OR1K64BF_SFMT_LF_ADD_S, OR1K64BF_SFMT_LF_ADD_D, OR1K64BF_SFMT_LF_ITOF_S, OR1K64BF_SFMT_LF_ITOF_D
+ , OR1K64BF_SFMT_LF_FTOI_S, OR1K64BF_SFMT_LF_FTOI_D, OR1K64BF_SFMT_LF_EQ_S, OR1K64BF_SFMT_LF_EQ_D
+ , OR1K64BF_SFMT_LF_MADD_S, OR1K64BF_SFMT_LF_MADD_D
 } OR1K64BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/model32.c b/sim/or1k/model32.c
index 72c0d61..ec33b24 100644
--- a/sim/or1k/model32.c
+++ b/sim/or1k/model32.c
@@ -163,6 +163,54 @@ model_or1200_l_sys (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
+model_or1200_l_msync (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200_l_psync (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
+model_or1200_l_csync (SIM_CPU *current_cpu, void *sem_arg)
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
+static int
 model_or1200_l_rfe (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_empty.f
@@ -291,6 +339,22 @@ model_or1200_l_lws (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
+model_or1200_l_lwa (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
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
 model_or1200_l_lbz (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
@@ -403,6 +467,22 @@ model_or1200_l_sh (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
+model_or1200_l_swa (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
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
 model_or1200_l_sll (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
@@ -1795,6 +1875,54 @@ model_or1200nd_l_sys (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
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
 model_or1200nd_l_rfe (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_empty.f
@@ -1923,6 +2051,22 @@ model_or1200nd_l_lws (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
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
 model_or1200nd_l_lbz (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_lwz.f
@@ -2035,6 +2179,22 @@ model_or1200nd_l_sh (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
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
 model_or1200nd_l_sll (SIM_CPU *current_cpu, void *sem_arg)
 {
 #define FLD(f) abuf->fields.sfmt_l_sll.f
@@ -3318,6 +3478,9 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_BF, model_or1200_l_bf, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_TRAP, model_or1200_l_trap, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SYS, model_or1200_l_sys, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MSYNC, model_or1200_l_msync, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_PSYNC, model_or1200_l_psync, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_CSYNC, model_or1200_l_csync, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_RFE, model_or1200_l_rfe, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_NOP_IMM, model_or1200_l_nop_imm, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MOVHI, model_or1200_l_movhi, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3326,6 +3489,7 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_MTSPR, model_or1200_l_mtspr, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LWZ, model_or1200_l_lwz, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LWS, model_or1200_l_lws, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_LWA, model_or1200_l_lwa, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LBZ, model_or1200_l_lbz, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LBS, model_or1200_l_lbs, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LHZ, model_or1200_l_lhz, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3333,6 +3497,7 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_SW, model_or1200_l_sw, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SB, model_or1200_l_sb, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SH, model_or1200_l_sh, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SWA, model_or1200_l_swa, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SLL, model_or1200_l_sll, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SLLI, model_or1200_l_slli, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SRL, model_or1200_l_srl, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3431,6 +3596,9 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_BF, model_or1200nd_l_bf, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_TRAP, model_or1200nd_l_trap, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SYS, model_or1200nd_l_sys, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MSYNC, model_or1200nd_l_msync, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_PSYNC, model_or1200nd_l_psync, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_CSYNC, model_or1200nd_l_csync, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_RFE, model_or1200nd_l_rfe, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_NOP_IMM, model_or1200nd_l_nop_imm, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MOVHI, model_or1200nd_l_movhi, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
@@ -3439,6 +3607,7 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_MTSPR, model_or1200nd_l_mtspr, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LWZ, model_or1200nd_l_lwz, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LWS, model_or1200nd_l_lws, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_LWA, model_or1200nd_l_lwa, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LBZ, model_or1200nd_l_lbz, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LBS, model_or1200nd_l_lbs, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_LHZ, model_or1200nd_l_lhz, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
@@ -3446,6 +3615,7 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_SW, model_or1200nd_l_sw, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SB, model_or1200nd_l_sb, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SH, model_or1200nd_l_sh, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_SWA, model_or1200nd_l_swa, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SLL, model_or1200nd_l_sll, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SLLI, model_or1200nd_l_slli, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SRL, model_or1200nd_l_srl, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
@@ -3547,13 +3717,13 @@ or1200nd_model_init (SIM_CPU *cpu)
 #define TIMING_DATA(td) 0
 #endif
 
-static const MODEL or32_models[] =
+static const SIM_MODEL or32_models[] =
 {
   { "or1200", & or32_mach, MODEL_OR1200, TIMING_DATA (& or1200_timing[0]), or1200_model_init },
   { 0 }
 };
 
-static const MODEL or32nd_models[] =
+static const SIM_MODEL or32nd_models[] =
 {
   { "or1200nd", & or32nd_mach, MODEL_OR1200ND, TIMING_DATA (& or1200nd_timing[0]), or1200nd_model_init },
   { 0 }
@@ -3561,7 +3731,7 @@ static const MODEL or32nd_models[] =
 
 /* The properties of this cpu's implementation.  */
 
-static const MACH_IMP_PROPERTIES or1k32bf_imp_properties =
+static const SIM_MACH_IMP_PROPERTIES or1k32bf_imp_properties =
 {
   sizeof (SIM_CPU),
 #if WITH_SCACHE
@@ -3603,7 +3773,7 @@ or32_init_cpu (SIM_CPU *cpu)
 #endif
 }
 
-const MACH or32_mach =
+const SIM_MACH or32_mach =
 {
   "or32", "or1k", MACH_OR32,
   32, 32, & or32_models[0], & or1k32bf_imp_properties,
@@ -3629,7 +3799,7 @@ or32nd_init_cpu (SIM_CPU *cpu)
 #endif
 }
 
-const MACH or32nd_mach =
+const SIM_MACH or32nd_mach =
 {
   "or32nd", "or1knd", MACH_OR32ND,
   32, 32, & or32nd_models[0], & or1k32bf_imp_properties,
diff --git a/sim/or1k/model64.c b/sim/or1k/model64.c
index 4fa3399..93107d2 100644
--- a/sim/or1k/model64.c
+++ b/sim/or1k/model64.c
@@ -45,19 +45,19 @@ This file is part of the GNU simulators.
 #define TIMING_DATA(td) 0
 #endif
 
-static const MODEL or64_models[] =
+static const SIM_MODEL or64_models[] =
 {
   { 0 }
 };
 
-static const MODEL or64nd_models[] =
+static const SIM_MODEL or64nd_models[] =
 {
   { 0 }
 };
 
 /* The properties of this cpu's implementation.  */
 
-static const MACH_IMP_PROPERTIES or1k64bf_imp_properties =
+static const SIM_MACH_IMP_PROPERTIES or1k64bf_imp_properties =
 {
   sizeof (SIM_CPU),
 #if WITH_SCACHE
@@ -99,7 +99,7 @@ or64_init_cpu (SIM_CPU *cpu)
 #endif
 }
 
-const MACH or64_mach =
+const SIM_MACH or64_mach =
 {
   "or64", "or1k64", MACH_OR64,
   64, 64, & or64_models[0], & or1k64bf_imp_properties,
@@ -125,7 +125,7 @@ or64nd_init_cpu (SIM_CPU *cpu)
 #endif
 }
 
-const MACH or64nd_mach =
+const SIM_MACH or64nd_mach =
 {
   "or64nd", "or1k64nd", MACH_OR64ND,
   64, 64, & or64nd_models[0], & or1k64bf_imp_properties,
diff --git a/sim/or1k/or1k32-opc.h b/sim/or1k/or1k32-opc.h
deleted file mode 100644
index 97aab87..0000000
--- a/sim/or1k/or1k32-opc.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/* Instruction opcode header for or1k.
-
-THIS FILE IS MACHINE GENERATED WITH CGEN.
-
-Copyright 1996-2010 Free Software Foundation, Inc.
-
-This file is part of the GNU Binutils and/or GDB, the GNU debugger.
-
-   This file is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 3, or (at your option)
-   any later version.
-
-   It is distributed in the hope that it will be useful, but WITHOUT
-   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
-   License for more details.
-
-   You should have received a copy of the GNU General Public License along
-   with this program; if not, write to the Free Software Foundation, Inc.,
-   51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.
-
-*/
-
-#ifndef OR1K_OPC_H
-#define OR1K_OPC_H
-
-/* -- opc.h */
-
-#undef  CGEN_DIS_HASH_SIZE
-#define CGEN_DIS_HASH_SIZE 256
-#undef  CGEN_DIS_HASH
-#define CGEN_DIS_HASH(buffer, value) (((unsigned char *) (buffer))[0] >> 2)
-
-/* -- */
-/* Enum declaration for or1k instruction types.  */
-typedef enum cgen_insn_type {
-  OR1K_INSN_INVALID, OR1K_INSN_L_J, OR1K_INSN_L_JAL, OR1K_INSN_L_JR
- , OR1K_INSN_L_JALR, OR1K_INSN_L_BNF, OR1K_INSN_L_BF, OR1K_INSN_L_TRAP
- , OR1K_INSN_L_SYS, OR1K_INSN_L_RFE, OR1K_INSN_L_NOP_IMM, OR1K_INSN_L_NOP
- , OR1K_INSN_L_MOVHI, OR1K_INSN_L_MACRC, OR1K_INSN_L_MFSPR, OR1K_INSN_L_MTSPR
- , OR1K_INSN_L_LWZ, OR1K_INSN_L_LWS, OR1K_INSN_L_LBZ, OR1K_INSN_L_LBS
- , OR1K_INSN_L_LHZ, OR1K_INSN_L_LHS, OR1K_INSN_L_SW, OR1K_INSN_L_SB
- , OR1K_INSN_L_SH, OR1K_INSN_L_SLL, OR1K_INSN_L_SLLI, OR1K_INSN_L_SRL
- , OR1K_INSN_L_SRLI, OR1K_INSN_L_SRA, OR1K_INSN_L_SRAI, OR1K_INSN_L_ROR
- , OR1K_INSN_L_RORI, OR1K_INSN_L_AND, OR1K_INSN_L_OR, OR1K_INSN_L_XOR
- , OR1K_INSN_L_ADD, OR1K_INSN_L_SUB, OR1K_INSN_L_ADDC, OR1K_INSN_L_MUL
- , OR1K_INSN_L_MULU, OR1K_INSN_L_DIV, OR1K_INSN_L_DIVU, OR1K_INSN_L_FF1
- , OR1K_INSN_L_FL1, OR1K_INSN_L_ANDI, OR1K_INSN_L_ORI, OR1K_INSN_L_XORI
- , OR1K_INSN_L_ADDI, OR1K_INSN_L_ADDIC, OR1K_INSN_L_MULI, OR1K_INSN_L_EXTHS
- , OR1K_INSN_L_EXTBS, OR1K_INSN_L_EXTHZ, OR1K_INSN_L_EXTBZ, OR1K_INSN_L_EXTWS
- , OR1K_INSN_L_EXTWZ, OR1K_INSN_L_CMOV, OR1K_INSN_L_SFGTU, OR1K_INSN_L_SFGEU
- , OR1K_INSN_L_SFLTU, OR1K_INSN_L_SFLEU, OR1K_INSN_L_SFGTS, OR1K_INSN_L_SFGES
- , OR1K_INSN_L_SFLTS, OR1K_INSN_L_SFLES, OR1K_INSN_L_SFGTUI, OR1K_INSN_L_SFGEUI
- , OR1K_INSN_L_SFLTUI, OR1K_INSN_L_SFLEUI, OR1K_INSN_L_SFGTSI, OR1K_INSN_L_SFGESI
- , OR1K_INSN_L_SFLTSI, OR1K_INSN_L_SFLESI, OR1K_INSN_L_SFEQ, OR1K_INSN_L_SFEQI
- , OR1K_INSN_L_SFNE, OR1K_INSN_L_SFNEI, OR1K_INSN_L_MAC, OR1K_INSN_L_MSB
- , OR1K_INSN_L_MACI, OR1K_INSN_L_CUST1, OR1K_INSN_L_CUST2, OR1K_INSN_L_CUST3
- , OR1K_INSN_L_CUST4, OR1K_INSN_L_CUST5, OR1K_INSN_L_CUST6, OR1K_INSN_L_CUST7
- , OR1K_INSN_L_CUST8, OR1K_INSN_LF_ADD_S, OR1K_INSN_LF_SUB_S, OR1K_INSN_LF_MUL_S
- , OR1K_INSN_LF_DIV_S, OR1K_INSN_LF_REM_S, OR1K_INSN_LF_ITOF_S, OR1K_INSN_LF_FTOI_S
- , OR1K_INSN_LF_EQ_S, OR1K_INSN_LF_NE_S, OR1K_INSN_LF_GE_S, OR1K_INSN_LF_GT_S
- , OR1K_INSN_LF_LT_S, OR1K_INSN_LF_LE_S, OR1K_INSN_LF_MADD_S, OR1K_INSN_LF_CUST1_S
-} CGEN_INSN_TYPE;
-
-/* Index of `invalid' insn place holder.  */
-#define CGEN_INSN_INVALID OR1K_INSN_INVALID
-
-/* Total number of insns in table.  */
-#define MAX_INSNS ((int) OR1K_INSN_LF_CUST1_S + 1)
-
-/* This struct records data prior to insertion or after extraction.  */
-struct cgen_fields
-{
-  int length;
-  long f_nil;
-  long f_anyof;
-  long f_opcode;
-  long f_r1;
-  long f_r2;
-  long f_r3;
-  long f_op_25_2;
-  long f_op_25_5;
-  long f_op_16_1;
-  long f_op_7_4;
-  long f_op_3_4;
-  long f_op_9_2;
-  long f_op_9_4;
-  long f_op_7_8;
-  long f_op_7_2;
-  long f_resv_25_26;
-  long f_resv_25_10;
-  long f_resv_25_5;
-  long f_resv_23_8;
-  long f_resv_20_5;
-  long f_resv_20_4;
-  long f_resv_15_8;
-  long f_resv_15_6;
-  long f_resv_10_11;
-  long f_resv_10_7;
-  long f_resv_10_3;
-  long f_resv_10_1;
-  long f_resv_7_4;
-  long f_resv_5_2;
-  long f_imm16_25_5;
-  long f_imm16_10_11;
-  long f_disp26;
-  long f_uimm16;
-  long f_simm16;
-  long f_uimm6;
-  long f_uimm16_split;
-  long f_simm16_split;
-};
-
-#define CGEN_INIT_PARSE(od) \
-{\
-}
-#define CGEN_INIT_INSERT(od) \
-{\
-}
-#define CGEN_INIT_EXTRACT(od) \
-{\
-}
-#define CGEN_INIT_PRINT(od) \
-{\
-}
-
-
-#endif /* OR1K_OPC_H */
diff --git a/sim/or1k/or1k64-opc.h b/sim/or1k/or1k64-opc.h
deleted file mode 100644
index b35a1bf..0000000
--- a/sim/or1k/or1k64-opc.h
+++ /dev/null
@@ -1,133 +0,0 @@
-/* Instruction opcode header for or1k.
-
-THIS FILE IS MACHINE GENERATED WITH CGEN.
-
-Copyright 1996-2010 Free Software Foundation, Inc.
-
-This file is part of the GNU Binutils and/or GDB, the GNU debugger.
-
-   This file is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 3, or (at your option)
-   any later version.
-
-   It is distributed in the hope that it will be useful, but WITHOUT
-   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
-   License for more details.
-
-   You should have received a copy of the GNU General Public License along
-   with this program; if not, write to the Free Software Foundation, Inc.,
-   51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.
-
-*/
-
-#ifndef OR1K_OPC_H
-#define OR1K_OPC_H
-
-/* -- opc.h */
-
-#undef  CGEN_DIS_HASH_SIZE
-#define CGEN_DIS_HASH_SIZE 256
-#undef  CGEN_DIS_HASH
-#define CGEN_DIS_HASH(buffer, value) (((unsigned char *) (buffer))[0] >> 2)
-
-/* -- */
-/* Enum declaration for or1k instruction types.  */
-typedef enum cgen_insn_type {
-  OR1K_INSN_INVALID, OR1K_INSN_L_J, OR1K_INSN_L_JAL, OR1K_INSN_L_JR
- , OR1K_INSN_L_JALR, OR1K_INSN_L_BNF, OR1K_INSN_L_BF, OR1K_INSN_L_TRAP
- , OR1K_INSN_L_SYS, OR1K_INSN_L_RFE, OR1K_INSN_L_NOP_IMM, OR1K_INSN_L_NOP
- , OR1K_INSN_L_MOVHI, OR1K_INSN_L_MACRC, OR1K_INSN_L_MFSPR, OR1K_INSN_L_MTSPR
- , OR1K_INSN_L_LWZ, OR1K_INSN_L_LWS, OR1K_INSN_L_LBZ, OR1K_INSN_L_LBS
- , OR1K_INSN_L_LHZ, OR1K_INSN_L_LHS, OR1K_INSN_L_SW, OR1K_INSN_L_SB
- , OR1K_INSN_L_SH, OR1K_INSN_L_SLL, OR1K_INSN_L_SLLI, OR1K_INSN_L_SRL
- , OR1K_INSN_L_SRLI, OR1K_INSN_L_SRA, OR1K_INSN_L_SRAI, OR1K_INSN_L_ROR
- , OR1K_INSN_L_RORI, OR1K_INSN_L_AND, OR1K_INSN_L_OR, OR1K_INSN_L_XOR
- , OR1K_INSN_L_ADD, OR1K_INSN_L_SUB, OR1K_INSN_L_ADDC, OR1K_INSN_L_MUL
- , OR1K_INSN_L_MULU, OR1K_INSN_L_DIV, OR1K_INSN_L_DIVU, OR1K_INSN_L_FF1
- , OR1K_INSN_L_FL1, OR1K_INSN_L_ANDI, OR1K_INSN_L_ORI, OR1K_INSN_L_XORI
- , OR1K_INSN_L_ADDI, OR1K_INSN_L_ADDIC, OR1K_INSN_L_MULI, OR1K_INSN_L_EXTHS
- , OR1K_INSN_L_EXTBS, OR1K_INSN_L_EXTHZ, OR1K_INSN_L_EXTBZ, OR1K_INSN_L_EXTWS
- , OR1K_INSN_L_EXTWZ, OR1K_INSN_L_CMOV, OR1K_INSN_L_SFGTU, OR1K_INSN_L_SFGEU
- , OR1K_INSN_L_SFLTU, OR1K_INSN_L_SFLEU, OR1K_INSN_L_SFGTS, OR1K_INSN_L_SFGES
- , OR1K_INSN_L_SFLTS, OR1K_INSN_L_SFLES, OR1K_INSN_L_SFGTUI, OR1K_INSN_L_SFGEUI
- , OR1K_INSN_L_SFLTUI, OR1K_INSN_L_SFLEUI, OR1K_INSN_L_SFGTSI, OR1K_INSN_L_SFGESI
- , OR1K_INSN_L_SFLTSI, OR1K_INSN_L_SFLESI, OR1K_INSN_L_SFEQ, OR1K_INSN_L_SFEQI
- , OR1K_INSN_L_SFNE, OR1K_INSN_L_SFNEI, OR1K_INSN_L_MAC, OR1K_INSN_L_MSB
- , OR1K_INSN_L_MACI, OR1K_INSN_L_CUST1, OR1K_INSN_L_CUST2, OR1K_INSN_L_CUST3
- , OR1K_INSN_L_CUST4, OR1K_INSN_L_CUST5, OR1K_INSN_L_CUST6, OR1K_INSN_L_CUST7
- , OR1K_INSN_L_CUST8, OR1K_INSN_LF_ADD_S, OR1K_INSN_LF_ADD_D, OR1K_INSN_LF_SUB_S
- , OR1K_INSN_LF_SUB_D, OR1K_INSN_LF_MUL_S, OR1K_INSN_LF_MUL_D, OR1K_INSN_LF_DIV_S
- , OR1K_INSN_LF_DIV_D, OR1K_INSN_LF_REM_S, OR1K_INSN_LF_REM_D, OR1K_INSN_LF_ITOF_S
- , OR1K_INSN_LF_ITOF_D, OR1K_INSN_LF_FTOI_S, OR1K_INSN_LF_FTOI_D, OR1K_INSN_LF_EQ_S
- , OR1K_INSN_LF_EQ_D, OR1K_INSN_LF_NE_S, OR1K_INSN_LF_NE_D, OR1K_INSN_LF_GE_S
- , OR1K_INSN_LF_GE_D, OR1K_INSN_LF_GT_S, OR1K_INSN_LF_GT_D, OR1K_INSN_LF_LT_S
- , OR1K_INSN_LF_LT_D, OR1K_INSN_LF_LE_S, OR1K_INSN_LF_LE_D, OR1K_INSN_LF_MADD_S
- , OR1K_INSN_LF_MADD_D, OR1K_INSN_LF_CUST1_S, OR1K_INSN_LF_CUST1_D
-} CGEN_INSN_TYPE;
-
-/* Index of `invalid' insn place holder.  */
-#define CGEN_INSN_INVALID OR1K_INSN_INVALID
-
-/* Total number of insns in table.  */
-#define MAX_INSNS ((int) OR1K_INSN_LF_CUST1_D + 1)
-
-/* This struct records data prior to insertion or after extraction.  */
-struct cgen_fields
-{
-  int length;
-  long f_nil;
-  long f_anyof;
-  long f_opcode;
-  long f_r1;
-  long f_r2;
-  long f_r3;
-  long f_op_25_2;
-  long f_op_25_5;
-  long f_op_16_1;
-  long f_op_7_4;
-  long f_op_3_4;
-  long f_op_9_2;
-  long f_op_9_4;
-  long f_op_7_8;
-  long f_op_7_2;
-  long f_resv_25_26;
-  long f_resv_25_10;
-  long f_resv_25_5;
-  long f_resv_23_8;
-  long f_resv_20_5;
-  long f_resv_20_4;
-  long f_resv_15_8;
-  long f_resv_15_6;
-  long f_resv_10_11;
-  long f_resv_10_7;
-  long f_resv_10_3;
-  long f_resv_10_1;
-  long f_resv_7_4;
-  long f_resv_5_2;
-  long f_imm16_25_5;
-  long f_imm16_10_11;
-  long f_disp26;
-  long f_uimm16;
-  long f_simm16;
-  long f_uimm6;
-  long f_uimm16_split;
-  long f_simm16_split;
-};
-
-#define CGEN_INIT_PARSE(od) \
-{\
-}
-#define CGEN_INIT_INSERT(od) \
-{\
-}
-#define CGEN_INIT_EXTRACT(od) \
-{\
-}
-#define CGEN_INIT_PRINT(od) \
-{\
-}
-
-
-#endif /* OR1K_OPC_H */
diff --git a/sim/or1k/sem32-switch.c b/sim/or1k/sem32-switch.c
index 7d3d97f..37c0dc7 100644
--- a/sim/or1k/sem32-switch.c
+++ b/sim/or1k/sem32-switch.c
@@ -46,6 +46,9 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_BF, && case_sem_INSN_L_BF },
     { OR1K32BF_INSN_L_TRAP, && case_sem_INSN_L_TRAP },
     { OR1K32BF_INSN_L_SYS, && case_sem_INSN_L_SYS },
+    { OR1K32BF_INSN_L_MSYNC, && case_sem_INSN_L_MSYNC },
+    { OR1K32BF_INSN_L_PSYNC, && case_sem_INSN_L_PSYNC },
+    { OR1K32BF_INSN_L_CSYNC, && case_sem_INSN_L_CSYNC },
     { OR1K32BF_INSN_L_RFE, && case_sem_INSN_L_RFE },
     { OR1K32BF_INSN_L_NOP_IMM, && case_sem_INSN_L_NOP_IMM },
     { OR1K32BF_INSN_L_MOVHI, && case_sem_INSN_L_MOVHI },
@@ -54,6 +57,7 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_MTSPR, && case_sem_INSN_L_MTSPR },
     { OR1K32BF_INSN_L_LWZ, && case_sem_INSN_L_LWZ },
     { OR1K32BF_INSN_L_LWS, && case_sem_INSN_L_LWS },
+    { OR1K32BF_INSN_L_LWA, && case_sem_INSN_L_LWA },
     { OR1K32BF_INSN_L_LBZ, && case_sem_INSN_L_LBZ },
     { OR1K32BF_INSN_L_LBS, && case_sem_INSN_L_LBS },
     { OR1K32BF_INSN_L_LHZ, && case_sem_INSN_L_LHZ },
@@ -61,6 +65,7 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_SW, && case_sem_INSN_L_SW },
     { OR1K32BF_INSN_L_SB, && case_sem_INSN_L_SB },
     { OR1K32BF_INSN_L_SH, && case_sem_INSN_L_SH },
+    { OR1K32BF_INSN_L_SWA, && case_sem_INSN_L_SWA },
     { OR1K32BF_INSN_L_SLL, && case_sem_INSN_L_SLL },
     { OR1K32BF_INSN_L_SLLI, && case_sem_INSN_L_SLLI },
     { OR1K32BF_INSN_L_SRL, && case_sem_INSN_L_SRL },
@@ -165,8 +170,8 @@ This file is part of the GNU simulators.
    special handlers into the instruction "stream".  */
 
 #if FAST_P
-#undef TRACE_RESULT
-#define TRACE_RESULT(cpu, abuf, name, type, val)
+#undef CGEN_TRACE_RESULT
+#define CGEN_TRACE_RESULT(cpu, abuf, name, type, val)
 #endif
 
 #undef GET_ATTR
@@ -354,7 +359,7 @@ SWITCH (sem, SEM_ARGBUF (vpc) -> semantic.sem_case)
   {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -382,14 +387,14 @@ if (1)
   {
     USI opval = ADDSI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 {
 {
   {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -419,7 +424,7 @@ if (1)
   {
     USI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -447,14 +452,14 @@ if (1)
   {
     USI opval = ADDSI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 {
 {
   {
     USI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -486,7 +491,7 @@ if (NOTSI (GET_H_SYS_SR_F ())) {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 } else {
@@ -496,7 +501,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     USI opval = ADDSI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 }
@@ -530,7 +535,7 @@ if (GET_H_SYS_SR_F ()) {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 } else {
@@ -540,7 +545,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     USI opval = ADDSI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 }
@@ -587,6 +592,51 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_SYSCALL);
 }
   NEXT (vpc);
 
+  CASE (sem, INSN_L_MSYNC) : /* l.msync */
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
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_PSYNC) : /* l.psync */
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
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_CSYNC) : /* l.csync */
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
+#undef FLD
+}
+  NEXT (vpc);
+
   CASE (sem, INSN_L_RFE) : /* l.rfe */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
@@ -629,7 +679,7 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
   {
     USI opval = SLLSI (ZEXTSISI (FLD (f_uimm16)), 16);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -649,17 +699,17 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
   {
     USI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
   {
     USI opval = 0;
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
   {
     USI opval = 0;
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
 }
 
@@ -679,7 +729,7 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
   {
     USI opval = or1k32bf_mfspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -713,7 +763,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = ZEXTSISI (GETMEMUSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -732,13 +782,44 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     SI opval = EXTSISI (GETMEMSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
 }
   NEXT (vpc);
 
+  CASE (sem, INSN_L_LWA) : /* l.lwa $rD,${simm16}($rA) */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  {
+    USI opval = ZEXTSISI (GETMEMUSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
+    SET_H_GPR (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+  }
+  {
+    BI opval = 1;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+  {
+    SI opval = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4);
+    CPU (h_atomic_address) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-address", 'x', opval);
+  }
+}
+
+#undef FLD
+}
+  NEXT (vpc);
+
   CASE (sem, INSN_L_LBZ) : /* l.lbz $rD,${simm16}($rA) */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
@@ -751,7 +832,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = ZEXTQISI (GETMEMUQI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -770,7 +851,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     SI opval = EXTQISI (GETMEMQI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -789,7 +870,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = ZEXTHISI (GETMEMUHI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -808,7 +889,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     SI opval = EXTHISI (GETMEMHI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -824,12 +905,25 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
   {
     USI opval = TRUNCSISI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
 
+  abuf->written = written;
 #undef FLD
 }
   NEXT (vpc);
@@ -843,12 +937,25 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1);
   {
     UQI opval = TRUNCSIQI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUQI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUQI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
 
+  abuf->written = written;
 #undef FLD
 }
   NEXT (vpc);
@@ -862,12 +969,63 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2);
   {
     UHI opval = TRUNCSIHI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUHI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUHI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
+
+  abuf->written = written;
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_SWA) : /* l.swa ${simm16-split}($rA),$rB */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sw.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  SI tmp_addr;
+  BI tmp_flag;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
+  {
+    USI opval = ANDBI (CPU (h_atomic_reserve), EQSI (tmp_addr, CPU (h_atomic_address)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+if (GET_H_SYS_SR_F ()) {
+  {
+    USI opval = TRUNCSISI (GET_H_GPR (FLD (f_r3)));
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    written |= (1 << 7);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+}
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
 
+  abuf->written = written;
 #undef FLD
 }
   NEXT (vpc);
@@ -884,7 +1042,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = SLLSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -903,7 +1061,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = SLLSI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -922,7 +1080,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = SRLSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -941,7 +1099,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = SRLSI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -960,7 +1118,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = SRASI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -979,7 +1137,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = SRASI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -998,7 +1156,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = RORSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1017,7 +1175,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = RORSI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1036,7 +1194,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = ANDSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1055,7 +1213,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = ORSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1074,7 +1232,7 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     USI opval = XORSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1095,17 +1253,17 @@ or1k32bf_mtspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = ADDSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1131,17 +1289,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = SUBCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = SUBOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = SUBSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1169,17 +1327,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = ADDCSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1205,17 +1363,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = MUL2OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1241,17 +1399,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1279,13 +1437,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     SI opval = DIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
@@ -1293,13 +1451,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1327,13 +1485,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = UDIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
@@ -1341,13 +1499,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1371,7 +1529,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = or1k32bf_ff1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1390,7 +1548,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = or1k32bf_fl1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1409,7 +1567,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = ANDSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1428,7 +1586,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1447,7 +1605,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = XORSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1468,17 +1626,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = ADDSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1506,17 +1664,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     SI opval = ADDCSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1542,17 +1700,17 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = MUL2OFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1576,7 +1734,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = EXTHISI (TRUNCSIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1595,7 +1753,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = EXTQISI (TRUNCSIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1614,7 +1772,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = ZEXTHISI (TRUNCSIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1633,7 +1791,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = ZEXTQISI (TRUNCSIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1652,7 +1810,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = EXTSISI (TRUNCSISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1671,7 +1829,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     USI opval = ZEXTSISI (TRUNCSISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -1692,14 +1850,14 @@ if (GET_H_SYS_SR_F ()) {
     USI opval = GET_H_GPR (FLD (f_r2));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 } else {
   {
     USI opval = GET_H_GPR (FLD (f_r3));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 
@@ -1720,7 +1878,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1739,7 +1897,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1758,7 +1916,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1777,7 +1935,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1796,7 +1954,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1815,7 +1973,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1834,7 +1992,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1853,7 +2011,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1872,7 +2030,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1891,7 +2049,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1910,7 +2068,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1929,7 +2087,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1948,7 +2106,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1967,7 +2125,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -1986,7 +2144,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2005,7 +2163,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2024,7 +2182,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = EQSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2043,7 +2201,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = EQSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2062,7 +2220,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = NESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2081,7 +2239,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     USI opval = NESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2105,12 +2263,12 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2135,12 +2293,12 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2165,12 +2323,12 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2310,7 +2468,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2329,7 +2487,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->subsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2348,7 +2506,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2367,7 +2525,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->divsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2386,7 +2544,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->remsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2405,7 +2563,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->floatsisf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), TRUNCSISI (GET_H_GPR (FLD (f_r2))));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2424,7 +2582,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = EXTSISI (CGEN_CPU_FPU (current_cpu)->ops->fixsfsi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FSR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
 #undef FLD
@@ -2443,7 +2601,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2462,7 +2620,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->nesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2481,7 +2639,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2500,7 +2658,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2519,7 +2677,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2538,7 +2696,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->lesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2557,7 +2715,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), GET_H_FSR (FLD (f_r1)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
diff --git a/sim/or1k/sem32.c b/sim/or1k/sem32.c
index e8cbcc9..61d66cf 100644
--- a/sim/or1k/sem32.c
+++ b/sim/or1k/sem32.c
@@ -37,8 +37,8 @@ This file is part of the GNU simulators.
    FAST_P, when desired, is defined on the command line, -DFAST_P=1.  */
 #if FAST_P
 #define SEM_FN_NAME(cpu,fn) XCONCAT3 (cpu,_semf_,fn)
-#undef TRACE_RESULT
-#define TRACE_RESULT(cpu, abuf, name, type, val)
+#undef CGEN_TRACE_RESULT
+#define CGEN_TRACE_RESULT(cpu, abuf, name, type, val)
 #else
 #define SEM_FN_NAME(cpu,fn) XCONCAT3 (cpu,_sem_,fn)
 #endif
@@ -214,7 +214,7 @@ SEM_FN_NAME (or1k32bf,l_j) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -244,14 +244,14 @@ SEM_FN_NAME (or1k32bf,l_jal) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ADDSI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 {
 {
   {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -283,7 +283,7 @@ SEM_FN_NAME (or1k32bf,l_jr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -313,14 +313,14 @@ SEM_FN_NAME (or1k32bf,l_jalr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ADDSI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 {
 {
   {
     USI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -354,7 +354,7 @@ if (NOTSI (GET_H_SYS_SR_F ())) {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 } else {
@@ -364,7 +364,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     USI opval = ADDSI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 }
@@ -400,7 +400,7 @@ if (GET_H_SYS_SR_F ()) {
     USI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 } else {
@@ -410,7 +410,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     USI opval = ADDSI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'x', opval);
   }
 }
 }
@@ -461,6 +461,57 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_SYSCALL);
 #undef FLD
 }
 
+/* l-msync: l.msync */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_msync) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
+/* l-psync: l.psync */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_psync) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
+/* l-csync: l.csync */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_csync) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
 /* l-rfe: l.rfe */
 
 static SEM_PC
@@ -509,7 +560,7 @@ SEM_FN_NAME (or1k32bf,l_movhi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SLLSI (ZEXTSISI (FLD (f_uimm16)), 16);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -531,17 +582,17 @@ SEM_FN_NAME (or1k32bf,l_macrc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
   {
     USI opval = 0;
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
   {
     USI opval = 0;
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
 }
 
@@ -563,7 +614,7 @@ SEM_FN_NAME (or1k32bf,l_mfspr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = or1k32bf_mfspr (current_cpu, ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -601,7 +652,7 @@ SEM_FN_NAME (or1k32bf,l_lwz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ZEXTSISI (GETMEMUSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -622,8 +673,41 @@ SEM_FN_NAME (or1k32bf,l_lws) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = EXTSISI (GETMEMSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* l-lwa: l.lwa $rD,${simm16}($rA) */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_lwa) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  {
+    USI opval = ZEXTSISI (GETMEMUSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
+    SET_H_GPR (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+  }
+  {
+    BI opval = 1;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+  {
+    SI opval = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4);
+    CPU (h_atomic_address) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-address", 'x', opval);
   }
+}
 
   return vpc;
 #undef FLD
@@ -643,7 +727,7 @@ SEM_FN_NAME (or1k32bf,l_lbz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ZEXTQISI (GETMEMUQI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -664,7 +748,7 @@ SEM_FN_NAME (or1k32bf,l_lbs) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = EXTQISI (GETMEMQI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -685,7 +769,7 @@ SEM_FN_NAME (or1k32bf,l_lhz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ZEXTHISI (GETMEMUHI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -706,7 +790,7 @@ SEM_FN_NAME (or1k32bf,l_lhs) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = EXTHISI (GETMEMHI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -724,12 +808,25 @@ SEM_FN_NAME (or1k32bf,l_sw) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
   {
     USI opval = TRUNCSISI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUSI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
   }
+}
+}
 
+  abuf->written = written;
   return vpc;
 #undef FLD
 }
@@ -745,12 +842,25 @@ SEM_FN_NAME (or1k32bf,l_sb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1);
   {
     UQI opval = TRUNCSIQI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUQI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUQI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
   }
+}
+}
 
+  abuf->written = written;
   return vpc;
 #undef FLD
 }
@@ -766,12 +876,65 @@ SEM_FN_NAME (or1k32bf,l_sh) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2);
   {
     UHI opval = TRUNCSIHI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUHI (current_cpu, pc, or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUHI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
+
+  abuf->written = written;
+  return vpc;
+#undef FLD
+}
+
+/* l-swa: l.swa ${simm16-split}($rA),$rB */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_swa) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  BI tmp_flag;
+  tmp_addr = or1k32bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
+  {
+    USI opval = ANDBI (CPU (h_atomic_reserve), EQSI (tmp_addr, CPU (h_atomic_address)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+  }
+if (GET_H_SYS_SR_F ()) {
+  {
+    USI opval = TRUNCSISI (GET_H_GPR (FLD (f_r3)));
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    written |= (1 << 7);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+}
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+
+  abuf->written = written;
   return vpc;
 #undef FLD
 }
@@ -790,7 +953,7 @@ SEM_FN_NAME (or1k32bf,l_sll) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SLLSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -811,7 +974,7 @@ SEM_FN_NAME (or1k32bf,l_slli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SLLSI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -832,7 +995,7 @@ SEM_FN_NAME (or1k32bf,l_srl) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SRLSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -853,7 +1016,7 @@ SEM_FN_NAME (or1k32bf,l_srli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SRLSI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -874,7 +1037,7 @@ SEM_FN_NAME (or1k32bf,l_sra) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SRASI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -895,7 +1058,7 @@ SEM_FN_NAME (or1k32bf,l_srai) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = SRASI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -916,7 +1079,7 @@ SEM_FN_NAME (or1k32bf,l_ror) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = RORSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -937,7 +1100,7 @@ SEM_FN_NAME (or1k32bf,l_rori) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = RORSI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -958,7 +1121,7 @@ SEM_FN_NAME (or1k32bf,l_and) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ANDSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -979,7 +1142,7 @@ SEM_FN_NAME (or1k32bf,l_or) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ORSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1000,7 +1163,7 @@ SEM_FN_NAME (or1k32bf,l_xor) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = XORSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1023,17 +1186,17 @@ SEM_FN_NAME (or1k32bf,l_add) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = ADDSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1061,17 +1224,17 @@ SEM_FN_NAME (or1k32bf,l_sub) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = SUBCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = SUBOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = SUBSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1101,17 +1264,17 @@ SEM_FN_NAME (or1k32bf,l_addc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = ADDCSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1139,17 +1302,17 @@ SEM_FN_NAME (or1k32bf,l_mul) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = MUL2OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1177,17 +1340,17 @@ SEM_FN_NAME (or1k32bf,l_mulu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1217,13 +1380,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     SI opval = DIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
@@ -1231,13 +1394,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1267,13 +1430,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = UDIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
@@ -1281,13 +1444,13 @@ if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1313,7 +1476,7 @@ SEM_FN_NAME (or1k32bf,l_ff1) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = or1k32bf_ff1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1334,7 +1497,7 @@ SEM_FN_NAME (or1k32bf,l_fl1) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = or1k32bf_fl1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1355,7 +1518,7 @@ SEM_FN_NAME (or1k32bf,l_andi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ANDSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1376,7 +1539,7 @@ SEM_FN_NAME (or1k32bf,l_ori) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ORSI (GET_H_GPR (FLD (f_r2)), ZEXTSISI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1397,7 +1560,7 @@ SEM_FN_NAME (or1k32bf,l_xori) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = XORSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1420,17 +1583,17 @@ SEM_FN_NAME (or1k32bf,l_addi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = ADDSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1460,17 +1623,17 @@ SEM_FN_NAME (or1k32bf,l_addic) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     SI opval = ADDCSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1498,17 +1661,17 @@ SEM_FN_NAME (or1k32bf,l_muli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = MUL2OFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     USI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1534,7 +1697,7 @@ SEM_FN_NAME (or1k32bf,l_exths) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = EXTHISI (TRUNCSIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1555,7 +1718,7 @@ SEM_FN_NAME (or1k32bf,l_extbs) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = EXTQISI (TRUNCSIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1576,7 +1739,7 @@ SEM_FN_NAME (or1k32bf,l_exthz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ZEXTHISI (TRUNCSIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1597,7 +1760,7 @@ SEM_FN_NAME (or1k32bf,l_extbz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ZEXTQISI (TRUNCSIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1618,7 +1781,7 @@ SEM_FN_NAME (or1k32bf,l_extws) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = EXTSISI (TRUNCSISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1639,7 +1802,7 @@ SEM_FN_NAME (or1k32bf,l_extwz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = ZEXTSISI (TRUNCSISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -1662,14 +1825,14 @@ if (GET_H_SYS_SR_F ()) {
     USI opval = GET_H_GPR (FLD (f_r2));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 } else {
   {
     USI opval = GET_H_GPR (FLD (f_r3));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 
@@ -1692,7 +1855,7 @@ SEM_FN_NAME (or1k32bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1713,7 +1876,7 @@ SEM_FN_NAME (or1k32bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1734,7 +1897,7 @@ SEM_FN_NAME (or1k32bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1755,7 +1918,7 @@ SEM_FN_NAME (or1k32bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1776,7 +1939,7 @@ SEM_FN_NAME (or1k32bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1797,7 +1960,7 @@ SEM_FN_NAME (or1k32bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1818,7 +1981,7 @@ SEM_FN_NAME (or1k32bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1839,7 +2002,7 @@ SEM_FN_NAME (or1k32bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = GEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1860,7 +2023,7 @@ SEM_FN_NAME (or1k32bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LTSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1881,7 +2044,7 @@ SEM_FN_NAME (or1k32bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LTSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1902,7 +2065,7 @@ SEM_FN_NAME (or1k32bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1923,7 +2086,7 @@ SEM_FN_NAME (or1k32bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LTUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1944,7 +2107,7 @@ SEM_FN_NAME (or1k32bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1965,7 +2128,7 @@ SEM_FN_NAME (or1k32bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -1986,7 +2149,7 @@ SEM_FN_NAME (or1k32bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2007,7 +2170,7 @@ SEM_FN_NAME (or1k32bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = LEUSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2028,7 +2191,7 @@ SEM_FN_NAME (or1k32bf,l_sfeq) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = EQSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2049,7 +2212,7 @@ SEM_FN_NAME (or1k32bf,l_sfeqi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = EQSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2070,7 +2233,7 @@ SEM_FN_NAME (or1k32bf,l_sfne) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = NESI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2091,7 +2254,7 @@ SEM_FN_NAME (or1k32bf,l_sfnei) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     USI opval = NESI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2117,12 +2280,12 @@ SEM_FN_NAME (or1k32bf,l_mac) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2149,12 +2312,12 @@ SEM_FN_NAME (or1k32bf,l_msb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2181,12 +2344,12 @@ SEM_FN_NAME (or1k32bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2344,7 +2507,7 @@ SEM_FN_NAME (or1k32bf,lf_add_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2365,7 +2528,7 @@ SEM_FN_NAME (or1k32bf,lf_sub_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->subsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2386,7 +2549,7 @@ SEM_FN_NAME (or1k32bf,lf_mul_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2407,7 +2570,7 @@ SEM_FN_NAME (or1k32bf,lf_div_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->divsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2428,7 +2591,7 @@ SEM_FN_NAME (or1k32bf,lf_rem_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->remsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2449,7 +2612,7 @@ SEM_FN_NAME (or1k32bf,lf_itof_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->floatsisf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), TRUNCSISI (GET_H_GPR (FLD (f_r2))));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2470,7 +2633,7 @@ SEM_FN_NAME (or1k32bf,lf_ftoi_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = EXTSISI (CGEN_CPU_FPU (current_cpu)->ops->fixsfsi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FSR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 
   return vpc;
@@ -2491,7 +2654,7 @@ SEM_FN_NAME (or1k32bf,lf_eq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2512,7 +2675,7 @@ SEM_FN_NAME (or1k32bf,lf_ne_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->nesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2533,7 +2696,7 @@ SEM_FN_NAME (or1k32bf,lf_ge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2554,7 +2717,7 @@ SEM_FN_NAME (or1k32bf,lf_gt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2575,7 +2738,7 @@ SEM_FN_NAME (or1k32bf,lf_lt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2596,7 +2759,7 @@ SEM_FN_NAME (or1k32bf,lf_le_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->lesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2617,7 +2780,7 @@ SEM_FN_NAME (or1k32bf,lf_madd_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), GET_H_FSR (FLD (f_r1)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2658,6 +2821,9 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_BF, SEM_FN_NAME (or1k32bf,l_bf) },
   { OR1K32BF_INSN_L_TRAP, SEM_FN_NAME (or1k32bf,l_trap) },
   { OR1K32BF_INSN_L_SYS, SEM_FN_NAME (or1k32bf,l_sys) },
+  { OR1K32BF_INSN_L_MSYNC, SEM_FN_NAME (or1k32bf,l_msync) },
+  { OR1K32BF_INSN_L_PSYNC, SEM_FN_NAME (or1k32bf,l_psync) },
+  { OR1K32BF_INSN_L_CSYNC, SEM_FN_NAME (or1k32bf,l_csync) },
   { OR1K32BF_INSN_L_RFE, SEM_FN_NAME (or1k32bf,l_rfe) },
   { OR1K32BF_INSN_L_NOP_IMM, SEM_FN_NAME (or1k32bf,l_nop_imm) },
   { OR1K32BF_INSN_L_MOVHI, SEM_FN_NAME (or1k32bf,l_movhi) },
@@ -2666,6 +2832,7 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_MTSPR, SEM_FN_NAME (or1k32bf,l_mtspr) },
   { OR1K32BF_INSN_L_LWZ, SEM_FN_NAME (or1k32bf,l_lwz) },
   { OR1K32BF_INSN_L_LWS, SEM_FN_NAME (or1k32bf,l_lws) },
+  { OR1K32BF_INSN_L_LWA, SEM_FN_NAME (or1k32bf,l_lwa) },
   { OR1K32BF_INSN_L_LBZ, SEM_FN_NAME (or1k32bf,l_lbz) },
   { OR1K32BF_INSN_L_LBS, SEM_FN_NAME (or1k32bf,l_lbs) },
   { OR1K32BF_INSN_L_LHZ, SEM_FN_NAME (or1k32bf,l_lhz) },
@@ -2673,6 +2840,7 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_SW, SEM_FN_NAME (or1k32bf,l_sw) },
   { OR1K32BF_INSN_L_SB, SEM_FN_NAME (or1k32bf,l_sb) },
   { OR1K32BF_INSN_L_SH, SEM_FN_NAME (or1k32bf,l_sh) },
+  { OR1K32BF_INSN_L_SWA, SEM_FN_NAME (or1k32bf,l_swa) },
   { OR1K32BF_INSN_L_SLL, SEM_FN_NAME (or1k32bf,l_sll) },
   { OR1K32BF_INSN_L_SLLI, SEM_FN_NAME (or1k32bf,l_slli) },
   { OR1K32BF_INSN_L_SRL, SEM_FN_NAME (or1k32bf,l_srl) },
diff --git a/sim/or1k/sem64-switch.c b/sim/or1k/sem64-switch.c
index 9de4e16..1bb27e4 100644
--- a/sim/or1k/sem64-switch.c
+++ b/sim/or1k/sem64-switch.c
@@ -46,6 +46,9 @@ This file is part of the GNU simulators.
     { OR1K64BF_INSN_L_BF, && case_sem_INSN_L_BF },
     { OR1K64BF_INSN_L_TRAP, && case_sem_INSN_L_TRAP },
     { OR1K64BF_INSN_L_SYS, && case_sem_INSN_L_SYS },
+    { OR1K64BF_INSN_L_MSYNC, && case_sem_INSN_L_MSYNC },
+    { OR1K64BF_INSN_L_PSYNC, && case_sem_INSN_L_PSYNC },
+    { OR1K64BF_INSN_L_CSYNC, && case_sem_INSN_L_CSYNC },
     { OR1K64BF_INSN_L_RFE, && case_sem_INSN_L_RFE },
     { OR1K64BF_INSN_L_NOP_IMM, && case_sem_INSN_L_NOP_IMM },
     { OR1K64BF_INSN_L_MOVHI, && case_sem_INSN_L_MOVHI },
@@ -54,6 +57,7 @@ This file is part of the GNU simulators.
     { OR1K64BF_INSN_L_MTSPR, && case_sem_INSN_L_MTSPR },
     { OR1K64BF_INSN_L_LWZ, && case_sem_INSN_L_LWZ },
     { OR1K64BF_INSN_L_LWS, && case_sem_INSN_L_LWS },
+    { OR1K64BF_INSN_L_LWA, && case_sem_INSN_L_LWA },
     { OR1K64BF_INSN_L_LBZ, && case_sem_INSN_L_LBZ },
     { OR1K64BF_INSN_L_LBS, && case_sem_INSN_L_LBS },
     { OR1K64BF_INSN_L_LHZ, && case_sem_INSN_L_LHZ },
@@ -61,6 +65,7 @@ This file is part of the GNU simulators.
     { OR1K64BF_INSN_L_SW, && case_sem_INSN_L_SW },
     { OR1K64BF_INSN_L_SB, && case_sem_INSN_L_SB },
     { OR1K64BF_INSN_L_SH, && case_sem_INSN_L_SH },
+    { OR1K64BF_INSN_L_SWA, && case_sem_INSN_L_SWA },
     { OR1K64BF_INSN_L_SLL, && case_sem_INSN_L_SLL },
     { OR1K64BF_INSN_L_SLLI, && case_sem_INSN_L_SLLI },
     { OR1K64BF_INSN_L_SRL, && case_sem_INSN_L_SRL },
@@ -180,8 +185,8 @@ This file is part of the GNU simulators.
    special handlers into the instruction "stream".  */
 
 #if FAST_P
-#undef TRACE_RESULT
-#define TRACE_RESULT(cpu, abuf, name, type, val)
+#undef CGEN_TRACE_RESULT
+#define CGEN_TRACE_RESULT(cpu, abuf, name, type, val)
 #endif
 
 #undef GET_ATTR
@@ -369,7 +374,7 @@ SWITCH (sem, SEM_ARGBUF (vpc) -> semantic.sem_case)
   {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -397,14 +402,14 @@ if (1)
   {
     UDI opval = ADDDI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 {
 {
   {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -434,7 +439,7 @@ if (1)
   {
     UDI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -462,14 +467,14 @@ if (1)
   {
     UDI opval = ADDDI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 {
 {
   {
     UDI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -501,7 +506,7 @@ if (NOTDI (GET_H_SYS_SR_F ())) {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 } else {
@@ -511,7 +516,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     UDI opval = ADDDI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 }
@@ -545,7 +550,7 @@ if (GET_H_SYS_SR_F ()) {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 } else {
@@ -555,7 +560,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     UDI opval = ADDDI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 }
@@ -602,6 +607,51 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_SYSCALL);
 }
   NEXT (vpc);
 
+  CASE (sem, INSN_L_MSYNC) : /* l.msync */
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
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_PSYNC) : /* l.psync */
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
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_CSYNC) : /* l.csync */
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
+#undef FLD
+}
+  NEXT (vpc);
+
   CASE (sem, INSN_L_RFE) : /* l.rfe */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
@@ -644,7 +694,7 @@ or1k64bf_nop (current_cpu, ZEXTSIDI (FLD (f_uimm16)));
   {
     UDI opval = SLLDI (ZEXTSIDI (FLD (f_uimm16)), 16);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -664,17 +714,17 @@ or1k64bf_nop (current_cpu, ZEXTSIDI (FLD (f_uimm16)));
   {
     UDI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
   {
     UDI opval = 0;
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'D', opval);
   }
   {
     UDI opval = 0;
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'D', opval);
   }
 }
 
@@ -694,7 +744,7 @@ or1k64bf_nop (current_cpu, ZEXTSIDI (FLD (f_uimm16)));
   {
     UDI opval = or1k64bf_mfspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -728,7 +778,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = ZEXTSIDI (GETMEMUSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -747,13 +797,44 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     DI opval = EXTSIDI (GETMEMSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
 }
   NEXT (vpc);
 
+  CASE (sem, INSN_L_LWA) : /* l.lwa $rD,${simm16}($rA) */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  {
+    UDI opval = ZEXTSIDI (GETMEMUSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
+    SET_H_GPR (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+  }
+  {
+    BI opval = 1;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+  {
+    SI opval = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4);
+    CPU (h_atomic_address) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-address", 'x', opval);
+  }
+}
+
+#undef FLD
+}
+  NEXT (vpc);
+
   CASE (sem, INSN_L_LBZ) : /* l.lbz $rD,${simm16}($rA) */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
@@ -766,7 +847,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = ZEXTQIDI (GETMEMUQI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -785,7 +866,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     DI opval = EXTQIDI (GETMEMQI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -804,7 +885,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = ZEXTHIDI (GETMEMUHI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -823,7 +904,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     DI opval = EXTHIDI (GETMEMHI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -839,12 +920,25 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
   {
     USI opval = TRUNCDISI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
 
+  abuf->written = written;
 #undef FLD
 }
   NEXT (vpc);
@@ -858,12 +952,25 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1);
   {
     UQI opval = TRUNCDIQI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUQI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUQI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
 
+  abuf->written = written;
 #undef FLD
 }
   NEXT (vpc);
@@ -877,12 +984,63 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2);
   {
     UHI opval = TRUNCDIHI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUHI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUHI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
+
+  abuf->written = written;
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_SWA) : /* l.swa ${simm16-split}($rA),$rB */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sw.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  SI tmp_addr;
+  BI tmp_flag;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
+  {
+    UDI opval = ANDBI (CPU (h_atomic_reserve), EQSI (tmp_addr, CPU (h_atomic_address)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+  }
+if (GET_H_SYS_SR_F ()) {
+  {
+    USI opval = TRUNCDISI (GET_H_GPR (FLD (f_r3)));
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    written |= (1 << 7);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+}
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
 
+  abuf->written = written;
 #undef FLD
 }
   NEXT (vpc);
@@ -899,7 +1057,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = SLLDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -918,7 +1076,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = SLLDI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -937,7 +1095,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = SRLDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -956,7 +1114,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = SRLDI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -975,7 +1133,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = SRADI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -994,7 +1152,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = SRADI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1013,7 +1171,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = RORDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1032,7 +1190,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = RORDI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1051,7 +1209,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = ANDDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1070,7 +1228,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = ORDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1089,7 +1247,7 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     UDI opval = XORDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1110,17 +1268,17 @@ or1k64bf_mtspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = ADDDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1146,17 +1304,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = SUBCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = SUBOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = SUBDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1184,17 +1342,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = ADDCDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1220,17 +1378,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = MUL2OFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     UDI opval = MULDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1256,17 +1414,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     UDI opval = MULDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1294,13 +1452,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     DI opval = DIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 } else {
@@ -1308,13 +1466,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1342,13 +1500,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     UDI opval = UDIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 } else {
@@ -1356,13 +1514,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1386,7 +1544,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = or1k64bf_ff1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1405,7 +1563,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = or1k64bf_fl1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1424,7 +1582,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = ANDDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1443,7 +1601,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1462,7 +1620,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = XORDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1483,17 +1641,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = ADDDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1521,17 +1679,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     DI opval = ADDCDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1557,17 +1715,17 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = MUL2OFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'D', opval);
   }
   {
     UDI opval = MUL1OFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'D', opval);
   }
   {
     UDI opval = MULDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1591,7 +1749,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = EXTHIDI (TRUNCDIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1610,7 +1768,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = EXTQIDI (TRUNCDIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1629,7 +1787,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = ZEXTHIDI (TRUNCDIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1648,7 +1806,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = ZEXTQIDI (TRUNCDIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1667,7 +1825,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = EXTSIDI (TRUNCDISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1686,7 +1844,7 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
   {
     UDI opval = ZEXTSISI (TRUNCDISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -1707,14 +1865,14 @@ if (GET_H_SYS_SR_F ()) {
     UDI opval = GET_H_GPR (FLD (f_r2));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 } else {
   {
     UDI opval = GET_H_GPR (FLD (f_r3));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 
@@ -1735,7 +1893,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1754,7 +1912,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1773,7 +1931,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1792,7 +1950,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1811,7 +1969,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1830,7 +1988,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1849,7 +2007,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1868,7 +2026,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1887,7 +2045,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1906,7 +2064,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1925,7 +2083,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1944,7 +2102,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1963,7 +2121,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -1982,7 +2140,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2001,7 +2159,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2020,7 +2178,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2039,7 +2197,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = EQDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2058,7 +2216,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = EQDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2077,7 +2235,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = NEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2096,7 +2254,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     UDI opval = NEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
 #undef FLD
@@ -2120,12 +2278,12 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2150,12 +2308,12 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2180,12 +2338,12 @@ if (GET_H_SYS_SR_F ()) {
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2325,7 +2483,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2344,7 +2502,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
@@ -2363,7 +2521,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->subsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2382,7 +2540,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->subdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
@@ -2401,7 +2559,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2420,7 +2578,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
@@ -2439,7 +2597,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->divsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2458,7 +2616,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->divdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
@@ -2477,7 +2635,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->remsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2496,7 +2654,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->moddf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
@@ -2515,7 +2673,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->floatsisf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), TRUNCDISI (GET_H_GPR (FLD (f_r2))));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2534,7 +2692,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->floatdidf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_GPR (FLD (f_r2)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
@@ -2553,7 +2711,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DI opval = EXTSIDI (CGEN_CPU_FPU (current_cpu)->ops->fixsfsi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FSR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -2572,7 +2730,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DI opval = CGEN_CPU_FPU (current_cpu)->ops->fixdfdi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FDR (FLD (f_r1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
 #undef FLD
@@ -2591,7 +2749,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2610,7 +2768,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2629,7 +2787,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->nesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2648,7 +2806,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2667,7 +2825,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2686,7 +2844,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2705,7 +2863,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2724,7 +2882,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2743,7 +2901,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2762,7 +2920,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2781,7 +2939,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->lesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2800,7 +2958,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
 #undef FLD
@@ -2819,7 +2977,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), GET_H_FSR (FLD (f_r1)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
 #undef FLD
@@ -2838,7 +2996,7 @@ if (GET_H_SYS_SR_F ()) {
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1))), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
 #undef FLD
diff --git a/sim/or1k/sem64.c b/sim/or1k/sem64.c
index 08bc8bb..8b6c504 100644
--- a/sim/or1k/sem64.c
+++ b/sim/or1k/sem64.c
@@ -37,8 +37,8 @@ This file is part of the GNU simulators.
    FAST_P, when desired, is defined on the command line, -DFAST_P=1.  */
 #if FAST_P
 #define SEM_FN_NAME(cpu,fn) XCONCAT3 (cpu,_semf_,fn)
-#undef TRACE_RESULT
-#define TRACE_RESULT(cpu, abuf, name, type, val)
+#undef CGEN_TRACE_RESULT
+#define CGEN_TRACE_RESULT(cpu, abuf, name, type, val)
 #else
 #define SEM_FN_NAME(cpu,fn) XCONCAT3 (cpu,_sem_,fn)
 #endif
@@ -214,7 +214,7 @@ SEM_FN_NAME (or1k64bf,l_j) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -244,14 +244,14 @@ SEM_FN_NAME (or1k64bf,l_jal) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ADDDI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 {
 {
   {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -283,7 +283,7 @@ SEM_FN_NAME (or1k64bf,l_jr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -313,14 +313,14 @@ SEM_FN_NAME (or1k64bf,l_jalr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ADDDI (pc, ((GET_H_SYS_CPUCFGR_ND ()) ? (4) : (8)));
     SET_H_GPR (((UINT) 9), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 {
 {
   {
     UDI opval = GET_H_GPR (FLD (f_r3));
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 if (GET_H_SYS_CPUCFGR_ND ()) {
@@ -354,7 +354,7 @@ if (NOTDI (GET_H_SYS_SR_F ())) {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 } else {
@@ -364,7 +364,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     UDI opval = ADDDI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 }
@@ -400,7 +400,7 @@ if (GET_H_SYS_SR_F ()) {
     UDI opval = FLD (i_disp26);
     SEM_BRANCH_VIA_CACHE (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 } else {
@@ -410,7 +410,7 @@ if (GET_H_SYS_CPUCFGR_ND ()) {
     UDI opval = ADDDI (pc, 4);
     SEM_BRANCH_VIA_ADDR (current_cpu, sem_arg, opval, vpc);
     written |= (1 << 4);
-    TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "pc", 'D', opval);
   }
 }
 }
@@ -461,6 +461,57 @@ or1k64bf_exception (current_cpu, pc, EXCEPT_SYSCALL);
 #undef FLD
 }
 
+/* l-msync: l.msync */
+
+static SEM_PC
+SEM_FN_NAME (or1k64bf,l_msync) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
+/* l-psync: l.psync */
+
+static SEM_PC
+SEM_FN_NAME (or1k64bf,l_psync) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
+/* l-csync: l.csync */
+
+static SEM_PC
+SEM_FN_NAME (or1k64bf,l_csync) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
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
 /* l-rfe: l.rfe */
 
 static SEM_PC
@@ -509,7 +560,7 @@ SEM_FN_NAME (or1k64bf,l_movhi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SLLDI (ZEXTSIDI (FLD (f_uimm16)), 16);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -531,17 +582,17 @@ SEM_FN_NAME (or1k64bf,l_macrc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GET_H_MAC_MACLO ();
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
   {
     UDI opval = 0;
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'D', opval);
   }
   {
     UDI opval = 0;
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'D', opval);
   }
 }
 
@@ -563,7 +614,7 @@ SEM_FN_NAME (or1k64bf,l_mfspr) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = or1k64bf_mfspr (current_cpu, ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -601,7 +652,7 @@ SEM_FN_NAME (or1k64bf,l_lwz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ZEXTSIDI (GETMEMUSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -622,8 +673,41 @@ SEM_FN_NAME (or1k64bf,l_lws) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DI opval = EXTSIDI (GETMEMSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
+/* l-lwa: l.lwa $rD,${simm16}($rA) */
+
+static SEM_PC
+SEM_FN_NAME (or1k64bf,l_lwa) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  {
+    UDI opval = ZEXTSIDI (GETMEMUSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4)));
+    SET_H_GPR (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+  }
+  {
+    BI opval = 1;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+  {
+    SI opval = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 4);
+    CPU (h_atomic_address) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-address", 'x', opval);
   }
+}
 
   return vpc;
 #undef FLD
@@ -643,7 +727,7 @@ SEM_FN_NAME (or1k64bf,l_lbz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ZEXTQIDI (GETMEMUQI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -664,7 +748,7 @@ SEM_FN_NAME (or1k64bf,l_lbs) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DI opval = EXTQIDI (GETMEMQI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -685,7 +769,7 @@ SEM_FN_NAME (or1k64bf,l_lhz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ZEXTHIDI (GETMEMUHI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -706,7 +790,7 @@ SEM_FN_NAME (or1k64bf,l_lhs) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DI opval = EXTHIDI (GETMEMHI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)), 2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -724,12 +808,25 @@ SEM_FN_NAME (or1k64bf,l_sw) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
   {
     USI opval = TRUNCDISI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUSI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
   }
+}
+}
 
+  abuf->written = written;
   return vpc;
 #undef FLD
 }
@@ -745,12 +842,25 @@ SEM_FN_NAME (or1k64bf,l_sb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1);
   {
     UQI opval = TRUNCDIQI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUQI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 1), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUQI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
   }
+}
+}
 
+  abuf->written = written;
   return vpc;
 #undef FLD
 }
@@ -766,12 +876,65 @@ SEM_FN_NAME (or1k64bf,l_sh) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2);
   {
     UHI opval = TRUNCDIHI (GET_H_GPR (FLD (f_r3)));
-    SETMEMUHI (current_cpu, pc, or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 2), opval);
-    TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+    SETMEMUHI (current_cpu, pc, tmp_addr, opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
   }
+if (EQSI (ANDSI (tmp_addr, 268435452), CPU (h_atomic_address))) {
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    written |= (1 << 4);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+}
+
+  abuf->written = written;
+  return vpc;
+#undef FLD
+}
+
+/* l-swa: l.swa ${simm16-split}($rA),$rB */
+
+static SEM_PC
+SEM_FN_NAME (or1k64bf,l_swa) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sw.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
+{
+  SI tmp_addr;
+  BI tmp_flag;
+  tmp_addr = or1k64bf_make_load_store_addr (current_cpu, GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16_split)), 4);
+  {
+    UDI opval = ANDBI (CPU (h_atomic_reserve), EQSI (tmp_addr, CPU (h_atomic_address)));
+    SET_H_SYS_SR_F (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+  }
+if (GET_H_SYS_SR_F ()) {
+  {
+    USI opval = TRUNCDISI (GET_H_GPR (FLD (f_r3)));
+    SETMEMUSI (current_cpu, pc, tmp_addr, opval);
+    written |= (1 << 7);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "memory", 'x', opval);
+  }
+}
+  {
+    BI opval = 0;
+    CPU (h_atomic_reserve) = opval;
+    CGEN_TRACE_RESULT (current_cpu, abuf, "atomic-reserve", 'x', opval);
+  }
+}
+
+  abuf->written = written;
   return vpc;
 #undef FLD
 }
@@ -790,7 +953,7 @@ SEM_FN_NAME (or1k64bf,l_sll) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SLLDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -811,7 +974,7 @@ SEM_FN_NAME (or1k64bf,l_slli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SLLDI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -832,7 +995,7 @@ SEM_FN_NAME (or1k64bf,l_srl) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SRLDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -853,7 +1016,7 @@ SEM_FN_NAME (or1k64bf,l_srli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SRLDI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -874,7 +1037,7 @@ SEM_FN_NAME (or1k64bf,l_sra) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SRADI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -895,7 +1058,7 @@ SEM_FN_NAME (or1k64bf,l_srai) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = SRADI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -916,7 +1079,7 @@ SEM_FN_NAME (or1k64bf,l_ror) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = RORDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -937,7 +1100,7 @@ SEM_FN_NAME (or1k64bf,l_rori) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = RORDI (GET_H_GPR (FLD (f_r2)), FLD (f_uimm6));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -958,7 +1121,7 @@ SEM_FN_NAME (or1k64bf,l_and) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ANDDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -979,7 +1142,7 @@ SEM_FN_NAME (or1k64bf,l_or) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ORDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1000,7 +1163,7 @@ SEM_FN_NAME (or1k64bf,l_xor) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = XORDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1023,17 +1186,17 @@ SEM_FN_NAME (or1k64bf,l_add) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = ADDDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1061,17 +1224,17 @@ SEM_FN_NAME (or1k64bf,l_sub) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = SUBCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = SUBOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = SUBDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1101,17 +1264,17 @@ SEM_FN_NAME (or1k64bf,l_addc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = ADDCDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1139,17 +1302,17 @@ SEM_FN_NAME (or1k64bf,l_mul) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = MUL2OFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     UDI opval = MULDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1177,17 +1340,17 @@ SEM_FN_NAME (or1k64bf,l_mulu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     BI opval = MUL1OFDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     UDI opval = MULDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1217,13 +1380,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     DI opval = DIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 } else {
@@ -1231,13 +1394,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1267,13 +1430,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     UDI opval = UDIVDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 5);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 } else {
@@ -1281,13 +1444,13 @@ if (NEDI (GET_H_GPR (FLD (f_r3)), 0)) {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
     written |= (1 << 6);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
 }
   {
     BI opval = 0;
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
 if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k64bf_exception (current_cpu, pc, EXCEPT_RANGE);
@@ -1313,7 +1476,7 @@ SEM_FN_NAME (or1k64bf,l_ff1) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = or1k64bf_ff1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1334,7 +1497,7 @@ SEM_FN_NAME (or1k64bf,l_fl1) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = or1k64bf_fl1 (current_cpu, GET_H_GPR (FLD (f_r2)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1355,7 +1518,7 @@ SEM_FN_NAME (or1k64bf,l_andi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ANDDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1376,7 +1539,7 @@ SEM_FN_NAME (or1k64bf,l_ori) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ORDI (GET_H_GPR (FLD (f_r2)), ZEXTSIDI (FLD (f_uimm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1397,7 +1560,7 @@ SEM_FN_NAME (or1k64bf,l_xori) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = XORDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1420,17 +1583,17 @@ SEM_FN_NAME (or1k64bf,l_addi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), 0);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     UDI opval = ADDDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1460,17 +1623,17 @@ SEM_FN_NAME (or1k64bf,l_addic) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = ADDCFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     BI opval = ADDOFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     DI opval = ADDCDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)), tmp_tmp_sys_sr_cy);
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1498,17 +1661,17 @@ SEM_FN_NAME (or1k64bf,l_muli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = MUL2OFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_OV (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'D', opval);
   }
   {
     UDI opval = MUL1OFDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_CY (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'D', opval);
   }
   {
     UDI opval = MULDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
@@ -1534,7 +1697,7 @@ SEM_FN_NAME (or1k64bf,l_exths) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = EXTHIDI (TRUNCDIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1555,7 +1718,7 @@ SEM_FN_NAME (or1k64bf,l_extbs) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = EXTQIDI (TRUNCDIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1576,7 +1739,7 @@ SEM_FN_NAME (or1k64bf,l_exthz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ZEXTHIDI (TRUNCDIHI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1597,7 +1760,7 @@ SEM_FN_NAME (or1k64bf,l_extbz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ZEXTQIDI (TRUNCDIQI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1618,7 +1781,7 @@ SEM_FN_NAME (or1k64bf,l_extws) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = EXTSIDI (TRUNCDISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1639,7 +1802,7 @@ SEM_FN_NAME (or1k64bf,l_extwz) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = ZEXTSISI (TRUNCDISI (GET_H_GPR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -1662,14 +1825,14 @@ if (GET_H_SYS_SR_F ()) {
     UDI opval = GET_H_GPR (FLD (f_r2));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 } else {
   {
     UDI opval = GET_H_GPR (FLD (f_r3));
     SET_H_GPR (FLD (f_r1), opval);
     written |= (1 << 3);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 }
 
@@ -1692,7 +1855,7 @@ SEM_FN_NAME (or1k64bf,l_sfgts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1713,7 +1876,7 @@ SEM_FN_NAME (or1k64bf,l_sfgtsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1734,7 +1897,7 @@ SEM_FN_NAME (or1k64bf,l_sfgtu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1755,7 +1918,7 @@ SEM_FN_NAME (or1k64bf,l_sfgtui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1776,7 +1939,7 @@ SEM_FN_NAME (or1k64bf,l_sfges) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1797,7 +1960,7 @@ SEM_FN_NAME (or1k64bf,l_sfgesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1818,7 +1981,7 @@ SEM_FN_NAME (or1k64bf,l_sfgeu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1839,7 +2002,7 @@ SEM_FN_NAME (or1k64bf,l_sfgeui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = GEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1860,7 +2023,7 @@ SEM_FN_NAME (or1k64bf,l_sflts) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1881,7 +2044,7 @@ SEM_FN_NAME (or1k64bf,l_sfltsi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LTDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1902,7 +2065,7 @@ SEM_FN_NAME (or1k64bf,l_sfltu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1923,7 +2086,7 @@ SEM_FN_NAME (or1k64bf,l_sfltui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LTUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1944,7 +2107,7 @@ SEM_FN_NAME (or1k64bf,l_sfles) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1965,7 +2128,7 @@ SEM_FN_NAME (or1k64bf,l_sflesi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -1986,7 +2149,7 @@ SEM_FN_NAME (or1k64bf,l_sfleu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -2007,7 +2170,7 @@ SEM_FN_NAME (or1k64bf,l_sfleui) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = LEUDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -2028,7 +2191,7 @@ SEM_FN_NAME (or1k64bf,l_sfeq) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = EQDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -2049,7 +2212,7 @@ SEM_FN_NAME (or1k64bf,l_sfeqi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = EQDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -2070,7 +2233,7 @@ SEM_FN_NAME (or1k64bf,l_sfne) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = NEDI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -2091,7 +2254,7 @@ SEM_FN_NAME (or1k64bf,l_sfnei) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     UDI opval = NEDI (GET_H_GPR (FLD (f_r2)), EXTSIDI (FLD (f_simm16)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'D', opval);
   }
 
   return vpc;
@@ -2117,12 +2280,12 @@ SEM_FN_NAME (or1k64bf,l_mac) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2149,12 +2312,12 @@ SEM_FN_NAME (or1k64bf,l_msb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2181,12 +2344,12 @@ SEM_FN_NAME (or1k64bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
   }
   {
     SI opval = SUBWORDDISI (tmp_result, 1);
     SET_H_MAC_MACLO (opval);
-    TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
 }
 
@@ -2344,7 +2507,7 @@ SEM_FN_NAME (or1k64bf,lf_add_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2365,7 +2528,7 @@ SEM_FN_NAME (or1k64bf,lf_add_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2386,7 +2549,7 @@ SEM_FN_NAME (or1k64bf,lf_sub_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->subsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2407,7 +2570,7 @@ SEM_FN_NAME (or1k64bf,lf_sub_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->subdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2428,7 +2591,7 @@ SEM_FN_NAME (or1k64bf,lf_mul_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2449,7 +2612,7 @@ SEM_FN_NAME (or1k64bf,lf_mul_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2470,7 +2633,7 @@ SEM_FN_NAME (or1k64bf,lf_div_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->divsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2491,7 +2654,7 @@ SEM_FN_NAME (or1k64bf,lf_div_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->divdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2512,7 +2675,7 @@ SEM_FN_NAME (or1k64bf,lf_rem_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->remsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2533,7 +2696,7 @@ SEM_FN_NAME (or1k64bf,lf_rem_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->moddf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2554,7 +2717,7 @@ SEM_FN_NAME (or1k64bf,lf_itof_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->floatsisf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), TRUNCDISI (GET_H_GPR (FLD (f_r2))));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2575,7 +2738,7 @@ SEM_FN_NAME (or1k64bf,lf_itof_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->floatdidf (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_GPR (FLD (f_r2)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2596,7 +2759,7 @@ SEM_FN_NAME (or1k64bf,lf_ftoi_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DI opval = EXTSIDI (CGEN_CPU_FPU (current_cpu)->ops->fixsfsi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FSR (FLD (f_r2))));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -2617,7 +2780,7 @@ SEM_FN_NAME (or1k64bf,lf_ftoi_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DI opval = CGEN_CPU_FPU (current_cpu)->ops->fixdfdi (CGEN_CPU_FPU (current_cpu), (GET_H_SYS_FPCSR_RM () == 0) ? (1) : (GET_H_SYS_FPCSR_RM () == 1) ? (3) : (GET_H_SYS_FPCSR_RM () == 2) ? (4) : (5), GET_H_FDR (FLD (f_r1)));
     SET_H_GPR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'D', opval);
   }
 
   return vpc;
@@ -2638,7 +2801,7 @@ SEM_FN_NAME (or1k64bf,lf_eq_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2659,7 +2822,7 @@ SEM_FN_NAME (or1k64bf,lf_eq_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->eqdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2680,7 +2843,7 @@ SEM_FN_NAME (or1k64bf,lf_ne_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->nesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2701,7 +2864,7 @@ SEM_FN_NAME (or1k64bf,lf_ne_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->nedf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2722,7 +2885,7 @@ SEM_FN_NAME (or1k64bf,lf_ge_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2743,7 +2906,7 @@ SEM_FN_NAME (or1k64bf,lf_ge_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gedf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2764,7 +2927,7 @@ SEM_FN_NAME (or1k64bf,lf_gt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2785,7 +2948,7 @@ SEM_FN_NAME (or1k64bf,lf_gt_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->gtdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2806,7 +2969,7 @@ SEM_FN_NAME (or1k64bf,lf_lt_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2827,7 +2990,7 @@ SEM_FN_NAME (or1k64bf,lf_lt_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ltdf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2848,7 +3011,7 @@ SEM_FN_NAME (or1k64bf,lf_le_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->lesf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2869,7 +3032,7 @@ SEM_FN_NAME (or1k64bf,lf_le_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     BI opval = CGEN_CPU_FPU (current_cpu)->ops->ledf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1)));
     SET_H_SYS_SR_F (opval);
-    TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-f", 'x', opval);
   }
 
   return vpc;
@@ -2890,7 +3053,7 @@ SEM_FN_NAME (or1k64bf,lf_madd_s) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     SF opval = CGEN_CPU_FPU (current_cpu)->ops->addsf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->mulsf (CGEN_CPU_FPU (current_cpu), GET_H_FSR (FLD (f_r2)), GET_H_FSR (FLD (f_r3))), GET_H_FSR (FLD (f_r1)));
     SET_H_FSR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fsr", 'f', opval);
   }
 
   return vpc;
@@ -2911,7 +3074,7 @@ SEM_FN_NAME (or1k64bf,lf_madd_d) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   {
     DF opval = CGEN_CPU_FPU (current_cpu)->ops->adddf (CGEN_CPU_FPU (current_cpu), CGEN_CPU_FPU (current_cpu)->ops->muldf (CGEN_CPU_FPU (current_cpu), GET_H_FDR (FLD (f_r1)), GET_H_FDR (FLD (f_r1))), GET_H_FDR (FLD (f_r1)));
     SET_H_FDR (FLD (f_r1), opval);
-    TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "fdr", 'f', opval);
   }
 
   return vpc;
@@ -2969,6 +3132,9 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K64BF_INSN_L_BF, SEM_FN_NAME (or1k64bf,l_bf) },
   { OR1K64BF_INSN_L_TRAP, SEM_FN_NAME (or1k64bf,l_trap) },
   { OR1K64BF_INSN_L_SYS, SEM_FN_NAME (or1k64bf,l_sys) },
+  { OR1K64BF_INSN_L_MSYNC, SEM_FN_NAME (or1k64bf,l_msync) },
+  { OR1K64BF_INSN_L_PSYNC, SEM_FN_NAME (or1k64bf,l_psync) },
+  { OR1K64BF_INSN_L_CSYNC, SEM_FN_NAME (or1k64bf,l_csync) },
   { OR1K64BF_INSN_L_RFE, SEM_FN_NAME (or1k64bf,l_rfe) },
   { OR1K64BF_INSN_L_NOP_IMM, SEM_FN_NAME (or1k64bf,l_nop_imm) },
   { OR1K64BF_INSN_L_MOVHI, SEM_FN_NAME (or1k64bf,l_movhi) },
@@ -2977,6 +3143,7 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K64BF_INSN_L_MTSPR, SEM_FN_NAME (or1k64bf,l_mtspr) },
   { OR1K64BF_INSN_L_LWZ, SEM_FN_NAME (or1k64bf,l_lwz) },
   { OR1K64BF_INSN_L_LWS, SEM_FN_NAME (or1k64bf,l_lws) },
+  { OR1K64BF_INSN_L_LWA, SEM_FN_NAME (or1k64bf,l_lwa) },
   { OR1K64BF_INSN_L_LBZ, SEM_FN_NAME (or1k64bf,l_lbz) },
   { OR1K64BF_INSN_L_LBS, SEM_FN_NAME (or1k64bf,l_lbs) },
   { OR1K64BF_INSN_L_LHZ, SEM_FN_NAME (or1k64bf,l_lhz) },
@@ -2984,6 +3151,7 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K64BF_INSN_L_SW, SEM_FN_NAME (or1k64bf,l_sw) },
   { OR1K64BF_INSN_L_SB, SEM_FN_NAME (or1k64bf,l_sb) },
   { OR1K64BF_INSN_L_SH, SEM_FN_NAME (or1k64bf,l_sh) },
+  { OR1K64BF_INSN_L_SWA, SEM_FN_NAME (or1k64bf,l_swa) },
   { OR1K64BF_INSN_L_SLL, SEM_FN_NAME (or1k64bf,l_sll) },
   { OR1K64BF_INSN_L_SLLI, SEM_FN_NAME (or1k64bf,l_slli) },
   { OR1K64BF_INSN_L_SRL, SEM_FN_NAME (or1k64bf,l_srl) },
-- 
2.7.4


