From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 25 Oct 2021 11:57:28 +0200
Subject: [OpenRISC] [PATCH] locking: remove spin_lock_flags() etc
In-Reply-To: <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
References: <20211022120058.1031690-1-arnd@kernel.org>
 <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
Message-ID: <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Oct 23, 2021 at 06:04:57PM +0200, Arnd Bergmann wrote:
> On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
> >> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > As this is all dead code, just remove it and the helper functions built
> > > around it. For arch/ia64, the inline asm could be cleaned up, but
> > > it seems safer to leave it untouched.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Does that mean we can also remove the GENERIC_LOCKBREAK config option
> > from the Kconfig files as well?
> 
>  I couldn't figure this out.
> 
> What I see is that the only architectures setting GENERIC_LOCKBREAK are
> nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
> implementing arch_spin_is_contended() are arm32, csky and ia64.
> 
> The part I don't understand is whether the option actually does anything
> useful any more after commit d89c70356acf ("locking/core: Remove break_lock
> field when CONFIG_GENERIC_LOCKBREAK=y").

Urgh, what a mess.. AFAICT there's still code in
kernel/locking/spinlock.c that relies on it. Specifically when
GENERIC_LOCKBREAK=y we seem to create _lock*() variants that are
basically TaS locks which drop preempt/irq disable while spinning.

Anybody having this on and not having native TaS locks is in for a rude
surprise I suppose... sparc64 being the obvious candidate there :/



