From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:31 +0900
Subject: [OpenRISC] [PATCH 17/18] sim: or1k: Implement fetch/store for ppc
	and sr
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-18-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This was causing some tests to failure due to warnings.
---
 sim/or1k/or1k-sim.h |  2 ++
 sim/or1k/or1k.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/sim/or1k/or1k-sim.h b/sim/or1k/or1k-sim.h
index 7213caa..2ad6f8c 100644
--- a/sim/or1k/or1k-sim.h
+++ b/sim/or1k/or1k-sim.h
@@ -4,7 +4,9 @@
 #include "symcat.h"
 
 /* GDB register numbers. */
+#define PPC_REGNUM	32
 #define PC_REGNUM	33
+#define SR_REGNUM	34
 
 /* Misc. profile data.  */
 typedef struct {
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
index 565a018..9f50c33 100644
--- a/sim/or1k/or1k.c
+++ b/sim/or1k/or1k.c
@@ -21,9 +21,15 @@ int XCONCAT2(WANT_CPU,_fetch_register) (sim_cpu *current_cpu, int rn, unsigned c
   else
     switch (rn)
       {
+      case PPC_REGNUM :
+        SETTWI (buf, XCONCAT2(WANT_CPU,_h_sys_ppc_get) (current_cpu));
+        break;
       case PC_REGNUM :
         SETTWI (buf, XCONCAT2(WANT_CPU,_h_pc_get) (current_cpu));
         break;
+      case SR_REGNUM :
+        SETTWI (buf, XCONCAT2(WANT_CPU,_h_sys_sr_get) (current_cpu));
+        break;
       default :
          return 0;
       }
@@ -37,9 +43,15 @@ int XCONCAT2(WANT_CPU,_store_register) (sim_cpu *current_cpu, int rn, unsigned c
   else
     switch (rn)
       {
+      case PPC_REGNUM :
+        XCONCAT2(WANT_CPU,_h_sys_ppc_set) (current_cpu, GETTWI (buf));
+        break;
       case PC_REGNUM :
         XCONCAT2(WANT_CPU,_h_pc_set) (current_cpu, GETTWI (buf));
         break;
+      case SR_REGNUM :
+        XCONCAT2(WANT_CPU,_h_sys_sr_set) (current_cpu, GETTWI (buf));
+        break;
       default :
          return 0;
       }
-- 
2.7.4


