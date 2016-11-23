From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:38 +0900
Subject: [OpenRISC] [PATCH 12/18] gdb: or1k: Apply changes of the last two
	years
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-13-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Wallentowitz <stefan@wallentowitz.de>

gdb/ChangeLog:

	* or1k-tdep.c (or1k_analyse_inst): s/fatal/throw_quit/
	(or1k_skip_prologue): use SYMTAB_COMPUNIT and
	COMPUNIT_DEBUGFORMAT
	(or1k_frame_cache): s/fatal/throw_quit/
	(or1k_regset_from_core_section): remove
	(or1k_iterate_over_regset_sections): create, blank
	implementation
---
 gdb/or1k-tdep.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index ae57734..8cfa440 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -89,7 +89,7 @@
 
 #include "demangle.h"
 #include "defs.h"
-#include "gdb_string.h"
+#include <string.h>
 #include "frame.h"
 #include "inferior.h"
 #include "symtab.h"
@@ -260,7 +260,7 @@ or1k_analyse_inst (uint32_t    inst,
 	  /* Check we got something, and if so skip on */
 	  if (start_ptr == end_ptr)
 	    {
-	      fatal ("bitstring \"%s\" at offset %d has no length field.\n",
+	      throw_quit ("bitstring \"%s\" at offset %d has no length field.\n",
 		     format, i);
 	    }
 
@@ -271,7 +271,7 @@ or1k_analyse_inst (uint32_t    inst,
 	     just should not be wrong. */
 	  if ('b' != format[i++])
 	    {
-	      fatal ("bitstring \"%s\" at offset %d has no terminating 'b'.\n",
+	      throw_quit ("bitstring \"%s\" at offset %d has no terminating 'b'.\n",
 		     format, i);
 	    }
 
@@ -292,7 +292,7 @@ or1k_analyse_inst (uint32_t    inst,
 	  break;
 
 	default:
-	  fatal ("invalid character in bitstring \"%s\" at offset %d.\n",
+	  throw_quit ("invalid character in bitstring \"%s\" at offset %d.\n",
 		 format, i);
 	  break;
 	}
@@ -977,7 +977,8 @@ or1k_skip_prologue (struct gdbarch *gdbarch,
       if (0 != prologue_end)
   	{
 	  struct symtab_and_line  prologue_sal = find_pc_line (start_pc, 0);
-	  const char *debug_format = prologue_sal.symtab->debugformat;
+	  struct compunit_symtab *compunit = SYMTAB_COMPUNIT(prologue_sal.symtab);
+	  const char *debug_format = COMPUNIT_DEBUGFORMAT(compunit);
 
 	  if ((NULL != debug_format) && (strlen ("dwarf") <= strlen (debug_format))
 	      && (0 == strncasecmp ("dwarf", debug_format, strlen ("dwarf"))))
@@ -1575,7 +1576,7 @@ or1k_frame_cache (struct frame_info  *this_frame,
      are frameless and can give up here. */
   if (end_addr < start_addr)
     {
-      fatal ("end addr 0x%08x is less than start addr 0x%08x\n",
+      throw_quit ("end addr 0x%08x is less than start addr 0x%08x\n",
 	     (unsigned int) end_addr, (unsigned int) start_addr);
     }
 
@@ -1850,28 +1851,15 @@ or1k_frame_base_sniffer (struct frame_info *this_frame)
 }	/* or1k_frame_base_sniffer () */
 #endif
 
-
-/* -------------------------------------------------------------------------- */
-/*!Return information needed to handle a core file.
-
-   We put together a regset structure that tells the system how to transfer
-   registers to and from a core file image.
-
-   @param[in] gdbarch    The GDB architecture we are using.
-   @param[in] sect_name  The name of the section being considered.
-   @param[in] sect_size  The size of the section being considered.
-
-   @return  A regset structure for the section, or NULL if none is available. */
-/* -------------------------------------------------------------------------- */
-static const struct regset *
-or1k_regset_from_core_section (struct gdbarch *gdbarch,
-			       const char     *sect_name,
-			       size_t          sect_size)
+/* Iterate over core file register note sections.  */
+static void
+or1k_iterate_over_regset_sections (struct gdbarch *gdbarch,
+				   iterate_over_regset_sections_cb *cb,
+                                   void *cb_data,
+                                   const struct regcache *regcache)
 {
-  printf ("sect_name \"%s\", sect_size %zd\n", sect_name, sect_size);
-  return NULL;
-
-}	/* or1k_regset_from_core_section () */
+  // TODO: Do we need to put something here? (wallento)
+}
 
 /* -------------------------------------------------------------------------- */
 /*!Create a register group based on a group name.
@@ -2091,7 +2079,7 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 #endif
 
   /* Handle core files */
-  set_gdbarch_regset_from_core_section (gdbarch, or1k_regset_from_core_section);
+  set_gdbarch_iterate_over_regset_sections (gdbarch, or1k_iterate_over_regset_sections);
 
   /* Frame unwinders. Use DWARF debug info if available, otherwise use our
      own unwinder. */
-- 
2.7.4


