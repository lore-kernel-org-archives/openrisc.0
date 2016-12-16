From: Stafford Horne <shorne@gmail.com>
Date: Sat, 17 Dec 2016 01:02:51 +0900
Subject: [OpenRISC] [PATCH 1/5] gdb: or1k: Updates suggested by yao in gdb
	review
In-Reply-To: <cover.1481903617.git.shorne@gmail.com>
References: <cover.1481903617.git.shorne@gmail.com>
Message-ID: <96ee67aab495792e1d80f1e2a5ea2f2f267d82ca.1481903617.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Fixes
  configure.tgt
  * remove linux builds

  or1k-tdep.[ch]
  * Fix copyrights, jullien embecosm, remove embecosm
  * indentation to use gnu style (i.e. && and || on left)
  * Fix comments to use gnu style
  * Move some includes around
  * Remove constant variables, replace with constants
  * Remove doxygen on a few calls
  * Have only 1 space between type and var name
  * remove todo about 4 const
  * do fix *buf checks (use buf != NULL)
  * BP_MANIPULATION
  * Use the builtin types for reg register functions
  * or1k_iterate_over_regset_sections - remove no linux, no cores yes
  * Add some of Yao's todo comments

 in .h file
  * remove a bunch of unused macros
---
 gdb/configure.tgt |   14 -
 gdb/or1k-tdep.c   | 2441 +++++++++++++++++++----------------------------------
 gdb/or1k-tdep.h   |  237 +-----
 3 files changed, 881 insertions(+), 1811 deletions(-)

diff --git a/gdb/configure.tgt b/gdb/configure.tgt
index 3a3df97..6c7fe86 100644
--- a/gdb/configure.tgt
+++ b/gdb/configure.tgt
@@ -421,26 +421,12 @@ nios2*-*-*)
 	gdb_target_obs="nios2-tdep.o"
 	;;
 
-or1k-*-linux*)
-	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux
-	gdb_target_obs="or1k-tdep.o"
-	gdb_sim=../sim/or1k/libsim.a
-	build_gdbserver=yes
-	;;
-
 or1k-*-*)
 	# Target: OpenCores OpenRISC 1000 32-bit implementation bare metal
 	gdb_target_obs="or1k-tdep.o"
 	gdb_sim=../sim/or1k/libsim.a
 	;;
 
-or1knd-*-linux*)
-	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux, without delay slot
-	gdb_target_obs="or1k-tdep.o"
-	gdb_sim=../sim/or1k/libsim.a
-	build_gdbserver=yes
-	;;
-
 or1knd-*-*)
 	# Target: OpenCores OpenRISC 1000 32-bit implementation bare metal, without delay slot
 	gdb_target_obs="or1k-tdep.o"
diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 3592ac9..2c5d679 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -1,91 +1,26 @@
-/* Target-dependent code for the 32-bit OpenRISC 1000, for the GNU Debugger.
-
-   Copyright 1988-2008, Free Software Foundation, Inc.
-   Copyright (C) 2008, 2010 Embecosm Limited
-
+/* Target-dependent code for the 32-bit OpenRISC 1000, for the GDB.
+   Copyright (C) 2008-2016, Free Software Foundation, Inc.
    Contributed by Alessandro Forin(af at cs.cmu.edu at CMU
    and by Per Bothner(bothner at cs.wisc.edu) at U.Wisconsin.
-
-   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
-
-   Contributor Franck Jullien <elec4fun@gmail.com>
+   Contributed by Jeremy Bennett <jeremy.bennett@embecosm.com>
+   Contributed by Franck Jullien <franck.jullien@gmail.com> on behalf of 
+   Embecosm Limited
+   Contributed by Stafford Horne <shorne@gmail.com>
 
    This file is part of GDB.
 
-   This program is free software; you can redistribute it and/or modify it
-   under the terms of the GNU General Public License as published by the Free
-   Software Foundation; either version 3 of the License, or (at your option)
-   any later version.
-
-   This program is distributed in the hope that it will be useful, but WITHOUT
-   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-   more details.
-
-   You should have received a copy of the GNU General Public License along
-   with this program.  If not, see <http://www.gnu.org/licenses/>.  */
-
-/*-----------------------------------------------------------------------------
-   This version for the OpenRISC 1000 architecture is a rewrite by Jeremy
-   Bennett of the old GDB 5.3 interface to make use of gdbarch for GDB 6.8. It
-   has since been updated for GDB 7.2 and GDB 7.5.
-
-   The code tries to follow the GDB coding style.
-
-   Commenting is Doxygen compatible.
-
-   Notes on the GDB 7.5 version
-   ============================
-
-   This version is just an upgrade of the previous port. It does use CGEN
-   for instruction lookup in or1k_single_step_through_delay as the new toolchain
-   is CGEN based.
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
 
-   This version is compatible with or1knd target (no delay slot version of the
-   toolchain). We check in bfd_arch_info if the mach is bfd_mach_or1k or
-   bfd_mach_or1knd to choose if or1k_single_step_through_delay must be
-   implemented.
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
 
-   Notes on the GDB 7.2 version
-   ============================
-
-   The primary change is to support the new GCC 4.5.1 compiler, which no
-   longer adds preceding underscores to global values and uses DWARF2 as its
-   default debug format.
-
-   This version now supports Or1ksim integrated as a simulator library, so
-   "target sim" will work. It does require Or1ksim to be available as a
-   library at configuration time, with the Or1ksim installation directory
-   specified by the argument --with-or1ksim.
-
-   The ad-hoc prologue analysis, which was always a weak point has been
-   stripped out and replaced with code based on the generic approach in
-   prologue-value.c and prologue-value.h.
-
-   The objective with this version is to get reasonable results on regression
-   testing. Something the older versions never achieved.
-
-   Notes on the GDB 6.8 version
-   ============================
-
-   Much has been stripped out in the interests of getting a basic working
-   system. This is described as the OpenRISC 1000 target architecture, so
-   should work with 32 and 64 bit versions of that architecture and should
-   work whether or not they have floating point and/or vector registers,
-   although to date it has only been tested with the 32-bit integer
-   archtiecture.
-
-   The info trace command has been removed. The meaning of this is not clear -
-   it relies on a value in register 255 of the debug group, which is
-   undocumented.
-
-   All the hardware trace has been removed for the time being. The new debug
-   interface does not support hardware trace, so there is no plan to reinstate
-   this functionality.
-
-   Support for multiple contexts (which was rudimentary, and not working) has
-   been removed.                                                             */
-/*---------------------------------------------------------------------------*/
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
 
 #include "defs.h"
 #include "frame.h"
@@ -100,9 +35,6 @@
 #include "gdbtypes.h"
 #include "target.h"
 #include "regcache.h"
-
-#include "or1k-tdep.h"
-
 #include "safe-ctype.h"
 #include "block.h"
 #include "reggroups.h"
@@ -119,136 +51,75 @@
 #include <inttypes.h>
 
 #include "dis-asm.h"
-#include "opcodes/or1k-desc.h"
-#include "opcodes/or1k-opc.h"
 
+/* OpenRISC specific includes.  */
+#include "or1k-tdep.h"
 
 
-/* Enum describing different kinds of breakpoints for or1k */
-
-enum or1k_breakpoint_kind
-{
-  /* 32-bit standard OpenRISC breakpoint */
-  OR1K_BP_KIND_OR1K = 2,
-};
-
-/* The gdbarch_tdep structure.  */
+/* The target-dependant structure for gdbarch.  */
 
-/*! OR1K specific per-architecture information. Replaces
-    struct_or1k_implementation. A lot of this info comes from the config regs,
-    so cannot be put in place until we have the actual target. Up until then
-    we have reasonable defaults. */
 struct gdbarch_tdep
 {
-  unsigned int  num_matchpoints;	/* Total matchpoints available. */
-  unsigned int  num_gpr_regs;		/* Number of general registers.  */
-  int           bytes_per_word;
-  int           bytes_per_address;
+  int bytes_per_word;
+  int bytes_per_address;
   CGEN_CPU_DESC gdb_cgen_cpu_desc;
 };
 
-/* Support functions for the architecture definition */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Get an instruction
-
-   This reads from memory. The old version relied on the frame, this relies
-   just on the architecture. The old version also guaranteed not to get a
-   software breakpoint if one had been set. However that seems to happen just
-   before execution and is removed immediately after, so we believe should not
-   happen. The old function from GDB 6.8 to do this has been deleted.
+/* Support functions for the architecture definition.  */
 
-   @param[in] gdbarch  Architecture for which we are getting the instruction.
-   @param[in] addr     Address from which to get the instruction
-
-   @return  The instruction */
-/*---------------------------------------------------------------------------*/
+/* Get an instruction from memory.  */
 
 static ULONGEST
-or1k_fetch_instruction (struct gdbarch *gdbarch,
-			CORE_ADDR       addr)
+or1k_fetch_instruction (struct gdbarch *gdbarch, CORE_ADDR addr)
 {
   enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
-  gdb_byte        buf[OR1K_INSTLEN];
+  gdb_byte buf[OR1K_INSTLEN];
 
   if (target_read_memory (addr, buf, OR1K_INSTLEN))
     {
       memory_error (TARGET_XFER_E_IO, addr);
     }
 
-  return  extract_unsigned_integer (buf, OR1K_INSTLEN, byte_order);
-
-}	/* or1k_fetch_instruction() */
-
-
-/*---------------------------------------------------------------------------*/
-/*!Generic function to read bits from an instruction
-
-   printf style. Basic syntax
-
-      or1k_analyse_inst (inst, format, &arg1, &arg2 ...)
-
-   Format string can contain the following characters:
-
-   - SPACE:  Ignored, just for layout
-   - 0:      Match with a zero bit
-   - 1:      Match with a one bit
-   - %<n>b:  Match <n> bits to the next argument (n decimal)
-
-   If the arg corresponding to a bit field is non-null, the value will be
-   assigned to that argument (using NULL allows fields to be skipped).
-
-   Any bad string will cause a fatal error. These are constant strings, so
-   should be correct.
+  return extract_unsigned_integer (buf, OR1K_INSTLEN, byte_order);
 
-   The bit field must be 32 bits long. A failure here will cause a fatal error
-   for the same reason.
-
-   @note The format string is presented MS field to LS field, left to
-         right. This means that it is read lowest numbered char first.
+}
 
-   @note Some of the arg fields may be populated, even if recognition
-         ultimately fails.
 
-   @param[in]  inst    The instruction to analyse
-   @param[in]  format  The format string
-   @param[out] ...     Argument fields
+/* Generic function to read bits from an instruction.  */
 
-   @return  1 (TRUE) if the instruction matches, 0 (FALSE) otherwise.        */
-/*---------------------------------------------------------------------------*/
 static int
-or1k_analyse_inst (uint32_t    inst,
-		   const char *format,
-		   ...)
+or1k_analyse_inst (uint32_t inst, const char *format, ...)
 {
-  /* Break out each field in turn, validating as we go. */
-  va_list     ap;
+  /* Break out each field in turn, validating as we go.  */
+  va_list ap;
 
-  int         i;
-  int         iptr = 0;			/* Instruction pointer */
+  int i;
+  int iptr = 0;			/* Instruction pointer */
 
   va_start (ap, format);
 
   for (i = 0; 0 != format[i];)
     {
       const char *start_ptr;
-      char       *end_ptr;
+      char *end_ptr;
 
-      uint32_t    bits;			/* Bit substring of interest */
-      uint32_t    width;		/* Substring width */
-      uint32_t   *arg_ptr;
+      uint32_t bits;		/* Bit substring of interest */
+      uint32_t width;		/* Substring width */
+      uint32_t *arg_ptr;
 
       switch (format[i])
 	{
-	case ' ': i++; break;	/* Formatting: ignored */
+	case ' ':
+	  i++;
+	  break;		/* Formatting: ignored */
 
-	case '0': case '1':	/* Constant bit field */
+	case '0':
+	case '1':		/* Constant bit field */
 	  bits = (inst >> (OR1K_INSTBITLEN - iptr - 1)) & 0x1;
 
 	  if ((format[i] - '0') != bits)
 	    {
-	      return  0;
+	      return 0;
 	    }
 
 	  iptr++;
@@ -258,45 +129,49 @@ or1k_analyse_inst (uint32_t    inst,
 	case '%':		/* Bit field */
 	  i++;
 	  start_ptr = &(format[i]);
-	  width     = strtoul (start_ptr, &end_ptr, 10);
+	  width = strtoul (start_ptr, &end_ptr, 10);
 
 	  /* Check we got something, and if so skip on */
 	  if (start_ptr == end_ptr)
 	    {
-	      throw_quit ("bitstring \"%s\" at offset %d has no length field.\n",
-		     format, i);
+	      throw_quit
+		("bitstring \"%s\" at offset %d has no length field.\n",
+		 format, i);
 	    }
 
 	  i += end_ptr - start_ptr;
 
 	  /* Look for and skip the terminating 'b'. If it's not there, we
 	     still give a fatal error, because these are fixed strings that
-	     just should not be wrong. */
+	     just should not be wrong.  */
 	  if ('b' != format[i++])
 	    {
-	      throw_quit ("bitstring \"%s\" at offset %d has no terminating 'b'.\n",
-		     format, i);
+	      throw_quit
+		("bitstring \"%s\" at offset %d has no terminating 'b'.\n",
+		 format, i);
 	    }
 
 	  /* Break out the field. There is a special case with a bit width of
-	     32. */
+	     32.  */
 	  if (32 == width)
 	    {
 	      bits = inst;
 	    }
 	  else
 	    {
-	      bits = (inst >> (OR1K_INSTBITLEN - iptr - width)) & ((1 << width) - 1);
+	      bits =
+		(inst >> (OR1K_INSTBITLEN - iptr - width)) & ((1 << width) -
+							      1);
 	    }
 
-	  arg_ptr   = va_arg (ap, uint32_t *);
-	  *arg_ptr  = bits;
-	  iptr     += width;
+	  arg_ptr = va_arg (ap, uint32_t *);
+	  *arg_ptr = bits;
+	  iptr += width;
 	  break;
 
 	default:
 	  throw_quit ("invalid character in bitstring \"%s\"@offset %d.\n",
-		 format, i);
+		      format, i);
 	  break;
 	}
     }
@@ -304,161 +179,99 @@ or1k_analyse_inst (uint32_t    inst,
   /* Is the length OK? */
   gdb_assert (OR1K_INSTBITLEN == iptr);
 
-  return  1;				/* We succeeded */
-
-}	/* or1k_analyse_inst () */
-
-
-/*---------------------------------------------------------------------------*/
-/*!Analyse a l.addi instruction
-
-   General form is:
+  return 1; /* We succeeded */
 
-     l.addi  rD,rA,I
+}
 
-   Makes use of the generic analysis function (@see or1k_analyse_inst ()).
 
-   @param[in]  inst      The instruction to analyse.
-   @param[out] rd_ptr    Pointer to the rD value.
-   @param[out] ra_ptr    Pointer to the rA value.
-   @param[out] simm_ptr  Pointer to the signed immediate value.
+/* Analyse a l.addi instruction in form: l.addi  rD,rA,I. This is used
+   to parse add instructions during various prologue analysis routines.  */
 
-   @return  1 (TRUE) if the instruction matches, 0 (FALSE) otherwise.        */
-/*---------------------------------------------------------------------------*/
 static int
-or1k_analyse_l_addi (uint32_t      inst,
+or1k_analyse_l_addi (uint32_t inst,
 		     unsigned int *rd_ptr,
-		     unsigned int *ra_ptr,
-		     int          *simm_ptr)
+		     unsigned int *ra_ptr, int *simm_ptr)
 {
   /* Instruction fields */
-  uint32_t  rd, ra, i;
+  uint32_t rd, ra, i;
 
   if (or1k_analyse_inst (inst, "10 0111 %5b %5b %16b", &rd, &ra, &i))
     {
-      /* Found it. Construct the result fields */
-      *rd_ptr   = (unsigned int) rd;
-      *ra_ptr   = (unsigned int) ra;
+      /* Found it. Construct the result fields.  */
+      *rd_ptr = (unsigned int) rd;
+      *ra_ptr = (unsigned int) ra;
       *simm_ptr = (int) (((i & 0x8000) == 0x8000) ? 0xffff0000 | i : i);
 
-      return  1;		/* Success */
+      return 1;		/* Success */
     }
   else
     {
-      return  0;		/* Failure */
+      return 0;		/* Failure */
     }
-}	/* or1k_analyse_l_addi () */
-
-
-/*---------------------------------------------------------------------------*/
-/*!Analyse a l.sw instruction
-
-   General form is:
-
-     l.sw  I(rA),rB
+}
 
-   Makes use of the generic analysis function (@see or1k_analyse_inst ()).
 
-   @param[in]  inst      The instruction to analyse.
-   @param[out] simm_ptr  Pointer to the signed immediate value.
-   @param[out] ra_ptr    Pointer to the rA value.
-   @param[out] rb_ptr    Pointer to the rB value.
+/* Analyse a l.sw instruction in form: l.sw  I(rA),rB. This is used to
+   to parse store instructions during various prologue analysis routines.  */
 
-   @return  1 (TRUE) if the instruction matches, 0 (FALSE) otherwise.        */
-/*---------------------------------------------------------------------------*/
 static int
-or1k_analyse_l_sw (uint32_t      inst,
-		   int          *simm_ptr,
-		   unsigned int *ra_ptr,
-		   unsigned int *rb_ptr)
+or1k_analyse_l_sw (uint32_t inst,
+		   int *simm_ptr, unsigned int *ra_ptr, unsigned int *rb_ptr)
 {
   /* Instruction fields */
-  uint32_t  ihi, ilo, ra, rb;
+  uint32_t ihi, ilo, ra, rb;
 
   if (or1k_analyse_inst (inst, "11 0101 %5b %5b %5b %11b", &ihi, &ra, &rb,
 			 &ilo))
 
     {
-      /* Found it. Construct the result fields */
-      *simm_ptr  = (int) ((ihi << 11) | ilo);
+      /* Found it. Construct the result fields.  */
+      *simm_ptr = (int) ((ihi << 11) | ilo);
       *simm_ptr |= ((ihi & 0x10) == 0x10) ? 0xffff0000 : 0;
 
-      *ra_ptr    = (unsigned int) ra;
-      *rb_ptr    = (unsigned int) rb;
+      *ra_ptr = (unsigned int) ra;
+      *rb_ptr = (unsigned int) rb;
 
-      return  1;		/* Success */
+      return 1;		/* Success */
     }
   else
     {
-      return  0;		/* Failure */
+      return 0;		/* Failure */
     }
-}	/* or1k_analyse_l_sw () */
-
-
+}
 
 
-/* Functions defining the architecture */
-
+/* Functions defining the architecture.  */
 
-/*----------------------------------------------------------------------------*/
-/*!Determine the return convention used for a given type
-
-   Optionally, fetch or set the return value via "readbuf" or "writebuf"
-   respectively using "regcache" for the register values.
-
-   The OpenRISC 1000 returns scalar values via R11 and (for 64 bit values on
-   32 bit architectures) R12. Structs and unions are returned by reference,
-   with the address in R11
-
-   The result returned is independent of the function type, so we ignore that.
-
-   Throughout use read_memory(), not target_read_memory(), since the address
-   may be invalid and we want an error reported (read_memory() is
-   target_read_memory() with error reporting).
-
-   @todo This implementation is labelled OR1K, but in fact is just for the 32
-         bit version, OR1K. This should be made explicit
-
-   @param[in]  gdbarch   The GDB architecture being used
-   @param[in]  functype  The type of the function to be called (may be NULL)
-   @param[in]  valtype   The type of the entity to be returned
-   @param[in]  regcache  The register cache
-   @param[in]  readbuf   Buffer into which the return value should be written
-   @param[out] writebuf  Buffer from which the return value should be written
-
-   @return  The type of return value */
-/*---------------------------------------------------------------------------*/
+/* Implement the return_value gdbarch method.  */
 
 static enum return_value_convention
-or1k_return_value (struct gdbarch  *gdbarch,
-		   struct value    *functype,
-		   struct type     *valtype,
-		   struct regcache *regcache,
-		   gdb_byte        *readbuf,
-		   const gdb_byte  *writebuf)
+or1k_return_value (struct gdbarch *gdbarch, struct value *functype,
+		   struct type *valtype, struct regcache *regcache,
+		   gdb_byte *readbuf, const gdb_byte *writebuf)
 {
   enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
-  enum type_code  rv_type    = TYPE_CODE (valtype);
-  unsigned int    rv_size    = TYPE_LENGTH (valtype);
-  unsigned int    bpw        = (gdbarch_tdep (gdbarch))->bytes_per_word;
+  enum type_code rv_type = TYPE_CODE (valtype);
+  unsigned int rv_size = TYPE_LENGTH (valtype);
+  unsigned int bpw = (gdbarch_tdep (gdbarch))->bytes_per_word;
 
   /* Deal with struct/union as addresses. If an array won't fit in a single
      register it is returned as address. Anything larger than 2 registers needs
-     to also be passed as address (this is from gcc default_return_in_memory) */
-  if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type) ||
-      ((TYPE_CODE_ARRAY == rv_type) && rv_size > bpw) ||
-      (rv_size > 2*bpw))
+     to also be passed as address (matches gcc default_return_in_memory).  */
+  if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type)
+      || ((TYPE_CODE_ARRAY == rv_type) && (rv_size > bpw))
+      || (rv_size > 2 * bpw))
     {
-      if (readbuf)
+      if (readbuf != NULL)
 	{
-	  ULONGEST        tmp;
+	  ULONGEST tmp;
 
 	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
 	  read_memory (tmp, readbuf, rv_size);
 	}
-      if (writebuf)
+      if (writebuf != NULL)
 	{
-	  ULONGEST        tmp;
+	  ULONGEST tmp;
 
 	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
 	  write_memory (tmp, writebuf, rv_size);
@@ -469,19 +282,19 @@ or1k_return_value (struct gdbarch  *gdbarch,
 
   if (rv_size <= bpw)
     {
-      /* up to one word scalars are returned in R11 */
-      if (readbuf)
+      /* Up to one word scalars are returned in R11.  */
+      if (readbuf != NULL)
 	{
-	  ULONGEST        tmp;
+	  ULONGEST tmp;
 
 	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
 	  store_unsigned_integer (readbuf, rv_size, byte_order, tmp);
 
 	}
-      if (writebuf)
+      if (writebuf != NULL)
 	{
-	  gdb_byte buf[4];			/* TODO - fixed const! */
-	  memset (buf, 0, sizeof (buf));	/* Zero pad if < bpw bytes */
+	  gdb_byte buf[4];
+	  memset (buf, 0, sizeof (buf)); /* Zero pad if < bpw bytes */
 
 	  if (BFD_ENDIAN_BIG == byte_order)
 	    {
@@ -489,7 +302,7 @@ or1k_return_value (struct gdbarch  *gdbarch,
 	    }
 	  else
 	    {
-	      memcpy (buf,                          writebuf, rv_size);
+	      memcpy (buf, writebuf, rv_size);
 	    }
 
 	  regcache_cooked_write (regcache, OR1K_RV_REGNUM, buf);
@@ -497,238 +310,136 @@ or1k_return_value (struct gdbarch  *gdbarch,
     }
   else
     {
-      /* 2 word scalars are returned in r11/r12 (with the MS word in r11). */
-      if (readbuf)
+      /* 2 word scalars are returned in r11/r12 (with the MS word in r11).  */
+      if (readbuf != NULL)
 	{
-	  ULONGEST        tmp_lo;
-	  ULONGEST        tmp_hi;
-	  ULONGEST        tmp;
+	  ULONGEST tmp_lo;
+	  ULONGEST tmp_hi;
+	  ULONGEST tmp;
 
-	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM    , &tmp_hi);
-	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM + 1, &tmp_lo);
+	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp_hi);
+	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM + 1,
+					 &tmp_lo);
 	  tmp = (tmp_hi << (bpw * 8)) | tmp_lo;
 
 	  store_unsigned_integer (readbuf, rv_size, byte_order, tmp);
 	}
-      if (writebuf)
+      if (writebuf != NULL)
 	{
-	  gdb_byte buf_lo[4];			/* TODO - fixed const! */
-	  gdb_byte buf_hi[4];			/* TODO - fixed const! */
+	  gdb_byte buf_lo[4];
+	  gdb_byte buf_hi[4];
 
 	  memset (buf_lo, 0, sizeof (buf_lo));	/* Zero pad if < bpw bytes */
 	  memset (buf_hi, 0, sizeof (buf_hi));	/* Zero pad if < bpw bytes */
 
 	  /* This is cheating. We assume that we fit in 2 words exactly, which
 	     wouldn't work if we had (say) a 6-byte scalar type on a big
-	     endian architecture (with the OpenRISC 1000 usually is). */
-	  memcpy (buf_hi, writebuf,       rv_size - bpw);
+	     endian architecture (with the OpenRISC 1000 usually is).  */
+	  memcpy (buf_hi, writebuf, rv_size - bpw);
 	  memcpy (buf_lo, writebuf + bpw, bpw);
 
-	  regcache_cooked_write (regcache, OR1K_RV_REGNUM,     buf_hi);
+	  regcache_cooked_write (regcache, OR1K_RV_REGNUM, buf_hi);
 	  regcache_cooked_write (regcache, OR1K_RV_REGNUM + 1, buf_lo);
 	}
     }
 
   return RETURN_VALUE_REGISTER_CONVENTION;
 
-}	/* or1k_return_value() */
-
-
-
-/*----------------------------------------------------------------------------*/
-/*!Determine the kind of breakpoint based on the current pc
-
-   Given the pc address, return the type of breapoint that should be used.
-   For or1k we only use one type which is a 32-bit trap instruction.
-
-   @param[in]  gdbarch  The GDB architecture being used
-   @param[in]  pcptr    The program counter address in question
-
-   @return  The breakpoint type */
-/*----------------------------------------------------------------------------*/
-
-static int
-or1k_breakpoint_kind_from_pc (struct gdbarch *gdbarch, CORE_ADDR *pcptr)
-{
-  return OR1K_BP_KIND_OR1K;
-}	/* or1k_breakpoint_kind_from_pc() */
-
-/*----------------------------------------------------------------------------*/
-/*!Determine the instruction to use for a breakpoint.
-
-   Given the address at which to insert a breakpoint (bp_addr), what will
-   that breakpoint be?
-
-   For or1k, we have a breakpoint instruction. Since all or1k instructions
-   are 32 bits, this is all we need, regardless of address.
-
-   @param[in]  gdbarch	The GDB architecture being used
-   @param[in]  kind	The kind of breakpoint to be returned
-   @param[out] size	The size of instruction selected
-
-   @return  The chosen breakpoint instruction */
-/*---------------------------------------------------------------------------*/
-
-static const gdb_byte *
-or1k_sw_breakpoint_from_kind (struct gdbarch *gdbarch, int kind, int *size)
-{
-
-  switch (kind)
-    {
-    case OR1K_BP_KIND_OR1K:
-      {
-        static const gdb_byte breakpoint[] = OR1K_BRK_INSTR_STRUCT;
-        
-        *size = OR1K_INSTLEN;
-        return breakpoint;
-      }
-    default:
-      gdb_assert_not_reached ("unexpected or1k breakpoint kind");
-    };
-}	/* or1k_sw_breakpoint_from_kind() */
-
+}
 
-/*----------------------------------------------------------------------------*/
-/*!Determine if we are executing a delay slot
+/* OR1K always uses a l.trap instruction for breakpoints.  */
 
-   Looks at the instruction@the previous instruction to see if it was one
-   with a delay slot. But it also has to be the address prior to NPC, because
-   we may have just taken an exception.
+constexpr gdb_byte or1k_break_insn[] = {0x21, 0x00, 0x00, 0x01};
 
-   @param[in] gdbarch     The GDB architecture being used
-   @param[in] this_frame  Information about THIS frame
+typedef BP_MANIPULATION (or1k_break_insn) or1k_breakpoint;
 
-   @return  1 (true) if this instruction is executing a delay slot, 0 (false)
-   otherwise. */
-/*--------------------------------------------------------------------------*/
+/* Implement the single_step_through_delay gdbarch method  */
 
 static int
-or1k_single_step_through_delay (struct gdbarch    *gdbarch,
+or1k_single_step_through_delay (struct gdbarch *gdbarch,
 				struct frame_info *this_frame)
 {
-  struct regcache     *regcache = get_current_regcache ();
-  ULONGEST            val;
-  CORE_ADDR           ppc;
-  CORE_ADDR           npc;
-  CGEN_FIELDS         tmp_fields;
-  const CGEN_INSN     *insns;
+  ULONGEST val;
+  CORE_ADDR ppc;
+  CORE_ADDR npc;
+  CGEN_FIELDS tmp_fields;
+  const CGEN_INSN *insns;
+  struct regcache *regcache = get_current_regcache ();
   struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
 
   /* Get and the previous and current instruction addresses. If they are not
      adjacent, we cannot be in a delay slot. */
   regcache_cooked_read_unsigned (regcache, OR1K_PPC_REGNUM, &val);
-  ppc        = (CORE_ADDR) val;
+  ppc = (CORE_ADDR) val;
   regcache_cooked_read_unsigned (regcache, OR1K_NPC_REGNUM, &val);
-  npc        = (CORE_ADDR) val;
+  npc = (CORE_ADDR) val;
 
   if (0x4 != (npc - ppc))
     {
-      return  0;
+      return 0;
     }
 
   insns = cgen_lookup_insn (tdep->gdb_cgen_cpu_desc,
-                            NULL,
-                            or1k_fetch_instruction (gdbarch, ppc),
-                            NULL,
-                            32,
-                            &tmp_fields,
-                            0);
+			    NULL,
+			    or1k_fetch_instruction (gdbarch, ppc),
+			    NULL, 32, &tmp_fields, 0);
 
   /* TODO: we should add a delay slot flag to the CGEN_INSN and remove
    * this hard coded test. */
-  return ((CGEN_INSN_NUM(insns) == OR1K_INSN_L_J) ||
-          (CGEN_INSN_NUM(insns) == OR1K_INSN_L_JAL) ||
-          (CGEN_INSN_NUM(insns) == OR1K_INSN_L_JR) ||
-          (CGEN_INSN_NUM(insns) == OR1K_INSN_L_JALR) ||
-          (CGEN_INSN_NUM(insns) == OR1K_INSN_L_BNF) ||
-          (CGEN_INSN_NUM(insns) == OR1K_INSN_L_BF));
-
-}	/* or1k_single_step_through_delay() */
+  return ((CGEN_INSN_NUM (insns) == OR1K_INSN_L_J)
+	  || (CGEN_INSN_NUM (insns) == OR1K_INSN_L_JAL)
+	  || (CGEN_INSN_NUM (insns) == OR1K_INSN_L_JR)
+	  || (CGEN_INSN_NUM (insns) == OR1K_INSN_L_JALR)
+	  || (CGEN_INSN_NUM (insns) == OR1K_INSN_L_BNF)
+	  || (CGEN_INSN_NUM (insns) == OR1K_INSN_L_BF));
 
+}
 
-/*----------------------------------------------------------------------------*/
-/*!Read a pseudo register
-
-   Since we have no pseudo registers this is a null function for now.
+/* Read a pseudo register.  */
 
-   @todo The floating point and vector registers ought to be done as
+/*
+   TODO The floating point and vector registers ought to be done as
          pseudo-registers.
-
-   @param[in]  gdbarch   The GDB architecture to consider
-   @param[in]  regcache  The cached register values as an array
-   @param[in]  regnum    The register to read
-   @param[out] buf       A buffer to put the result in */
-/*---------------------------------------------------------------------------*/
+*/
 
 static enum register_status
-or1k_pseudo_register_read (struct gdbarch  *gdbarch,
+or1k_pseudo_register_read (struct gdbarch *gdbarch,
 			   struct regcache *regcache,
-			   int              regnum,
-			   gdb_byte        *buf)
+			   int regnum, gdb_byte * buf)
 {
   return REG_UNKNOWN;
-}	/* or1k_pseudo_register_read() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Write a pseudo register
-
-   Since we have no pseudo registers this is a null function for now.
+}
 
-   @todo The floating point and vector registers ought to be done as
-         pseudo-registers.
 
-   @param[in] gdbarch   The GDB architecture to consider
-   @param[in] regcache  The cached register values as an array
-   @param[in] regnum    The register to read
-   @param[in] buf       A buffer with the value to write */
-/*---------------------------------------------------------------------------*/
+/* Write a pseudo register.  */
 
 static void
-or1k_pseudo_register_write (struct gdbarch  *gdbarch,
+or1k_pseudo_register_write (struct gdbarch *gdbarch,
 			    struct regcache *regcache,
-			    int              regnum,
-			    const gdb_byte  *buf)
+			    int regnum, const gdb_byte * buf)
 {
   return;
 
-}	/* or1k_pseudo_register_write() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Return the register name for the OpenRISC 1000 architecture
+}
 
-   This version converted to ANSI C, made static and incorporates the static
-   table of register names (this is the only place it is referenced).
+/* Name for or1k general registers.  */
 
-   @todo The floating point and vector registers ought to be done as
-         pseudo-registers.
+static const char *const or1k_reg_names[OR1K_NUM_REGS_CACHED] = {
+  /* general purpose registers */
+  "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
+  "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+  "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+  "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
 
-   @param[in] gdbarch  The GDB architecture being used
-   @param[in] regnum    The register number
+  /* previous program counter, next program counter and status register */
+  "ppc", "npc", "sr"
+};
 
-   @return  The textual name of the register */
-/*---------------------------------------------------------------------------*/
+/* Implement the register_name gdbarch method.  */
 
 static const char *
-or1k_register_name (struct gdbarch *gdbarch,
-		    int             regnum)
+or1k_register_name (struct gdbarch *gdbarch, int regnum)
 {
-  static char *or1k_gdb_reg_names[OR1K_NUM_REGS_CACHED] =
-    {
-      /* general purpose registers */
-      "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
-      "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
-      "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
-      "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
-
-      /* previous program counter, next program counter and status register */
-      "ppc",   "npc",   "sr"
-
-      /* Floating point and vector registers may appear as pseudo registers in
-	 the future. */
-    };
-
   /* If we have a target description, use it */
   if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
     return tdesc_register_name (gdbarch, regnum);
@@ -736,105 +447,68 @@ or1k_register_name (struct gdbarch *gdbarch,
     {
       if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
 	{
-	  return or1k_gdb_reg_names[regnum];
+	  return or1k_reg_names[regnum];
 	}
       else
 	return NULL;
     }
 
-}	/* or1k_register_name() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Identify the type of a register
-
-   @todo I don't fully understand exactly what this does, but I think this
-         makes sense!
-
-   @param[in] arch     The GDB architecture to consider
-   @param[in] regnum   The register to identify
+}
 
-   @return  The type of the register */
-/*---------------------------------------------------------------------------*/
+/* Implement the register_type gdbarch method.  */
 
 static struct type *
-or1k_register_type (struct gdbarch *arch,
-		    int             regnum)
+or1k_register_type (struct gdbarch *gdbarch, int regnum)
 {
-  static struct type *void_func_ptr = NULL;
-  static struct type *void_ptr      = NULL;
-
-  /* Set up the static pointers once, the first time*/
-  if (NULL == void_func_ptr)
-    {
-      struct type *void_type = builtin_type (arch)->builtin_void;
-
-      void_ptr      = lookup_pointer_type (void_type);
-      void_func_ptr = lookup_pointer_type (lookup_function_type (void_type));
-    }
-
-  if((regnum >= 0) && (regnum < OR1K_TOTAL_NUM_REGS))
+  if ((regnum >= 0) && (regnum < OR1K_TOTAL_NUM_REGS))
     {
       switch (regnum)
 	{
 	case OR1K_PPC_REGNUM:
 	case OR1K_NPC_REGNUM:
-	  return void_func_ptr;			/* Pointer to code */
+	  return builtin_type (gdbarch)->builtin_func_ptr;	/* Pointer to code */
 
 	case OR1K_SP_REGNUM:
 	case OR1K_FP_REGNUM:
-	  return void_ptr;				/* Pointer to data */
+	  return builtin_type (gdbarch)->builtin_data_ptr;	/* Pointer to data */
 
 	default:
-	  return builtin_type (arch)->builtin_uint32;	/* Data */
+	  return builtin_type (gdbarch)->builtin_uint32;	/* Data */
 	}
     }
 
   internal_error (__FILE__, __LINE__,
-		  _("or1k_register_type: illegal register number %d"), regnum);
-
-}	/* or1k_register_type() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Handle the "info register" command
+		  _("or1k_register_type: illegal register number %d"),
+		  regnum);
 
-   Print the identified register, unless it is -1, in which case print all
-   the registers. If all is 1 means all registers, otherwise only the core
-   GPRs.
-
-   @todo At present all registers are printed with the default method. Should
-         there be something special for FP registers?
-
-   @param[in] gdbarch  The GDB architecture being used
-   @param[in] file     File handle for use with any custom I/O
-   @param[in] frame    Frame info for use with custom output
-   @param[in] regnum   Register of interest, or -1 if all registers
-   @param[in] all      1 if all means all, 0 if all means just GPRs
+}
 
-   @return  The aligned stack frame address */
-/*---------------------------------------------------------------------------*/
+/* Implement the registers_info gdbarch method.  */
 
 static void
-or1k_registers_info (struct gdbarch    *gdbarch,
-		     struct ui_file    *file,
-		     struct frame_info *frame,
-		     int                regnum,
-		     int                all)
+or1k_registers_info (struct gdbarch *gdbarch,
+		     struct ui_file *file,
+		     struct frame_info *frame, int regnum, int all)
 {
   struct regcache *regcache = get_current_regcache ();
 
+/* TODO
+or1k_registers_info should print the registers contents from FRAME
+rather than current regcache.
+*/
+
   if (-1 == regnum)
     {
       /* Do all (valid) registers */
-      unsigned int  lim = all ? OR1K_NUM_REGS_CACHED : OR1K_MAX_GPR_REGS;
+      unsigned int lim = all ? OR1K_NUM_REGS_CACHED : OR1K_MAX_GPR_REGS;
 
-      for (regnum = 0; regnum < lim; regnum++) {
-	if ('\0' != *(or1k_register_name (gdbarch, regnum)))
-	  {
-	    or1k_registers_info (gdbarch, file, frame, regnum, all);
-	  }
-      }
+      for (regnum = 0; regnum < lim; regnum++)
+	{
+	  if ('\0' != *(or1k_register_name (gdbarch, regnum)))
+	    {
+	      or1k_registers_info (gdbarch, file, frame, regnum, all);
+	    }
+	}
     }
   else
     {
@@ -852,62 +526,49 @@ or1k_registers_info (struct gdbarch    *gdbarch,
 	  if (regnum >= OR1K_NUM_REGS_CACHED)
 	    target_fetch_registers (regcache, regnum);
 
+/* TODO
+Why is a register not in the g/G packet?  Again, we shouldn't fetch
+registers now.
+*/
+
 	  default_print_registers_info (gdbarch, file, frame, regnum, all);
 	}
     }
-}	/* or1k_registers_info() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Identify if a register belongs to a specified group
-
-   Return true if the specified register is a member of the specified
-   register group.
-
-   These are the groups of registers that can be displayed via "info reg".
-
-   @todo The Vector and Floating Point registers ought to be displayed as
-         pseudo-registers.
+}
 
-   @param[in] gdbarch  The GDB architecture to consider
-   @param[in] regnum   The register to consider
-   @param[in] group    The group to consider
 
-   @return  True (1) if regnum is a member of group */
-/*---------------------------------------------------------------------------*/
+/* Implement the register_reggroup_p gdbarch method.  */
 
 static int
-or1k_register_reggroup_p (struct gdbarch  *gdbarch,
-			  int              regnum,
-			  struct reggroup *group)
+or1k_register_reggroup_p (struct gdbarch *gdbarch,
+			  int regnum, struct reggroup *group)
 {
   struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
 
   /* All register group */
   if (group == all_reggroup)
     {
-      return ((regnum >= 0) &&
-	      (regnum < OR1K_NUM_REGS_CACHED) &&
-	      (or1k_register_name (gdbarch, regnum)[0] != '\0'));
+      return ((regnum >= 0)
+	      && (regnum < OR1K_NUM_REGS_CACHED)
+	      && (or1k_register_name (gdbarch, regnum)[0] != '\0'));
     }
 
   /* For now everything except the PC */
   if (group == general_reggroup)
     {
-      return ((regnum >= OR1K_ZERO_REGNUM) &&
-	      (regnum <  tdep->num_gpr_regs) &&
-	      (regnum != OR1K_PPC_REGNUM) &&
-	      (regnum != OR1K_NPC_REGNUM));
+      return ((regnum >= OR1K_ZERO_REGNUM)
+	      && (regnum < OR1K_MAX_GPR_REGS)
+	      && (regnum != OR1K_PPC_REGNUM) && (regnum != OR1K_NPC_REGNUM));
     }
 
   if (group == float_reggroup)
     {
-      return 0;			/* No float regs.  */
+      return 0;	/* No float regs.  */
     }
 
   if (group == vector_reggroup)
     {
-      return 0;			/* No vector regs.  */
+      return 0;	/* No vector regs.  */
     }
 
   if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
@@ -921,201 +582,142 @@ or1k_register_reggroup_p (struct gdbarch  *gdbarch,
     /* For any that are not handled above.  */
     return default_register_reggroup_p (gdbarch, regnum, group);
 
-}	/* or1k_register_reggroup_p() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Is this one of the registers used for passing arguments?
-
-   These are r3-r8 in the API.
+}
 
-   @param[in] regnum  The register to consider
 
-   @return  Non-zero (TRUE) if it is an argument register, zero (FALSE)
-            otherwise.                                                        */
-/*----------------------------------------------------------------------------*/
 static int
-or1k_is_arg_reg (unsigned int  regnum)
+or1k_is_arg_reg (unsigned int regnum)
 {
-  return (OR1K_FIRST_ARG_REGNUM <= regnum) && (regnum <= OR1K_LAST_ARG_REGNUM);
+  return (OR1K_FIRST_ARG_REGNUM <= regnum)
+    && (regnum <= OR1K_LAST_ARG_REGNUM);
 
-}	/* or1k_is_arg_reg () */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Is this a callee saved register?
-
-   These are r10, r12, r14, r16, r18, r20, r22, r24, r26, r28 and r30 in the
-   API.
+}
 
-   @param[in] regnum  The register to consider
 
-   @return  Non-zero (TRUE) if it is a callee saved register, zero (FALSE)
-            otherwise.                                                        */
-/*----------------------------------------------------------------------------*/
 static int
-or1k_is_callee_saved_reg (unsigned int  regnum)
+or1k_is_callee_saved_reg (unsigned int regnum)
 {
   return (OR1K_FIRST_SAVED_REGNUM <= regnum) && (0 == regnum % 2);
 
-}	/* or1k_is_callee_saved_reg () */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Skip a function prolog
-
-   If the input address, PC, is in a function prologue, return the address of
-   the end of the prologue, otherwise return the input  address.
-
-   @see For details of the stack frame, see the function
-        or1k_frame_cache().
-
-   @note The old version of this function used to use skip_prologue_using_sal
-         to skip the prologue without checking if it had actually worked. It
-         doesn't for STABS, so we had better check for a valid result.
+}
 
-   This function reuses the helper functions from or1k_frame_cache() to
-   locate the various parts of the prolog, any or all of which may be missing.
 
-   @param[in] gdbarch  The GDB architecture being used
-   @param[in] pc       Current program counter
+/* Implement the skip_prologue gdbarch method.  */
 
-   @return  The address of the end of the prolog if the PC is in a function
-            prologue, otherwise the input  address.                           */
-/*----------------------------------------------------------------------------*/
 static CORE_ADDR
-or1k_skip_prologue (struct gdbarch *gdbarch,
-		    CORE_ADDR       pc)
+or1k_skip_prologue (struct gdbarch *gdbarch, CORE_ADDR pc)
 {
-  CORE_ADDR     start_pc;
-  CORE_ADDR     addr;
-  uint32_t      inst;
+  CORE_ADDR start_pc;
+  CORE_ADDR addr;
+  uint32_t inst;
 
-  unsigned int  ra, rb, rd;		/* For instruction analysis */
-  int           simm;
+  unsigned int ra, rb, rd; /* for instruction analysis */
+  int simm;
 
-  int           frame_size = 0;
+  int frame_size = 0;
 
   /* Try using SAL first if we have symbolic information available. This only
-     works for DWARF 2, not STABS. */
+     works for DWARF 2, not STABS.  */
+
   if (find_pc_partial_function (pc, NULL, &start_pc, NULL))
     {
-      CORE_ADDR  prologue_end = skip_prologue_using_sal( gdbarch, pc );
+      CORE_ADDR prologue_end = skip_prologue_using_sal (gdbarch, pc);
 
       if (0 != prologue_end)
-  	{
-	  struct symtab_and_line  prologue_sal = find_pc_line (start_pc, 0);
-	  struct compunit_symtab *compunit = SYMTAB_COMPUNIT(prologue_sal.symtab);
-	  const char *debug_format = COMPUNIT_DEBUGFORMAT(compunit);
+	{
+	  struct symtab_and_line prologue_sal = find_pc_line (start_pc, 0);
+	  struct compunit_symtab *compunit
+	    = SYMTAB_COMPUNIT (prologue_sal.symtab);
+	  const char *debug_format = COMPUNIT_DEBUGFORMAT (compunit);
 
-	  if ((NULL != debug_format) && (strlen ("dwarf") <= strlen (debug_format))
+	  if ((NULL != debug_format)
+	      && (strlen ("dwarf") <= strlen (debug_format))
 	      && (0 == strncasecmp ("dwarf", debug_format, strlen ("dwarf"))))
 	    {
-	      return  (prologue_end > pc) ? prologue_end : pc;
+	      return (prologue_end > pc) ? prologue_end : pc;
 	    }
-  	}
+	}
     }
 
   /* Look to see if we can find any of the standard prologue sequence. All
      quite difficult, since any or all of it may be missing. So this is just a
-     best guess! */
-  addr = pc;				/* Where we have got to */
+     best guess!  */
+
+  addr = pc; /* Where we have got to */
   inst = or1k_fetch_instruction (gdbarch, addr);
 
-  /* Look for the new stack pointer being set up. */
-  if (or1k_analyse_l_addi (inst, &rd, &ra, &simm) &&
-      (OR1K_SP_REGNUM == rd) && (OR1K_SP_REGNUM == ra) &&
-      (simm < 0) && (0 == (simm % 4)))
+  /* Look for the new stack pointer being set up.  */
+  if (or1k_analyse_l_addi (inst, &rd, &ra, &simm)
+      && (OR1K_SP_REGNUM == rd) && (OR1K_SP_REGNUM == ra)
+      && (simm < 0) && (0 == (simm % 4)))
     {
-      frame_size  = -simm;
-      addr       += OR1K_INSTLEN;
-      inst        = or1k_fetch_instruction (gdbarch, addr);
+      frame_size = -simm;
+      addr += OR1K_INSTLEN;
+      inst = or1k_fetch_instruction (gdbarch, addr);
     }
 
-  /* Look for the frame pointer being manipulated. */
-  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb) &&
-      (OR1K_SP_REGNUM == ra) && (OR1K_FP_REGNUM == rb) &&
-      (simm >= 0) && (0 == (simm % 4)))
+  /* Look for the frame pointer being manipulated.  */
+  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
+      && (OR1K_SP_REGNUM == ra) && (OR1K_FP_REGNUM == rb)
+      && (simm >= 0) && (0 == (simm % 4)))
     {
       addr += OR1K_INSTLEN;
-      inst  = or1k_fetch_instruction (gdbarch, addr);
+      inst = or1k_fetch_instruction (gdbarch, addr);
 
-      gdb_assert (or1k_analyse_l_addi (inst, &rd, &ra, &simm) &&
-		  (OR1K_FP_REGNUM == rd) && (OR1K_SP_REGNUM == ra) &&
-		  (simm == frame_size));
+      gdb_assert (or1k_analyse_l_addi (inst, &rd, &ra, &simm)
+		  && (OR1K_FP_REGNUM == rd) && (OR1K_SP_REGNUM == ra)
+		  && (simm == frame_size));
 
       addr += OR1K_INSTLEN;
-      inst  = or1k_fetch_instruction (gdbarch, addr);
+      inst = or1k_fetch_instruction (gdbarch, addr);
     }
 
-  /* Look for the link register being saved */
-  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb) &&
-      (OR1K_SP_REGNUM == ra) && (OR1K_LR_REGNUM == rb) &&
-      (simm >= 0) && (0 == (simm % 4)))
+  /* Look for the link register being saved.  */
+  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
+      && (OR1K_SP_REGNUM == ra) && (OR1K_LR_REGNUM == rb)
+      && (simm >= 0) && (0 == (simm % 4)))
     {
       addr += OR1K_INSTLEN;
-      inst  = or1k_fetch_instruction (gdbarch, addr);
+      inst = or1k_fetch_instruction (gdbarch, addr);
     }
 
   /* Look for arguments or callee-saved register being saved. The register
      must be one of the arguments (r3-r8) or the 10 callee saved registers
      (r10, r12, r14, r16, r18, r20, r22, r24, r26, r28, r30). The base
      register must be the FP (for the args) or the SP (for the callee_saved
-     registers). */
+     registers).  */
   while (1)
     {
-      if (or1k_analyse_l_sw (inst, &simm, &ra, &rb) &&
-	  (((OR1K_FP_REGNUM == ra) && or1k_is_arg_reg (rb)) ||
-	   ((OR1K_SP_REGNUM == ra) && or1k_is_callee_saved_reg (rb))) &&
-	  (0 == (simm % 4)))
+      if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
+	  && (((OR1K_FP_REGNUM == ra) && or1k_is_arg_reg (rb))
+	      || ((OR1K_SP_REGNUM == ra) && or1k_is_callee_saved_reg (rb)))
+	  && (0 == (simm % 4)))
 	{
 	  addr += OR1K_INSTLEN;
-	  inst  = or1k_fetch_instruction (gdbarch, addr);
+	  inst = or1k_fetch_instruction (gdbarch, addr);
 	}
       else
 	{
 	  /* Nothing else to look for. We have found the end of the prologue. */
-	  return  addr;
+	  return addr;
 	}
     }
-}	/* or1k_skip_prologue() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Align the stack frame
-
-   OpenRISC 1000 uses a falling stack frame, so this aligns down to the
-   nearest 8 bytes. Useful when we'be building a dummy frame.
+}
 
-   @param[in] gdbarch  The GDB architecture being used
-   @param[in] sp       Current stack pointer
 
-   @return  The aligned stack frame address */
-/*---------------------------------------------------------------------------*/
+/* Implement the frame_align gdbarch method.  */
 
 static CORE_ADDR
-or1k_frame_align (struct gdbarch *gdbarch,
-		  CORE_ADDR       sp)
+or1k_frame_align (struct gdbarch *gdbarch, CORE_ADDR sp)
 {
   return align_down (sp, OR1K_STACK_ALIGN);
 
-}	/* or1k_frame_align() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Unwind the program counter from a stack frame
-
-   This just uses the built in frame unwinder
-
-   @param[in] gdbarch     The GDB architecture being used
-   @param[in] next_frame  Frame info for the NEXT frame
+}
 
-   @return  The program counter for THIS frame */
-/*---------------------------------------------------------------------------*/
+/* Implement the unwind_pc gdbarch method.  */
 
 static CORE_ADDR
-or1k_unwind_pc (struct gdbarch    *gdbarch,
-		struct frame_info *next_frame)
+or1k_unwind_pc (struct gdbarch *gdbarch, struct frame_info *next_frame)
 {
   CORE_ADDR pc;
 
@@ -1129,28 +731,18 @@ or1k_unwind_pc (struct gdbarch    *gdbarch,
 
   if (frame_debug)
     {
-      fprintf_unfiltered (gdb_stdlog, "or1k_unwind_pc, pc=0x%p\n", (void *) pc);
+      fprintf_unfiltered (gdb_stdlog, "or1k_unwind_pc, pc=0x%p\n",
+			  (void *) pc);
     }
 
   return pc;
 
-}	/* or1k_unwind_pc() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Unwind the stack pointer from a stack frame
-
-   This just uses the built in frame unwinder
-
-   @param[in] gdbarch     The GDB architecture being used
-   @param[in] next_frame  Frame info for the NEXT frame
+}
 
-   @return  The stack pointer for THIS frame */
-/*---------------------------------------------------------------------------*/
+/* Implement the unwind_sp gdbarch method.  */
 
 static CORE_ADDR
-or1k_unwind_sp (struct gdbarch    *gdbarch,
-		struct frame_info *next_frame)
+or1k_unwind_sp (struct gdbarch *gdbarch, struct frame_info *next_frame)
 {
   CORE_ADDR sp;
 
@@ -1164,49 +756,27 @@ or1k_unwind_sp (struct gdbarch    *gdbarch,
 
   if (frame_debug)
     {
-      fprintf_unfiltered (gdb_stdlog, "or1k_unwind_sp, sp=0x%p\n", (void *) sp);
+      fprintf_unfiltered (gdb_stdlog, "or1k_unwind_sp, sp=0x%p\n",
+			  (void *) sp);
     }
 
   return sp;
 
-}	/* or1k_unwind_sp() */
-
-/*----------------------------------------------------------------------------*/
-/*!Provides return address for dummy call
-
-   Provides an address on the stack where to put a breakpoint as return
-   address for function. bp_addr is the address to which the function should
-   return (which is breakpointed, so gdb can regain control, hence the name).
-
-   @param[in] gdbarch        The architecture to use
-   @param[in] sp             The stack pointer
-   @param[in] function       Pointer to the function that will be called
-   @param[in] args           The arguments
-   @param[in] nargs          Number of ags to push
-   @param[in] value_type     Type of the function result
-   @param[in] real_pc        Resume address
-   @param[in] bp_addr        Breakpoint address
-   @param[in] regcache       The register cache to use
+}
 
-   @return  The breakpoint address */
-/*---------------------------------------------------------------------------*/
+/* Implement the push_dummy_code gdbarch method.  */
 
 static CORE_ADDR
-or1k_push_dummy_code (struct gdbarch *gdbarch,
-		      CORE_ADDR sp,
-		      CORE_ADDR function,
-		      struct value **args,
-		      int nargs,
-		      struct type *value_type,
-		      CORE_ADDR *real_pc,
-		      CORE_ADDR *bp_addr,
-		      struct regcache *regcache)
+or1k_push_dummy_code (struct gdbarch *gdbarch, CORE_ADDR sp,
+		      CORE_ADDR function, struct value **args, int nargs,
+		      struct type *value_type, CORE_ADDR * real_pc,
+		      CORE_ADDR * bp_addr, struct regcache *regcache)
 {
   CORE_ADDR bp_slot;
 
   /* Reserve enough room on the stack for our breakpoint instruction.  */
   bp_slot = sp - 4;
-  /* Store the address of that breakpoint */
+  /* Store the address of that breakpoint.  */
   *bp_addr = bp_slot;
   /* keeping the stack aligned.  */
   sp = or1k_frame_align (gdbarch, bp_slot);
@@ -1215,59 +785,36 @@ or1k_push_dummy_code (struct gdbarch *gdbarch,
 
   return sp;
 
-}	/* or1k_push_dummy_code() */
-
-/*----------------------------------------------------------------------------*/
-/*!Create a dummy stack frame
-
-   The arguments are placed in registers and/or pushed on the stack as per the
-   OR1K ABI.
-
-   @param[in] gdbarch        The architecture to use
-   @param[in] function       Pointer to the function that will be called
-   @param[in] regcache       The register cache to use
-   @param[in] bp_addr        Breakpoint address
-   @param[in] nargs          Number of ags to push
-   @param[in] args           The arguments
-   @param[in] sp             The stack pointer
-   @param[in] struct_return  True (1) if this returns a structure
-   @param[in] struct_addr    Address for returning structures
+}
 
-   @return  The updated stack pointer */
-/*---------------------------------------------------------------------------*/
+/* Implement the push_dummy_call gdbarch method.  */
 
 static CORE_ADDR
-or1k_push_dummy_call (struct gdbarch  *gdbarch,
-		      struct value    *function,
-		      struct regcache *regcache,
-		      CORE_ADDR        bp_addr,
-		      int              nargs,
-		      struct value   **args,
-		      CORE_ADDR        sp,
-		      int              struct_return,
-		      CORE_ADDR        struct_addr)
+or1k_push_dummy_call (struct gdbarch *gdbarch, struct value *function,
+		      struct regcache *regcache, CORE_ADDR bp_addr,
+		      int nargs, struct value **args, CORE_ADDR sp,
+		      int struct_return, CORE_ADDR struct_addr)
 {
-  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
-
-  int             argreg;
-  int             argnum;
-  int             first_stack_arg;
-  int             stack_offset = 0;
-  int             heap_offset = 0;
-  CORE_ADDR       heap_sp = sp - 128;
 
-  unsigned int    bpa = (gdbarch_tdep (gdbarch))->bytes_per_address;
-  unsigned int    bpw = (gdbarch_tdep (gdbarch))->bytes_per_word;
+  int argreg;
+  int argnum;
+  int first_stack_arg;
+  int stack_offset = 0;
+  int heap_offset = 0;
+  CORE_ADDR heap_sp = sp - 128;
+  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
+  unsigned int bpa = (gdbarch_tdep (gdbarch))->bytes_per_address;
+  unsigned int bpw = (gdbarch_tdep (gdbarch))->bytes_per_word;
   struct type *func_type = value_type (function);
 
   /* Return address */
   regcache_cooked_write_unsigned (regcache, OR1K_LR_REGNUM, bp_addr);
 
-  /* Register for the next argument */
+  /* Register for the next argument.  */
   argreg = OR1K_FIRST_ARG_REGNUM;
 
   /* Location for a returned structure. This is passed as a silent first
-     argument. */
+     argument.  */
   if (struct_return)
     {
       regcache_cooked_write_unsigned (regcache, OR1K_FIRST_ARG_REGNUM,
@@ -1279,38 +826,40 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
   for (argnum = 0; argnum < nargs; argnum++)
     {
       const gdb_byte *val;
-      gdb_byte        valbuf[sizeof (ULONGEST)];
+      gdb_byte valbuf[sizeof (ULONGEST)];
 
-      struct value   *arg      = args[argnum];
-      struct type    *arg_type = check_typedef (value_type (arg));
-      int             len      = arg_type->length;
-      enum type_code  typecode = arg_type->main_type->code;
+      struct value *arg = args[argnum];
+      struct type *arg_type = check_typedef (value_type (arg));
+      int len = arg_type->length;
+      enum type_code typecode = arg_type->main_type->code;
 
-      if (TYPE_VARARGS (func_type) && argnum >= TYPE_NFIELDS(func_type))
-        {
-          break; /* end or regular args, varargs go to stack */
-        }
+      if (TYPE_VARARGS (func_type) && argnum >= TYPE_NFIELDS (func_type))
+	{
+	  break; /* end or regular args, varargs go to stack */
+	}
 
       /* Extract the value, either a reference or the data */
-      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode) || (len > bpw*2))
+      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode)
+	  || (len > bpw * 2))
 	{
-          CORE_ADDR valaddr = value_address (arg);
+	  CORE_ADDR valaddr = value_address (arg);
 
-          /* if the arg is fabricated (i.e. 3*i, instead of i) valaddr is undefined */
-          if (valaddr == 0) {
-              /* The argument needs to be copied into the target space. Since
-                 the bottom of the stack is reserved for function arguments
-                 we store this at the these at the top growing down. */
-              heap_offset += align_up (len, bpw);
-              valaddr = heap_sp + heap_offset;
+	  /* if the arg is fabricated (i.e. 3*i, instead of i) valaddr is undefined */
+	  if (valaddr == 0)
+	    {
+	      /* The argument needs to be copied into the target space. Since
+	         the bottom of the stack is reserved for function arguments
+	         we store this at the these at the top growing down.  */
+	      heap_offset += align_up (len, bpw);
+	      valaddr = heap_sp + heap_offset;
 
-              write_memory (valaddr, value_contents(arg), len);
-          }
+	      write_memory (valaddr, value_contents (arg), len);
+	    }
 
-          /* The ABI passes all structures by reference, so get its address. */
-          store_unsigned_integer (valbuf, bpa, byte_order, valaddr);
-          len      = bpa;
-          val      = valbuf;
+	  /* The ABI passes all structures by reference, so get its address.  */
+	  store_unsigned_integer (valbuf, bpa, byte_order, valaddr);
+	  len = bpa;
+	  val = valbuf;
 	}
       else
 	{
@@ -1319,20 +868,20 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	}
 
       /* Stick the value in a register */
-      if(len > bpw)
+      if (len > bpw)
 	{
-	  /* Big scalars use two registers, but need NOT be pair aligned. */
+	  /* Big scalars use two registers, but need NOT be pair aligned.  */
 
 	  if (argreg <= (OR1K_LAST_ARG_REGNUM - 1))
 	    {
-	      ULONGEST regval = extract_unsigned_integer (val, len, byte_order);
+	      ULONGEST regval =	extract_unsigned_integer (val, len, byte_order);
 
-	      unsigned int  bits_per_word = bpw * 8;
-	      ULONGEST      mask = (((ULONGEST) 1) << bits_per_word) - 1;
-	      ULONGEST      lo   = regval & mask;
-	      ULONGEST      hi   = regval >> bits_per_word;
+	      unsigned int bits_per_word = bpw * 8;
+	      ULONGEST mask = (((ULONGEST) 1) << bits_per_word) - 1;
+	      ULONGEST lo = regval & mask;
+	      ULONGEST hi = regval >> bits_per_word;
 
-	      regcache_cooked_write_unsigned (regcache, argreg,     hi);
+	      regcache_cooked_write_unsigned (regcache, argreg, hi);
 	      regcache_cooked_write_unsigned (regcache, argreg + 1, lo);
 	      argreg += 2;
 	    }
@@ -1347,7 +896,7 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	  /* Smaller scalars fit in a single register */
 	  regcache_cooked_write_unsigned (regcache, argreg,
 					  extract_unsigned_integer (val, len,
-								   byte_order));
+								    byte_order));
 	  argreg++;
 	}
       else
@@ -1363,52 +912,55 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
      the stack. This is tricky, since they must be pushed in reverse order and
      the stack in the end must be aligned. The only solution is to do it in
      two stages, the first to compute the stack size, the second to save the
-     args. */
+     args.  */
 
   for (argnum = first_stack_arg; argnum < nargs; argnum++)
     {
-      struct value   *arg      = args[argnum];
-      struct type    *arg_type = check_typedef (value_type (arg));
-      int             len      = arg_type->length;
-      enum type_code  typecode = arg_type->main_type->code;
+      struct value *arg = args[argnum];
+      struct type *arg_type = check_typedef (value_type (arg));
+      int len = arg_type->length;
+      enum type_code typecode = arg_type->main_type->code;
 
-      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode) || (len > bpw*2))
+      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode)
+	  || (len > bpw * 2))
 	{
 	  /* Structures are passed as addresses */
 	  sp -= bpa;
 	}
       else
 	{
-	/* Big scalars use more than one word. Code here allows for future
-	 quad-word entities (e.g. long double) */
-	  sp -= align_up(len, bpw);
+	  /* Big scalars use more than one word. Code here allows for future
+	     quad-word entities (e.g. long double) */
+	  sp -= align_up (len, bpw);
 	}
 
       /* ensure our dummy heap doesn't touch the stack, this could only happen
          if we have many arguments including fabricated arguments */
-      gdb_assert(heap_offset == 0 || ((heap_sp + heap_offset) < sp));
+      gdb_assert (heap_offset == 0 || ((heap_sp + heap_offset) < sp));
     }
 
-  sp           = gdbarch_frame_align (gdbarch, sp);
+  sp = gdbarch_frame_align (gdbarch, sp);
   stack_offset = 0;
 
   /* Push the remaining args on the stack */
   for (argnum = first_stack_arg; argnum < nargs; argnum++)
     {
       const gdb_byte *val;
-      gdb_byte        valbuf[sizeof (ULONGEST) ];
+      gdb_byte valbuf[sizeof (ULONGEST)];
 
-      struct value   *arg      = args[argnum];
-      struct type    *arg_type = check_typedef (value_type (arg));
-      int             len      = arg_type->length;
-      enum type_code  typecode = arg_type->main_type->code;
+      struct value *arg = args[argnum];
+      struct type *arg_type = check_typedef (value_type (arg));
+      int len = arg_type->length;
+      enum type_code typecode = arg_type->main_type->code;
       /* The EABI passes structures that do not fit in a register by
-	 reference. In all other cases, pass the structure by value.  */
-      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode) || (len > bpw*2))
+         reference. In all other cases, pass the structure by value.  */
+      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode)
+	  || (len > bpw * 2))
 	{
-	  store_unsigned_integer (valbuf, bpa, byte_order, value_address (arg));
-	  len      = bpa;
-	  val      = valbuf;
+	  store_unsigned_integer (valbuf, bpa, byte_order,
+				  value_address (arg));
+	  len = bpa;
+	  val = valbuf;
 	}
       else
 	{
@@ -1416,61 +968,45 @@ or1k_push_dummy_call (struct gdbarch  *gdbarch,
 	}
 
       while (len > 0)
-        {
-          int partial_len = (len < bpw ? len : bpw);
+	{
+	  int partial_len = (len < bpw ? len : bpw);
 
-          write_memory (sp + stack_offset, val, partial_len);
-          stack_offset += align_up (partial_len, bpw);
-          len -= partial_len;
-          val += partial_len;
-        }
+	  write_memory (sp + stack_offset, val, partial_len);
+	  stack_offset += align_up (partial_len, bpw);
+	  len -= partial_len;
+	  val += partial_len;
+	}
     }
 
   /* Save the updated stack pointer */
   regcache_cooked_write_unsigned (regcache, OR1K_SP_REGNUM, sp);
 
-  if (heap_offset > 0) {
-    sp = heap_sp;
-  }
+  if (heap_offset > 0)
+    {
+      sp = heap_sp;
+    }
 
   return sp;
 
-}	/* or1k_push_dummy_call() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Return the frame ID for a dummy stack frame
-
-   Tear down a dummy frame created by or1k_push_dummy_call(). This data has to
-   be constructed manually from the data in our hand.
-
-   The stack pointer and program counter can be obtained from the frame info.
+}
 
-   @param[in] gdbarch     The architecture to use
-   @param[in] this_frame  Information about this frame
 
-   @return  Frame ID of this frame */
-/*---------------------------------------------------------------------------*/
+/* Implement the dummy_id gdbarch method.  */
 
 static struct frame_id
-or1k_dummy_id (struct gdbarch    *gdbarch,
-	       struct frame_info *this_frame)
+or1k_dummy_id (struct gdbarch *gdbarch, struct frame_info *this_frame)
 {
-  return  frame_id_build (get_frame_sp (this_frame), get_frame_pc (this_frame));
+  return frame_id_build (get_frame_sp (this_frame),
+			 get_frame_pc (this_frame));
 
-}	/* or1k_dummy_id() */
+}
+
 
 
-
 
 /* Support functions for frame handling */
 
-/* -------------------------------------------------------------------------- */
-/*!Initialize a prologue cache
-
-   This function is changed from its GDB 6.8 version (named
-   or1k_frame_unwind_cache), in that it is based on THIS frame, not the NEXT
-   frame.
+/* Initialize a prologue cache
 
    We build a cache, saying where registers of the PREV frame can be found
    from the data so far set up in this THIS.
@@ -1486,32 +1022,24 @@ or1k_dummy_id (struct gdbarch    *gdbarch,
    is R1 and the frame pointer R2. The frame base is therefore the address
    held in R2 and the stack pointer (R1) is the frame base of the NEXT frame.
 
-   @verbatim
    l.addi  r1,r1,-frame_size	# SP now points to end of new stack frame
-   @endverbatim
 
    The stack pointer may not be set up in a frameless function (e.g. a simple
    leaf function).
 
-   @verbatim
    l.sw    fp_loc(r1),r2        # old FP saved in new stack frame
    l.addi  r2,r1,frame_size     # FP now points to base of new stack frame
-   @endverbatim
 
    The frame pointer is not necessarily saved right at the end of the stack
    frame - OR1K saves enough space for any args to called functions right at
    the end (this is a difference from the Architecture Manual).
 
-   @verbatim
    l.sw    lr_loc(r1),r9        # Link (return) address
-   @endverbatim
 
    The link register is usally saved at fp_loc - 4. It may not be saved at all
    in a leaf function.
 
-   @verbatim
    l.sw    reg_loc(r1),ry       # Save any callee saved regs
-   @endverbatim
 
    The offsets x for the callee saved registers generally (always?) rise in
    increments of 4, starting at fp_loc + 4. If the frame pointer is omitted
@@ -1540,28 +1068,21 @@ or1k_dummy_id (struct gdbarch    *gdbarch,
    A suite of "helper" routines are used, allowing reuse for
    or1k_skip_prologue().
 
-   Reportedly, this is only valid for frames less than 0x7fff in size.
-
-   @param[in]     this_frame      Our stack frame.
-   @param[in,out] prologue_cache  The prologue cache. If not supplied, we
-                                  build it.
+   Reportedly, this is only valid for frames less than 0x7fff in size.  */
 
-   @return  The prolog cache (duplicates the return through the argument) */
-/* ---------------------------------------------------------------------------*/
 static struct trad_frame_cache *
-or1k_frame_cache (struct frame_info  *this_frame,
-		  void              **prologue_cache)
+or1k_frame_cache (struct frame_info *this_frame, void **prologue_cache)
 {
-  struct gdbarch          *gdbarch;
+  struct gdbarch *gdbarch;
   struct trad_frame_cache *info;
 
-  CORE_ADDR                this_pc;
-  CORE_ADDR                this_sp;
-  CORE_ADDR                this_sp_for_id;
-  int                      frame_size = 0;
+  CORE_ADDR this_pc;
+  CORE_ADDR this_sp;
+  CORE_ADDR this_sp_for_id;
+  int frame_size = 0;
 
-  CORE_ADDR                start_addr;
-  CORE_ADDR                end_addr;
+  CORE_ADDR start_addr;
+  CORE_ADDR end_addr;
 
   if (frame_debug)
     {
@@ -1570,14 +1091,14 @@ or1k_frame_cache (struct frame_info  *this_frame,
 			  *prologue_cache);
     }
 
-  /* Nothing to do if we already have this info */
+  /* Nothing to do if we already have this info.  */
   if (NULL != *prologue_cache)
     {
       return (struct trad_frame_cache *) *prologue_cache;
     }
 
-  /* Get a new prologue cache and populate it with default values */
-  info            = trad_frame_cache_zalloc (this_frame);
+  /* Get a new prologue cache and populate it with default values.  */
+  info = trad_frame_cache_zalloc (this_frame);
   *prologue_cache = info;
 
   /* Find the start address of THIS function (which is a NORMAL frame, even if
@@ -1586,10 +1107,9 @@ or1k_frame_cache (struct frame_info  *this_frame,
   find_pc_partial_function (this_pc, NULL, &start_addr, NULL);
 
   /* Get the stack pointer if we have one (if there's no process executing yet
-     we won't have a frame. */
+     we won't have a frame.  */
   this_sp = (NULL == this_frame) ? 0 :
-                                   get_frame_register_unsigned (this_frame,
-								OR1K_SP_REGNUM);
+    get_frame_register_unsigned (this_frame, OR1K_SP_REGNUM);
 
   /* Return early if GDB couldn't find the function.  */
   if (start_addr == 0)
@@ -1600,10 +1120,10 @@ or1k_frame_cache (struct frame_info  *this_frame,
 	}
 
       /* JPB: 28-Apr-11. This is a temporary patch, to get round GDB crashing
-	 right at the beginning. Build the frame ID as best we can. */
+         right at the beginning. Build the frame ID as best we can. */
       trad_frame_set_id (info, frame_id_build (this_sp, this_pc));
 
-      return  info;
+      return info;
     }
 
 
@@ -1633,7 +1153,7 @@ or1k_frame_cache (struct frame_info  *this_frame,
   if (end_addr < start_addr)
     {
       throw_quit ("end addr 0x%08x is less than start addr 0x%08x\n",
-	     (unsigned int) end_addr, (unsigned int) start_addr);
+		  (unsigned int) end_addr, (unsigned int) start_addr);
     }
 
   if (end_addr == start_addr)
@@ -1643,20 +1163,20 @@ or1k_frame_cache (struct frame_info  *this_frame,
   else
     {
       /* have a frame. Look for the various components */
-      CORE_ADDR  addr = start_addr;	/* Where we have got to */
-      uint32_t   inst = or1k_fetch_instruction (gdbarch, addr);
+      CORE_ADDR addr = start_addr;	/* Where we have got to */
+      uint32_t inst = or1k_fetch_instruction (gdbarch, addr);
 
-      unsigned int  ra, rb, rd;		/* For instruction analysis */
-      int           simm;
+      unsigned int ra, rb, rd;	/* For instruction analysis */
+      int simm;
 
       /* Look for the new stack pointer being set up. */
-      if (or1k_analyse_l_addi (inst, &rd, &ra, &simm) &&
-	  (OR1K_SP_REGNUM == rd) && (OR1K_SP_REGNUM == ra) &&
-	  (simm < 0) && (0 == (simm % 4)))
+      if (or1k_analyse_l_addi (inst, &rd, &ra, &simm)
+	  && (OR1K_SP_REGNUM == rd) && (OR1K_SP_REGNUM == ra)
+	  && (simm < 0) && (0 == (simm % 4)))
 	{
-	  frame_size  = -simm;
-	  addr       += OR1K_INSTLEN;
-	  inst        = or1k_fetch_instruction (gdbarch, addr);
+	  frame_size = -simm;
+	  addr += OR1K_INSTLEN;
+	  inst = or1k_fetch_instruction (gdbarch, addr);
 
 	  /* If the PC has not actually got to this point, then the frame base
 	     will be wrong, and we adjust it.
@@ -1675,25 +1195,25 @@ or1k_frame_cache (struct frame_info  *this_frame,
 	  else
 	    {
 	      /* We are past this point, so the stack pointer of the PREV
-		 frame is frame_size greater than the stack pointer of THIS
-		 frame. */
+	         frame is frame_size greater than the stack pointer of THIS
+	         frame. */
 	      trad_frame_set_reg_value (info, OR1K_SP_REGNUM,
 					this_sp + frame_size);
 	    }
 	}
 
       /* From now on we are only populating the cache, so we stop once we get
-	 to either the end OR the current PC. */
+         to either the end OR the current PC. */
       end_addr = (this_pc < end_addr) ? this_pc : end_addr;
 
       /* Look for the frame pointer being manipulated. */
-      if ((addr < end_addr) &&
-	  or1k_analyse_l_sw (inst, &simm, &ra, &rb) &&
-	  (OR1K_SP_REGNUM == ra) && (OR1K_FP_REGNUM == rb) &&
-	  (simm >= 0) && (0 == (simm % 4)))
+      if ((addr < end_addr)
+	  && or1k_analyse_l_sw (inst, &simm, &ra, &rb)
+	  && (OR1K_SP_REGNUM == ra) && (OR1K_FP_REGNUM == rb)
+	  && (simm >= 0) && (0 == (simm % 4)))
 	{
 	  addr += OR1K_INSTLEN;
-	  inst  = or1k_fetch_instruction (gdbarch, addr);
+	  inst = or1k_fetch_instruction (gdbarch, addr);
 
 	  /* At this stage, we can find the frame pointer of the PREVIOUS
 	     frame on the stack of the current frame. */
@@ -1702,57 +1222,58 @@ or1k_frame_cache (struct frame_info  *this_frame,
 	  /* Look for the new frame pointer being set up */
 	  if (addr < end_addr)
 	    {
-	      gdb_assert (or1k_analyse_l_addi (inst, &rd, &ra, &simm) &&
-			  (OR1K_FP_REGNUM == rd) && (OR1K_SP_REGNUM == ra) &&
-			  (simm == frame_size));
+	      gdb_assert (or1k_analyse_l_addi (inst, &rd, &ra, &simm)
+			  && (OR1K_FP_REGNUM == rd) && (OR1K_SP_REGNUM == ra)
+			  && (simm == frame_size));
 
 	      addr += OR1K_INSTLEN;
-	      inst  = or1k_fetch_instruction (gdbarch, addr);
+	      inst = or1k_fetch_instruction (gdbarch, addr);
 
 	      /* If we have got this far, the stack pointer of the PREVIOUS
-		 frame is the frame pointer of THIS frame. */
-	      trad_frame_set_reg_realreg (info, OR1K_SP_REGNUM, OR1K_FP_REGNUM);
+	         frame is the frame pointer of THIS frame. */
+	      trad_frame_set_reg_realreg (info, OR1K_SP_REGNUM,
+					  OR1K_FP_REGNUM);
 	    }
 	}
 
       /* Look for the link register being saved */
-      if ((addr < end_addr) &&
-	  or1k_analyse_l_sw (inst, &simm, &ra, &rb) &&
-	  (OR1K_SP_REGNUM == ra) && (OR1K_LR_REGNUM == rb) &&
-	  (simm >= 0) && (0 == (simm % 4)))
+      if ((addr < end_addr)
+	  && or1k_analyse_l_sw (inst, &simm, &ra, &rb)
+	  && (OR1K_SP_REGNUM == ra) && (OR1K_LR_REGNUM == rb)
+	  && (simm >= 0) && (0 == (simm % 4)))
 	{
 	  addr += OR1K_INSTLEN;
-	  inst  = or1k_fetch_instruction (gdbarch, addr);
+	  inst = or1k_fetch_instruction (gdbarch, addr);
 
 	  /* If the link register is saved in the THIS frame, it holds the
 	     value of the PC in the PREVIOUS frame. This overwrites the
 	     previous information about finding the PC in the link
-	     register. */
+	     register.  */
 	  trad_frame_set_reg_addr (info, OR1K_NPC_REGNUM, this_sp + simm);
 	}
 
       /* Look for arguments or callee-saved register being saved. The register
-	 must be one of the arguments (r3-r8) or the 10 callee saved registers
-	 (r10, r12, r14, r16, r18, r20, r22, r24, r26, r28, r30). The base
-	 register must be the FP (for the args) or the SP (for the
-	 callee_saved registers). */
+         must be one of the arguments (r3-r8) or the 10 callee saved registers
+         (r10, r12, r14, r16, r18, r20, r22, r24, r26, r28, r30). The base
+         register must be the FP (for the args) or the SP (for the
+         callee_saved registers).  */
       while (addr < end_addr)
 	{
-	  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb) &&
-	      (((OR1K_FP_REGNUM == ra) && or1k_is_arg_reg (rb)) ||
-	       ((OR1K_SP_REGNUM == ra) && or1k_is_callee_saved_reg (rb))) &&
-	      (0 == (simm % 4)))
+	  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
+	      && (((OR1K_FP_REGNUM == ra) && or1k_is_arg_reg (rb))
+		  || ((OR1K_SP_REGNUM == ra)
+		      && or1k_is_callee_saved_reg (rb))) && (0 == (simm % 4)))
 	    {
 	      addr += OR1K_INSTLEN;
-	      inst  = or1k_fetch_instruction (gdbarch, addr);
+	      inst = or1k_fetch_instruction (gdbarch, addr);
 
 	      /* The register in the PREVIOUS frame can be found@this
-		 location in THIS frame */
+	         location in THIS frame */
 	      trad_frame_set_reg_addr (info, rb, this_sp + simm);
 	    }
 	  else
 	    {
-	      break;			/* Not a register save instruction */
+	      break;		/* Not a register save instruction */
 	    }
 	}
     }
@@ -1770,163 +1291,53 @@ or1k_frame_cache (struct frame_info  *this_frame,
 
   return info;
 
-}	/* or1k_frame_cache() */
-
-
-/* -------------------------------------------------------------------------- */
-/*!Find the frame ID of this frame
-
-   This function has changed since GDB 6.8 to use THIS frame, rather than the
-   NEXT frame.
+}
 
-   Given a GDB frame, return its frame_id.
 
-   @param[in]  this_frame      Our frame, for which the ID is wanted.
-   @param[in]  prologue_cache  Any cached prologue for THIS function.
-   @param[out] this_id         Frame ID of our own frame.
+/* Implement the this_id function for the stub unwinder.  */
 
-   @return  Frame ID for THIS frame */
-/* ------------------------------------------------------------------------- */
 static void
-or1k_frame_this_id (struct frame_info  *this_frame,
-		    void              **prologue_cache,
-		    struct frame_id    *this_id)
+or1k_frame_this_id (struct frame_info *this_frame,
+		    void **prologue_cache, struct frame_id *this_id)
 {
-  struct trad_frame_cache *info =
-    or1k_frame_cache (this_frame, prologue_cache);
+  struct trad_frame_cache *info = or1k_frame_cache (this_frame,
+						    prologue_cache);
 
   trad_frame_get_id (info, this_id);
 
-}	/* or1k_frame_this_id() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Get a register from the PREVIOUS frame
-
-   This function has changed from GDB 6.8. It now takes a reference to THIS
-   frame, not the NEXT frame. It returns it results via a structure, not its
-   argument list.
+}
 
-   Given a pointer to the THIS frame, return the details of a register in the
-   PREVIOUS frame.
 
-   @param[in] this_frame      The stack frame under consideration
-   @param[in] prologue_cache  Any cached prologue associated with THIS frame,
-                              which may therefore tell us about registers in
-                              the PREVIOUS frame.
-   @param[in] regnum          The register of interest in the PREVIOUS frame
+/* Implement the prev_register function for the stub unwinder.  */
 
-   @return  A value structure representing the register.                      */
-/* -------------------------------------------------------------------------- */
 static struct value *
-or1k_frame_prev_register (struct frame_info  *this_frame,
-			  void              **prologue_cache,
-			  int                 regnum)
+or1k_frame_prev_register (struct frame_info *this_frame,
+			  void **prologue_cache, int regnum)
 {
   struct trad_frame_cache *info = or1k_frame_cache (this_frame,
 						    prologue_cache);
 
-  return  trad_frame_get_register (info, this_frame, regnum);
-
-}	/* or1k_frame_prev_register() */
-
+  return trad_frame_get_register (info, this_frame, regnum);
 
-/* -------------------------------------------------------------------------- */
-/*!Structure defining the OR1K frame unwind functions
-
-   Must be global (to this file), since referred to by multiple functions.
-
-   Since we are the fallback unwinder, we use the default frame sniffer, which
-   always accepts the frame
+}
 
-   This applies to NORMAL frames only. We provide the following functions.
-   - to give the ID of THIS frame
-   - to give the details of a register in PREVIOUS frame
-   - a frame sniffer.                                                         */
-/* -------------------------------------------------------------------------- */
+/* Data structures for the normal prologue-analysis-based
+   unwinder.  */
+ 
 static const struct frame_unwind or1k_frame_unwind = {
-  .type          = NORMAL_FRAME,
-  .stop_reason   = default_frame_unwind_stop_reason,
-  .this_id       = or1k_frame_this_id,
+  .type = NORMAL_FRAME,
+  .stop_reason = default_frame_unwind_stop_reason,
+  .this_id = or1k_frame_this_id,
   .prev_register = or1k_frame_prev_register,
-  .unwind_data   = NULL,
-  .sniffer       = default_frame_sniffer,
+  .unwind_data = NULL,
+  .sniffer = default_frame_sniffer,
   .dealloc_cache = NULL,
-  .prev_arch     = NULL
+  .prev_arch = NULL
 };
 
 
-#if 0
-/*----------------------------------------------------------------------------*/
-/*!Return the base address of the frame
-
-   The implementations has changed since GDB 6.8, since we are now provided
-   with the address of THIS frame, rather than the NEXT frame.
-
-   For the OR1K, the base address is the frame pointer
-
-   @param[in] this_frame      The current stack frame.
-   @param[in] prologue_cache  Any cached prologue for THIS function.
-
-   @return  The frame base address */
-/*---------------------------------------------------------------------------*/
-
-static CORE_ADDR
-or1k_frame_base_address (struct frame_info  *this_frame,
-			 void              **prologue_cache)
-{
-  return  (CORE_ADDR) get_frame_register_unsigned (this_frame, OR1K_FP_REGNUM);
+/* Create a register group based on a group name.  */
 
-}	/* or1k_frame_base_address() */
-
-
-/* -------------------------------------------------------------------------- */
-/*!Identify our frame base sniffer functions
-
-   This function just identifies our family of frame sniffing functions.
-
-   @param[in] this_frame  The frame of THIS function. Not used here.
-
-   @return  A pointer to a struct identifying the frame base sniffing
-            functions.                                                        */
-/* -------------------------------------------------------------------------- */
-static const struct frame_base *
-or1k_frame_base_sniffer (struct frame_info *this_frame)
-{
-  /* Structure defining how the frame base is to be identified. */
-  static const struct frame_base  or1k_frame_base =
-    {
-      .unwind      = &or1k_frame_unwind,
-      .this_base   = or1k_frame_base_address,
-      .this_locals = or1k_frame_base_address,
-      .this_args   = or1k_frame_base_address
-    };
-
-  return &or1k_frame_base;
-
-}	/* or1k_frame_base_sniffer () */
-#endif
-
-/* Iterate over core file register note sections.  */
-static void
-or1k_iterate_over_regset_sections (struct gdbarch *gdbarch,
-				   iterate_over_regset_sections_cb *cb,
-                                   void *cb_data,
-                                   const struct regcache *regcache)
-{
-  // TODO: Do we need to put something here? (wallento)
-}
-
-/* -------------------------------------------------------------------------- */
-/*!Create a register group based on a group name.
-
-   We create a group only if group_name is not already a register group name.
-
-   @param[in] gdbarch     The GDB architecture we are using.
-   @param[in] group_name  Name of the new register group.
-
-   @return  1 if the group has been created, 0 otherwise. */
-/* -------------------------------------------------------------------------- */
 static int
 create_register_group (struct gdbarch *gdbarch, const char *group_name)
 {
@@ -1948,18 +1359,17 @@ create_register_group (struct gdbarch *gdbarch, const char *group_name)
 
       if (!group_exist)
 	{
-	  /* If the group doesn't exist, create it */
+	  /* If the group doesn't exist, create it.  */
 	  reggroup_add (gdbarch, reggroup_new (group_name, USER_REGGROUP));
 	  return 1;
 	}
     }
   else
     {
-      /* reggroup_next cannot be called during architecture. However,
-       * a first call to reggroup_add execute reggroups_init and then
-       * reggroup_next can be use. We assume the first group name we
-       * create does not exist.
-       */
+      /* The function reggroup_next cannot be called during architecture init.
+         However, a first call to reggroup_add execute reggroups_init and then
+         reggroup_next can be use. We assume the first group name we create
+         does not exist.  */
       reggroup_add (gdbarch, reggroup_new (group_name, USER_REGGROUP));
       first = 0;
     }
@@ -1967,19 +1377,9 @@ create_register_group (struct gdbarch *gdbarch, const char *group_name)
   return 0;
 }
 
-/* -------------------------------------------------------------------------- */
-/*!Register all reg found in a feature section.
-
-   Register all reg found in a feature section and create a group for each
-   new register group name found in the tdesc file.
+/* Register all reg found in a feature section and create a group for each
+   new register group name found in the tdesc file.  */
 
-   @param[in]  feature    The feature to search for registers.
-   @param[out] tdesc_data The target descriptor data to fill.
-   @param[out] reg_index  Register index in tdesc_data.
-   @param[in]  gdbarch    The GDB architecture we are using.
-
-   @return  Number of registers found, -1 if error.                           */
-/* -------------------------------------------------------------------------- */
 static int
 get_feature_registers (const struct tdesc_feature *feature,
 		       struct tdesc_arch_data *tdesc_data, int *reg_index,
@@ -1987,8 +1387,8 @@ get_feature_registers (const struct tdesc_feature *feature,
 {
   int valid_p;
   int i;
-  char *name;
-  char *group_name;
+  const char *name;
+  const char *group_name;
 
   if (feature)
     {
@@ -2027,26 +1427,16 @@ get_feature_registers (const struct tdesc_feature *feature,
   return 0;
 }
 
-/* -------------------------------------------------------------------------- */
-/*!Architecture initialization for OpenRISC 1000
-
-   Looks for a candidate architecture in the list of architectures supplied
-   using the info supplied. If none match, create a new architecture.
+/* Architecture initialization for OpenRISC 1000.  */
 
-   @param[in] info    Information about the target architecture
-   @param[in] arches  The list of currently know architectures
-
-   @return  A structure describing the target architecture                    */
-/* -------------------------------------------------------------------------- */
 static struct gdbarch *
-or1k_gdbarch_init (struct gdbarch_info  info,
-		   struct gdbarch_list *arches)
+or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
 {
-  static struct frame_base     or1k_frame_base;
-  struct        gdbarch       *gdbarch;
-  struct        gdbarch_tdep  *tdep;
-  const struct  bfd_arch_info *binfo;
-  struct tdesc_arch_data      *tdesc_data = NULL;
+  static struct frame_base or1k_frame_base;
+  struct gdbarch *gdbarch;
+  struct gdbarch_tdep *tdep;
+  const struct bfd_arch_info *binfo;
+  struct tdesc_arch_data *tdesc_data = NULL;
 
   int i;
   int reg_index = 0;
@@ -2064,82 +1454,69 @@ or1k_gdbarch_init (struct gdbarch_info  info,
      provided. Can't initialize all the target dependencies until we actually
      know which target we are talking to, but put in some defaults for now. */
 
-  binfo                   = info.bfd_arch_info;
-  tdep                    = XNEW (struct gdbarch_tdep);
-  tdep->num_matchpoints   = OR1K_MAX_MATCHPOINTS;
-  tdep->num_gpr_regs      = OR1K_MAX_GPR_REGS;
-  tdep->bytes_per_word    = binfo->bits_per_word    / binfo->bits_per_byte;
+  binfo = info.bfd_arch_info;
+  tdep = XNEW (struct gdbarch_tdep);
+  tdep->bytes_per_word = binfo->bits_per_word / binfo->bits_per_byte;
   tdep->bytes_per_address = binfo->bits_per_address / binfo->bits_per_byte;
-  gdbarch                 = gdbarch_alloc (&info, tdep);
+  gdbarch = gdbarch_alloc (&info, tdep);
 
   /* Target data types.  */
-  set_gdbarch_short_bit             (gdbarch, 16);
-  set_gdbarch_int_bit               (gdbarch, 32);
-  set_gdbarch_long_bit              (gdbarch, 32);
-  set_gdbarch_long_long_bit         (gdbarch, 64);
-  set_gdbarch_float_bit             (gdbarch, 32);
-  set_gdbarch_float_format          (gdbarch, floatformats_ieee_single);
-  set_gdbarch_double_bit            (gdbarch, 64);
-  set_gdbarch_double_format         (gdbarch, floatformats_ieee_double);
-  set_gdbarch_long_double_bit       (gdbarch, 64);
-  set_gdbarch_long_double_format    (gdbarch, floatformats_ieee_double);
-  set_gdbarch_ptr_bit               (gdbarch, binfo->bits_per_address);
-  set_gdbarch_addr_bit              (gdbarch, binfo->bits_per_address);
-  set_gdbarch_char_signed           (gdbarch, 1);
+  set_gdbarch_short_bit (gdbarch, 16);
+  set_gdbarch_int_bit (gdbarch, 32);
+  set_gdbarch_long_bit (gdbarch, 32);
+  set_gdbarch_long_long_bit (gdbarch, 64);
+  set_gdbarch_float_bit (gdbarch, 32);
+  set_gdbarch_float_format (gdbarch, floatformats_ieee_single);
+  set_gdbarch_double_bit (gdbarch, 64);
+  set_gdbarch_double_format (gdbarch, floatformats_ieee_double);
+  set_gdbarch_long_double_bit (gdbarch, 64);
+  set_gdbarch_long_double_format (gdbarch, floatformats_ieee_double);
+  set_gdbarch_ptr_bit (gdbarch, binfo->bits_per_address);
+  set_gdbarch_addr_bit (gdbarch, binfo->bits_per_address);
+  set_gdbarch_char_signed (gdbarch, 1);
 
   /* Information about the target architecture */
-  set_gdbarch_return_value          (gdbarch, or1k_return_value);
-  set_gdbarch_breakpoint_kind_from_pc (gdbarch, or1k_breakpoint_kind_from_pc);
-  set_gdbarch_sw_breakpoint_from_kind (gdbarch, or1k_sw_breakpoint_from_kind);
-  set_gdbarch_have_nonsteppable_watchpoint
-                                    (gdbarch, 1);
+  set_gdbarch_return_value (gdbarch, or1k_return_value);
+  set_gdbarch_breakpoint_kind_from_pc (gdbarch, or1k_breakpoint::kind_from_pc);
+  set_gdbarch_sw_breakpoint_from_kind (gdbarch, or1k_breakpoint::bp_from_kind);
+  set_gdbarch_have_nonsteppable_watchpoint (gdbarch, 1);
 
-  set_gdbarch_print_insn            (gdbarch, print_insn_or1k);
+  set_gdbarch_print_insn (gdbarch, print_insn_or1k);
 
   /* Register architecture */
-  set_gdbarch_pseudo_register_read  (gdbarch, or1k_pseudo_register_read);
+  set_gdbarch_pseudo_register_read (gdbarch, or1k_pseudo_register_read);
   set_gdbarch_pseudo_register_write (gdbarch, or1k_pseudo_register_write);
-  set_gdbarch_num_regs              (gdbarch, OR1K_NUM_REGS);
-  set_gdbarch_num_pseudo_regs       (gdbarch, OR1K_NUM_PSEUDO_REGS);
-  set_gdbarch_sp_regnum             (gdbarch, OR1K_SP_REGNUM);
-  set_gdbarch_pc_regnum             (gdbarch, OR1K_NPC_REGNUM);
-  set_gdbarch_ps_regnum             (gdbarch, OR1K_SR_REGNUM);
-  set_gdbarch_deprecated_fp_regnum  (gdbarch, OR1K_FP_REGNUM);
+  set_gdbarch_num_regs (gdbarch, OR1K_NUM_REGS);
+  set_gdbarch_num_pseudo_regs (gdbarch, OR1K_NUM_PSEUDO_REGS);
+  set_gdbarch_sp_regnum (gdbarch, OR1K_SP_REGNUM);
+  set_gdbarch_pc_regnum (gdbarch, OR1K_NPC_REGNUM);
+  set_gdbarch_ps_regnum (gdbarch, OR1K_SR_REGNUM);
+  set_gdbarch_deprecated_fp_regnum (gdbarch, OR1K_FP_REGNUM);
 
   /* Functions to supply register information */
-  set_gdbarch_register_name         (gdbarch, or1k_register_name);
-  set_gdbarch_register_type         (gdbarch, or1k_register_type);
-  set_gdbarch_print_registers_info  (gdbarch, or1k_registers_info);
-  set_gdbarch_register_reggroup_p   (gdbarch, or1k_register_reggroup_p);
+  set_gdbarch_register_name (gdbarch, or1k_register_name);
+  set_gdbarch_register_type (gdbarch, or1k_register_type);
+  set_gdbarch_print_registers_info (gdbarch, or1k_registers_info);
+  set_gdbarch_register_reggroup_p (gdbarch, or1k_register_reggroup_p);
 
   /* Functions to analyse frames */
-  set_gdbarch_skip_prologue         (gdbarch, or1k_skip_prologue);
-  set_gdbarch_inner_than            (gdbarch, core_addr_lessthan);
-  set_gdbarch_frame_align           (gdbarch, or1k_frame_align);
-  set_gdbarch_frame_red_zone_size   (gdbarch, OR1K_FRAME_RED_ZONE_SIZE);
+  set_gdbarch_skip_prologue (gdbarch, or1k_skip_prologue);
+  set_gdbarch_inner_than (gdbarch, core_addr_lessthan);
+  set_gdbarch_frame_align (gdbarch, or1k_frame_align);
+  set_gdbarch_frame_red_zone_size (gdbarch, OR1K_FRAME_RED_ZONE_SIZE);
 
   /* Functions to access frame data */
-  set_gdbarch_unwind_pc             (gdbarch, or1k_unwind_pc);
-  set_gdbarch_unwind_sp             (gdbarch, or1k_unwind_sp);
+  set_gdbarch_unwind_pc (gdbarch, or1k_unwind_pc);
+  set_gdbarch_unwind_sp (gdbarch, or1k_unwind_sp);
 
   /* Functions handling dummy frames */
-  set_gdbarch_call_dummy_location   (gdbarch, ON_STACK);
-  set_gdbarch_push_dummy_code       (gdbarch, or1k_push_dummy_code);
-  set_gdbarch_push_dummy_call       (gdbarch, or1k_push_dummy_call);
-  set_gdbarch_dummy_id              (gdbarch, or1k_dummy_id);
-
-#if 0
-  /* Set up sniffers for the frame base. Use DWARF debug info if available,
-     otherwise use our own sniffer. */
-  frame_base_append_sniffer (gdbarch, dwarf2_frame_base_sniffer);
-  frame_base_append_sniffer (gdbarch, or1k_frame_base_sniffer);
-#endif
-
-  /* Handle core files */
-  set_gdbarch_iterate_over_regset_sections (gdbarch, or1k_iterate_over_regset_sections);
+  set_gdbarch_call_dummy_location (gdbarch, ON_STACK);
+  set_gdbarch_push_dummy_code (gdbarch, or1k_push_dummy_code);
+  set_gdbarch_push_dummy_call (gdbarch, or1k_push_dummy_call);
+  set_gdbarch_dummy_id (gdbarch, or1k_dummy_id);
 
   /* Frame unwinders. Use DWARF debug info if available, otherwise use our
-     own unwinder. */
+     own unwinder.  */
   dwarf2_append_unwinders (gdbarch);
   frame_unwind_append_unwinder (gdbarch, &or1k_frame_unwind);
 
@@ -2148,24 +1525,23 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 
     const char *mach_name = binfo->printable_name;
     enum cgen_endian endian = (info.byte_order == BFD_ENDIAN_BIG
-                               ? CGEN_ENDIAN_BIG
-                               : CGEN_ENDIAN_LITTLE);
+			       ? CGEN_ENDIAN_BIG : CGEN_ENDIAN_LITTLE);
 
-    tdep->gdb_cgen_cpu_desc = or1k_cgen_cpu_open (CGEN_CPU_OPEN_BFDMACH, mach_name,
-                                        CGEN_CPU_OPEN_ENDIAN, endian,
-                                        CGEN_CPU_OPEN_END);
+    tdep->gdb_cgen_cpu_desc =
+      or1k_cgen_cpu_open (CGEN_CPU_OPEN_BFDMACH, mach_name,
+			  CGEN_CPU_OPEN_ENDIAN, endian, CGEN_CPU_OPEN_END);
 
     or1k_cgen_init_asm (tdep->gdb_cgen_cpu_desc);
   }
 
-  /* If this mach as delay slot */
+  /* If this mach has a delay slot.  */
   if (binfo->mach == bfd_mach_or1k)
     {
       set_gdbarch_single_step_through_delay
-                                    (gdbarch, or1k_single_step_through_delay);
+	(gdbarch, or1k_single_step_through_delay);
     }
 
- /* Check any target description for validity.  */
+  /* Check any target description for validity.  */
   if (tdesc_has_registers (info.target_desc))
     {
 
@@ -2176,7 +1552,8 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 
       tdesc_data = tdesc_data_alloc ();
 
-      /* OpenRisc architecture manual define a maximum of 32 registers groups */
+      /* OpenRisc architecture manual define a maximum of 32 registers
+	 groups.  */
       for (group = 0; group < 32; group++)
 	{
 
@@ -2200,6 +1577,11 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 				    retval, feature_name);
 	    }
 	}
+/*
+TODO YQ
+I don't fully understand what you want to achieve here, can you
+elaborate?  What do these features look alike?
+*/
       if (gdbarch_debug)
 	fprintf_unfiltered (gdb_stdout,
 			    "Found %4d registers in the tdesc file\n",
@@ -2218,6 +1600,9 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 
       /* Override the normal target description methods to handle our
          dual real and pseudo registers.  */
+/* TODO SMH
+These look wrong they are already set above
+*/
       set_gdbarch_register_name (gdbarch, or1k_register_name);
       set_gdbarch_register_reggroup_p (gdbarch, or1k_register_reggroup_p);
 
@@ -2229,19 +1614,12 @@ or1k_gdbarch_init (struct gdbarch_info  info,
 
   return gdbarch;
 
-}	/* or1k_gdbarch_init() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Dump the target specific data for this architecture
+}
 
-   @param[in] gdbarch  The architecture of interest
-   @param[in] file     Where to dump the data */
-/*---------------------------------------------------------------------------*/
+/* Dump the target specific data for this architecture.  */
 
 static void
-or1k_dump_tdep (struct gdbarch *gdbarch,
-		struct ui_file *file)
+or1k_dump_tdep (struct gdbarch *gdbarch, struct ui_file *file)
 {
   struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
 
@@ -2250,48 +1628,36 @@ or1k_dump_tdep (struct gdbarch *gdbarch,
       return;			/* Nothing to report */
     }
 
-  fprintf_unfiltered (file, "or1k_dump_tdep: %d matchpoints available\n",
-		      tdep->num_matchpoints);
-  fprintf_unfiltered (file, "or1k_dump_tdep: %d general purpose registers\n",
-		      tdep->num_gpr_regs);
   fprintf_unfiltered (file, "or1k_dump_tdep: %d bytes per word\n",
 		      tdep->bytes_per_word);
   fprintf_unfiltered (file, "or1k_dump_tdep: %d bytes per address\n",
 		      tdep->bytes_per_address);
 
-}	/* or1k_dump_tdep() */
-
-
+}
 
-/* Functions to add extra commands to GDB */
 
 
-/*----------------------------------------------------------------------------*/
-/*!Returns a special purpose register group name
+/* Functions to add extra commands to GDB.  */
 
-   @param[in]  group  The SPR group number
-
-   @return  The SPR name (pointer to the name argument) */
-/*---------------------------------------------------------------------------*/
+/* Get a special purpose register group name.  */
 
 static const char *
-or1k_spr_group_name (int  group)
+or1k_spr_group_name (int group)
 {
-  static const char *or1k_group_names[OR1K_NUM_SPGS] =
-    {
-      "SYS",
-      "DMMU",
-      "IMMU",
-      "DCACHE",
-      "ICACHE",
-      "MAC",
-      "DEBUG",
-      "PERF",
-      "POWER",
-      "PIC",
-      "TIMER",
-      "FPU"
-    };
+  static const char *or1k_group_names[OR1K_NUM_SPGS] = {
+    "SYS",
+    "DMMU",
+    "IMMU",
+    "DCACHE",
+    "ICACHE",
+    "MAC",
+    "DEBUG",
+    "PERF",
+    "POWER",
+    "PIC",
+    "TIMER",
+    "FPU"
+  };
 
   if ((0 <= group) && (group < OR1K_NUM_SPGS))
     {
@@ -2301,23 +1667,13 @@ or1k_spr_group_name (int  group)
     {
       return "";
     }
-}	/* or1k_spr_group_name() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Returns a special purpose register name
+}
 
-   @param[in]  group  The SPR group
-   @param[in]  index  The index within the SPR group
-   @param[out] name   Array to put the name in
 
-   @return  The SPR name (pointer to the name argument) */
-/*---------------------------------------------------------------------------*/
+/* Get a special purpose register name.  */
 
 static char *
-or1k_spr_register_name (int   group,
-			int   index,
-			char *name)
+or1k_spr_register_name (int group, int index, char *name)
 {
   char di;
 
@@ -2328,51 +1684,73 @@ or1k_spr_register_name (int   group,
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_SYS_VR:       sprintf (name, "VR"      ); return  name;
-	case OR1K_SPG_SYS_UPR:      sprintf (name, "UPR"     ); return  name;
-	case OR1K_SPG_SYS_CPUCFGR:  sprintf (name, "CPUCFGR" ); return  name;
-	case OR1K_SPG_SYS_DMMUCFGR: sprintf (name, "DMMUCFGR"); return  name;
-	case OR1K_SPG_SYS_IMMUCFGR: sprintf (name, "IMMUCFGR"); return  name;
-	case OR1K_SPG_SYS_DCCFGR:   sprintf (name, "DCCFGR"  ); return  name;
-	case OR1K_SPG_SYS_ICCFGR:   sprintf (name, "ICCFGR"  ); return  name;
-	case OR1K_SPG_SYS_DCFGR:    sprintf (name, "DCFGR"   ); return  name;
-	case OR1K_SPG_SYS_PCCFGR:   sprintf (name, "PCCFGR"  ); return  name;
-	case OR1K_SPG_SYS_NPC:      sprintf (name, "NPC"     ); return  name;
-	case OR1K_SPG_SYS_SR:       sprintf (name, "SR"      ); return  name;
-	case OR1K_SPG_SYS_PPC:      sprintf (name, "PPC"     ); return  name;
-	case OR1K_SPG_SYS_FPCSR:    sprintf (name, "FPCSR"   ); return  name;
+	case OR1K_SPG_SYS_VR:
+	  sprintf (name, "VR");
+	  return name;
+	case OR1K_SPG_SYS_UPR:
+	  sprintf (name, "UPR");
+	  return name;
+	case OR1K_SPG_SYS_CPUCFGR:
+	  sprintf (name, "CPUCFGR");
+	  return name;
+	case OR1K_SPG_SYS_DMMUCFGR:
+	  sprintf (name, "DMMUCFGR");
+	  return name;
+	case OR1K_SPG_SYS_IMMUCFGR:
+	  sprintf (name, "IMMUCFGR");
+	  return name;
+	case OR1K_SPG_SYS_DCCFGR:
+	  sprintf (name, "DCCFGR");
+	  return name;
+	case OR1K_SPG_SYS_ICCFGR:
+	  sprintf (name, "ICCFGR");
+	  return name;
+	case OR1K_SPG_SYS_DCFGR:
+	  sprintf (name, "DCFGR");
+	  return name;
+	case OR1K_SPG_SYS_PCCFGR:
+	  sprintf (name, "PCCFGR");
+	  return name;
+	case OR1K_SPG_SYS_NPC:
+	  sprintf (name, "NPC");
+	  return name;
+	case OR1K_SPG_SYS_SR:
+	  sprintf (name, "SR");
+	  return name;
+	case OR1K_SPG_SYS_PPC:
+	  sprintf (name, "PPC");
+	  return name;
+	case OR1K_SPG_SYS_FPCSR:
+	  sprintf (name, "FPCSR");
+	  return name;
 	}
 
       /* Exception PC regs */
-      if((OR1K_SPG_SYS_EPCR <= index) &&
-	 (index             <= OR1K_SPG_SYS_EPCR_END))
+      if ((OR1K_SPG_SYS_EPCR <= index) && (index <= OR1K_SPG_SYS_EPCR_END))
 	{
 	  sprintf (name, "EPCR%d", index - OR1K_SPG_SYS_EPCR);
-	  return  name;
+	  return name;
 	}
 
       /* Exception EA regs */
-      if((OR1K_SPG_SYS_EEAR <= index) &&
-	 (index             <= OR1K_SPG_SYS_EEAR_END))
+      if ((OR1K_SPG_SYS_EEAR <= index) && (index <= OR1K_SPG_SYS_EEAR_END))
 	{
 	  sprintf (name, "EEAR%d", index - OR1K_SPG_SYS_EEAR);
-	  return  name;
+	  return name;
 	}
 
       /* Exception SR regs */
-      if((OR1K_SPG_SYS_ESR <= index) &&
-	 (index            <= OR1K_SPG_SYS_ESR_END))
+      if ((OR1K_SPG_SYS_ESR <= index) && (index <= OR1K_SPG_SYS_ESR_END))
 	{
 	  sprintf (name, "ESR%d", index - OR1K_SPG_SYS_ESR);
-	  return  name;
+	  return name;
 	}
 
       /* GPRs */
-      if((OR1K_SPG_SYS_GPR <= index) &&
-	 (index            <= OR1K_SPG_SYS_GPR_END))
+      if ((OR1K_SPG_SYS_GPR <= index) && (index <= OR1K_SPG_SYS_GPR_END))
 	{
 	  sprintf (name, "GPR%d", index - OR1K_SPG_SYS_GPR);
-	  return  name;
+	  return name;
 	}
 
       break;
@@ -2380,99 +1758,114 @@ or1k_spr_register_name (int   group,
     case OR1K_SPG_DMMU:
     case OR1K_SPG_IMMU:
       /* MMU registers. Use DMMU constants throughout, but these are identical
-	 to the corresponding IMMU constants */
+         to the corresponding IMMU constants.  */
       di = OR1K_SPG_DMMU == group ? 'D' : 'I';
 
       /* 1:1 names */
       switch (index)
 	{
 	case OR1K_SPG_DMMU_DMMUCR:
-	  sprintf (name, "%cMMUCR",  di); return  name;
+	  sprintf (name, "%cMMUCR", di);
+	  return name;
 	case OR1K_SPG_DMMU_DMMUPR:
-	  sprintf (name, "%cMMUPR",  di); return  name;
+	  sprintf (name, "%cMMUPR", di);
+	  return name;
 	case OR1K_SPG_DMMU_DTLBEIR:
-	  sprintf (name, "%cTLBEIR", di); return  name;
+	  sprintf (name, "%cTLBEIR", di);
+	  return name;
 	}
 
       /* ATB Match registers */
-      if((OR1K_SPG_DMMU_DATBMR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DATBMR_END))
+      if ((OR1K_SPG_DMMU_DATBMR <= index)
+	  && (index <= OR1K_SPG_DMMU_DATBMR_END))
 	{
 	  sprintf (name, "%cATBMR%d", di, index - OR1K_SPG_DMMU_DATBMR);
-	  return  name;
+	  return name;
 	}
 
       /* ATB Translate registers */
-      if((OR1K_SPG_DMMU_DATBTR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DATBTR_END))
+      if ((OR1K_SPG_DMMU_DATBTR <= index)
+	  && (index <= OR1K_SPG_DMMU_DATBTR_END))
 	{
 	  sprintf (name, "%cATBTR%d", di, index - OR1K_SPG_DMMU_DATBTR);
-	  return  name;
+	  return name;
 	}
 
       /* TLB Way 1 Match registers */
-      if((OR1K_SPG_DMMU_DTLBW1MR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DTLBW1MR_END))
+      if ((OR1K_SPG_DMMU_DTLBW1MR <= index)
+	  && (index <= OR1K_SPG_DMMU_DTLBW1MR_END))
 	{
 	  sprintf (name, "%cTLBW1MR%d", di, index - OR1K_SPG_DMMU_DTLBW1MR);
-	  return  name;
+	  return name;
 	}
 
       /* TLB Way 1 Translate registers */
-      if((OR1K_SPG_DMMU_DTLBW1TR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DTLBW1TR_END))
+      if ((OR1K_SPG_DMMU_DTLBW1TR <= index)
+	  && (index <= OR1K_SPG_DMMU_DTLBW1TR_END))
 	{
 	  sprintf (name, "%cTLBW1TR%d", di, index - OR1K_SPG_DMMU_DTLBW1TR);
-	  return  name;
+	  return name;
 	}
 
       /* TLB Way 2 Match registers */
-      if((OR1K_SPG_DMMU_DTLBW2MR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DTLBW2MR_END))
+      if ((OR1K_SPG_DMMU_DTLBW2MR <= index)
+	  && (index <= OR1K_SPG_DMMU_DTLBW2MR_END))
 	{
 	  sprintf (name, "%cTLBW2MR%d", di, index - OR1K_SPG_DMMU_DTLBW2MR);
-	  return  name;
+	  return name;
 	}
 
       /* TLB Way 2 Translate registers */
-      if((OR1K_SPG_DMMU_DTLBW2TR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DTLBW2TR_END))
+      if ((OR1K_SPG_DMMU_DTLBW2TR <= index)
+	  && (index <= OR1K_SPG_DMMU_DTLBW2TR_END))
 	{
 	  sprintf (name, "%cTLBW2TR%d", di, index - OR1K_SPG_DMMU_DTLBW2TR);
-	  return  name;
+	  return name;
 	}
 
       /* TLB Way 3 Match registers */
-      if((OR1K_SPG_DMMU_DTLBW3MR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DTLBW3MR_END))
+      if ((OR1K_SPG_DMMU_DTLBW3MR <= index)
+	  && (index <= OR1K_SPG_DMMU_DTLBW3MR_END))
 	{
 	  sprintf (name, "%cTLBW3MR%d", di, index - OR1K_SPG_DMMU_DTLBW3MR);
-	  return  name;
+	  return name;
 	}
 
       /* TLB Way 3 Translate registers */
-      if((OR1K_SPG_DMMU_DTLBW3TR <= index) &&
-	 (index                <= OR1K_SPG_DMMU_DTLBW3TR_END))
+      if ((OR1K_SPG_DMMU_DTLBW3TR <= index)
+	  && (index <= OR1K_SPG_DMMU_DTLBW3TR_END))
 	{
 	  sprintf (name, "%cTLBW3TR%d", di, index - OR1K_SPG_DMMU_DTLBW3TR);
-	  return  name;
+	  return name;
 	}
 
       break;
 
     case OR1K_SPG_DC:
       /* Data cache registers. These do not have an exact correspondence with
-	 their instruction cache counterparts, so must be done separately. */
+         their instruction cache counterparts, so must be done separately.  */
 
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_DC_DCCR:  sprintf (name, "DCCR" ); return  name;
-	case OR1K_SPG_DC_DCBPR: sprintf (name, "DCBPR"); return  name;
-	case OR1K_SPG_DC_DCBFR: sprintf (name, "DCBFR"); return  name;
-	case OR1K_SPG_DC_DCBIR: sprintf (name, "DCBIR"); return  name;
-	case OR1K_SPG_DC_DCBWR: sprintf (name, "DCBWR"); return  name;
-	case OR1K_SPG_DC_DCBLR: sprintf (name, "DCBLR"); return  name;
+	case OR1K_SPG_DC_DCCR:
+	  sprintf (name, "DCCR");
+	  return name;
+	case OR1K_SPG_DC_DCBPR:
+	  sprintf (name, "DCBPR");
+	  return name;
+	case OR1K_SPG_DC_DCBFR:
+	  sprintf (name, "DCBFR");
+	  return name;
+	case OR1K_SPG_DC_DCBIR:
+	  sprintf (name, "DCBIR");
+	  return name;
+	case OR1K_SPG_DC_DCBWR:
+	  sprintf (name, "DCBWR");
+	  return name;
+	case OR1K_SPG_DC_DCBLR:
+	  sprintf (name, "DCBLR");
+	  return name;
 	}
 
       break;
@@ -2483,10 +1876,18 @@ or1k_spr_register_name (int   group,
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_IC_ICCR:  sprintf (name, "ICCR" ); return  name;
-	case OR1K_SPG_IC_ICBPR: sprintf (name, "ICBPR"); return  name;
-	case OR1K_SPG_IC_ICBIR: sprintf (name, "ICBIR"); return  name;
-	case OR1K_SPG_IC_ICBLR: sprintf (name, "ICBLR"); return  name;
+	case OR1K_SPG_IC_ICCR:
+	  sprintf (name, "ICCR");
+	  return name;
+	case OR1K_SPG_IC_ICBPR:
+	  sprintf (name, "ICBPR");
+	  return name;
+	case OR1K_SPG_IC_ICBIR:
+	  sprintf (name, "ICBIR");
+	  return name;
+	case OR1K_SPG_IC_ICBLR:
+	  sprintf (name, "ICBLR");
+	  return name;
 	}
 
       break;
@@ -2497,8 +1898,12 @@ or1k_spr_register_name (int   group,
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_MAC_MACLO: sprintf (name, "MACLO"); return  name;
-	case OR1K_SPG_MAC_MACHI: sprintf (name, "MACHI"); return  name;
+	case OR1K_SPG_MAC_MACLO:
+	  sprintf (name, "MACLO");
+	  return name;
+	case OR1K_SPG_MAC_MACHI:
+	  sprintf (name, "MACHI");
+	  return name;
 	}
 
       break;
@@ -2507,30 +1912,40 @@ or1k_spr_register_name (int   group,
       /* Debug registers */
 
       /* Debug Value registers */
-      if((OR1K_SPG_DEBUG_DVR <= index) &&
-	 (index                <= OR1K_SPG_DEBUG_DVR_END))
+      if ((OR1K_SPG_DEBUG_DVR <= index) && (index <= OR1K_SPG_DEBUG_DVR_END))
 	{
 	  sprintf (name, "DVR%d", index - OR1K_SPG_DEBUG_DVR);
-	  return  name;
+	  return name;
 	}
 
       /* Debug Control registers */
-      if((OR1K_SPG_DEBUG_DCR <= index) &&
-	 (index                <= OR1K_SPG_DEBUG_DCR_END))
+      if ((OR1K_SPG_DEBUG_DCR <= index) && (index <= OR1K_SPG_DEBUG_DCR_END))
 	{
 	  sprintf (name, "DCR%d", index - OR1K_SPG_DEBUG_DCR);
-	  return  name;
+	  return name;
 	}
 
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_DEBUG_DMR1:  sprintf (name, "DMR1" ); return  name;
-	case OR1K_SPG_DEBUG_DMR2:  sprintf (name, "DMR2" ); return  name;
-	case OR1K_SPG_DEBUG_DCWR0: sprintf (name, "DCWR0"); return  name;
-	case OR1K_SPG_DEBUG_DCWR1: sprintf (name, "DCWR1"); return  name;
-	case OR1K_SPG_DEBUG_DSR:   sprintf (name, "DSR"  ); return  name;
-	case OR1K_SPG_DEBUG_DRR:   sprintf (name, "DRR"  ); return  name;
+	case OR1K_SPG_DEBUG_DMR1:
+	  sprintf (name, "DMR1");
+	  return name;
+	case OR1K_SPG_DEBUG_DMR2:
+	  sprintf (name, "DMR2");
+	  return name;
+	case OR1K_SPG_DEBUG_DCWR0:
+	  sprintf (name, "DCWR0");
+	  return name;
+	case OR1K_SPG_DEBUG_DCWR1:
+	  sprintf (name, "DCWR1");
+	  return name;
+	case OR1K_SPG_DEBUG_DSR:
+	  sprintf (name, "DSR");
+	  return name;
+	case OR1K_SPG_DEBUG_DRR:
+	  sprintf (name, "DRR");
+	  return name;
 	}
 
       break;
@@ -2539,19 +1954,17 @@ or1k_spr_register_name (int   group,
       /* Performance Counter registers */
 
       /* Performance Counters Count registers */
-      if((OR1K_SPG_PC_PCCR <= index) &&
-	 (index                <= OR1K_SPG_PC_PCCR_END))
+      if ((OR1K_SPG_PC_PCCR <= index) && (index <= OR1K_SPG_PC_PCCR_END))
 	{
 	  sprintf (name, "PCCR%d", index - OR1K_SPG_PC_PCCR);
-	  return  name;
+	  return name;
 	}
 
       /* Performance Counters Mode registers */
-      if((OR1K_SPG_PC_PCMR <= index) &&
-	 (index                <= OR1K_SPG_PC_PCMR_END))
+      if ((OR1K_SPG_PC_PCMR <= index) && (index <= OR1K_SPG_PC_PCMR_END))
 	{
 	  sprintf (name, "PCMR%d", index - OR1K_SPG_PC_PCMR);
-	  return  name;
+	  return name;
 	}
 
       break;
@@ -2562,7 +1975,9 @@ or1k_spr_register_name (int   group,
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_PM_PMR:  sprintf (name, "PMR"); return  name;
+	case OR1K_SPG_PM_PMR:
+	  sprintf (name, "PMR");
+	  return name;
 	}
 
       break;
@@ -2573,8 +1988,12 @@ or1k_spr_register_name (int   group,
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_PIC_PICMR:  sprintf (name, "PICMR"); return  name;
-	case OR1K_SPG_PIC_PICSR:  sprintf (name, "PICSR"); return  name;
+	case OR1K_SPG_PIC_PICMR:
+	  sprintf (name, "PICMR");
+	  return name;
+	case OR1K_SPG_PIC_PICSR:
+	  sprintf (name, "PICSR");
+	  return name;
 	}
 
       break;
@@ -2585,8 +2004,12 @@ or1k_spr_register_name (int   group,
       /* 1:1 names */
       switch (index)
 	{
-	case OR1K_SPG_TT_TTMR:  sprintf (name, "TTMR"); return  name;
-	case OR1K_SPG_TT_TTCR:  sprintf (name, "TTCR"); return  name;
+	case OR1K_SPG_TT_TTMR:
+	  sprintf (name, "TTMR");
+	  return name;
+	case OR1K_SPG_TT_TTCR:
+	  sprintf (name, "TTCR");
+	  return name;
 	}
 
       break;
@@ -2598,23 +2021,17 @@ or1k_spr_register_name (int   group,
 
   /* Not a recognized register */
   strcpy (name, "");
-  return  name;
-
-}	/* or1k_spr_register_name() */
-
+  return name;
 
-/*----------------------------------------------------------------------------*/
-/*!Get SPR group number from a name
+}
 
-   @param[in] group_name  SPR register group
 
-   @return  The index, or negative if no match. */
-/*----------------------------------------------------------------------------*/
+/* Get SPR group number from a name.  */
 
 static int
 or1k_groupnum_from_name (char *group_name)
 {
-  int  group;
+  int group;
 
   for (group = 0; group < OR1K_NUM_SPGS; group++)
     {
@@ -2626,60 +2043,50 @@ or1k_groupnum_from_name (char *group_name)
 
   return -1;
 
-}	/* or1k_groupnum_from_name() */
-
+}
 
-/*----------------------------------------------------------------------------*/
-/*!Get register index in special purpose register group from name
 
+/* Get register index in special purpose register group from name.
    The name may either be SPR<group_num>_<index> or a known unique name. In
-   either case the group number must match the supplied group number.
-
-   @param[in] group  SPR register group
-   @param[in] name   Register name
-
-   @return  The index, or negative if no match. */
-/*----------------------------------------------------------------------------*/
+   either case the group number must match the supplied group number.  */
 
 static int
-or1k_regnum_from_name (int   group,
-		       char *name)
+or1k_regnum_from_name (int group, char *name)
 {
-  /* Last valid register in each group. */
-  static const int  or1k_spr_group_last[OR1K_NUM_SPGS] =
-    {
-      OR1K_SPG_SYS_LAST,
-      OR1K_SPG_DMMU_LAST,
-      OR1K_SPG_IMMU_LAST,
-      OR1K_SPG_DC_LAST,
-      OR1K_SPG_IC_LAST,
-      OR1K_SPG_MAC_LAST,
-      OR1K_SPG_DEBUG_LAST,
-      OR1K_SPG_PC_LAST,
-      OR1K_SPG_PM_LAST,
-      OR1K_SPG_PIC_LAST,
-      OR1K_SPG_TT_LAST,
-      OR1K_SPG_FPU_LAST
-    };
-
-  int  i;
-  char  spr_name[32];
+  /* Last valid register in each group.  */
+  static const int or1k_spr_group_last[OR1K_NUM_SPGS] = {
+    OR1K_SPG_SYS_LAST,
+    OR1K_SPG_DMMU_LAST,
+    OR1K_SPG_IMMU_LAST,
+    OR1K_SPG_DC_LAST,
+    OR1K_SPG_IC_LAST,
+    OR1K_SPG_MAC_LAST,
+    OR1K_SPG_DEBUG_LAST,
+    OR1K_SPG_PC_LAST,
+    OR1K_SPG_PM_LAST,
+    OR1K_SPG_PIC_LAST,
+    OR1K_SPG_TT_LAST,
+    OR1K_SPG_FPU_LAST
+  };
+
+  int i;
+  char spr_name[32];
 
   if (0 == strcasecmp (name, "SPR"))
     {
       char *ptr_c;
 
-      /* Skip SPR */
+      /* skip SPR */
       name += 3;
 
-      /* Get group number */
+      /* get group number */
       i = (int) strtoul (name, &ptr_c, 10);
       if (*ptr_c != '_' || i != group)
 	{
 	  return -1;
 	}
 
-      /* Get index */
+      /* get index */
       ptr_c++;
       i = (int) strtoul (name, &ptr_c, 10);
       if (*ptr_c)
@@ -2688,11 +2095,11 @@ or1k_regnum_from_name (int   group,
 	}
       else
 	{
-	  return  i;
+	  return i;
 	}
     }
 
-  /* Look for a "known" name in this group */
+  /* Look for a "known" name in this group.  */
   for (i = 0; i <= or1k_spr_group_last[group]; i++)
     {
       char *s = or1k_spr_register_name (group, i, spr_name);
@@ -2706,36 +2113,18 @@ or1k_regnum_from_name (int   group,
   /* Failure */
   return -1;
 
-}	/* or1k_regnum_from_name() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Get the next token from a string
-
-   I can't believe there isn't a library argument for this, but strtok is
-   deprecated.
-
-   Take a string and find the start of the next token and its length. A token
-   is anything containing non-blank characters.
-
-   @param[in]  str  The string to look at (may be NULL).
-   @param[out] tok  Pointer to the start of the token within str. May be NULL
-                    if this result is not wanted (e.g. just the length is
-		    wanted. If no token is found will be the NULL char@the
-		    end of the string, if the original str was NULL, this will
-		    be NULL.
-
-		    @return  The length of the token found */
-/*----------------------------------------------------------------------------*/
+}
 
+/* Get the next token from a string. Take a string and find the start of the
+   next token and its length. A token is anything containing non-blank
+   characters.  */
+/* TODO make sure we cant use something existing here */
 static int
-or1k_tokenize (char  *str,
-	       char **tok)
+or1k_tokenize (char *str, char **tok)
 {
   char *ptr;
-  int   len;
+  int len;
 
-  /* Deal with NULL argument */
   if (NULL == str)
     {
       if (NULL != tok)
@@ -2745,112 +2134,66 @@ or1k_tokenize (char  *str,
       return 0;
     }
 
-  /* Find the start */
-  for (ptr = str; ISBLANK (*ptr) ; ptr++)
+  /* Find the start.  */
+  for (ptr = str; ISBLANK (*ptr); ptr++)
     {
       continue;
     }
 
-  /* Return the start pointer if requested */
+  /* Return the start pointer if requested.  */
   if (NULL != tok)
     {
       *tok = ptr;
     }
 
-  /* Find the end and put in EOS */
-  for (len = 0;  ('\0' != ptr[len]) && (!ISBLANK (ptr[len])); len++)
+  /* Find the end and put in EOS.  */
+  for (len = 0; ('\0' != ptr[len]) && (!ISBLANK (ptr[len])); len++)
     {
       continue;
     }
 
   return len;
 
-}	/* or1k_tokenize() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Parses args for spr commands
-
-   Determines the special purpose register (SPR) name and puts result into
-   group and index
+}
 
-   Syntax is:
+/* Parses args for spr commands. Where arg_str syntax is:
 
-   @verbatim
    <spr_args>    -> <group_ref> | <reg_name>
    <group_ref>   -> <group_id> <index>
    <group_id>    -> <group_num> | <group_name>
-   @endverbatim
-
-   Where the indices/names have to be valid.
-
-   So to parse, we look for 1 or 2 args. If 1 it must be a unique register
-   name. If 2, the first must be a group number or name and the second an
-   index within that group.
-
-   Also responsible for providing diagnostics if the arguments do not match.
-
-   Rewritten for GDB 6.8 to use the new UI calls and remove assorted
-   bugs. Syntax also slightly restricted to be more comprehensible.
 
-   @param[in]  arg_str  The argument string
-   @param[out] group    The group this SPR belongs in, or -1 to indicate
-                        failure
-   @param[out] index    Index of the register within the group, or -1 to
-                        indicate the whole group
-   @param[in]  is_set   1 (true) if we are called from the "spr" command (so
-                        there is an extra arg) rather than the "info spr"
-                        command. Needed to distinguish between the case where
-                        info is sought from a register specified as group and
-                        index and setting a uniquely identified register to a
-                        value.
-
-			@return  A pointer to any remaining args */
-/*---------------------------------------------------------------------------*/
+   Where the indices/names have to be valid.  */
 
 static char *
-or1k_parse_spr_params (char *arg_str,
-		       int  *group,
-		       int  *index,
-		       int   is_set)
+or1k_parse_spr_params (char *arg_str, int *group, int *index, int is_set)
 {
-  struct {
-    char              *str;
-    int                len;
-    unsigned long int  val;
-    int                is_num;
-  } arg[3] = {
-    {
-      .str    = NULL,
-      .len    = 0,
-      .val    = 0,
-      .is_num = 0,
-    },
-   {
-      .str    = NULL,
-      .len    = 0,
-      .val    = 0,
-      .is_num = 0,
-    },
-   {
-      .str    = NULL,
-      .len    = 0,
-      .val    = 0,
-      .is_num = 0,
-    }
+  struct
+  {
+    char *str;
+    int len;
+    unsigned long int val;
+    int is_num;
+  } arg[3] =
+  {
+    {
+    .str = NULL,.len = 0,.val = 0,.is_num = 0,},
+    {
+    .str = NULL,.len = 0,.val = 0,.is_num = 0,},
+    {
+    .str = NULL,.len = 0,.val = 0,.is_num = 0,}
   };
 
-  int   num_args;
-  char *trailer  = arg_str;
+  int num_args;
+  char *trailer = arg_str;
   char *tmp_str;
-  int   i;
+  int i;
   struct ui_out *uiout = current_uiout;
-  char  spr_name[32];
+  char spr_name[32];
 
   /* Break out the arguments. Note that the strings are NOT null terminated
      (we don't want to change arg_str), so we must rely on len. The stroul
      call will still work, since there is always a non-digit char (possibly EOS)
-     after the last digit. */
+     after the last digit.  */
   if (NULL == arg_str)
     {
       num_args = 0;
@@ -2860,7 +2203,7 @@ or1k_parse_spr_params (char *arg_str,
       for (num_args = 0; num_args < 3; num_args++)
 	{
 	  arg[num_args].len = or1k_tokenize (trailer, &(arg[num_args].str));
-	  trailer           = arg[num_args].str + arg[num_args].len;
+	  trailer = arg[num_args].str + arg[num_args].len;
 
 	  if (0 == arg[num_args].len)
 	    {
@@ -2871,9 +2214,9 @@ or1k_parse_spr_params (char *arg_str,
 
   /* Patch nulls into the arg strings and see about values. Couldn't do this
      earlier, since we needed the next char clean to check later args. This
-     means advancing trailer, UNLESS it was already at EOS */
+     means advancing trailer, UNLESS it was already@EOS.  */
 
-  if((NULL != arg_str) && ('\0' != *trailer))
+  if ((NULL != arg_str) && ('\0' != *trailer))
     {
       trailer++;
     }
@@ -2881,14 +2224,14 @@ or1k_parse_spr_params (char *arg_str,
   for (i = 0; i < num_args; i++)
     {
       (arg[i].str)[arg[i].len] = '\0';
-      errno                    = 0;
-      arg[i].val               = strtoul (arg[i].str, &tmp_str, 0);
-      arg[i].is_num            = (0 == errno) && ('\0' == *tmp_str);
+      errno = 0;
+      arg[i].val = strtoul (arg[i].str, &tmp_str, 0);
+      arg[i].is_num = (0 == errno) && ('\0' == *tmp_str);
     }
 
   /* Deal with the case where we are setting a register, so the final argument
      should be disregarded (it is the trailer). Do this anyway if we get a
-     third argument */
+     third argument.  */
   if ((is_set & (num_args > 0)) || (num_args > 2))
     {
       trailer = arg[num_args - 1].str;
@@ -2908,14 +2251,14 @@ or1k_parse_spr_params (char *arg_str,
 		      "Valid groups are:\n");
       for (i = 0; i < OR1K_NUM_SPGS; i++)
 	{
-	  ui_out_field_string (uiout, NULL, or1k_spr_group_name  (i));
+	  ui_out_field_string (uiout, NULL, or1k_spr_group_name (i));
 	  ui_out_spaces (uiout, 1);
 	  ui_out_wrap_hint (uiout, NULL);
 	}
       ui_out_field_string (uiout, NULL, "\n");
 
       *index = -1;
-      return  trailer;
+      return trailer;
 
     case 1:
       /* See if it is a numeric group */
@@ -2953,7 +2296,7 @@ or1k_parse_spr_params (char *arg_str,
 
 	  if (*index >= 0)
 	    {
-	      return  trailer;
+	      return trailer;
 	    }
 	}
 
@@ -2971,7 +2314,7 @@ or1k_parse_spr_params (char *arg_str,
 
       *group = -1;
       *index = -1;
-      return  trailer;
+      return trailer;
 
     case 2:
       /* See if first arg is a numeric group */
@@ -3015,7 +2358,7 @@ or1k_parse_spr_params (char *arg_str,
 
 	      *group = -1;
 	      *index = -1;
-	      return  trailer;
+	      return trailer;
 	    }
 	}
 
@@ -3037,7 +2380,7 @@ or1k_parse_spr_params (char *arg_str,
 				  "No valid register at that index in group\n");
 		  *group = -1;
 		  *index = -1;
-		  return  trailer;
+		  return trailer;
 		}
 	    }
 	  else
@@ -3047,7 +2390,7 @@ or1k_parse_spr_params (char *arg_str,
 			      OR1K_SPG_SIZE - 1);
 	      *group = -1;
 	      *index = -1;
-	      return  trailer;
+	      return trailer;
 	    }
 	}
 
@@ -3063,41 +2406,37 @@ or1k_parse_spr_params (char *arg_str,
       ui_out_message (uiout, 0, "Register name not recognized in group.\n");
       *group = -1;
       *index = -1;
-      return  trailer;
+      return trailer;
 
     default:
       /* Anything else is an error */
       ui_out_message (uiout, 0, "Unable to parse arguments\n");
       *group = -1;
       *index = -1;
-      return  trailer;
+      return trailer;
     }
-}	/* or1k_parse_spr_params() */
-
-
-/*---------------------------------------------------------------------------*/
-/*!Read a special purpose register from the target
-
-   This has to be done using the target remote command "readspr"
-
-   @param[in] regnum  The register to read
+}
 
-   @return  The value read */
-/*---------------------------------------------------------------------------*/
+/* Read a special purpose register from the target.  */
 
 static ULONGEST
-or1k_read_spr (unsigned int  regnum)
+or1k_read_spr (unsigned int regnum)
 {
-  struct ui_file    *uibuf = mem_fileopen ();
-  char               cmd[sizeof ("readspr ffff")];
-  unsigned long int  data;
-  char              *res;
-  long int           len;
+  struct ui_file *uibuf = mem_fileopen ();
+  char cmd[sizeof ("readspr ffff")];
+  unsigned long int data;
+  char *res;
+  long int len;
 
   /* Create the command string and pass it to target remote command function */
   sprintf (cmd, "readspr %4x", regnum);
   target_rcmd (cmd, uibuf);
 
+/* TODO YQ
+Why don't you put these special purpose register to g packet, so that
+we can read them through g packet?  It is not a good idea to extend rcmd this way.
+*/
+
   /* Get the output for the UI file as a string */
   res = ui_file_xstrdup (uibuf, &len);
   sscanf (res, "%lx", &data);
@@ -3106,137 +2445,113 @@ or1k_read_spr (unsigned int  regnum)
   xfree (res);
   ui_file_delete (uibuf);
 
-  return  (ULONGEST)data;
-
-}	/* or1k_read_spr() */
+  return (ULONGEST) data;
 
+}
 
-/*---------------------------------------------------------------------------*/
-/*!Write a special purpose register on the target
-
-   This has to be done using the target remote command "writespr"
-
-   Since the SPRs may map to GPR's or the other GDB register (PPC, NPC, SR),
-   any register cache is flushed.
-
-   @param[in] regnum  The register to write
-   @param[in] data  The value to write */
-/*---------------------------------------------------------------------------*/
+/* Write a special purpose register on the target.  */
 
 static void
-or1k_write_spr (unsigned int  regnum,
-		ULONGEST      data)
+or1k_write_spr (unsigned int regnum, ULONGEST data)
 {
-  struct ui_file    *uibuf = mem_fileopen ();
-  char               cmd[sizeof ("writespr ffff ffffffff")];
-  char              *res;
-  long int           len;
+  struct ui_file *uibuf = mem_fileopen ();
+  char cmd[sizeof ("writespr ffff ffffffff")];
+  char *res;
+  long int len;
 
   /* Create the command string and pass it to target remote command function */
-  sprintf (cmd, "writespr %4x %8llx", regnum, (long long unsigned int)data);
+  sprintf (cmd, "writespr %4x %8llx", regnum, (long long unsigned int) data);
   target_rcmd (cmd, uibuf);
 
   /* Flush the register cache */
   registers_changed ();
 
   /* We ignore the result - Rcmd can put out its own error messages. Just
-     tidy up */
+     tidy up.  */
   ui_file_delete (uibuf);
 
-}	/* or1k_write_spr() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Show the value of a special purpose register or group
-
-   This is a custom extension to the GDB info command.
+}
 
-   @param[in] args
-   @param[in] from_tty  True (1) if GDB is running from a TTY, false (0)
-   otherwise. */
-/*---------------------------------------------------------------------------*/
+/* Show the value of a special purpose register or group.  */
 
 static void
-or1k_info_spr_command (char *args,
-		       int   from_tty)
+or1k_info_spr_command (char *args, int from_tty)
 {
-  int  group;
-  int  index;
+  int group;
+  int index;
   struct ui_out *uiout = current_uiout;
-  char  spr_name[32];
+  char spr_name[32];
 
   or1k_parse_spr_params (args, &group, &index, 0);
 
+/* TODO YQ
+Could you explain what do you want to do for special purpose
+register/group here?
+*/
+
   if (group < 0)
     {
-      return;			/* Couldn't parse the args */
+      return; /* couldn't parse the args */
     }
 
   if (index >= 0)
     {
-      ULONGEST  value = or1k_read_spr (OR1K_SPR (group, index));
+      ULONGEST value = or1k_read_spr (OR1K_SPR (group, index));
 
       ui_out_field_fmt (uiout, NULL, "%s.%s = SPR%i_%i = %llu (0x%llx)\n",
 			or1k_spr_group_name (group),
-			or1k_spr_register_name (group, index, spr_name), group,
-			index, (long long unsigned int)value, (long long unsigned int)value);
+			or1k_spr_register_name (group, index, spr_name),
+			group, index, (long long unsigned int) value,
+			(long long unsigned int) value);
     }
   else
     {
-      /* Print all valid registers in the group */
+      /* Print all valid registers in the group.  */
       for (index = 0; index < OR1K_SPG_SIZE; index++)
 	{
 	  if (0 != strlen (or1k_spr_register_name (group, index, spr_name)))
 	    {
-	      ULONGEST  value = or1k_read_spr (OR1K_SPR (group, index));
+	      ULONGEST value = or1k_read_spr (OR1K_SPR (group, index));
 
 	      ui_out_field_fmt (uiout, NULL,
 				"%s.%s = SPR%i_%i = %llu (0x%llx)\n",
 				or1k_spr_group_name (group),
-				or1k_spr_register_name (group, index, spr_name),
-				group, index, (long long unsigned int)value, (long long unsigned int)value);
+				or1k_spr_register_name (group, index,
+							spr_name), group,
+				index, (long long unsigned int) value,
+				(long long unsigned int) value);
 	    }
 	}
     }
-}	/* or1k_info_spr_command() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Set a special purpose register
-
-   This is a custom command added to GDB.
+}
 
-   @param[in] args
-   @param[in] from_tty  True (1) if GDB is running from a TTY, false (0)
-   otherwise. */
-/*---------------------------------------------------------------------------*/
+/* Set a special purpose register command.  */
 
 static void
-or1k_spr_command (char *args,
-		  int   from_tty)
+or1k_spr_command (char *args, int from_tty)
 {
-  int   group;
-  int   index;
+  int group;
+  int index;
   char *tmp_str;
   char *nargs = or1k_parse_spr_params (args, &group, &index, 1);
   struct ui_out *uiout = current_uiout;
-  ULONGEST  old_val;
-  ULONGEST  new_val;
+  ULONGEST old_val;
+  ULONGEST new_val;
 
-  char  spr_name[32];
+  char spr_name[32];
 
-  /* Do we have a valid register spec? */
+  /* Do we have a valid register spec?  */
   if (index < 0)
     {
-      return;		/* Parser will have printed the error message */
+      return; /* Parser will have printed the error message.  */
     }
 
-  /* Do we have a value to set? */
+  /* Do we have a value to set?  */
 
   errno = 0;
-  new_val = (ULONGEST)strtoul (nargs, &tmp_str, 0);
+  new_val = (ULONGEST) strtoul (nargs, &tmp_str, 0);
 
-  if((0 != errno) || ('\0' != *tmp_str))
+  if ((0 != errno) || ('\0' != *tmp_str))
     {
       ui_out_message (uiout, 0, "Invalid value - register not changed\n");
       return;
@@ -3244,42 +2559,34 @@ or1k_spr_command (char *args,
 
   old_val = or1k_read_spr (OR1K_SPR (group, index));
 
-  or1k_write_spr (OR1K_SPR (group, index) , new_val);
+  or1k_write_spr (OR1K_SPR (group, index), new_val);
 
   ui_out_field_fmt (uiout, NULL,
 		    "%s.%s (SPR%i_%i) set to %llu (0x%llx), "
 		    "was: %llu (0x%llx)\n",
 		    or1k_spr_group_name (group),
-		    or1k_spr_register_name (group, index, spr_name) , group,
-		    index, (long long unsigned int)new_val, (long long unsigned int)new_val, (long long unsigned int)old_val, (long long unsigned int)old_val);
+		    or1k_spr_register_name (group, index, spr_name), group,
+		    index, (long long unsigned int) new_val,
+		    (long long unsigned int) new_val,
+		    (long long unsigned int) old_val,
+		    (long long unsigned int) old_val);
 
-}	/* or1k_spr_command() */
-
-
-/*----------------------------------------------------------------------------*/
-/*!Main entry point for target architecture initialization
-
-   In this version initializes the architecture via
-   registers_gdbarch_init(). Add a command to set and show special purpose
-   registers. */
-/*---------------------------------------------------------------------------*/
+}
 
 extern initialize_file_ftype _initialize_or1k_tdep; /* -Wmissing-prototypes */
 
 void
 _initialize_or1k_tdep (void)
 {
-  /* Register this architecture. We should do this for or16 and or64 when
-     they have their BFD defined. */
+  /* Register this architecture.  */
   gdbarch_register (bfd_arch_or1k, or1k_gdbarch_init, or1k_dump_tdep);
 
   /* Tell remote stub that we support XML target description.  */
   register_remote_support_xml ("or1k");
 
-  /* Commands to show and set special purpose registers */
   add_info ("spr", or1k_info_spr_command,
 	    "Show the value of a special purpose register");
   add_com ("spr", class_support, or1k_spr_command,
 	   "Set a special purpose register");
 
-}	/* _initialize_or1k_tdep() */
+}
diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
index f0afc8f..a3c361d 100644
--- a/gdb/or1k-tdep.h
+++ b/gdb/or1k-tdep.h
@@ -1,9 +1,6 @@
 /* Definitions to target GDB to OpenRISC 1000 32-bit targets.
-
-   Copyright 2001 Free Software Foundation, Inc.
-   Copyright (C) 2008, 2010 Embecosm Limited
-
-   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+   Copyright (C) 2008-2016 Free Software Foundation, Inc.
+   Contributed by Jeremy Bennett <jeremy.bennett@embecosm.com>
 
    This file is part of GDB.
 
@@ -18,7 +15,7 @@
    more details.
 
    You should have received a copy of the GNU General Public License along
-   with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+   With this program.  If not, see <http://www.gnu.org/licenses/>.  */
 
 
 #ifndef OR1K_TDEP__H
@@ -28,24 +25,8 @@
 #define TARGET_OR1K
 #endif
 
-/*-----------------------------------------------------------------------------
-   This version for the OpenRISC 1000 architecture is a rewrite by Jeremy
-   Bennett of the old GDB 5.3 interface to make use of gdbarch for GDB 6.8.
-
-   The code tries to follow the GDB coding style. All OR1K specific globals
-   should have names beginning ork1_ or OR1K_.
-
-   Commenting is Doxygen compatible.
-
-   Much has been stripped out. See the files or1k-tdep.c, remote-or1k.c and
-   or1k-jtag.c for details of what has changed.
-   --------------------------------------------------------------------------*/
-
-
-/*! Byte array for the TRAP instruction used for breakpoints */
-#define OR1K_BRK_INSTR_STRUCT  {0x21, 0x00, 0x00, 0x01}
-/*! Numeric instruction used for a breakpoint */
-#define OR1K_BRK_INSTR 0x21000001
+#include "opcodes/or1k-desc.h"
+#include "opcodes/or1k-opc.h"
 
 /*! Numeric instruction used for a l.nop NOP_EXIT */
 #define  OR1K_NOP_EXIT 0x15000001
@@ -198,26 +179,6 @@
 /* Define absolute SPR values from group and index  */
 #define OR1K_SPR(group, index) (((group) << OR1K_SPG_SIZE_BITS) + (index))
 
-/* System group registers */
-#define OR1K_VR_SPRNUM       OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_VR)
-#define OR1K_UPR_SPRNUM      OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_UPR)
-#define OR1K_CPUCFGR_SPRNUM  OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_CPUCFGR)
-#define OR1K_DCFGR_SPRNUM    OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_DCFGR)
-#define OR1K_NPC_SPRNUM      OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_NPC)
-#define OR1K_SR_SPRNUM       OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_SR)
-#define OR1K_PPC_SPRNUM      OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_PPC)
-#define OR1K_EPCR_SPRNUM     OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_EPCR)
-
-/* Debug group registers */
-#define OR1K_DVR0_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DVR)
-#define OR1K_DCR0_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DCR)
-#define OR1K_DMR1_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DMR1)
-#define OR1K_DMR2_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DMR2)
-#define OR1K_DCWR0_SPRNUM    OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DCWR0)
-#define OR1K_DCWR1_SPRNUM    OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DCWR0)
-#define OR1K_DSR_SPRNUM      OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DSR)
-#define OR1K_DRR_SPRNUM      OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DRR)
-
 /* General Purpose Registers */
 #define OR1K_ZERO_REGNUM          0
 #define OR1K_SP_REGNUM            1
@@ -231,204 +192,20 @@
 #define OR1K_NPC_REGNUM          (OR1K_MAX_GPR_REGS + 1)
 #define OR1K_SR_REGNUM           (OR1K_MAX_GPR_REGS + 2)
 
-/* Defines for Debug Control Register bits */
-
-#define OR1K_DCR_DP        0x0000001    /* DVR/DCR Present */
-#define OR1K_DCR_CC        0x000000e    /* Compare condition */
-#define OR1K_DCR_CC_OFF            1    /* Compare condition offset */
-#define OR1K_DCR_SC        0x0000010    /* Signed compare */
-#define OR1K_DCR_CT        0x00000e0    /* Compare type */
-#define OR1K_DCR_CT_OFF            5    /* Compare type offset */
-
-/* Defines for Debug Mode Register 1 bits.  */
-#define OR1K_DMR1_CW       0x00000003   /* Mask for CW bits */
-#define OR1K_DMR1_CW_AND   0x00000001	/* Chain watchpoint 0 AND */
-#define OR1K_DMR1_CW_OR    0x00000002	/* Chain watchpoint 0 OR */
-#define OR1K_DMR1_CW_SZ             2   /* Number of bits for each WP */
-#define OR1K_DMR1_ST       0x00400000	/* Single-step trace */
-#define OR1K_DMR1_BT       0x00800000	/* Branch trace */
-
-/* Defines for Debug Mode Register 2 bits.  */
-#define OR1K_DMR2_WCE0       0x00000001	/* Watchpoint counter enable 0 */
-#define OR1K_DMR2_WCE1       0x00000002	/* Watchpoint counter enable 1 */
-#define OR1K_DMR2_AWTC_MASK  0x00000ffc	/* Assign watchpoints to ctr mask */
-#define OR1K_DMR2_WGB_MASK   0x003ff000	/* Watchpoints generaing brk mask */
-#define OR1K_DMR2_WBS_MASK   0xffc00000 /* Watchpoint brkpt status mask */
-#define OR1K_DMR2_AWTC_OFF    2		/* Assign watchpoints to ctr offset */
-#define OR1K_DMR2_WGB_OFF    12		/* Watchpoints generating brk offset */
-#define OR1K_DMR2_WBS_OFF    22		/* Watchpoint brkpt status offset */
-
-/* Defines for Debug Stop Register.  */
-#define OR1K_DSR_RSTE    0x00000001	/* Reset exception */
-#define OR1K_DSR_BUSEE   0x00000002	/* Bus error exception */
-#define OR1K_DSR_DPFE    0x00000004	/* Data page fault exception */
-#define OR1K_DSR_IPFE    0x00000008	/* Instrution page fault exception */
-#define OR1K_DSR_TTE     0x00000010	/* Tick timer exception */
-#define OR1K_DSR_AE      0x00000020	/* Alignment exception */
-#define OR1K_DSR_IIE     0x00000040	/* Illegal instruction exception */
-#define OR1K_DSR_INTE    0x00000080	/* Interrupt exception */
-#define OR1K_DSR_DME     0x00000100	/* DTLB miss exception */
-#define OR1K_DSR_IME     0x00000200	/* ITLB miss exception */
-#define OR1K_DSR_RE      0x00000400	/* Range exception */
-#define OR1K_DSR_SCE     0x00000800	/* System call exception */
-#define OR1K_DSR_FPE     0x00001000	/* Floating point exception */
-#define OR1K_DSR_TE      0x00002000	/* Trap exception */
-
-/* Defines for Debug Reason Register bits */
-#define OR1K_DRR_RSTE    0x00000001	/* Reset exception */
-#define OR1K_DRR_BUSEE   0x00000002	/* Bus error exception */
-#define OR1K_DRR_DPFE    0x00000004	/* Data page fault exception */
-#define OR1K_DRR_IPFE    0x00000008	/* Instrution page fault exception */
-#define OR1K_DRR_TTE     0x00000010	/* Tick timer exception */
-#define OR1K_DRR_AE      0x00000020	/* Alignment exception */
-#define OR1K_DRR_IIE     0x00000040	/* Illegal instruction exception */
-#define OR1K_DRR_INTE    0x00000080	/* Interrupt exception */
-#define OR1K_DRR_DME     0x00000100	/* DTLB miss exception */
-#define OR1K_DRR_IME     0x00000200	/* ITLB miss exception */
-#define OR1K_DRR_RE      0x00000400	/* Range exception */
-#define OR1K_DRR_SCE     0x00000800	/* System call exception */
-#define OR1K_DRR_FPE     0x00001000	/* Floating point exception */
-#define OR1K_DRR_TE      0x00002000	/* Trap exception */
-
-/* Bit definitions for the Unit Present Register */
-#define OR1K_SPR_UPR_UP	        0x00000001  /* UPR present */
-#define OR1K_SPR_UPR_DCP        0x00000002  /* Data cache present */
-#define OR1K_SPR_UPR_ICP        0x00000004  /* Instruction cache present */
-#define OR1K_SPR_UPR_DMP        0x00000008  /* Data MMU present */
-#define OR1K_SPR_UPR_IMP        0x00000010  /* Instruction MMU present */
-#define OR1K_SPR_UPR_MP         0x00000020  /* MAC present */
-#define OR1K_SPR_UPR_DUP        0x00000040  /* Debug unit present */
-#define OR1K_SPR_UPR_PCUP       0x00000080  /* Perf counters unit present */
-#define OR1K_SPR_UPR_PMP        0x00000100  /* Power management present */
-#define OR1K_SPR_UPR_PICP       0x00000200  /* PIC present */
-#define OR1K_SPR_UPR_TTP        0x00000400  /* Tick timer present */
-
-/* Bit definitions for the CPU Configuration Register */
-#define OR1K_SPR_CPUCFGR_NSGF   0x0000000f  /* Number of shadow GPR files */
-#define OR1K_SPR_CPUCFGR_CGF    0x00000010  /* Custom GPR file */
-#define OR1K_SPR_CPUCFGR_OB32S  0x00000020  /* ORBIS32 supported */
-#define OR1K_SPR_CPUCFGR_OB64S  0x00000040  /* ORBIS64 supported */
-#define OR1K_SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
-#define OR1K_SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
-#define OR1K_SPR_CPUCFGR_OV64S  0x00000400  /* ORVDX64 supported */
-
-/* Bit definitions for the Debug configuration register */
-#define OR1K_SPR_DCFGR_NDP      0x00000007  /* Number of matchpoints */
-#define OR1K_SPR_DCFGR_WPCI     0x00000008  /* Watchpoint ctrs implemented */
-
 /* Properties of the architecture. GDB mapping of registers is all the GPRs
    and SPRs followed by the PPC, NPC and SR@the end. Red zone is the area
-   past the end of the stack reserved for exception handlers etc. */
+   past the end of the stack reserved for exception handlers etc.  */
+
 #define OR1K_MAX_GPR_REGS            32
 #define OR1K_MAX_SPR_REGS           (32 * 2048)
 #define OR1K_NUM_PSEUDO_REGS         0
 #define OR1K_NUM_REGS_CACHED        (OR1K_MAX_GPR_REGS + 3)
 #define OR1K_NUM_REGS               (OR1K_NUM_REGS_CACHED + OR1K_MAX_SPR_REGS)
 #define OR1K_TOTAL_NUM_REGS         (OR1K_NUM_REGS + OR1K_NUM_PSEUDO_REGS)
-#define OR1K_MAX_MATCHPOINTS         8
-#define OR1K_MAX_HW_WATCHES          OR1K_MAX_MATCHPOINTS
 #define OR1K_STACK_ALIGN             4
 #define OR1K_INSTLEN                 4
 #define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
 #define OR1K_NUM_TAP_RECORDS         8
 #define OR1K_FRAME_RED_ZONE_SIZE     2536
 
-/* OR1K exception vectors */
-
-#define OR1K_RESET_VECTOR   0x100
-#define OR1K_BUSERR_VECTOR  0x200
-#define OR1K_DPF_VECTOR     0x300
-#define OR1K_IPF_VECTOR     0x400
-#define OR1K_TT_VECTOR      0x500
-#define OR1K_ALIGN_VECTOR   0x600
-#define OR1K_ILL_VECTOR     0x700
-#define OR1K_EXT_VECTOR     0x800
-#define OR1K_DTLB_VECTOR    0x900
-#define OR1K_ITLB_VECTOR    0xa00
-#define OR1K_RANGE_VECTOR   0xb00
-#define OR1K_SYS_VECTOR     0xc00
-#define OR1K_FP_VECTOR      0xd00
-#define OR1K_TRAP_VECTOR    0xe00
-
-/* Constants and macros to break out instruction fields. I'd expect these in
-   the assembler header, but they aren't there (for now). */
-
-#define OR1K_SEXT16(v) (((v) & 0x00008000) ? ((v) - 0x00010000) : (v))
-#define OR1K_SEXT26(v) (((v) & 0x02000000) ? ((v) - 0x04000000) : (v))
-
-#define OR1K_OPCODE1(i)  (((i) & 0xfc000000) >> 26)
-#define OR1K_OPCODE2(i) ((((i) & 0xfc000000) >> 20) | \
-			 (((i) & 0x00000300) >>  6) | \
-			  ((i) & 0x0000000f))
-#define OR1K_OPCODE3(i) ((((i) & 0xfc000000) >> 24) | \
-			 (((i) & 0x000000c0) >> 6))
-#define OR1K_OPCODE4(i) ((((i) & 0xfc000000) >> 18) | \
-			 (((i) & 0x000003c0) >>  2) | \
-			  ((i) & 0x0000000f))
-#define OR1K_OPCODE5(i)  (((i) & 0xffff0000) >> 16)
-#define OR1K_OPCODE6(i)  (((i) & 0xff000000) >> 24)
-#define OR1K_OPCODE7(i)  (((i) & 0xfc000000) >> 21)
-#define OR1K_D_REG(i)    (((i) & 0x03e00000) >> 21)
-#define OR1K_A_REG(i)    (((i) & 0x001f0000) >> 16)
-#define OR1K_B_REG(i)    (((i) & 0x0000f800) >> 11)
-#define OR1K_IMM(i)      (OR1K_SEXT16((i) & 0x0000ffff))
-#define OR1K_IMM2(i)     (OR1K_SEXT16((((i) & 0x03e00000) >> 10) |	\
-				       ((i) & 0x000003ff)))
-#define OR1K_OFFSET(i)    (OR1K_SEXT26((i) & 0x03ffffff) ))
-#define OR1K_SHIFT(i)     ((i) & 0x0000003f)
-
-/* The instruction opcodes */
-
-#define OR1K_OP_ADD     0xe00	/* Type 2 */
-#define OR1K_OP_ADDC    0xe01	/* Type 2 */
-#define OR1K_OP_ADDI     0x27	/* Type 1 */
-#define OR1K_OP_AND     0xe03	/* Type 2 */
-#define OR1K_OP_ANDI     0x29	/* Type 1 */
-#define OR1K_OP_BF       0x04	/* Type 1 */
-#define OR1K_OP_BNF      0x03	/* Type 1 */
-#define OR1K_OP_TRAP   0x2100	/* Type 5 */
-#define OR1K_OP_J        0x00	/* Type 1 */
-#define OR1K_OP_JAL      0x01	/* Type 1 */
-#define OR1K_OP_JALR     0x12	/* Type 1 */
-#define OR1K_OP_JR       0x11	/* Type 1 */
-#define OR1K_OP_LBS      0x24   /* Type 1 */
-#define OR1K_OP_LBZ      0x23   /* Type 1 */
-#define OR1K_OP_LHS      0x26   /* Type 1 */
-#define OR1K_OP_LHZ      0x25   /* Type 1 */
-#define OR1K_OP_LWS      0x22   /* Type 1 */
-#define OR1K_OP_LWZ      0x21   /* Type 1 */
-#define OR1K_OP_MFSPR    0x07   /* Type 1 */
-#define OR1K_OP_MOVHI    0x06   /* Type 1 */
-#define OR1K_OP_MTSPR    0x10   /* Type 1 */
-#define OR1K_OP_MUL     0xe36   /* Type 2 */
-#define OR1K_OP_MULI     0x2c   /* Type 1 */
-#define OR1K_OP_MULU    0xe3b   /* Type 2 */
-#define OR1K_OP_NOP      0x15   /* Type 6 */
-#define OR1K_OP_OR      0xe04	/* Type 2 */
-#define OR1K_OP_ORI      0x2a   /* Type 1 */
-#define OR1K_OP_RFE      0x09   /* Type 1 */
-#define OR1K_OP_RORI     0xe3   /* Type 3 */
-#define OR1K_OP_SB       0x36   /* Type 1 */
-#define OR1K_OP_SFEQ    0x720   /* Type 7 */
-#define OR1K_OP_SFGES   0x72b   /* Type 7 */
-#define OR1K_OP_SFGEU   0x723   /* Type 7 */
-#define OR1K_OP_SFGTS   0x72a   /* Type 7 */
-#define OR1K_OP_SFGTU   0x722   /* Type 7 */
-#define OR1K_OP_SFLES   0x72d   /* Type 7 */
-#define OR1K_OP_SFLEU   0x725   /* Type 7 */
-#define OR1K_OP_SFLTS   0x72c   /* Type 7 */
-#define OR1K_OP_SFLTU   0x724   /* Type 7 */
-#define OR1K_OP_SFNE    0x721   /* Type 7 */
-#define OR1K_OP_SLL    0x3808   /* Type 4 */
-#define OR1K_OP_SLLI     0xe0   /* Type 3 */
-#define OR1K_OP_SRA    0x3828   /* Type 4 */
-#define OR1K_OP_SRAI     0xe2   /* Type 3 */
-#define OR1K_OP_SRL    0x3818   /* Type 4 */
-#define OR1K_OP_SRLI     0xe1   /* Type 3 */
-#define OR1K_OP_SUB     0xe02   /* Type 2 */
-#define OR1K_OP_SW       0x35   /* Type 1 */
-#define OR1K_OP_SYS    0x2000   /* Type 5 */
-#define OR1K_OP_XOR     0xe05   /* Type 2 */
-#define OR1K_OP_XORI     0x2b   /* Type 1 */
-
 #endif /* OR1K_TDEP__H */
-- 
2.7.4


