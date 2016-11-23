From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:43 +0900
Subject: [OpenRISC] [PATCH 17/18] gdb: or1k: Updates for compiler type
	checking
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-18-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

There are several new compiler type checking enabled
in latest build/toolchain.  Fix issues where void* cannot
be blindly cast to type* also issues with enum vs int.

gdb/ChangeLog:

	* or1k-tdep.c (or1k_fetch_instruction): dont pass status
	directly to memory_error as they are different types
	(or1k_pseudo_register_read): return proper typed REG_UNKNOWN
	(or1k_frame_cache): cast result to trad_frame_cache
	(or1k_gdbarch_init): init gdbarch_tdep with XNEW
---
 gdb/or1k-tdep.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index a0fd651..5aa0e7c 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -87,9 +87,7 @@
    been removed.                                                             */
 /*---------------------------------------------------------------------------*/
 
-#include "demangle.h"
 #include "defs.h"
-#include <string.h>
 #include "frame.h"
 #include "inferior.h"
 #include "symtab.h"
@@ -165,13 +163,10 @@ or1k_fetch_instruction (struct gdbarch *gdbarch,
 {
   enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
   gdb_byte        buf[OR1K_INSTLEN];
-  int             status;
 
-  status = target_read_memory (addr, buf, OR1K_INSTLEN);
-
-  if (status)
+  if (target_read_memory (addr, buf, OR1K_INSTLEN))
     {
-      memory_error (status, addr);
+      memory_error (TARGET_XFER_E_IO, addr);
     }
 
   return  extract_unsigned_integer (buf, OR1K_INSTLEN, byte_order);
@@ -638,7 +633,7 @@ or1k_pseudo_register_read (struct gdbarch  *gdbarch,
 			   int              regnum,
 			   gdb_byte        *buf)
 {
-  return 0;
+  return REG_UNKNOWN;
 }	/* or1k_pseudo_register_read() */
 
 
@@ -1545,7 +1540,7 @@ or1k_frame_cache (struct frame_info  *this_frame,
   /* Nothing to do if we already have this info */
   if (NULL != *prologue_cache)
     {
-      return *prologue_cache;
+      return (struct trad_frame_cache *) *prologue_cache;
     }
 
   /* Get a new prologue cache and populate it with default values */
@@ -2037,7 +2032,7 @@ or1k_gdbarch_init (struct gdbarch_info  info,
      know which target we are talking to, but put in some defaults for now. */
 
   binfo                   = info.bfd_arch_info;
-  tdep                    = xmalloc (sizeof *tdep);
+  tdep                    = XNEW (struct gdbarch_tdep);
   tdep->num_matchpoints   = OR1K_MAX_MATCHPOINTS;
   tdep->num_gpr_regs      = OR1K_MAX_GPR_REGS;
   tdep->bytes_per_word    = binfo->bits_per_word    / binfo->bits_per_byte;
-- 
2.7.4


