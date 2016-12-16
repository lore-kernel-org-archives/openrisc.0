From: Stafford Horne <shorne@gmail.com>
Date: Sat, 17 Dec 2016 01:02:52 +0900
Subject: [OpenRISC] [PATCH 2/5] gdb: or1k: Remove pseudo registers
In-Reply-To: <cover.1481903617.git.shorne@gmail.com>
References: <cover.1481903617.git.shorne@gmail.com>
Message-ID: <015c0ab94b89deb4c321cd5931ca148a27855971.1481903617.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

We do not have definitions for peudo registers yet.  This could be added
later. We do have vectors and floats that could be added here, but
discussions need to be made on how they should be named and represented.
---
 gdb/or1k-tdep.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 2c5d679..be5f483 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -395,33 +395,6 @@ or1k_single_step_through_delay (struct gdbarch *gdbarch,
 
 }
 
-/* Read a pseudo register.  */
-
-/*
-   TODO The floating point and vector registers ought to be done as
-         pseudo-registers.
-*/
-
-static enum register_status
-or1k_pseudo_register_read (struct gdbarch *gdbarch,
-			   struct regcache *regcache,
-			   int regnum, gdb_byte * buf)
-{
-  return REG_UNKNOWN;
-}
-
-
-/* Write a pseudo register.  */
-
-static void
-or1k_pseudo_register_write (struct gdbarch *gdbarch,
-			    struct regcache *regcache,
-			    int regnum, const gdb_byte * buf)
-{
-  return;
-
-}
-
 /* Name for or1k general registers.  */
 
 static const char *const or1k_reg_names[OR1K_NUM_REGS_CACHED] = {
@@ -1484,8 +1457,6 @@ or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
   set_gdbarch_print_insn (gdbarch, print_insn_or1k);
 
   /* Register architecture */
-  set_gdbarch_pseudo_register_read (gdbarch, or1k_pseudo_register_read);
-  set_gdbarch_pseudo_register_write (gdbarch, or1k_pseudo_register_write);
   set_gdbarch_num_regs (gdbarch, OR1K_NUM_REGS);
   set_gdbarch_num_pseudo_regs (gdbarch, OR1K_NUM_PSEUDO_REGS);
   set_gdbarch_sp_regnum (gdbarch, OR1K_SP_REGNUM);
-- 
2.7.4


