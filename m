From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 Feb 2020 09:31:05 +0900
Subject: [OpenRISC] [PATCH 1/3] openrisc: Convert copy_thread to
 copy_thread_tls
In-Reply-To: <20200226225625.28935-2-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-2-shorne@gmail.com>
Message-ID: <20200227003105.GF7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 27, 2020 at 07:56:23AM +0900, Stafford Horne wrote:
> This is required for clone3 which passes the TLS value through a
> struct rather than a register.

[...]
 
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index b06f84f6676f..6695f167e126 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
>  extern asmlinkage void ret_from_fork(void);
>  
>  /*
> - * copy_thread
> + * copy_thread_tls
>   * @clone_flags: flags
>   * @usp: user stack pointer or fn for kernel thread
>   * @arg: arg to fn for kernel thread; always NULL for userspace thread
>   * @p: the newly created task
>   * @regs: CPU context to copy for userspace thread; always NULL for kthread
> + * @tls: the Thread Local Storate pointer for the new process

This should be *Storage*.
 
