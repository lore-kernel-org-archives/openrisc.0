From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sun, 28 Oct 2018 17:54:47 -0500
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181028214723.GD1761@lianli.shorne-pla.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
 <20181028214723.GD1761@lianli.shorne-pla.net>
Message-ID: <20181028225447.GK5766@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi!

On Mon, Oct 29, 2018 at 06:47:23AM +0900, Stafford Horne wrote:
> On Sat, Oct 27, 2018 at 09:57:30PM -0500, Segher Boessenkool wrote:
> > > +/* Helper for defining INITIAL_ELIMINATION_OFFSET.
> > > +   We allow the following eliminiations:
> > > +     FP -> HARD_FP or SP
> > > +     AP -> HARD_FP or SP
> > > +
> > > +   HFP and AP are the same which is handled below.  */
> > > +
> > > +HOST_WIDE_INT
> > > +or1k_initial_elimination_offset (int from, int to)
> > 
> > You could calculate this as  some_offset (from) - some_offset (to)  with
> > some_offset a simple helper function.  That gives you all possible
> > eliminations :-)
> > 
> > (Each offset is very cheap to compute in your case, so that's not a problem).
> 
> Right, Do you mean something like the following?  I think it would work, but I
> am not sure it make the code easier to read.  Do you think there would be much
> benefits supporting all possible eliminations?

Yes, like that.  It also easily can handle the other combos (those with
STACK_POINTER), and it is easier if you have to switch FRAME_GROWS_DOWNWARD
("false" is better on some args, but "true" is required for ssp).

Your code is fine as-is of course.

> > > +#undef TARGET_RTX_COSTS
> > > +#define TARGET_RTX_COSTS or1k_rtx_costs
> > 
> > You may want TARGET_INSN_COST as well (it is easier to get (more) correct).
> 
> OK, I was not considering that for the first port.  Perhaps after getting this
> in?  I think in general the OpenRISC insruction costs are fairly flat for the
> ones are using.

Oh, this was just a suggestion for the future :-)

If you compile with -dp you will see the cost and length for every insn
annotated; are most/all correct?

> > > +   This ABI has no adjacent call-saved register, which means that
> > > +   DImode/DFmode pseudos cannot be call-saved and will always be
> > > +   spilled across calls.  To solve this without changing the ABI,
> > > +   remap the compiler internal register numbers to place the even
> > > +   call-saved registers r16-r30 in 24-31, and the odd call-clobbered
> > > +   registers r17-r31 in 16-23.  */
> > 
> > Ooh evilness :-)
> 
> Richard did this, I thought it was rather clever. :)

Yes!

> > > +#define FUNCTION_ARG_REGNO_P(r) (r >= 3 && r <= 8)
> > 
> > IN_RANGE ?
> 
> OK, I may change it, I think without the macro, its easy to understand that its
> (inclusive).

Yeah, you'll have to remember that IN_RANGE always is inclusive too.  Maybe
if it were used more that woul become second nature to more people :-)


Segher
