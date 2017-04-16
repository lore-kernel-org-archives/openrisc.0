From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:51 +0900
Subject: [OpenRISC] [PATCH 2/7] target/openrisc: add shutdown logic
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
Message-ID: <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In openrisc simulators we use hooks like 'l.nop 1' to cause the
simulator to exit.  Implement that for qemu too.

Reported-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/helper.h     |  1 +
 target/openrisc/sys_helper.c | 17 +++++++++++++++++
 target/openrisc/translate.c  |  5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 4fd1a6b..b7838f5 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -59,3 +59,4 @@ DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 /* sys */
 DEF_HELPER_FLAGS_4(mtspr, 0, void, env, tl, tl, tl)
 DEF_HELPER_FLAGS_4(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl, tl)
+DEF_HELPER_1(nop, void, i32)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 60c3193..2eaff87 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "sysemu/sysemu.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
@@ -286,3 +287,19 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     /* for rd is passed in, if rd unchanged, just keep it back.  */
     return rd;
 }
+
+/* In openrisc simulators nop can be used to do intersting
+ * things like shut down the simulator */
+void HELPER(nop)(uint32_t arg)
+{
+#ifndef CONFIG_USER_ONLY
+    switch (arg) {
+    case 0x001: /* NOP_EXIT */
+    case 0x00c: /* NOP_EXIT_SILENT */
+        qemu_system_shutdown_request();
+        break;
+    default:
+        break;
+    }
+#endif
+}
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7c4cbf2..74df245 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -755,8 +755,11 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x01:    /* l.nop */
             LOG_DIS("l.nop %d\n", I16);
+            {
+                TCGv_i32 arg = tcg_const_i32(I16);
+                gen_helper_nop(arg);
+            }
             break;
-
         default:
             gen_illegal_exception(dc);
             break;
-- 
2.9.3

