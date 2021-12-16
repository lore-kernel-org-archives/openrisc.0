From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 16 Dec 2021 17:49:27 +0000
Subject: [OpenRISC] [PATCH v2 00/13] Unify asm/unaligned.h around struct
 helper
In-Reply-To: <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
Message-ID: <5a46959bfe654ae9a8a4e1b1adf0db95@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Ard Biesheuvel
> Sent: 16 December 2021 17:30
> 
> Hi Arnd,
> 
> (replying to an old thread as this came up in the discussion regarding
> misaligned loads and stored in siphash() when compiled for ARM
> [f7e5b9bfa6c8820407b64eabc1f29c9a87e8993d])
> 
> On Fri, 14 May 2021 at 12:02, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The get_unaligned()/put_unaligned() helpers are traditionally architecture
> > specific, with the two main variants being the "access-ok.h" version
> > that assumes unaligned pointer accesses always work on a particular
> > architecture, and the "le-struct.h" version that casts the data to a
> > byte aligned type before dereferencing, for architectures that cannot
> > always do unaligned accesses in hardware.

I'm pretty sure the compiler is allowed to 'read through' that cast
and still do an aligned access.
It has always been hard to get the compiler to 'forget' about known/expected
alignment - typically trying to stop memcpy() faulting on sparc.
Real function calls are usually required - but LTO may scupper that.

> >
> > Based on the discussion linked below, it appears that the access-ok
> > version is not realiable on any architecture, but the struct version
> > probably has no downsides. This series changes the code to use the
> > same implementation on all architectures, addressing the few exceptions
> > separately.
> >
> > I've included this version in the asm-generic tree for 5.14 already,
> > addressing the few issues that were pointed out in the RFC. If there
> > are any remaining problems, I hope those can be addressed as follow-up
> > patches.
> >
> 
> I think this series is a huge improvement, but it does not solve the
> UB problem completely. As we found, there are open issues in the GCC
> bugzilla regarding assumptions in the compiler that aligned quantities
> either overlap entirely or not at all. (e.g.,
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363)

I think we can stop the compiler merging unaligned requests by adding a byte-sized
memory barrier for the base address before and after the access.
That should still support complex addressing modes (esp on x86).

Another option is to do the misaligned access from within an asm statement.
While architecture dependant, it only really depends on the syntax of the ld/st
instruction.
The compiler can't merge those because it doesn't know whether the data is
'frobbed' before/after the memory access.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
