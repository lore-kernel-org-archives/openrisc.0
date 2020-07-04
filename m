From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sat, 04 Jul 2020 16:11:56 -0000
Subject: [OpenRISC] [PATCH 17/17] arch: rename copy_thread_tls() back to
 copy_thread()
In-Reply-To: <20200625211749.GH1401039@lianli.shorne-pla.net>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
 <20200625211749.GH1401039@lianli.shorne-pla.net>
Message-ID: <20200704161031.lcln4ez6yehgffgq@wittgenstein>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jun 26, 2020 at 06:17:49AM +0900, Stafford Horne wrote:
> On Tue, Jun 23, 2020 at 01:43:26AM +0200, Christian Brauner wrote:
> 
> > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > index d7010e72450c..19045a3efb8a 100644
> > --- a/arch/openrisc/kernel/process.c
> > +++ b/arch/openrisc/kernel/process.c
> > @@ -116,7 +116,7 @@ void release_thread(struct task_struct *dead_task)
> >  extern asmlinkage void ret_from_fork(void);
> >  
> >  /*
> > - * copy_thread_tls
> > + * copy_thread
> >   * @clone_flags: flags
> >   * @usp: user stack pointer or fn for kernel thread
> >   * @arg: arg to fn for kernel thread; always NULL for userspace thread
> > @@ -147,7 +147,7 @@ extern asmlinkage void ret_from_fork(void);
> >   */
> >  
> >  int
> > -copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> > +copy_thread(unsigned long clone_flags, unsigned long usp,
> >  		unsigned long arg, struct task_struct *p, unsigned long tls)
> >  {
> 
> For the OpenRISC bit.
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
> 
> Also, I would agree with what Kees mentioned about aligning the parameters.
> Sure that would be more work but it would be appreciated.

Sure, this is a mechanical change. I'll update the individual patches to account for that.

Thanks!
Christian
