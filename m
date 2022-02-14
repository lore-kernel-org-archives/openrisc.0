From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 14 Feb 2022 17:15:25 +0000
Subject: [OpenRISC] [PATCH 07/14] uaccess: generalize access_ok()
In-Reply-To: <20220214163452.1568807-8-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-8-arnd@kernel.org>
Message-ID: <YgqOLZbFK7/B2HJT@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 05:34:45PM +0100, Arnd Bergmann wrote:

> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index c7b763d2f526..8867ddf3e6c7 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -136,7 +136,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
>  static int
>  setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>  {
> -	struct rt_sigframe *frame;
> +	struct rt_sigframe __user *frame;
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));

Minor nit: might make sense to separate annotations (here, on nios2, etc.) from the rest...

This, OTOH,

> diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
> index 5c12fb46bc61..000bac67cf31 100644
> --- a/arch/sparc/include/asm/uaccess_64.h
> +++ b/arch/sparc/include/asm/uaccess_64.h
...
> -static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
> -{
> -	if (__builtin_constant_p(size))
> -		return addr > limit - size;
> -
> -	addr += size;
> -	if (addr < size)
> -		return true;
> -
> -	return addr > limit;
> -}
> -
> -#define __range_not_ok(addr, size, limit)                               \
> -({                                                                      \
> -	__chk_user_ptr(addr);                                           \
> -	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
> -})
> -
> -static inline int __access_ok(const void __user * addr, unsigned long size)
> -{
> -	return 1;
> -}
> -
> -static inline int access_ok(const void __user * addr, unsigned long size)
> -{
> -	return 1;
> -}
> +#define __range_not_ok(addr, size, limit) (!__access_ok(addr, size))

is really wrong.  For sparc64, access_ok() should always be true.
This __range_not_ok() thing is used *only* for valid_user_frame() in
arch/sparc/kernel/perf_event.c - it's not a part of normal access_ok()
there.

sparc64 has separate address spaces for kernel and for userland; access_ok()
had never been useful there.  
