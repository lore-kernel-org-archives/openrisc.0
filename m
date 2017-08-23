From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:10 +0900
Subject: [OpenRISC] [PATCH 2/5] target/openrisc: Make coreid and numcores
	configurable in state
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Message-ID: <88d5624e0d2f52db9072fcb36406baadf31d96bd.1503467674.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Previously coreid and numcores were hard coded as 0 and 1 respectively
as OpenRISC QEMU did not have multicore support.

Multicore support is now being added so these registers need to have
configured values.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/openrisc_sim.c   | 3 +++
 target/openrisc/cpu.h        | 3 +++
 target/openrisc/machine.c    | 7 +++++--
 target/openrisc/sys_helper.c | 4 ++--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e1eeffc490..44a657753d 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -110,6 +110,9 @@ static void openrisc_sim_init(MachineState *machine)
 
     for (n = 0; n < smp_cpus; n++) {
         cpu = cpu_openrisc_init(cpu_model);
+        cpu->env.coreid = n;
+        cpu->env.numcores = smp_cpus;
+
         if (cpu == NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 2721432c4f..4a61e5abfc 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -319,7 +319,10 @@ typedef struct CPUOpenRISCState {
 
     uint32_t picmr;         /* Interrupt mask register */
     uint32_t picsr;         /* Interrupt contrl register*/
+    uint32_t coreid;
+    uint32_t numcores;
 #endif
+
     void *irq[32];          /* Interrupt irq input */
 } CPUOpenRISCState;
 
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index a20cce705d..a879b2b539 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -104,8 +104,8 @@ static const VMStateInfo vmstate_sr = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 6,
-    .minimum_version_id = 6,
+    .version_id = 7,
+    .minimum_version_id = 7,
     .post_load = env_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
@@ -152,6 +152,9 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINT32(picmr, CPUOpenRISCState),
         VMSTATE_UINT32(picsr, CPUOpenRISCState),
 
+        VMSTATE_UINT32(coreid, CPUOpenRISCState),
+        VMSTATE_UINT32(numcores, CPUOpenRISCState),
+
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index abdef5d6a5..e138bcf9db 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -249,10 +249,10 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->esr;
 
     case TO_SPR(0, 128): /* COREID */
-        return 0;
+        return env->coreid;
 
     case TO_SPR(0, 129): /* NUMCORES */
-        return 1;
+        return env->numcores;
 
     case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
         idx = (spr - 1024);
-- 
2.13.5

