From: Stafford Horne <shorne@gmail.com>
Date: Fri, 5 Oct 2018 12:59:29 +0900
Subject: [OpenRISC] [PATCH v2 1/3] or1k: libgcc: initial support for
	openrisc
In-Reply-To: <alpine.DEB.2.21.1810041731350.27752@digraph.polyomino.org.uk>
References: <20181004034803.18066-1-shorne@gmail.com>
 <20181004034803.18066-2-shorne@gmail.com>
 <alpine.DEB.2.21.1810041731350.27752@digraph.polyomino.org.uk>
Message-ID: <20181005035929.GF32353@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Oct 04, 2018 at 05:36:58PM +0000, Joseph Myers wrote:
> On Thu, 4 Oct 2018, Stafford Horne wrote:
> 
> > +or1k-*-linux*)
> > +	tmake_file="$tmake_file or1k/t-or1k"
> > +	tmake_file="$tmake_file t-softfp-sfdf t-softfp-excl t-softfp"
> > +	md_unwind_header=or1k/linux-unwind.h
> > +	;;
> > +or1k-*-*)
> > +	tmake_file="$tmake_file or1k/t-or1k"
> > +	tmake_file="$tmake_file t-softfp-sfdf t-softfp-excl t-softfp"
> > +	extra_parts="$extra_parts crti.o crtn.o"
> > +	;;
> 
> Could you clarify why you are using t-softfp-excl?
> 
> In general, for soft-float configurations it's best not to use 
> t-softfp-excl - meaning the floating-point operations from libgcc2.c get 
> implemented directly in soft-fp, rather than through libgcc2.c wrapping 
> other soft-fp operations.  While for hard-float configurations it's best 
> not to use soft-fp at all.
> 
> If you have hard-float configurations using a soft-float ABI, that thus 
> need to provide all the functions in question so soft-float objects / 
> programs can be linked with hard-float libgcc, t-hardfp should be used 
> instead when building a hard-float multilib.  (It's possible to have more 
> complicated mixtures in cases where some operations or types come from 
> hardfp and others from softfp; some mips and powerpcspe configurations 
> do.)

Hello,

I don't know of a reason for using t-softfp-excl, I think Richard or I was just
copying from what we saw similar targets do.  I just removed it and reran some
of the tests and don't see any regressions.

We will be patching in hardfp post upstreaming, so the notes above are very
helpful.

-Stafford
