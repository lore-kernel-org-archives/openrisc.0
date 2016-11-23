From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:29 +0900
Subject: [OpenRISC] [PATCH 03/18] gdb: or1k: Add or1k_push_dummy_code and
	use it.
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-4-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

gdb/ChangeLog:

	* or1k-tdep.c (or1k_push_dummy_code): New function.
 	(or1k_gdbarch_init): Override default behavior and call dummy
	from the stack. Set the push_dummy_code handler to
	or1k_push_dummy_code.

Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
---
 gdb/or1k-tdep.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 55b9522..d660a39 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -1112,6 +1112,47 @@ or1k_unwind_sp (struct gdbarch    *gdbarch,
 
 }	/* or1k_unwind_sp() */
 
+/*----------------------------------------------------------------------------*/
+/*!Provides return address for dummy call
+
+   Provides an address on the stack where to put a breakpoint as return
+   address for function. bp_addr is the address to which the function should
+   return (which is breakpointed, so gdb can regain control, hence the name).
+
+   @param[in] gdbarch        The architecture to use
+   @param[in] sp             The stack pointer
+   @param[in] function       Pointer to the function that will be called
+   @param[in] args           The arguments
+   @param[in] nargs          Number of ags to push
+   @param[in] value_type     Type of the function result
+   @param[in] real_pc        Resume address
+   @param[in] bp_addr        Breakpoint address
+   @param[in] regcache       The register cache to use
+
+   @return  The breakpoint address */
+/*---------------------------------------------------------------------------*/
+
+static CORE_ADDR
+or1k_push_dummy_code (struct gdbarch *gdbarch,
+		      CORE_ADDR sp,
+		      CORE_ADDR function,
+		      struct value **args,
+		      int nargs,
+		      struct type *value_type,
+		      CORE_ADDR *real_pc,
+		      CORE_ADDR *bp_addr,
+		      struct regcache *regcache)
+{
+  /* Allocate space sufficient for a breakpoint, keeping the stack aligned.  */
+  sp = (sp - 4) & ~15;
+  /* Store the address of that breakpoint */
+  *bp_addr = sp;
+  /* The call starts at the callee's entry point.  */
+  *real_pc = function;
+
+  return sp;
+
+}	/* or1k_push_dummy_code() */
 
 /*----------------------------------------------------------------------------*/
 /*!Create a dummy stack frame
@@ -1888,6 +1929,8 @@ or1k_gdbarch_init (struct gdbarch_info  info,
   set_gdbarch_unwind_sp             (gdbarch, or1k_unwind_sp);
 
   /* Functions handling dummy frames */
+  set_gdbarch_call_dummy_location   (gdbarch, ON_STACK);
+  set_gdbarch_push_dummy_code       (gdbarch, or1k_push_dummy_code);
   set_gdbarch_push_dummy_call       (gdbarch, or1k_push_dummy_call);
   set_gdbarch_dummy_id              (gdbarch, or1k_dummy_id);
 
-- 
2.7.4


