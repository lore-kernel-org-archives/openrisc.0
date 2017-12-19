From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Dec 2017 23:22:55 +0900
Subject: [OpenRISC] [PATCH v3 2/4] reggroups: Convert reggroups from
	post_init to pre_init
In-Reply-To: <20171219142257.13402-1-shorne@gmail.com>
References: <20171219142257.13402-1-shorne@gmail.com>
Message-ID: <20171219142257.13402-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Currently the reggroups gdbarch_data cannot be manipulated until after
the gdbarch is completely initialized.  This is usually done when the
object init depends on architecture specific fields.  In the case of
reggroups it only depends on the obstack being available.

Coverting this to pre_init allows using reggroups during gdbarch
initialization.  This is needed to allow registering arbitrary reggroups
during gdbarch initializations.

gdb/ChangeLog:

2017-06-06  Stafford Horne  <shorne@gmail.com>

	* reggroups.c (reggroups_init): Change to depend only on
	obstack rather than gdbarch.
	(reggroup_add): Remove logic for forcing premature init.
	(_initialize_reggroup): Set `reggroups_data` with
	gdbarch_data_register_pre_init() rather than
	gdbarch_data_register_post_init().
---
 gdb/reggroups.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/gdb/reggroups.c b/gdb/reggroups.c
index 2ecd0b494f..5d5e33f2a3 100644
--- a/gdb/reggroups.c
+++ b/gdb/reggroups.c
@@ -26,6 +26,7 @@
 #include "regcache.h"
 #include "command.h"
 #include "gdbcmd.h"		/* For maintenanceprintlist.  */
+#include "gdb_obstack.h"
 
 /* Individual register groups.  */
 
@@ -76,10 +77,9 @@ struct reggroups
 static struct gdbarch_data *reggroups_data;
 
 static void *
-reggroups_init (struct gdbarch *gdbarch)
+reggroups_init (struct obstack *obstack)
 {
-  struct reggroups *groups = GDBARCH_OBSTACK_ZALLOC (gdbarch,
-						     struct reggroups);
+  struct reggroups *groups = OBSTACK_ZALLOC (obstack, struct reggroups);
 
   groups->last = &groups->first;
   return groups;
@@ -105,13 +105,6 @@ reggroup_add (struct gdbarch *gdbarch, struct reggroup *group)
   struct reggroups *groups
     = (struct reggroups *) gdbarch_data (gdbarch, reggroups_data);
 
-  if (groups == NULL)
-    {
-      /* ULGH, called during architecture initialization.  Patch
-         things up.  */
-      groups = (struct reggroups *) reggroups_init (gdbarch);
-      deprecated_set_gdbarch_data (gdbarch, reggroups_data, groups);
-    }
   add_group (groups, group,
 	     GDBARCH_OBSTACK_ZALLOC (gdbarch, struct reggroup_el));
 }
@@ -298,7 +291,7 @@ struct reggroup *const restore_reggroup = &restore_group;
 void
 _initialize_reggroup (void)
 {
-  reggroups_data = gdbarch_data_register_post_init (reggroups_init);
+  reggroups_data = gdbarch_data_register_pre_init (reggroups_init);
 
   /* The pre-defined list of groups.  */
   add_group (&default_groups, general_reggroup, XNEW (struct reggroup_el));
-- 
2.13.6

