From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 15 Feb 2022 13:28:59 +0000
Subject: [OpenRISC] [PATCH 09/14] m68k: drop custom __access_ok()
In-Reply-To: <CAK8P3a0t-dnJXvXH0Mx5L-AeVQe1mYzRi0sQjYxzMQw-mVPv0Q@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-10-arnd@kernel.org>
 <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk> <20220215062942.GA12551@lst.de>
 <YgtSpk0boDjsyjFK@zeniv-ca.linux.org.uk>
 <CAK8P3a0t-dnJXvXH0Mx5L-AeVQe1mYzRi0sQjYxzMQw-mVPv0Q@mail.gmail.com>
Message-ID: <665a8abfa86f4b5f9a66e294a79bb531@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann
> Sent: 15 February 2022 10:02
> 
> On Tue, Feb 15, 2022 at 8:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Feb 15, 2022 at 07:29:42AM +0100, Christoph Hellwig wrote:
> > > On Tue, Feb 15, 2022 at 12:37:41AM +0000, Al Viro wrote:
> > > > Perhaps simply wrap that sucker into #ifdef CONFIG_CPU_HAS_ADDRESS_SPACES
> > > > (and trim the comment down to "coldfire and 68000 will pick generic
> > > > variant")?
> > >
> > > I wonder if we should invert CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
> > > select the separate address space config for s390, sparc64, non-coldfire
> > > m68k and mips with EVA and then just have one single access_ok for
> > > overlapping address space (as added by Arnd) and non-overlapping ones
> > > (always return true).
> >
> > parisc is also such...  How about
> >
> >         select ALTERNATE_SPACE_USERLAND
> >
> > for that bunch?
> 
> Either of those works for me. My current version has this keyed off
> TASK_SIZE_MAX==ULONG_MAX, but a CONFIG_ symbol does
> look more descriptive.
> 
> >  While we are at it, how many unusual access_ok() instances are
> > left after this series?  arm64, itanic, um, anything else?
> 
> x86 adds a WARN_ON_IN_IRQ() check in there.

If is a noop unless CONFIG_DEBUG_ATOMIC_SLEEP is set.
I doubt that is often enabled.

> This could be
> made generic, but it's not obvious what exactly the exceptions are
> that other architectures need. The arm64 tagged pointers could
> probably also get integrated into the generic version.
> 
> > FWIW, sparc32 has a slightly unusual instance (see uaccess_32.h there); it's
> > obviously cheaper than generic and I wonder if the trick is legitimate (and
> > applicable elsewhere, perhaps)...
> 
> Right, a few others have the same, but I wasn't convinced that this
> is actually safe for call possible cases: it's trivial to construct a caller
> that works on other architectures but not this one, if you pass a large
> enough size value and don't access the contents in sequence.

You'd need code that did an access_ok() check and then read from
a large offset from the address - unlikely.
It's not like the access_ok() check for read/write is done on syscall
entry and then everything underneath assumes it is valid.

Hasn't (almost) everything been checked for function calls between
user_access_begin() and the actual accesses?
And access_ok() is done by/at the same time as user_access_begin()?

You do need an unmapped page above the address that is tested.

> Also, like the ((addr | (addr + size)) & MASK) check on some other
> architectures, it is less portable because it makes assumptions about
> the actual layout beyond a fixed address limit.

Isn't that test broken without a separate bound check on size?

I also seem to remember that access_ok(xxx, 0) is always 'ok'
and some of the 'fast' tests give a false negative if the user
buffer ends with the last byte of user address space.

So you may need:
	size < TASK_SIZE && (addr < (TASK_SIZE - size - 1) || !size)
(sprinkled with [un]likely())

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
