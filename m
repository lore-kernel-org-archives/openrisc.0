From: Stafford Horne <shorne@gmail.com>
Date: Sat, 17 Dec 2016 01:02:53 +0900
Subject: [OpenRISC] [PATCH 3/5] or1k: gdb: Simplify handling of tdesc
In-Reply-To: <cover.1481903617.git.shorne@gmail.com>
References: <cover.1481903617.git.shorne@gmail.com>
Message-ID: <367e63db38d88ac51dcf23d863f57bd87fde1c5f.1481903617.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The previous code tried to intercept all access to registers provided by
report target descriptor features.  However, the target descriptor can
support that access if setup properly.

There was also some code which dynamically created groups which I change
to simply hard code the groups we support.  I hope that is reasonable.

I did some basic testing and it seems to all work the same as before.
Need to confirm with the real openocd target.

or1k-tdep.c
 * remove parsing logic and info_reg overrides
   as its handled by target descriptions actually

target-descriptions.[ch]
 * remove unused functions
---
 gdb/or1k-tdep.c           | 262 +++++++---------------------------------------
 gdb/target-descriptions.c |  34 ------
 gdb/target-descriptions.h |  12 ---
 3 files changed, 39 insertions(+), 269 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index be5f483..2ea3c24 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -413,19 +413,12 @@ static const char *const or1k_reg_names[OR1K_NUM_REGS_CACHED] = {
 static const char *
 or1k_register_name (struct gdbarch *gdbarch, int regnum)
 {
-  /* If we have a target description, use it */
-  if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
-    return tdesc_register_name (gdbarch, regnum);
-  else
+  if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
     {
-      if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
-	{
-	  return or1k_reg_names[regnum];
-	}
-      else
-	return NULL;
+      return or1k_reg_names[regnum];
     }
-
+  else
+      return NULL;
 }
 
 /* Implement the register_type gdbarch method.  */
@@ -456,60 +449,6 @@ or1k_register_type (struct gdbarch *gdbarch, int regnum)
 
 }
 
-/* Implement the registers_info gdbarch method.  */
-
-static void
-or1k_registers_info (struct gdbarch *gdbarch,
-		     struct ui_file *file,
-		     struct frame_info *frame, int regnum, int all)
-{
-  struct regcache *regcache = get_current_regcache ();
-
-/* TODO
-or1k_registers_info should print the registers contents from FRAME
-rather than current regcache.
-*/
-
-  if (-1 == regnum)
-    {
-      /* Do all (valid) registers */
-      unsigned int lim = all ? OR1K_NUM_REGS_CACHED : OR1K_MAX_GPR_REGS;
-
-      for (regnum = 0; regnum < lim; regnum++)
-	{
-	  if ('\0' != *(or1k_register_name (gdbarch, regnum)))
-	    {
-	      or1k_registers_info (gdbarch, file, frame, regnum, all);
-	    }
-	}
-    }
-  else
-    {
-      /* Do one specified register - if it is part of this architecture */
-      if ((regnum < OR1K_NUM_REGS_CACHED)
-	  && ('\0' == *(or1k_register_name (gdbarch, regnum))))
-	{
-	  error ("Not a valid register for the current processor type");
-	}
-      else
-	{
-	  /* If the register is not in the g/G packet, fetch it from the
-	   * target with a p/P packet.
-	   */
-	  if (regnum >= OR1K_NUM_REGS_CACHED)
-	    target_fetch_registers (regcache, regnum);
-
-/* TODO
-Why is a register not in the g/G packet?  Again, we shouldn't fetch
-registers now.
-*/
-
-	  default_print_registers_info (gdbarch, file, frame, regnum, all);
-	}
-    }
-}
-
-
 /* Implement the register_reggroup_p gdbarch method.  */
 
 static int
@@ -544,16 +483,8 @@ or1k_register_reggroup_p (struct gdbarch *gdbarch,
       return 0;	/* No vector regs.  */
     }
 
-  if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
-    {
-      if ((tdesc_register_in_reggroup_p (gdbarch, regnum, group)) != 1)
-	return 0;
-      else
-	return 1;
-    }
-  else
-    /* For any that are not handled above.  */
-    return default_register_reggroup_p (gdbarch, regnum, group);
+  /* For any that are not handled above.  */
+  return default_register_reggroup_p (gdbarch, regnum, group);
 
 }
 
@@ -1308,98 +1239,6 @@ static const struct frame_unwind or1k_frame_unwind = {
   .prev_arch = NULL
 };
 
-
-/* Create a register group based on a group name.  */
-
-static int
-create_register_group (struct gdbarch *gdbarch, const char *group_name)
-{
-  struct reggroup *group;
-  static int first = 1;
-  int group_exist = 0;
-
-  if (group_name == NULL)
-    return 0;
-
-  if (!first)
-    {
-      for (group = reggroup_next (gdbarch, NULL);
-	   group != NULL; group = reggroup_next (gdbarch, group))
-	{
-	  if (strcmp (group_name, reggroup_name (group)) == 0)
-	    group_exist = 1;
-	}
-
-      if (!group_exist)
-	{
-	  /* If the group doesn't exist, create it.  */
-	  reggroup_add (gdbarch, reggroup_new (group_name, USER_REGGROUP));
-	  return 1;
-	}
-    }
-  else
-    {
-      /* The function reggroup_next cannot be called during architecture init.
-         However, a first call to reggroup_add execute reggroups_init and then
-         reggroup_next can be use. We assume the first group name we create
-         does not exist.  */
-      reggroup_add (gdbarch, reggroup_new (group_name, USER_REGGROUP));
-      first = 0;
-    }
-
-  return 0;
-}
-
-/* Register all reg found in a feature section and create a group for each
-   new register group name found in the tdesc file.  */
-
-static int
-get_feature_registers (const struct tdesc_feature *feature,
-		       struct tdesc_arch_data *tdesc_data, int *reg_index,
-		       struct gdbarch *gdbarch)
-{
-  int valid_p;
-  int i;
-  const char *name;
-  const char *group_name;
-
-  if (feature)
-    {
-      valid_p = 1;
-      i = 0;
-      while (1)
-	{
-	  name = tdesc_find_register_name (feature, i);
-	  if (name)
-	    {
-	      valid_p &=
-		tdesc_numbered_register (feature, tdesc_data, (*reg_index)++,
-					 name);
-	      if (valid_p)
-		{
-		  group_name = tdesc_find_register_group_name (feature, i);
-		  if (group_name)
-		    create_register_group (gdbarch, group_name);
-		}
-	      i++;
-	    }
-	  else
-	    break;
-	}
-
-      if (!valid_p)
-	{
-	  tdesc_data_cleanup (tdesc_data);
-	  return -1;
-	}
-
-      return i;
-
-    }
-
-  return 0;
-}
-
 /* Architecture initialization for OpenRISC 1000.  */
 
 static struct gdbarch *
@@ -1467,7 +1306,6 @@ or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
   /* Functions to supply register information */
   set_gdbarch_register_name (gdbarch, or1k_register_name);
   set_gdbarch_register_type (gdbarch, or1k_register_type);
-  set_gdbarch_print_registers_info (gdbarch, or1k_registers_info);
   set_gdbarch_register_reggroup_p (gdbarch, or1k_register_reggroup_p);
 
   /* Functions to analyse frames */
@@ -1514,73 +1352,51 @@ or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
 
   /* Check any target description for validity.  */
   if (tdesc_has_registers (info.target_desc))
-    {
-
+    { 
       const struct tdesc_feature *feature;
-      int total_regs = 0;
-      int nb_features;
-      char feature_name[30];
+      int valid_p;
 
-      tdesc_data = tdesc_data_alloc ();
+      feature = tdesc_find_feature (info.target_desc, "org.gnu.gdb.or1k.group0");
+      if (feature == NULL)
+        return NULL;
 
-      /* OpenRisc architecture manual define a maximum of 32 registers
-	 groups.  */
-      for (group = 0; group < 32; group++)
-	{
+      tdesc_data = tdesc_data_alloc ();
 
-	  sprintf (feature_name, "org.gnu.gdb.or1k.group%d", group);
-	  feature = tdesc_find_feature (info.target_desc, feature_name);
+      valid_p = 1;
 
-	  retval =
-	    get_feature_registers (feature, tdesc_data, &reg_index, gdbarch);
+      for (i = 0; i < OR1K_NUM_REGS_CACHED; i++)
+        valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
+                                            or1k_reg_names[i]);
 
-	  if (retval < 0)
-	    {
-	      tdesc_data_cleanup (tdesc_data);
-	      return NULL;
-	    }
-	  else
-	    {
-	      total_regs += retval;
-	      if (retval && gdbarch_debug)
-		fprintf_unfiltered (gdb_stdout,
-				    "Found %4d registers in feature %s\n",
-				    retval, feature_name);
-	    }
-	}
-/*
-TODO YQ
-I don't fully understand what you want to achieve here, can you
-elaborate?  What do these features look alike?
-*/
-      if (gdbarch_debug)
-	fprintf_unfiltered (gdb_stdout,
-			    "Found %4d registers in the tdesc file\n",
-			    total_regs);
-
-      if (!total_regs)
-	{
-	  tdesc_data_cleanup (tdesc_data);
-	  return NULL;
-	}
+      if (!valid_p)
+        { 
+          tdesc_data_cleanup (tdesc_data);
+          return NULL;
+        }
     }
 
   if (tdesc_data)
     {
       tdesc_use_registers (gdbarch, info.target_desc, tdesc_data);
 
-      /* Override the normal target description methods to handle our
-         dual real and pseudo registers.  */
-/* TODO SMH
-These look wrong they are already set above
-*/
-      set_gdbarch_register_name (gdbarch, or1k_register_name);
-      set_gdbarch_register_reggroup_p (gdbarch, or1k_register_reggroup_p);
-
-      set_gdbarch_register_name (gdbarch, or1k_register_name);
-      set_gdbarch_sp_regnum (gdbarch, OR1K_SP_REGNUM);
-      set_gdbarch_pc_regnum (gdbarch, OR1K_NPC_REGNUM);
-      set_gdbarch_num_pseudo_regs (gdbarch, OR1K_NUM_PSEUDO_REGS);
+      /* Target descriptions may extend into the following groups.  */
+      reggroup_add (gdbarch, general_reggroup);
+      reggroup_add (gdbarch, system_reggroup);
+      reggroup_add (gdbarch, float_reggroup);
+      reggroup_add (gdbarch, vector_reggroup);
+      reggroup_add (gdbarch, reggroup_new ("immu", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("dmmu", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("icache", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("dcache", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("pic", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("timer", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("power", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("perf", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("mac", USER_REGGROUP));
+      reggroup_add (gdbarch, reggroup_new ("debug", USER_REGGROUP));
+      reggroup_add (gdbarch, all_reggroup);
+      reggroup_add (gdbarch, save_reggroup);
+      reggroup_add (gdbarch, restore_reggroup);
     }
 
   return gdbarch;
diff --git a/gdb/target-descriptions.c b/gdb/target-descriptions.c
index a542ef9..dfc2e93 100644
--- a/gdb/target-descriptions.c
+++ b/gdb/target-descriptions.c
@@ -900,40 +900,6 @@ tdesc_numbered_register (const struct tdesc_feature *feature,
   return 1;
 }
 
-/* Search FEATURE for a register REGNO and return its name. */
-char *
-tdesc_find_register_name (const struct tdesc_feature *feature,
-			   int regno)
-{
-  int ixr;
-  struct tdesc_reg *reg;
-
-  for (ixr = 0;
-       VEC_iterate (tdesc_reg_p, feature->registers, ixr, reg);
-       ixr++)
-    if (ixr == regno)
-      return reg->name;
-
-  return NULL;
-}
-
-/* Search FEATURE for a register REGNO and return its group name. */
-char *
-tdesc_find_register_group_name (const struct tdesc_feature *feature,
-			   int regno)
-{
-  int ixr;
-  struct tdesc_reg *reg;
-
-  for (ixr = 0;
-       VEC_iterate (tdesc_reg_p, feature->registers, ixr, reg);
-       ixr++)
-    if (ixr == regno)
-      return reg->group;
-
-  return NULL;
-}
-
 /* Search FEATURE for a register named NAME, but do not assign a fixed
    register number to it.  */
 
diff --git a/gdb/target-descriptions.h b/gdb/target-descriptions.h
index 0d8f03f..ef97d1d 100644
--- a/gdb/target-descriptions.h
+++ b/gdb/target-descriptions.h
@@ -111,18 +111,6 @@ struct tdesc_arch_data *tdesc_data_alloc (void);
 
 void tdesc_data_cleanup (void *data_untyped);
 
-/* Search FEATURE for a register REGNO and return its name. */
-
-char *tdesc_find_register_name (const struct tdesc_feature *feature,
-				int regno);
-
-
-/* Search FEATURE for a register REGNO and return its group name. */
-
-char *tdesc_find_register_group_name (const struct tdesc_feature *feature,
-				      int regno);
-
-
 /* Search FEATURE for a register named NAME.  Record REGNO and the
    register in DATA; when tdesc_use_registers is called, REGNO will be
    assigned to the register.  1 is returned if the register was found,
-- 
2.7.4


