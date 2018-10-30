From: Stafford Horne <shorne@gmail.com>
Date: Tue, 30 Oct 2018 21:49:18 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181028225447.GK5766@gate.crashing.org>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
 <20181028214723.GD1761@lianli.shorne-pla.net>
 <20181028225447.GK5766@gate.crashing.org>
Message-ID: <20181030124918.GC2843@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

On Sun, Oct 28, 2018 at 05:54:47PM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Mon, Oct 29, 2018 at 06:47:23AM +0900, Stafford Horne wrote:
> > On Sat, Oct 27, 2018 at 09:57:30PM -0500, Segher Boessenkool wrote:
> > > > +/* Helper for defining INITIAL_ELIMINATION_OFFSET.
> > > > +   We allow the following eliminiations:
> > > > +     FP -> HARD_FP or SP
> > > > +     AP -> HARD_FP or SP
> > > > +
> > > > +   HFP and AP are the same which is handled below.  */
> > > > +
> > > > +HOST_WIDE_INT
> > > > +or1k_initial_elimination_offset (int from, int to)
> > > 
> > > You could calculate this as  some_offset (from) - some_offset (to)  with
> > > some_offset a simple helper function.  That gives you all possible
> > > eliminations :-)
> > > 
> > > (Each offset is very cheap to compute in your case, so that's not a problem).
> > 
> > Right, Do you mean something like the following?  I think it would work, but I
> > am not sure it make the code easier to read.  Do you think there would be much
> > benefits supporting all possible eliminations?
> 
> Yes, like that.  It also easily can handle the other combos (those with
> STACK_POINTER), and it is easier if you have to switch FRAME_GROWS_DOWNWARD
> ("false" is better on some args, but "true" is required for ssp).
> 
> Your code is fine as-is of course.

Just to be clear, when you say 'as-is' did you mean the original v3 patch?  Or
are you referring to followup patch I posted with the some_offset (from) -
some_offset (to) logic.

-Stafford
