From: Stafford Horne <shorne@gmail.com>
Date: Sun, 28 Oct 2018 09:37:40 +0900
Subject: [OpenRISC] [PATCH v3 1/3] or1k: libgcc: initial support for
	openrisc
In-Reply-To: <20181027232503.GG5766@gate.crashing.org>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-2-shorne@gmail.com>
 <20181027232503.GG5766@gate.crashing.org>
Message-ID: <20181028003740.GC1761@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

Thanks for the review.

On Sat, Oct 27, 2018 at 06:25:04PM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Sat, Oct 27, 2018 at 01:37:00PM +0900, Stafford Horne wrote:
> > +	/* Given R = X * Y ... */
> > +1:	l.sfeq		r4, r0			/* while (y != 0) */
> > +	l.bf		2f
> > +	 l.andi		r5, r4, 1		/* if (y & 1) ... */
> 
> Do the extra leading spaces mean something?

Yes, we put those to indicate a branch delay slot instruction.

> > +        l.sfeqi		r4, 0		/* division by zero; return 0.  */
> 
> In some places (like here) you ident with 8 spaces instead of a tab.

Thanks, I will fix those, it should be tab.

> > +/* For signed division we do:
> > + *
> > + *   -x / y = x / -y = -(x / y)
> > + *   -x % y = -(x % y)
> > + *   x % -y = x % b
> > + *
> > + * which has the property that (x/y)*y + (x%y) = x.
> > + */
> 
> You mean "y" instead of "b" I think.

I believe so, I will read through it.  This part was done by Richard I should
have reviewed it better.

-Stafford
