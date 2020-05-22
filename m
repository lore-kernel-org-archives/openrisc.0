From: Stafford Horne <shorne@gmail.com>
Date: Fri, 22 May 2020 20:36:32 +0900
Subject: [OpenRISC] [PATCH 0/1] OpenRISC port
Message-ID: <20200522113633.209664-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

This is the patch for the OpenRISC port of glibc.

DEVELOPMENT

The original patch was put together by Christian Scensson a few years ago.  I
have taken the patch and finished all of the TODO items and run and fixed all of
the test failures.

BUILDING and TESTING

Testing has been done with the qemu OpenRISC simulator using the build and run
scripts found here:

 - https://github.com/stffrdhrn/or1k-utils/tree/master/glibc

Running the tests I found a few issues with binutils, gcc and the OpenRISC
architecture as well, patches for binutils are upstream and gcc should be
upstream soon:

 - Binutils: use latest master
 - GCC: https://github.com/stffrdhrn/gcc/commits/or1k-glibc-1
 - QEMU: https://github.com/stffrdhrn/qemu/commits/or1k-glibc (FPU issues)

TEST RESULTS

Pretty much all tests are passing however there are several math (fpu) tests
which are failing due to issues with setting underflow/overflow flags.  These
seem consistent with issues reported by other architectures.  Is there a known
issue here?

I can provide more details.

-Stafford

Christian Svensson (1):
  Initial support for OpenRISC

 elf/elf.h                                     |   37 +
 sysdeps/or1k/Implies                          |    4 +
 sysdeps/or1k/Makefile                         |    7 +
 sysdeps/or1k/__longjmp.S                      |   55 +
 sysdeps/or1k/atomic-machine.h                 |   77 +
 sysdeps/or1k/bits/atomic.h                    |   51 +
 sysdeps/or1k/bits/endianness.h                |   11 +
 sysdeps/or1k/bits/fenv.h                      |   79 +
 sysdeps/or1k/bits/link.h                      |   51 +
 sysdeps/or1k/bits/setjmp.h                    |   36 +
 sysdeps/or1k/bsd-_setjmp.S                    |    1 +
 sysdeps/or1k/bsd-setjmp.S                     |    1 +
 sysdeps/or1k/dl-machine.h                     |  339 +++
 sysdeps/or1k/dl-start.S                       |  101 +
 sysdeps/or1k/dl-tls.h                         |   28 +
 sysdeps/or1k/dl-trampoline.S                  |   82 +
 sysdeps/or1k/fpu/fclrexcpt.c                  |   41 +
 sysdeps/or1k/fpu/fegetenv.c                   |   32 +
 sysdeps/or1k/fpu/fegetmode.c                  |   27 +
 sysdeps/or1k/fpu/fegetround.c                 |   34 +
 sysdeps/or1k/fpu/feholdexcpt.c                |   41 +
 sysdeps/or1k/fpu/fesetenv.c                   |   35 +
 sysdeps/or1k/fpu/fesetexcept.c                |   32 +
 sysdeps/or1k/fpu/fesetmode.c                  |   42 +
 sysdeps/or1k/fpu/fesetround.c                 |   44 +
 sysdeps/or1k/fpu/feupdateenv.c                |   44 +
 sysdeps/or1k/fpu/fgetexcptflg.c               |   37 +
 sysdeps/or1k/fpu/fraiseexcpt.c                |   82 +
 sysdeps/or1k/fpu/fsetexcptflg.c               |   40 +
 sysdeps/or1k/fpu/ftestexcept.c                |   32 +
 sysdeps/or1k/fpu/get-rounding-mode.h          |   38 +
 sysdeps/or1k/fpu_control.h                    |   49 +
 sysdeps/or1k/jmpbuf-offsets.h                 |   23 +
 sysdeps/or1k/jmpbuf-unwind.h                  |   35 +
 sysdeps/or1k/ldsodefs.h                       |   40 +
 sysdeps/or1k/libc-tls.c                       |   32 +
 sysdeps/or1k/libm-test-ulps                   | 1107 +++++++++
 sysdeps/or1k/libm-test-ulps-name              |    1 +
 sysdeps/or1k/machine-gmon.h                   |   24 +
 sysdeps/or1k/math-tests-trap.h                |   27 +
 sysdeps/or1k/memusage.h                       |   20 +
 sysdeps/or1k/nofpu/Implies                    |    1 +
 sysdeps/or1k/nofpu/math-tests-exceptions.h    |   29 +
 sysdeps/or1k/nofpu/math-tests-rounding.h      |   28 +
 sysdeps/or1k/nptl/Makefile                    |   21 +
 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h    |   48 +
 sysdeps/or1k/nptl/bits/semaphore.h            |   34 +
 sysdeps/or1k/nptl/pthreaddef.h                |   32 +
 sysdeps/or1k/nptl/tcb-offsets.sym             |    6 +
 sysdeps/or1k/nptl/tls.h                       |  193 ++
 sysdeps/or1k/preconfigure                     |   38 +
 sysdeps/or1k/setjmp.S                         |   56 +
 sysdeps/or1k/sfp-machine.h                    |  102 +
 sysdeps/or1k/sotruss-lib.c                    |   51 +
 sysdeps/or1k/stackinfo.h                      |   33 +
 sysdeps/or1k/start.S                          |  116 +
 sysdeps/or1k/sysdep.h                         |   77 +
 sysdeps/or1k/tininess.h                       |    1 +
 sysdeps/or1k/tls-macros.h                     |   82 +
 sysdeps/or1k/tst-audit.h                      |   24 +
 sysdeps/unix/sysv/linux/or1k/Implies          |    3 +
 sysdeps/unix/sysv/linux/or1k/Makefile         |   12 +
 sysdeps/unix/sysv/linux/or1k/arch-syscall.h   |  315 +++
 sysdeps/unix/sysv/linux/or1k/bits/fcntl.h     |   49 +
 sysdeps/unix/sysv/linux/or1k/bits/mman.h      |   44 +
 sysdeps/unix/sysv/linux/or1k/c++-types.data   |   67 +
 sysdeps/unix/sysv/linux/or1k/clone.c          |   59 +
 sysdeps/unix/sysv/linux/or1k/configure        |    4 +
 sysdeps/unix/sysv/linux/or1k/configure.ac     |    4 +
 sysdeps/unix/sysv/linux/or1k/getcontext.S     |   72 +
 sysdeps/unix/sysv/linux/or1k/ioctl.c          |   40 +
 sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h |   41 +
 .../unix/sysv/linux/or1k/kernel-features.h    |   24 +
 sysdeps/unix/sysv/linux/or1k/ld.abilist       |    5 +
 .../sysv/linux/or1k/libBrokenLocale.abilist   |    1 +
 sysdeps/unix/sysv/linux/or1k/libanl.abilist   |    4 +
 sysdeps/unix/sysv/linux/or1k/libc.abilist     | 2081 +++++++++++++++++
 sysdeps/unix/sysv/linux/or1k/libcrypt.abilist |    2 +
 sysdeps/unix/sysv/linux/or1k/libdl.abilist    |    9 +
 sysdeps/unix/sysv/linux/or1k/libm.abilist     |  699 ++++++
 sysdeps/unix/sysv/linux/or1k/libnsl.abilist   |  121 +
 .../unix/sysv/linux/or1k/libpthread.abilist   |  216 ++
 .../unix/sysv/linux/or1k/libresolv.abilist    |   79 +
 sysdeps/unix/sysv/linux/or1k/librt.abilist    |   35 +
 .../unix/sysv/linux/or1k/libthread_db.abilist |   40 +
 sysdeps/unix/sysv/linux/or1k/libutil.abilist  |    6 +
 sysdeps/unix/sysv/linux/or1k/localplt.data    |   13 +
 sysdeps/unix/sysv/linux/or1k/lowlevellock.h   |   23 +
 sysdeps/unix/sysv/linux/or1k/makecontext.c    |   77 +
 sysdeps/unix/sysv/linux/or1k/mmap_internal.h  |   29 +
 sysdeps/unix/sysv/linux/or1k/or1k_clone.S     |  112 +
 sysdeps/unix/sysv/linux/or1k/prctl.c          |   41 +
 sysdeps/unix/sysv/linux/or1k/pt-vfork.c       |   30 +
 sysdeps/unix/sysv/linux/or1k/setcontext.S     |  110 +
 sysdeps/unix/sysv/linux/or1k/shlib-versions   |    2 +
 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h |   28 +
 sysdeps/unix/sysv/linux/or1k/swapcontext.S    |  116 +
 sysdeps/unix/sysv/linux/or1k/sys/procfs.h     |  120 +
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |   48 +
 sysdeps/unix/sysv/linux/or1k/sys/user.h       |    1 +
 sysdeps/unix/sysv/linux/or1k/syscall.c        |   45 +
 sysdeps/unix/sysv/linux/or1k/sysdep.c         |   33 +
 sysdeps/unix/sysv/linux/or1k/sysdep.h         |  167 ++
 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |   26 +
 sysdeps/unix/sysv/linux/syscall-names.list    |    1 +
 105 files changed, 8945 insertions(+)
 create mode 100644 sysdeps/or1k/Implies
 create mode 100644 sysdeps/or1k/Makefile
 create mode 100644 sysdeps/or1k/__longjmp.S
 create mode 100644 sysdeps/or1k/atomic-machine.h
 create mode 100644 sysdeps/or1k/bits/atomic.h
 create mode 100644 sysdeps/or1k/bits/endianness.h
 create mode 100644 sysdeps/or1k/bits/fenv.h
 create mode 100644 sysdeps/or1k/bits/link.h
 create mode 100644 sysdeps/or1k/bits/setjmp.h
 create mode 100644 sysdeps/or1k/bsd-_setjmp.S
 create mode 100644 sysdeps/or1k/bsd-setjmp.S
 create mode 100644 sysdeps/or1k/dl-machine.h
 create mode 100644 sysdeps/or1k/dl-start.S
 create mode 100644 sysdeps/or1k/dl-tls.h
 create mode 100644 sysdeps/or1k/dl-trampoline.S
 create mode 100644 sysdeps/or1k/fpu/fclrexcpt.c
 create mode 100644 sysdeps/or1k/fpu/fegetenv.c
 create mode 100644 sysdeps/or1k/fpu/fegetmode.c
 create mode 100644 sysdeps/or1k/fpu/fegetround.c
 create mode 100644 sysdeps/or1k/fpu/feholdexcpt.c
 create mode 100644 sysdeps/or1k/fpu/fesetenv.c
 create mode 100644 sysdeps/or1k/fpu/fesetexcept.c
 create mode 100644 sysdeps/or1k/fpu/fesetmode.c
 create mode 100644 sysdeps/or1k/fpu/fesetround.c
 create mode 100644 sysdeps/or1k/fpu/feupdateenv.c
 create mode 100644 sysdeps/or1k/fpu/fgetexcptflg.c
 create mode 100644 sysdeps/or1k/fpu/fraiseexcpt.c
 create mode 100644 sysdeps/or1k/fpu/fsetexcptflg.c
 create mode 100644 sysdeps/or1k/fpu/ftestexcept.c
 create mode 100644 sysdeps/or1k/fpu/get-rounding-mode.h
 create mode 100644 sysdeps/or1k/fpu_control.h
 create mode 100644 sysdeps/or1k/jmpbuf-offsets.h
 create mode 100644 sysdeps/or1k/jmpbuf-unwind.h
 create mode 100644 sysdeps/or1k/ldsodefs.h
 create mode 100644 sysdeps/or1k/libc-tls.c
 create mode 100644 sysdeps/or1k/libm-test-ulps
 create mode 100644 sysdeps/or1k/libm-test-ulps-name
 create mode 100644 sysdeps/or1k/machine-gmon.h
 create mode 100644 sysdeps/or1k/math-tests-trap.h
 create mode 100644 sysdeps/or1k/memusage.h
 create mode 100644 sysdeps/or1k/nofpu/Implies
 create mode 100644 sysdeps/or1k/nofpu/math-tests-exceptions.h
 create mode 100644 sysdeps/or1k/nofpu/math-tests-rounding.h
 create mode 100644 sysdeps/or1k/nptl/Makefile
 create mode 100644 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
 create mode 100644 sysdeps/or1k/nptl/bits/semaphore.h
 create mode 100644 sysdeps/or1k/nptl/pthreaddef.h
 create mode 100644 sysdeps/or1k/nptl/tcb-offsets.sym
 create mode 100644 sysdeps/or1k/nptl/tls.h
 create mode 100644 sysdeps/or1k/preconfigure
 create mode 100644 sysdeps/or1k/setjmp.S
 create mode 100644 sysdeps/or1k/sfp-machine.h
 create mode 100644 sysdeps/or1k/sotruss-lib.c
 create mode 100644 sysdeps/or1k/stackinfo.h
 create mode 100644 sysdeps/or1k/start.S
 create mode 100644 sysdeps/or1k/sysdep.h
 create mode 100644 sysdeps/or1k/tininess.h
 create mode 100644 sysdeps/or1k/tls-macros.h
 create mode 100644 sysdeps/or1k/tst-audit.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Implies
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Makefile
 create mode 100644 sysdeps/unix/sysv/linux/or1k/arch-syscall.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/fcntl.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/mman.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/c++-types.data
 create mode 100644 sysdeps/unix/sysv/linux/or1k/clone.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/configure
 create mode 100644 sysdeps/unix/sysv/linux/or1k/configure.ac
 create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ioctl.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/kernel-features.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ld.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libanl.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libc.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libcrypt.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libdl.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libm.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libnsl.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libpthread.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libresolv.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/librt.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libthread_db.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libutil.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/localplt.data
 create mode 100644 sysdeps/unix/sysv/linux/or1k/lowlevellock.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/makecontext.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/mmap_internal.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/or1k_clone.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/prctl.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/pt-vfork.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/setcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/shlib-versions
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/swapcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/procfs.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/user.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/syscall.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sysdep.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sysdep.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym

-- 
2.26.2

