From: Richard Henderson <rth@twiddle.net>
Date: Sun, 28 Oct 2018 01:25:54 +0000
Subject: [OpenRISC] [PATCH v3 1/3] or1k: libgcc: initial support for
	openrisc
In-Reply-To: <20181027043702.18414-2-shorne@gmail.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-2-shorne@gmail.com>
Message-ID: <494cb6a6-fcc5-04d6-346a-c91e7f8ff085@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/27/18 5:37 AM, Stafford Horne wrote:
> +/* Here _init and _fini are empty because .init_array/.fini_array are used
> +   exclusively.  However, the functions are still needed as required when
> +   linking.  */
> +	.align 4
> +	.global	_init
> +	.type	_init, at function
> +_init:
> +	.global	_fini
> +	.type	_fini, at function
> +_fini:
> +	l.jr	r9
> +	 l.nop

Where are they referenced from?  Perhaps just a binutils bug, in that the
linker script needs adjustment?

> +	/* Given R = X * Y ... */
> +1:	l.sfeq		r4, r0			/* while (y != 0) */
> +	l.bf		2f
> +	 l.andi		r5, r4, 1		/* if (y & 1) ... */
> +	l.add		r12, r11, r3
> +	l.sfne		r5, r0
> +#if defined(__or1k_cmov__)
> +	l.cmov		r11, r12, r11		/* ... r += x. */
> +	l.srli		r4, r4, 1		/* y >>= 1 */
> +#else
> +	l.bnf		3f
> +	 l.srli		r4, r4, 1		/* y >>= 1 */
> +	l.ori		r11, r12, 0

This move could be the add to save 1 cycle in the !cmov case.

> +	/* Shift Y back to the right again, subtracting from X.  */
> +2:	l.add		r7, r11, r6	/* tmp1 = quot + mask */
> +3:	l.srli		r6, r6, 1	/* mask >>= 1 */
> +	l.sub		r8, r12, r4	/* tmp2 = x - y */
> +	l.sfleu		r4, r12		/* y <= x */
> +	l.srli		r4, r4, 1	/* y >>= 1 */
> +#if defined(__or1k_cmov__)
> +	l.cmov		r11, r7, r11	/* if (y <= x) quot = tmp1 */
> +	l.cmov		r12, r8, r12	/* if (y <= x) x = tmp2 */
> +#else
> +	l.bnf		4f
> +	 l.nop
> +	l.ori		r11, r7, 0
> +	l.ori		r12, r8, 0

Simiarly.

Although both mul nor div are correct as-is, and need not be fixed immediately.
 I'm only concerned about _init and _fini.


r~
