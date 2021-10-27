From: Stafford Horne <shorne@gmail.com>
Date: Thu, 28 Oct 2021 07:07:09 +0900
Subject: [OpenRISC] [PATCH] or1k: Add return address argument to _mcount call
Message-ID: <20211027220709.750104-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

This fixes an issue in the glibc port I am working on where the build
fails due to the warning:

  error: calling ‘__builtin_return_address’ with a nonzero argument is unsafe [-Werror=frame-address]

This is due to how the current implementation of _mcount in glibc uses
__builtin_return_address with a count argument of 1.

Fix that by passing the value of LR_REGNUM to the _mcount function,
effectivtly providing the value _mcount is after.

This is an ABI change, but I think it's OK because the glibc port for
or1k is not yet upstreamed.  Also, I think just adding an argument
should not break anything anyway.

gcc/ChangeLog:

	* config/or1k/or1k.h (PROFILE_HOOK): Add return address argument
	to _mcount.
---
 gcc/config/or1k/or1k.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index fe01ab81ead..4603cb67160 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -387,9 +387,10 @@ do {                                                    \
    profiling a function entry.  */
 #define PROFILE_HOOK(LABEL)						\
   {									\
-    rtx fun;								\
+    rtx fun, ra;							\
+    ra = get_hard_reg_initial_val (Pmode, LR_REGNUM);			\
     fun = gen_rtx_SYMBOL_REF (Pmode, "_mcount");			\
-    emit_library_call (fun, LCT_NORMAL, VOIDmode);			\
+    emit_library_call (fun, LCT_NORMAL, VOIDmode, ra, Pmode);		\
   }
 
 /* All the work is done in PROFILE_HOOK, but this is still required.  */
-- 
2.31.1

