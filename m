From: Stafford Horne <shorne@gmail.com>
Date: Sat, 17 Dec 2016 01:02:55 +0900
Subject: [OpenRISC] [PATCH 5/5] gdb: or1k: Just have one number of registers
In-Reply-To: <cover.1481903617.git.shorne@gmail.com>
References: <cover.1481903617.git.shorne@gmail.com>
Message-ID: <fc280f480343907e7b133a7113a49159b2859672.1481903617.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Old logic about local vs remote registers and having a cache
is trying to be removed.  Remove these variables to match that.
---
 gdb/or1k-tdep.c | 10 +++++-----
 gdb/or1k-tdep.h |  4 +---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index bd982b6..d906066 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -397,7 +397,7 @@ or1k_single_step_through_delay (struct gdbarch *gdbarch,
 
 /* Name for or1k general registers.  */
 
-static const char *const or1k_reg_names[OR1K_NUM_REGS_CACHED] = {
+static const char *const or1k_reg_names[OR1K_NUM_REGS] = {
   /* general purpose registers */
   "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
   "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
@@ -413,7 +413,7 @@ static const char *const or1k_reg_names[OR1K_NUM_REGS_CACHED] = {
 static const char *
 or1k_register_name (struct gdbarch *gdbarch, int regnum)
 {
-  if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
+  if (0 <= regnum && regnum < OR1K_NUM_REGS)
     {
       return or1k_reg_names[regnum];
     }
@@ -426,7 +426,7 @@ or1k_register_name (struct gdbarch *gdbarch, int regnum)
 static struct type *
 or1k_register_type (struct gdbarch *gdbarch, int regnum)
 {
-  if ((regnum >= 0) && (regnum < OR1K_TOTAL_NUM_REGS))
+  if ((regnum >= 0) && (regnum < OR1K_NUM_REGS))
     {
       switch (regnum)
 	{
@@ -461,7 +461,7 @@ or1k_register_reggroup_p (struct gdbarch *gdbarch,
   if (group == all_reggroup)
     {
       return ((regnum >= 0)
-	      && (regnum < OR1K_NUM_REGS_CACHED)
+	      && (regnum < OR1K_NUM_REGS)
 	      && (or1k_register_name (gdbarch, regnum)[0] != '\0'));
     }
 
@@ -1364,7 +1364,7 @@ or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
 
       valid_p = 1;
 
-      for (i = 0; i < OR1K_NUM_REGS_CACHED; i++)
+      for (i = 0; i < OR1K_NUM_REGS; i++)
         valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
                                             or1k_reg_names[i]);
 
diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
index 0684004..335cd5c 100644
--- a/gdb/or1k-tdep.h
+++ b/gdb/or1k-tdep.h
@@ -51,9 +51,7 @@
 #define OR1K_MAX_GPR_REGS            32
 #define OR1K_MAX_SPR_REGS           (32 * 2048)
 #define OR1K_NUM_PSEUDO_REGS         0
-#define OR1K_NUM_REGS_CACHED        (OR1K_MAX_GPR_REGS + 3)
-#define OR1K_NUM_REGS               (OR1K_NUM_REGS_CACHED + OR1K_MAX_SPR_REGS)
-#define OR1K_TOTAL_NUM_REGS         (OR1K_NUM_REGS + OR1K_NUM_PSEUDO_REGS)
+#define OR1K_NUM_REGS               (OR1K_MAX_GPR_REGS + 3)
 #define OR1K_STACK_ALIGN             4
 #define OR1K_INSTLEN                 4
 #define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
-- 
2.7.4


