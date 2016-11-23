From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:30 +0900
Subject: [OpenRISC] [PATCH 04/18] gdb: add tdesc_find_register functions
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-5-git-send-email-shorne@gmail.com>
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

gdb/ChangeLog:

	* target-descriptions.c: (tdesc_find_register_name) create
	(tdesc_find_register_group_name) create
	* target-descriptions.h: (tdesc_find_register_name) create
	(tdesc_find_register_group_name) create
---
 gdb/target-descriptions.c | 34 ++++++++++++++++++++++++++++++++++
 gdb/target-descriptions.h | 12 ++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/gdb/target-descriptions.c b/gdb/target-descriptions.c
index 40f0478..18c39cd 100644
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


