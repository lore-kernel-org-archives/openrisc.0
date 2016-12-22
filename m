From: Stafford Horne <shorne@gmail.com>
Date: Fri, 23 Dec 2016 01:11:29 +0900
Subject: [OpenRISC] [PATCH v2 2/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <20161129100603.GE22209@E107787-LIN>
References: <cover.1480216015.git.shorne@gmail.com>
 <f6acbadf23ddacc9c5b335a2de3b2919793f96af.1480216015.git.shorne@gmail.com>
 <20161129100603.GE22209@E107787-LIN>
Message-ID: <20161222161129.GK2650@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Yao,

On Tue, Nov 29, 2016 at 10:06:03AM +0000, Yao Qi wrote:
> On Sun, Nov 27, 2016 at 03:16:44PM +0900, Stafford Horne wrote:
> > From: Franck Jullien <franck.jullien@gmail.com>
> > 
> > This patch prepates the current GDB port of the openrisc processor from
> > https://github.com/openrisc/binutils-gdb for upstream merging.
> > 
> > Testing has been done with a cgen sim provided in a separate patch. This
> > has been tested with 2 toolchains. GCC [1] 5.4.0 from the openrisc
> > project with Newlib [2] and GCC 5.4.0 with Musl [3] 1.1.4.
> > 
> > It supports or1knd (no delay slot target).
> > The default target is or1k (with delay slot).
> > 
> > You can change the target arch with:
> > 
> > (gdb) set architecture or1knd
> > The target architecture is assumed to be or1knd
> > 
> > [1] https://github.com/openrisc/or1k-gcc
> > [2] https://github.com/openrisc/newlib
> > [3] https://github.com/openrisc/musl-cross
> 
> Hi Stafford,
> The code style in or1k-tdep.{c,h} is completely different from GNU
> coding standard.  Take a look at
> https://sourceware.org/gdb/wiki/ContributionChecklist and please
> also reference other new added ports about code style, like
> nios2-tdep.c.

I have taken a look at it.  I have done my best to get everything fixed
up, comments indentation etc. I will send a V3 patch shortly.
 
> > 
> > gdb/doc/ChangeLog:
> > 
> > 2016-03-13  Stefan Wallentowitz  <stefan@wallentowitz.de>
> > 
> > 	* gdb.texinfo (Embedded Processors): Add openrisc to suppress error.
> > 
> > 2013-01-31  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	* gdb.texinfo: Add / merge OpenRISC documentation from old svn.
> > 
> > 2008-08-13  Jeremy Bennett  <jeremy.bennett@embecosm.com>
> > 
> > 	* gdb.texinfo: Sections relating to OpenRISC 1000 rewritten
> > 
> > gdb/ChangeLog:
> > 
> > 2016-11-23  Stafford Horne  <shorne@gmail.com>
> > 
> > 	Updates after Yao Qi's breakpoint refactor.
> > 	* or1k-tdep.c (or1k_breakpoint_kind_from_pc): New function.
> > 	(or1k_sw_breakpoint_from_kind): New function.
> > 	(or1k_breakpoint_from_pc): Remove.
> > 	(or1k_gdbarch_init): Use new functions.
> > 
> > 2016-11-23  Stafford Horne  <shorne@gmail.com>
> > 
> > 	Corelow is no longer needed for or1k as its in by default.
> > 	* configure.tgt: Remove corelow.o for or1k linux.
> > 
> > 2016-11-16  Stafford Horne  <shorne@gmail.com>
> > 
> > 	Updates after rebase to upstream master.
> > 	* or1k-tdep.c (or1k_fetch_instruction): Dont pass status
> > 	directly to memory_error as they are different types.
> > 	(or1k_pseudo_register_read): Return proper typed REG_UNKNOWN.
> > 	(or1k_frame_cache): Cast result to trad_frame_cache.
> > 	(or1k_gdbarch_init): Init gdbarch_tdep with XNEW.
> > 
> > 2016-05-22  Stafford Horne  <shorne@gmail.com>
> > 
> > 	Upstream merge fixes.
> > 	* or1k-tdep.c (or1k_return_value): Fix return conventions
> > 	handling of arrays and literals to match gcc.
> > 	(or1k_push_dummy_call): Properly handle vararg dummy args by
> > 	pushing a pointer to args as per conventions.
> > 
> > 2016-03-13  Stefan Wallentowitz  <stefan@wallentowitz.de>
> > 
> > 	Upstream merge fixes.
> > 	* or1k-tdep.c (or1k_analyse_inst): Change fatal to throw_quit.
> > 	(or1k_skip_prologue): Use SYMTAB_COMPUNIT and
> > 	COMPUNIT_DEBUGFORMAT.
> > 	(or1k_frame_cache): Change fatal to throw_quit.
> > 	(or1k_regset_from_core_section): Remove.
> > 	(or1k_iterate_over_regset_sections): Create, blank
> > 	implementation.
> > 
> > 2013-10-01  Stefan Kristiansson  <stefan.kristiansson@saunalahti.fi>
> > 
> > 	Upstream merge fixes.
> > 	* or1k-tdep.c (or1k_fetch_instruction): Change char to gdb_byte
> > 	to prevent pointer signedness error.
> > 	(or1k_push_dummy_code): Likewise.
> > 
> > 2013-03-15  Stefan Kristiansson  <stefan.kristiansson@saunalahti.fi>
> > 
> > 	* or1k-tdep.c (or1k_regset_firom_core_section) : Silence gcc
> > 	warning by using %z format for size_t.
> > 
> > 2013-02-22  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	* or1k-tdep.c (or1k_push_dummy_code) : Use or1k_frame_align to
> > 	align the stack pointer.
> > 
> > 2013-02-17  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	Add target descriptor support.
> > 	* or1k-tdep.c (or1k_register_name): Conditionally pull register
> > 	names from tdesc_register_name if we can.
> > 	(or1k_registers_info): Fetch register via target_fetch_registers
> > 	if it is not cached.
> > 	(or1k_register_reggroup_p): Check register groups in target
> > 	descriptor before falling back to default reg groups.
> > 	(create_register_group): New Function.
> > 	(get_feature_registers): New Function.
> > 	(or1k_gdbarch_init): Init the register details from target_desc.
> > 	(_initialize_or1k_tdep): Tell remote we support target
> > 	description xml.
> > 
> > 2013-02-16  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	* or1k-tdep.c: Use OR1K_NUM_REGS_CACHED.
> > 	* or1k-tdep.h: Add OR1K_NUM_REGS_CACHED.
> > 	Add OR1K_MAX_SPR_REGS.
> > 
> > 2013-02-14  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	* or1k-tdep.c (or1k_push_dummy_code): New function.
> > 	(or1k_gdbarch_init): Override default behavior and call dummy
> > 	from the stack. Set the push_dummy_code handler to
> > 	or1k_push_dummy_code.
> > 
> > 2013-02-13  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	* or1k-tdep.c (or1k_skip_prologue): Add a check for NULL
> > 	pointer while comparing debugformat to "dwarf".
> > 
> > 2013-01-31  Franck Jullien  <franck.jullien@gmail.com>
> > 
> > 	* or1k-tdesc.c  : Add file for or1k support from old svn
> > 	* or1k-tdesc.h  : Add file for or1k support from old svn
> > 	* configure.tgt : Add or1k targets from old svn
> > 
> > 2010-06-30  Jeremy Bennett  <jeremy.bennett@embecosm.com>
> > 
> > 	* or1k-tdep.c (or1k_fetch_instruction): Logic flow made clearer.
> > 	(or1k_analyse_inst, or1k_analyse_L_addi)
> > 	(or1k_analyse_l_sw): Added.
> > 	(or1k_frame_size, or1k_frame_fp_loc, or1k_frame_size_check)
> > 	(or1k_link_address, or1k_get_saved_reg): Removed.
> > 	(or1k_skip_prologue, or1k_frame_unwind_cache): Rewritten to use
> > 	or1k_analyse_inst functions.
> > 	* or1k_tdep.h <OR1K_FIRST_SAVED_REGNUM, OR1K_INSTBITLEN>: #define
> > 	added.
> > 
> > 2008-11-08  Jeremy Bennett  <jeremy.bennett@embecosm.com>
> > 
> > 	* or1k-tdep.c (or1k_read_spr, or1k_write_spr): Moved here from
> > 	remote-or1k.c and made local to this file. Rewritten to use
> > 	commands via the target remote command (to_rcmd) function.
> > 	* or1k-tdep.c (or1k_spr_command). Invalidates register cache when
> > 	SPR is written.
> > 	* or1k-tdep.h: or1k_read_spr and Or1k_write_spr are removed as
> > 	global functions.
> > 	* or1k-tdep.c (or1k_read_spr, or1k_write_spr). Functions removed
> > 	and made local to or1k-tdep.c. All or1k-tdep.c references to these
> > 	functions changed to use or1k_jtag_read_spr and
> > 	or1k_jtag_write_spr (for which these were only wrappers).
> > 	* or1k-tdep.c (or1k_rcmd): Function added to process SPR access
> > 	requests.
> > 
> > 2008-10-23  Jeremy Bennett  <jeremy.bennett@embecosm.com>
> > 
> > 	* or1k-tdep.h, or1k-tdep.c: Extend the number of registers to
> > 	include the PPC as well as the NPC
> > 
> > 2008-07-30  Jeremy Bennett  <jeremy.bennett@embecosm.com>
> > 
> > 	* or1k-tdep.c: New file, based on the OpenCores 5.3 port
> > 	* or1k-tdep.h: New file, based on the OpenCores 5.3 port
> > 	* configure.tgt: Updated description of OpenRISC 1000 files
> 
> Please merge all ChangeLog entries into one, but with all contributors
> listed as author.
> 
> >  
> > +or1k-*-linux*)
> > +	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux
> > +	gdb_target_obs="or1k-tdep.o"
> > +	gdb_sim=../sim/or1k/libsim.a
> > +	build_gdbserver=yes
> > +	;;
> 
> build_gdbserver=no?  We don't have OpenRISC GDBserver yet.  Secondly, we
> don't have or1k-linux-tdep.c, so I don't think or1k-*-linux target is
> supported.  Let us remove it...

Correct, I have removed these now until we have patches for gdbserver
and linux ready. No ETA on that though.
 
> > +
> > +or1k-*-*)
> > +	# Target: OpenCores OpenRISC 1000 32-bit implementation bare metal
> > +	gdb_target_obs="or1k-tdep.o"
> > +	gdb_sim=../sim/or1k/libsim.a
> > +	;;
> > +
> > +or1knd-*-linux*)
> > +	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux, without delay slot
> > +	gdb_target_obs="or1k-tdep.o"
> > +	gdb_sim=../sim/or1k/libsim.a
> > +	build_gdbserver=yes
> > +	;;
> 
> Likewise, let us remove it.

Done.

> > diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
> > new file mode 100644
> > index 0000000..3592ac9
> > --- /dev/null
> > +++ b/gdb/or1k-tdep.c
> > @@ -0,0 +1,3285 @@
> > +/* Target-dependent code for the 32-bit OpenRISC 1000, for the GNU Debugger.
> > +
> > +   Copyright 1988-2008, Free Software Foundation, Inc.
> > +   Copyright (C) 2008, 2010 Embecosm Limited
> 
> If the patch is contributed to FSF project, FSF should be the copyright
> owner.  All the contributors should agree on this.

I have fixed. This has been agreed with Jeremy.

> > +
> > +   Contributed by Alessandro Forin(af at cs.cmu.edu at CMU
> > +   and by Per Bothner(bothner at cs.wisc.edu) at U.Wisconsin.
> > +
> > +   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
> > +
> > +   Contributor Franck Jullien <elec4fun@gmail.com>
> > +
> 
> Franck doesn't have FSF copyright assignment.

Franck has signed over his copyright to Embecosm. The notice will be
changed to reflect that.  If that is an issue Franck can help.

> > +/*-----------------------------------------------------------------------------
> > +   This version for the OpenRISC 1000 architecture is a rewrite by Jeremy
> > +   Bennett of the old GDB 5.3 interface to make use of gdbarch for GDB 6.8. It
> > +   has since been updated for GDB 7.2 and GDB 7.5.
> 
> Once we add or1k-tdep.c into GDB mainline, these notes are not useful
> anymore.

Removed.

> > +
> > +   The code tries to follow the GDB coding style.
> > +
> > +   Commenting is Doxygen compatible.
> 
> We don't write comments in Doxygen style.

Those have all, hopefully, been removed.

> > +
> > +   Notes on the GDB 7.5 version
> > +   ============================
> > +
> > +   This version is just an upgrade of the previous port. It does use CGEN
> > +   for instruction lookup in or1k_single_step_through_delay as the new toolchain
> > +   is CGEN based.
> > +
> > +   This version is compatible with or1knd target (no delay slot version of the
> > +   toolchain). We check in bfd_arch_info if the mach is bfd_mach_or1k or
> > +   bfd_mach_or1knd to choose if or1k_single_step_through_delay must be
> > +   implemented.
> > +
> > +   Notes on the GDB 7.2 version
> > +   ============================
> > +
> > +   The primary change is to support the new GCC 4.5.1 compiler, which no
> > +   longer adds preceding underscores to global values and uses DWARF2 as its
> > +   default debug format.
> > +
> > +   This version now supports Or1ksim integrated as a simulator library, so
> > +   "target sim" will work. It does require Or1ksim to be available as a
> > +   library at configuration time, with the Or1ksim installation directory
> > +   specified by the argument --with-or1ksim.
> > +
> > +   The ad-hoc prologue analysis, which was always a weak point has been
> > +   stripped out and replaced with code based on the generic approach in
> > +   prologue-value.c and prologue-value.h.
> > +
> > +   The objective with this version is to get reasonable results on regression
> > +   testing. Something the older versions never achieved.
> > +
> > +   Notes on the GDB 6.8 version
> > +   ============================
> > +
> > +   Much has been stripped out in the interests of getting a basic working
> > +   system. This is described as the OpenRISC 1000 target architecture, so
> > +   should work with 32 and 64 bit versions of that architecture and should
> > +   work whether or not they have floating point and/or vector registers,
> > +   although to date it has only been tested with the 32-bit integer
> > +   archtiecture.
> > +
> > +   The info trace command has been removed. The meaning of this is not clear -
> > +   it relies on a value in register 255 of the debug group, which is
> > +   undocumented.
> > +
> > +   All the hardware trace has been removed for the time being. The new debug
> > +   interface does not support hardware trace, so there is no plan to reinstate
> > +   this functionality.
> > +
> > +   Support for multiple contexts (which was rudimentary, and not working) has
> > +   been removed.*/
> > +/*---------------------------------------------------------------------------*/
> > +
> 
> These comments/notes are not useful.  Please remove it.

OK.
 
> > +

> > +
> > +/* Enum describing different kinds of breakpoints for or1k */
> > +
> > +enum or1k_breakpoint_kind
> > +{
> > +  /* 32-bit standard OpenRISC breakpoint */
> > +  OR1K_BP_KIND_OR1K = 2,
> > +};
> > +
> > +/* The gdbarch_tdep structure.  */
> > +
> > +/*! OR1K specific per-architecture information. Replaces
> > +    struct_or1k_implementation. A lot of this info comes from the config regs,
> > +    so cannot be put in place until we have the actual target. Up until then
> > +    we have reasonable defaults. */
> > +struct gdbarch_tdep
> > +{
> > +  unsigned int  num_matchpoints;	/* Total matchpoints available. */
> 
> num_matchpoints is not used in this patch.  Can we remove it?

Removed, I think this was previously used for hardware watchpoints.  We
now use software breakpoints. (trap instruction written to memory)

> > +  unsigned int  num_gpr_regs;		/* Number of general registers.  */
> 
> It is an invariant, OR1K_MAX_GPR_REGS.  We can use the macro directly.

Using the const everywhere now, Removed.

> > +  int           bytes_per_word;
> > +  int           bytes_per_address;
> 
> These two fields can be calculated from gdbarch_bfd_arch_info,
> 
> (gdbarch_bfd_arch_info (gdbarch)->bits_per_word
>           / gdbarch_bfd_arch_info (gdbarch)->bits_per_byte)
> 
> so, these fields are not needed.

Agreed, removed.

> > +  CGEN_CPU_DESC gdb_cgen_cpu_desc;
> > +};
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Determine the return convention used for a given type
> > +
> > +   Optionally, fetch or set the return value via "readbuf" or "writebuf"
> > +   respectively using "regcache" for the register values.
> > +
> > +   The OpenRISC 1000 returns scalar values via R11 and (for 64 bit values on
> > +   32 bit architectures) R12. Structs and unions are returned by reference,
> > +   with the address in R11
> > +
> > +   The result returned is independent of the function type, so we ignore that.
> > +
> > +   Throughout use read_memory(), not target_read_memory(), since the address
> > +   may be invalid and we want an error reported (read_memory() is
> > +   target_read_memory() with error reporting).
> > +
> > +   @todo This implementation is labelled OR1K, but in fact is just for the 32
> > +         bit version, OR1K. This should be made explicit
> > +
> > +   @param[in]  gdbarch   The GDB architecture being used
> > +   @param[in]  functype  The type of the function to be called (may be NULL)
> > +   @param[in]  valtype   The type of the entity to be returned
> > +   @param[in]  regcache  The register cache
> > +   @param[in]  readbuf   Buffer into which the return value should be written
> > +   @param[out] writebuf  Buffer from which the return value should be written
> > +
> > +   @return  The type of return value */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static enum return_value_convention
> > +or1k_return_value (struct gdbarch  *gdbarch,
> > +		   struct value    *functype,
> > +		   struct type     *valtype,
> > +		   struct regcache *regcache,
> > +		   gdb_byte        *readbuf,
> > +		   const gdb_byte  *writebuf)
> 
> 
> We don't document gdbarch method this way.  Instead, we document this
> way,

Made changes.

> /* Implement the return_value gdbarch method.  */
> 
> > +{
> > +  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
> > +  enum type_code  rv_type    = TYPE_CODE (valtype);
> > +  unsigned int    rv_size    = TYPE_LENGTH (valtype);
> > +  unsigned int    bpw        = (gdbarch_tdep (gdbarch))->bytes_per_word;
> > +
> > +  /* Deal with struct/union as addresses. If an array won't fit in a single
> > +     register it is returned as address. Anything larger than 2 registers needs
> > +     to also be passed as address (this is from gcc default_return_in_memory) */
> 
> There should be two spaces after ".".  The comments ends with "." and
> two spaces.

All should be gnu style now.

> > +  if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type) ||
> > +      ((TYPE_CODE_ARRAY == rv_type) && rv_size > bpw) ||
> > +      (rv_size > 2*bpw))
> 
> 
>      if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type)
>          || ((TYPE_CODE_ARRAY == rv_type) && rv_size > bpw)
>          || (rv_size > 2 * bpw))
> 
> Please take a look at GNU coding standard,
> https://www.gnu.org/prep/standards/standards.html#Writing-C

These should be fixed now.

> > +    {
> > +      if (readbuf)
> > +	{
> > +	  ULONGEST        tmp;
> 
> "ULONGEST tmp;?", only one space between type and variable name.

Yes, those should be cleaned up now.
 
> > +
> > +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
> > +	  read_memory (tmp, readbuf, rv_size);
> > +	}
> > +      if (writebuf)
> > +	{
> > +	  ULONGEST        tmp;
> > +
> > +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
> > +	  write_memory (tmp, writebuf, rv_size);
> > +	}
> > +
> > +      return RETURN_VALUE_ABI_RETURNS_ADDRESS;
> > +    }
> > +
> > +  if (rv_size <= bpw)
> > +    {
> > +      /* up to one word scalars are returned in R11 */
> > +      if (readbuf)
> 
> Check to NULL explicitly, "if (readbuf != NULL)"

This is fixed.
 
> > +	{
> > +	  ULONGEST        tmp;
> > +
> > +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
> > +	  store_unsigned_integer (readbuf, rv_size, byte_order, tmp);
> > +
> > +	}
> > +      if (writebuf)
> > +	{
> > +	  gdb_byte buf[4];			/* TODO - fixed const! */
> 
> Fix this TODO?

I have just removed the todo, 4 bytes seems to be hard coded in other
targets like nios-tdep.c. I guess most people will know and we dont have
64-bit yet.

> > +	  memset (buf, 0, sizeof (buf));	/* Zero pad if < bpw bytes */
> > +
> > +	  if (BFD_ENDIAN_BIG == byte_order)
> > +	    {
> > +	      memcpy (buf + sizeof (buf) - rv_size, writebuf, rv_size);
> > +	    }
> > +	  else
> > +	    {
> > +	      memcpy (buf,                          writebuf, rv_size);
> > +	    }
> > +
> > +	  regcache_cooked_write (regcache, OR1K_RV_REGNUM, buf);
> > +	}
> > +    }
> > +/*----------------------------------------------------------------------------*/
> > +/*!Determine the kind of breakpoint based on the current pc
> > +
> > +   Given the pc address, return the type of breapoint that should be used.
> > +   For or1k we only use one type which is a 32-bit trap instruction.
> > +
> > +   @param[in]  gdbarch  The GDB architecture being used
> > +   @param[in]  pcptr    The program counter address in question
> > +
> > +   @return  The breakpoint type */
> > +/*----------------------------------------------------------------------------*/
> > +
> 
> Again, we don't document gdbarch method this way.

Yes.

> > +static int
> > +or1k_breakpoint_kind_from_pc (struct gdbarch *gdbarch, CORE_ADDR *pcptr)
> > +{
> > +  return OR1K_BP_KIND_OR1K;
> > +}	/* or1k_breakpoint_kind_from_pc() */
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Determine the instruction to use for a breakpoint.
> > +
> > +   Given the address at which to insert a breakpoint (bp_addr), what will
> > +   that breakpoint be?
> > +
> > +   For or1k, we have a breakpoint instruction. Since all or1k instructions
> > +   are 32 bits, this is all we need, regardless of address.
> > +
> > +   @param[in]  gdbarch	The GDB architecture being used
> > +   @param[in]  kind	The kind of breakpoint to be returned
> > +   @param[out] size	The size of instruction selected
> > +
> > +   @return  The chosen breakpoint instruction */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static const gdb_byte *
> > +or1k_sw_breakpoint_from_kind (struct gdbarch *gdbarch, int kind, int *size)
> > +{
> > +
> > +  switch (kind)
> > +    {
> > +    case OR1K_BP_KIND_OR1K:
> > +      {
> > +        static const gdb_byte breakpoint[] = OR1K_BRK_INSTR_STRUCT;
> > +        
> > +        *size = OR1K_INSTLEN;
> > +        return breakpoint;
> > +      }
> > +    default:
> > +      gdb_assert_not_reached ("unexpected or1k breakpoint kind");
> > +    };
> > +}	/* or1k_sw_breakpoint_from_kind() */
> 
> or1k only has one breakpoint, so we can do something simpler.  Take a
> look at i386-tdep.c,
> 
> constexpr gdb_byte i386_break_insn[] = { 0xcc }; /* int 3 */
> 
> typedef BP_MANIPULATION (i386_break_insn) i386_breakpoint;

Right, using BP_MANIPULATION now.
 
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Read a pseudo register
> > +
> > +   Since we have no pseudo registers this is a null function for now.
> > +
> > +   @todo The floating point and vector registers ought to be done as
> > +         pseudo-registers.
> > +
> > +   @param[in]  gdbarch   The GDB architecture to consider
> > +   @param[in]  regcache  The cached register values as an array
> > +   @param[in]  regnum    The register to read
> > +   @param[out] buf       A buffer to put the result in */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static enum register_status
> > +or1k_pseudo_register_read (struct gdbarch  *gdbarch,
> > +			   struct regcache *regcache,
> > +			   int              regnum,
> > +			   gdb_byte        *buf)
> > +{
> > +  return REG_UNKNOWN;
> 
> Is it expected?

Removed pseudo's now.  There needs to be some discussion on what we want
to name the registers i.e. v1,v2 for vectors or f1,f2... for floats?

We can implement later.
 
> > +}	/* or1k_pseudo_register_read() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Write a pseudo register
> > +
> > +   Since we have no pseudo registers this is a null function for now.
> > +
> > +   @todo The floating point and vector registers ought to be done as
> > +         pseudo-registers.
> > +
> > +   @param[in] gdbarch   The GDB architecture to consider
> > +   @param[in] regcache  The cached register values as an array
> > +   @param[in] regnum    The register to read
> > +   @param[in] buf       A buffer with the value to write */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static void
> > +or1k_pseudo_register_write (struct gdbarch  *gdbarch,
> > +			    struct regcache *regcache,
> > +			    int              regnum,
> > +			    const gdb_byte  *buf)
> > +{
> > +  return;
> 
> Likewise.

Removed as well.

> > +
> > +}	/* or1k_pseudo_register_write() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Return the register name for the OpenRISC 1000 architecture
> > +
> > +   This version converted to ANSI C, made static and incorporates the static
> > +   table of register names (this is the only place it is referenced).
> > +
> > +   @todo The floating point and vector registers ought to be done as
> > +         pseudo-registers.
> 
> We need to fix it....

As mentioned above pseudos can come later.

> > +
> > +   @param[in] gdbarch  The GDB architecture being used
> > +   @param[in] regnum    The register number
> > +
> > +   @return  The textual name of the register */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static const char *
> > +or1k_register_name (struct gdbarch *gdbarch,
> > +		    int             regnum)
> > +{
> > +  static char *or1k_gdb_reg_names[OR1K_NUM_REGS_CACHED] =
> > +    {
> > +      /* general purpose registers */
> > +      "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> > +      "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> > +      "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> > +      "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> > +
> > +      /* previous program counter, next program counter and status register */
> 
> Comment is a sentence, should be ended with ".", and two spaces after
> it.  Many instances of this problem.

All should be fixed now.

> > +      "ppc",   "npc",   "sr"
> > +
> > +      /* Floating point and vector registers may appear as pseudo registers in
> > +	 the future. */
> > +    };
> > +
> > +  /* If we have a target description, use it */
> > +  if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
> > +    return tdesc_register_name (gdbarch, regnum);
> > +  else
> > +    {
> > +      if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
> > +	{
> > +	  return or1k_gdb_reg_names[regnum];
> > +	}
> > +      else
> > +	return NULL;
> > +    }
> > +
> > +}	/* or1k_register_name() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Identify the type of a register
> > +
> > +   @todo I don't fully understand exactly what this does, but I think this
> > +         makes sense!

No comment here from you, but this has been reviewed.
 
> > +
> > +   @param[in] arch     The GDB architecture to consider
> > +   @param[in] regnum   The register to identify
> > +
> > +   @return  The type of the register */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static struct type *
> > +or1k_register_type (struct gdbarch *arch,
> > +		    int             regnum)
> > +{
> > +  static struct type *void_func_ptr = NULL;
> > +  static struct type *void_ptr      = NULL;
> > +
> > +  /* Set up the static pointers once, the first time*/
> > +  if (NULL == void_func_ptr)
> > +    {
> > +      struct type *void_type = builtin_type (arch)->builtin_void;
> > +
> > +      void_ptr      = lookup_pointer_type (void_type);
> > +      void_func_ptr = lookup_pointer_type (lookup_function_type (void_type));
> 
> Why don't you use builtin_type (gdbarch)->builtin_data_ptr and
> builtin_type (gdbarch)->builtin_func_ptr?

Yes, using builtins now and not using these 'static' 'caches'.

> > +    }
> > +
> > +  if((regnum >= 0) && (regnum < OR1K_TOTAL_NUM_REGS))
> > +    {
> > +      switch (regnum)
> > +	{
> > +	case OR1K_PPC_REGNUM:
> > +	case OR1K_NPC_REGNUM:
> > +	  return void_func_ptr;			/* Pointer to code */
> > +
> > +	case OR1K_SP_REGNUM:
> > +	case OR1K_FP_REGNUM:
> > +	  return void_ptr;				/* Pointer to data */
> > +
> > +	default:
> > +	  return builtin_type (arch)->builtin_uint32;	/* Data */
> > +	}
> > +    }
> > +
> > +  internal_error (__FILE__, __LINE__,
> > +		  _("or1k_register_type: illegal register number %d"), regnum);
> > +
> > +}	/* or1k_register_type() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Handle the "info register" command
> > +
> > +   Print the identified register, unless it is -1, in which case print all
> > +   the registers. If all is 1 means all registers, otherwise only the core
> > +   GPRs.
> > +
> > +   @todo At present all registers are printed with the default method. Should
> > +         there be something special for FP registers?
> > +
> > +   @param[in] gdbarch  The GDB architecture being used
> > +   @param[in] file     File handle for use with any custom I/O
> > +   @param[in] frame    Frame info for use with custom output
> > +   @param[in] regnum   Register of interest, or -1 if all registers
> > +   @param[in] all      1 if all means all, 0 if all means just GPRs
> > +
> > +   @return  The aligned stack frame address */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static void
> > +or1k_registers_info (struct gdbarch    *gdbarch,
> > +		     struct ui_file    *file,
> > +		     struct frame_info *frame,
> > +		     int                regnum,
> > +		     int                all)
> > +{
> > +  struct regcache *regcache = get_current_regcache ();
> > +
> 
> or1k_registers_info should print the registers contents from FRAME
> rather than current regcache.

Yes, this has been fixed, actually removed and we are using the default
implementation now.
 
> > +  if (-1 == regnum)
> > +    {
> > +      /* Do all (valid) registers */
> > +      unsigned int  lim = all ? OR1K_NUM_REGS_CACHED : OR1K_MAX_GPR_REGS;
> > +
> > +      for (regnum = 0; regnum < lim; regnum++) {
> > +	if ('\0' != *(or1k_register_name (gdbarch, regnum)))
> > +	  {
> > +	    or1k_registers_info (gdbarch, file, frame, regnum, all);
> > +	  }
> > +      }
> > +    }
> > +  else
> > +    {
> > +      /* Do one specified register - if it is part of this architecture */
> > +      if ((regnum < OR1K_NUM_REGS_CACHED)
> > +	  && ('\0' == *(or1k_register_name (gdbarch, regnum))))
> > +	{
> > +	  error ("Not a valid register for the current processor type");
> > +	}
> > +      else
> > +	{
> > +	  /* If the register is not in the g/G packet, fetch it from the
> > +	   * target with a p/P packet.
> > +	   */
> > +	  if (regnum >= OR1K_NUM_REGS_CACHED)
> > +	    target_fetch_registers (regcache, regnum);
> 
> Why is a register no in the g/G packet?  Again, we shouldn't fetch
> registers now.

In openrisc there are about >1000 registers.  The g-packet has only first ~36
registers.  Now, the target-descriptions implementation of registers_info
actually supports this and falls back to the 'p' packet if registers are
not in the 'g' packet.

Using target-description with openrisc has been tested by me with a
remote OpenOCD target and is working.

> > +
> > +	  default_print_registers_info (gdbarch, file, frame, regnum, all);
> > +	}
> > +    }
> > +}	/* or1k_registers_info() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Identify if a register belongs to a specified group
> > +
> > +   Return true if the specified register is a member of the specified
> > +   register group.
> > +
> > +   These are the groups of registers that can be displayed via "info reg".
> > +
> > +   @todo The Vector and Floating Point registers ought to be displayed as
> > +         pseudo-registers.
> 
> Need to fix it.

As mentioned above I have removed the pseudo registers for now.
 
> > +
> > +/* Support functions for frame handling */
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/*!Initialize a prologue cache
> > +
> > +   This function is changed from its GDB 6.8 version (named
> > +   or1k_frame_unwind_cache), in that it is based on THIS frame, not the NEXT
> > +   frame.
> 
> This is not useful.

Removed.

> > +
> > +
> > +#if 0
> 
> If this is not needed, remove it.

Yes, removed.

> > +/*----------------------------------------------------------------------------*/
> > +/*!Return the base address of the frame
> > +
> > +   The implementations has changed since GDB 6.8, since we are now provided
> > +   with the address of THIS frame, rather than the NEXT frame.
> > +
> > +   For the OR1K, the base address is the frame pointer
> > +
> > +   @param[in] this_frame      The current stack frame.
> > +   @param[in] prologue_cache  Any cached prologue for THIS function.
> > +
> > +   @return  The frame base address */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static CORE_ADDR
> > +or1k_frame_base_address (struct frame_info  *this_frame,
> > +			 void              **prologue_cache)
> > +{
> > +  return  (CORE_ADDR) get_frame_register_unsigned (this_frame, OR1K_FP_REGNUM);
> > +
> > +}	/* or1k_frame_base_address() */
> > +
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/*!Identify our frame base sniffer functions
> > +
> > +   This function just identifies our family of frame sniffing functions.
> > +
> > +   @param[in] this_frame  The frame of THIS function. Not used here.
> > +
> > +   @return  A pointer to a struct identifying the frame base sniffing
> > +            functions.                                                        */
> > +/* -------------------------------------------------------------------------- */
> > +static const struct frame_base *
> > +or1k_frame_base_sniffer (struct frame_info *this_frame)
> > +{
> > +  /* Structure defining how the frame base is to be identified. */
> > +  static const struct frame_base  or1k_frame_base =
> > +    {
> > +      .unwind      = &or1k_frame_unwind,
> > +      .this_base   = or1k_frame_base_address,
> > +      .this_locals = or1k_frame_base_address,
> > +      .this_args   = or1k_frame_base_address
> > +    };
> > +
> > +  return &or1k_frame_base;
> > +
> > +}	/* or1k_frame_base_sniffer () */
> > +#endif
> > +
> > +/* Iterate over core file register note sections.  */
> > +static void
> > +or1k_iterate_over_regset_sections (struct gdbarch *gdbarch,
> > +				   iterate_over_regset_sections_cb *cb,
> > +                                   void *cb_data,
> > +                                   const struct regcache *regcache)
> > +{
> > +  // TODO: Do we need to put something here? (wallento)
> 
> Yes, you need.  'grep iterate_over_regset_sections *.c', and see how
> other arch does.
> 
> > +}
> 
> This function should be move to or1k-linux-tdep.c

This is removed now as we do not have or1k-linux-tdep.c yet.
 
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/*!Architecture initialization for OpenRISC 1000
> > +
> > +   Looks for a candidate architecture in the list of architectures supplied
> > +   using the info supplied. If none match, create a new architecture.
> > +
> > +   @param[in] info    Information about the target architecture
> > +   @param[in] arches  The list of currently know architectures
> > +
> > +   @return  A structure describing the target architecture                    */
> > +/* -------------------------------------------------------------------------- */
> > +static struct gdbarch *
> > +or1k_gdbarch_init (struct gdbarch_info  info,
> > +		   struct gdbarch_list *arches)
> > +{
> > +
> > +#if 0
> > +  /* Set up sniffers for the frame base. Use DWARF debug info if available,
> > +     otherwise use our own sniffer. */
> > +  frame_base_append_sniffer (gdbarch, dwarf2_frame_base_sniffer);
> > +  frame_base_append_sniffer (gdbarch, or1k_frame_base_sniffer);
> > +#endif
> 
> This can be removed.

Removed now.

> > +
> > +  /* Handle core files */
> > +  set_gdbarch_iterate_over_regset_sections (gdbarch, or1k_iterate_over_regset_sections);
> > +
> > +  /* Frame unwinders. Use DWARF debug info if available, otherwise use our
> > +     own unwinder. */
> > +  dwarf2_append_unwinders (gdbarch);
> > +  frame_unwind_append_unwinder (gdbarch, &or1k_frame_unwind);
> > +
> > +  /* Get a CGEN CPU descriptor for this architecture.  */
> > +  {
> > +
> > +    const char *mach_name = binfo->printable_name;
> > +    enum cgen_endian endian = (info.byte_order == BFD_ENDIAN_BIG
> > +                               ? CGEN_ENDIAN_BIG
> > +                               : CGEN_ENDIAN_LITTLE);
> > +
> > +    tdep->gdb_cgen_cpu_desc = or1k_cgen_cpu_open (CGEN_CPU_OPEN_BFDMACH, mach_name,
> > +                                        CGEN_CPU_OPEN_ENDIAN, endian,
> > +                                        CGEN_CPU_OPEN_END);
> > +
> > +    or1k_cgen_init_asm (tdep->gdb_cgen_cpu_desc);
> > +  }
> > +
> > +  /* If this mach as delay slot */
> > +  if (binfo->mach == bfd_mach_or1k)
> > +    {
> > +      set_gdbarch_single_step_through_delay
> > +                                    (gdbarch, or1k_single_step_through_delay);
> > +    }
> > +
> > + /* Check any target description for validity.  */
> > +  if (tdesc_has_registers (info.target_desc))
> > +    {
> > +
> > +      const struct tdesc_feature *feature;
> > +      int total_regs = 0;
> > +      int nb_features;
> > +      char feature_name[30];
> > +
> > +      tdesc_data = tdesc_data_alloc ();
> > +
> > +      /* OpenRisc architecture manual define a maximum of 32 registers groups */
> > +      for (group = 0; group < 32; group++)
> > +	{
> > +
> > +	  sprintf (feature_name, "org.gnu.gdb.or1k.group%d", group);
> > +	  feature = tdesc_find_feature (info.target_desc, feature_name);
> > +
> > +	  retval =
> > +	    get_feature_registers (feature, tdesc_data, &reg_index, gdbarch);
> > +
> > +	  if (retval < 0)
> > +	    {
> > +	      tdesc_data_cleanup (tdesc_data);
> > +	      return NULL;
> > +	    }
> > +	  else
> > +	    {
> > +	      total_regs += retval;
> > +	      if (retval && gdbarch_debug)
> > +		fprintf_unfiltered (gdb_stdout,
> > +				    "Found %4d registers in feature %s\n",
> > +				    retval, feature_name);
> > +	    }
> > +	}
> 
> I don't fully understand what you want to achieve here, can you
> elaborate?  What do these features look alike?

This code was iterating through all of the tdesc registers looking for
groups.  It was then adding all the groups from the tdesc to the gdb
register groups list.

I have removed this now.  OpenRISC has a few "extra" groups, in the next
series of patches you can see more clearly that we will just add those groups
explicitly rather than search dynamically for them.

Overall I have replaced this code for initializing the tdesc with the
details explained in the gdb docs here:

https://sourceware.org/gdb/wiki/Internals%20Adding-Target-Described-Register-Support

> > +      if (gdbarch_debug)
> > +	fprintf_unfiltered (gdb_stdout,
> > +			    "Found %4d registers in the tdesc file\n",
> > +			    total_regs);
> > +
> > +      if (!total_regs)
> > +	{
> > +	  tdesc_data_cleanup (tdesc_data);
> > +	  return NULL;
> > +	}
> > +    }
> > +
> > +  if (tdesc_data)
> > +    {
> > +      tdesc_use_registers (gdbarch, info.target_desc, tdesc_data);
> > +
> > +      /* Override the normal target description methods to handle our
> > +         dual real and pseudo registers.  */
> > +      set_gdbarch_register_name (gdbarch, or1k_register_name);
> > +      set_gdbarch_register_reggroup_p (gdbarch, or1k_register_reggroup_p);
> > +
> > +      set_gdbarch_register_name (gdbarch, or1k_register_name);
> > +      set_gdbarch_sp_regnum (gdbarch, OR1K_SP_REGNUM);
> > +      set_gdbarch_pc_regnum (gdbarch, OR1K_NPC_REGNUM);
> > +      set_gdbarch_num_pseudo_regs (gdbarch, OR1K_NUM_PSEUDO_REGS);
> > +    }
> > +
> > +  return gdbarch;
> > +
> > +}	/* or1k_gdbarch_init() */
> > +
> > +
> > +
> > +

> > +/* Functions to add extra commands to GDB */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Returns a special purpose register group name
> > +
> > +   @param[in]  group  The SPR group number
> > +
> > +   @return  The SPR name (pointer to the name argument) */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static const char *
> > +or1k_spr_group_name (int  group)
> > +{
> > +  static const char *or1k_group_names[OR1K_NUM_SPGS] =
> > +    {
> > +      "SYS",
> > +      "DMMU",
> > +      "IMMU",
> > +      "DCACHE",
> > +      "ICACHE",
> > +      "MAC",
> > +      "DEBUG",
> > +      "PERF",
> > +      "POWER",
> > +      "PIC",
> > +      "TIMER",
> > +      "FPU"
> > +    };
> > +
> > +  if ((0 <= group) && (group < OR1K_NUM_SPGS))
> > +    {
> > +      return or1k_group_names[group];
> > +    }
> > +  else
> > +    {
> > +      return "";
> > +    }
> > +}	/* or1k_spr_group_name() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Returns a special purpose register name
> > +
> > +   @param[in]  group  The SPR group
> > +   @param[in]  index  The index within the SPR group
> > +   @param[out] name   Array to put the name in
> > +
> > +   @return  The SPR name (pointer to the name argument) */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static char *
> > +or1k_spr_register_name (int   group,
> > +			int   index,
> > +			char *name)
> > +{
> > +  char di;
> > +
> > +  switch (group)
> > +    {
> > +
> > +    case OR1K_SPG_SYS:
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_SYS_VR:       sprintf (name, "VR"      ); return  name;
> > +	case OR1K_SPG_SYS_UPR:      sprintf (name, "UPR"     ); return  name;
> > +	case OR1K_SPG_SYS_CPUCFGR:  sprintf (name, "CPUCFGR" ); return  name;
> > +	case OR1K_SPG_SYS_DMMUCFGR: sprintf (name, "DMMUCFGR"); return  name;
> > +	case OR1K_SPG_SYS_IMMUCFGR: sprintf (name, "IMMUCFGR"); return  name;
> > +	case OR1K_SPG_SYS_DCCFGR:   sprintf (name, "DCCFGR"  ); return  name;
> > +	case OR1K_SPG_SYS_ICCFGR:   sprintf (name, "ICCFGR"  ); return  name;
> > +	case OR1K_SPG_SYS_DCFGR:    sprintf (name, "DCFGR"   ); return  name;
> > +	case OR1K_SPG_SYS_PCCFGR:   sprintf (name, "PCCFGR"  ); return  name;
> > +	case OR1K_SPG_SYS_NPC:      sprintf (name, "NPC"     ); return  name;
> > +	case OR1K_SPG_SYS_SR:       sprintf (name, "SR"      ); return  name;
> > +	case OR1K_SPG_SYS_PPC:      sprintf (name, "PPC"     ); return  name;
> > +	case OR1K_SPG_SYS_FPCSR:    sprintf (name, "FPCSR"   ); return  name;
> > +	}
> > +
> > +      /* Exception PC regs */
> > +      if((OR1K_SPG_SYS_EPCR <= index) &&
> > +	 (index             <= OR1K_SPG_SYS_EPCR_END))
> > +	{
> > +	  sprintf (name, "EPCR%d", index - OR1K_SPG_SYS_EPCR);
> > +	  return  name;
> > +	}
> > +
> > +      /* Exception EA regs */
> > +      if((OR1K_SPG_SYS_EEAR <= index) &&
> > +	 (index             <= OR1K_SPG_SYS_EEAR_END))
> > +	{
> > +	  sprintf (name, "EEAR%d", index - OR1K_SPG_SYS_EEAR);
> > +	  return  name;
> > +	}
> > +
> > +      /* Exception SR regs */
> > +      if((OR1K_SPG_SYS_ESR <= index) &&
> > +	 (index            <= OR1K_SPG_SYS_ESR_END))
> > +	{
> > +	  sprintf (name, "ESR%d", index - OR1K_SPG_SYS_ESR);
> > +	  return  name;
> > +	}
> > +
> > +      /* GPRs */
> > +      if((OR1K_SPG_SYS_GPR <= index) &&
> > +	 (index            <= OR1K_SPG_SYS_GPR_END))
> > +	{
> > +	  sprintf (name, "GPR%d", index - OR1K_SPG_SYS_GPR);
> > +	  return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_DMMU:
> > +    case OR1K_SPG_IMMU:
> > +      /* MMU registers. Use DMMU constants throughout, but these are identical
> > +	 to the corresponding IMMU constants */
> > +      di = OR1K_SPG_DMMU == group ? 'D' : 'I';
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_DMMU_DMMUCR:
> > +	  sprintf (name, "%cMMUCR",  di); return  name;
> > +	case OR1K_SPG_DMMU_DMMUPR:
> > +	  sprintf (name, "%cMMUPR",  di); return  name;
> > +	case OR1K_SPG_DMMU_DTLBEIR:
> > +	  sprintf (name, "%cTLBEIR", di); return  name;
> > +	}
> > +
> > +      /* ATB Match registers */
> > +      if((OR1K_SPG_DMMU_DATBMR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DATBMR_END))
> > +	{
> > +	  sprintf (name, "%cATBMR%d", di, index - OR1K_SPG_DMMU_DATBMR);
> > +	  return  name;
> > +	}
> > +
> > +      /* ATB Translate registers */
> > +      if((OR1K_SPG_DMMU_DATBTR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DATBTR_END))
> > +	{
> > +	  sprintf (name, "%cATBTR%d", di, index - OR1K_SPG_DMMU_DATBTR);
> > +	  return  name;
> > +	}
> > +
> > +      /* TLB Way 1 Match registers */
> > +      if((OR1K_SPG_DMMU_DTLBW1MR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DTLBW1MR_END))
> > +	{
> > +	  sprintf (name, "%cTLBW1MR%d", di, index - OR1K_SPG_DMMU_DTLBW1MR);
> > +	  return  name;
> > +	}
> > +
> > +      /* TLB Way 1 Translate registers */
> > +      if((OR1K_SPG_DMMU_DTLBW1TR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DTLBW1TR_END))
> > +	{
> > +	  sprintf (name, "%cTLBW1TR%d", di, index - OR1K_SPG_DMMU_DTLBW1TR);
> > +	  return  name;
> > +	}
> > +
> > +      /* TLB Way 2 Match registers */
> > +      if((OR1K_SPG_DMMU_DTLBW2MR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DTLBW2MR_END))
> > +	{
> > +	  sprintf (name, "%cTLBW2MR%d", di, index - OR1K_SPG_DMMU_DTLBW2MR);
> > +	  return  name;
> > +	}
> > +
> > +      /* TLB Way 2 Translate registers */
> > +      if((OR1K_SPG_DMMU_DTLBW2TR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DTLBW2TR_END))
> > +	{
> > +	  sprintf (name, "%cTLBW2TR%d", di, index - OR1K_SPG_DMMU_DTLBW2TR);
> > +	  return  name;
> > +	}
> > +
> > +      /* TLB Way 3 Match registers */
> > +      if((OR1K_SPG_DMMU_DTLBW3MR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DTLBW3MR_END))
> > +	{
> > +	  sprintf (name, "%cTLBW3MR%d", di, index - OR1K_SPG_DMMU_DTLBW3MR);
> > +	  return  name;
> > +	}
> > +
> > +      /* TLB Way 3 Translate registers */
> > +      if((OR1K_SPG_DMMU_DTLBW3TR <= index) &&
> > +	 (index                <= OR1K_SPG_DMMU_DTLBW3TR_END))
> > +	{
> > +	  sprintf (name, "%cTLBW3TR%d", di, index - OR1K_SPG_DMMU_DTLBW3TR);
> > +	  return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_DC:
> > +      /* Data cache registers. These do not have an exact correspondence with
> > +	 their instruction cache counterparts, so must be done separately. */
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_DC_DCCR:  sprintf (name, "DCCR" ); return  name;
> > +	case OR1K_SPG_DC_DCBPR: sprintf (name, "DCBPR"); return  name;
> > +	case OR1K_SPG_DC_DCBFR: sprintf (name, "DCBFR"); return  name;
> > +	case OR1K_SPG_DC_DCBIR: sprintf (name, "DCBIR"); return  name;
> > +	case OR1K_SPG_DC_DCBWR: sprintf (name, "DCBWR"); return  name;
> > +	case OR1K_SPG_DC_DCBLR: sprintf (name, "DCBLR"); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_IC:
> > +      /* Instruction cache registers */
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_IC_ICCR:  sprintf (name, "ICCR" ); return  name;
> > +	case OR1K_SPG_IC_ICBPR: sprintf (name, "ICBPR"); return  name;
> > +	case OR1K_SPG_IC_ICBIR: sprintf (name, "ICBIR"); return  name;
> > +	case OR1K_SPG_IC_ICBLR: sprintf (name, "ICBLR"); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_MAC:
> > +      /* MAC registers */
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_MAC_MACLO: sprintf (name, "MACLO"); return  name;
> > +	case OR1K_SPG_MAC_MACHI: sprintf (name, "MACHI"); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_DEBUG:
> > +      /* Debug registers */
> > +
> > +      /* Debug Value registers */
> > +      if((OR1K_SPG_DEBUG_DVR <= index) &&
> > +	 (index                <= OR1K_SPG_DEBUG_DVR_END))
> > +	{
> > +	  sprintf (name, "DVR%d", index - OR1K_SPG_DEBUG_DVR);
> > +	  return  name;
> > +	}
> > +
> > +      /* Debug Control registers */
> > +      if((OR1K_SPG_DEBUG_DCR <= index) &&
> > +	 (index                <= OR1K_SPG_DEBUG_DCR_END))
> > +	{
> > +	  sprintf (name, "DCR%d", index - OR1K_SPG_DEBUG_DCR);
> > +	  return  name;
> > +	}
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_DEBUG_DMR1:  sprintf (name, "DMR1" ); return  name;
> > +	case OR1K_SPG_DEBUG_DMR2:  sprintf (name, "DMR2" ); return  name;
> > +	case OR1K_SPG_DEBUG_DCWR0: sprintf (name, "DCWR0"); return  name;
> > +	case OR1K_SPG_DEBUG_DCWR1: sprintf (name, "DCWR1"); return  name;
> > +	case OR1K_SPG_DEBUG_DSR:   sprintf (name, "DSR"  ); return  name;
> > +	case OR1K_SPG_DEBUG_DRR:   sprintf (name, "DRR"  ); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_PC:
> > +      /* Performance Counter registers */
> > +
> > +      /* Performance Counters Count registers */
> > +      if((OR1K_SPG_PC_PCCR <= index) &&
> > +	 (index                <= OR1K_SPG_PC_PCCR_END))
> > +	{
> > +	  sprintf (name, "PCCR%d", index - OR1K_SPG_PC_PCCR);
> > +	  return  name;
> > +	}
> > +
> > +      /* Performance Counters Mode registers */
> > +      if((OR1K_SPG_PC_PCMR <= index) &&
> > +	 (index                <= OR1K_SPG_PC_PCMR_END))
> > +	{
> > +	  sprintf (name, "PCMR%d", index - OR1K_SPG_PC_PCMR);
> > +	  return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_PM:
> > +      /* Power Management registers */
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_PM_PMR:  sprintf (name, "PMR"); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_PIC:
> > +      /* Programmable Interrupt Controller registers */
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_PIC_PICMR:  sprintf (name, "PICMR"); return  name;
> > +	case OR1K_SPG_PIC_PICSR:  sprintf (name, "PICSR"); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_TT:
> > +      /* Tick Timer registers */
> > +
> > +      /* 1:1 names */
> > +      switch (index)
> > +	{
> > +	case OR1K_SPG_TT_TTMR:  sprintf (name, "TTMR"); return  name;
> > +	case OR1K_SPG_TT_TTCR:  sprintf (name, "TTCR"); return  name;
> > +	}
> > +
> > +      break;
> > +
> > +    case OR1K_SPG_FPU:
> > +
> > +      break;
> > +    }
> > +
> > +  /* Not a recognized register */
> > +  strcpy (name, "");
> > +  return  name;
> > +
> > +}	/* or1k_spr_register_name() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Get SPR group number from a name
> > +
> > +   @param[in] group_name  SPR register group
> > +
> > +   @return  The index, or negative if no match. */
> > +/*----------------------------------------------------------------------------*/
> > +
> > +static int
> > +or1k_groupnum_from_name (char *group_name)
> > +{
> > +  int  group;
> > +
> > +  for (group = 0; group < OR1K_NUM_SPGS; group++)
> > +    {
> > +      if (0 == strcasecmp (group_name, or1k_spr_group_name (group)))
> > +	{
> > +	  return group;
> > +	}
> > +    }
> > +
> > +  return -1;
> > +
> > +}	/* or1k_groupnum_from_name() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Get register index in special purpose register group from name
> > +
> > +   The name may either be SPR<group_num>_<index> or a known unique name. In
> > +   either case the group number must match the supplied group number.
> > +
> > +   @param[in] group  SPR register group
> > +   @param[in] name   Register name
> > +
> > +   @return  The index, or negative if no match. */
> > +/*----------------------------------------------------------------------------*/
> > +
> > +static int
> > +or1k_regnum_from_name (int   group,
> > +		       char *name)
> > +{
> > +  /* Last valid register in each group. */
> > +  static const int  or1k_spr_group_last[OR1K_NUM_SPGS] =
> > +    {
> > +      OR1K_SPG_SYS_LAST,
> > +      OR1K_SPG_DMMU_LAST,
> > +      OR1K_SPG_IMMU_LAST,
> > +      OR1K_SPG_DC_LAST,
> > +      OR1K_SPG_IC_LAST,
> > +      OR1K_SPG_MAC_LAST,
> > +      OR1K_SPG_DEBUG_LAST,
> > +      OR1K_SPG_PC_LAST,
> > +      OR1K_SPG_PM_LAST,
> > +      OR1K_SPG_PIC_LAST,
> > +      OR1K_SPG_TT_LAST,
> > +      OR1K_SPG_FPU_LAST
> > +    };
> > +
> > +  int  i;
> > +  char  spr_name[32];
> > +
> > +  if (0 == strcasecmp (name, "SPR"))
> > +    {
> > +      char *ptr_c;
> > +
> > +      /* Skip SPR */
> > +      name += 3;
> > +
> > +      /* Get group number */
> > +      i = (int) strtoul (name, &ptr_c, 10);
> > +      if (*ptr_c != '_' || i != group)
> > +	{
> > +	  return -1;
> > +	}
> > +
> > +      /* Get index */
> > +      ptr_c++;
> > +      i = (int) strtoul (name, &ptr_c, 10);
> > +      if (*ptr_c)
> > +	{
> > +	  return -1;
> > +	}
> > +      else
> > +	{
> > +	  return  i;
> > +	}
> > +    }
> > +
> > +  /* Look for a "known" name in this group */
> > +  for (i = 0; i <= or1k_spr_group_last[group]; i++)
> > +    {
> > +      char *s = or1k_spr_register_name (group, i, spr_name);
> > +
> > +      if (0 == strcasecmp (name, s))
> > +	{
> > +	  return i;
> > +	}
> > +    }
> > +
> > +  /* Failure */
> > +  return -1;
> > +
> > +}	/* or1k_regnum_from_name() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Get the next token from a string
> > +
> > +   I can't believe there isn't a library argument for this, but strtok is
> > +   deprecated.
> > +
> > +   Take a string and find the start of the next token and its length. A token
> > +   is anything containing non-blank characters.
> > +
> > +   @param[in]  str  The string to look at (may be NULL).
> > +   @param[out] tok  Pointer to the start of the token within str. May be NULL
> > +                    if this result is not wanted (e.g. just the length is
> > +		    wanted. If no token is found will be the NULL char at the
> > +		    end of the string, if the original str was NULL, this will
> > +		    be NULL.
> > +
> > +		    @return  The length of the token found */
> > +/*----------------------------------------------------------------------------*/
> > +
> > +static int
> > +or1k_tokenize (char  *str,
> > +	       char **tok)
> > +{
> > +  char *ptr;
> > +  int   len;
> > +
> > +  /* Deal with NULL argument */
> > +  if (NULL == str)
> > +    {
> > +      if (NULL != tok)
> > +	{
> > +	  *tok = NULL;
> > +	}
> > +      return 0;
> > +    }
> > +
> > +  /* Find the start */
> > +  for (ptr = str; ISBLANK (*ptr) ; ptr++)
> > +    {
> > +      continue;
> > +    }
> > +
> > +  /* Return the start pointer if requested */
> > +  if (NULL != tok)
> > +    {
> > +      *tok = ptr;
> > +    }
> > +
> > +  /* Find the end and put in EOS */
> > +  for (len = 0;  ('\0' != ptr[len]) && (!ISBLANK (ptr[len])); len++)
> > +    {
> > +      continue;
> > +    }
> > +
> > +  return len;
> > +
> > +}	/* or1k_tokenize() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Parses args for spr commands
> > +
> > +   Determines the special purpose register (SPR) name and puts result into
> > +   group and index
> > +
> > +   Syntax is:
> > +
> > +   @verbatim
> > +   <spr_args>    -> <group_ref> | <reg_name>
> > +   <group_ref>   -> <group_id> <index>
> > +   <group_id>    -> <group_num> | <group_name>
> > +   @endverbatim
> > +
> > +   Where the indices/names have to be valid.
> > +
> > +   So to parse, we look for 1 or 2 args. If 1 it must be a unique register
> > +   name. If 2, the first must be a group number or name and the second an
> > +   index within that group.
> > +
> > +   Also responsible for providing diagnostics if the arguments do not match.
> > +
> > +   Rewritten for GDB 6.8 to use the new UI calls and remove assorted
> > +   bugs. Syntax also slightly restricted to be more comprehensible.
> > +
> > +   @param[in]  arg_str  The argument string
> > +   @param[out] group    The group this SPR belongs in, or -1 to indicate
> > +                        failure
> > +   @param[out] index    Index of the register within the group, or -1 to
> > +                        indicate the whole group
> > +   @param[in]  is_set   1 (true) if we are called from the "spr" command (so
> > +                        there is an extra arg) rather than the "info spr"
> > +                        command. Needed to distinguish between the case where
> > +                        info is sought from a register specified as group and
> > +                        index and setting a uniquely identified register to a
> > +                        value.
> > +
> > +			@return  A pointer to any remaining args */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static char *
> > +or1k_parse_spr_params (char *arg_str,
> > +		       int  *group,
> > +		       int  *index,
> > +		       int   is_set)
> > +{
> > +  struct {
> > +    char              *str;
> > +    int                len;
> > +    unsigned long int  val;
> > +    int                is_num;
> > +  } arg[3] = {
> > +    {
> > +      .str    = NULL,
> > +      .len    = 0,
> > +      .val    = 0,
> > +      .is_num = 0,
> > +    },
> > +   {
> > +      .str    = NULL,
> > +      .len    = 0,
> > +      .val    = 0,
> > +      .is_num = 0,
> > +    },
> > +   {
> > +      .str    = NULL,
> > +      .len    = 0,
> > +      .val    = 0,
> > +      .is_num = 0,
> > +    }
> > +  };
> > +
> > +  int   num_args;
> > +  char *trailer  = arg_str;
> > +  char *tmp_str;
> > +  int   i;
> > +  struct ui_out *uiout = current_uiout;
> > +  char  spr_name[32];
> > +
> > +  /* Break out the arguments. Note that the strings are NOT null terminated
> > +     (we don't want to change arg_str), so we must rely on len. The stroul
> > +     call will still work, since there is always a non-digit char (possibly EOS)
> > +     after the last digit. */
> > +  if (NULL == arg_str)
> > +    {
> > +      num_args = 0;
> > +    }
> > +  else
> > +    {
> > +      for (num_args = 0; num_args < 3; num_args++)
> > +	{
> > +	  arg[num_args].len = or1k_tokenize (trailer, &(arg[num_args].str));
> > +	  trailer           = arg[num_args].str + arg[num_args].len;
> > +
> > +	  if (0 == arg[num_args].len)
> > +	    {
> > +	      break;
> > +	    }
> > +	}
> > +    }
> > +
> > +  /* Patch nulls into the arg strings and see about values. Couldn't do this
> > +     earlier, since we needed the next char clean to check later args. This
> > +     means advancing trailer, UNLESS it was already at EOS */
> > +
> > +  if((NULL != arg_str) && ('\0' != *trailer))
> > +    {
> > +      trailer++;
> > +    }
> > +
> > +  for (i = 0; i < num_args; i++)
> > +    {
> > +      (arg[i].str)[arg[i].len] = '\0';
> > +      errno                    = 0;
> > +      arg[i].val               = strtoul (arg[i].str, &tmp_str, 0);
> > +      arg[i].is_num            = (0 == errno) && ('\0' == *tmp_str);
> > +    }
> > +
> > +  /* Deal with the case where we are setting a register, so the final argument
> > +     should be disregarded (it is the trailer). Do this anyway if we get a
> > +     third argument */
> > +  if ((is_set & (num_args > 0)) || (num_args > 2))
> > +    {
> > +      trailer = arg[num_args - 1].str;
> > +      num_args--;
> > +    }
> > +
> > +  /* Deal with different numbers of args */
> > +
> > +  switch (num_args)
> > +    {
> > +
> > +    case 0:
> > +      ui_out_message (uiout, 0,
> > +		      "Usage: <command> <register>      |\n"
> > +		      "       <command> <group>         |\n"
> > +		      "       <command> <group> <index>\n"
> > +		      "Valid groups are:\n");
> > +      for (i = 0; i < OR1K_NUM_SPGS; i++)
> > +	{
> > +	  ui_out_field_string (uiout, NULL, or1k_spr_group_name  (i));
> > +	  ui_out_spaces (uiout, 1);
> > +	  ui_out_wrap_hint (uiout, NULL);
> > +	}
> > +      ui_out_field_string (uiout, NULL, "\n");
> > +
> > +      *index = -1;
> > +      return  trailer;
> > +
> > +    case 1:
> > +      /* See if it is a numeric group */
> > +      if (arg[0].is_num)
> > +	{
> > +	  if (arg[0].val < OR1K_NUM_SPGS)
> > +	    {
> > +	      *group = arg[0].val;
> > +	      *index = -1;
> > +	      return trailer;
> > +	    }
> > +	  else
> > +	    {
> > +	      ui_out_message (uiout, 0,
> > +			      "Group index should be in the range 0 - %d\n",
> > +			      OR1K_NUM_SPGS);
> > +	      *group = -1;
> > +	      *index = -1;
> > +	      return trailer;
> > +	    }
> > +	}
> > +
> > +      /* Is is it a group name? */
> > +      *group = or1k_groupnum_from_name (arg[0].str);
> > +      if (*group >= 0)
> > +	{
> > +	  *index = -1;
> > +	  return trailer;
> > +	}
> > +
> > +      /* See if it is a valid register name in any group */
> > +      for (*group = 0; *group < OR1K_NUM_SPGS; (*group)++)
> > +	{
> > +	  *index = or1k_regnum_from_name (*group, arg[0].str);
> > +
> > +	  if (*index >= 0)
> > +	    {
> > +	      return  trailer;
> > +	    }
> > +	}
> > +
> > +      /* Couldn't find it - print out a rude message */
> > +      ui_out_message (uiout, 0,
> > +		      "Group or register name not recognized.\n"
> > +		      "Valid groups are:\n");
> > +      for (i = 0; i < OR1K_NUM_SPGS; i++)
> > +	{
> > +	  ui_out_field_string (uiout, NULL, or1k_spr_group_name (i));
> > +	  ui_out_spaces (uiout, 1);
> > +	  ui_out_wrap_hint (uiout, NULL);
> > +	}
> > +      ui_out_field_string (uiout, NULL, "\n");
> > +
> > +      *group = -1;
> > +      *index = -1;
> > +      return  trailer;
> > +
> > +    case 2:
> > +      /* See if first arg is a numeric group */
> > +      if (arg[0].is_num)
> > +	{
> > +	  if (arg[0].val < OR1K_NUM_SPGS)
> > +	    {
> > +	      *group = arg[0].val;
> > +	      *index = -1;
> > +	    }
> > +	  else
> > +	    {
> > +	      ui_out_message (uiout, 0,
> > +			      "Group index should be in the range 0 - %d\n",
> > +			      OR1K_NUM_SPGS - 1);
> > +	      *group = -1;
> > +	      *index = -1;
> > +	      return trailer;
> > +	    }
> > +	}
> > +      else
> > +	{
> > +	  /* Is is it a group name? */
> > +	  *group = or1k_groupnum_from_name (arg[0].str);
> > +	  if (*group >= 0)
> > +	    {
> > +	      *index = -1;
> > +	    }
> > +	  else
> > +	    {
> > +	      ui_out_message (uiout, 0,
> > +			      "Group name not recognized.\n"
> > +			      "Valid groups are:\n");
> > +	      for (i = 0; i < OR1K_NUM_SPGS; i++)
> > +		{
> > +		  ui_out_field_string (uiout, NULL, or1k_spr_group_name (i));
> > +		  ui_out_spaces (uiout, 1);
> > +		  ui_out_wrap_hint (uiout, NULL);
> > +		}
> > +	      ui_out_field_string (uiout, NULL, "\n");
> > +
> > +	      *group = -1;
> > +	      *index = -1;
> > +	      return  trailer;
> > +	    }
> > +	}
> > +
> > +      /* Is second arg an index or name? */
> > +      if (arg[1].is_num)
> > +	{
> > +	  if (arg[1].val < OR1K_SPG_SIZE)
> > +	    {
> > +	      /* Check this really is a register */
> > +	      if (0 != strlen (or1k_spr_register_name (*group, arg[1].val,
> > +						       spr_name)))
> > +		{
> > +		  *index = arg[1].val;
> > +		  return trailer;
> > +		}
> > +	      else
> > +		{
> > +		  ui_out_message (uiout, 0,
> > +				  "No valid register at that index in group\n");
> > +		  *group = -1;
> > +		  *index = -1;
> > +		  return  trailer;
> > +		}
> > +	    }
> > +	  else
> > +	    {
> > +	      ui_out_message (uiout, 0,
> > +			      "Register index should be in the range 0 - %d\n",
> > +			      OR1K_SPG_SIZE - 1);
> > +	      *group = -1;
> > +	      *index = -1;
> > +	      return  trailer;
> > +	    }
> > +	}
> > +
> > +      /* Must be a name */
> > +      *index = or1k_regnum_from_name (*group, arg[1].str);
> > +
> > +      if (*index >= 0)
> > +	{
> > +	  return trailer;
> > +	}
> > +
> > +      /* Couldn't find it - print out a rude message */
> > +      ui_out_message (uiout, 0, "Register name not recognized in group.\n");
> > +      *group = -1;
> > +      *index = -1;
> > +      return  trailer;
> > +
> > +    default:
> > +      /* Anything else is an error */
> > +      ui_out_message (uiout, 0, "Unable to parse arguments\n");
> > +      *group = -1;
> > +      *index = -1;
> > +      return  trailer;
> > +    }
> > +}	/* or1k_parse_spr_params() */
> > +
> > +
> > +/*---------------------------------------------------------------------------*/
> > +/*!Read a special purpose register from the target
> > +
> > +   This has to be done using the target remote command "readspr"
> > +
> > +   @param[in] regnum  The register to read
> > +
> > +   @return  The value read */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static ULONGEST
> > +or1k_read_spr (unsigned int  regnum)
> > +{
> > +  struct ui_file    *uibuf = mem_fileopen ();
> > +  char               cmd[sizeof ("readspr ffff")];
> > +  unsigned long int  data;
> > +  char              *res;
> > +  long int           len;
> > +
> > +  /* Create the command string and pass it to target remote command function */
> > +  sprintf (cmd, "readspr %4x", regnum);
> > +  target_rcmd (cmd, uibuf);
> 
> Why don't you put these special purpose register to g packet, so that
> we can read them through g packet?  It is not a good idea to extend rcmd this way.

I think this solution was put in place before the target descriptions
api was available.  The SPRs are now returned in via 'info registers', they
are actually in the p packet though. 

The logic for retrieving registers from both g and p packes is handled in:

  remote.c (remote_fetch_registers)

All of these spr functions have been removed now.

> > +
> > +  /* Get the output for the UI file as a string */
> > +  res = ui_file_xstrdup (uibuf, &len);
> > +  sscanf (res, "%lx", &data);
> > +
> > +  /* Tidy up */
> > +  xfree (res);
> > +  ui_file_delete (uibuf);
> > +
> > +  return  (ULONGEST)data;
> > +
> > +}	/* or1k_read_spr() */
> > +
> > +
> > +/*----------------------------------------------------------------------------*/
> > +/*!Show the value of a special purpose register or group
> > +
> > +   This is a custom extension to the GDB info command.
> > +
> > +   @param[in] args
> > +   @param[in] from_tty  True (1) if GDB is running from a TTY, false (0)
> > +   otherwise. */
> > +/*---------------------------------------------------------------------------*/
> > +
> > +static void
> > +or1k_info_spr_command (char *args,
> > +		       int   from_tty)
> > +{
> > +  int  group;
> > +  int  index;
> > +  struct ui_out *uiout = current_uiout;
> > +  char  spr_name[32];
> > +
> > +  or1k_parse_spr_params (args, &group, &index, 0);
> > +
> 
> Could you explain what do you want to do for special purpose
> register/group here?

This has been removed now too.  There was some documentation in
gdb.texinfo as well which has been removed.  Overall this was very
similar to 'info reg <group>'.

I never used it actually though. It can all be handled by the normal
register commands now.

> > +  if (group < 0)
> > +    {
> > +      return;			/* Couldn't parse the args */
> > +    }
> > +
> > +  if (index >= 0)
> > +    {
> > +      ULONGEST  value = or1k_read_spr (OR1K_SPR (group, index));
> > +
> > +      ui_out_field_fmt (uiout, NULL, "%s.%s = SPR%i_%i = %llu (0x%llx)\n",
> > +			or1k_spr_group_name (group),
> > +			or1k_spr_register_name (group, index, spr_name), group,
> > +			index, (long long unsigned int)value, (long long unsigned int)value);
> > +    }
> > +  else
> > +    {
> > +      /* Print all valid registers in the group */
> > +      for (index = 0; index < OR1K_SPG_SIZE; index++)
> > +	{
> > +	  if (0 != strlen (or1k_spr_register_name (group, index, spr_name)))
> > +	    {
> > +	      ULONGEST  value = or1k_read_spr (OR1K_SPR (group, index));
> > +
> > +	      ui_out_field_fmt (uiout, NULL,
> > +				"%s.%s = SPR%i_%i = %llu (0x%llx)\n",
> > +				or1k_spr_group_name (group),
> > +				or1k_spr_register_name (group, index, spr_name),
> > +				group, index, (long long unsigned int)value, (long long unsigned int)value);
> > +	    }
> > +	}
> > +    }
> > +}	/* or1k_info_spr_command() */
> > +
> > +
> > diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
> > new file mode 100644
> > index 0000000..f0afc8f
> > --- /dev/null
> > +++ b/gdb/or1k-tdep.h
> > @@ -0,0 +1,434 @@
> > +/* Definitions to target GDB to OpenRISC 1000 32-bit targets.
> > +
> > +   Copyright 2001 Free Software Foundation, Inc.
> > +   Copyright (C) 2008, 2010 Embecosm Limited
> 
> Copyright year and copyright owner.

These have been fixed.
 
> > +
> > +/*-----------------------------------------------------------------------------
> > +   This version for the OpenRISC 1000 architecture is a rewrite by Jeremy
> > +   Bennett of the old GDB 5.3 interface to make use of gdbarch for GDB 6.8.
> > +
> > +   The code tries to follow the GDB coding style. All OR1K specific globals
> > +   should have names beginning ork1_ or OR1K_.
> > +
> > +   Commenting is Doxygen compatible.
> > +
> > +   Much has been stripped out. See the files or1k-tdep.c, remote-or1k.c and
> > +   or1k-jtag.c for details of what has changed.
> 
> This comment is out of date.

I think its fixed now.
 
> > +   --------------------------------------------------------------------------*/
> > +
> > +
> > +/*! Byte array for the TRAP instruction used for breakpoints */
> > +#define OR1K_BRK_INSTR_STRUCT  {0x21, 0x00, 0x00, 0x01}
> > +/*! Numeric instruction used for a breakpoint */
> > +#define OR1K_BRK_INSTR 0x21000001
> > +
> > +/*! Numeric instruction used for a l.nop NOP_EXIT */
> > +#define  OR1K_NOP_EXIT 0x15000001
> 
> They are only used in or1k-tdep.c, so we can move them there.

I have removed as many unreferenced defines as I could find.

> > +
> > +/* Special purpose groups */
> > +
> > +#define OR1K_SPG_SIZE_BITS  11
> > +#define OR1K_SPG_SIZE       (1 << OR1K_SPG_SIZE_BITS)
> > +
> > +#define OR1K_SPG_SYS      0
> > +#define OR1K_SPG_DMMU     1
> > +#define OR1K_SPG_IMMU     2
> > +#define OR1K_SPG_DC       3
> > +#define OR1K_SPG_IC       4
> > +#define OR1K_SPG_MAC      5
> > +#define OR1K_SPG_DEBUG    6
> > +#define OR1K_SPG_PC       7
> > +#define OR1K_SPG_PM       8
> > +#define OR1K_SPG_PIC      9
> > +#define OR1K_SPG_TT      10
> > +#define OR1K_SPG_FPU     11
> > +
> > +#define OR1K_NUM_SPGS   (OR1K_SPG_FPU + 1)
> > +
> > +/* Special register group offsets */
> > +
> > +#define OR1K_SPG_SYS_VR          0
> > +#define OR1K_SPG_SYS_UPR         1
> > +#define OR1K_SPG_SYS_CPUCFGR     2
> > +#define OR1K_SPG_SYS_DMMUCFGR    3
> > +#define OR1K_SPG_SYS_IMMUCFGR    4
> > +#define OR1K_SPG_SYS_DCCFGR      5
> > +#define OR1K_SPG_SYS_ICCFGR      6
> > +#define OR1K_SPG_SYS_DCFGR       7
> > +#define OR1K_SPG_SYS_PCCFGR      8
> > +#define OR1K_SPG_SYS_NPC        16
> > +#define OR1K_SPG_SYS_SR         17
> > +#define OR1K_SPG_SYS_PPC        18
> > +#define OR1K_SPG_SYS_FPCSR      20
> > +#define OR1K_SPG_SYS_EPCR       32
> > +#define OR1K_SPG_SYS_EPCR_END  (OR1K_SPG_SYS_EPCR + 15)
> > +#define OR1K_SPG_SYS_EEAR       48
> > +#define OR1K_SPG_SYS_EEAR_END  (OR1K_SPG_SYS_EEAR + 15)
> > +#define OR1K_SPG_SYS_ESR        64
> > +#define OR1K_SPG_SYS_ESR_END   (OR1K_SPG_SYS_ESR + 15)
> > +#define OR1K_SPG_SYS_GPR      1024
> > +#define OR1K_SPG_SYS_GPR_END   (OR1K_SPG_SYS_GPR + OR1K_MAX_GPR_REGS)
> > +#define OR1K_SPG_SYS_LAST       OR1K_SPG_SYS_GPR_END
> > +
> > +#define OR1K_SPG_DMMU_DMMUCR           0
> > +#define OR1K_SPG_DMMU_DMMUPR           1
> > +#define OR1K_SPG_DMMU_DTLBEIR          2
> > +#define OR1K_SPG_DMMU_DATBMR           4
> > +#define OR1K_SPG_DMMU_DATBMR_END   (OR1K_SPG_DMMU_DATBMR + 3)
> > +#define OR1K_SPG_DMMU_DATBTR           8
> > +#define OR1K_SPG_DMMU_DATBTR_END   (OR1K_SPG_DMMU_DATBTR + 3)
> > +#define OR1K_SPG_DMMU_DTLBW0MR       512
> > +#define OR1K_SPG_DMMU_DTLBW0MR_END (OR1K_SPG_DMMU_DTLBW0MR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW0TR       640
> > +#define OR1K_SPG_DMMU_DTLBW0TR_END (OR1K_SPG_DMMU_DTLBW0TR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW1MR       768
> > +#define OR1K_SPG_DMMU_DTLBW1MR_END (OR1K_SPG_DMMU_DTLBW1MR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW1TR       896
> > +#define OR1K_SPG_DMMU_DTLBW1TR_END (OR1K_SPG_DMMU_DTLBW1TR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW2MR      1024
> > +#define OR1K_SPG_DMMU_DTLBW2MR_END (OR1K_SPG_DMMU_DTLBW2MR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW2TR      1152
> > +#define OR1K_SPG_DMMU_DTLBW2TR_END (OR1K_SPG_DMMU_DTLBW2TR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW3MR      1280
> > +#define OR1K_SPG_DMMU_DTLBW3MR_END (OR1K_SPG_DMMU_DTLBW3MR + 127)
> > +#define OR1K_SPG_DMMU_DTLBW3TR      1408
> > +#define OR1K_SPG_DMMU_DTLBW3TR_END (OR1K_SPG_DMMU_DTLBW3TR + 127)
> > +#define OR1K_SPG_DMMU_LAST          OR1K_SPG_DMMU_DTLBW3TR_END
> > +
> > +#define OR1K_SPG_IMMU_IMMUCR           0
> > +#define OR1K_SPG_IMMU_IMMUPR           1
> > +#define OR1K_SPG_IMMU_ITLBEIR          2
> > +#define OR1K_SPG_IMMU_IATBMR           4
> > +#define OR1K_SPG_IMMU_IATBMR_END   (OR1K_SPG_IMMU_IATBMR + 3)
> > +#define OR1K_SPG_IMMU_IATBTR           8
> > +#define OR1K_SPG_IMMU_IATBTR_END   (OR1K_SPG_IMMU_IATBTR + 3)
> > +#define OR1K_SPG_IMMU_ITLBW0MR       512
> > +#define OR1K_SPG_IMMU_ITLBW0MR_END (OR1K_SPG_IMMU_ITLBW0MR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW0TR       640
> > +#define OR1K_SPG_IMMU_ITLBW0TR_END (OR1K_SPG_IMMU_ITLBW0TR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW1MR       768
> > +#define OR1K_SPG_IMMU_ITLBW1MR_END (OR1K_SPG_IMMU_ITLBW1MR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW1TR       896
> > +#define OR1K_SPG_IMMU_ITLBW1TR_END (OR1K_SPG_IMMU_ITLBW1TR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW2MR      1024
> > +#define OR1K_SPG_IMMU_ITLBW2MR_END (OR1K_SPG_IMMU_ITLBW2MR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW2TR      1152
> > +#define OR1K_SPG_IMMU_ITLBW2TR_END (OR1K_SPG_IMMU_ITLBW2TR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW3MR      1280
> > +#define OR1K_SPG_IMMU_ITLBW3MR_END (OR1K_SPG_IMMU_ITLBW3MR + 127)
> > +#define OR1K_SPG_IMMU_ITLBW3TR      1408
> > +#define OR1K_SPG_IMMU_ITLBW3TR_END (OR1K_SPG_IMMU_ITLBW3TR + 127)
> > +#define OR1K_SPG_IMMU_LAST          OR1K_SPG_IMMU_ITLBW3TR_END
> > +
> > +#define OR1K_SPG_DC_DCCR   0
> > +#define OR1K_SPG_DC_DCBPR  1
> > +#define OR1K_SPG_DC_DCBFR  2
> > +#define OR1K_SPG_DC_DCBIR  3
> > +#define OR1K_SPG_DC_DCBWR  4
> > +#define OR1K_SPG_DC_DCBLR  5
> > +#define OR1K_SPG_DC_LAST   OR1K_SPG_DC_DCBLR
> > +
> > +#define OR1K_SPG_IC_ICCR   0
> > +#define OR1K_SPG_IC_ICBPR  1
> > +#define OR1K_SPG_IC_ICBIR  2
> > +#define OR1K_SPG_IC_ICBLR  3
> > +#define OR1K_SPG_IC_LAST   OR1K_SPG_IC_ICBLR
> > +
> > +#define OR1K_SPG_MAC_MACLO  1
> > +#define OR1K_SPG_MAC_MACHI  2
> > +#define OR1K_SPG_MAC_LAST   OR1K_SPG_MAC_MACHI
> > +
> > +#define OR1K_SPG_DEBUG_DVR      0
> > +#define OR1K_SPG_DEBUG_DVR_END (OR1K_SPG_DEBUG_DVR + 7)
> > +#define OR1K_SPG_DEBUG_DCR      8
> > +#define OR1K_SPG_DEBUG_DCR_END (OR1K_SPG_DEBUG_DCR + 7)
> > +#define OR1K_SPG_DEBUG_DMR1   16
> > +#define OR1K_SPG_DEBUG_DMR2   17
> > +#define OR1K_SPG_DEBUG_DCWR0  18
> > +#define OR1K_SPG_DEBUG_DCWR1  19
> > +#define OR1K_SPG_DEBUG_DSR    20
> > +#define OR1K_SPG_DEBUG_DRR    21
> > +#define OR1K_SPG_DEBUG_LAST   OR1K_SPG_DEBUG_DRR
> > +
> > +#define OR1K_SPG_PC_PCCR       0
> > +#define OR1K_SPG_PC_PCCR_END  (OR1K_SPG_PC_PCCR + 7)
> > +#define OR1K_SPG_PC_PCMR       8
> > +#define OR1K_SPG_PC_PCMR_END  (OR1K_SPG_PC_PCMR + 7)
> > +#define OR1K_SPG_PC_LAST       OR1K_SPG_PC_PCMR_END
> > +
> > +#define OR1K_SPG_PM_PMR     0
> > +#define OR1K_SPG_PM_LAST    OR1K_SPG_PM_PMR
> > +
> > +#define OR1K_SPG_PIC_PICMR  0
> > +#define OR1K_SPG_PIC_PICSR  2
> > +#define OR1K_SPG_PIC_LAST   OR1K_SPG_PIC_PICSR
> > +
> > +#define OR1K_SPG_TT_TTMR    0
> > +#define OR1K_SPG_TT_TTCR    1
> > +#define OR1K_SPG_TT_LAST    OR1K_SPG_TT_TTCR
> > +
> > +#define OR1K_SPG_FPU_LAST  -1
> > +
> > +
> > +/* Define absolute SPR values from group and index  */
> > +#define OR1K_SPR(group, index) (((group) << OR1K_SPG_SIZE_BITS) + (index))
> > +
> > +/* System group registers */
> > +#define OR1K_VR_SPRNUM       OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_VR)
> > +#define OR1K_UPR_SPRNUM      OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_UPR)
> > +#define OR1K_CPUCFGR_SPRNUM  OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_CPUCFGR)
> > +#define OR1K_DCFGR_SPRNUM    OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_DCFGR)
> > +#define OR1K_NPC_SPRNUM      OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_NPC)
> > +#define OR1K_SR_SPRNUM       OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_SR)
> > +#define OR1K_PPC_SPRNUM      OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_PPC)
> > +#define OR1K_EPCR_SPRNUM     OR1K_SPR (OR1K_SPG_SYS, OR1K_SPG_SYS_EPCR)
> > +
> > +/* Debug group registers */
> > +#define OR1K_DVR0_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DVR)
> > +#define OR1K_DCR0_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DCR)
> > +#define OR1K_DMR1_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DMR1)
> > +#define OR1K_DMR2_SPRNUM     OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DMR2)
> > +#define OR1K_DCWR0_SPRNUM    OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DCWR0)
> > +#define OR1K_DCWR1_SPRNUM    OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DCWR0)
> > +#define OR1K_DSR_SPRNUM      OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DSR)
> > +#define OR1K_DRR_SPRNUM      OR1K_SPR (OR1K_SPG_DEBUG, OR1K_SPG_DEBUG_DRR)
> > +
> > +/* General Purpose Registers */
> > +#define OR1K_ZERO_REGNUM          0
> > +#define OR1K_SP_REGNUM            1
> > +#define OR1K_FP_REGNUM            2
> > +#define OR1K_FIRST_ARG_REGNUM     3
> > +#define OR1K_LAST_ARG_REGNUM      8
> > +#define OR1K_LR_REGNUM            9
> > +#define OR1K_FIRST_SAVED_REGNUM  10
> > +#define OR1K_RV_REGNUM           11
> > +#define OR1K_PPC_REGNUM          (OR1K_MAX_GPR_REGS + 0)
> > +#define OR1K_NPC_REGNUM          (OR1K_MAX_GPR_REGS + 1)
> > +#define OR1K_SR_REGNUM           (OR1K_MAX_GPR_REGS + 2)
> > +
> > +/* Defines for Debug Control Register bits */
> > +
> > +#define OR1K_DCR_DP        0x0000001    /* DVR/DCR Present */
> > +#define OR1K_DCR_CC        0x000000e    /* Compare condition */
> > +#define OR1K_DCR_CC_OFF            1    /* Compare condition offset */
> > +#define OR1K_DCR_SC        0x0000010    /* Signed compare */
> > +#define OR1K_DCR_CT        0x00000e0    /* Compare type */
> > +#define OR1K_DCR_CT_OFF            5    /* Compare type offset */
> > +
> > +/* Defines for Debug Mode Register 1 bits.  */
> > +#define OR1K_DMR1_CW       0x00000003   /* Mask for CW bits */
> > +#define OR1K_DMR1_CW_AND   0x00000001	/* Chain watchpoint 0 AND */
> > +#define OR1K_DMR1_CW_OR    0x00000002	/* Chain watchpoint 0 OR */
> > +#define OR1K_DMR1_CW_SZ             2   /* Number of bits for each WP */
> > +#define OR1K_DMR1_ST       0x00400000	/* Single-step trace */
> > +#define OR1K_DMR1_BT       0x00800000	/* Branch trace */
> > +
> > +/* Defines for Debug Mode Register 2 bits.  */
> > +#define OR1K_DMR2_WCE0       0x00000001	/* Watchpoint counter enable 0 */
> > +#define OR1K_DMR2_WCE1       0x00000002	/* Watchpoint counter enable 1 */
> > +#define OR1K_DMR2_AWTC_MASK  0x00000ffc	/* Assign watchpoints to ctr mask */
> > +#define OR1K_DMR2_WGB_MASK   0x003ff000	/* Watchpoints generaing brk mask */
> > +#define OR1K_DMR2_WBS_MASK   0xffc00000 /* Watchpoint brkpt status mask */
> > +#define OR1K_DMR2_AWTC_OFF    2		/* Assign watchpoints to ctr offset */
> > +#define OR1K_DMR2_WGB_OFF    12		/* Watchpoints generating brk offset */
> > +#define OR1K_DMR2_WBS_OFF    22		/* Watchpoint brkpt status offset */
> > +
> > +/* Defines for Debug Stop Register.  */
> > +#define OR1K_DSR_RSTE    0x00000001	/* Reset exception */
> > +#define OR1K_DSR_BUSEE   0x00000002	/* Bus error exception */
> > +#define OR1K_DSR_DPFE    0x00000004	/* Data page fault exception */
> > +#define OR1K_DSR_IPFE    0x00000008	/* Instrution page fault exception */
> > +#define OR1K_DSR_TTE     0x00000010	/* Tick timer exception */
> > +#define OR1K_DSR_AE      0x00000020	/* Alignment exception */
> > +#define OR1K_DSR_IIE     0x00000040	/* Illegal instruction exception */
> > +#define OR1K_DSR_INTE    0x00000080	/* Interrupt exception */
> > +#define OR1K_DSR_DME     0x00000100	/* DTLB miss exception */
> > +#define OR1K_DSR_IME     0x00000200	/* ITLB miss exception */
> > +#define OR1K_DSR_RE      0x00000400	/* Range exception */
> > +#define OR1K_DSR_SCE     0x00000800	/* System call exception */
> > +#define OR1K_DSR_FPE     0x00001000	/* Floating point exception */
> > +#define OR1K_DSR_TE      0x00002000	/* Trap exception */
> > +
> > +/* Defines for Debug Reason Register bits */
> > +#define OR1K_DRR_RSTE    0x00000001	/* Reset exception */
> > +#define OR1K_DRR_BUSEE   0x00000002	/* Bus error exception */
> > +#define OR1K_DRR_DPFE    0x00000004	/* Data page fault exception */
> > +#define OR1K_DRR_IPFE    0x00000008	/* Instrution page fault exception */
> > +#define OR1K_DRR_TTE     0x00000010	/* Tick timer exception */
> > +#define OR1K_DRR_AE      0x00000020	/* Alignment exception */
> > +#define OR1K_DRR_IIE     0x00000040	/* Illegal instruction exception */
> > +#define OR1K_DRR_INTE    0x00000080	/* Interrupt exception */
> > +#define OR1K_DRR_DME     0x00000100	/* DTLB miss exception */
> > +#define OR1K_DRR_IME     0x00000200	/* ITLB miss exception */
> > +#define OR1K_DRR_RE      0x00000400	/* Range exception */
> > +#define OR1K_DRR_SCE     0x00000800	/* System call exception */
> > +#define OR1K_DRR_FPE     0x00001000	/* Floating point exception */
> > +#define OR1K_DRR_TE      0x00002000	/* Trap exception */
> > +
> > +/* Bit definitions for the Unit Present Register */
> > +#define OR1K_SPR_UPR_UP	        0x00000001  /* UPR present */
> > +#define OR1K_SPR_UPR_DCP        0x00000002  /* Data cache present */
> > +#define OR1K_SPR_UPR_ICP        0x00000004  /* Instruction cache present */
> > +#define OR1K_SPR_UPR_DMP        0x00000008  /* Data MMU present */
> > +#define OR1K_SPR_UPR_IMP        0x00000010  /* Instruction MMU present */
> > +#define OR1K_SPR_UPR_MP         0x00000020  /* MAC present */
> > +#define OR1K_SPR_UPR_DUP        0x00000040  /* Debug unit present */
> > +#define OR1K_SPR_UPR_PCUP       0x00000080  /* Perf counters unit present */
> > +#define OR1K_SPR_UPR_PMP        0x00000100  /* Power management present */
> > +#define OR1K_SPR_UPR_PICP       0x00000200  /* PIC present */
> > +#define OR1K_SPR_UPR_TTP        0x00000400  /* Tick timer present */
> > +
> > +/* Bit definitions for the CPU Configuration Register */
> > +#define OR1K_SPR_CPUCFGR_NSGF   0x0000000f  /* Number of shadow GPR files */
> > +#define OR1K_SPR_CPUCFGR_CGF    0x00000010  /* Custom GPR file */
> > +#define OR1K_SPR_CPUCFGR_OB32S  0x00000020  /* ORBIS32 supported */
> > +#define OR1K_SPR_CPUCFGR_OB64S  0x00000040  /* ORBIS64 supported */
> > +#define OR1K_SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
> > +#define OR1K_SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
> > +#define OR1K_SPR_CPUCFGR_OV64S  0x00000400  /* ORVDX64 supported */
> > +
> > +/* Bit definitions for the Debug configuration register */
> > +#define OR1K_SPR_DCFGR_NDP      0x00000007  /* Number of matchpoints */
> > +#define OR1K_SPR_DCFGR_WPCI     0x00000008  /* Watchpoint ctrs implemented */
> > +
> > +/* Properties of the architecture. GDB mapping of registers is all the GPRs
> > +   and SPRs followed by the PPC, NPC and SR at the end. Red zone is the area
> > +   past the end of the stack reserved for exception handlers etc. */
> > +#define OR1K_MAX_GPR_REGS            32
> > +#define OR1K_MAX_SPR_REGS           (32 * 2048)
> > +#define OR1K_NUM_PSEUDO_REGS         0
> > +#define OR1K_NUM_REGS_CACHED        (OR1K_MAX_GPR_REGS + 3)
> > +#define OR1K_NUM_REGS               (OR1K_NUM_REGS_CACHED + OR1K_MAX_SPR_REGS)
> > +#define OR1K_TOTAL_NUM_REGS         (OR1K_NUM_REGS + OR1K_NUM_PSEUDO_REGS)
> > +#define OR1K_MAX_MATCHPOINTS         8
> > +#define OR1K_MAX_HW_WATCHES          OR1K_MAX_MATCHPOINTS
> > +#define OR1K_STACK_ALIGN             4
> > +#define OR1K_INSTLEN                 4
> > +#define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
> > +#define OR1K_NUM_TAP_RECORDS         8
> > +#define OR1K_FRAME_RED_ZONE_SIZE     2536
> > +
> > +/* OR1K exception vectors */
> > +
> > +#define OR1K_RESET_VECTOR   0x100
> > +#define OR1K_BUSERR_VECTOR  0x200
> > +#define OR1K_DPF_VECTOR     0x300
> > +#define OR1K_IPF_VECTOR     0x400
> > +#define OR1K_TT_VECTOR      0x500
> > +#define OR1K_ALIGN_VECTOR   0x600
> > +#define OR1K_ILL_VECTOR     0x700
> > +#define OR1K_EXT_VECTOR     0x800
> > +#define OR1K_DTLB_VECTOR    0x900
> > +#define OR1K_ITLB_VECTOR    0xa00
> > +#define OR1K_RANGE_VECTOR   0xb00
> > +#define OR1K_SYS_VECTOR     0xc00
> > +#define OR1K_FP_VECTOR      0xd00
> > +#define OR1K_TRAP_VECTOR    0xe00
> 
> These macros are not used, AFAICS, why do you define them?
> 
> > +
> > +/* Constants and macros to break out instruction fields. I'd expect these in
> > +   the assembler header, but they aren't there (for now). */
> 
> 
> I don't see how these macros below are used.  If they are not used,
> don't define them.  If they are used, define them in include/opcode
> or opcodes/or1k-*.h

Removed.
 
> > +
> > +#define OR1K_SEXT16(v) (((v) & 0x00008000) ? ((v) - 0x00010000) : (v))
> > +#define OR1K_SEXT26(v) (((v) & 0x02000000) ? ((v) - 0x04000000) : (v))
> > +
> > +#define OR1K_OPCODE1(i)  (((i) & 0xfc000000) >> 26)
> > +#define OR1K_OPCODE2(i) ((((i) & 0xfc000000) >> 20) | \
> > +			 (((i) & 0x00000300) >>  6) | \
> > +			  ((i) & 0x0000000f))
> > +#define OR1K_OPCODE3(i) ((((i) & 0xfc000000) >> 24) | \
> > +			 (((i) & 0x000000c0) >> 6))
> > +#define OR1K_OPCODE4(i) ((((i) & 0xfc000000) >> 18) | \
> > +			 (((i) & 0x000003c0) >>  2) | \
> > +			  ((i) & 0x0000000f))
> > +#define OR1K_OPCODE5(i)  (((i) & 0xffff0000) >> 16)
> > +#define OR1K_OPCODE6(i)  (((i) & 0xff000000) >> 24)
> > +#define OR1K_OPCODE7(i)  (((i) & 0xfc000000) >> 21)
> > +#define OR1K_D_REG(i)    (((i) & 0x03e00000) >> 21)
> > +#define OR1K_A_REG(i)    (((i) & 0x001f0000) >> 16)
> > +#define OR1K_B_REG(i)    (((i) & 0x0000f800) >> 11)
> > +#define OR1K_IMM(i)      (OR1K_SEXT16((i) & 0x0000ffff))
> > +#define OR1K_IMM2(i)     (OR1K_SEXT16((((i) & 0x03e00000) >> 10) |	\
> > +				       ((i) & 0x000003ff)))
> > +#define OR1K_OFFSET(i)    (OR1K_SEXT26((i) & 0x03ffffff) ))
> > +#define OR1K_SHIFT(i)     ((i) & 0x0000003f)
> > +
> > +/* The instruction opcodes */
> > +
> > +#define OR1K_OP_ADD     0xe00	/* Type 2 */
> > +#define OR1K_OP_ADDC    0xe01	/* Type 2 */
> > +#define OR1K_OP_ADDI     0x27	/* Type 1 */
> > +#define OR1K_OP_AND     0xe03	/* Type 2 */
> > +#define OR1K_OP_ANDI     0x29	/* Type 1 */
> > +#define OR1K_OP_BF       0x04	/* Type 1 */
> > +#define OR1K_OP_BNF      0x03	/* Type 1 */
> > +#define OR1K_OP_TRAP   0x2100	/* Type 5 */
> > +#define OR1K_OP_J        0x00	/* Type 1 */
> > +#define OR1K_OP_JAL      0x01	/* Type 1 */
> > +#define OR1K_OP_JALR     0x12	/* Type 1 */
> > +#define OR1K_OP_JR       0x11	/* Type 1 */
> > +#define OR1K_OP_LBS      0x24   /* Type 1 */
> > +#define OR1K_OP_LBZ      0x23   /* Type 1 */
> > +#define OR1K_OP_LHS      0x26   /* Type 1 */
> > +#define OR1K_OP_LHZ      0x25   /* Type 1 */
> > +#define OR1K_OP_LWS      0x22   /* Type 1 */
> > +#define OR1K_OP_LWZ      0x21   /* Type 1 */
> > +#define OR1K_OP_MFSPR    0x07   /* Type 1 */
> > +#define OR1K_OP_MOVHI    0x06   /* Type 1 */
> > +#define OR1K_OP_MTSPR    0x10   /* Type 1 */
> > +#define OR1K_OP_MUL     0xe36   /* Type 2 */
> > +#define OR1K_OP_MULI     0x2c   /* Type 1 */
> > +#define OR1K_OP_MULU    0xe3b   /* Type 2 */
> > +#define OR1K_OP_NOP      0x15   /* Type 6 */
> > +#define OR1K_OP_OR      0xe04	/* Type 2 */
> > +#define OR1K_OP_ORI      0x2a   /* Type 1 */
> > +#define OR1K_OP_RFE      0x09   /* Type 1 */
> > +#define OR1K_OP_RORI     0xe3   /* Type 3 */
> > +#define OR1K_OP_SB       0x36   /* Type 1 */
> > +#define OR1K_OP_SFEQ    0x720   /* Type 7 */
> > +#define OR1K_OP_SFGES   0x72b   /* Type 7 */
> > +#define OR1K_OP_SFGEU   0x723   /* Type 7 */
> > +#define OR1K_OP_SFGTS   0x72a   /* Type 7 */
> > +#define OR1K_OP_SFGTU   0x722   /* Type 7 */
> > +#define OR1K_OP_SFLES   0x72d   /* Type 7 */
> > +#define OR1K_OP_SFLEU   0x725   /* Type 7 */
> > +#define OR1K_OP_SFLTS   0x72c   /* Type 7 */
> > +#define OR1K_OP_SFLTU   0x724   /* Type 7 */
> > +#define OR1K_OP_SFNE    0x721   /* Type 7 */
> > +#define OR1K_OP_SLL    0x3808   /* Type 4 */
> > +#define OR1K_OP_SLLI     0xe0   /* Type 3 */
> > +#define OR1K_OP_SRA    0x3828   /* Type 4 */
> > +#define OR1K_OP_SRAI     0xe2   /* Type 3 */
> > +#define OR1K_OP_SRL    0x3818   /* Type 4 */
> > +#define OR1K_OP_SRLI     0xe1   /* Type 3 */
> > +#define OR1K_OP_SUB     0xe02   /* Type 2 */
> > +#define OR1K_OP_SW       0x35   /* Type 1 */
> > +#define OR1K_OP_SYS    0x2000   /* Type 5 */
> > +#define OR1K_OP_XOR     0xe05   /* Type 2 */
> > +#define OR1K_OP_XORI     0x2b   /* Type 1 */
> > +
> > +#endif /* OR1K_TDEP__H */
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Yao 

