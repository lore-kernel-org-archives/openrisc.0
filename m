From: Guo Ren <guoren@kernel.org>
Date: Sun, 20 Mar 2022 11:05:41 +0800
Subject: [OpenRISC] [PATCH V2 5/5] openrisc: Move to ticket-spinlock
In-Reply-To: <202203200824.EQJTy8pW-lkp@intel.com>
References: <20220319035457.2214979-6-guoren@kernel.org>
 <202203200824.EQJTy8pW-lkp@intel.com>
Message-ID: <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi openrisc guys,

>    kernel/signal.c:2625:49: sparse:     expected struct sighand_struct *sighand
>    kernel/signal.c:2625:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand

Some warning here, Is that all right? I don't think it is because of
changing arch_spinlock_t from struct qspinlock to atomic_t.

On Sun, Mar 20, 2022 at 8:07 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on arnd-asm-generic/master]
> [also build test WARNING on tip/locking/core openrisc/for-next linus/master v5.17-rc8 next-20220318]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/Generic-Ticket-Spinlocks/20220319-115644
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> config: openrisc-randconfig-s032-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200824.EQJTy8pW-lkp at intel.com/config)
> compiler: or1k-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/0day-ci/linux/commit/4e66dc8c71c62011bcb287f66bf5c5363920cd91
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review guoren-kernel-org/Generic-Ticket-Spinlocks/20220319-115644
>         git checkout 4e66dc8c71c62011bcb287f66bf5c5363920cd91
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>    kernel/signal.c: note: in included file (through include/uapi/asm-generic/signal.h, include/asm-generic/signal.h, arch/openrisc/include/generated/uapi/asm/signal.h, ...):
>    include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
>    kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:517:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:517:9: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:517:9: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:520:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:520:36: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:520:36: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
>    kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
>    kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
>    include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
>    kernel/signal.c:698:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:698:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:698:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:700:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:700:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:700:31: sparse:     got struct spinlock [noderef] __rcu *
> >> kernel/signal.c:887:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
>    kernel/signal.c:887:9: sparse:     expected struct atomic_t [usertype] *lock
>    kernel/signal.c:887:9: sparse:     got struct atomic_t [noderef] __rcu *
>    kernel/signal.c:1082:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
>    kernel/signal.c:1082:9: sparse:     expected struct atomic_t [usertype] *lock
>    kernel/signal.c:1082:9: sparse:     got struct atomic_t [noderef] __rcu *
>    kernel/signal.c:1330:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:1330:9: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:1330:9: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:1331:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
>    kernel/signal.c:1331:16: sparse:     expected struct k_sigaction *action
>    kernel/signal.c:1331:16: sparse:     got struct k_sigaction [noderef] __rcu *
>    kernel/signal.c:1350:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:1350:34: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:1350:34: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:1928:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:1928:36: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:1928:36: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2038:44: sparse: sparse: cast removes address space '__rcu' of expression
>    kernel/signal.c:2057:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
>    kernel/signal.c:2057:65: sparse:     expected struct task_struct *tsk
>    kernel/signal.c:2057:65: sparse:     got struct task_struct [noderef] __rcu *parent
>    kernel/signal.c:2058:40: sparse: sparse: cast removes address space '__rcu' of expression
>    kernel/signal.c:2076:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
>    kernel/signal.c:2076:14: sparse:     expected struct sighand_struct *psig
>    kernel/signal.c:2076:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
>    kernel/signal.c:2105:46: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
>    kernel/signal.c:2105:46: sparse:     expected struct task_struct *t
>    kernel/signal.c:2105:46: sparse:     got struct task_struct [noderef] __rcu *parent
>    kernel/signal.c:2106:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
>    kernel/signal.c:2106:34: sparse:     expected struct task_struct *parent
>    kernel/signal.c:2106:34: sparse:     got struct task_struct [noderef] __rcu *parent
>    kernel/signal.c:2135:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
>    kernel/signal.c:2135:24: sparse:     expected struct task_struct *parent
>    kernel/signal.c:2135:24: sparse:     got struct task_struct [noderef] __rcu *parent
>    kernel/signal.c:2138:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
>    kernel/signal.c:2138:24: sparse:     expected struct task_struct *parent
>    kernel/signal.c:2138:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
>    kernel/signal.c:2171:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
>    kernel/signal.c:2171:17: sparse:     expected struct sighand_struct *sighand
>    kernel/signal.c:2171:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>    kernel/signal.c:2209:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2209:41: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2209:41: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2211:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2211:39: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2211:39: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2261:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2261:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2261:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2316:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2316:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2316:31: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2350:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2350:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2350:31: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2352:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2352:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2352:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2450:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2450:41: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2450:41: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2535:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2535:41: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2535:41: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2547:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2547:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2547:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2585:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
>    kernel/signal.c:2585:52: sparse:     expected struct task_struct *tsk
>    kernel/signal.c:2585:52: sparse:     got struct task_struct [noderef] __rcu *parent
>    kernel/signal.c:2587:49: sparse: sparse: cast removes address space '__rcu' of expression
>    kernel/signal.c:2625:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
>    kernel/signal.c:2625:49: sparse:     expected struct sighand_struct *sighand
>    kernel/signal.c:2625:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>    kernel/signal.c:2961:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2961:27: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2961:27: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:2981:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:2981:29: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:2981:29: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3048:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3048:27: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:3048:27: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3050:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3050:29: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:3050:29: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3201:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3201:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:3201:31: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3204:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3204:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:3204:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3591:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3591:27: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:3591:27: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3603:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3603:37: sparse:     expected struct spinlock [usertype] *lock
>    kernel/signal.c:3603:37: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/signal.c:3608:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/signal.c:3608:35: sparse:     expected struct spinlock [usertype] *lock
>
> vim +887 kernel/signal.c
>
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  866
> fb1d910c178ba0c Tejun Heo      2011-06-14  867  /**
> fb1d910c178ba0c Tejun Heo      2011-06-14  868   * ptrace_trap_notify - schedule trap to notify ptracer
> fb1d910c178ba0c Tejun Heo      2011-06-14  869   * @t: tracee wanting to notify tracer
> fb1d910c178ba0c Tejun Heo      2011-06-14  870   *
> fb1d910c178ba0c Tejun Heo      2011-06-14  871   * This function schedules sticky ptrace trap which is cleared on the next
> fb1d910c178ba0c Tejun Heo      2011-06-14  872   * TRAP_STOP to notify ptracer of an event.  @t must have been seized by
> fb1d910c178ba0c Tejun Heo      2011-06-14  873   * ptracer.
> fb1d910c178ba0c Tejun Heo      2011-06-14  874   *
> 544b2c91a9f14f9 Tejun Heo      2011-06-14  875   * If @t is running, STOP trap will be taken.  If trapped for STOP and
> 544b2c91a9f14f9 Tejun Heo      2011-06-14  876   * ptracer is listening for events, tracee is woken up so that it can
> 544b2c91a9f14f9 Tejun Heo      2011-06-14  877   * re-trap for the new event.  If trapped otherwise, STOP trap will be
> 544b2c91a9f14f9 Tejun Heo      2011-06-14  878   * eventually taken without returning to userland after the existing traps
> 544b2c91a9f14f9 Tejun Heo      2011-06-14  879   * are finished by PTRACE_CONT.
> fb1d910c178ba0c Tejun Heo      2011-06-14  880   *
> fb1d910c178ba0c Tejun Heo      2011-06-14  881   * CONTEXT:
> fb1d910c178ba0c Tejun Heo      2011-06-14  882   * Must be called with @task->sighand->siglock held.
> fb1d910c178ba0c Tejun Heo      2011-06-14  883   */
> fb1d910c178ba0c Tejun Heo      2011-06-14  884  static void ptrace_trap_notify(struct task_struct *t)
> fb1d910c178ba0c Tejun Heo      2011-06-14  885  {
> fb1d910c178ba0c Tejun Heo      2011-06-14  886          WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
> fb1d910c178ba0c Tejun Heo      2011-06-14 @887          assert_spin_locked(&t->sighand->siglock);
> fb1d910c178ba0c Tejun Heo      2011-06-14  888
> fb1d910c178ba0c Tejun Heo      2011-06-14  889          task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
> 910ffdb18a6408e Oleg Nesterov  2013-01-21  890          ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
> fb1d910c178ba0c Tejun Heo      2011-06-14  891  }
> fb1d910c178ba0c Tejun Heo      2011-06-14  892
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
