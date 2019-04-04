From: Dmitry V. Levin <ldv@altlinux.org>
Date: Thu, 4 Apr 2019 21:17:58 +0300
Subject: [OpenRISC] [PATCH 5/6 v3] syscalls: Remove start and number
 from syscall_get_arguments() args
In-Reply-To: <20190401134421.278590567@goodmis.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
Message-ID: <20190404181758.GA8071@altlinux.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Apr 01, 2019 at 09:41:09AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in only
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the first 6
> arguments of a system call.
> 
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.
> 
> Link: http://lkml.kernel.org/r/20161107213233.754809394 at goodmis.org

FWIW, you can add
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>

There are several places listed below where I'd prefer to see more readable
equivalents, but feel free to leave it to respective arch maintainers.

> diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
> index 4af9c7b6f13a..ae3a1e24fabd 100644
> --- a/arch/hexagon/include/asm/syscall.h
> +++ b/arch/hexagon/include/asm/syscall.h
> @@ -37,10 +37,8 @@ static inline long syscall_get_nr(struct task_struct *task,
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
> -	BUG_ON(i + n > 6);
> -	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
> +	memcpy(args, &(&regs->r00)[0], 6 * sizeof(args[0]));

A shorter and slightly more readable equivalent is

	memcpy(args, &regs->r00, 6 * sizeof(args[0]));

> diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
> index f7e5e86765fe..89a6ec8731d8 100644
> --- a/arch/nds32/include/asm/syscall.h
> +++ b/arch/nds32/include/asm/syscall.h
> @@ -108,42 +108,21 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
>   * syscall_get_arguments - extract system call parameter values
>   * @task:	task of interest, must be blocked
>   * @regs:	task_pt_regs() of @task
> - * @i:		argument index [0,5]
> - * @n:		number of arguments; n+i must be [1,6].
>   * @args:	array filled with argument values
>   *
> - * Fetches @n arguments to the system call starting with the @i'th argument
> - * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
> - * An arch inline version is probably optimal when @i and @n are constants.
> + * Fetches 6 arguments to the system call (from 0 through 5). The first
> + * argument is stored in @args[0], and so on.
>   *
>   * It's only valid to call this when @task is stopped for tracing on
>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
> - * It's invalid to call this with @i + @n > 6; we only support system calls
> - * taking up to 6 arguments.
>   */
>  #define SYSCALL_MAX_ARGS 6
>  void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> -			   unsigned int i, unsigned int n, unsigned long *args)
> +			   unsigned long *args)
>  {
> -	if (n == 0)
> -		return;
> -	if (i + n > SYSCALL_MAX_ARGS) {
> -		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
> -		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
> -		pr_warning("%s called with max args %d, handling only %d\n",
> -			   __func__, i + n, SYSCALL_MAX_ARGS);
> -		memset(args_bad, 0, n_bad * sizeof(args[0]));
> -		memset(args_bad, 0, n_bad * sizeof(args[0]));
> -	}
> -
> -	if (i == 0) {
> -		args[0] = regs->orig_r0;
> -		args++;
> -		i++;
> -		n--;
> -	}
> -
> -	memcpy(args, &regs->uregs[0] + i, n * sizeof(args[0]));
> +	args[0] = regs->orig_r0;
> +	args++;
> +	memcpy(args, &regs->uregs[0] + 1, 5 * sizeof(args[0]));
>  }

A shorter and slightly more readable equivalent of the last memcpy is

	memcpy(args, &regs->uregs[1], 5 * sizeof(args[0]));

> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 1a0e7a8b1c81..5c9b9dc82b7e 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -65,22 +65,20 @@ static inline void syscall_set_return_value(struct task_struct *task,
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
>  	unsigned long val, mask = -1UL;
> -
> -	BUG_ON(i + n > 6);
> +	unsigned int n = 6;
>  
>  #ifdef CONFIG_COMPAT
>  	if (test_tsk_thread_flag(task, TIF_32BIT))
>  		mask = 0xffffffff;
>  #endif
>  	while (n--) {
> -		if (n == 0 && i == 0)
> +		if (n == 0)
>  			val = regs->orig_gpr3;
>  		else
> -			val = regs->gpr[3 + i + n];
> +			val = regs->gpr[3 + n];
>  
>  		args[n] = val & mask;
>  	}

A shorter and slightly more readable equivalent of the loop is

	while (--n)
		args[n] = regs->gpr[3 + n] & mask;
	args[0] = regs->orig_gpr3 & mask;

> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index 96f9a9151fde..ee0b1f6aa36d 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -56,27 +56,20 @@ static inline void syscall_set_return_value(struct task_struct *task,
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
>  	unsigned long mask = -1UL;
> +	unsigned int n = 6;
>  
> -	/*
> -	 * No arguments for this syscall, there's nothing to do.
> -	 */
> -	if (!n)
> -		return;
> -
> -	BUG_ON(i + n > 6);
>  #ifdef CONFIG_COMPAT
>  	if (test_tsk_thread_flag(task, TIF_31BIT))
>  		mask = 0xffffffff;
>  #endif
>  	while (n-- > 0)
> -		if (i + n > 0)
> -			args[n] = regs->gprs[2 + i + n] & mask;
> -	if (i == 0)
> -		args[0] = regs->orig_gpr2 & mask;
> +		if (n > 0)
> +			args[n] = regs->gprs[2 + n] & mask;
> +
> +	args[0] = regs->orig_gpr2 & mask;

A shorter and slightly more readable equivalent of the loop is

	while (--n > 0)
		args[n] = regs->gprs[2 + n] & mask;


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190404/1ec25a34/attachment-0001.sig>
