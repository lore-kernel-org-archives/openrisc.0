From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Dec 2017 23:22:57 +0900
Subject: [OpenRISC] [PATCH v3 4/4] tdesc: handle arbitrary strings in
	tdesc_register_in_reggroup_p
In-Reply-To: <20171219142257.13402-1-shorne@gmail.com>
References: <20171219142257.13402-1-shorne@gmail.com>
Message-ID: <20171219142257.13402-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

tdesc_register_in_reggroup_p in now able to handle arbitrary
groups. This is useful when groups are created while the
target descriptor file is received from the remote.

This can be the case of a soft core target processor where
registers/groups can change.

gdb/ChangeLog:

2017-06-06  Franck Jullien  <franck.jullien@gmail.com>
	    Stafford Horne  <shorne@gmail.com>

	* target-descriptions.c (tdesc_register_in_reggroup_p): Support
	arbitrary strings.
	* NEWS (Changes since GDB 8.0): Announce that GDB supports
	arbitrary reggroups.

gdb/testsuite/ChangeLog:

2017-06-06  Stafford Horne  <shorne@gmail.com>

	* gdb.xml/extra-regs.xml: Add example foo reggroup.
	* gdb.xml/tdesc-regs.exp: Add test to check for foo reggroup.

gdb/doc/ChangeLog:

2017-06-06  Stafford Horne  <shorne@gmail.com>

	* gdb.texinfo (Target Description Format): Explain that arbitrary
	strings are now allowed for register groups.
---
 gdb/NEWS                             |  7 ++++
 gdb/doc/gdb.texinfo                  |  9 +++--
 gdb/target-descriptions.c            | 74 ++++++++++++++++++------------------
 gdb/testsuite/gdb.xml/extra-regs.xml |  1 +
 gdb/testsuite/gdb.xml/tdesc-regs.exp |  3 ++
 5 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/gdb/NEWS b/gdb/NEWS
index 44f481d1f5..7d27262aee 100644
--- a/gdb/NEWS
+++ b/gdb/NEWS
@@ -3,6 +3,13 @@
 
 *** Changes since GDB 8.0
 
+* GDB now supports dynamically creating arbitrary register groups specified
+  in XML target descriptions.  This allows for finer grain grouping of
+  registers on systems with a large amount of registers.
+
+* On Unix systems, GDBserver now does globbing expansion and variable
+  substitution in inferior command line arguments.
+
 * The 'ptype' command now accepts a '/o' flag, which prints the
   offsets and sizes of fields in a struct, like the pahole(1) tool.
 
diff --git a/gdb/doc/gdb.texinfo b/gdb/doc/gdb.texinfo
index e169260e7e..a71faaa89c 100644
--- a/gdb/doc/gdb.texinfo
+++ b/gdb/doc/gdb.texinfo
@@ -41761,10 +41761,11 @@ architecture's normal floating point format) of the correct size for
 @var{bitsize}.  The default is @code{int}.
 
 @item group
-The register group to which this register belongs.  It must
-be either @code{general}, @code{float}, or @code{vector}.  If no
- at var{group} is specified, @value{GDBN} will not display the register
-in @code{info registers}.
+The register group to which this register belongs.  It can be one of the
+standard register groups @code{general}, @code{float}, @code{vector} or an
+arbitrary string.  The string should be limited to alphanumeric characters
+and internal hyphens.  If no @var{group} is specified, @value{GDBN} will
+not display the register in @code{info registers}.
 
 @end table
 
diff --git a/gdb/target-descriptions.c b/gdb/target-descriptions.c
index 88ac55f404..1435f3f4cf 100644
--- a/gdb/target-descriptions.c
+++ b/gdb/target-descriptions.c
@@ -111,12 +111,11 @@ struct tdesc_reg : tdesc_element
   int save_restore;
 
   /* The name of the register group containing this register, or empty
-     if the group should be automatically determined from the
-     register's type.  If this is "general", "float", or "vector", the
-     corresponding "info" command should display this register's
-     value.  It can be an arbitrary string, but should be limited to
-     alphanumeric characters and internal hyphens.  Currently other
-     strings are ignored (treated as empty).  */
+     if the group should be automatically determined from the register's
+     type.  This is traditionally "general", "float", "vector" but can
+     also be an arbitrary string.  If defined the corresponding "info"
+     command should display this register's value.  The string should be
+     limited to alphanumeric characters and internal hyphens.  */
   std::string group;
 
   /* The size of the register, in bits.  */
@@ -1279,17 +1278,13 @@ tdesc_remote_register_number (struct gdbarch *gdbarch, int regno)
 }
 
 /* Check whether REGNUM is a member of REGGROUP.  Registers from the
-   target description may be classified as general, float, or vector.
-   Unlike a gdbarch register_reggroup_p method, this function will
-   return -1 if it does not know; the caller should handle registers
-   with no specified group.
-
-   Arbitrary strings (other than "general", "float", and "vector")
-   from the description are not used; they cause the register to be
-   displayed in "info all-registers" but excluded from "info
-   registers" et al.  The names of containing features are also not
-   used.  This might be extended to display registers in some more
-   useful groupings.
+   target description may be classified as general, float, vector or other
+   register groups registered with reggroup_add().  Unlike a gdbarch
+   register_reggroup_p method, this function will return -1 if it does not
+   know; the caller should handle registers with no specified group.
+
+   The names of containing features are not used.  This might be extended
+   to display registers in some more useful groupings.
 
    The save-restore flag is also implemented here.  */
 
@@ -1299,26 +1294,9 @@ tdesc_register_in_reggroup_p (struct gdbarch *gdbarch, int regno,
 {
   struct tdesc_reg *reg = tdesc_find_register (gdbarch, regno);
 
-  if (reg != NULL && !reg->group.empty ())
-    {
-      int general_p = 0, float_p = 0, vector_p = 0;
-
-      if (reg->group == "general")
-	general_p = 1;
-      else if (reg->group == "float")
-	float_p = 1;
-      else if (reg->group == "vector")
-	vector_p = 1;
-
-      if (reggroup == float_reggroup)
-	return float_p;
-
-      if (reggroup == vector_reggroup)
-	return vector_p;
-
-      if (reggroup == general_reggroup)
-	return general_p;
-    }
+  if (reg != NULL && !reg->group.empty ()
+      && (strcmp (reg->group.c_str (), reggroup_name (reggroup)) == 0))
+	return 1;
 
   if (reg != NULL
       && (reggroup == save_reggroup || reggroup == restore_reggroup))
@@ -1421,6 +1399,28 @@ tdesc_use_registers (struct gdbarch *gdbarch,
 	void **slot = htab_find_slot (reg_hash, reg.get (), INSERT);
 
 	*slot = reg.get ();
+	/* Add reggroup if its new.  */
+	if (!reg->group.empty ())
+	  {
+	    struct reggroup *group;
+	    bool group_exists = false;
+
+	    for (group = reggroup_next (gdbarch, NULL);
+		 group != NULL;
+		 group = reggroup_next (gdbarch, group))
+	      {
+		if (strcmp (reg->group.c_str (), reggroup_name (group)) == 0)
+		  {
+		    group_exists = true;
+		    break;
+		  }
+	      }
+
+	    if (!group_exists)
+	      reggroup_add (gdbarch, reggroup_gdbarch_new (gdbarch,
+							   reg->group.c_str (),
+							   USER_REGGROUP));
+	  }
       }
 
   /* Remove any registers which were assigned numbers by the
diff --git a/gdb/testsuite/gdb.xml/extra-regs.xml b/gdb/testsuite/gdb.xml/extra-regs.xml
index 997d6598e5..302e64ce7d 100644
--- a/gdb/testsuite/gdb.xml/extra-regs.xml
+++ b/gdb/testsuite/gdb.xml/extra-regs.xml
@@ -53,5 +53,6 @@
     <reg name="bitfields" bitsize="64" type="struct2"/>
     <reg name="flags" bitsize="32" type="flags"/>
     <reg name="mixed_flags" bitsize="32" type="mixed_flags"/>
+    <reg name="groupreg" bitsize="32" type="uint32" group="foo"/>
   </feature>
 </target>
diff --git a/gdb/testsuite/gdb.xml/tdesc-regs.exp b/gdb/testsuite/gdb.xml/tdesc-regs.exp
index d62ed9841b..e8b7fd506b 100644
--- a/gdb/testsuite/gdb.xml/tdesc-regs.exp
+++ b/gdb/testsuite/gdb.xml/tdesc-regs.exp
@@ -190,6 +190,9 @@ gdb_test "ptype \$flags" \
     "type = flag flags {\r\n *bool X @0;\r\n *uint32_t Y @2;\r\n}"
 gdb_test "ptype \$mixed_flags" \
     "type = flag mixed_flags {\r\n *bool A @0;\r\n *uint32_t B @1-3;\r\n *bool C @4;\r\n *uint32_t D @5;\r\n *uint32_t @6-7;\r\n *enum {yes = 1, no = 0, maybe = 2, so} Z @8-9;\r\n}"
+# Reggroups should have at least general and the extra foo group
+gdb_test "maintenance print reggroups" \
+    " Group\[ \t\]+Type\[ \t\]+\r\n.* general\[ \t\]+user\[ \t\]+\r\n.* foo\[ \t\]+user\[ \t\]+"
 
 load_description "core-only.xml" "" "test-regs.xml"
 # The extra register from the previous description should be gone.
-- 
2.13.6

