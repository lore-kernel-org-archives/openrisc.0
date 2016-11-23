From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:32 +0900
Subject: [OpenRISC] [PATCH 06/18] gdb: or1k: set gdbarch num regs to gpr +
	spr regs
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-7-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

Add a definition for SPR maximum number (OR1K_MAX_SPR_REGS).
This value is set to 64K (32 groups of 2048 registers).

gdb/ChangeLog:

	* or1k-tdep.c: use OR1K_MAX_SPR_REGS
	* or1k-tdep.h: add OR1K_MAX_SPR_REGS
---
 gdb/or1k-tdep.c |  6 +++---
 gdb/or1k-tdep.h | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index d660a39..1a3c16b 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -684,7 +684,7 @@ static const char *
 or1k_register_name (struct gdbarch *gdbarch,
 		    int             regnum)
 {
-  static char *or1k_gdb_reg_names[OR1K_TOTAL_NUM_REGS] =
+  static char *or1k_gdb_reg_names[OR1K_NUM_REGS_CACHED] =
     {
       /* general purpose registers */
       "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
@@ -784,7 +784,7 @@ or1k_registers_info (struct gdbarch    *gdbarch,
   if (-1 == regnum)
     {
       /* Do all (valid) registers */
-      unsigned int  lim = all ? OR1K_NUM_REGS : OR1K_MAX_GPR_REGS;
+      unsigned int  lim = all ? OR1K_NUM_REGS_CACHED : OR1K_MAX_GPR_REGS;
 
       for (regnum = 0; regnum < lim; regnum++) {
 	if ('\0' != *(or1k_register_name (gdbarch, regnum)))
@@ -837,7 +837,7 @@ or1k_register_reggroup_p (struct gdbarch  *gdbarch,
   if (group == all_reggroup)
     {
       return ((regnum >= 0) &&
-	      (regnum < OR1K_TOTAL_NUM_REGS) &&
+	      (regnum < OR1K_NUM_REGS_CACHED) &&
 	      (or1k_register_name (gdbarch, regnum)[0] != '\0'));
     }
 
diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
index 3179537..f0afc8f 100644
--- a/gdb/or1k-tdep.h
+++ b/gdb/or1k-tdep.h
@@ -317,19 +317,21 @@
 #define OR1K_SPR_DCFGR_WPCI     0x00000008  /* Watchpoint ctrs implemented */
 
 /* Properties of the architecture. GDB mapping of registers is all the GPRs
-   followed by the PPC, NPC and SR at the end. Red zone is the area past the
-   end of the stack reserved for exception handlers etc. */
-#define OR1K_MAX_GPR_REGS           32
+   and SPRs followed by the PPC, NPC and SR@the end. Red zone is the area
+   past the end of the stack reserved for exception handlers etc. */
+#define OR1K_MAX_GPR_REGS            32
+#define OR1K_MAX_SPR_REGS           (32 * 2048)
 #define OR1K_NUM_PSEUDO_REGS         0
-#define OR1K_NUM_REGS               (OR1K_MAX_GPR_REGS + 3)
+#define OR1K_NUM_REGS_CACHED        (OR1K_MAX_GPR_REGS + 3)
+#define OR1K_NUM_REGS               (OR1K_NUM_REGS_CACHED + OR1K_MAX_SPR_REGS)
 #define OR1K_TOTAL_NUM_REGS         (OR1K_NUM_REGS + OR1K_NUM_PSEUDO_REGS)
 #define OR1K_MAX_MATCHPOINTS         8
 #define OR1K_MAX_HW_WATCHES          OR1K_MAX_MATCHPOINTS
 #define OR1K_STACK_ALIGN             4
 #define OR1K_INSTLEN                 4
-#define OR1K_INSTBITLEN              (OR1K_INSTLEN * 8)
+#define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
 #define OR1K_NUM_TAP_RECORDS         8
-#define OR1K_FRAME_RED_ZONE_SIZE  2536
+#define OR1K_FRAME_RED_ZONE_SIZE     2536
 
 /* OR1K exception vectors */
 
-- 
2.7.4


