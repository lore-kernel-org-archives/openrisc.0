From: Dmitry V. Levin <ldv@altlinux.org>
Date: Thu, 4 Apr 2019 21:18:49 +0300
Subject: [OpenRISC] [PATCH 6/6 v3] syscalls: Remove start and number
 from syscall_set_arguments() args
In-Reply-To: <20190401134421.442323029@goodmis.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.442323029@goodmis.org>
Message-ID: <20190404181849.GA8711@altlinux.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Apr 01, 2019 at 09:41:10AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().
> 
> Link: http://lkml.kernel.org/r/20190327222014.GA32540 at altlinux.org

FWIW, you can add
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>
 
There are two places listed below where I'd prefer to see more readable
equivalents, but feel free to leave it to respective arch maintainers.

> diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
> index 89a6ec8731d8..671ebd357496 100644
> --- a/arch/nds32/include/asm/syscall.h
> +++ b/arch/nds32/include/asm/syscall.h
> @@ -129,39 +129,20 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
>   * syscall_set_arguments - change system call parameter value
>   * @task:	task of interest, must be in system call entry tracing
>   * @regs:	task_pt_regs() of @task
> - * @i:		argument index [0,5]
> - * @n:		number of arguments; n+i must be [1,6].
>   * @args:	array of argument values to store
>   *
> - * Changes @n arguments to the system call starting with the @i'th argument.
> - * Argument @i gets value @args[0], and so on.
> - * An arch inline version is probably optimal when @i and @n are constants.
> + * Changes 6 arguments to the system call. The first argument gets value
> + * @args[0], and so on.
>   *
>   * It's only valid to call this when @task is stopped for tracing on
>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
> - * It's invalid to call this with @i + @n > 6; we only support system calls
> - * taking up to 6 arguments.
>   */
>  void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> -			   unsigned int i, unsigned int n,
>  			   const unsigned long *args)
>  {
> -	if (n == 0)
> -		return;
> -
> -	if (i + n > SYSCALL_MAX_ARGS) {
> -		pr_warn("%s called with max args %d, handling only %d\n",
> -			__func__, i + n, SYSCALL_MAX_ARGS);
> -		n = SYSCALL_MAX_ARGS - i;
> -	}
> -
> -	if (i == 0) {
> -		regs->orig_r0 = args[0];
> -		args++;
> -		i++;
> -		n--;
> -	}
> +	regs->orig_r0 = args[0];
> +	args++;
>  
> -	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
> +	memcpy(&regs->uregs[0] + 1, args, 5 * sizeof(args[0]));
>  }

A shorter and slightly more readable equivalent of the last memcpy is

	memcpy(&regs->uregs[1], args, 5 * sizeof(args[0]));

> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index ee0b1f6aa36d..59c3e91f2cdb 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -74,15 +74,14 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  
>  static inline void syscall_set_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 const unsigned long *args)
>  {
> -	BUG_ON(i + n > 6);
> +	unsigned int n = 6;
> +
>  	while (n-- > 0)
> -		if (i + n > 0)
> -			regs->gprs[2 + i + n] = args[n];
> -	if (i == 0)
> -		regs->orig_gpr2 = args[0];
> +		if (n > 0)
> +			regs->gprs[2 + n] = args[n];
> +	regs->orig_gpr2 = args[0];
>  }

A shorter and slightly more readable equivalent of the loop is

	while (--n > 0)
		regs->gprs[2 + n] = args[n];


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190404/f6b30284/attachment-0001.sig>
