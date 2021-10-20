From: Eric W. Biederman <ebiederm@xmission.com>
Date: Wed, 20 Oct 2021 12:32:20 -0500
Subject: [OpenRISC] [PATCH 00/20] exit cleanups
Message-ID: <87y26nmwkb.fsf@disp2133>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


While looking at some issues related to the exit path in the kernel I
found several instances where the code is not using the existing
abstractions properly.

This set of changes introduces force_fatal_sig a way of sending
a signal and not allowing it to be caught, and corrects the
misuse of the existing abstractions that I found.

A lot of the misuse of the existing abstractions are silly things such
as doing something after calling a no return function, rolling BUG by
hand, doing more work than necessary to terminate a kernel thread, or
calling do_exit(SIGKILL) instead of calling force_sig(SIGKILL).

It is my plan after sending all of these changes out for review to place
them in a topic branch for sending Linus.  Especially for the changes
that depend upon the new helper force_fatal_sig this is important.

Eric W. Biederman (20):
      exit/doublefault: Remove apparently bogus comment about rewind_stack_do_exit
      exit: Remove calls of do_exit after noreturn versions of die
      reboot: Remove the unreachable panic after do_exit in reboot(2)
      signal/sparc32: Remove unreachable do_exit in do_sparc_fault
      signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
      signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
      signal/powerpc: On swapcontext failure force SIGSEGV
      signal/sparc: In setup_tsb_params convert open coded BUG into BUG
      signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
      signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
      signal/s390: Use force_sigsegv in default_trap_handler
      exit/kthread: Have kernel threads return instead of calling do_exit
      signal: Implement force_fatal_sig
      exit/syscall_user_dispatch: Send ordinary signals on failure
      signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails
      signal/sparc32: In setup_rt_frame and setup_fram use force_fatal_sig
      signal/x86: In emulate_vsyscall force a signal instead of calling do_exit
      exit/rtl8723bs: Replace the macro thread_exit with a simple return 0
      exit/rtl8712: Replace the macro thread_exit with a simple return 0
      exit/r8188eu: Replace the macro thread_exit with a simple return 0

 arch/mips/kernel/r2300_fpu.S                       |  4 ++--
 arch/mips/kernel/syscall.c                         |  9 --------
 arch/nds32/kernel/traps.c                          |  2 +-
 arch/nds32/mm/fault.c                              |  6 +----
 arch/openrisc/kernel/traps.c                       |  2 +-
 arch/openrisc/mm/fault.c                           |  4 +---
 arch/powerpc/kernel/signal_32.c                    |  6 +++--
 arch/powerpc/kernel/signal_64.c                    |  9 +++++---
 arch/s390/include/asm/kdebug.h                     |  2 +-
 arch/s390/kernel/dumpstack.c                       |  2 +-
 arch/s390/kernel/traps.c                           |  2 +-
 arch/s390/mm/fault.c                               |  2 --
 arch/sh/kernel/cpu/fpu.c                           | 10 +++++----
 arch/sh/kernel/traps.c                             |  2 +-
 arch/sh/mm/fault.c                                 |  2 --
 arch/sparc/kernel/signal_32.c                      |  4 ++--
 arch/sparc/kernel/windows.c                        |  6 +++--
 arch/sparc/mm/fault_32.c                           |  1 -
 arch/sparc/mm/tsb.c                                |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |  3 ++-
 arch/x86/kernel/doublefault_32.c                   |  3 ---
 arch/x86/kernel/signal.c                           |  6 ++++-
 arch/x86/kernel/vm86_32.c                          |  8 +++----
 arch/xtensa/kernel/traps.c                         |  2 +-
 arch/xtensa/mm/fault.c                             |  3 +--
 drivers/firmware/stratix10-svc.c                   |  4 ++--
 drivers/soc/ti/wkup_m3_ipc.c                       |  2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |  2 +-
 drivers/staging/r8188eu/core/rtw_mp.c              |  2 +-
 drivers/staging/r8188eu/include/osdep_service.h    |  2 --
 drivers/staging/rtl8712/osdep_service.h            |  1 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |  2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |  2 +-
 .../rtl8723bs/include/osdep_service_linux.h        |  2 --
 fs/ocfs2/journal.c                                 |  5 +----
 include/linux/sched/signal.h                       |  1 +
 kernel/entry/syscall_user_dispatch.c               | 12 ++++++----
 kernel/kthread.c                                   |  2 +-
 kernel/reboot.c                                    |  1 -
 kernel/signal.c                                    | 26 ++++++++++++++--------
 net/batman-adv/tp_meter.c                          |  2 +-
 43 files changed, 83 insertions(+), 91 deletions(-)

Eric
