From: Stafford Horne <shorne@gmail.com>
Date: Tue, 22 Mar 2022 14:26:36 +0900
Subject: [OpenRISC] [PATCH V2 5/5] openrisc: Move to ticket-spinlock
In-Reply-To: <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
References: <20220319035457.2214979-6-guoren@kernel.org>
 <202203200824.EQJTy8pW-lkp@intel.com>
 <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
Message-ID: <CAAfxs751zQ=rut1qkNwKZXtMAUmKdcG28YgJ+fqYzT9mXgtDFA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi

On Sun, Mar 20, 2022 at 12:05 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi openrisc guys,
>
> >    kernel/signal.c:2625:49: sparse:     expected struct sighand_struct *sighand
> >    kernel/signal.c:2625:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>
> Some warning here, Is that all right? I don't think it is because of
> changing arch_spinlock_t from struct qspinlock to atomic_t.
>
> On Sun, Mar 20, 2022 at 8:07 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on arnd-asm-generic/master]
> > [also build test WARNING on tip/locking/core openrisc/for-next linus/master v5.17-rc8 next-20220318]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/Generic-Ticket-Spinlocks/20220319-115644
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> > config: openrisc-randconfig-s032-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200824.EQJTy8pW-lkp at intel.com/config)
> > compiler: or1k-linux-gcc (GCC) 11.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-dirty
> >         # https://github.com/0day-ci/linux/commit/4e66dc8c71c62011bcb287f66bf5c5363920cd91
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review guoren-kernel-org/Generic-Ticket-Spinlocks/20220319-115644
> >         git checkout 4e66dc8c71c62011bcb287f66bf5c5363920cd91
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >    kernel/signal.c: note: in included file (through include/uapi/asm-generic/signal.h, include/asm-generic/signal.h, arch/openrisc/include/generated/uapi/asm/signal.h, ...):
> >    include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
> >    kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:517:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:517:9: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:517:9: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:520:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:520:36: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:520:36: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
> >    kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
> >    kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
> >    include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
> >    kernel/signal.c:698:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:698:33: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:698:33: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:700:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:700:31: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:700:31: sparse:     got struct spinlock [noderef] __rcu *
> > >> kernel/signal.c:887:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
> >    kernel/signal.c:887:9: sparse:     expected struct atomic_t [usertype] *lock
> >    kernel/signal.c:887:9: sparse:     got struct atomic_t [noderef] __rcu *

This one is being reported as a new warning. I can see this warning
even when testing with x86_64 which uses qspinlock:

    kernel/signal.c:542:53:    got struct k_sigaction [noderef] __rcu *
    ./include/uapi/asm-generic/signal-defs.h:83:29: error: multiple
address spaces given
    kernel/signal.c:698:33: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:698:33:    expected struct spinlock [usertype] *lock
    kernel/signal.c:698:33:    got struct spinlock [noderef] __rcu *
    kernel/signal.c:700:31: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:700:31:    expected struct spinlock [usertype] *lock
    kernel/signal.c:700:31:    got struct spinlock [noderef] __rcu *
    kernel/signal.c:887:9: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:887:9:    expected struct qspinlock *lock
    kernel/signal.c:887:9:    got struct qspinlock [noderef] __rcu *
    kernel/signal.c:1082:9: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:1082:9:    expected struct qspinlock *lock

It looks like these are treated as *new* by the kbuild robot because
they changed from qspinlock to atomic_t, which changes the match
pattern.

I looked into what it takes to fix it but it seems such a change would
be very intrusive.  I think we can leave as is for now.

-Stafford
