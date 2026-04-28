Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1744DB67;
	Tue, 28 Apr 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397642; cv=none; b=E5jnBRqTT4p+75bEEwpZEvuDra1ou+TYJ0wedEbpqoizPKG8gH3NkjsY4JMxZf8iJh/wiXAwX4g3tOOezRFJSRvda9zPeCE8qsl+BftCE2a5ZTD/7izzuEL9TDsQGY9BNLODgNqkd70aK41R5bEP7gQWtu2DGLmIqJLcxL4+XvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397642; c=relaxed/simple;
	bh=UZC8SFlB86YJDJswwxe6Gnyvjqf8PPN1xkQBYA1ImjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuSJmXLz5+sEqSi5DBCvkdlXo82RdwxSm021tH4Jdy0m6T+Y+XDOcmPAvbiXwVZtiRBKe70zZUj5SNlPKUYS44Y/O0DyrpduHCLDK4i3HlhH8TLd666vYE8KrRMNYGek4i3+2GKRbnWgoBGyTEPCaCxv0A96Uxw4QKo83bMrvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GzV8SSQz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GzV8SSQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777397636;
	bh=UZC8SFlB86YJDJswwxe6Gnyvjqf8PPN1xkQBYA1ImjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzV8SSQzDSNGVAcYAfHfU4jmjKxtVCD7/wlo551LJ78SCe3N6jGcGyabG/728lgNn
	 J1Ck0bvoh+TQug+wabk/Wnh6dyXBD+scrVJERj/QchHDf278IohiT8+r9DlrTQO1g9
	 yMNEQwggRfyz3SoGVIdZQkzsdh5UECffuyLfhrcQ=
Date: Tue, 28 Apr 2026 19:33:55 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Stafford Horne <shorne@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for OpenRISC / or1k
Message-ID: <f501622f-aa21-4ac2-ab90-4775d6bf5867@t-8ch.de>
References: <20260428-nolibc-openrisc-v1-1-33b399054af6@weissschuh.net>
 <afDor4Fh8aZt82sr@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afDor4Fh8aZt82sr@antec>

On 2026-04-28 18:04:47+0100, Stafford Horne wrote:
> On Tue, Apr 28, 2026 at 05:48:51PM +0200, Thomas Weißschuh wrote:
> > Add support for OpenRISC / or1k to nolibc.
> > 
> > _start() uses the same wrapper construct as in arch-sh.h.
> > libgcc is necessary as OpenRISC is missing 64-bit multiplication.
> 
> There are a few minor issues with this patch.

Thanks for taking a look!

> Could you give any background for this?  What are you working on?
> Just getting more coverage in the test suite?

I have no specific goal. In general I'd like for nolibc to support all
architectures which are supported by Linux.

> Do you have any results for or1k, considering one of the issues I
> highlighted before I am not sure this will compile as is.

This compiled fine for me and ran the full nolibc testsuite.
More details below.

With "highlighted before", do you mean "below"?

> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/Makefile                  |   2 +-
> >  tools/include/nolibc/arch-openrisc.h           | 176 +++++++++++++++++++++++++
> >  tools/include/nolibc/arch.h                    |   2 +
> >  tools/testing/selftests/nolibc/Makefile.nolibc |   5 +
> >  tools/testing/selftests/nolibc/run-tests.sh    |   4 +-
> >  5 files changed, 187 insertions(+), 2 deletions(-)

(...)

> > +#define __nolibc_syscall0(num)                                                \
> > +({                                                                            \
> > +	register long _num __asm__ ("r11") = (num);                           \
> > +	register long _ret __asm__ ("r11");                                   \
> > +									      \
> > +	__asm__ volatile (                                                    \
> > +		"l.sys 1\n"                                                   \
> > +		"l.nop\n"                                                     \
> 
> We do not need l.nop for l.sys instructions.  They do not have a delay-slot line
> branches.

Ack, I'll remove them.

> > +		: "=r"(_ret)                                                  \
> > +		: "r"(_num)                                                   \
> > +		: "r3", "r4", "r5", "r6", "r7", "r8",                         \
> > +		  _NOLIBC_SYSCALL_CLOBBERLIST                                 \
> > +	);                                                                    \
> > +	_ret;                                                                 \
> > +})

(...)

> > +#ifndef NOLIBC_NO_RUNTIME
> > +/* startup code */
> > +void _start_wrapper(void);
> > +void __attribute__((weak,noreturn))
> > +__nolibc_entrypoint __nolibc_no_stack_protector
> > +_start_wrapper(void)
> > +{
> > +	__asm__ volatile (
> > +		".global _start\n"           /* The C function will have a prologue,         */
> > +		".type _start, @function\n"  /* corrupting "sp"                              */
> > +		".weak _start\n"
> > +		"_start:\n"
> > +
> > +		"l.or r3,sp,sp\n"            /* save stack pointer to 3, as arg1 of _start_c */
> 
> What is sp here?  There is no sp alias in OpenRISC, should it be r1?  Does this
> compile?

It compiles and works with my fairly modern GCC.
It is translated to 'r1'. If it is not idiomatic, I'll change it to r1.

> 
> > +		"l.jal _start_c\n"           /* transfer to c runtime                        */
> > +		"l.nop\n"
> 
> The l.or can go in the delay slot.

Ack.

> Also, preferrably we use spaces between args, and a space to indicate a delay
> slot e.g.
> 
> 	"l.jal _start_c\n"
> 	 "l.or r3, r1, r1\n"

I'd prefer to keep this aligned with the rest of nolibc instead of
aligning it with the arch/openrisc/ code.

> > +
> > +		".size _start, .-_start\n"
> > +	);
> > +	__nolibc_entrypoint_epilogue();
> > +}
> > +#endif /* NOLIBC_NO_RUNTIME */

(...)

> The rest looks ok to me.

Thanks!


Thomas
