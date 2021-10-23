From: Arnd Bergmann <arnd@kernel.org>
Date: Sat, 23 Oct 2021 18:04:57 +0200
Subject: [OpenRISC] [PATCH] locking: remove spin_lock_flags() etc
In-Reply-To: <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
References: <20211022120058.1031690-1-arnd@kernel.org>
 <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
Message-ID: <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
>> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > As this is all dead code, just remove it and the helper functions built
> > around it. For arch/ia64, the inline asm could be cleaned up, but
> > it seems safer to leave it untouched.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Does that mean we can also remove the GENERIC_LOCKBREAK config option
> from the Kconfig files as well?

 I couldn't figure this out.

What I see is that the only architectures setting GENERIC_LOCKBREAK are
nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
implementing arch_spin_is_contended() are arm32, csky and ia64.

The part I don't understand is whether the option actually does anything
useful any more after commit d89c70356acf ("locking/core: Remove break_lock
field when CONFIG_GENERIC_LOCKBREAK=y").

      Arnd
