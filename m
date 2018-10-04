From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 4 Oct 2018 17:36:58 +0000
Subject: [OpenRISC] [PATCH v2 1/3] or1k: libgcc: initial support for
	openrisc
In-Reply-To: <20181004034803.18066-2-shorne@gmail.com>
References: <20181004034803.18066-1-shorne@gmail.com>
 <20181004034803.18066-2-shorne@gmail.com>
Message-ID: <alpine.DEB.2.21.1810041731350.27752@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 4 Oct 2018, Stafford Horne wrote:

> +or1k-*-linux*)
> +	tmake_file="$tmake_file or1k/t-or1k"
> +	tmake_file="$tmake_file t-softfp-sfdf t-softfp-excl t-softfp"
> +	md_unwind_header=or1k/linux-unwind.h
> +	;;
> +or1k-*-*)
> +	tmake_file="$tmake_file or1k/t-or1k"
> +	tmake_file="$tmake_file t-softfp-sfdf t-softfp-excl t-softfp"
> +	extra_parts="$extra_parts crti.o crtn.o"
> +	;;

Could you clarify why you are using t-softfp-excl?

In general, for soft-float configurations it's best not to use 
t-softfp-excl - meaning the floating-point operations from libgcc2.c get 
implemented directly in soft-fp, rather than through libgcc2.c wrapping 
other soft-fp operations.  While for hard-float configurations it's best 
not to use soft-fp at all.

If you have hard-float configurations using a soft-float ABI, that thus 
need to provide all the functions in question so soft-float objects / 
programs can be linked with hard-float libgcc, t-hardfp should be used 
instead when building a hard-float multilib.  (It's possible to have more 
complicated mixtures in cases where some operations or types come from 
hardfp and others from softfp; some mips and powerpcspe configurations 
do.)

-- 
Joseph S. Myers
joseph at codesourcery.com
