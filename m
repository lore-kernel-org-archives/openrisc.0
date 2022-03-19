From: Guo Ren <guoren@kernel.org>
Date: Sat, 19 Mar 2022 21:26:31 +0800
Subject: [OpenRISC] [PATCH V2 1/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <CAK8P3a3wMJv6-fGo_i4DnFMigj=ko4DN1XTe8oa1HzWLiX50yw@mail.gmail.com>
References: <20220319035457.2214979-1-guoren@kernel.org>
 <20220319035457.2214979-2-guoren@kernel.org>
 <CAK8P3a3wMJv6-fGo_i4DnFMigj=ko4DN1XTe8oa1HzWLiX50yw@mail.gmail.com>
Message-ID: <CAJF2gTRvOLZPP_PYOEPMkr0S3vTSiPZOCFOmiVRXxi2QRu-vMA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Mar 19, 2022 at 7:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 4:54 AM <guoren@kernel.org> wrote:
> >  /*
> > - * You need to implement asm/spinlock.h for SMP support. The generic
> > - * version does not handle SMP.
> > + * Using ticket-spinlock.h as generic for SMP support.
> >   */
> >  #ifdef CONFIG_SMP
> > -#error need an architecture specific asm/spinlock.h
> > +#include <asm-generic/ticket-lock.h>
> > +#ifdef CONFIG_QUEUED_RWLOCKS
> > +#include <asm-generic/qrwlock.h>
> > +#else
> > +#error Please select ARCH_USE_QUEUED_RWLOCKS in architecture Kconfig
> > +#endif
> >  #endif
>
> There is no need for the !CONFIG_SMP case, as asm/spinlock.h only ever
> gets included for SMP builds in the first place. This was already a mistake
> in the existing code, but your change would be the time to fix it.
>
> I would also drop the !CONFIG_QUEUED_RWLOCKS case, just include
> it unconditionally. If any architecture wants the ticket spinlock in
> combination with a custom rwlock, they can simply include the
> asm-generic/ticket-lock.h from their asm/spinlock.h, but more
> likely any architecture that can use the ticket spinlock will also
> want the qrwlock anyway.
I agree, !CONFIG_SMP & !CONFIG_QUEUED_RWLOCKS are unnecessary.

@Palmer, you could pick back the series, thx.

>
>      Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
