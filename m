From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Feb 2022 08:29:59 +0100
Subject: [OpenRISC] [PATCH v2 05/18] x86: remove __range_not_ok()
In-Reply-To: <20220218062851.GC22576@lst.de>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-6-arnd@kernel.org>
 <20220218062851.GC22576@lst.de>
Message-ID: <CAK8P3a1Dhn1Gsap1Wss2xpKBwe3jWLAmMYtL7S1-26tZ5D_2fQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 18, 2022 at 7:28 AM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Feb 16, 2022 at 02:13:19PM +0100, Arnd Bergmann wrote:
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2794,7 +2794,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> >  static inline int
> >  valid_user_frame(const void __user *fp, unsigned long size)
> >  {
> > -     return (__range_not_ok(fp, size, TASK_SIZE) == 0);
> > +     return __access_ok(fp, size);
> >  }
>
> valid_user_frame just need to go away and the following __get_user calls
> replaced with normal get_user ones.

As I understand it, that would not work here because get_user() calls
access_ok() rather than __access_ok(), and on x86 that can not be
called in NMI context.

It is a bit odd that x86 is the only architecture that has this check,
but adding
it was clearly intentional, see 7c4788950ba5 ("x86/uaccess, sched/preempt:
Verify access_ok() context").

> > diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> > index 53de044e5654..da534fb7b5c6 100644
> > --- a/arch/x86/kernel/dumpstack.c
> > +++ b/arch/x86/kernel/dumpstack.c
> > @@ -85,7 +85,7 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
> >        * Make sure userspace isn't trying to trick us into dumping kernel
> >        * memory by pointing the userspace instruction pointer at it.
> >        */
> > -     if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
> > +     if (!__access_ok((void __user *)src, nbytes))
> >               return -EINVAL;
>
> This one is not needed at all as copy_from_user_nmi already checks the
> access range.

Ok, removing this.

> > diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> > index 15b058eefc4e..ee117fcf46ed 100644
> > --- a/arch/x86/kernel/stacktrace.c
> > +++ b/arch/x86/kernel/stacktrace.c
> > @@ -90,7 +90,7 @@ copy_stack_frame(const struct stack_frame_user __user *fp,
> >  {
> >       int ret;
> >
> > -     if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
> > +     if (!__access_ok(fp, sizeof(*frame)))
> >               return 0;
>
> Just switch the __get_user calls below to get_user instead.

Same as the first one, I think we can't do this in NMI context.

         Arnd
