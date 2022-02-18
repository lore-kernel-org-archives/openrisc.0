From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Feb 2022 10:24:50 +0100
Subject: [OpenRISC] [PATCH v2 10/18] m68k: fix access_ok for coldfire
In-Reply-To: <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-11-arnd@kernel.org>
 <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
Message-ID: <CAK8P3a2hrjxzzAWk3ut3VTD3h=ZLpDwPdvqs+uKaC4_b6+Vbfg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 18, 2022 at 10:00 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> >  /* We let the MMU do all checking */
> > -static inline int access_ok(const void __user *addr,
> > +static inline int access_ok(const void __user *ptr,
> >                             unsigned long size)
> >  {
> > +       unsigned long limit = TASK_SIZE;
> > +       unsigned long addr = (unsigned long)ptr;
> > +
> >         /*
> >          * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
> >          * for TASK_SIZE!
> > +        * Removing this helper is probably sufficient.
> >          */
>
> Shouldn't the above comment block be removed completely,
> as this is now implemented below?

Yes, obviously. Fixed now.

> > -       return 1;
> > +       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
> > +               return 1;

I just noticed this should have the same change that I made for the
generic version, changed it now to

+       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES) ||
+           !IS_ENABLED(CONFIG_MMU))

This is gone again after the cleanup patch, when the generic version
is used instead.

> > +       return (size <= limit) && (addr <= (limit - size));
> >  }
>
> Any pesky compilers that warn (or worse with -Werror) about
> "condition always true" for TASK_SIZE = 0xFFFFFFFFUL?

No, using a local variable avoids this warning.

        Arnd
