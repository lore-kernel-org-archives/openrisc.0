From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 14 Feb 2022 21:06:58 +0000
Subject: [OpenRISC] [PATCH 08/14] arm64: simplify access_ok()
In-Reply-To: <20220214163452.1568807-9-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
Message-ID: <cc6006c6-b073-7cc0-484d-7ddd193a8c2c@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2022-02-14 16:34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> arm64 has an inline asm implementation of access_ok() that is derived from
> the 32-bit arm version and optimized for the case that both the limit and
> the size are variable. With set_fs() gone, the limit is always constant,
> and the size usually is as well, so just using the default implementation
> reduces the check into a comparison against a constant that can be
> scheduled by the compiler.

Aww, I still vividly remember the birth of this madness, sat with my 
phone on a Saturday morning waiting for my bike to be MOT'd, staring at 
the 7-instruction sequence that Mark and I had come up with and certain 
that it could be shortened still. Kinda sad to see it go, but at the 
same time, glad that it can.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> On a defconfig build, this saves over 28KB of .text.

Not to mention saving those "WTF is going on there... oh yeah, 
access_ok()" moments when looking through disassembly :)

Cheers,
Robin.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm64/include/asm/uaccess.h | 28 +++++-----------------------
>   1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 357f7bd9c981..e8dce0cc5eaa 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -26,6 +26,8 @@
>   #include <asm/memory.h>
>   #include <asm/extable.h>
>   
> +static inline int __access_ok(const void __user *ptr, unsigned long size);
> +
>   /*
>    * Test whether a block of memory is a valid user space address.
>    * Returns 1 if the range is valid, 0 otherwise.
> @@ -33,10 +35,8 @@
>    * This is equivalent to the following test:
>    * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
>    */
> -static inline unsigned long __access_ok(const void __user *addr, unsigned long size)
> +static inline int access_ok(const void __user *addr, unsigned long size)
>   {
> -	unsigned long ret, limit = TASK_SIZE_MAX - 1;
> -
>   	/*
>   	 * Asynchronous I/O running in a kernel thread does not have the
>   	 * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
> @@ -46,27 +46,9 @@ static inline unsigned long __access_ok(const void __user *addr, unsigned long s
>   	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
>   		addr = untagged_addr(addr);
>   
> -	__chk_user_ptr(addr);
> -	asm volatile(
> -	// A + B <= C + 1 for all A,B,C, in four easy steps:
> -	// 1: X = A + B; X' = X % 2^64
> -	"	adds	%0, %3, %2\n"
> -	// 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
> -	"	csel	%1, xzr, %1, hi\n"
> -	// 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
> -	//    to compensate for the carry flag being set in step 4. For
> -	//    X > 2^64, X' merely has to remain nonzero, which it does.
> -	"	csinv	%0, %0, xzr, cc\n"
> -	// 4: For X < 2^64, this gives us X' - C - 1 <= 0, where the -1
> -	//    comes from the carry in being clear. Otherwise, we are
> -	//    testing X' - C == 0, subject to the previous adjustments.
> -	"	sbcs	xzr, %0, %1\n"
> -	"	cset	%0, ls\n"
> -	: "=&r" (ret), "+r" (limit) : "Ir" (size), "0" (addr) : "cc");
> -
> -	return ret;
> +	return likely(__access_ok(addr, size));
>   }
> -#define __access_ok __access_ok
> +#define access_ok access_ok
>   
>   #include <asm-generic/access_ok.h>
>   
