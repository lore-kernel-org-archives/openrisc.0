From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:25 +0900
Subject: [OpenRISC] [PATCH 11/18] sim: or1k: fix segfault when run without
	arguments
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-12-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/or1k/ChangeLog:

	* sim-if.c: (sim_open) push check for delay slot mode further down
	in function so other checks happen first.  This prevents a
	segfault when the simulator is run without arguments.
---
 sim/or1k/ChangeLog |  6 ++++++
 sim/or1k/sim-if.c  | 19 ++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/sim/or1k/ChangeLog b/sim/or1k/ChangeLog
index c1038c3..ff7ca8d 100644
--- a/sim/or1k/ChangeLog
+++ b/sim/or1k/ChangeLog
@@ -1,3 +1,9 @@
+2012-09-06  Peter Gavin  <pgavin@gmail.com>
+
+	* sim-if.c: (sim_open) push check for delay slot mode further down
+	in function so other checks happen first.  This prevents a
+	segfault when the simulator is run without arguments.
+
 2012-06-22  Peter Gavin  <pgavin@gmail.com>
 
 	* cpu32.c: regenerate
diff --git a/sim/or1k/sim-if.c b/sim/or1k/sim-if.c
index c257ae6..23a8a9e 100644
--- a/sim/or1k/sim-if.c
+++ b/sim/or1k/sim-if.c
@@ -235,14 +235,6 @@ sim_open (kind, callback, abfd, argv)
       return 0;
     }
 
-  if ((or1k_cpucfgr & SPR_FIELD_MASK_SYS_CPUCFGR_ND) &&
-      (STATE_ARCHITECTURE (sd)->mach != bfd_mach_or1knd)) {
-    sim_io_eprintf (sd, "WARNING: CPUCFGR ND flag set, but loading non-or1knd binary\n");
-  } else if (!(or1k_cpucfgr & SPR_FIELD_MASK_SYS_CPUCFGR_ND) &&
-             (STATE_ARCHITECTURE (sd)->mach != bfd_mach_or1k)) {
-    sim_io_eprintf (sd, "WARNING: CPUCFGR ND flag not set, but loading non-or1k binary\n");
-  }
-  
   /* Establish any remaining configuration options.  */
   if (sim_config (sd) != SIM_RC_OK)
     {
@@ -255,7 +247,16 @@ sim_open (kind, callback, abfd, argv)
       free_state (sd);
       return 0;
     }
-
+  
+  /* make sure delay slot mode is consistent with the loaded binary */
+  if ((or1k_cpucfgr & SPR_FIELD_MASK_SYS_CPUCFGR_ND) &&
+      (STATE_ARCHITECTURE (sd)->mach != bfd_mach_or1knd)) {
+    sim_io_eprintf (sd, "WARNING: CPUCFGR ND flag set, but loading non-or1knd binary\n");
+  } else if (!(or1k_cpucfgr & SPR_FIELD_MASK_SYS_CPUCFGR_ND) &&
+             (STATE_ARCHITECTURE (sd)->mach != bfd_mach_or1k)) {
+    sim_io_eprintf (sd, "WARNING: CPUCFGR ND flag not set, but loading non-or1k binary\n");
+  }
+  
   /* Open a copy of the cpu descriptor table.  */
   {
     CGEN_CPU_DESC cd = or1k_cgen_cpu_open_1 (STATE_ARCHITECTURE (sd)->printable_name,
-- 
2.7.4


