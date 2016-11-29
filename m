From: Stafford Horne <shorne@gmail.com>
Date: Wed, 30 Nov 2016 00:06:46 +0900 (JST)
Subject: [OpenRISC] [PATCH v2 2/4] gdb: Add OpenRISC or1k and or1knd
 target support (fwd)
In-Reply-To: <alpine.LFD.2.20.1611292334190.29569@lianli.shorne-pla.net>
References: <alpine.LFD.2.20.1611292334190.29569@lianli.shorne-pla.net>
Message-ID: <alpine.LFD.2.20.1611300001280.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


Send again, I stripped some of the patch below to hopefully get past the 
openrisc mailinglist size limit.

On Tue, 29 Nov 2016, Stafford Horne wrote:

>
> Hi Jeremy,
>
> You have probably seen the below. I am wondering if you have any concerns 
> with some of the suggestions. Specifically:
>
>  * Removing copyright Embecosm Limited and changing to Contributed by
>    Embecosm Limited.
>  * Franck doesn't have copyright assignment, he mentioned you might push
>    the code on his behalf. Since I am pushing the code now what do you
>    think?
>
> The freedback in general is great I think. I have started to clean up several 
> things. But it will take time.
>
> -Stafford
>
> ---------- Forwarded message ----------
> Date: Tue, 29 Nov 2016 19:06:03
> From: Yao Qi <qiyaoltc@gmail.com>
> To: Stafford Horne <shorne@gmail.com>
> Cc: gdb-patches at sourceware.org, openrisc at lists.librecores.org,
>    Franck Jullien <franck.jullien@gmail.com>
> Subject: Re: [PATCH v2 2/4] gdb: Add OpenRISC or1k and or1knd target support
>
> On Sun, Nov 27, 2016 at 03:16:44PM +0900, Stafford Horne wrote:
>>  From: Franck Jullien <franck.jullien@gmail.com>
>>
>>  This patch prepates the current GDB port of the openrisc processor from
>>  https://github.com/openrisc/binutils-gdb for upstream merging.
>>
>>  Testing has been done with a cgen sim provided in a separate patch. This
>>  has been tested with 2 toolchains. GCC [1] 5.4.0 from the openrisc
>>  project with Newlib [2] and GCC 5.4.0 with Musl [3] 1.1.4.
>>
>>  It supports or1knd (no delay slot target).
>>  The default target is or1k (with delay slot).
>>
>>  You can change the target arch with:
>>
>>  (gdb) set architecture or1knd
>>  The target architecture is assumed to be or1knd
>>
>>  [1] https://github.com/openrisc/or1k-gcc
>>  [2] https://github.com/openrisc/newlib
>>  [3] https://github.com/openrisc/musl-cross
>
> Hi Stafford,
> The code style in or1k-tdep.{c,h} is completely different from GNU
> coding standard.  Take a look at
> https://sourceware.org/gdb/wiki/ContributionChecklist and please
> also reference other new added ports about code style, like
> nios2-tdep.c.
>
>>
>>  gdb/doc/ChangeLog:
>>
>>  2016-03-13  Stefan Wallentowitz  <stefan@wallentowitz.de>
>>
>>   * gdb.texinfo (Embedded Processors): Add openrisc to suppress error.
>>
>>  2013-01-31  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   * gdb.texinfo: Add / merge OpenRISC documentation from old svn.
>>
>>  2008-08-13  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>
>>   * gdb.texinfo: Sections relating to OpenRISC 1000 rewritten
>>
>>  gdb/ChangeLog:
>>
>>  2016-11-23  Stafford Horne  <shorne@gmail.com>
>>
>>   Updates after Yao Qi's breakpoint refactor.
>>   * or1k-tdep.c (or1k_breakpoint_kind_from_pc): New function.
>>   (or1k_sw_breakpoint_from_kind): New function.
>>   (or1k_breakpoint_from_pc): Remove.
>>   (or1k_gdbarch_init): Use new functions.
>>
>>  2016-11-23  Stafford Horne  <shorne@gmail.com>
>>
>>   Corelow is no longer needed for or1k as its in by default.
>>   * configure.tgt: Remove corelow.o for or1k linux.
>>
>>  2016-11-16  Stafford Horne  <shorne@gmail.com>
>>
>>   Updates after rebase to upstream master.
>>   * or1k-tdep.c (or1k_fetch_instruction): Dont pass status
>>   directly to memory_error as they are different types.
>>   (or1k_pseudo_register_read): Return proper typed REG_UNKNOWN.
>>   (or1k_frame_cache): Cast result to trad_frame_cache.
>>   (or1k_gdbarch_init): Init gdbarch_tdep with XNEW.
>>
>>  2016-05-22  Stafford Horne  <shorne@gmail.com>
>>
>>   Upstream merge fixes.
>>   * or1k-tdep.c (or1k_return_value): Fix return conventions
>>   handling of arrays and literals to match gcc.
>>   (or1k_push_dummy_call): Properly handle vararg dummy args by
>>   pushing a pointer to args as per conventions.
>>
>>  2016-03-13  Stefan Wallentowitz  <stefan@wallentowitz.de>
>>
>>   Upstream merge fixes.
>>   * or1k-tdep.c (or1k_analyse_inst): Change fatal to throw_quit.
>>   (or1k_skip_prologue): Use SYMTAB_COMPUNIT and
>>   COMPUNIT_DEBUGFORMAT.
>>   (or1k_frame_cache): Change fatal to throw_quit.
>>   (or1k_regset_from_core_section): Remove.
>>   (or1k_iterate_over_regset_sections): Create, blank
>>   implementation.
>>
>>  2013-10-01  Stefan Kristiansson  <stefan.kristiansson@saunalahti.fi>
>>
>>   Upstream merge fixes.
>>   * or1k-tdep.c (or1k_fetch_instruction): Change char to gdb_byte
>>   to prevent pointer signedness error.
>>   (or1k_push_dummy_code): Likewise.
>>
>>  2013-03-15  Stefan Kristiansson  <stefan.kristiansson@saunalahti.fi>
>>
>>   * or1k-tdep.c (or1k_regset_firom_core_section) : Silence gcc
>>   warning by using %z format for size_t.
>>
>>  2013-02-22  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   * or1k-tdep.c (or1k_push_dummy_code) : Use or1k_frame_align to
>>   align the stack pointer.
>>
>>  2013-02-17  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   Add target descriptor support.
>>   * or1k-tdep.c (or1k_register_name): Conditionally pull register
>>   names from tdesc_register_name if we can.
>>   (or1k_registers_info): Fetch register via target_fetch_registers
>>   if it is not cached.
>>   (or1k_register_reggroup_p): Check register groups in target
>>   descriptor before falling back to default reg groups.
>>   (create_register_group): New Function.
>>   (get_feature_registers): New Function.
>>   (or1k_gdbarch_init): Init the register details from target_desc.
>>   (_initialize_or1k_tdep): Tell remote we support target
>>   description xml.
>>
>>  2013-02-16  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   * or1k-tdep.c: Use OR1K_NUM_REGS_CACHED.
>>   * or1k-tdep.h: Add OR1K_NUM_REGS_CACHED.
>>   Add OR1K_MAX_SPR_REGS.
>>
>>  2013-02-14  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   * or1k-tdep.c (or1k_push_dummy_code): New function.
>>   (or1k_gdbarch_init): Override default behavior and call dummy
>>   from the stack. Set the push_dummy_code handler to
>>   or1k_push_dummy_code.
>>
>>  2013-02-13  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   * or1k-tdep.c (or1k_skip_prologue): Add a check for NULL
>>   pointer while comparing debugformat to "dwarf".
>>
>>  2013-01-31  Franck Jullien  <franck.jullien@gmail.com>
>>
>>   * or1k-tdesc.c  : Add file for or1k support from old svn
>>   * or1k-tdesc.h  : Add file for or1k support from old svn
>>   * configure.tgt : Add or1k targets from old svn
>>
>>  2010-06-30  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>
>>   * or1k-tdep.c (or1k_fetch_instruction): Logic flow made clearer.
>>   (or1k_analyse_inst, or1k_analyse_L_addi)
>>   (or1k_analyse_l_sw): Added.
>>   (or1k_frame_size, or1k_frame_fp_loc, or1k_frame_size_check)
>>   (or1k_link_address, or1k_get_saved_reg): Removed.
>>   (or1k_skip_prologue, or1k_frame_unwind_cache): Rewritten to use
>>   or1k_analyse_inst functions.
>>   * or1k_tdep.h <OR1K_FIRST_SAVED_REGNUM, OR1K_INSTBITLEN>: #define
>>   added.
>>
>>  2008-11-08  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>
>>   * or1k-tdep.c (or1k_read_spr, or1k_write_spr): Moved here from
>>   remote-or1k.c and made local to this file. Rewritten to use
>>   commands via the target remote command (to_rcmd) function.
>>   * or1k-tdep.c (or1k_spr_command). Invalidates register cache when
>>   SPR is written.
>>   * or1k-tdep.h: or1k_read_spr and Or1k_write_spr are removed as
>>   global functions.
>>   * or1k-tdep.c (or1k_read_spr, or1k_write_spr). Functions removed
>>   and made local to or1k-tdep.c. All or1k-tdep.c references to these
>>   functions changed to use or1k_jtag_read_spr and
>>   or1k_jtag_write_spr (for which these were only wrappers).
>>   * or1k-tdep.c (or1k_rcmd): Function added to process SPR access
>>   requests.
>>
>>  2008-10-23  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>
>>   * or1k-tdep.h, or1k-tdep.c: Extend the number of registers to
>>   include the PPC as well as the NPC
>>
>>  2008-07-30  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>
>>   * or1k-tdep.c: New file, based on the OpenCores 5.3 port
>>   * or1k-tdep.h: New file, based on the OpenCores 5.3 port
>>   * configure.tgt: Updated description of OpenRISC 1000 files
>
> Please merge all ChangeLog entries into one, but with all contributors
> listed as author.
>
>>
>>  +or1k-*-linux*)
>>  +	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux
>>  +	gdb_target_obs="or1k-tdep.o"
>>  +	gdb_sim=../sim/or1k/libsim.a
>>  +	build_gdbserver=yes
>>  +	;;
>
> build_gdbserver=no?  We don't have OpenRISC GDBserver yet.  Secondly, we
> don't have or1k-linux-tdep.c, so I don't think or1k-*-linux target is
> supported.  Let us remove it...
>
>>  +
>>  +or1k-*-*)
>>  +	# Target: OpenCores OpenRISC 1000 32-bit implementation bare metal
>>  +	gdb_target_obs="or1k-tdep.o"
>>  +	gdb_sim=../sim/or1k/libsim.a
>>  +	;;
>>  +
>>  +or1knd-*-linux*)
>>  +	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux,
>>  without delay slot
>>  +	gdb_target_obs="or1k-tdep.o"
>>  +	gdb_sim=../sim/or1k/libsim.a
>>  +	build_gdbserver=yes
>>  +	;;
>
> Likewise, let us remove it.
>
>>  diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
>>  new file mode 100644
>>  index 0000000..3592ac9
>>  --- /dev/null
>>  +++ b/gdb/or1k-tdep.c
>>  @@ -0,0 +1,3285 @@
>>  +/* Target-dependent code for the 32-bit OpenRISC 1000, for the GNU
>>  Debugger.
>>  +
>>  +   Copyright 1988-2008, Free Software Foundation, Inc.
>>  +   Copyright (C) 2008, 2010 Embecosm Limited
>
> If the patch is contributed to FSF project, FSF should be the copyright
> owner.  All the contributors should agree on this.
>
>>  +
>>  +   Contributed by Alessandro Forin(af at cs.cmu.edu at CMU
>>  +   and by Per Bothner(bothner at cs.wisc.edu) at U.Wisconsin.
>>  +
>>  +   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
>>  +
>>  +   Contributor Franck Jullien <elec4fun@gmail.com>
>>  +
>
> Franck doesn't have FSF copyright assignment.
>
>>  +/*-----------------------------------------------------------------------------
>>  +   This version for the OpenRISC 1000 architecture is a rewrite by Jeremy
>>  +   Bennett of the old GDB 5.3 interface to make use of gdbarch for GDB
>>  6.8. It
>>  +   has since been updated for GDB 7.2 and GDB 7.5.
>
> Once we add or1k-tdep.c into GDB mainline, these notes are not useful
> anymore.
>
>>  +
>>  +   The code tries to follow the GDB coding style.
>>  +
>>  +   Commenting is Doxygen compatible.
>
> We don't write comments in Doxygen style.
>
>>  +
>>  +   Notes on the GDB 7.5 version
>>  +   ============================
>>  +
>>  +   This version is just an upgrade of the previous port. It does use CGEN
>>  +   for instruction lookup in or1k_single_step_through_delay as the new
>>  toolchain
>>  +   is CGEN based.
>>  +
>>  +   This version is compatible with or1knd target (no delay slot version
>>  of the
>>  +   toolchain). We check in bfd_arch_info if the mach is bfd_mach_or1k or
>>  +   bfd_mach_or1knd to choose if or1k_single_step_through_delay must be
>>  +   implemented.
>>  +
>>  +   Notes on the GDB 7.2 version
>>  +   ============================
>>  +
>>  +   The primary change is to support the new GCC 4.5.1 compiler, which no
>>  +   longer adds preceding underscores to global values and uses DWARF2 as
>>  its
>>  +   default debug format.
>>  +
>>  +   This version now supports Or1ksim integrated as a simulator library,
>>  so
>>  +   "target sim" will work. It does require Or1ksim to be available as a
>>  +   library at configuration time, with the Or1ksim installation directory
>>  +   specified by the argument --with-or1ksim.
>>  +
>>  +   The ad-hoc prologue analysis, which was always a weak point has been
>>  +   stripped out and replaced with code based on the generic approach in
>>  +   prologue-value.c and prologue-value.h.
>>  +
>>  +   The objective with this version is to get reasonable results on
>>  regression
>>  +   testing. Something the older versions never achieved.
>>  +
>>  +   Notes on the GDB 6.8 version
>>  +   ============================
>>  +
>>  +   Much has been stripped out in the interests of getting a basic working
>>  +   system. This is described as the OpenRISC 1000 target architecture, so
>>  +   should work with 32 and 64 bit versions of that architecture and
>>  should
>>  +   work whether or not they have floating point and/or vector registers,
>>  +   although to date it has only been tested with the 32-bit integer
>>  +   archtiecture.
>>  +
>>  +   The info trace command has been removed. The meaning of this is not
>>  clear -
>>  +   it relies on a value in register 255 of the debug group, which is
>>  +   undocumented.
>>  +
>>  +   All the hardware trace has been removed for the time being. The new
>>  debug
>>  +   interface does not support hardware trace, so there is no plan to
>>  reinstate
>>  +   this functionality.
>>  +
>>  +   Support for multiple contexts (which was rudimentary, and not working)
>>  has
>>  +   been removed.*/
>>  +/*---------------------------------------------------------------------------*/
>>  +
>
> These comments/notes are not useful.  Please remove it.
>
>>  +
>>  +
>>  +/* Enum describing different kinds of breakpoints for or1k */
>>  +
>>  +enum or1k_breakpoint_kind
>>  +{
>>  +  /* 32-bit standard OpenRISC breakpoint */
>>  +  OR1K_BP_KIND_OR1K = 2,
>>  +};
>>  +
>>  +/* The gdbarch_tdep structure.  */
>>  +
>>  +/*! OR1K specific per-architecture information. Replaces
>>  +    struct_or1k_implementation. A lot of this info comes from the config
>>  regs,
>>  +    so cannot be put in place until we have the actual target. Up until
>>  then
>>  +    we have reasonable defaults. */
>>  +struct gdbarch_tdep
>>  +{
>>  +  unsigned int  num_matchpoints;	/* Total matchpoints available. */
>
> num_matchpoints is not used in this patch.  Can we remove it?
>
>>  +  unsigned int  num_gpr_regs;		/* Number of general
>>  registers.  */
>
> It is an invariant, OR1K_MAX_GPR_REGS.  We can use the macro directly.
>
>>  +  int           bytes_per_word;
>>  +  int           bytes_per_address;
>
> These two fields can be calculated from gdbarch_bfd_arch_info,
>
> (gdbarch_bfd_arch_info (gdbarch)->bits_per_word
>           / gdbarch_bfd_arch_info (gdbarch)->bits_per_byte)
>
> so, these fields are not needed.
>
>>  +  CGEN_CPU_DESC gdb_cgen_cpu_desc;
>>  +};
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Determine the return convention used for a given type
>>  +
>>  +   Optionally, fetch or set the return value via "readbuf" or "writebuf"
>>  +   respectively using "regcache" for the register values.
>>  +
>>  +   The OpenRISC 1000 returns scalar values via R11 and (for 64 bit values
>>  on
>>  +   32 bit architectures) R12. Structs and unions are returned by
>>  reference,
>>  +   with the address in R11
>>  +
>>  +   The result returned is independent of the function type, so we ignore
>>  that.
>>  +
>>  +   Throughout use read_memory(), not target_read_memory(), since the
>>  address
>>  +   may be invalid and we want an error reported (read_memory() is
>>  +   target_read_memory() with error reporting).
>>  +
>>  +   @todo This implementation is labelled OR1K, but in fact is just for
>>  the 32
>>  +         bit version, OR1K. This should be made explicit
>>  +
>>  +   @param[in]  gdbarch   The GDB architecture being used
>>  +   @param[in]  functype  The type of the function to be called (may be
>>  NULL)
>>  +   @param[in]  valtype   The type of the entity to be returned
>>  +   @param[in]  regcache  The register cache
>>  +   @param[in]  readbuf   Buffer into which the return value should be
>>  written
>>  +   @param[out] writebuf  Buffer from which the return value should be
>>  written
>>  +
>>  +   @return  The type of return value */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static enum return_value_convention
>>  +or1k_return_value (struct gdbarch  *gdbarch,
>>  +		   struct value    *functype,
>>  +		   struct type     *valtype,
>>  +		   struct regcache *regcache,
>>  +		   gdb_byte        *readbuf,
>>  +		   const gdb_byte  *writebuf)
>
>
> We don't document gdbarch method this way.  Instead, we document this
> way,
>
> /* Implement the return_value gdbarch method.  */
>
>>  +{
>>  +  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
>>  +  enum type_code  rv_type    = TYPE_CODE (valtype);
>>  +  unsigned int    rv_size    = TYPE_LENGTH (valtype);
>>  +  unsigned int    bpw        = (gdbarch_tdep (gdbarch))->bytes_per_word;
>>  +
>>  +  /* Deal with struct/union as addresses. If an array won't fit in a
>>  single
>>  +     register it is returned as address. Anything larger than 2 registers
>>  needs
>>  +     to also be passed as address (this is from gcc
>>  default_return_in_memory) */
>
> There should be two spaces after ".".  The comments ends with "." and
> two spaces.
>
>>  +  if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type) ||
>>  +      ((TYPE_CODE_ARRAY == rv_type) && rv_size > bpw) ||
>>  +      (rv_size > 2*bpw))
>
>
>      if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type)
>         | |  ((TYPE_CODE_ARRAY == rv_type) && rv_size > bpw)
>         | |  (rv_size > 2 * bpw))
>
> Please take a look at GNU coding standard,
> https://www.gnu.org/prep/standards/standards.html#Writing-C
>
>>  +    {
>>  +      if (readbuf)
>>  +	{
>>  +	  ULONGEST        tmp;
>
> "ULONGEST tmp;??, only one space between type and variable name.
>
>>  +
>>  +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
>>  +	  read_memory (tmp, readbuf, rv_size);
>>  +	}
>>  +      if (writebuf)
>>  +	{
>>  +	  ULONGEST        tmp;
>>  +
>>  +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
>>  +	  write_memory (tmp, writebuf, rv_size);
>>  +	}
>>  +
>>  +      return RETURN_VALUE_ABI_RETURNS_ADDRESS;
>>  +    }
>>  +
>>  +  if (rv_size <= bpw)
>>  +    {
>>  +      /* up to one word scalars are returned in R11 */
>>  +      if (readbuf)
>
> Check to NULL explicitly, "if (readbuf != NULL)"
>
>>  +	{
>>  +	  ULONGEST        tmp;
>>  +
>>  +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
>>  +	  store_unsigned_integer (readbuf, rv_size, byte_order, tmp);
>>  +
>>  +	}
>>  +      if (writebuf)
>>  +	{
>>  +	  gdb_byte buf[4];			/* TODO - fixed const! */
>
> Fix this TODO?
>
>>  +	  memset (buf, 0, sizeof (buf));	/* Zero pad if < bpw bytes */
>>  +
>>  +	  if (BFD_ENDIAN_BIG == byte_order)
>>  +	    {
>>  +	      memcpy (buf + sizeof (buf) - rv_size, writebuf, rv_size);
>>  +	    }
>>  +	  else
>>  +	    {
>>  +	      memcpy (buf,                          writebuf, rv_size);
>>  +	    }
>>  +
>>  +	  regcache_cooked_write (regcache, OR1K_RV_REGNUM, buf);
>>  +	}
>>  +    }
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Determine the kind of breakpoint based on the current pc
>>  +
>>  +   Given the pc address, return the type of breapoint that should be
>>  used.
>>  +   For or1k we only use one type which is a 32-bit trap instruction.
>>  +
>>  +   @param[in]  gdbarch  The GDB architecture being used
>>  +   @param[in]  pcptr    The program counter address in question
>>  +
>>  +   @return  The breakpoint type */
>>  +/*----------------------------------------------------------------------------*/
>>  +
>
> Again, we don't document gdbarch method this way.
>
>>  +static int
>>  +or1k_breakpoint_kind_from_pc (struct gdbarch *gdbarch, CORE_ADDR *pcptr)
>>  +{
>>  +  return OR1K_BP_KIND_OR1K;
>>  +}	/* or1k_breakpoint_kind_from_pc() */
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Determine the instruction to use for a breakpoint.
>>  +
>>  +   Given the address at which to insert a breakpoint (bp_addr), what will
>>  +   that breakpoint be?
>>  +
>>  +   For or1k, we have a breakpoint instruction. Since all or1k
>>  instructions
>>  +   are 32 bits, this is all we need, regardless of address.
>>  +
>>  +   @param[in]  gdbarch	The GDB architecture being used
>>  +   @param[in]  kind	The kind of breakpoint to be returned
>>  +   @param[out] size	The size of instruction selected
>>  +
>>  +   @return  The chosen breakpoint instruction */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static const gdb_byte *
>>  +or1k_sw_breakpoint_from_kind (struct gdbarch *gdbarch, int kind, int
>>  *size)
>>  +{
>>  +
>>  +  switch (kind)
>>  +    {
>>  +    case OR1K_BP_KIND_OR1K:
>>  +      {
>>  +        static const gdb_byte breakpoint[] = OR1K_BRK_INSTR_STRUCT;
>>  +
>>  +        *size = OR1K_INSTLEN;
>>  +        return breakpoint;
>>  +      }
>>  +    default:
>>  +      gdb_assert_not_reached ("unexpected or1k breakpoint kind");
>>  +    };
>>  +}	/* or1k_sw_breakpoint_from_kind() */
>
> or1k only has one breakpoint, so we can do something simpler.  Take a
> look at i386-tdep.c,
>
> constexpr gdb_byte i386_break_insn[] = { 0xcc }; /* int 3 */
>
> typedef BP_MANIPULATION (i386_break_insn) i386_breakpoint;
>
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Read a pseudo register
>>  +
>>  +   Since we have no pseudo registers this is a null function for now.
>>  +
>>  +   @todo The floating point and vector registers ought to be done as
>>  +         pseudo-registers.
>>  +
>>  +   @param[in]  gdbarch   The GDB architecture to consider
>>  +   @param[in]  regcache  The cached register values as an array
>>  +   @param[in]  regnum    The register to read
>>  +   @param[out] buf       A buffer to put the result in */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static enum register_status
>>  +or1k_pseudo_register_read (struct gdbarch  *gdbarch,
>>  +			   struct regcache *regcache,
>>  +			   int              regnum,
>>  +			   gdb_byte        *buf)
>>  +{
>>  +  return REG_UNKNOWN;
>
> Is it expected?
>
>>  +}	/* or1k_pseudo_register_read() */
>>  +
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Write a pseudo register
>>  +
>>  +   Since we have no pseudo registers this is a null function for now.
>>  +
>>  +   @todo The floating point and vector registers ought to be done as
>>  +         pseudo-registers.
>>  +
>>  +   @param[in] gdbarch   The GDB architecture to consider
>>  +   @param[in] regcache  The cached register values as an array
>>  +   @param[in] regnum    The register to read
>>  +   @param[in] buf       A buffer with the value to write */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static void
>>  +or1k_pseudo_register_write (struct gdbarch  *gdbarch,
>>  +			    struct regcache *regcache,
>>  +			    int              regnum,
>>  +			    const gdb_byte  *buf)
>>  +{
>>  +  return;
>
> Likewise.
>
>>  +
>>  +}	/* or1k_pseudo_register_write() */
>>  +
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Return the register name for the OpenRISC 1000 architecture
>>  +
>>  +   This version converted to ANSI C, made static and incorporates the
>>  static
>>  +   table of register names (this is the only place it is referenced).
>>  +
>>  +   @todo The floating point and vector registers ought to be done as
>>  +         pseudo-registers.
>
> We need to fix it....
>
>>  +
>>  +   @param[in] gdbarch  The GDB architecture being used
>>  +   @param[in] regnum    The register number
>>  +
>>  +   @return  The textual name of the register */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static const char *
>>  +or1k_register_name (struct gdbarch *gdbarch,
>>  +		    int             regnum)
>>  +{
>>  +  static char *or1k_gdb_reg_names[OR1K_NUM_REGS_CACHED] =
>>  +    {
>>  +      /* general purpose registers */
>>  +      "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>>  +      "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>>  +      "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>>  +      "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>>  +
>>  +      /* previous program counter, next program counter and status
>>  register */
>
> Comment is a sentence, should be ended with ".", and two spaces after
> it.  Many instances of this problem.
>
>>  +      "ppc",   "npc",   "sr"
>>  +
>>  +      /* Floating point and vector registers may appear as pseudo
>>  registers in
>>  +	 the future. */
>>  +    };
>>  +
>>  +  /* If we have a target description, use it */
>>  +  if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
>>  +    return tdesc_register_name (gdbarch, regnum);
>>  +  else
>>  +    {
>>  +      if (0 <= regnum && regnum < OR1K_NUM_REGS_CACHED)
>>  +	{
>>  +	  return or1k_gdb_reg_names[regnum];
>>  +	}
>>  +      else
>>  +	return NULL;
>>  +    }
>>  +
>>  +}	/* or1k_register_name() */
>>  +
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Identify the type of a register
>>  +
>>  +   @todo I don't fully understand exactly what this does, but I think
>>  this
>>  +         makes sense!
>
>
>
>>  +
>>  +   @param[in] arch     The GDB architecture to consider
>>  +   @param[in] regnum   The register to identify
>>  +
>>  +   @return  The type of the register */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static struct type *
>>  +or1k_register_type (struct gdbarch *arch,
>>  +		    int             regnum)
>>  +{
>>  +  static struct type *void_func_ptr = NULL;
>>  +  static struct type *void_ptr      = NULL;
>>  +
>>  +  /* Set up the static pointers once, the first time*/
>>  +  if (NULL == void_func_ptr)
>>  +    {
>>  +      struct type *void_type = builtin_type (arch)->builtin_void;
>>  +
>>  +      void_ptr      = lookup_pointer_type (void_type);
>>  +      void_func_ptr = lookup_pointer_type (lookup_function_type
>>  (void_type));
>
> Why don't you use builtin_type (gdbarch)->builtin_data_ptr and
> builtin_type (gdbarch)->builtin_func_ptr?
>
>>  +    }
>>  +
>>  +  if((regnum >= 0) && (regnum < OR1K_TOTAL_NUM_REGS))
>>  +    {
>>  +      switch (regnum)
>>  +	{
>>  +	case OR1K_PPC_REGNUM:
>>  +	case OR1K_NPC_REGNUM:
>>  +	  return void_func_ptr;			/* Pointer to code */
>>  +
>>  +	case OR1K_SP_REGNUM:
>>  +	case OR1K_FP_REGNUM:
>>  +	  return void_ptr;				/* Pointer to data */
>>  +
>>  +	default:
>>  +	  return builtin_type (arch)->builtin_uint32;	/* Data */
>>  +	}
>>  +    }
>>  +
>>  +  internal_error (__FILE__, __LINE__,
>>  +		  _("or1k_register_type: illegal register number %d"),
>>  regnum);
>>  +
>>  +}	/* or1k_register_type() */
>>  +
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Handle the "info register" command
>>  +
>>  +   Print the identified register, unless it is -1, in which case print
>>  all
>>  +   the registers. If all is 1 means all registers, otherwise only the
>>  core
>>  +   GPRs.
>>  +
>>  +   @todo At present all registers are printed with the default method.
>>  Should
>>  +         there be something special for FP registers?
>>  +
>>  +   @param[in] gdbarch  The GDB architecture being used
>>  +   @param[in] file     File handle for use with any custom I/O
>>  +   @param[in] frame    Frame info for use with custom output
>>  +   @param[in] regnum   Register of interest, or -1 if all registers
>>  +   @param[in] all      1 if all means all, 0 if all means just GPRs
>>  +
>>  +   @return  The aligned stack frame address */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static void
>>  +or1k_registers_info (struct gdbarch    *gdbarch,
>>  +		     struct ui_file    *file,
>>  +		     struct frame_info *frame,
>>  +		     int                regnum,
>>  +		     int                all)
>>  +{
>>  +  struct regcache *regcache = get_current_regcache ();
>>  +
>
> or1k_registers_info should print the registers contents from FRAME
> rather than current regcache.
>
>>  +  if (-1 == regnum)
>>  +    {
>>  +      /* Do all (valid) registers */
>>  +      unsigned int  lim = all ? OR1K_NUM_REGS_CACHED : OR1K_MAX_GPR_REGS;
>>  +
>>  +      for (regnum = 0; regnum < lim; regnum++) {
>>  +	if ('\0' != *(or1k_register_name (gdbarch, regnum)))
>>  +	  {
>>  +	    or1k_registers_info (gdbarch, file, frame, regnum, all);
>>  +	  }
>>  +      }
>>  +    }
>>  +  else
>>  +    {
>>  +      /* Do one specified register - if it is part of this architecture
>>  */
>>  +      if ((regnum < OR1K_NUM_REGS_CACHED)
>>  +	  && ('\0' == *(or1k_register_name (gdbarch, regnum))))
>>  +	{
>>  +	  error ("Not a valid register for the current processor type");
>>  +	}
>>  +      else
>>  +	{
>>  +	  /* If the register is not in the g/G packet, fetch it from the
>>  +	   * target with a p/P packet.
>>  +	   */
>>  +	  if (regnum >= OR1K_NUM_REGS_CACHED)
>>  +	    target_fetch_registers (regcache, regnum);
>
> Why is a register no in the g/G packet?  Again, we shouldn't fetch
> registers now.
>
>>  +
>>  +	  default_print_registers_info (gdbarch, file, frame, regnum, all);
>>  +	}
>>  +    }
>>  +}	/* or1k_registers_info() */
>>  +
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Identify if a register belongs to a specified group
>>  +
>>  +   Return true if the specified register is a member of the specified
>>  +   register group.
>>  +
>>  +   These are the groups of registers that can be displayed via "info
>>  reg".
>>  +
>>  +   @todo The Vector and Floating Point registers ought to be displayed as
>>  +         pseudo-registers.
>
> Need to fix it.
>
>>  +
>>  +/* Support functions for frame handling */
>>  +
>>  +/*
>>  --------------------------------------------------------------------------
>>  */
>>  +/*!Initialize a prologue cache
>>  +
>>  +   This function is changed from its GDB 6.8 version (named
>>  +   or1k_frame_unwind_cache), in that it is based on THIS frame, not the
>>  NEXT
>>  +   frame.
>
> This is not useful.
>
>>  +
>>  +
>>  +#if 0
>
> If this is not needed, remove it.
>
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Return the base address of the frame
>>  +
>>  +   The implementations has changed since GDB 6.8, since we are now
>>  provided
>>  +   with the address of THIS frame, rather than the NEXT frame.
>>  +
>>  +   For the OR1K, the base address is the frame pointer
>>  +
>>  +   @param[in] this_frame      The current stack frame.
>>  +   @param[in] prologue_cache  Any cached prologue for THIS function.
>>  +
>>  +   @return  The frame base address */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static CORE_ADDR
>>  +or1k_frame_base_address (struct frame_info  *this_frame,
>>  +			 void              **prologue_cache)
>>  +{
>>  +  return  (CORE_ADDR) get_frame_register_unsigned (this_frame,
>>  OR1K_FP_REGNUM);
>>  +
>>  +}	/* or1k_frame_base_address() */
>>  +
>>  +
>>  +/*
>>  --------------------------------------------------------------------------
>>  */
>>  +/*!Identify our frame base sniffer functions
>>  +
>>  +   This function just identifies our family of frame sniffing functions.
>>  +
>>  +   @param[in] this_frame  The frame of THIS function. Not used here.
>>  +
>>  +   @return  A pointer to a struct identifying the frame base sniffing
>>  +            functions.
>>  */
>>  +/*
>>  --------------------------------------------------------------------------
>>  */
>>  +static const struct frame_base *
>>  +or1k_frame_base_sniffer (struct frame_info *this_frame)
>>  +{
>>  +  /* Structure defining how the frame base is to be identified. */
>>  +  static const struct frame_base  or1k_frame_base =
>>  +    {
>>  +      .unwind      = &or1k_frame_unwind,
>>  +      .this_base   = or1k_frame_base_address,
>>  +      .this_locals = or1k_frame_base_address,
>>  +      .this_args   = or1k_frame_base_address
>>  +    };
>>  +
>>  +  return &or1k_frame_base;
>>  +
>>  +}	/* or1k_frame_base_sniffer () */
>>  +#endif
>>  +
>>  +/* Iterate over core file register note sections.  */
>>  +static void
>>  +or1k_iterate_over_regset_sections (struct gdbarch *gdbarch,
>>  +				   iterate_over_regset_sections_cb *cb,
>>  +                                   void *cb_data,
>>  +                                   const struct regcache *regcache)
>>  +{
>>  +  // TODO: Do we need to put something here? (wallento)
>
> Yes, you need.  'grep iterate_over_regset_sections *.c', and see how
> other arch does.
>
>>  +}
>
> This function should be move to or1k-linux-tdep.c
>
>>  +
>>  +/*
>>  --------------------------------------------------------------------------
>>  */
>>  +/*!Architecture initialization for OpenRISC 1000
>>  +
>>  +   Looks for a candidate architecture in the list of architectures
>>  supplied
>>  +   using the info supplied. If none match, create a new architecture.
>>  +
>>  +   @param[in] info    Information about the target architecture
>>  +   @param[in] arches  The list of currently know architectures
>>  +
>>  +   @return  A structure describing the target architecture
>>  */
>>  +/*
>>  --------------------------------------------------------------------------
>>  */
>>  +static struct gdbarch *
>>  +or1k_gdbarch_init (struct gdbarch_info  info,
>>  +		   struct gdbarch_list *arches)
>>  +{
>>  +
>>  +#if 0
>>  +  /* Set up sniffers for the frame base. Use DWARF debug info if
>>  available,
>>  +     otherwise use our own sniffer. */
>>  +  frame_base_append_sniffer (gdbarch, dwarf2_frame_base_sniffer);
>>  +  frame_base_append_sniffer (gdbarch, or1k_frame_base_sniffer);
>>  +#endif
>
> This can be removed.
>
>>  +
>>  +  /* Handle core files */
>>  +  set_gdbarch_iterate_over_regset_sections (gdbarch,
>>  or1k_iterate_over_regset_sections);
>>  +
>>  +  /* Frame unwinders. Use DWARF debug info if available, otherwise use
>>  our
>>  +     own unwinder. */
>>  +  dwarf2_append_unwinders (gdbarch);
>>  +  frame_unwind_append_unwinder (gdbarch, &or1k_frame_unwind);
>>  +
>>  +  /* Get a CGEN CPU descriptor for this architecture.  */
>>  +  {
>>  +
>>  +    const char *mach_name = binfo->printable_name;
>>  +    enum cgen_endian endian = (info.byte_order == BFD_ENDIAN_BIG
>>  +                               ? CGEN_ENDIAN_BIG
>>  +                               : CGEN_ENDIAN_LITTLE);
>>  +
>>  +    tdep->gdb_cgen_cpu_desc = or1k_cgen_cpu_open (CGEN_CPU_OPEN_BFDMACH,
>>  mach_name,
>>  +                                        CGEN_CPU_OPEN_ENDIAN, endian,
>>  +                                        CGEN_CPU_OPEN_END);
>>  +
>>  +    or1k_cgen_init_asm (tdep->gdb_cgen_cpu_desc);
>>  +  }
>>  +
>>  +  /* If this mach as delay slot */
>>  +  if (binfo->mach == bfd_mach_or1k)
>>  +    {
>>  +      set_gdbarch_single_step_through_delay
>>  +                                    (gdbarch,
>>  or1k_single_step_through_delay);
>>  +    }
>>  +
>>  + /* Check any target description for validity.  */
>>  +  if (tdesc_has_registers (info.target_desc))
>>  +    {
>>  +
>>  +      const struct tdesc_feature *feature;
>>  +      int total_regs = 0;
>>  +      int nb_features;
>>  +      char feature_name[30];
>>  +
>>  +      tdesc_data = tdesc_data_alloc ();
>>  +
>>  +      /* OpenRisc architecture manual define a maximum of 32 registers
>>  groups */
>>  +      for (group = 0; group < 32; group++)
>>  +	{
>>  +
>>  +	  sprintf (feature_name, "org.gnu.gdb.or1k.group%d", group);
>>  +	  feature = tdesc_find_feature (info.target_desc, feature_name);
>>  +
>>  +	  retval =
>>  +	    get_feature_registers (feature, tdesc_data, &reg_index, gdbarch);
>>  +
>>  +	  if (retval < 0)
>>  +	    {
>>  +	      tdesc_data_cleanup (tdesc_data);
>>  +	      return NULL;
>>  +	    }
>>  +	  else
>>  +	    {
>>  +	      total_regs += retval;
>>  +	      if (retval && gdbarch_debug)
>>  +		fprintf_unfiltered (gdb_stdout,
>>  +				    "Found %4d registers in feature %s\n",
>>  +				    retval, feature_name);
>>  +	    }
>>  +	}
>
> I don't fully understand what you want to achieve here, can you
> elaborate?  What do these features look alike?
>
>>  +      if (gdbarch_debug)
>>  +	fprintf_unfiltered (gdb_stdout,
>>  +			    "Found %4d registers in the tdesc file\n",
>>  +			    total_regs);
>>  +
>>  +      if (!total_regs)
>>  +	{
>>  +	  tdesc_data_cleanup (tdesc_data);
>>  +	  return NULL;
>>  +	}
>>  +    }
>>  +
>>  +  if (tdesc_data)
>>  +    {
>>  +      tdesc_use_registers (gdbarch, info.target_desc, tdesc_data);

**SNIP**

>>  +  long int           len;
>>  +
>>  +  /* Create the command string and pass it to target remote command
>>  function */
>>  +  sprintf (cmd, "readspr %4x", regnum);
>>  +  target_rcmd (cmd, uibuf);
>
> Why don't you put these special purpose register to g packet, so that
> we can read them through g packet?  It is not a good idea to extend rcmd this 
> way.
>
>>  +
>>  +  /* Get the output for the UI file as a string */
>>  +  res = ui_file_xstrdup (uibuf, &len);
>>  +  sscanf (res, "%lx", &data);
>>  +
>>  +  /* Tidy up */
>>  +  xfree (res);
>>  +  ui_file_delete (uibuf);
>>  +
>>  +  return  (ULONGEST)data;
>>  +
>>  +}	/* or1k_read_spr() */
>>  +
>>  +
>>  +/*----------------------------------------------------------------------------*/
>>  +/*!Show the value of a special purpose register or group
>>  +
>>  +   This is a custom extension to the GDB info command.
>>  +
>>  +   @param[in] args
>>  +   @param[in] from_tty  True (1) if GDB is running from a TTY, false (0)
>>  +   otherwise. */
>>  +/*---------------------------------------------------------------------------*/
>>  +
>>  +static void
>>  +or1k_info_spr_command (char *args,
>>  +		       int   from_tty)
>>  +{
>>  +  int  group;
>>  +  int  index;
>>  +  struct ui_out *uiout = current_uiout;
>>  +  char  spr_name[32];
>>  +
>>  +  or1k_parse_spr_params (args, &group, &index, 0);
>>  +
>
> Could you explain what do you want to do for special purpose
> register/group here?
>
>>  +  if (group < 0)
>>  +    {
>>  +      return;			/* Couldn't parse the args */
>>  +    }
>>  +
>>  +  if (index >= 0)
>>  +    {
>>  +      ULONGEST  value = or1k_read_spr (OR1K_SPR (group, index));
>>  +
>>  +      ui_out_field_fmt (uiout, NULL, "%s.%s = SPR%i_%i = %llu
>>  (0x%llx)\n",
>>  +			or1k_spr_group_name (group),
>>  +			or1k_spr_register_name (group, index, spr_name),
>>  group,
>>  +			index, (long long unsigned int)value, (long long
>>  unsigned int)value);
>>  +    }
>>  +  else
>>  +    {
>>  +      /* Print all valid registers in the group */
>>  +      for (index = 0; index < OR1K_SPG_SIZE; index++)
>>  +	{
>>  +	  if (0 != strlen (or1k_spr_register_name (group, index, spr_name)))
>>  +	    {
>>  +	      ULONGEST  value = or1k_read_spr (OR1K_SPR (group, index));
>>  +
>>  +	      ui_out_field_fmt (uiout, NULL,
>>  +				"%s.%s = SPR%i_%i = %llu (0x%llx)\n",
>>  +				or1k_spr_group_name (group),
>>  +				or1k_spr_register_name (group, index,
>>  spr_name),
>>  +				group, index, (long long unsigned int)value,
>>  (long long unsigned int)value);
>>  +	    }
>>  +	}
>>  +    }
>>  +}	/* or1k_info_spr_command() */
>>  +
>>  +
>>  diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
>>  new file mode 100644
>>  index 0000000..f0afc8f
>>  --- /dev/null
>>  +++ b/gdb/or1k-tdep.h
>>  @@ -0,0 +1,434 @@
>>  +/* Definitions to target GDB to OpenRISC 1000 32-bit targets.
>>  +
>>  +   Copyright 2001 Free Software Foundation, Inc.
>>  +   Copyright (C) 2008, 2010 Embecosm Limited
>
> Copyright year and copyright owner.
>
>>  +
>>  +/*-----------------------------------------------------------------------------
>>  +   This version for the OpenRISC 1000 architecture is a rewrite by Jeremy
>>  +   Bennett of the old GDB 5.3 interface to make use of gdbarch for GDB
>>  6.8.
>>  +
>>  +   The code tries to follow the GDB coding style. All OR1K specific
>>  globals
>>  +   should have names beginning ork1_ or OR1K_.
>>  +
>>  +   Commenting is Doxygen compatible.
>>  +
>>  +   Much has been stripped out. See the files or1k-tdep.c, remote-or1k.c
>>  and
>>  +   or1k-jtag.c for details of what has changed.
>
> This comment is out of date.
>
>>  +
>>  --------------------------------------------------------------------------*/
>>  +
>>  +
>>  +/*! Byte array for the TRAP instruction used for breakpoints */
>>  +#define OR1K_BRK_INSTR_STRUCT  {0x21, 0x00, 0x00, 0x01}
>>  +/*! Numeric instruction used for a breakpoint */
>>  +#define OR1K_BRK_INSTR 0x21000001
>>  +
>>  +/*! Numeric instruction used for a l.nop NOP_EXIT */
>>  +#define  OR1K_NOP_EXIT 0x15000001
>
> They are only used in or1k-tdep.c, so we can move them there.
>
>>  +
>>  +/* Special purpose groups */
>>  +
>>  +#define OR1K_SPG_SIZE_BITS  11
>>  +#define OR1K_SPG_SIZE       (1 << OR1K_SPG_SIZE_BITS)
>>  +
>>  +#define OR1K_SPG_SYS      0
>>  +#define OR1K_SPG_DMMU     1
>>  +#define OR1K_SPG_IMMU     2
>>  +#define OR1K_SPG_DC       3
>>  +#define OR1K_SPG_IC       4
>>  +#define OR1K_SPG_MAC      5
>>  +#define OR1K_SPG_DEBUG    6
>>  +#define OR1K_SPG_PC       7
>>  +#define OR1K_SPG_PM       8
>>  +#define OR1K_SPG_PIC      9
>>  +#define OR1K_SPG_TT      10
>>  +#define OR1K_SPG_FPU     11
>>  +
>>  +#define OR1K_NUM_SPGS   (OR1K_SPG_FPU + 1)
>>  +
>>  +/* Special register group offsets */
>>  +
>>  +#define OR1K_SPG_SYS_VR          0
>>  +#define OR1K_SPG_SYS_UPR         1

** SNIP **

>>  +#define OR1K_MAX_HW_WATCHES          OR1K_MAX_MATCHPOINTS
>>  +#define OR1K_STACK_ALIGN             4
>>  +#define OR1K_INSTLEN                 4
>>  +#define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
>>  +#define OR1K_NUM_TAP_RECORDS         8
>>  +#define OR1K_FRAME_RED_ZONE_SIZE     2536
>>  +
>>  +/* OR1K exception vectors */
>>  +
>>  +#define OR1K_RESET_VECTOR   0x100
>>  +#define OR1K_BUSERR_VECTOR  0x200
>>  +#define OR1K_DPF_VECTOR     0x300
>>  +#define OR1K_IPF_VECTOR     0x400
>>  +#define OR1K_TT_VECTOR      0x500
>>  +#define OR1K_ALIGN_VECTOR   0x600
>>  +#define OR1K_ILL_VECTOR     0x700
>>  +#define OR1K_EXT_VECTOR     0x800
>>  +#define OR1K_DTLB_VECTOR    0x900
>>  +#define OR1K_ITLB_VECTOR    0xa00
>>  +#define OR1K_RANGE_VECTOR   0xb00
>>  +#define OR1K_SYS_VECTOR     0xc00
>>  +#define OR1K_FP_VECTOR      0xd00
>>  +#define OR1K_TRAP_VECTOR    0xe00
>
> These macros are not used, AFAICS, why do you define them?
>
>>  +
>>  +/* Constants and macros to break out instruction fields. I'd expect these
>>  in
>>  +   the assembler header, but they aren't there (for now). */
>
>
> I don't see how these macros below are used.  If they are not used,
> don't define them.  If they are used, define them in include/opcode
> or opcodes/or1k-*.h
>
>>  +
>>  +#define OR1K_SEXT16(v) (((v) & 0x00008000) ? ((v) - 0x00010000) : (v))
>>  +#define OR1K_SEXT26(v) (((v) & 0x02000000) ? ((v) - 0x04000000) : (v))
>>  +
>>  +#define OR1K_OPCODE1(i)  (((i) & 0xfc000000) >> 26)
>>  +#define OR1K_OPCODE2(i) ((((i) & 0xfc000000) >> 20) | \
>>  +			 (((i) & 0x00000300) >>  6) | \
>>  +			  ((i) & 0x0000000f))
>>  +#define OR1K_OPCODE3(i) ((((i) & 0xfc000000) >> 24) | \
>>  +			 (((i) & 0x000000c0) >> 6))
>>  +#define OR1K_OPCODE4(i) ((((i) & 0xfc000000) >> 18) | \
>>  +			 (((i) & 0x000003c0) >>  2) | \
>>  +			  ((i) & 0x0000000f))
>>  +#define OR1K_OPCODE5(i)  (((i) & 0xffff0000) >> 16)
>>  +#define OR1K_OPCODE6(i)  (((i) & 0xff000000) >> 24)
>>  +#define OR1K_OPCODE7(i)  (((i) & 0xfc000000) >> 21)
>>  +#define OR1K_D_REG(i)    (((i) & 0x03e00000) >> 21)
>>  +#define OR1K_A_REG(i)    (((i) & 0x001f0000) >> 16)
>>  +#define OR1K_B_REG(i)    (((i) & 0x0000f800) >> 11)
>>  +#define OR1K_IMM(i)      (OR1K_SEXT16((i) & 0x0000ffff))
>>  +#define OR1K_IMM2(i)     (OR1K_SEXT16((((i) & 0x03e00000) >> 10) |	\
>>  +				       ((i) & 0x000003ff)))
>>  +#define OR1K_OFFSET(i)    (OR1K_SEXT26((i) & 0x03ffffff) ))
>>  +#define OR1K_SHIFT(i)     ((i) & 0x0000003f)
>>  +
>>  +/* The instruction opcodes */
>>  +
>>  +#define OR1K_OP_ADD     0xe00	/* Type 2 */
>>  +#define OR1K_OP_ADDC    0xe01	/* Type 2 */
>>  +#define OR1K_OP_ADDI     0x27	/* Type 1 */
>>  +#define OR1K_OP_AND     0xe03	/* Type 2 */
>>  +#define OR1K_OP_ANDI     0x29	/* Type 1 */
>>  +#define OR1K_OP_BF       0x04	/* Type 1 */
>>  +#define OR1K_OP_BNF      0x03	/* Type 1 */
>>  +#define OR1K_OP_TRAP   0x2100	/* Type 5 */
>>  +#define OR1K_OP_J        0x00	/* Type 1 */
>>  +#define OR1K_OP_JAL      0x01	/* Type 1 */
>>  +#define OR1K_OP_JALR     0x12	/* Type 1 */
>>  +#define OR1K_OP_JR       0x11	/* Type 1 */
>>  +#define OR1K_OP_LBS      0x24   /* Type 1 */
>>  +#define OR1K_OP_LBZ      0x23   /* Type 1 */
>>  +#define OR1K_OP_LHS      0x26   /* Type 1 */
>>  +#define OR1K_OP_LHZ      0x25   /* Type 1 */
>>  +#define OR1K_OP_LWS      0x22   /* Type 1 */
>>  +#define OR1K_OP_LWZ      0x21   /* Type 1 */
>>  +#define OR1K_OP_MFSPR    0x07   /* Type 1 */
>>  +#define OR1K_OP_MOVHI    0x06   /* Type 1 */
>>  +#define OR1K_OP_MTSPR    0x10   /* Type 1 */
>>  +#define OR1K_OP_MUL     0xe36   /* Type 2 */
>>  +#define OR1K_OP_MULI     0x2c   /* Type 1 */
>>  +#define OR1K_OP_MULU    0xe3b   /* Type 2 */
>>  +#define OR1K_OP_NOP      0x15   /* Type 6 */
>>  +#define OR1K_OP_OR      0xe04	/* Type 2 */
>>  +#define OR1K_OP_ORI      0x2a   /* Type 1 */
>>  +#define OR1K_OP_RFE      0x09   /* Type 1 */
>>  +#define OR1K_OP_RORI     0xe3   /* Type 3 */
>>  +#define OR1K_OP_SB       0x36   /* Type 1 */
>>  +#define OR1K_OP_SFEQ    0x720   /* Type 7 */
>>  +#define OR1K_OP_SFGES   0x72b   /* Type 7 */
>>  +#define OR1K_OP_SFGEU   0x723   /* Type 7 */
>>  +#define OR1K_OP_SFGTS   0x72a   /* Type 7 */
>>  +#define OR1K_OP_SFGTU   0x722   /* Type 7 */
>>  +#define OR1K_OP_SFLES   0x72d   /* Type 7 */
>>  +#define OR1K_OP_SFLEU   0x725   /* Type 7 */
>>  +#define OR1K_OP_SFLTS   0x72c   /* Type 7 */
>>  +#define OR1K_OP_SFLTU   0x724   /* Type 7 */
>>  +#define OR1K_OP_SFNE    0x721   /* Type 7 */
>>  +#define OR1K_OP_SLL    0x3808   /* Type 4 */
>>  +#define OR1K_OP_SLLI     0xe0   /* Type 3 */
>>  +#define OR1K_OP_SRA    0x3828   /* Type 4 */
>>  +#define OR1K_OP_SRAI     0xe2   /* Type 3 */
>>  +#define OR1K_OP_SRL    0x3818   /* Type 4 */
>>  +#define OR1K_OP_SRLI     0xe1   /* Type 3 */
>>  +#define OR1K_OP_SUB     0xe02   /* Type 2 */
>>  +#define OR1K_OP_SW       0x35   /* Type 1 */
>>  +#define OR1K_OP_SYS    0x2000   /* Type 5 */
>>  +#define OR1K_OP_XOR     0xe05   /* Type 2 */
>>  +#define OR1K_OP_XORI     0x2b   /* Type 1 */
>>  +
>>  +#endif /* OR1K_TDEP__H */
>>  --
>>  2.7.4
>> 
>
> -- 
> Yao
>
>

