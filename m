From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:26 +0900
Subject: [OpenRISC] [PATCH 12/18] sim: or1k: Get or1k sim building with
	latest sim common
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-13-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

There have been a few type name changes.
 * Update configure.ac to use new ENDIAN config tpes
 * Update mloop to use new CGEN_TRACE.. instead of TRACE..
 * Change singnature of sim_create_inferior to have const param
 * Remove sim_close as its covered by sim_close in common now
 * Move WITH_SCACHE_PBB into sim-main.h from tconfig.in
 * Remove SIM_HANDLES_LMA as it seems its not needed anymore from tcofig.in
 * Remove tconfig.in
---
 sim/or1k/configure.ac |  5 ++---
 sim/or1k/mloop.in     |  6 +++---
 sim/or1k/sim-if.c     | 14 +++-----------
 sim/or1k/sim-main.h   |  2 ++
 sim/or1k/tconfig.in   |  8 --------
 5 files changed, 10 insertions(+), 25 deletions(-)
 delete mode 100644 sim/or1k/tconfig.in

diff --git a/sim/or1k/configure.ac b/sim/or1k/configure.ac
index d5dca70..c248d0a 100644
--- a/sim/or1k/configure.ac
+++ b/sim/or1k/configure.ac
@@ -24,11 +24,10 @@ sinclude(../common/acinclude.m4)
 
 SIM_AC_COMMON
 
-SIM_AC_OPTION_ENDIAN(BIG_ENDIAN)
+SIM_AC_OPTION_ENDIAN(BIG)
 SIM_AC_OPTION_ALIGNMENT(STRICT_ALIGNMENT)
-SIM_AC_OPTION_HOSTENDIAN
 SIM_AC_OPTION_BITSIZE([32], [31], [32])
-SIM_AC_OPTION_SCACHE([16384])
+SIM_AC_OPTION_SCACHE(16384)
 SIM_AC_OPTION_DEFAULT_MODEL([$default_model])
 SIM_AC_OPTION_ENVIRONMENT
 SIM_AC_OPTION_INLINE()
diff --git a/sim/or1k/mloop.in b/sim/or1k/mloop.in
index 6f19c50..092ce7d 100644
--- a/sim/or1k/mloop.in
+++ b/sim/or1k/mloop.in
@@ -97,8 +97,8 @@ execute (SIM_CPU *current_cpu, SCACHE *sc, int fast_p)
           if (PROFILE_MODEL_P (current_cpu)
               && ARGBUF_PROFILE_P (abuf))
             @cpu at _model_insn_before (current_cpu, 1 /*first_p*/);
-          TRACE_INSN_INIT (current_cpu, abuf, 1);
-          TRACE_INSN (current_cpu, idata,
+          CGEN_TRACE_INSN_INIT (current_cpu, abuf, 1);
+          CGEN_TRACE_INSN (current_cpu, idata,
                       (const struct argbuf *) abuf, abuf->addr);
         }
 #if WITH_SCACHE
@@ -117,7 +117,7 @@ execute (SIM_CPU *current_cpu, SCACHE *sc, int fast_p)
               cycles = (*idesc->timing->model_fn) (current_cpu, sc);
               @cpu at _model_insn_after (current_cpu, 1 /*last_p*/, cycles);
             }
-          TRACE_INSN_FINI (current_cpu, abuf, 1);
+          CGEN_TRACE_INSN_FINI (current_cpu, abuf, 1);
         }
 #else
       abort ();
diff --git a/sim/or1k/sim-if.c b/sim/or1k/sim-if.c
index 23a8a9e..e643fa1 100644
--- a/sim/or1k/sim-if.c
+++ b/sim/or1k/sim-if.c
@@ -174,7 +174,7 @@ sim_open (kind, callback, abfd, argv)
      SIM_OPEN_KIND kind;
      host_callback *callback;
      struct bfd *abfd;
-     char **argv;
+     char * const *argv;
 {
   SIM_DESC sd = sim_state_alloc (kind, callback);
   char c;
@@ -297,21 +297,13 @@ sim_open (kind, callback, abfd, argv)
   return sd;
 }
 
-void
-sim_close (sd, quitting)
-     SIM_DESC sd;
-     int quitting;
-{
-  or1k_cgen_cpu_close (CPU_CPU_DESC (STATE_CPU (sd, 0)));
-  sim_module_uninstall (sd);
-}
 
 SIM_RC
 sim_create_inferior (sd, abfd, argv, envp)
      SIM_DESC sd;
      struct bfd *abfd;
-     char **argv;
-     char **envp;
+     char * const *argv;
+     char * const *envp;
 {
   SIM_CPU *current_cpu = STATE_CPU (sd, 0);
   SIM_ADDR addr;
diff --git a/sim/or1k/sim-main.h b/sim/or1k/sim-main.h
index d26d616..f0b4e07 100644
--- a/sim/or1k/sim-main.h
+++ b/sim/or1k/sim-main.h
@@ -1,6 +1,8 @@
 #ifndef SIM_MAIN_H
 #define SIM_MAIN_H
 
+#define WITH_SCACHE_PBB 1
+
 #include "ansidecl.h"
 #include "or1k-desc.h"
 #include "sim-basics.h"
diff --git a/sim/or1k/tconfig.in b/sim/or1k/tconfig.in
deleted file mode 100644
index a1b463f..0000000
--- a/sim/or1k/tconfig.in
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef OR1K_TCONFIG_H
-#define OR1K_TCONFIG_H
-
-#define SIM_HANDLES_LMA 1
-
-#define WITH_SCACHE_PBB 1
-
-#endif
\ No newline at end of file
-- 
2.7.4


