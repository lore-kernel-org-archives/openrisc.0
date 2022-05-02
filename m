From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Tue,  3 May 2022 00:52:30 +0200
Subject: [OpenRISC] [PATCH] target/openrisc: implement shutdown and reset
 helpers
Message-ID: <20220502225230.237369-1-Jason@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

OpenRISC defines various nop instructions in or1k as meaning shutdown or
reset. Implement these in TCG. This has been tested with Linux and
confirmed to work.

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 target/openrisc/helper.h     |  1 +
 target/openrisc/sys_helper.c | 18 ++++++++++++++++++
 target/openrisc/translate.c  |  1 +
 3 files changed, 20 insertions(+)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index d847814a28..ea3557b3f9 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -64,3 +64,4 @@ DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 /* sys */
 DEF_HELPER_FLAGS_3(mtspr, 0, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl)
+DEF_HELPER_1(nop, void, i32)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 48674231e7..f6249896fb 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -314,3 +315,20 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
     /* for rd is passed in, if rd unchanged, just keep it back.  */
     return rd;
 }
+
+void HELPER(nop)(uint32_t arg)
+{
+#ifndef CONFIG_USER_ONLY
+	switch (arg) {
+	case 0x001: /* NOP_EXIT */
+	case 0x00c: /* NOP_EXIT_SILENT */
+		qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+		break;
+	case 0x00d: /* NOP_RESET */
+		qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+		break;
+	default:
+		break;
+	}
+#endif
+}
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7b8ad43d5f..2e4f3759d4 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -780,6 +780,7 @@ static bool trans_l_sh(DisasContext *dc, arg_store *a)
 
 static bool trans_l_nop(DisasContext *dc, arg_l_nop *a)
 {
+    gen_helper_nop(cpu_R(dc, a->k));
     return true;
 }
 
-- 
2.35.1

