From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 15 Feb 2022 09:30:41 +0000
Subject: [OpenRISC] [PATCH 08/14] arm64: simplify access_ok()
In-Reply-To: <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
Message-ID: <153bb1887f484ed79ce8224845a4b2ea@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Ard Biesheuvel
> Sent: 15 February 2022 08:18
> 
> On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > arm64 has an inline asm implementation of access_ok() that is derived from
> > the 32-bit arm version and optimized for the case that both the limit and
> > the size are variable. With set_fs() gone, the limit is always constant,
> > and the size usually is as well, so just using the default implementation
> > reduces the check into a comparison against a constant that can be
> > scheduled by the compiler.
> >
> > On a defconfig build, this saves over 28KB of .text.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 28 +++++-----------------------
> >  1 file changed, 5 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 357f7bd9c981..e8dce0cc5eaa 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -26,6 +26,8 @@
> >  #include <asm/memory.h>
> >  #include <asm/extable.h>
> >
> > +static inline int __access_ok(const void __user *ptr, unsigned long size);
> > +
> >  /*
> >   * Test whether a block of memory is a valid user space address.
> >   * Returns 1 if the range is valid, 0 otherwise.
> > @@ -33,10 +35,8 @@
> >   * This is equivalent to the following test:
> >   * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
> >   */
> > -static inline unsigned long __access_ok(const void __user *addr, unsigned long size)
> > +static inline int access_ok(const void __user *addr, unsigned long size)
> >  {
> > -       unsigned long ret, limit = TASK_SIZE_MAX - 1;
> > -
> >         /*
> >          * Asynchronous I/O running in a kernel thread does not have the
> >          * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
> > @@ -46,27 +46,9 @@ static inline unsigned long __access_ok(const void __user *addr, unsigned long s
> >             (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
> >                 addr = untagged_addr(addr);
> >
> > -       __chk_user_ptr(addr);
> > -       asm volatile(
> > -       // A + B <= C + 1 for all A,B,C, in four easy steps:
> > -       // 1: X = A + B; X' = X % 2^64
> > -       "       adds    %0, %3, %2\n"
> > -       // 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
> > -       "       csel    %1, xzr, %1, hi\n"
> > -       // 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
> > -       //    to compensate for the carry flag being set in step 4. For
> > -       //    X > 2^64, X' merely has to remain nonzero, which it does.
> > -       "       csinv   %0, %0, xzr, cc\n"
> > -       // 4: For X < 2^64, this gives us X' - C - 1 <= 0, where the -1
> > -       //    comes from the carry in being clear. Otherwise, we are
> > -       //    testing X' - C == 0, subject to the previous adjustments.
> > -       "       sbcs    xzr, %0, %1\n"
> > -       "       cset    %0, ls\n"
> > -       : "=&r" (ret), "+r" (limit) : "Ir" (size), "0" (addr) : "cc");
> > -
> > -       return ret;
> > +       return likely(__access_ok(addr, size));
> >  }
> > -#define __access_ok __access_ok
> > +#define access_ok access_ok
> >
> >  #include <asm-generic/access_ok.h>
> >
> > --
> > 2.29.2
> >
> 
> With set_fs() out of the picture, wouldn't it be sufficient to check
> that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> That would also remove the need to strip the tag from the address.
> 
> Something like
> 
>     asm goto("tbnz  %0, #55, %2     \n"
>              "tbnz  %1, #55, %2     \n"
>              :: "r"(addr), "r"(addr + size - 1) :: notok);
>     return 1;
> notok:
>     return 0;
> 
> with an additional sanity check on the size which the compiler could
> eliminate for compile-time constant values.

Is there are reason not to just use:
	size < 1u << 48 && !((addr | (addr + size - 1)) & 1u << 55)

(The -1 can be removed if the last user page is never mapped)

Ugg, is arm64 addressing as horrid as it looks - with the 'kernel'
bit in the middle of the virtual address space?
It seems to be:
	<zero:4><tag:4><kernel:1><ignored:7><address:48>
Although I found some references to 44 bit VA and to code using the
'ignored' bits as tags - relying on the hardware ignoring them.
There might be some feature that uses the top 4 bits as well.

Another option is assuming that accesses are 'reasonably sequential',
removing the length check and ensuring there is an unmapped page
between valid user and kernel addresses.
That probably requires and unmapped page at the bottom of kernel space
which may not be achievable.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
