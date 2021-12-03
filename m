From: Stafford Horne <shorne@gmail.com>
Date: Fri, 3 Dec 2021 16:53:23 +0900
Subject: [OpenRISC] [PATCH] openrisc: remove wrappers for clone and fork
In-Reply-To: <20211128022803.3828408-1-shorne@gmail.com>
References: <20211128022803.3828408-1-shorne@gmail.com>
Message-ID: <YanM831BiT+tzmd7@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Nov 28, 2021 at 11:28:01AM +0900, Stafford Horne wrote:
> The comment here explains that the extra saved registers are clobbered
> by _switch.  However, looking at switch they are definitely saved, so I
> am not sure why these wrappers are needed.  This was noticed when
> auditing the clone3 syscall path which works fine and does not have the
> extra wrapper code.
> 
> The patch removes the wrapper code as a cleanup.

Nak.

This breaks stuff.  More extensive testing resulted in instability.

There may be another way, but as for now this code that restores these
registers during return is basically clobbering them again.

        l.lwz   r12,PT_GPR12(r1)
        l.lwz   r14,PT_GPR14(r1)
        l.lwz   r16,PT_GPR16(r1)
        l.lwz   r18,PT_GPR18(r1)
        l.lwz   r20,PT_GPR20(r1)
        l.lwz   r22,PT_GPR22(r1)
        l.lwz   r24,PT_GPR24(r1)
        l.lwz   r26,PT_GPR26(r1)
        l.lwz   r28,PT_GPR28(r1)

        l.j     _syscall_return
         l.nop

-Stafford

> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/include/asm/syscalls.h |  7 ------
>  arch/openrisc/kernel/entry.S         | 36 ++--------------------------
>  2 files changed, 2 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/syscalls.h b/arch/openrisc/include/asm/syscalls.h
> index 3a7eeae6f56a..c8c8a5072ad9 100644
> --- a/arch/openrisc/include/asm/syscalls.h
> +++ b/arch/openrisc/include/asm/syscalls.h
> @@ -20,11 +20,4 @@ asmlinkage long sys_or1k_atomic(unsigned long type, unsigned long *v1,
>  
>  #include <asm-generic/syscalls.h>
>  
> -asmlinkage long __sys_clone(unsigned long clone_flags, unsigned long newsp,
> -			void __user *parent_tid, void __user *child_tid, int tls);
> -asmlinkage long __sys_fork(void);
> -
> -#define sys_clone __sys_clone
> -#define sys_fork __sys_fork
> -
>  #endif /* __ASM_OPENRISC_SYSCALLS_H */
> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> index 59c6d3aa7081..062967e09fbb 100644
> --- a/arch/openrisc/kernel/entry.S
> +++ b/arch/openrisc/kernel/entry.S
> @@ -1139,43 +1139,11 @@ ENTRY(_switch)
>  
>  /* ==================================================================== */
>  
> -/* These all use the delay slot for setting the argument register, so the
> +/*
> + * This uses the delay slot for setting the argument register, so the
>   * jump is always happening after the l.addi instruction.
> - *
> - * These are all just wrappers that don't touch the link-register r9, so the
> - * return from the "real" syscall function will return back to the syscall
> - * code that did the l.jal that brought us here.
> - */
> -
> -/* fork requires that we save all the callee-saved registers because they
> - * are all effectively clobbered by the call to _switch.  Here we store
> - * all the registers that aren't touched by the syscall fast path and thus
> - * weren't saved there.
>   */
>  
> -_fork_save_extra_regs_and_call:
> -	l.sw    PT_GPR14(r1),r14
> -	l.sw    PT_GPR16(r1),r16
> -	l.sw    PT_GPR18(r1),r18
> -	l.sw    PT_GPR20(r1),r20
> -	l.sw    PT_GPR22(r1),r22
> -	l.sw    PT_GPR24(r1),r24
> -	l.sw    PT_GPR26(r1),r26
> -	l.jr	r29
> -	 l.sw    PT_GPR28(r1),r28
> -
> -ENTRY(__sys_clone)
> -	l.movhi	r29,hi(sys_clone)
> -	l.ori	r29,r29,lo(sys_clone)
> -	l.j	_fork_save_extra_regs_and_call
> -	 l.nop
> -
> -ENTRY(__sys_fork)
> -	l.movhi	r29,hi(sys_fork)
> -	l.ori	r29,r29,lo(sys_fork)
> -	l.j	_fork_save_extra_regs_and_call
> -	 l.nop
> -
>  ENTRY(sys_rt_sigreturn)
>  	l.jal	_sys_rt_sigreturn
>  	 l.addi	r3,r1,0
> -- 
> 2.31.1
> 
