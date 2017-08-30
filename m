From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 06:58:32 +0900
Subject: [OpenRISC] [PATCH 01/13] openrisc: use shadow registers to save
	regs on exception
In-Reply-To: <cover.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
Message-ID: <45e5b91f645a51c3c7a7410f0c67676c5c8193e0.1504129273.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Previously, the area between 0x0-0x100 have been used as a
"scratch" memory area to temporarily store regs during
exception entry.
In a multi-core environment, this will not work.

This change is to use shadow registers for nested context.

Currently only the "critical" temp load/stores are covered,
the EMERGENCY_PRINT ones are left as is (when they are used,
it's game over anyway), they need to be handled as well in the
future.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig       | 10 +++++
 arch/openrisc/kernel/head.S | 95 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 1e95920b0737..ba8ae92ec5fb 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -121,6 +121,16 @@ config OPENRISC_NO_SPR_SR_DSX
 	  Say N here if you know that your OpenRISC processor has
 	  SPR_SR_DSX bit implemented. Say Y if you are unsure.
 
+config OPENRISC_HAVE_SHADOW_GPRS
+	bool "Support for shadow gpr files"
+	help
+	  Say Y here if your OpenRISC processor features shadowed
+	  register files. They will in such case be used as a
+	  scratch reg storage on exception entry.
+
+	  On SMP systems, this feature is mandatory.
+	  On a unicore system it's safe to say N here if you are unsure.
+
 config CMDLINE
         string "Default kernel command string"
         default ""
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 1e87913576e3..1e49895408f4 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -49,9 +49,31 @@
 
 /* ============================================[ tmp store locations ]=== */
 
+#define SPR_SHADOW_GPR(x)	((x) + SPR_GPR_BASE + 32)
+
 /*
  * emergency_print temporary stores
  */
+#ifdef CONFIG_OPENRISC_HAVE_SHADOW_GPRS
+#define EMERGENCY_PRINT_STORE_GPR4	l.mtspr r0,r4,SPR_SHADOW_GPR(14)
+#define EMERGENCY_PRINT_LOAD_GPR4	l.mfspr r4,r0,SPR_SHADOW_GPR(14)
+
+#define EMERGENCY_PRINT_STORE_GPR5	l.mtspr r0,r5,SPR_SHADOW_GPR(15)
+#define EMERGENCY_PRINT_LOAD_GPR5	l.mfspr r5,r0,SPR_SHADOW_GPR(15)
+
+#define EMERGENCY_PRINT_STORE_GPR6	l.mtspr r0,r6,SPR_SHADOW_GPR(16)
+#define EMERGENCY_PRINT_LOAD_GPR6	l.mfspr r6,r0,SPR_SHADOW_GPR(16)
+
+#define EMERGENCY_PRINT_STORE_GPR7	l.mtspr r0,r7,SPR_SHADOW_GPR(7)
+#define EMERGENCY_PRINT_LOAD_GPR7	l.mfspr r7,r0,SPR_SHADOW_GPR(7)
+
+#define EMERGENCY_PRINT_STORE_GPR8	l.mtspr r0,r8,SPR_SHADOW_GPR(8)
+#define EMERGENCY_PRINT_LOAD_GPR8	l.mfspr r8,r0,SPR_SHADOW_GPR(8)
+
+#define EMERGENCY_PRINT_STORE_GPR9	l.mtspr r0,r9,SPR_SHADOW_GPR(9)
+#define EMERGENCY_PRINT_LOAD_GPR9	l.mfspr r9,r0,SPR_SHADOW_GPR(9)
+
+#else /* !CONFIG_OPENRISC_HAVE_SHADOW_GPRS */
 #define EMERGENCY_PRINT_STORE_GPR4	l.sw    0x20(r0),r4
 #define EMERGENCY_PRINT_LOAD_GPR4	l.lwz   r4,0x20(r0)
 
@@ -70,13 +92,28 @@
 #define EMERGENCY_PRINT_STORE_GPR9	l.sw    0x34(r0),r9
 #define EMERGENCY_PRINT_LOAD_GPR9	l.lwz   r9,0x34(r0)
 
+#endif
 
 /*
  * TLB miss handlers temorary stores
  */
-#define EXCEPTION_STORE_GPR9		l.sw    0x10(r0),r9
-#define EXCEPTION_LOAD_GPR9		l.lwz   r9,0x10(r0)
+#ifdef CONFIG_OPENRISC_HAVE_SHADOW_GPRS
+#define EXCEPTION_STORE_GPR2		l.mtspr r0,r2,SPR_SHADOW_GPR(2)
+#define EXCEPTION_LOAD_GPR2		l.mfspr r2,r0,SPR_SHADOW_GPR(2)
+
+#define EXCEPTION_STORE_GPR3		l.mtspr r0,r3,SPR_SHADOW_GPR(3)
+#define EXCEPTION_LOAD_GPR3		l.mfspr r3,r0,SPR_SHADOW_GPR(3)
 
+#define EXCEPTION_STORE_GPR4		l.mtspr r0,r4,SPR_SHADOW_GPR(4)
+#define EXCEPTION_LOAD_GPR4		l.mfspr r4,r0,SPR_SHADOW_GPR(4)
+
+#define EXCEPTION_STORE_GPR5		l.mtspr r0,r5,SPR_SHADOW_GPR(5)
+#define EXCEPTION_LOAD_GPR5		l.mfspr r5,r0,SPR_SHADOW_GPR(5)
+
+#define EXCEPTION_STORE_GPR6		l.mtspr r0,r6,SPR_SHADOW_GPR(6)
+#define EXCEPTION_LOAD_GPR6		l.mfspr r6,r0,SPR_SHADOW_GPR(6)
+
+#else /* !CONFIG_OPENRISC_HAVE_SHADOW_GPRS */
 #define EXCEPTION_STORE_GPR2		l.sw    0x64(r0),r2
 #define EXCEPTION_LOAD_GPR2		l.lwz   r2,0x64(r0)
 
@@ -92,26 +129,32 @@
 #define EXCEPTION_STORE_GPR6		l.sw    0x74(r0),r6
 #define EXCEPTION_LOAD_GPR6		l.lwz   r6,0x74(r0)
 
+#endif
 
 /*
  * EXCEPTION_HANDLE temporary stores
  */
 
+#ifdef CONFIG_OPENRISC_HAVE_SHADOW_GPRS
+#define EXCEPTION_T_STORE_GPR30		l.mtspr r0,r30,SPR_SHADOW_GPR(30)
+#define EXCEPTION_T_LOAD_GPR30(reg)	l.mfspr reg,r0,SPR_SHADOW_GPR(30)
+
+#define EXCEPTION_T_STORE_GPR10		l.mtspr r0,r10,SPR_SHADOW_GPR(10)
+#define EXCEPTION_T_LOAD_GPR10(reg)	l.mfspr reg,r0,SPR_SHADOW_GPR(10)
+
+#define EXCEPTION_T_STORE_SP		l.mtspr r0,r1,SPR_SHADOW_GPR(1)
+#define EXCEPTION_T_LOAD_SP(reg)	l.mfspr reg,r0,SPR_SHADOW_GPR(1)
+
+#else /* !CONFIG_OPENRISC_HAVE_SHADOW_GPRS */
 #define EXCEPTION_T_STORE_GPR30		l.sw    0x78(r0),r30
 #define EXCEPTION_T_LOAD_GPR30(reg)	l.lwz   reg,0x78(r0)
 
 #define EXCEPTION_T_STORE_GPR10		l.sw    0x7c(r0),r10
 #define EXCEPTION_T_LOAD_GPR10(reg)	l.lwz   reg,0x7c(r0)
 
-#define EXCEPTION_T_STORE_SP		l.sw	0x80(r0),r1
+#define EXCEPTION_T_STORE_SP		l.sw    0x80(r0),r1
 #define EXCEPTION_T_LOAD_SP(reg)	l.lwz   reg,0x80(r0)
-
-/*
- * For UNHANLDED_EXCEPTION
- */
-
-#define EXCEPTION_T_STORE_GPR31		l.sw    0x84(r0),r31
-#define EXCEPTION_T_LOAD_GPR31(reg)	l.lwz   reg,0x84(r0)
+#endif
 
 /* =========================================================[ macros ]=== */
 
@@ -226,7 +269,7 @@
  *
  */
 #define UNHANDLED_EXCEPTION(handler)				\
-	EXCEPTION_T_STORE_GPR31					;\
+	EXCEPTION_T_STORE_GPR30					;\
 	EXCEPTION_T_STORE_GPR10					;\
 	EXCEPTION_T_STORE_SP					;\
 	/* temporary store r3, r9 into r1, r10 */		;\
@@ -255,35 +298,35 @@
 	/* r1: KSP, r10: current, r31: __pa(KSP) */		;\
 	/* r12:	temp, syscall indicator, r13 temp */		;\
 	l.addi  r1,r1,-(INT_FRAME_SIZE)				;\
-	/* r1 is KSP, r31 is __pa(KSP) */			;\
-	tophys  (r31,r1)					;\
-	l.sw    PT_GPR12(r31),r12					;\
+	/* r1 is KSP, r30 is __pa(KSP) */			;\
+	tophys  (r30,r1)					;\
+	l.sw    PT_GPR12(r30),r12					;\
 	l.mfspr r12,r0,SPR_EPCR_BASE				;\
-	l.sw    PT_PC(r31),r12					;\
+	l.sw    PT_PC(r30),r12					;\
 	l.mfspr r12,r0,SPR_ESR_BASE				;\
-	l.sw    PT_SR(r31),r12					;\
+	l.sw    PT_SR(r30),r12					;\
 	/* save r31 */						;\
-	EXCEPTION_T_LOAD_GPR31(r12)				;\
-	l.sw	PT_GPR31(r31),r12					;\
+	EXCEPTION_T_LOAD_GPR30(r12)				;\
+	l.sw	PT_GPR30(r30),r12					;\
 	/* save r10 as was prior to exception */		;\
 	EXCEPTION_T_LOAD_GPR10(r12)				;\
-	l.sw	PT_GPR10(r31),r12					;\
+	l.sw	PT_GPR10(r30),r12					;\
 	/* save PT_SP as was prior to exception */			;\
 	EXCEPTION_T_LOAD_SP(r12)				;\
-	l.sw	PT_SP(r31),r12					;\
-	l.sw    PT_GPR13(r31),r13					;\
+	l.sw	PT_SP(r30),r12					;\
+	l.sw    PT_GPR13(r30),r13					;\
 	/* --> */						;\
 	/* save exception r4, set r4 = EA */			;\
-	l.sw	PT_GPR4(r31),r4					;\
+	l.sw	PT_GPR4(r30),r4					;\
 	l.mfspr r4,r0,SPR_EEAR_BASE				;\
 	/* r12 == 1 if we come from syscall */			;\
 	CLEAR_GPR(r12)						;\
 	/* ----- play a MMU trick ----- */			;\
-	l.ori	r31,r0,(EXCEPTION_SR)				;\
-	l.mtspr	r0,r31,SPR_ESR_BASE				;\
+	l.ori	r30,r0,(EXCEPTION_SR)				;\
+	l.mtspr	r0,r30,SPR_ESR_BASE				;\
 	/* r31:	EA address of handler */			;\
-	LOAD_SYMBOL_2_GPR(r31,handler)				;\
-	l.mtspr r0,r31,SPR_EPCR_BASE				;\
+	LOAD_SYMBOL_2_GPR(r30,handler)				;\
+	l.mtspr r0,r30,SPR_EPCR_BASE				;\
 	l.rfe
 
 /* =====================================================[ exceptions] === */
-- 
2.13.5

