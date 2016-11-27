From: Stafford Horne <shorne@gmail.com>
Date: Sun, 27 Nov 2016 15:16:43 +0900
Subject: [OpenRISC] [PATCH v2 1/4] gdb: Add tdesc_find_register functions
In-Reply-To: <cover.1480216015.git.shorne@gmail.com>
References: <cover.1480216015.git.shorne@gmail.com>
Message-ID: <ffdc788c10996edca2b068acd5d43fda1592be01.1480216015.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

In order to get registers names and groups from the target descriptor
file, some new functions are needed.

This patch adds:

- tdesc_find_register_name: Search FEATURE for a register REGNO and
  return its name.

- tdesc_find_register_group_name: Search FEATURE for a register
  REGNO and return its group name.

Also, handle arbitrary strings in tdesc_register_in_reggroup_p

tdesc_register_in_reggroup_p in now able to handle arbitrary
groups. This is useful when groups are created while the
target descriptor file is received from the remote.

This can be the case of a soft core target processor's like OpenRISC
where registers/groups can change.

2013-02-15  Franck Jullien  <franck.jullien@gmail.com>

	* target-descriptions.c: (tdesc_find_register_name) Create.
	(tdesc_find_register_group_name) Create.
	(tdesc_register_in_reggroup_p) Support arbitrary groups.
	* target-descriptions.h: (tdesc_find_register_name) Create.
	(tdesc_find_register_group_name) Create.
---
 gdb/target-descriptions.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 gdb/target-descriptions.h | 12 ++++++++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/gdb/target-descriptions.c b/gdb/target-descriptions.c
index 40f0478..a542ef9 100644
--- a/gdb/target-descriptions.c
+++ b/gdb/target-descriptions.c
@@ -900,6 +900,40 @@ tdesc_numbered_register (const struct tdesc_feature *feature,
   return 1;
 }
 
+/* Search FEATURE for a register REGNO and return its name. */
+char *
+tdesc_find_register_name (const struct tdesc_feature *feature,
+			   int regno)
+{
+  int ixr;
+  struct tdesc_reg *reg;
+
+  for (ixr = 0;
+       VEC_iterate (tdesc_reg_p, feature->registers, ixr, reg);
+       ixr++)
+    if (ixr == regno)
+      return reg->name;
+
+  return NULL;
+}
+
+/* Search FEATURE for a register REGNO and return its group name. */
+char *
+tdesc_find_register_group_name (const struct tdesc_feature *feature,
+			   int regno)
+{
+  int ixr;
+  struct tdesc_reg *reg;
+
+  for (ixr = 0;
+       VEC_iterate (tdesc_reg_p, feature->registers, ixr, reg);
+       ixr++)
+    if (ixr == regno)
+      return reg->group;
+
+  return NULL;
+}
+
 /* Search FEATURE for a register named NAME, but do not assign a fixed
    register number to it.  */
 
@@ -1084,12 +1118,8 @@ tdesc_remote_register_number (struct gdbarch *gdbarch, int regno)
    return -1 if it does not know; the caller should handle registers
    with no specified group.
 
-   Arbitrary strings (other than "general", "float", and "vector")
-   from the description are not used; they cause the register to be
-   displayed in "info all-registers" but excluded from "info
-   registers" et al.  The names of containing features are also not
-   used.  This might be extended to display registers in some more
-   useful groupings.
+   The names of containing features are also not used.  This might be
+   extended to display registers in some more useful groupings.
 
    The save-restore flag is also implemented here.  */
 
@@ -1118,6 +1148,10 @@ tdesc_register_in_reggroup_p (struct gdbarch *gdbarch, int regno,
 
       if (reggroup == general_reggroup)
 	return general_p;
+
+      if (strcmp (reg->group, reggroup_name (reggroup)) == 0)
+	return 1;
+
     }
 
   if (reg != NULL
diff --git a/gdb/target-descriptions.h b/gdb/target-descriptions.h
index ef97d1d..0d8f03f 100644
--- a/gdb/target-descriptions.h
+++ b/gdb/target-descriptions.h
@@ -111,6 +111,18 @@ struct tdesc_arch_data *tdesc_data_alloc (void);
 
 void tdesc_data_cleanup (void *data_untyped);
 
+/* Search FEATURE for a register REGNO and return its name. */
+
+char *tdesc_find_register_name (const struct tdesc_feature *feature,
+				int regno);
+
+
+/* Search FEATURE for a register REGNO and return its group name. */
+
+char *tdesc_find_register_group_name (const struct tdesc_feature *feature,
+				      int regno);
+
+
 /* Search FEATURE for a register named NAME.  Record REGNO and the
    register in DATA; when tdesc_use_registers is called, REGNO will be
    assigned to the register.  1 is returned if the register was found,
-- 
2.7.4


