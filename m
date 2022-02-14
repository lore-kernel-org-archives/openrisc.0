From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 14 Feb 2022 22:13:34 +0000
Subject: [OpenRISC] [PATCH 04/14] x86: use more conventional access_ok()
 definition
In-Reply-To: <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org> <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
 <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
Message-ID: <2dda07f893cb4ef9b5ea2265adccb98f@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Linus Torvalds
> Sent: 14 February 2022 20:24
> >
> > x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
> > get_user() assembler implementation does the same.
> 
> Side note: we could just check the sign bit instead, and avoid big
> constants that way.

The cheap test for most 64bit is (addr | size) >> 62 != 0.

I did some tests last week and the compilers correctly optimise
out constant size.

Doesn't sparc64 still need a wrap test?
Or is that assumed because there is always an unmapped page
and transfer are 'adequately' done on increasing addresses?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
