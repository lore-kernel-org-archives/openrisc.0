From: Stafford Horne <shorne@gmail.com>
Date: Sun, 12 Feb 2017 21:33:51 +0900
Subject: [OpenRISC] [PATCH 2/2] sim: or1k: Regenerate sim files
In-Reply-To: <cover.1486902449.git.shorne@gmail.com>
References: <cover.1486902449.git.shorne@gmail.com>
Message-ID: <600c5db572b186e3e46ae1b886e4391045702dce.1486902449.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

After updating the cpu ppc setting logic regenarate the cpu files.

sim/ChangeLog:

2017-02-12  Stafford Horne  <shorne@gmail.com>

	* or1k/cpu32.c: Regenerate.
	* or1k/cpu32.h: Regenerate.
---
 sim/or1k/cpu32.c | 4 ++--
 sim/or1k/cpu32.h | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sim/or1k/cpu32.c b/sim/or1k/cpu32.c
index 14e11ec..d8c0526 100644
--- a/sim/or1k/cpu32.c
+++ b/sim/or1k/cpu32.c
@@ -33,7 +33,7 @@ This file is part of the GNU simulators.
 USI
 or1k32bf_h_pc_get (SIM_CPU *current_cpu)
 {
-  return CPU (h_pc);
+  return GET_H_PC ();
 }
 
 /* Set a value for h-pc.  */
@@ -41,7 +41,7 @@ or1k32bf_h_pc_get (SIM_CPU *current_cpu)
 void
 or1k32bf_h_pc_set (SIM_CPU *current_cpu, USI newval)
 {
-  CPU (h_pc) = newval;
+  SET_H_PC (newval);
 }
 
 /* Get the value of h-fsr.  */
diff --git a/sim/or1k/cpu32.h b/sim/or1k/cpu32.h
index 771fcdc..20c9ac6 100644
--- a/sim/or1k/cpu32.h
+++ b/sim/or1k/cpu32.h
@@ -45,7 +45,13 @@ typedef struct {
   /* program counter */
   USI h_pc;
 #define GET_H_PC() CPU (h_pc)
-#define SET_H_PC(x) (CPU (h_pc) = (x))
+#define SET_H_PC(x) \
+do { \
+{\
+SET_H_SYS_PPC (CPU (h_pc));\
+CPU (h_pc) = (x);\
+}\
+;} while (0)
   /* general registers */
   USI h_gpr[32];
 #define GET_H_GPR(index) GET_H_SPR (((index) + (ORSI (SLLSI (SPR_GROUP_SYS, 11), SPR_INDEX_SYS_GPR0))))
-- 
2.9.3

