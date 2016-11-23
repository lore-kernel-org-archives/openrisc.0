From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:41 +0900
Subject: [OpenRISC] [PATCH 15/18] gdb: or1k: Update calling conventions to
	help pass tests
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-16-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The calling conventions for handling struct/array return, large scalars
and variadic args were incomplete and causing several gdb testsuite
tests to fail.

These changes were developed with help from olofk.
---
 gdb/or1k-tdep.c | 78 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 8cfa440..a0fd651 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -439,12 +439,12 @@ or1k_return_value (struct gdbarch  *gdbarch,
   unsigned int    rv_size    = TYPE_LENGTH (valtype);
   unsigned int    bpw        = (gdbarch_tdep (gdbarch))->bytes_per_word;
 
-  /* Deal with struct/union first. If this won't fit in a single register it
-     is returned in memory. Large (2 word) scalars are returned in r11 and r12
-     (this is a change from GCC 4.2.2, when they were apparently returned in
-     memory). */
-  if (((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION  == rv_type)) &&
-      (rv_size >  bpw))
+  /* Deal with struct/union as addresses. If an array won't fit in a single
+     register it is returned as address. Anything larger than 2 registers needs
+     to also be passed as address (this is from gcc default_return_in_memory) */
+  if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type) ||
+      ((TYPE_CODE_ARRAY == rv_type) && rv_size > bpw) ||
+      (rv_size > 2*bpw))
     {
       if (readbuf)
 	{
@@ -1225,9 +1225,12 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
   int             argnum;
   int             first_stack_arg;
   int             stack_offset = 0;
+  int             heap_offset = 0;
+  CORE_ADDR       heap_sp = sp - 128;
 
   unsigned int    bpa = (gdbarch_tdep (gdbarch))->bytes_per_address;
   unsigned int    bpw = (gdbarch_tdep (gdbarch))->bytes_per_word;
+  struct type *func_type = value_type (function);
 
   /* Return address */
   regcache_cooked_write_unsigned (regcache, OR1K_LR_REGNUM, bp_addr);
@@ -1237,7 +1240,6 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 
   /* Location for a returned structure. This is passed as a silent first
      argument. */
-
   if (struct_return)
     {
       regcache_cooked_write_unsigned (regcache, OR1K_FIRST_ARG_REGNUM,
@@ -1256,13 +1258,31 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
       int             len      = arg_type->length;
       enum type_code  typecode = arg_type->main_type->code;
 
-      /* Handle the different argument types. */
-      if((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode))
+      if (TYPE_VARARGS (func_type) && argnum >= TYPE_NFIELDS(func_type))
+        {
+          break; /* end or regular args, varargs go to stack */
+        }
+
+      /* Extract the value, either a reference or the data */
+      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode) || (len > bpw*2))
 	{
-	  /* The ABI passes all structures by reference, so get its address. */
-	  store_unsigned_integer (valbuf, bpa, byte_order, value_address (arg));
-	  len      = bpa;
-	  val      = valbuf;
+          CORE_ADDR valaddr = value_address (arg);
+
+          /* if the arg is fabricated (i.e. 3*i, instead of i) valaddr is undefined */
+          if (valaddr == 0) {
+              /* The argument needs to be copied into the target space. Since
+                 the bottom of the stack is reserved for function arguments
+                 we store this at the these at the top growing down. */
+              heap_offset += align_up (len, bpw);
+              valaddr = heap_sp + heap_offset;
+
+              write_memory (valaddr, value_contents(arg), len);
+          }
+
+          /* The ABI passes all structures by reference, so get its address. */
+          store_unsigned_integer (valbuf, bpa, byte_order, valaddr);
+          len      = bpa;
+          val      = valbuf;
 	}
       else
 	{
@@ -1273,9 +1293,7 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
       /* Stick the value in a register */
       if(len > bpw)
 	{
-	  /* Big scalars use two registers, but need NOT be pair aligned. This
-	     code breaks if we can have quad-word scalars (e.g. long
-	     double). */
+	  /* Big scalars use two registers, but need NOT be pair aligned. */
 
 	  if (argreg <= (OR1K_LAST_ARG_REGNUM - 1))
 	    {
@@ -1286,8 +1304,6 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	      ULONGEST      lo   = regval & mask;
 	      ULONGEST      hi   = regval >> bits_per_word;
 
-	      gdb_assert (len <= (bpw * 2));
-
 	      regcache_cooked_write_unsigned (regcache, argreg,     hi);
 	      regcache_cooked_write_unsigned (regcache, argreg + 1, lo);
 	      argreg += 2;
@@ -1328,7 +1344,7 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
       int             len      = arg_type->length;
       enum type_code  typecode = arg_type->main_type->code;
 
-      if((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode))
+      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode) || (len > bpw*2))
 	{
 	  /* Structures are passed as addresses */
 	  sp -= bpa;
@@ -1337,8 +1353,12 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	{
 	/* Big scalars use more than one word. Code here allows for future
 	 quad-word entities (e.g. long double) */
-	  sp -= ((len + bpw - 1) / bpw) * bpw;
+	  sp -= align_up(len, bpw);
 	}
+
+      /* ensure our dummy heap doesn't touch the stack, this could only happen
+         if we have many arguments including fabricated arguments */
+      gdb_assert(heap_offset == 0 || ((heap_sp + heap_offset) < sp));
     }
 
   sp           = gdbarch_frame_align (gdbarch, sp);
@@ -1354,10 +1374,9 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
       struct type    *arg_type = check_typedef (value_type (arg));
       int             len      = arg_type->length;
       enum type_code  typecode = arg_type->main_type->code;
-
       /* The EABI passes structures that do not fit in a register by
 	 reference. In all other cases, pass the structure by value.  */
-      if((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode))
+      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode) || (len > bpw*2))
 	{
 	  store_unsigned_integer (valbuf, bpa, byte_order, value_address (arg));
 	  len      = bpa;
@@ -1368,15 +1387,24 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	  val = value_contents (arg);
 	}
 
-      gdb_assert (len <= (bpw * 2));
+      while (len > 0)
+        {
+          int partial_len = (len < bpw ? len : bpw);
 
-      write_memory (sp + stack_offset, val, len);
-      stack_offset += ((len + bpw - 1) / bpw) * bpw;
+          write_memory (sp + stack_offset, val, partial_len);
+          stack_offset += align_up (partial_len, bpw);
+          len -= partial_len;
+          val += partial_len;
+        }
     }
 
   /* Save the updated stack pointer */
   regcache_cooked_write_unsigned (regcache, OR1K_SP_REGNUM, sp);
 
+  if (heap_offset > 0) {
+    sp = heap_sp;
+  }
+
   return sp;
 
 }	/* or1k_push_dummy_call() */
-- 
2.7.4


