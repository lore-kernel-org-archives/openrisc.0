From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 Oct 2018 06:47:23 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181028025730.GH5766@gate.crashing.org>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
Message-ID: <20181028214723.GD1761@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Segher,

Thank you for the review and thank you for all the help up until now.

On Sat, Oct 27, 2018 at 09:57:30PM -0500, Segher Boessenkool wrote:
> Hi Stafford,
> 
> Some minor comments.  I didn't read the atomics much, but I did look at
> everything else, and it looks fine :-)
> 
> On Sat, Oct 27, 2018 at 01:37:02PM +0900, Stafford Horne wrote:
> > +        case ${target} in
> > +        or1k*-*-linux*)
> > +                tm_file="${tm_file} gnu-user.h linux.h glibc-stdint.h"
> > +                tm_file="${tm_file} or1k/linux.h"
> > +                ;;
> 
> Spaces instead of tabs.

OK, I will fix.

> > +  /* Number of bytes saved on the stack for outgoing/sub-fucntion args.  */
> 
> Typo ("function").

OK.

> > +  /* The sum of sizes: locals vars, called saved regs, stack pointer
> > +   * and an optional frame pointer.
> > +   * Used in expand_prologue () and expand_epilogue().  */
> 
> We don't use leading stars in comments (just spaces), normally.

OK.

> > +  /* Set address to volitile to ensure the store doesn't get optimized out.  */
> 
> "volatile"

OK.

> > +/* Helper for defining INITIAL_ELIMINATION_OFFSET.
> > +   We allow the following eliminiations:
> > +     FP -> HARD_FP or SP
> > +     AP -> HARD_FP or SP
> > +
> > +   HFP and AP are the same which is handled below.  */
> > +
> > +HOST_WIDE_INT
> > +or1k_initial_elimination_offset (int from, int to)
> 
> You could calculate this as  some_offset (from) - some_offset (to)  with
> some_offset a simple helper function.  That gives you all possible
> eliminations :-)
> 
> (Each offset is very cheap to compute in your case, so that's not a problem).

Right, Do you mean something like the following?  I think it would work, but I
am not sure it make the code easier to read.  Do you think there would be much
benefits supporting all possible eliminations?


/* Helper function for use with INITIAL_ELIMINATION_OFFSET.  */

static HOST_WIDE_INT
or1k_stack_pointer_offset (int from)
{
   HOST_WIDE_INT offset;

  /* Set OFFSET to the offset from the stack pointer.  */
  switch (from)
    {
    /* Incoming args are all the way up at the previous frame.  */
    case HARD_FRAME_POINTER_REGNUM:
    case ARG_POINTER_REGNUM:
      offset = cfun->machine->total_size;
      break;

    /* Local args grow downward from the saved registers.  */
    case FRAME_POINTER_REGNUM:
      offset = cfun->machine->args_size + cfun->machine->local_vars_size;
      break;

    default:
      gcc_unreachable ();
    }

  return offset;
}

/* Helper for defining INITIAL_ELIMINATION_OFFSET.
   We allow the following eliminiations:
     FP -> HARD_FP or SP
     AP -> HARD_FP or SP

   HARD_FP and AP are actually the same.  */

HOST_WIDE_INT
or1k_initial_elimination_offset (int from, int to)
{
  return or1k_stack_pointer_offset (from) - or1k_stack_pointer_offset (to);
}


> > +static rtx
> > +or1k_function_value (const_tree valtype,
> > +		     const_tree fn_decl_or_type ATTRIBUTE_UNUSED,
> > +		     bool outgoing ATTRIBUTE_UNUSED)
> 
> Since we use C++ now you can write this as
> 		     bool /*outgoing*/)
> or such, for enhanced readability.

Sure, I will remove all ATTRIBUTE_UNUSED instances.

> > +   split.  Symbols are lagitimized using split relocations.  */
> 
> "legitimized"

OK.

> > +void
> > +or1k_expand_move (machine_mode mode, rtx op0, rtx op1)
> > +{
> > +  if (MEM_P (op0))
> > +    {
> > +      if (!const0_operand(op1, mode))
> 
> Space before (.

OK. I found a few ore too, thanks.

> > +#undef TARGET_RTX_COSTS
> > +#define TARGET_RTX_COSTS or1k_rtx_costs
> 
> You may want TARGET_INSN_COST as well (it is easier to get (more) correct).

OK, I was not considering that for the first port.  Perhaps after getting this
in?  I think in general the OpenRISC insruction costs are fairly flat for the
ones are using.

> > +      if (hi != 0)
> > +	{
> > +	  rtx scratch2 = gen_rtx_REG (Pmode, RV_REGNUM);
> > +	  emit_move_insn (scratch2, GEN_INT (hi));
> > +	  emit_insn (gen_add2_insn (scratch, scratch2));
> > +        }
> 
> Tab instead of spaces.

OK.

> > +  /* Generate a tail call to the target function.  */
> > +  if (! TREE_USED (function))
> 
> No space after !.

Ok.

> > +#define TARGET_RETURN_IN_MEMORY	or1k_return_in_memory
> 
> > +#define	TARGET_PASS_BY_REFERENCE or1k_pass_by_reference
> 
> These two have a tab instead of a space (as the rest do).

OK, also some TARGET_* are aligned and some not.  Will fix.

> > +#define WCHAR_TYPE_SIZE	32
> 
> And this.

OK.

> > +   This ABI has no adjacent call-saved register, which means that
> > +   DImode/DFmode pseudos cannot be call-saved and will always be
> > +   spilled across calls.  To solve this without changing the ABI,
> > +   remap the compiler internal register numbers to place the even
> > +   call-saved registers r16-r30 in 24-31, and the odd call-clobbered
> > +   registers r17-r31 in 16-23.  */
> 
> Ooh evilness :-)

Richard did this, I thought it was rather clever. :)

> > +#define Pmode	SImode
> > +#define FUNCTION_MODE	SImode
> 
> Some more tabs.

OK.

> > +#define FUNCTION_ARG_REGNO_P(r) (r >= 3 && r <= 8)
> 
> IN_RANGE ?

OK, I may change it, I think without the macro, its easy to understand that its
(inclusive).

> > + { ARG_POINTER_REGNUM,	 STACK_POINTER_REGNUM },	\
> 
> Weird tab here, too.

Oh, weird one, thank you.

> > +#define EH_RETURN_REGNUM	HW_TO_GCC_REGNO (23)
> 
> And here.

OK.

> > +(define_insn "xorsi3"
> > +  [(set (match_operand:SI 0 "register_operand" "=r,r")
> > +	  (xor:SI
> > +	   (match_operand:SI 1 "register_operand"   "%r,r")
> > +	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))]
> > +  ""
> > +  "@
> > +  l.xor\t%0, %1, %2
> > +  l.xori\t%0, %1, %2")
> 
> Is this correct?  Should this be unsigned (u16 and K)?
> https://sourceware.org/cgen/gen-doc/openrisc-insn.html suggest so, but I
> don't know how up-to-date or relevant that is.  Well.  From the atomics
> much below it seems to be correct, and signed is nice for making a bit
> inverse.  Is there some better documentation?  Something to put at
> https://gcc.gnu.org/readings.html (this is in the CVS repo, still see
> https://gcc.gnu.org/about.html#cvs ).

OK, let me have a look at this one and get back.  Maybe Richard has a
suggestion as he did the Atomics.

> > +(define_expand "mov<I:mode>"
> > +  [(set (match_operand:I 0 "nonimmediate_operand" "")
> > +	(match_operand:I 1 "general_operand" ""))]
> 
> You can completely leave out empty constraint strings, for example in the
> expanders.

OK.

> > +mhard-div
> > +Target RejectNegative InverseMask(SOFT_DIV)
> > +Use hardware divide instructions, use -msoft-div for emulation.
> > +
> > +mhard-mul
> > +Target RejectNegative InverseMask(SOFT_MUL).
> > +Use hardware multiply instructions, use -msoft-mul for emulation.
> 
> Maybe put the -msoft-* options near here then?

I was trying to keep them in alphabetical order.  But I do understand it makes
more sense to group these together.

> This was a lovely read.  Thank you!  Your port looks great.

Thanks a lot!

-Stafford
