From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:49 +0900
Subject: [OpenRISC] [PATCH v2 1/9] target/openrisc: Implement EVBAR register
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
References: <cover.1492986468.git.shorne@gmail.com>
Message-ID: <356a2db3c6f84e8e79e5afa3913514184bff5f50.1492986468.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Tim 'mithro' Ansell <mithro@mithis.com>

Exception Vector Base Address Register (EVBAR) - This optional register
can be used to apply an offset to the exception vector addresses.

The significant bits (31-12) of the vector offset address for each
exception depend on the setting of the Supervision Register (SR)'s EPH
bit and the Exception Vector Base Address Register (EVBAR).

Its presence is indicated by the EVBARP bit in the CPU Configuration
Register (CPUCFGR).

Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c        | 2 ++
 target/openrisc/cpu.h        | 7 +++++++
 target/openrisc/interrupt.c  | 6 +++++-
 target/openrisc/sys_helper.c | 7 +++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 7fd2b9a..1524ed9 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -134,6 +134,7 @@ static void or1200_initfn(Object *obj)
 
     set_feature(cpu, OPENRISC_FEATURE_OB32S);
     set_feature(cpu, OPENRISC_FEATURE_OF32S);
+    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
 }
 
 static void openrisc_any_initfn(Object *obj)
@@ -141,6 +142,7 @@ static void openrisc_any_initfn(Object *obj)
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
     set_feature(cpu, OPENRISC_FEATURE_OB32S);
+    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
 }
 
 typedef struct OpenRISCCPUInfo {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 418a0e6..1958b72 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -111,6 +111,11 @@ enum {
     CPUCFGR_OF32S = (1 << 7),
     CPUCFGR_OF64S = (1 << 8),
     CPUCFGR_OV64S = (1 << 9),
+    /* CPUCFGR_ND = (1 << 10), */
+    /* CPUCFGR_AVRP = (1 << 11), */
+    CPUCFGR_EVBARP = (1 << 12),
+    /* CPUCFGR_ISRP = (1 << 13), */
+    /* CPUCFGR_AECSRP = (1 << 14), */
 };
 
 /* DMMU configure register */
@@ -200,6 +205,7 @@ enum {
     OPENRISC_FEATURE_OF32S = (1 << 7),
     OPENRISC_FEATURE_OF64S = (1 << 8),
     OPENRISC_FEATURE_OV64S = (1 << 9),
+    OPENRISC_FEATURE_EVBAR = (1 << 12),
 };
 
 /* Tick Timer Mode Register */
@@ -289,6 +295,7 @@ typedef struct CPUOpenRISCState {
     uint32_t dmmucfgr;        /* DMMU configure register */
     uint32_t immucfgr;        /* IMMU configure register */
     uint32_t esr;             /* Exception supervisor register */
+    uint32_t evbar;           /* Exception vector base address register */
     uint32_t fpcsr;           /* Float register */
     float_status fp_status;
 
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index a2eec6f..78f0ba9 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -65,7 +65,11 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->lock_addr = -1;
 
     if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
-        env->pc = (cs->exception_index << 8);
+        hwaddr vect_pc = cs->exception_index << 8;
+        if (env->cpucfgr & CPUCFGR_EVBARP) {
+            vect_pc |= env->evbar;
+        }
+        env->pc = vect_pc;
     } else {
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 60c3193..6ba8162 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -39,6 +39,10 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
         env->vr = rb;
         break;
 
+    case TO_SPR(0, 11): /* EVBAR */
+        env->evbar = rb;
+        break;
+
     case TO_SPR(0, 16): /* NPC */
         cpu_restore_state(cs, GETPC());
         /* ??? Mirror or1ksim in not trashing delayed branch state
@@ -206,6 +210,9 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 4): /* IMMUCFGR */
         return env->immucfgr;
 
+    case TO_SPR(0, 11): /* EVBAR */
+        return env->evbar;
+
     case TO_SPR(0, 16): /* NPC (equals PC) */
         cpu_restore_state(cs, GETPC());
         return env->pc;
-- 
2.9.3

