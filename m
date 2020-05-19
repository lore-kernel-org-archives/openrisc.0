From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 May 2020 05:37:46 +0900
Subject: [OpenRISC] [PATCH 1/5] or1k: Implement profile hook calling _mcount
In-Reply-To: <20200519203750.401593-1-shorne@gmail.com>
References: <20200519203750.401593-1-shorne@gmail.com>
Message-ID: <20200519203750.401593-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Defining this to not abort as found when working on running tests in
the glibc test suite.

We implement this with a call to _mcount with no arguments.  The required
return address's will be pulled from the stack.  Passing the LR (r9) as
an argument had problems as sometimes r9 is clobbered by the GOT logic
in the prologue before the call to _mcount.

gcc/ChangeLog:

	* config/or1k/or1k.h (NO_PROFILE_COUNTERS): Define as 1.
	(PROFILE_HOOK): Define to call _mcount.
	(FUNCTION_PROFILER): Change from abort to no-op.
---
 gcc/config/or1k/or1k.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index 23db771d8fb..be089900fd4 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -379,8 +379,19 @@ do {                                                    \
 /* Always pass the SYMBOL_REF for direct calls to the expanders.  */
 #define NO_FUNCTION_CSE 1
 
-/* Profiling */
-#define FUNCTION_PROFILER(FILE,LABELNO) (abort (), 0)
+#define NO_PROFILE_COUNTERS 1
+
+/* Emit rtl for profiling.  Output assembler code to call "_mcount" for
+   profiling a function entry.  */
+#define PROFILE_HOOK(LABEL)						\
+  {									\
+    rtx fun;								\
+    fun = gen_rtx_SYMBOL_REF (Pmode, "_mcount");			\
+    emit_library_call (fun, LCT_NORMAL, VOIDmode);			\
+  }
+
+/* All the work is done in PROFILE_HOOK, but this is still required.  */
+#define FUNCTION_PROFILER(STREAM, LABELNO) do { } while (0)
 
 /* Dwarf 2 Support */
 #define DWARF2_DEBUGGING_INFO 1
-- 
2.26.2

