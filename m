From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:33 +0900
Subject: [OpenRISC] [PATCH 07/18] gdb: or1k: add target descriptor support
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-8-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

This patch adds target support to or1k.

Registers names and groups are dynamically created from the tdesc
remote file.

For example, we could have:

  <feature name="org.gnu.gdb.or1k.group10">
    <reg name="ttmr"  bitsize="32" regnum="2216" group="timer"/>
    <reg name="ttcr"  bitsize="32" regnum="2217" group="timer"/>
  </feature>

Then, a group "timer" would be created and timer registers would
be accessible using "info registers timer" and "set $ttmr ..."

While receiving a tdesc file from the remote, found registers and
corresponding groups can displayed using "set debug arch 1" before
setting the target to remote.

For example:

Remote debugging using :50001
Found   93 registers in feature org.gnu.gdb.or1k.group0
Found 1035 registers in feature org.gnu.gdb.or1k.group1
Found 1035 registers in feature org.gnu.gdb.or1k.group2
Found    6 registers in feature org.gnu.gdb.or1k.group3
Found    4 registers in feature org.gnu.gdb.or1k.group4
Found    2 registers in feature org.gnu.gdb.or1k.group5
Found   22 registers in feature org.gnu.gdb.or1k.group6
Found   16 registers in feature org.gnu.gdb.or1k.group7
Found    1 registers in feature org.gnu.gdb.or1k.group8
Found    2 registers in feature org.gnu.gdb.or1k.group9
Found    2 registers in feature org.gnu.gdb.or1k.group10
Found 2218 registers in the tdesc file

Available groups can be displayed with:

(gdb) maintenance print reggroups
 Group      Type
 system     user
 dmmu       user
 immu       user
 dcache     user
 icache     user
 mac        user
 debug      user
 perf       user
 power      user
 pic        user
 timer      user

gdb/ChangeLog:

	* or1k-tdep.c: changes
---
 gdb/or1k-tdep.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 214 insertions(+), 4 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 1a3c16b..cb0871f 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -115,6 +115,8 @@
 #include "dwarf2-frame.h"
 #include "trad-frame.h"
 #include "regset.h"
+#include "remote.h"
+#include "target-descriptions.h"
 
 #include <inttypes.h>
 
@@ -699,7 +701,18 @@ or1k_register_name (struct gdbarch *gdbarch,
 	 the future. */
     };
 
-  return or1k_gdb_reg_names[regnum];
+  /* If we have a target description, use it */
+  if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
+    return tdesc_register_name (gdbarch, regnum);
+  else
+    {
+      if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
+	{
+	  return or1k_gdb_reg_names[regnum];
+	}
+      else
+	return NULL;
+    }
 
 }	/* or1k_register_name() */
 
@@ -781,6 +794,8 @@ or1k_registers_info (struct gdbarch    *gdbarch,
 		     int                regnum,
 		     int                all)
 {
+  struct regcache *regcache = get_current_regcache ();
+
   if (-1 == regnum)
     {
       /* Do all (valid) registers */
@@ -796,12 +811,19 @@ or1k_registers_info (struct gdbarch    *gdbarch,
   else
     {
       /* Do one specified register - if it is part of this architecture */
-      if ('\0' == *(or1k_register_name (gdbarch, regnum)))
+      if ((regnum < OR1K_NUM_REGS_CACHED)
+	  && ('\0' == *(or1k_register_name (gdbarch, regnum))))
 	{
 	  error ("Not a valid register for the current processor type");
 	}
       else
 	{
+	  /* If the register is not in the g/G packet, fetch it from the
+	   * target with a p/P packet.
+	   */
+	  if (regnum >= OR1K_NUM_REGS_CACHED)
+	    target_fetch_registers (regcache, regnum);
+
 	  default_print_registers_info (gdbarch, file, frame, regnum, all);
 	}
     }
@@ -860,8 +882,16 @@ or1k_register_reggroup_p (struct gdbarch  *gdbarch,
       return 0;			/* No vector regs.  */
     }
 
-  /* For any that are not handled above.  */
-  return default_register_reggroup_p (gdbarch, regnum, group);
+  if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
+    {
+      if ((tdesc_register_in_reggroup_p (gdbarch, regnum, group)) != 1)
+	return 0;
+      else
+	return 1;
+    }
+  else
+    /* For any that are not handled above.  */
+    return default_register_reggroup_p (gdbarch, regnum, group);
 
 }	/* or1k_register_reggroup_p() */
 
@@ -1839,6 +1869,115 @@ or1k_regset_from_core_section (struct gdbarch *gdbarch,
 
 }	/* or1k_regset_from_core_section () */
 
+/* -------------------------------------------------------------------------- */
+/*!Create a register group based on a group name.
+
+   We create a group only if group_name is not already a register group name.
+
+   @param[in] gdbarch     The GDB architecture we are using.
+   @param[in] group_name  Name of the new register group.
+
+   @return  1 if the group has been created, 0 otherwise. */
+/* -------------------------------------------------------------------------- */
+static int
+create_register_group (struct gdbarch *gdbarch, const char *group_name)
+{
+  struct reggroup *group;
+  static int first = 1;
+  int group_exist = 0;
+
+  if (group_name == NULL)
+    return 0;
+
+  if (!first)
+    {
+      for (group = reggroup_next (gdbarch, NULL);
+	   group != NULL; group = reggroup_next (gdbarch, group))
+	{
+	  if (strcmp (group_name, reggroup_name (group)) == 0)
+	    group_exist = 1;
+	}
+
+      if (!group_exist)
+	{
+	  /* If the group doesn't exist, create it */
+	  reggroup_add (gdbarch, reggroup_new (group_name, USER_REGGROUP));
+	  return 1;
+	}
+    }
+  else
+    {
+      /* reggroup_next cannot be called during architecture. However,
+       * a first call to reggroup_add execute reggroups_init and then
+       * reggroup_next can be use. We assume the first group name we
+       * create does not exist.
+       */
+      reggroup_add (gdbarch, reggroup_new (group_name, USER_REGGROUP));
+      first = 0;
+    }
+
+  return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+/*!Register all reg found in a feature section.
+
+   Register all reg found in a feature section and create a group for each
+   new register group name found in the tdesc file.
+
+   @param[in]  feature    The feature to search for registers.
+   @param[out] tdesc_data The target descriptor data to fill.
+   @param[out] reg_index  Register index in tdesc_data.
+   @param[in]  gdbarch    The GDB architecture we are using.
+
+   @return  Number of registers found, -1 if error.                           */
+/* -------------------------------------------------------------------------- */
+static int
+get_feature_registers (const struct tdesc_feature *feature,
+		       struct tdesc_arch_data *tdesc_data, int *reg_index,
+		       struct gdbarch *gdbarch)
+{
+  int valid_p;
+  int i;
+  char *name;
+  char *group_name;
+
+  if (feature)
+    {
+      valid_p = 1;
+      i = 0;
+      while (1)
+	{
+	  name = tdesc_find_register_name (feature, i);
+	  if (name)
+	    {
+	      valid_p &=
+		tdesc_numbered_register (feature, tdesc_data, (*reg_index)++,
+					 name);
+	      if (valid_p)
+		{
+		  group_name = tdesc_find_register_group_name (feature, i);
+		  if (group_name)
+		    create_register_group (gdbarch, group_name);
+		}
+	      i++;
+	    }
+	  else
+	    break;
+	}
+
+      if (!valid_p)
+	{
+	  tdesc_data_cleanup (tdesc_data);
+	  return -1;
+	}
+
+      return i;
+
+    }
+
+  return 0;
+}
 
 /* -------------------------------------------------------------------------- */
 /*!Architecture initialization for OpenRISC 1000
@@ -1859,6 +1998,12 @@ or1k_gdbarch_init (struct gdbarch_info  info,
   struct        gdbarch       *gdbarch;
   struct        gdbarch_tdep  *tdep;
   const struct  bfd_arch_info *binfo;
+  struct tdesc_arch_data      *tdesc_data = NULL;
+
+  int i;
+  int reg_index = 0;
+  int retval;
+  int group;
 
   /* Find a candidate among the list of pre-declared architectures.  */
   arches = gdbarch_list_lookup_by_info (arches, &info);
@@ -1971,6 +2116,68 @@ or1k_gdbarch_init (struct gdbarch_info  info,
                                     (gdbarch, or1k_single_step_through_delay);
     }
 
+ /* Check any target description for validity.  */
+  if (tdesc_has_registers (info.target_desc))
+    {
+
+      const struct tdesc_feature *feature;
+      int total_regs = 0;
+      int nb_features;
+      char feature_name[30];
+
+      tdesc_data = tdesc_data_alloc ();
+
+      /* OpenRisc architecture manual define a maximum of 32 registers groups */
+      for (group = 0; group < 32; group++)
+	{
+
+	  sprintf (feature_name, "org.gnu.gdb.or1k.group%d", group);
+	  feature = tdesc_find_feature (info.target_desc, feature_name);
+
+	  retval =
+	    get_feature_registers (feature, tdesc_data, &reg_index, gdbarch);
+
+	  if (retval < 0)
+	    {
+	      tdesc_data_cleanup (tdesc_data);
+	      return NULL;
+	    }
+	  else
+	    {
+	      total_regs += retval;
+	      if (retval && gdbarch_debug)
+		fprintf_unfiltered (gdb_stdout,
+				    "Found %4d registers in feature %s\n",
+				    retval, feature_name);
+	    }
+	}
+      if (gdbarch_debug)
+	fprintf_unfiltered (gdb_stdout,
+			    "Found %4d registers in the tdesc file\n",
+			    total_regs);
+
+      if (!total_regs)
+	{
+	  tdesc_data_cleanup (tdesc_data);
+	  return NULL;
+	}
+    }
+
+  if (tdesc_data)
+    {
+      tdesc_use_registers (gdbarch, info.target_desc, tdesc_data);
+
+      /* Override the normal target description methods to handle our
+         dual real and pseudo registers.  */
+      set_gdbarch_register_name (gdbarch, or1k_register_name);
+      set_gdbarch_register_reggroup_p (gdbarch, or1k_register_reggroup_p);
+
+      set_gdbarch_register_name (gdbarch, or1k_register_name);
+      set_gdbarch_sp_regnum (gdbarch, OR1K_SP_REGNUM);
+      set_gdbarch_pc_regnum (gdbarch, OR1K_NPC_REGNUM);
+      set_gdbarch_num_pseudo_regs (gdbarch, OR1K_NUM_PSEUDO_REGS);
+    }
+
   return gdbarch;
 
 }	/* or1k_gdbarch_init() */
@@ -3017,6 +3224,9 @@ _initialize_or1k_tdep (void)
      they have their BFD defined. */
   gdbarch_register (bfd_arch_or1k, or1k_gdbarch_init, or1k_dump_tdep);
 
+  /* Tell remote stub that we support XML target description.  */
+  register_remote_support_xml ("or1k");
+
   /* Commands to show and set special purpose registers */
   add_info ("spr", or1k_info_spr_command,
 	    "Show the value of a special purpose register");
-- 
2.7.4


