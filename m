From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:36 +0900
Subject: [OpenRISC] [PATCH 10/18] gdb: or1k: Fixes for things that broke
	after upstream merge
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-11-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

gdb/ChangeLog:

	* or1k-tdep.c (or1k_fetch_instruction): Change char to gdb_byte
	to prevent pointer signedness error.
	(or1k_push_dummy_code): Likewise.
---
 gdb/or1k-tdep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index f938077..ae57734 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -164,7 +164,7 @@ or1k_fetch_instruction (struct gdbarch *gdbarch,
 			CORE_ADDR       addr)
 {
   enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
-  char            buf[OR1K_INSTLEN];
+  gdb_byte        buf[OR1K_INSTLEN];
   int             status;
 
   status = target_read_memory (addr, buf, OR1K_INSTLEN);
@@ -1247,8 +1247,8 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
   /* Put as many args as possible in registers */
   for (argnum = 0; argnum < nargs; argnum++)
     {
-      char           *val;
-      char            valbuf[sizeof (ULONGEST) ];
+      const gdb_byte *val;
+      gdb_byte        valbuf[sizeof (ULONGEST)];
 
       struct value   *arg      = args[argnum];
       struct type    *arg_type = check_typedef (value_type (arg));
@@ -1266,7 +1266,7 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
       else
 	{
 	  /* Everything else, we just get the value. */
-	  val = (char *) value_contents (arg);
+	  val = value_contents (arg);
 	}
 
       /* Stick the value in a register */
@@ -1346,8 +1346,8 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
   /* Push the remaining args on the stack */
   for (argnum = first_stack_arg; argnum < nargs; argnum++)
     {
-      char           *val;
-      char            valbuf[sizeof (ULONGEST) ];
+      const gdb_byte *val;
+      gdb_byte        valbuf[sizeof (ULONGEST) ];
 
       struct value   *arg      = args[argnum];
       struct type    *arg_type = check_typedef (value_type (arg));
@@ -1364,7 +1364,7 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	}
       else
 	{
-	  val = (char *) value_contents (arg);
+	  val = value_contents (arg);
 	}
 
       gdb_assert (len <= (bpw * 2));
-- 
2.7.4


