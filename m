From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 12:16:26 +0900
Subject: [OpenRISC] [PATCH v2 00/13] Glibc OpenRISC port
Message-ID: <20211113031639.2402161-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is the OpenRISC port for glibc that I have been working on.

Changes since v1:
 - Update api's as suggested by Florian
 - Remove hard float support
 - Updates to get all tests passing
 - Split patch into managable bits similar to recent ARC port

Documentation:

  Architecture / ABI docs:
   https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf

Test Results:

  build-many-glibcs.py:

   Both with mainline ang gcc-11.

    Summary of test results:
       1252 PASS
	 15 XFAIL

  Full test suite:

   The full suite is running using the gcc-11 branch of GCC, mainline shows
   issues with math soft-fp.

	  1 FAIL
       4056 PASS
	 28 UNSUPPORTED
	 18 XFAIL

    tst-tzset.out: https://gist.github.com/stffrdhrn/5a49696cbf9bda342c52162a4950e4f2
    tests.sum:     https://gist.github.com/stffrdhrn/9663c91ae65865e5323b946d0f2d1a3e

   Note, I have some extra patches to get this to work:
    Branch: https://github.com/stffrdhrn/or1k-glibc/commits/or1k-port-2
    Patches:
      2021-11-13 a45ab06431 Stafford Horne   support: Workaround gcc float rounding error
      2021-11-13 1cb553ff2b Stafford Horne   malloc: Fix malloc debug for 2.35 onwards
      2021-11-13 864ac06370 Stafford Horne   resolv: Fix tests by aligning hand

   I have posted these before to the list, they are not architecture specific
   issues, but things that need to be resolved in gcc or glibc.


Stafford Horne (13):
  elf: Add reloc for OpenRISC
  linux/syscalls: Add or1k_atomic syscall for OpenRISC
  or1k: ABI Implementation
  or1k: startup and dynamic linking code
  or1k: Thread Local Storage support
  or1k: Atomics and Locking primitives
  or1k: math soft float support
  or1k: Linux Syscall Interface
  or1k: Linux ABI
  or1k: ABI lists
  or1k: Build Infrastructure
  build-many-glibcs.py: add OpenRISC support
  Documentation for OpenRISC port

 NEWS                                          |    2 +
 README                                        |    1 +
 elf/elf.h                                     |   37 +
 scripts/build-many-glibcs.py                  |    5 +
 sysdeps/or1k/Implies                          |    3 +
 sysdeps/or1k/Makefile                         |    7 +
 sysdeps/or1k/__longjmp.S                      |   55 +
 sysdeps/or1k/atomic-machine.h                 |   79 +
 sysdeps/or1k/bits/endianness.h                |   11 +
 sysdeps/or1k/bits/fenv.h                      |   68 +
 sysdeps/or1k/bits/link.h                      |   50 +
 sysdeps/or1k/bits/setjmp.h                    |   32 +
 sysdeps/or1k/bsd-_setjmp.S                    |    1 +
 sysdeps/or1k/bsd-setjmp.S                     |    1 +
 sysdeps/or1k/dl-machine.h                     |  323 +++
 sysdeps/or1k/dl-start.S                       |   98 +
 sysdeps/or1k/dl-tls.h                         |   26 +
 sysdeps/or1k/dl-trampoline.S                  |   79 +
 sysdeps/or1k/jmpbuf-offsets.h                 |   23 +
 sysdeps/or1k/jmpbuf-unwind.h                  |   35 +
 sysdeps/or1k/ldsodefs.h                       |   40 +
 sysdeps/or1k/libc-tls.c                       |   32 +
 sysdeps/or1k/libm-test-ulps                   | 1112 +++++++++
 sysdeps/or1k/libm-test-ulps-name              |    1 +
 sysdeps/or1k/machine-gmon.h                   |   35 +
 sysdeps/or1k/memusage.h                       |   20 +
 sysdeps/or1k/nofpu/Implies                    |    1 +
 sysdeps/or1k/nofpu/math-tests-exceptions.h    |   29 +
 sysdeps/or1k/nofpu/math-tests-rounding.h      |   28 +
 sysdeps/or1k/nptl/Makefile                    |   21 +
 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h    |   48 +
 sysdeps/or1k/nptl/pthreaddef.h                |   35 +
 sysdeps/or1k/nptl/tcb-offsets.sym             |    6 +
 sysdeps/or1k/nptl/tls.h                       |  189 ++
 sysdeps/or1k/preconfigure                     |   34 +
 sysdeps/or1k/setjmp.S                         |   56 +
 sysdeps/or1k/sfp-machine.h                    |   93 +
 sysdeps/or1k/sotruss-lib.c                    |   51 +
 sysdeps/or1k/stackinfo.h                      |   33 +
 sysdeps/or1k/start.S                          |   99 +
 sysdeps/or1k/sysdep.h                         |   82 +
 sysdeps/or1k/tininess.h                       |    1 +
 sysdeps/or1k/tst-audit.h                      |   24 +
 sysdeps/unix/sysv/linux/or1k/Implies          |    3 +
 sysdeps/unix/sysv/linux/or1k/Makefile         |   12 +
 sysdeps/unix/sysv/linux/or1k/arch-syscall.h   |  320 +++
 sysdeps/unix/sysv/linux/or1k/bits/procfs.h    |   38 +
 sysdeps/unix/sysv/linux/or1k/bits/timesize.h  |   19 +
 sysdeps/unix/sysv/linux/or1k/c++-types.data   |   67 +
 sysdeps/unix/sysv/linux/or1k/clone.c          |   59 +
 sysdeps/unix/sysv/linux/or1k/configure        |    4 +
 sysdeps/unix/sysv/linux/or1k/configure.ac     |    4 +
 sysdeps/unix/sysv/linux/or1k/getcontext.S     |   72 +
 sysdeps/unix/sysv/linux/or1k/ioctl.c          |   40 +
 sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h |   41 +
 sysdeps/unix/sysv/linux/or1k/kernel_stat.h    |   24 +
 sysdeps/unix/sysv/linux/or1k/ld.abilist       |    5 +
 .../sysv/linux/or1k/libBrokenLocale.abilist   |    1 +
 sysdeps/unix/sysv/linux/or1k/libanl.abilist   |    1 +
 sysdeps/unix/sysv/linux/or1k/libc.abilist     | 2122 +++++++++++++++++
 .../sysv/linux/or1k/libc_malloc_debug.abilist |   26 +
 sysdeps/unix/sysv/linux/or1k/libcrypt.abilist |    2 +
 sysdeps/unix/sysv/linux/or1k/libdl.abilist    |    0
 sysdeps/unix/sysv/linux/or1k/libm.abilist     |  759 ++++++
 sysdeps/unix/sysv/linux/or1k/libnsl.abilist   |  121 +
 .../unix/sysv/linux/or1k/libpthread.abilist   |    0
 .../unix/sysv/linux/or1k/libresolv.abilist    |   55 +
 sysdeps/unix/sysv/linux/or1k/librt.abilist    |    0
 .../unix/sysv/linux/or1k/libthread_db.abilist |   40 +
 sysdeps/unix/sysv/linux/or1k/libutil.abilist  |    1 +
 sysdeps/unix/sysv/linux/or1k/localplt.data    |   14 +
 sysdeps/unix/sysv/linux/or1k/makecontext.c    |   77 +
 sysdeps/unix/sysv/linux/or1k/mmap_internal.h  |   30 +
 sysdeps/unix/sysv/linux/or1k/or1k_clone.S     |   89 +
 sysdeps/unix/sysv/linux/or1k/setcontext.S     |  108 +
 sysdeps/unix/sysv/linux/or1k/shlib-versions   |    2 +
 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h |   28 +
 sysdeps/unix/sysv/linux/or1k/swapcontext.S    |  116 +
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |   53 +
 sysdeps/unix/sysv/linux/or1k/sys/user.h       |    1 +
 sysdeps/unix/sysv/linux/or1k/syscall.c        |   45 +
 sysdeps/unix/sysv/linux/or1k/sysdep.c         |   33 +
 sysdeps/unix/sysv/linux/or1k/sysdep.h         |  195 ++
 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |   26 +
 sysdeps/unix/sysv/linux/syscall-names.list    |    1 +
 85 files changed, 7660 insertions(+)
 create mode 100644 sysdeps/or1k/Implies
 create mode 100644 sysdeps/or1k/Makefile
 create mode 100644 sysdeps/or1k/__longjmp.S
 create mode 100644 sysdeps/or1k/atomic-machine.h
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
 create mode 100644 sysdeps/or1k/jmpbuf-offsets.h
 create mode 100644 sysdeps/or1k/jmpbuf-unwind.h
 create mode 100644 sysdeps/or1k/ldsodefs.h
 create mode 100644 sysdeps/or1k/libc-tls.c
 create mode 100644 sysdeps/or1k/libm-test-ulps
 create mode 100644 sysdeps/or1k/libm-test-ulps-name
 create mode 100644 sysdeps/or1k/machine-gmon.h
 create mode 100644 sysdeps/or1k/memusage.h
 create mode 100644 sysdeps/or1k/nofpu/Implies
 create mode 100644 sysdeps/or1k/nofpu/math-tests-exceptions.h
 create mode 100644 sysdeps/or1k/nofpu/math-tests-rounding.h
 create mode 100644 sysdeps/or1k/nptl/Makefile
 create mode 100644 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
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
 create mode 100644 sysdeps/or1k/tst-audit.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Implies
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Makefile
 create mode 100644 sysdeps/unix/sysv/linux/or1k/arch-syscall.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/procfs.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/timesize.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/c++-types.data
 create mode 100644 sysdeps/unix/sysv/linux/or1k/clone.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/configure
 create mode 100644 sysdeps/unix/sysv/linux/or1k/configure.ac
 create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ioctl.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/kernel_stat.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ld.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libanl.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libc.abilist
 create mode 100644 sysdeps/unix/sysv/linux/or1k/libc_malloc_debug.abilist
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
 create mode 100644 sysdeps/unix/sysv/linux/or1k/makecontext.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/mmap_internal.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/or1k_clone.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/setcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/shlib-versions
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/swapcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/user.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/syscall.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sysdep.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sysdep.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym

-- 
2.31.1

