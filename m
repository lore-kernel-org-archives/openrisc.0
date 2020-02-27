From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 Feb 2020 22:16:20 +0900
Subject: [OpenRISC] [PATCH 1/3] openrisc: Convert copy_thread to
 copy_thread_tls
In-Reply-To: <20200227121952.hywkuydswvdn3myc@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-2-shorne@gmail.com>
 <20200227121952.hywkuydswvdn3myc@wittgenstein>
Message-ID: <20200227131620.GG7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 27, 2020 at 01:19:52PM +0100, Christian Brauner wrote:
> On Thu, Feb 27, 2020 at 07:56:23AM +0900, Stafford Horne wrote:
> > This is required for clone3 which passes the TLS value through a
> > struct rather than a register.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/Kconfig          |  1 +
> >  arch/openrisc/kernel/process.c | 15 +++++----------
> >  2 files changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index 1928e061ff96..5debdbe6fc35 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -14,6 +14,7 @@ config OPENRISC
> >  	select HANDLE_DOMAIN_IRQ
> >  	select GPIOLIB
> >  	select HAVE_ARCH_TRACEHOOK
> > +	select HAVE_COPY_THREAD_TLS
> >  	select SPARSE_IRQ
> >  	select GENERIC_IRQ_CHIP
> >  	select GENERIC_IRQ_PROBE
> > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > index b06f84f6676f..6695f167e126 100644
> > --- a/arch/openrisc/kernel/process.c
> > +++ b/arch/openrisc/kernel/process.c
> > @@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
> >  extern asmlinkage void ret_from_fork(void);
> >  
> >  /*
> > - * copy_thread
> > + * copy_thread_tls
> >   * @clone_flags: flags
> >   * @usp: user stack pointer or fn for kernel thread
> >   * @arg: arg to fn for kernel thread; always NULL for userspace thread
> >   * @p: the newly created task
> >   * @regs: CPU context to copy for userspace thread; always NULL for kthread
> > + * @tls: the Thread Local Storate pointer for the new process
> >   *
> >   * At the top of a newly initialized kernel stack are two stacked pt_reg
> >   * structures.  The first (topmost) is the userspace context of the thread.
> > @@ -148,8 +149,8 @@ extern asmlinkage void ret_from_fork(void);
> >   */
> >  
> >  int
> > -copy_thread(unsigned long clone_flags, unsigned long usp,
> > -	    unsigned long arg, struct task_struct *p)
> > +copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> > +		unsigned long arg, struct task_struct *p, unsigned long tls)
> >  {
> >  	struct pt_regs *userregs;
> >  	struct pt_regs *kregs;
> > @@ -180,15 +181,9 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
> >  
> >  		/*
> >  		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
> 
> Maybe reword this to:
> 
> For CLONE_SETTLS set "tp" (r10) to the TLS pointer. We probably
> shouldn't mention clone() explicitly anymore, since we now have
> clone3() and therefore two callers that pass in tls arguments.

Sure, I updated it in the 'docs' commit, but as you mention I can just remove
the mention of clone* all together.  I will just remove that here and it won't
have to be touched in the 'docs' commit.
