From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:29 +0900
Subject: [OpenRISC] [PATCH 15/18] sim: or1k: Implement register store/fetch
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-16-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

There was a comment questioning the use of these. But as soon
as I run any basic test gdb complains that these are not implemented.

More tests and basic run and execute work now.
---
 sim/or1k/or1k-sim.h |  2 +-
 sim/or1k/or1k.c     | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/sim/or1k/or1k-sim.h b/sim/or1k/or1k-sim.h
index 9e1754f..7213caa 100644
--- a/sim/or1k/or1k-sim.h
+++ b/sim/or1k/or1k-sim.h
@@ -4,7 +4,7 @@
 #include "symcat.h"
 
 /* GDB register numbers. */
-#define PC_REGNUM	16
+#define PC_REGNUM	33
 
 /* Misc. profile data.  */
 typedef struct {
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
index 98225ab..565a018 100644
--- a/sim/or1k/or1k.c
+++ b/sim/or1k/or1k.c
@@ -9,27 +9,52 @@
 #include "sim-main.h"
 #include "symcat.h"
 #include "cgen-ops.h"
+#include "cgen-mem.h"
+#include "cpuall.h"
 
 #include <string.h>
 
-/* not sure what the point of these is */
 int XCONCAT2(WANT_CPU,_fetch_register) (sim_cpu *current_cpu, int rn, unsigned char *buf, int len)
 {
-  return -1;
+   if (rn < 32)
+    SETTWI (buf, XCONCAT2(WANT_CPU,_h_gpr_get) (current_cpu, rn));
+  else
+    switch (rn)
+      {
+      case PC_REGNUM :
+        SETTWI (buf, XCONCAT2(WANT_CPU,_h_pc_get) (current_cpu));
+        break;
+      default :
+         return 0;
+      }
+  return sizeof(WI); /* WI from arch.h */
 }
 
 int XCONCAT2(WANT_CPU,_store_register) (sim_cpu *current_cpu, int rn, unsigned char *buf, int len)
 {
-  return -1;
+  if (rn < 32)
+    XCONCAT2(WANT_CPU,_h_gpr_set) (current_cpu, rn, GETTWI (buf));
+  else
+    switch (rn)
+      {
+      case PC_REGNUM :
+        XCONCAT2(WANT_CPU,_h_pc_set) (current_cpu, GETTWI (buf));
+        break;
+      default :
+         return 0;
+      }
+  return sizeof(WI); /* WI from arch.h */
 }
 
 #ifdef WANT_CPU_OR1K32BF
 int or1k32bf_model_or1200_u_exec (sim_cpu * UNUSED current_cpu, const IDESC * UNUSED idesc, int unit_num, int referenced)
 {
+  return -1;
 }
 
 int or1k32bf_model_or1200nd_u_exec (sim_cpu * UNUSED current_cpu, const IDESC * UNUSED idesc, int unit_num, int referenced)
 {
+  return -1;
 }
 
 void or1k32bf_model_insn_before (sim_cpu * UNUSED current_cpu, int UNUSED first_p)
-- 
2.7.4


