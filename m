From: Stafford Horne <shorne@gmail.com>
Date: Thu, 4 Jan 2018 00:32:11 +0900
Subject: [OpenRISC] OpenRISC GCC upstream plan
In-Reply-To: <c6104ef7-0dba-fcd7-e57e-f925b85fc553@twiddle.net>
References: <20180101125546.GH32243@lianli.shorne-pla.net>
 <c6104ef7-0dba-fcd7-e57e-f925b85fc553@twiddle.net>
Message-ID: <20180103153211.GK32243@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 01, 2018 at 02:48:02PM -0800, Richard Henderson wrote:
> On 01/01/2018 04:55 AM, Stafford Horne wrote:
> >>From what we know GCC cannot go upstream due to early patches from Matjaz, and
> > he has not assigned his FSF copyright.
> > 
> > Options;
> > 
> >   1.  Continue to keep Or1k GCC out of upstream.
> >   2.  Clean-room rewrite.
> >   3.  Determine if Matjaz's contributions can be deem trivial and upstream the
> >       current gcc.
> >   4.  Convince Matjaz to do FSF copyright assignment.
> 
> IANAL, so I won't opine on (3).  I think (4) would obviously be the best route,
> if that is at all a possibility.

I agree, I wish we could convince him.

> Failing that, I'm willing to mentor (2) for any volunteers.  I'm not currently
> active in gcc, but I expect most backend advice is still current.

Thank you for the offer, I have been reading docs from back to the 90s and many
things still seem relevant.

> There's also my to-do list that I never finished: primarily, support Sparcv9
> style double-offset relocations.
> 
> This takes advantage of the fact that the page-offset relocation requires 13
> bits, but the load/store instructions that use the page-offset relocation have
> 16 bits.  Thus one can be certain that an addend between -32768 and 24576
> cannot overflow the field.  That is quite a significant range and can easily be
> combined with the section anchor support to minimize the number of l.adrp
> instructions required to address lots of local variables.

Sorry, I don't follow 100%

How is this different from the l.adrp supported relocations added for this
series?  Which relocations are these on sparcv9 R_SPARC_??

-Stafford

> r~
