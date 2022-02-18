From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 18 Feb 2022 09:30:32 +0000
Subject: [OpenRISC] [PATCH v2 13/18] uaccess: generalize access_ok()
In-Reply-To: <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-14-arnd@kernel.org>
 <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
Message-ID: <93a1ee797e9d4f789dff85a3c0f0c232@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Andy Lutomirski
> Sent: 17 February 2022 19:15
...
> This isn't actually optimal.  On x86, TASK_SIZE_MAX is a bizarre
> constant that has a very specific value to work around a bug^Wdesign
> error^Wfeature of Intel CPUs.  TASK_SIZE_MAX is the maximum address at
> which userspace is permitted to allocate memory, but there is a huge
> gap between user and kernel addresses, and any value in the gap would
> be adequate for the comparison.  If we wanted to optimize this, simply
> checking the high bit (which x86 can do without any immediate
> constants at all) would be sufficient and, for an access known to fit
> in 32 bits, one could get even fancier and completely ignore the size
> of the access.  (For accesses not known to fit in 32 bits, I suspect
> some creativity could still come up with a construction that's
> substantially faster than the one in your patch.)
> 
> So there's plenty of room for optimization here.
> 
> (This is not in any respect a NAK -- it's just an observation that
> this could be even better.)

For 64bit arch that use the top bit to separate user/kernel
you can test '(addr | size) >> 62)'.
The compiler optimises out constant sizes.

This has all been mentioned a lot of times.
You do get different fault types.

OTOH an explicit check for constant size (less than something big)
can use the cheaper test of the sign bit.
Big constant sizes could be compile time errors.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
