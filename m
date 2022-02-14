From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 14 Feb 2022 20:25:24 +0100
Subject: [OpenRISC] [PATCH 07/14] uaccess: generalize access_ok()
In-Reply-To: <YgqOLZbFK7/B2HJT@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-8-arnd@kernel.org>
 <YgqOLZbFK7/B2HJT@zeniv-ca.linux.org.uk>
Message-ID: <CAK8P3a36U35DK22UT6id=WawWaJa-2+_W9HFgmwdDJ_tVYE5NQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 6:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:45PM +0100, Arnd Bergmann wrote:
>
> > diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> > index c7b763d2f526..8867ddf3e6c7 100644
> > --- a/arch/csky/kernel/signal.c
> > +++ b/arch/csky/kernel/signal.c
> > @@ -136,7 +136,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
> >  static int
> >  setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
> >  {
> > -     struct rt_sigframe *frame;
> > +     struct rt_sigframe __user *frame;
> >       int err = 0;
> >
> >       frame = get_sigframe(ksig, regs, sizeof(*frame));
>
> Minor nit: might make sense to separate annotations (here, on nios2, etc.) from the rest...

Done.

> > -}
> > -
> > -static inline int access_ok(const void __user * addr, unsigned long size)
> > -{
> > -     return 1;
> > -}
> > +#define __range_not_ok(addr, size, limit) (!__access_ok(addr, size))
>
> is really wrong.  For sparc64, access_ok() should always be true.
> This __range_not_ok() thing is used *only* for valid_user_frame() in
> arch/sparc/kernel/perf_event.c - it's not a part of normal access_ok()
> there.
>
> sparc64 has separate address spaces for kernel and for userland; access_ok()
> had never been useful there.

Ok, fixed as well now. I had the access_ok() bit right, the definition just
moved around here so it comes before the #include, but I missed the
bit about __range_not_ok(), which I have now reverted back to the
correct version in my tree.

        Arnd
