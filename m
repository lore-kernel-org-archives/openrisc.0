From: Stafford Horne <shorne@gmail.com>
Date: Sat, 11 Jan 2020 06:28:43 +0900
Subject: [OpenRISC] [PATCH] target/openrisc: Fix FPCSR mask to allow setting
 DZF
Message-ID: <20200110212843.27335-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The mask used when setting FPCSR allows setting bits 10 to 1.  However,
OpenRISC has flags and config bits in 11 to 1, 11 being Divide by Zero
Flag (DZF).  This seems like an off-by-one bug.

This was found when testing the GLIBC test suite which has test cases to
set and clear all bits.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 59e1413279..6f75ea0505 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -70,7 +70,7 @@ void cpu_set_fpcsr(CPUOpenRISCState *env, uint32_t val)
         float_round_down
     };
 
-    env->fpcsr = val & 0x7ff;
+    env->fpcsr = val & 0xfff;
     set_float_rounding_mode(rm_to_sf[extract32(val, 1, 2)], &env->fp_status);
 }
 
-- 
2.21.0

