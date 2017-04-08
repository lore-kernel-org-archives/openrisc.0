From: Stafford Horne <shorne@gmail.com>
Date: Sat, 8 Apr 2017 18:36:33 +0900
Subject: [OpenRISC] [PATCH v5 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <86wpaz6ffa.fsf@gmail.com>
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <61be7be503333904f9533549b0a809bed4066ac3.1489728533.git.shorne@gmail.com>
 <86wpaz6ffa.fsf@gmail.com>
Message-ID: <20170408093633.GC2194@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Yao,

Thanks for reviewing, I had a few of these fixed already, but I havent
had time to send a new series.  I hope I can get around to it and these
in a week or so.

On Tue, Apr 04, 2017 at 10:17:29PM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> Hi Stafford,
> Have some cycles today, so I can review the patch.
> 
> > +/* The target-dependent structure for gdbarch.  */
> > +
> > +struct gdbarch_tdep
> > +{
> > +  int bytes_per_word;
> > +  int bytes_per_address;
> 
> Don't need these two fields, we can get bfd_arch_info via
> gdbarch_bfd_arch_info (gdbarch), and access its fields to compute
> bytes_per_word and bytes_per_address.

These are computed that way in or1k_gdbarch_init():

  tdep->bytes_per_word = binfo->bits_per_word / binfo->bits_per_byte;
  tdep->bytes_per_address = binfo->bits_per_address / binfo->bits_per_byte;

The idea is that these are used a few times to its better for
readability to not have to compute every time.

I would prefer to keep.

> > +  CGEN_CPU_DESC gdb_cgen_cpu_desc;
> > +};
> > +
> > +/* Support functions for the architecture definition.  */
> > +
> > +/* Get an instruction from memory.  */
> > +
> > +static ULONGEST
> > +or1k_fetch_instruction (struct gdbarch *gdbarch, CORE_ADDR addr)
> > +{
> > +  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
> > +  gdb_byte buf[OR1K_INSTLEN];
> > +
> > +  if (target_read_memory (addr, buf, OR1K_INSTLEN)) {
> 
> target_read_code, it uses cache, and helps on performance.

OK, thanks

> > +    memory_error (TARGET_XFER_E_IO, addr);
> > +  }
> > +
> > +  return extract_unsigned_integer (buf, OR1K_INSTLEN, byte_order);
> > +}
> > +
> 
> > +
> > +	  /* Check we got something, and if so skip on.  */
> > +	  if (start_ptr == end_ptr)
> > +	    throw_quit ("bitstring \"%s\" at offset %d has no length field.\n",
> > +			format, i);
> 
> s/throw_quit/error/
> multiple instances of this.

OK

> > +/* Analyze a l.addi instruction in form: l.addi  rD,rA,I.  This is used
> > +   to parse add instructions during various prologue analysis routines.  */
> > +
> 
> Document the argument and return value.

OK

> > +static int
> 
> static bool

OK, I guess more instances of this

> > +or1k_analyse_l_addi (uint32_t inst, unsigned int *rd_ptr,
> > +		     unsigned int *ra_ptr, int *simm_ptr)
> > +{
> > +  /* Instruction fields */
> > +  uint32_t rd, ra, i;
> > +
> > +  if (or1k_analyse_inst (inst, "10 0111 %5b %5b %16b", &rd, &ra, &i))
> > +    {
> > +      /* Found it.  Construct the result fields.  */
> > +      *rd_ptr = (unsigned int) rd;
> > +      *ra_ptr = (unsigned int) ra;
> > +      *simm_ptr = (int) (((i & 0x8000) == 0x8000) ? 0xffff0000 | i : i);
> > +
> > +      return 1; /* Success */
> > +    }
> > +  else
> > +    return 0; /* Failure */
> > +}
> > +
> 
> > +/* Functions defining the architecture.  */
> 
> What is this?

Its just a code section comment. i.e. the previous section was

 /* Support functions for the architecture definition.  */

I would prefer to keep.

> > +
> > +/* Implement the return_value gdbarch method.  */
> > +
> > +static enum return_value_convention
> > +or1k_return_value (struct gdbarch *gdbarch, struct value *functype,
> > +		   struct type *valtype, struct regcache *regcache,
> > +		   gdb_byte *readbuf, const gdb_byte *writebuf)
> > +{
> > +  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
> > +  enum type_code rv_type = TYPE_CODE (valtype);
> > +  unsigned int rv_size = TYPE_LENGTH (valtype);
> > +  int bpw = (gdbarch_tdep (gdbarch))->bytes_per_word;
> > +
> > +  /* Deal with struct/union as addresses.  If an array won't fit in a single
> > +     register it is returned as address.  Anything larger than 2 registers needs
> > +     to also be passed as address (matches gcc default_return_in_memory).  */
> > +  if ((TYPE_CODE_STRUCT == rv_type) || (TYPE_CODE_UNION == rv_type)
> > +      || ((TYPE_CODE_ARRAY == rv_type) && (rv_size > bpw))
> > +      || (rv_size > 2 * bpw))
> 
> If I read the comment and code correctly, register size is
> "bytes_per_word", and bytes_per_address is added in gdbarch_tdep.  Does
> this imply that register size may be different (in bytes) on different
> processors?

It currently will be 4 for 32-bit and the spec doesnt define return
values for 64-bit architectures, but this code does seem to assume that
64-bit architectures would follow the same convention.

> > +    {
> > +      if (readbuf != NULL)
> > +	{
> > +	  ULONGEST tmp;
> > +
> > +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
> > +	  read_memory (tmp, readbuf, rv_size);
> > +	}
> > +      if (writebuf != NULL)
> > +	{
> > +	  ULONGEST tmp;
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
> > +      /* Up to one word scalars are returned in R11.  */
> > +      if (readbuf != NULL)
> > +	{
> > +	  ULONGEST tmp;
> > +
> > +	  regcache_cooked_read_unsigned (regcache, OR1K_RV_REGNUM, &tmp);
> > +	  store_unsigned_integer (readbuf, rv_size, byte_order, tmp);
> > +
> > +	}
> > +      if (writebuf != NULL)
> > +	{
> > +	  gdb_byte buf[4];
> 
> Overflow if bpw is greater than 4?

Good catch, I think we can calloc(1, bpw) and free().

> > +	  memset (buf, 0, sizeof (buf)); /* Zero pad if < bpw bytes.  */
> > +
> > +	  if (BFD_ENDIAN_BIG == byte_order)
> > +	    memcpy (buf + sizeof (buf) - rv_size, writebuf, rv_size);
> > +	  else
> > +	    memcpy (buf, writebuf, rv_size);
> > +
> > +	  regcache_cooked_write (regcache, OR1K_RV_REGNUM, buf);
> > +	}
> > +    }
> > +  else
> > +    {
> > +      /* 2 word scalars are returned in r11/r12 (with the MS word in r11).  */
> 
> 
> > +
> > +/* OR1K always uses a l.trap instruction for breakpoints.  */
> > +
> > +constexpr gdb_byte or1k_break_insn[] = {0x21, 0x00, 0x00, 0x01};
> > +
> > +typedef BP_MANIPULATION (or1k_break_insn) or1k_breakpoint;
> > +
> > +/* Implement the single_step_through_delay gdbarch method.  */
> > +
> > +static int
> > +or1k_single_step_through_delay (struct gdbarch *gdbarch,
> > +				struct frame_info *this_frame)
> > +{
> > +  ULONGEST val;
> > +  CORE_ADDR ppc;
> > +  CORE_ADDR npc;
> > +  CGEN_FIELDS tmp_fields;
> > +  const CGEN_INSN *insn;
> > +  struct regcache *regcache = get_current_regcache ();
> > +  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
> > +
> > +  /* Get and the previous and current instruction addresses.  If they are not
> 
> This line is too long.

OK

> > +
> > +/* Name for or1k general registers.  */
> > +
> > +static const char *const or1k_reg_names[OR1K_NUM_REGS] = {
> > +  /* general purpose registers */
> > +  "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> > +  "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
> > +  "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> > +  "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> > +
> > +  /* previous program counter, next program counter and status register */
> > +  "ppc", "npc", "sr"
> > +};
> > +
> > +/* Implement the register_name gdbarch method.  */
> > +
> > +static const char *
> > +or1k_register_name (struct gdbarch *gdbarch, int regnum)
> > +{
> > +  if (0 <= regnum && regnum < OR1K_NUM_REGS)
> > +    return or1k_reg_names[regnum];
> > +  else
> > +    return NULL;
> > +}
> > +
> 
> Register names can be from target description, so we don't need this
> function.

Right, now that I have added target-desc it not needed.

> > +/* Implement the register_type gdbarch method.  */
> > +
> > +static struct type *
> > +or1k_register_type (struct gdbarch *gdbarch, int regnum)
> > +{
> > +  if ((regnum >= 0) && (regnum < OR1K_NUM_REGS))
> > +    {
> > +      switch (regnum)
> > +	{
> > +	case OR1K_PPC_REGNUM:
> > +	case OR1K_NPC_REGNUM:
> > +	  return builtin_type (gdbarch)->builtin_func_ptr; /* Pointer to code */
> > +
> > +	case OR1K_SP_REGNUM:
> > +	case OR1K_FP_REGNUM:
> > +	  return builtin_type (gdbarch)->builtin_data_ptr; /* Pointer to data */
> > +
> > +	default:
> > +	  return builtin_type (gdbarch)->builtin_uint32; /* Data */
> > +	}
> > +    }
> > +
> > +  internal_error (__FILE__, __LINE__,
> > +		  _("or1k_register_type: illegal register number %d"),
> > +		  regnum);
> > +}
> > +
> 
> Likewise.

Yes

> > +/* Implement the register_reggroup_p gdbarch method.  */
> > +
> > +static int
> > +or1k_register_reggroup_p (struct gdbarch *gdbarch,
> > +			  int regnum, struct reggroup *group)
> > +{
> > +  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
> > +
> > +  /* All register group.  */
> > +  if (group == all_reggroup)
> > +    return ((regnum >= 0)
> > +	    && (regnum < OR1K_NUM_REGS)
> > +	    && (or1k_register_name (gdbarch, regnum)[0] != '\0'));
> > +
> > +  /* For now everything except the PC.  */
> > +  if (group == general_reggroup)
> > +    return ((regnum >= OR1K_ZERO_REGNUM)
> > +	    && (regnum < OR1K_MAX_GPR_REGS)
> > +	    && (regnum != OR1K_PPC_REGNUM) && (regnum != OR1K_NPC_REGNUM));
> > +
> > +  if (group == float_reggroup)
> > +    return 0; /* No float regs */
> > +
> > +  if (group == vector_reggroup)
> > +    return 0; /* No vector regs */
> > +
> > +  /* For any that are not handled above.  */
> > +  return default_register_reggroup_p (gdbarch, regnum, group);
> > +}
> > +
> 
> Likewise.

Yes

> > +static int
> > +or1k_is_arg_reg (unsigned int regnum)
> > +{
> > +  return (OR1K_FIRST_ARG_REGNUM <= regnum)
> > +    && (regnum <= OR1K_LAST_ARG_REGNUM);
> > +}
> > +
> > +static int
> > +or1k_is_callee_saved_reg (unsigned int regnum)
> > +{
> > +  return (OR1K_FIRST_SAVED_REGNUM <= regnum) && (0 == regnum % 2);
> > +}
> > +
> > +/* Implement the skip_prologue gdbarch method.  */
> > +
> > +static CORE_ADDR
> > +or1k_skip_prologue (struct gdbarch *gdbarch, CORE_ADDR pc)
> > +{
> > +  CORE_ADDR start_pc;
> > +  CORE_ADDR addr;
> > +  uint32_t inst;
> > +
> > +  unsigned int ra, rb, rd; /* for instruction analysis */
> > +  int simm;
> > +
> > +  int frame_size = 0;
> > +
> > +  /* Try using SAL first if we have symbolic information available.  This only
> > +     works for DWARF 2, not STABS.  */
> > +
> > +  if (find_pc_partial_function (pc, NULL, &start_pc, NULL))
> > +    {
> > +      CORE_ADDR prologue_end = skip_prologue_using_sal (gdbarch, pc);
> > +
> > +      if (0 != prologue_end)
> > +	{
> > +	  struct symtab_and_line prologue_sal = find_pc_line (start_pc, 0);
> > +	  struct compunit_symtab *compunit
> > +	    = SYMTAB_COMPUNIT (prologue_sal.symtab);
> > +	  const char *debug_format = COMPUNIT_DEBUGFORMAT (compunit);
> > +
> > +	  if ((NULL != debug_format)
> > +	      && (strlen ("dwarf") <= strlen (debug_format))
> > +	      && (0 == strncasecmp ("dwarf", debug_format, strlen ("dwarf"))))
> > +	    return (prologue_end > pc) ? prologue_end : pc;
> > +	}
> > +    }
> > +
> > +  /* Look to see if we can find any of the standard prologue sequence.  All
> > +     quite difficult, since any or all of it may be missing.  So this is just a
> 
> This line is too long.

OK

> > +     best guess!  */
> > +
> > +  addr = pc; /* Where we have got to */
> > +  inst = or1k_fetch_instruction (gdbarch, addr);
> > +
> > +  /* Look for the new stack pointer being set up.  */
> > +  if (or1k_analyse_l_addi (inst, &rd, &ra, &simm)
> > +      && (OR1K_SP_REGNUM == rd) && (OR1K_SP_REGNUM == ra)
> > +      && (simm < 0) && (0 == (simm % 4)))
> > +    {
> > +      frame_size = -simm;
> > +      addr += OR1K_INSTLEN;
> > +      inst = or1k_fetch_instruction (gdbarch, addr);
> > +    }
> > +
> > +  /* Look for the frame pointer being manipulated.  */
> > +  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
> > +      && (OR1K_SP_REGNUM == ra) && (OR1K_FP_REGNUM == rb)
> > +      && (simm >= 0) && (0 == (simm % 4)))
> > +    {
> > +      addr += OR1K_INSTLEN;
> > +      inst = or1k_fetch_instruction (gdbarch, addr);
> > +
> > +      gdb_assert (or1k_analyse_l_addi (inst, &rd, &ra, &simm)
> > +		  && (OR1K_FP_REGNUM == rd) && (OR1K_SP_REGNUM == ra)
> > +		  && (simm == frame_size));
> > +
> > +      addr += OR1K_INSTLEN;
> > +      inst = or1k_fetch_instruction (gdbarch, addr);
> > +    }
> > +
> > +  /* Look for the link register being saved.  */
> > +  if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
> > +      && (OR1K_SP_REGNUM == ra) && (OR1K_LR_REGNUM == rb)
> > +      && (simm >= 0) && (0 == (simm % 4)))
> > +    {
> > +      addr += OR1K_INSTLEN;
> > +      inst = or1k_fetch_instruction (gdbarch, addr);
> > +    }
> > +
> > +  /* Look for arguments or callee-saved register being saved.  The register
> > +     must be one of the arguments (r3-r8) or the 10 callee saved registers
> > +     (r10, r12, r14, r16, r18, r20, r22, r24, r26, r28, r30).  The base
> > +     register must be the FP (for the args) or the SP (for the callee_saved
> > +     registers).  */
> > +  while (1)
> 
> Can you give an upper-bound of the loop?  The endless loop looks scary
> to me.

OK, ill look for another way to do it. If not I'll revert with more
comments.

> > +    {
> > +      if (or1k_analyse_l_sw (inst, &simm, &ra, &rb)
> > +	  && (((OR1K_FP_REGNUM == ra) && or1k_is_arg_reg (rb))
> > +	      || ((OR1K_SP_REGNUM == ra) && or1k_is_callee_saved_reg (rb)))
> > +	  && (0 == (simm % 4)))
> > +	{
> > +	  addr += OR1K_INSTLEN;
> > +	  inst = or1k_fetch_instruction (gdbarch, addr);
> > +	}
> > +      else
> > +	{
> > +	  /* Nothing else to look for.  We have found the end of the
> > +	     prologue.  */
> > +	  return addr;
> 
> break the loop and "return addr" at the end of this function.

Right, thats more clean.

> > +
> > +/* Implement the push_dummy_call gdbarch method.  */
> > +
> > +static CORE_ADDR
> > +or1k_push_dummy_call (struct gdbarch *gdbarch, struct value *function,
> > +		      struct regcache *regcache, CORE_ADDR bp_addr,
> > +		      int nargs, struct value **args, CORE_ADDR sp,
> > +		      int struct_return, CORE_ADDR struct_addr)
> > +{
> > +
> > +  int argreg;
> > +  int argnum;
> > +  int first_stack_arg;
> > +  int stack_offset = 0;
> > +  int heap_offset = 0;
> > +  CORE_ADDR heap_sp = sp - 128;
> > +  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
> > +  int bpa = (gdbarch_tdep (gdbarch))->bytes_per_address;
> > +  int bpw = (gdbarch_tdep (gdbarch))->bytes_per_word;
> > +  struct type *func_type = value_type (function);
> > +
> > +  /* Return address */
> > +  regcache_cooked_write_unsigned (regcache, OR1K_LR_REGNUM, bp_addr);
> > +
> > +  /* Register for the next argument.  */
> > +  argreg = OR1K_FIRST_ARG_REGNUM;
> > +
> > +  /* Location for a returned structure.  This is passed as a silent first
> > +     argument.  */
> > +  if (struct_return)
> > +    {
> > +      regcache_cooked_write_unsigned (regcache, OR1K_FIRST_ARG_REGNUM,
> > +				      struct_addr);
> > +      argreg++;
> > +    }
> > +
> > +  /* Put as many args as possible in registers.  */
> > +  for (argnum = 0; argnum < nargs; argnum++)
> > +    {
> > +      const gdb_byte *val;
> > +      gdb_byte valbuf[sizeof (ULONGEST)];
> > +
> > +      struct value *arg = args[argnum];
> > +      struct type *arg_type = check_typedef (value_type (arg));
> > +      int len = arg_type->length;
> > +      enum type_code typecode = arg_type->main_type->code;
> 
> typecode = TYPE_CODE (arg_type);

OK, thanks

> > +
> > +      if (TYPE_VARARGS (func_type) && argnum >= TYPE_NFIELDS (func_type))
> > +	break; /* end or regular args, varargs go to stack.  */
> > +
> > +      /* Extract the value, either a reference or the data.  */
> > +      if ((TYPE_CODE_STRUCT == typecode) || (TYPE_CODE_UNION == typecode)
> > +	  || (len > bpw * 2))
> > +	{
> > +	  CORE_ADDR valaddr = value_address (arg);
> > +
> > +	  /* If the arg is fabricated (i.e. 3*i, instead of i) valaddr is
> > +	     undefined.  */
> > +	  if (valaddr == 0)
> > +	    {
> > +	      /* The argument needs to be copied into the target space.  Since
> > +	         the bottom of the stack is reserved for function arguments
> > +	         we store this at the these at the top growing down.  */
> > +	      heap_offset += align_up (len, bpw);
> > +	      valaddr = heap_sp + heap_offset;
> > +
> > +	      write_memory (valaddr, value_contents (arg), len);
> > +	    }
> > +
> > +	  /* The ABI passes all structures by reference, so get its address.  */
> > +	  store_unsigned_integer (valbuf, bpa, byte_order, valaddr);
> > +	  len = bpa;
> > +	  val = valbuf;
> > +	}
> > +      else
> > +	{
> > +	  /* Everything else, we just get the value.  */
> > +	  val = value_contents (arg);
> > +	}
> > +
> > +      /* Stick the value in a register.  */
> > +      if (len > bpw)
> > +	{
> > +	  /* Big scalars use two registers, but need NOT be pair aligned.  */
> > +
> > +	  if (argreg <= (OR1K_LAST_ARG_REGNUM - 1))
> > +	    {
> > +	      ULONGEST regval =	extract_unsigned_integer (val, len, byte_order);
> > +
> > +	      unsigned int bits_per_word = bpw * 8;
> > +	      ULONGEST mask = (((ULONGEST) 1) << bits_per_word) - 1;
> > +	      ULONGEST lo = regval & mask;
> > +	      ULONGEST hi = regval >> bits_per_word;
> > +
> > +	      regcache_cooked_write_unsigned (regcache, argreg, hi);
> > +	      regcache_cooked_write_unsigned (regcache, argreg + 1, lo);
> > +	      argreg += 2;
> > +	    }
> > +	  else
> > +	    {
> > +	      /* Run out of regs */
> > +	      break;
> > +	    }
> > +	}
> > +      else if (argreg <= OR1K_LAST_ARG_REGNUM)
> > +	{
> > +	  /* Smaller scalars fit in a single register.  */
> > +	  regcache_cooked_write_unsigned
> > +	    (regcache, argreg, extract_unsigned_integer (val, len, byte_order));
> > +	  argreg++;
> > +	}
> > +      else
> > +	{
> > +	  /* Ran out of regs.  */
> > +	  break;
> > +	}
> > +    }
> > +
> > +  first_stack_arg = argnum;
> > +
> > +  /* If we get here with argnum < nargs, then arguments remain to be placed on
> > +     the stack.  This is tricky, since they must be pushed in reverse order and
> 
> These two lines are too long.

OK.

> > +     the stack in the end must be aligned.  The only solution is to do it in
> > +     two stages, the first to compute the stack size, the second to save the
> > +     args.  */
> > +
> > +  for (argnum = first_stack_arg; argnum < nargs; argnum++)
> > +    {
> > +      struct value *arg = args[argnum];
> > +      struct type *arg_type = check_typedef (value_type (arg));
> > +      int len = arg_type->length;
> 
> TYPE_LENGTH (arg_type);

Right, thanks.

> > +      enum type_code typecode = arg_type->main_type->code;
> > +
> 
> TYPE_CODE (arg_type);

Right, thanks

> > +
> > +
> > +/* Support functions for frame handling.  */
> > +
> > +/* Initialize a prologue cache
> > +
> > +   We build a cache, saying where registers of the PREV frame can be found
> > +   from the data so far set up in this THIS.
> > +
> > +   We also compute a unique ID for this frame, based on the function start
> > +   address and the stack pointer (as it will be, even if it has yet to be
> > +   computed.
> > +
> > +   STACK FORMAT
> > +   ============
> > +
> > +   The OR1K has a falling stack frame and a simple prolog.  The Stack pointer
> > +   is R1 and the frame pointer R2.  The frame base is therefore the address
> > +   held in R2 and the stack pointer (R1) is the frame base of the NEXT frame.
> > +
> > +   l.addi  r1,r1,-frame_size	# SP now points to end of new stack frame
> > +
> > +   The stack pointer may not be set up in a frameless function (e.g. a simple
> > +   leaf function).
> > +
> > +   l.sw    fp_loc(r1),r2        # old FP saved in new stack frame
> > +   l.addi  r2,r1,frame_size     # FP now points to base of new stack frame
> > +
> > +   The frame pointer is not necessarily saved right at the end of the stack
> > +   frame - OR1K saves enough space for any args to called functions right at
> > +   the end (this is a difference from the Architecture Manual).
> > +
> > +   l.sw    lr_loc(r1),r9        # Link (return) address
> > +
> > +   The link register is usally saved at fp_loc - 4.  It may not be saved at all
> > +   in a leaf function.
> > +
> > +   l.sw    reg_loc(r1),ry       # Save any callee saved regs
> > +
> > +   The offsets x for the callee saved registers generally (always?) rise in
> > +   increments of 4, starting at fp_loc + 4.  If the frame pointer is omitted
> > +   (an option to GCC), then it may not be saved at all.  There may be no callee
> > +   saved registers.
> > +
> > +   So in summary none of this may be present.  However what is present seems
> > +   always to follow this fixed order, and occur before any substantive code
> > +   (it is possible for GCC to have more flexible scheduling of the prologue,
> > +   but this does not seem to occur for OR1K).
> > +
> > +   ANALYSIS
> > +   ========
> > +
> > +   This prolog is used, even for -O3 with GCC.
> > +
> > +   All this analysis must allow for the possibility that the PC is in the
> > +   middle of the prologue.  Data in the cache should only be set up insofar as
> > +   it has been computed.
> > +
> > +   HOWEVER.  The frame_id must be created with the SP *as it will be* at the
> > +   end of the Prologue.  Otherwise a recursive call, checking the frame with
> > +   the PC at the start address will end up with the same frame_id as the
> > +   caller.
> > +
> > +   A suite of "helper" routines are used, allowing reuse for
> > +   or1k_skip_prologue().
> > +
> > +   Reportedly, this is only valid for frames less than 0x7fff in size.  */
> > +
> > +static struct trad_frame_cache *
> > +or1k_frame_cache (struct frame_info *this_frame, void **prologue_cache)
> > +{
> > +  struct gdbarch *gdbarch;
> > +  struct trad_frame_cache *info;
> > +
> > +  CORE_ADDR this_pc;
> > +  CORE_ADDR this_sp;
> > +  CORE_ADDR this_sp_for_id;
> > +  int frame_size = 0;
> > +
> > +  CORE_ADDR start_addr;
> > +  CORE_ADDR end_addr;
> > +
> > +  if (frame_debug)
> > +    fprintf_unfiltered (gdb_stdlog,
> > +			"or1k_frame_cache, prologue_cache = 0x%p\n",
> > +			*prologue_cache);
> 
> Can you add a new debug flag, like or1k_debug, to control this?  Each
> backend in GDB (amd64-windows-tdep.c) use its own debug flag to control
> the output related to frame unwinding.

OK, adding with add_setshow_boolean_cmd().

> > +  /* Get a new prologue cache and populate it with default values.  */
> > +  info = trad_frame_cache_zalloc (this_frame);
> > +  *prologue_cache = info;
> > +
> > +  /* Find the start address of THIS function (which is a NORMAL frame, even if
> > +     the NEXT frame is the sentinel frame) and the end of its prologue.  */
> 
> Don't need to capitalize THIS, NORMAL, and NEXT.

OK, I think this was done for emphasis, but I guess its not needed.

> > +
> > +  /* The default frame base of THIS frame (for ID purposes only - frame base
> > +     is an overloaded term) is its stack pointer.  For now we use the value of
> > +     the SP register in THIS frame.  However if the PC is in the prologue of
> > +     THIS frame, before the SP has been set up, then the value will actually
> > +     be that of the PREV frame, and we'll need to adjust it later.  */
> > +  trad_frame_set_this_base (info, this_sp);
> > +  this_sp_for_id = this_sp;
> > +
> > +  /* The default is to find the PC of the PREVIOUS frame in the link register
> > +     of this frame.  This may be changed if we find the link register was saved
> > +     on the stack.  */
> > +  trad_frame_set_reg_realreg (info, OR1K_NPC_REGNUM, OR1K_LR_REGNUM);
> > +
> > +  /* We should only examine code that is in the prologue.  This is all code up
> > +     to (but not including) end_addr.  We should only populate the cache while
> > +     the address is up to (but not including) the PC or end_addr, whichever is
> > +     first.  */
> > +  gdbarch = get_frame_arch (this_frame);
> > +  end_addr = or1k_skip_prologue (gdbarch, start_addr);
> > +
> > +  /* All the following analysis only occurs if we are in the prologue and have
> > +     executed the code.  Check we have a sane prologue size, and if zero we
> > +     are frameless and can give up here.  */
> > +  if (end_addr < start_addr)
> 
> How can it be?

Looking at or1k_skip_prologue(), it doesnt look like its possible.

I guess this is just a sanity check.  I can remove if you agree it looks
impossible.

> > +    throw_quit ("end addr 0x%08x is less than start addr 0x%08x\n",
> > +		(unsigned int) end_addr, (unsigned int) start_addr);
> 
> s/throw_quit/error/

OK

> > +
> > +/* Data structures for the normal prologue-analysis-based unwinder.  */
> > +
> > +static const struct frame_unwind or1k_frame_unwind = {
> > +  .type = NORMAL_FRAME,
> > +  .stop_reason = default_frame_unwind_stop_reason,
> > +  .this_id = or1k_frame_this_id,
> > +  .prev_register = or1k_frame_prev_register,
> > +  .unwind_data = NULL,
> > +  .sniffer = default_frame_sniffer,
> > +  .dealloc_cache = NULL,
> > +  .prev_arch = NULL
> > +};
> 
> Write the code this way,
> 
> static const struct frame_unwind or1k_frame_unwind =
> {
>   NORMAL_FRAME,
>   default_frame_unwind_stop_reason,
>   or1k_frame_this_id,
>   or1k_frame_prev_register,
>   NULL,
>   default_frame_sniffer,
>   NULL,
> };

OK, I prefer with the named fields, because its self documenting, but
what you are showing is consistent with other *-tdep.c definitions.

I'll change it.

> > +
> > +/* Architecture initialization for OpenRISC 1000.  */
> > +
> > +static struct gdbarch *
> > +or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
> > +{
> ...
> > +  /* Check any target description for validity.  */
> > +  if (tdesc_has_registers (info.target_desc))
> > +    {
> > +      const struct tdesc_feature *feature;
> > +      int valid_p;
> > +
> > +      feature = tdesc_find_feature (info.target_desc, "org.gnu.gdb.or1k.group0");
> 
> This line is too long.  In patch 2/4, you defined 11 features, group0 -
> group 10, but you only find feature group0.  Is group0 a required
> feature?

I have upated this already.  I only define group0 as a required feature
and documented it as well.  The other I removed and leave up to targets
like OpenOCD to define.

> > +      if (feature == NULL)
> > +        return NULL;
> > +
> > +      tdesc_data = tdesc_data_alloc ();
> > +
> > +      valid_p = 1;
> > +
> > +      for (i = 0; i < OR1K_NUM_REGS; i++)
> > +        valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
> > +                                            or1k_reg_names[i]);
> > +
> > +      if (!valid_p)
> > +        {
> > +          tdesc_data_cleanup (tdesc_data);
> > +          return NULL;
> > +        }
> > +    }
> > +
> > +  if (tdesc_data)
> 
> if (tdesc_data != NULL)

OK

> > +    {
> > +      tdesc_use_registers (gdbarch, info.target_desc, tdesc_data);
> > +
> > +      /* Target descriptions may extend into the following groups.  */
> > +      reggroup_add (gdbarch, general_reggroup);
> > +      reggroup_add (gdbarch, system_reggroup);
> > +      reggroup_add (gdbarch, float_reggroup);
> > +      reggroup_add (gdbarch, vector_reggroup);
> > +      reggroup_add (gdbarch, reggroup_new ("immu", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("dmmu", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("icache", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("dcache", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("pic", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("timer", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("power", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("perf", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("mac", USER_REGGROUP));
> > +      reggroup_add (gdbarch, reggroup_new ("debug", USER_REGGROUP));
> > +      reggroup_add (gdbarch, all_reggroup);
> > +      reggroup_add (gdbarch, save_reggroup);
> > +      reggroup_add (gdbarch, restore_reggroup);
> > +    }
> > +
> > +  return gdbarch;
> > +}
> > +
> 
> > +
> > +extern initialize_file_ftype _initialize_or1k_tdep; /* -Wmissing-prototypes */
> > +
> > +void
> > +_initialize_or1k_tdep (void)
> > +{
> > +  /* Register this architecture.  */
> > +  gdbarch_register (bfd_arch_or1k, or1k_gdbarch_init, or1k_dump_tdep);
> > +
> > +  /* Tell remote stub that we support XML target description.  */
> > +  register_remote_support_xml ("or1k");
> 
> Can't remote stub think GDB support xml target description already?

I'll try to remove and see.

> > +}
> > diff --git a/gdb/or1k-tdep.h b/gdb/or1k-tdep.h
> > new file mode 100644
> > index 0000000..edcad88
> > --- /dev/null
> > +++ b/gdb/or1k-tdep.h
> > @@ -0,0 +1,56 @@
> > +/* Definitions to target GDB to OpenRISC 1000 32-bit targets.
> > +   Copyright (C) 2008-2017 Free Software Foundation, Inc.
> > +
> > +   This file is part of GDB.
> > +
> > +   This program is free software; you can redistribute it and/or modify it
> > +   under the terms of the GNU General Public License as published by the Free
> > +   Software Foundation; either version 3 of the License, or (at your option)
> > +   any later version.
> > +
> > +   This program is distributed in the hope that it will be useful, but WITHOUT
> > +   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > +   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > +   more details.
> > +
> > +   You should have received a copy of the GNU General Public License along
> > +   With this program.  If not, see <http://www.gnu.org/licenses/>.  */
> > +
> > +
> > +#ifndef OR1K_TDEP__H
> > +#define OR1K_TDEP__H
> > +
> > +#ifndef TARGET_OR1K
> > +#define TARGET_OR1K
> > +#endif
> > +
> > +#include "opcodes/or1k-desc.h"
> > +#include "opcodes/or1k-opc.h"
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
> 
> A general comments on these macros, if they are only used in
> or1k-tdep.c, why don't you move these macros into or1k-tdep.c?

It seems common that other archs put their macros like this in the
*tdep.h file.  I see in nio2 and alpha.

I could change but I rather not if its ok.

> > +
> > +/* Properties of the architecture. GDB mapping of registers is all the GPRs
> > +   and SPRs followed by the PPC, NPC and SR at the end. Red zone is the area
> > +   past the end of the stack reserved for exception handlers etc.  */
> > +
> > +#define OR1K_MAX_GPR_REGS            32
> > +#define OR1K_NUM_PSEUDO_REGS         0
> > +#define OR1K_NUM_REGS               (OR1K_MAX_GPR_REGS + 3)
> > +#define OR1K_STACK_ALIGN             4
> > +#define OR1K_INSTLEN                 4
> > +#define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
> > +#define OR1K_NUM_TAP_RECORDS         8
> > +#define OR1K_FRAME_RED_ZONE_SIZE     2536
> > +
> > +#endif /* OR1K_TDEP__H */


Thanks for all the comments.  As mentioned before I will fix up and
send.

> -- 
> Yao (齐尧)
