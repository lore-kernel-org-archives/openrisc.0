From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:57 +0900
Subject: [OpenRISC] [PATCH v2 9/9] target/openrisc: Remove duplicate
	features property
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
References: <cover.1492986468.git.shorne@gmail.com>
Message-ID: <5466599bfa21f03ae01741580c7e3fa0fdc6800d.1492986468.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The features property has stored the exact same thing as the cpucfgr
spr. Remove the feature enum and property as it is not needed.

In order to preserve the behavior or keeping features accross reset this
patch moves cpucfgr into the non reset region of the state struct.  Since
the cpucfgr is read only this means we only need to sset cpucfgr once
during class init.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c | 17 +++--------------
 target/openrisc/cpu.h | 16 ++--------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6c1ed07..c9b3f22 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -52,7 +52,6 @@ static void openrisc_cpu_reset(CPUState *s)
     s->exception_index = -1;
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
-    cpu->env.cpucfgr = CPUCFGR_OB32S | CPUCFGR_OF32S | CPUCFGR_NSGF;
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2)) | (DMMUCFGR_NTS & (6 << 2));
     cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2)) | (IMMUCFGR_NTS & (6 << 2));
 
@@ -65,12 +64,6 @@ static void openrisc_cpu_reset(CPUState *s)
 #endif
 }
 
-static inline void set_feature(OpenRISCCPU *cpu, int feature)
-{
-    cpu->feature |= feature;
-    cpu->env.cpucfgr = cpu->feature;
-}
-
 static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -132,19 +125,15 @@ static void or1200_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
-    set_feature(cpu, OPENRISC_FEATURE_NSGF);
-    set_feature(cpu, OPENRISC_FEATURE_OB32S);
-    set_feature(cpu, OPENRISC_FEATURE_OF32S);
-    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
+    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
+                       CPUCFGR_EVBARP;
 }
 
 static void openrisc_any_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
-    set_feature(cpu, OPENRISC_FEATURE_NSGF);
-    set_feature(cpu, OPENRISC_FEATURE_OB32S);
-    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
+    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
 }
 
 typedef struct OpenRISCCPUInfo {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index e159b22..938ccc3 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -196,18 +196,6 @@ enum {
     SR_SCE = (1 << 17),
 };
 
-/* OpenRISC Hardware Capabilities */
-enum {
-    OPENRISC_FEATURE_NSGF = (15 << 0),
-    OPENRISC_FEATURE_CGF = (1 << 4),
-    OPENRISC_FEATURE_OB32S = (1 << 5),
-    OPENRISC_FEATURE_OB64S = (1 << 6),
-    OPENRISC_FEATURE_OF32S = (1 << 7),
-    OPENRISC_FEATURE_OF64S = (1 << 8),
-    OPENRISC_FEATURE_OV64S = (1 << 9),
-    OPENRISC_FEATURE_EVBAR = (1 << 12),
-};
-
 /* Tick Timer Mode Register */
 enum {
     TTMR_TP = (0xfffffff),
@@ -292,7 +280,6 @@ typedef struct CPUOpenRISCState {
     uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
     uint32_t vr;              /* Version register */
     uint32_t upr;             /* Unit presence register */
-    uint32_t cpucfgr;         /* CPU configure register */
     uint32_t dmmucfgr;        /* DMMU configure register */
     uint32_t immucfgr;        /* IMMU configure register */
     uint32_t esr;             /* Exception supervisor register */
@@ -311,6 +298,8 @@ typedef struct CPUOpenRISCState {
     CPU_COMMON
 
     /* Fields from here on are preserved across CPU reset. */
+    uint32_t cpucfgr;         /* CPU configure register */
+
 #ifndef CONFIG_USER_ONLY
     CPUOpenRISCTLBContext * tlb;
 
@@ -337,7 +326,6 @@ typedef struct OpenRISCCPU {
 
     CPUOpenRISCState env;
 
-    uint32_t feature;       /* CPU Capabilities */
 } OpenRISCCPU;
 
 static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
-- 
2.9.3

