From: Stafford Horne <shorne@gmail.com>
Date: Sun,  1 May 2016 11:18:02 +0900
Subject: [OpenRISC] [PATCH] cgen: sim: Updates to sim files to match gdb
	types
Message-ID: <1462069082-8756-1-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The types like MACH and MODEL have changes to SIM_MACH and SIM_MODEL
make updates to match these changes.  This way people dont have to
manually update the generated files in GDB.

I am from openrisc and working on getting the openrisc sim and gdb patches 
ready for submitting to upstream. This was required to get the sim build to 
work.

2016-05-01  Stafford Horne <shorne@gmail.com>

	* cgen/sim-cpu.scm (cgen-semantics.c, cgen-sem-switch.c): Rename
	TRACE_RESULT to CGEN_TRACE_RESULT.
	* cgen/sim-model.scm (gen-cpu-imp-properties): Rename
	SIM_MACH_IMP_PROPERTIES to SIM_MACH_IMP_PROPERTIES.
	(gen-mach-model-table): Rename MODEL to SIM_MODEL.
	(gen-mach-defns): Rename MACH to SIM_MACH.
	* cgen/sim.scm (op-gen-set-trace, op-gen-set-trace-parallel): Rename
	TRACE_RESULT to CGEN_TRACE_RESULT.
	(gen-mach-decls, gen-mach-data): Rename MACH to SIM_MACH.

 cgen/sim-cpu.scm   | 8 ++++----
 cgen/sim-model.scm | 6 +++---
 cgen/sim.scm       | 8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/cgen/sim-cpu.scm b/cgen/sim-cpu.scm
index b3e5c40..454d734 100644
--- a/cgen/sim-cpu.scm
+++ b/cgen/sim-cpu.scm
@@ -1090,8 +1090,8 @@ CGEN_ATTR_VALUE (NULL, abuf->idesc->attrs, CGEN_INSN_" "attr)")
    FAST_P, when desired, is defined on the command line, -DFAST_P=1.  */
 #if FAST_P
 #define SEM_FN_NAME(cpu,fn) XCONCAT3 (cpu,_semf_,fn)
-#undef TRACE_RESULT
-#define TRACE_RESULT(cpu, abuf, name, type, val)
+#undef CGEN_TRACE_RESULT
+#define CGEN_TRACE_RESULT(cpu, abuf, name, type, val)
 #else
 #define SEM_FN_NAME(cpu,fn) XCONCAT3 (cpu,_sem_,fn)
 #endif
@@ -1188,8 +1188,8 @@ CGEN_ATTR_VALUE (NULL, abuf->idesc->attrs, CGEN_INSN_" "attr)")
    special handlers into the instruction \"stream\".  */
 
 #if FAST_P
-#undef TRACE_RESULT
-#define TRACE_RESULT(cpu, abuf, name, type, val)
+#undef CGEN_TRACE_RESULT
+#define CGEN_TRACE_RESULT(cpu, abuf, name, type, val)
 #endif
 
 #undef GET_ATTR
diff --git a/cgen/sim-model.scm b/cgen/sim-model.scm
index dbc67da..8c05188 100644
--- a/cgen/sim-model.scm
+++ b/cgen/sim-model.scm
@@ -16,7 +16,7 @@
    "\
 /* The properties of this cpu's implementation.  */
 
-static const MACH_IMP_PROPERTIES @cpu at _imp_properties =
+static const SIM_MACH_IMP_PROPERTIES @cpu at _imp_properties =
 {
   sizeof (SIM_CPU),
 #if WITH_SCACHE
@@ -249,7 +249,7 @@ static const MACH_IMP_PROPERTIES @cpu at _imp_properties =
 (define (/gen-mach-model-table mach)
   (string-list
    "\
-static const MODEL " (gen-sym mach) "_models[] =\n{\n"
+static const SIM_MODEL " (gen-sym mach) "_models[] =\n{\n"
    (string-list-map (lambda (model)
 		      (string-list "  { "
 				   "\"" (obj:str-name model) "\", "
@@ -343,7 +343,7 @@ static void\n"
 #endif
 }
 
-const MACH " (gen-sym mach) "_mach =
+const SIM_MACH " (gen-sym mach) "_mach =
 {
   \"" (obj:str-name mach) "\", "
   "\"" (mach-bfd-name mach) "\", "
diff --git a/cgen/sim.scm b/cgen/sim.scm
index 77c2169..f965ef1 100644
--- a/cgen/sim.scm
+++ b/cgen/sim.scm
@@ -1265,7 +1265,7 @@
 ; operand instance table].
 ; Could just scan the operand table for the operand or hardware number,
 ; assuming the operand number is stored in `op'.
-   "    TRACE_RESULT (current_cpu, abuf"
+   "    CGEN_TRACE_RESULT (current_cpu, abuf"
    ", " (send op 'gen-pretty-name mode)
    ", " (mode:printf-type mode)
    ", opval);\n"
@@ -1292,7 +1292,7 @@
 ; operand instance table].
 ; Could just scan the operand table for the operand or hardware number,
 ; assuming the operand number is stored in `op'.
-   "    TRACE_RESULT (current_cpu, abuf"
+   "    CGEN_TRACE_RESULT (current_cpu, abuf"
    ", " (send op 'gen-pretty-name mode)
    ", " (mode:printf-type mode)
    ", opval);\n"
@@ -1464,7 +1464,7 @@
   (string-append
    (string-map (lambda (mach)
 		 (gen-obj-sanitize mach
-				   (string-append "extern const MACH "
+				   (string-append "extern const SIM_MACH "
 						  (gen-sym mach)
 						  "_mach;\n")))
 	       (current-mach-list))
@@ -1475,7 +1475,7 @@
 
 (define (/gen-mach-data)
   (string-append
-   "const MACH *sim_machs[] =\n{\n"
+   "const SIM_MACH *sim_machs[] =\n{\n"
    (string-map (lambda (mach)
 		 (gen-obj-sanitize
 		  mach
-- 
2.5.5


