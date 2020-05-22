From: Stafford Horne <shorne@gmail.com>
Date: Fri, 22 May 2020 20:36:33 +0900
Subject: [OpenRISC] [PATCH 1/1] Initial support for OpenRISC
In-Reply-To: <20200522113633.209664-1-shorne@gmail.com>
References: <20200522113633.209664-1-shorne@gmail.com>
Message-ID: <20200522113633.209664-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christian Svensson <blue@cmd.nu>

This patch includes the OpenRISC glibc support for linux.

YYYY-MM-DD  Stafford Horne  <shorne@gmail.com>
	    Christian Svensson  <blue@cmd.nu>

	* elf/elf.h: Add OpenRISC relocations.
	* sysdeps/or1k/Implies: New file.
	* sysdeps/or1k/Makefile: New file.
	* sysdeps/or1k/__longjmp.S: New file.
	* sysdeps/or1k/atomic-machine.h: New file.
	* sysdeps/or1k/bits/atomic.h: New file.
	* sysdeps/or1k/bits/endianness.h: New file.
	* sysdeps/or1k/bits/fenv.h: New file.
	* sysdeps/or1k/bits/link.h: New file.
	* sysdeps/or1k/bits/setjmp.h: New file.
	* sysdeps/or1k/bsd-_setjmp.S: New file.
	* sysdeps/or1k/bsd-setjmp.S: New file.
	* sysdeps/or1k/dl-machine.h: New file.
	* sysdeps/or1k/dl-start.S: New file.
	* sysdeps/or1k/dl-tls.h: New file.
	* sysdeps/or1k/dl-trampoline.S: New file.
	* sysdeps/or1k/fpu/fclrexcpt.c: New file.
	* sysdeps/or1k/fpu/fegetenv.c: New file.
	* sysdeps/or1k/fpu/fegetmode.c: New file.
	* sysdeps/or1k/fpu/fegetround.c: New file.
	* sysdeps/or1k/fpu/feholdexcpt.c: New file.
	* sysdeps/or1k/fpu/fesetenv.c: New file.
	* sysdeps/or1k/fpu/fesetexcept.c: New file.
	* sysdeps/or1k/fpu/fesetmode.c: New file.
	* sysdeps/or1k/fpu/fesetround.c: New file.
	* sysdeps/or1k/fpu/feupdateenv.c: New file.
	* sysdeps/or1k/fpu/fgetexcptflg.c: New file.
	* sysdeps/or1k/fpu/fraiseexcpt.c: New file.
	* sysdeps/or1k/fpu/fsetexcptflg.c: New file.
	* sysdeps/or1k/fpu/ftestexcept.c: New file.
	* sysdeps/or1k/fpu/get-rounding-mode.h: New file.
	* sysdeps/or1k/fpu_control.h: New file.
	* sysdeps/or1k/jmpbuf-offsets.h: New file.
	* sysdeps/or1k/jmpbuf-unwind.h: New file.
	* sysdeps/or1k/ldsodefs.h: New file.
	* sysdeps/or1k/libc-tls.c: New file.
	* sysdeps/or1k/libm-test-ulps: New file.
	* sysdeps/or1k/libm-test-ulps-name: New file.
	* sysdeps/or1k/machine-gmon.h: New file.
	* sysdeps/or1k/math-tests-trap.h: New file.
	* sysdeps/or1k/memusage.h: New file.
	* sysdeps/or1k/nofpu/Implies: New file.
	* sysdeps/or1k/nofpu/math-tests-exceptions.h: New file.
	* sysdeps/or1k/nofpu/math-tests-rounding.h: New file.
	* sysdeps/or1k/nptl/Makefile: New file.
	* sysdeps/or1k/nptl/bits/pthreadtypes-arch.h: New file.
	* sysdeps/or1k/nptl/bits/semaphore.h: New file.
	* sysdeps/or1k/nptl/pthreaddef.h: New file.
	* sysdeps/or1k/nptl/tcb-offsets.sym: New file.
	* sysdeps/or1k/nptl/tls.h: New file.
	* sysdeps/or1k/preconfigure: New file.
	* sysdeps/or1k/setjmp.S: New file.
	* sysdeps/or1k/sfp-machine.h: New file.
	* sysdeps/or1k/sotruss-lib.c: New file.
	* sysdeps/or1k/stackinfo.h: New file.
	* sysdeps/or1k/start.S: New file.
	* sysdeps/or1k/sysdep.h: New file.
	* sysdeps/or1k/tininess.h: New file.
	* sysdeps/or1k/tls-macros.h: New file.
	* sysdeps/or1k/tst-audit.h: New file.
	* sysdeps/unix/sysv/linux/or1k/Implies: New file.
	* sysdeps/unix/sysv/linux/or1k/Makefile: New file.
	* sysdeps/unix/sysv/linux/or1k/arch-syscall.h: New file.
	* sysdeps/unix/sysv/linux/or1k/bits/fcntl.h: New file.
	* sysdeps/unix/sysv/linux/or1k/bits/mman.h: New file.
	* sysdeps/unix/sysv/linux/or1k/c++-types.data: New file.
	* sysdeps/unix/sysv/linux/or1k/clone.c: New file.
	* sysdeps/unix/sysv/linux/or1k/configure: New file.
	* sysdeps/unix/sysv/linux/or1k/configure.ac: New file.
	* sysdeps/unix/sysv/linux/or1k/getcontext.S: New file.
	* sysdeps/unix/sysv/linux/or1k/ioctl.c: New file.
	* sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h: New file.
	* sysdeps/unix/sysv/linux/or1k/kernel-features.h: New file.
	* sysdeps/unix/sysv/linux/or1k/ld.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libanl.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libc.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libcrypt.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libdl.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libm.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libnsl.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libpthread.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libresolv.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/librt.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libthread_db.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/libutil.abilist: New file.
	* sysdeps/unix/sysv/linux/or1k/localplt.data: New file.
	* sysdeps/unix/sysv/linux/or1k/lowlevellock.h: New file.
	* sysdeps/unix/sysv/linux/or1k/makecontext.c: New file.
	* sysdeps/unix/sysv/linux/or1k/mmap_internal.h: New file.
	* sysdeps/unix/sysv/linux/or1k/or1k_clone.S: New file.
	* sysdeps/unix/sysv/linux/or1k/prctl.c: New file.
	* sysdeps/unix/sysv/linux/or1k/pt-vfork.c: New file.
	* sysdeps/unix/sysv/linux/or1k/setcontext.S: New file.
	* sysdeps/unix/sysv/linux/or1k/shlib-versions: New file.
	* sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h: New file.
	* sysdeps/unix/sysv/linux/or1k/swapcontext.S: New file.
	* sysdeps/unix/sysv/linux/or1k/sys/procfs.h: New file.
	* sysdeps/unix/sysv/linux/or1k/sys/ucontext.h: New file.
	* sysdeps/unix/sysv/linux/or1k/sys/user.h: New file.
	* sysdeps/unix/sysv/linux/or1k/syscall.c: New file.
	* sysdeps/unix/sysv/linux/or1k/sysdep.c: New file.
	* sysdeps/unix/sysv/linux/or1k/sysdep.h: New file.
	* sysdeps/unix/sysv/linux/or1k/ucontext_i.sym: New file.
	* sysdeps/unix/sysv/linux/syscall-names.list: New file.
---
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

diff --git a/elf/elf.h b/elf/elf.h
index 51e9968405..1e8a8e74c4 100644
--- a/elf/elf.h
+++ b/elf/elf.h
@@ -4096,6 +4096,43 @@ enum
 #define R_ARC_TLS_LE_S9		0x4a
 #define R_ARC_TLS_LE_32		0x4b
 
+/* OpenRISC 1000 specific relocs.  */
+#define R_OR1K_NONE		0
+#define R_OR1K_32		1
+#define R_OR1K_16		2
+#define R_OR1K_8		3
+#define R_OR1K_LO_16_IN_INSN	4
+#define R_OR1K_HI_16_IN_INSN	5
+#define R_OR1K_INSN_REL_26	6
+#define R_OR1K_GNU_VTENTRY	7
+#define R_OR1K_GNU_VTINHERIT	8
+#define R_OR1K_32_PCREL		9
+#define R_OR1K_16_PCREL		10
+#define R_OR1K_8_PCREL		11
+#define R_OR1K_GOTPC_HI16	12
+#define R_OR1K_GOTPC_LO16	13
+#define R_OR1K_GOT16		14
+#define R_OR1K_PLT26		15
+#define R_OR1K_GOTOFF_HI16	16
+#define R_OR1K_GOTOFF_LO16	17
+#define R_OR1K_COPY		18
+#define R_OR1K_GLOB_DAT		19
+#define R_OR1K_JMP_SLOT		20
+#define R_OR1K_RELATIVE		21
+#define R_OR1K_TLS_GD_HI16	22
+#define R_OR1K_TLS_GD_LO16	23
+#define R_OR1K_TLS_LDM_HI16	24
+#define R_OR1K_TLS_LDM_LO16	25
+#define R_OR1K_TLS_LDO_HI16	26
+#define R_OR1K_TLS_LDO_LO16	27
+#define R_OR1K_TLS_IE_HI16	28
+#define R_OR1K_TLS_IE_LO16	29
+#define R_OR1K_TLS_LE_HI16	30
+#define R_OR1K_TLS_LE_LO16	31
+#define R_OR1K_TLS_TPOFF	32
+#define R_OR1K_TLS_DTPOFF	33
+#define R_OR1K_TLS_DTPMOD	34
+
 __END_DECLS
 
 #endif	/* elf.h */
diff --git a/sysdeps/or1k/Implies b/sysdeps/or1k/Implies
new file mode 100644
index 0000000000..ff699c7dd5
--- /dev/null
+++ b/sysdeps/or1k/Implies
@@ -0,0 +1,4 @@
+init_array
+wordsize-32
+ieee754/dbl-64
+ieee754/flt-32
diff --git a/sysdeps/or1k/Makefile b/sysdeps/or1k/Makefile
new file mode 100644
index 0000000000..0241a0587e
--- /dev/null
+++ b/sysdeps/or1k/Makefile
@@ -0,0 +1,7 @@
+ASFLAGS-.os += -fPIC
+
+ifeq ($(subdir),elf)
+# Extra shared linker files to link only into dl-allobjs.so.
+sysdep-rtld-routines += dl-start
+endif
+
diff --git a/sysdeps/or1k/__longjmp.S b/sysdeps/or1k/__longjmp.S
new file mode 100644
index 0000000000..6db1320282
--- /dev/null
+++ b/sysdeps/or1k/__longjmp.S
@@ -0,0 +1,55 @@
+/* longjmp, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <features.h>
+#define _ASM
+#define _SETJMP_H
+#include <bits/setjmp.h>
+
+	.globl	__longjmp;
+	.type	__longjmp, @function;
+	.align	4;
+
+__longjmp:
+	l.lwz	r1, 0(r3)
+	l.lwz	r2, 4(r3)
+
+	/* if r4 is 0, something wrong, so set it to 1 */
+	l.sfeqi	r4, 0x0
+	l.bnf	1f		/* r4 != 0, longjmp value sensible */
+	 l.nop
+	l.ori	r4, r0, 0x1	/* make nonzero */
+1:
+	l.addi	r11, r4, 0
+	l.lwz	r9, 8(r3)
+	l.lwz	r10, 12(r3)
+	l.lwz	r14, 16(r3)
+	l.lwz	r16, 20(r3)
+	l.lwz	r18, 24(r3)
+	l.lwz	r20, 28(r3)
+	l.lwz	r22, 32(r3)
+	l.lwz	r24, 36(r3)
+	l.lwz	r26, 40(r3)
+	l.lwz	r28, 44(r3)
+	l.lwz	r30, 48(r3)
+	l.jr	r9
+	 l.nop
+	.size	__longjmp, . - __longjmp
+
+libc_hidden_def(__longjmp)
diff --git a/sysdeps/or1k/atomic-machine.h b/sysdeps/or1k/atomic-machine.h
new file mode 100644
index 0000000000..8505928911
--- /dev/null
+++ b/sysdeps/or1k/atomic-machine.h
@@ -0,0 +1,77 @@
+/* Atomic operations.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef __OR1K_ATOMIC_H_
+#define __OR1K_ATOMIC_H_
+
+#include <stdint.h>
+
+typedef int32_t atomic32_t;
+typedef uint32_t uatomic32_t;
+
+typedef intptr_t atomicptr_t;
+typedef uintptr_t uatomicptr_t;
+typedef intmax_t atomic_max_t;
+typedef uintmax_t uatomic_max_t;
+
+#define __HAVE_64B_ATOMICS 0
+#define USE_ATOMIC_COMPILER_BUILTINS 1
+#define ATOMIC_EXCHANGE_USES_CAS 1
+
+#define __arch_compare_and_exchange_bool_8_int(mem, newval, oldval, model) \
+  (abort (), 0)
+
+#define __arch_compare_and_exchange_bool_16_int(mem, newval, oldval, model) \
+  (abort (), 0)
+
+#define __arch_compare_and_exchange_bool_32_int(mem, newval, oldval, model) \
+  ({                                                                    \
+    typeof (*mem) __oldval = (oldval);                                  \
+    !__atomic_compare_exchange_n (mem, (void *) &__oldval, newval, 0,   \
+                                  model, __ATOMIC_RELAXED);             \
+  })
+
+#define __arch_compare_and_exchange_bool_64_int(mem, newval, oldval, model) \
+  (abort (), 0)
+
+#define __arch_compare_and_exchange_val_8_int(mem, newval, oldval, model) \
+  (abort (), (__typeof (*mem)) 0)
+
+#define __arch_compare_and_exchange_val_16_int(mem, newval, oldval, model) \
+  (abort (), (__typeof (*mem)) 0)
+
+#define __arch_compare_and_exchange_val_32_int(mem, newval, oldval, model) \
+  ({                                                                    \
+    typeof (*mem) __oldval = (oldval);                                  \
+    __atomic_compare_exchange_n (mem, (void *) &__oldval, newval, 0,    \
+                                 model, __ATOMIC_RELAXED);              \
+    __oldval;                                                           \
+  })
+
+#define __arch_compare_and_exchange_val_64_int(mem, newval, oldval, model) \
+  (abort (), (__typeof (*mem)) 0)
+
+#define atomic_compare_and_exchange_bool_acq(mem, new, old)		\
+  __atomic_bool_bysize (__arch_compare_and_exchange_bool, int,		\
+			mem, new, old, __ATOMIC_ACQUIRE)
+
+#define atomic_compare_and_exchange_val_acq(mem, new, old)		\
+  __atomic_val_bysize (__arch_compare_and_exchange_val, int,		\
+		       mem, new, old, __ATOMIC_ACQUIRE)
+
+#endif /* atomic-machine.h */
diff --git a/sysdeps/or1k/bits/atomic.h b/sysdeps/or1k/bits/atomic.h
new file mode 100644
index 0000000000..89520af043
--- /dev/null
+++ b/sysdeps/or1k/bits/atomic.h
@@ -0,0 +1,51 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _OR1K_BITS_ATOMIC_H
+#define _OR1K_BITS_ATOMIC_H     1
+
+#include <stdint.h>
+
+typedef int8_t  atomic8_t;
+typedef int16_t atomic16_t;
+typedef int32_t atomic32_t;
+
+typedef uint8_t  uatomic8_t;
+typedef uint16_t uatomic16_t;
+typedef uint32_t uatomic32_t;
+
+typedef intptr_t atomicptr_t;
+typedef uintptr_t uatomicptr_t;
+typedef intmax_t atomic_max_t;
+typedef uintmax_t uatomic_max_t;
+
+#define atomic_compare_and_exchange_val_acq(mem, newval, oldval) \
+  ({                                                                    \
+    typeof (*mem) __oldval = (oldval);                                  \
+    __atomic_compare_exchange_n (mem, (void *) &__oldval, newval, 0,    \
+                                 __ATOMIC_ACQUIRE, __ATOMIC_RELAXED);   \
+    __oldval;                                                           \
+  })
+
+#define atomic_exchange_acq(mem, value) \
+  __atomic_exchange_n(mem, value, __ATOMIC_ACQUIRE)
+
+#define atomic_exchange_and_add_acq(mem, value) \
+  __atomic_fetch_add(mem, value, __ATOMIC_ACQUIRE)
+
+#endif
diff --git a/sysdeps/or1k/bits/endianness.h b/sysdeps/or1k/bits/endianness.h
new file mode 100644
index 0000000000..96fd5ae5ef
--- /dev/null
+++ b/sysdeps/or1k/bits/endianness.h
@@ -0,0 +1,11 @@
+#ifndef _BITS_ENDIANNESS_H
+#define _BITS_ENDIANNESS_H 1
+
+#ifndef _BITS_ENDIAN_H
+# error "Never use <bits/endianness.h> directly; include <endian.h> instead."
+#endif
+
+/* HP-PA is big-endian.  */
+#define __BYTE_ORDER __BIG_ENDIAN
+
+#endif /* bits/endianness.h */
diff --git a/sysdeps/or1k/bits/fenv.h b/sysdeps/or1k/bits/fenv.h
new file mode 100644
index 0000000000..767b4bba4f
--- /dev/null
+++ b/sysdeps/or1k/bits/fenv.h
@@ -0,0 +1,79 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public License as
+   published by the Free Software Foundation; either version 2.1 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _FENV_H
+# error "Never use <bits/fenv.h> directly; include <fenv.h> instead."
+#endif
+
+#ifdef __or1k_hard_float__
+/* Define bits representing exceptions in the FPCSR status word.  */
+enum
+  {
+    FE_OVERFLOW =
+#define FE_OVERFLOW	1 << 3
+      FE_OVERFLOW,
+    FE_UNDERFLOW =
+#define FE_UNDERFLOW	1 << 4
+      FE_UNDERFLOW,
+    FE_INEXACT =
+#define FE_INEXACT	1 << 8
+      FE_INEXACT,
+    FE_INVALID =
+#define FE_INVALID	1 << 9
+      FE_INVALID,
+    FE_DIVBYZERO =
+#define FE_DIVBYZERO	1 << 11
+      FE_DIVBYZERO,
+  };
+
+/* All supported exceptions.  */
+#define FE_ALL_EXCEPT	\
+	(FE_INVALID | FE_DIVBYZERO | FE_OVERFLOW | FE_UNDERFLOW | FE_INEXACT)
+
+/* Define bits representing rounding modes in the FPCSR Rmode field.  */
+#define FE_TONEAREST  (0x0 << 1)
+#define FE_TOWARDZERO (0x1 << 1)
+#define FE_UPWARD     (0x2 << 1)
+#define FE_DOWNWARD   (0x3 << 1)
+
+#else
+
+/* For the soft-float case, we only support round to nearest and no
+   exceptions.  */
+
+#define FE_ALL_EXCEPT 0
+#define FE_TONEAREST  0
+
+#endif
+
+/* Type representing exception flags. */
+typedef unsigned int fexcept_t;
+
+/* Type representing floating-point environment.  */
+typedef unsigned int fenv_t;
+
+/* If the default argument is used we use this value.  */
+#define FE_DFL_ENV	((const fenv_t *) -1l)
+
+#if __GLIBC_USE (IEC_60559_BFP_EXT)
+/* Type representing floating-point control modes.  */
+typedef unsigned int femode_t;
+
+/* Default floating-point control modes.  */
+# define FE_DFL_MODE	((const femode_t *) -1L)
+#endif
diff --git a/sysdeps/or1k/bits/link.h b/sysdeps/or1k/bits/link.h
new file mode 100644
index 0000000000..3fe8385f4f
--- /dev/null
+++ b/sysdeps/or1k/bits/link.h
@@ -0,0 +1,51 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _LINK_H
+# error "Never include <bits/link.h> directly; use <link.h> instead."
+#endif
+
+/* Registers for entry into PLT.  */
+typedef struct La_or1k_regs
+{
+  uint32_t lr_reg[31];
+} La_or1k_regs;
+
+/* Return values for calls from PLT.  */
+typedef struct La_or1k_retval
+{
+  uint32_t lrv_r3;
+} La_or1k_retval;
+
+
+__BEGIN_DECLS
+
+extern ElfW(Addr) la_or1k_gnu_pltenter (ElfW(Sym) *__sym, unsigned int __ndx,
+                                        uintptr_t *__refcook,
+                                        uintptr_t *__defcook,
+                                        La_or1k_regs *__regs,
+                                        unsigned int *__flags,
+                                        const char *__symname,
+                                        long int *__framesizep);
+extern unsigned int la_or1k_gnu_pltexit (ElfW(Sym) *__sym, unsigned int __ndx,
+                                         uintptr_t *__refcook,
+                                         uintptr_t *__defcook,
+                                         const La_or1k_regs *__inregs,
+                                         La_or1k_retval *__outregs,
+                                         const char *__symname);
+
+__END_DECLS
diff --git a/sysdeps/or1k/bits/setjmp.h b/sysdeps/or1k/bits/setjmp.h
new file mode 100644
index 0000000000..dd07fce68c
--- /dev/null
+++ b/sysdeps/or1k/bits/setjmp.h
@@ -0,0 +1,36 @@
+/* Define the machine-dependent type `jmp_buf'.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+
+#ifndef _OR1K_BITS_SETJMP_H
+#define _OR1K_BITS_SETJMP_H  1
+
+#if !defined _SETJMP_H && !defined _PTHREAD_H
+# error "Never include <bits/setjmp.h> directly; use <setjmp.h> instead."
+#endif
+
+#if defined __USE_MISC || defined _ASM
+# define JB_SP     0  /* GPR1 */
+#endif
+
+#ifndef _ASM
+typedef long int __jmp_buf[13];
+#endif
+
+#endif /* _OR1K_BITS_SETJMP_H */
diff --git a/sysdeps/or1k/bsd-_setjmp.S b/sysdeps/or1k/bsd-_setjmp.S
new file mode 100644
index 0000000000..4e6a2da560
--- /dev/null
+++ b/sysdeps/or1k/bsd-_setjmp.S
@@ -0,0 +1 @@
+/* _setjmp is in setjmp.S  */
diff --git a/sysdeps/or1k/bsd-setjmp.S b/sysdeps/or1k/bsd-setjmp.S
new file mode 100644
index 0000000000..1da848d2f1
--- /dev/null
+++ b/sysdeps/or1k/bsd-setjmp.S
@@ -0,0 +1 @@
+/* setjmp is in setjmp.S  */
diff --git a/sysdeps/or1k/dl-machine.h b/sysdeps/or1k/dl-machine.h
new file mode 100644
index 0000000000..0bcdc9888c
--- /dev/null
+++ b/sysdeps/or1k/dl-machine.h
@@ -0,0 +1,339 @@
+/* Machine-dependent ELF dynamic relocation inline functions.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef dl_machine_h
+#define dl_machine_h
+
+#define ELF_MACHINE_NAME "or1k"
+
+#include <sys/param.h>
+#include <tls.h>
+#include <dl-irel.h>
+#include <assert.h>
+
+/* All relocs are Rela, no Rel */
+#define ELF_MACHINE_NO_REL 1
+
+/* Return nonzero iff ELF header is compatible with the running host.  */
+static inline int __attribute__ ((unused))
+elf_machine_matches_host (const Elf32_Ehdr *ehdr)
+{
+  return ehdr->e_machine == EM_OPENRISC;
+}
+
+static inline Elf32_Addr *
+or1k_get_got (void)
+{
+  Elf32_Addr *got;
+  Elf32_Addr linkreg;
+  __asm__("l.ori   %0, r9, 0\n"
+    "l.jal  8\n"
+    "l.movhi  %1, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n"
+    "l.ori  %1, %1, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n"
+    "l.add  %1, %1, r9\n"
+    "l.ori  r9, %0, 0\n"
+    : "=r" (linkreg), "=r" (got));
+
+  return got;
+}
+
+/* Return the link-time address of _DYNAMIC.  Conveniently, this is the
+   first element of the GOT. */
+static inline Elf32_Addr
+elf_machine_dynamic (void)
+{
+  Elf32_Addr *got = or1k_get_got();
+  return *got;
+}
+
+
+/* Return the run-time load address of the shared object.  */
+static inline Elf32_Addr
+elf_machine_load_address (void)
+{
+  /* Compute the difference between the runtime address of _DYNAMIC as seen
+     by a GOTOFF reference, and the link-time address found in the special
+     unrelocated first GOT entry.  */
+  Elf32_Addr dyn;
+  Elf32_Addr *got = or1k_get_got();
+
+  __asm__ __volatile__ (
+    "l.movhi %0, gotoffhi(_DYNAMIC);"
+    "l.ori %0, %0, gotofflo(_DYNAMIC);"
+    "l.add %0, %0, %1;"
+    : "=r"(dyn) : "r"(got)
+    );
+
+  return dyn - *got;
+}
+
+/* Initial entry point code for the dynamic linker.
+   The C function `_dl_start' is the real entry point;
+   its return value is the user program's entry point.
+
+   Code is really located in dl-start.S, just tell the
+   linker that it exists. */
+#define RTLD_START asm (".globl _dl_start");
+
+/* ELF_RTYPE_CLASS_PLT iff TYPE describes relocation of a PLT entry or
+   TLS variable, so undefined references should not be allowed to
+   define the value.
+   ELF_RTYPE_CLASS_NOCOPY iff TYPE should not be allowed to resolve to one
+   of the main executable's symbols, as for a COPY reloc.  */
+
+#define elf_machine_type_class(type) \
+  (((type) == R_OR1K_JMP_SLOT \
+   || (type) == R_OR1K_TLS_DTPMOD \
+   || (type) == R_OR1K_TLS_DTPOFF \
+   || (type) == R_OR1K_TLS_TPOFF) * ELF_RTYPE_CLASS_PLT \
+   | ((type) == R_OR1K_COPY) * ELF_RTYPE_CLASS_COPY)
+
+/* A reloc type used for ld.so cmdline arg lookups to reject PLT entries.  */
+#define ELF_MACHINE_JMP_SLOT    R_OR1K_JMP_SLOT
+
+#define ELF_MACHINE_NO_REL 1
+#define ELF_MACHINE_NO_RELA 0
+
+#define ARCH_LA_PLTENTER or1k_gnu_pltenter
+#define ARCH_LA_PLTEXIT or1k_gnu_pltexit
+
+/* Set up the loaded object described by L so its unrelocated PLT
+   entries will jump to the on-demand fixup code in dl-runtime.c.  */
+static inline int __attribute__ ((unused, always_inline))
+elf_machine_runtime_setup (struct link_map *l, int lazy, int profile)
+{
+  ElfW(Addr) *pltgot;
+  extern void _dl_runtime_resolve (ElfW(Word));
+  extern void _dl_runtime_profile (ElfW(Word));
+
+  if (l->l_info[DT_JMPREL] && lazy)
+    {
+      pltgot = (ElfW(Addr) *) D_PTR (l, l_info[DT_PLTGOT]);
+
+      /* Fill in initial entrys of the plt */
+
+      /* Register the link_map address in the plt at pltgot[1].
+         This will also be used in the resolver for accessing the
+         link_map structure.  */
+      pltgot[1] = (ElfW(Addr)) l;
+
+      /* The pltgot[2] entry contains the address of a function which gets
+	 called to get the address of a so far unresolved function and
+	 jump to it.  The profiling extension of the dynamic linker allows
+	 to intercept the calls to collect information.  In this case we
+	 don't store the address in the GOT so that all future calls also
+	 end in this function.  */
+#if 0 /* Profiling not supported in OpenRISC yet (need to implement
+         _dl_runtime_profile).  */
+      if ( profile)
+	{
+	   pltgot[2] = (ElfW(Addr)) &_dl_runtime_profile;
+
+	  if (GLRO(dl_profile) != NULL
+	      && _dl_name_match_p (GLRO(dl_profile), l))
+	    /* Say that we really want profiling and the timers are
+	       started.  */
+	    GL(dl_profile_map) = l;
+	}
+      else
+#endif
+	{
+	  /* This function will get called to fix up the GOT entry
+	     indicated by the offset on the stack, and then jump to
+	     the resolved address.  */
+	  pltgot[2] = (ElfW(Addr)) &_dl_runtime_resolve;
+	}
+
+    }
+
+  return lazy;
+}
+
+/* Mask identifying addresses reserved for the user program,
+   where the dynamic linker should not map anything.  */
+#define ELF_MACHINE_USER_ADDRESS_MASK   0xf8000000UL
+
+/* We define an initialization functions.  This is called very early in
+   _dl_sysdep_start.  */
+#define DL_PLATFORM_INIT dl_platform_init ()
+
+static inline void __attribute__ ((unused))
+dl_platform_init (void)
+{
+  if (GLRO(dl_platform) != NULL && *GLRO(dl_platform) == '\0')
+    /* Avoid an empty string which would disturb us.  */
+    GLRO(dl_platform) = NULL;
+}
+
+static inline ElfW(Addr)
+elf_machine_fixup_plt (struct link_map *map, lookup_t t,
+		       const ElfW(Sym) *refsym, const ElfW(Sym) *sym,
+		       const ElfW(Rela) *reloc,
+		       ElfW(Addr) *reloc_addr, ElfW(Addr) value)
+{
+  return *reloc_addr = value;
+}
+
+/* Return the final value of a plt relocation.  */
+static inline Elf32_Addr
+elf_machine_plt_value (struct link_map *map, const Elf32_Rela *reloc,
+                       Elf32_Addr value)
+{
+  return value + reloc->r_addend;
+}
+
+
+#endif /* !dl_machine_h */
+
+#ifdef RESOLVE_MAP
+
+/* Perform the relocation specified by RELOC and SYM (which is fully resolved).
+   MAP is the object containing the reloc.  */
+
+auto inline void
+__attribute ((always_inline))
+elf_machine_rela (struct link_map *map, const Elf32_Rela *reloc,
+                  const Elf32_Sym *sym, const struct r_found_version *version,
+                  void *const reloc_addr_arg, int skip_ifunc)
+{
+  Elf32_Addr *const reloc_addr = reloc_addr_arg;
+  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
+
+  if (__builtin_expect (r_type == R_OR1K_NONE, 0))
+    return;
+  else
+    {
+# ifndef RESOLVE_CONFLICT_FIND_MAP
+      const Elf32_Sym *const refsym = sym;
+# endif
+      struct link_map *sym_map = RESOLVE_MAP (&sym, version, r_type);
+      Elf32_Addr value = SYMBOL_ADDRESS (sym_map, sym, true);
+
+      if (sym != NULL
+          && __builtin_expect (ELFW(ST_TYPE) (sym->st_info) == STT_GNU_IFUNC, 0)
+          && __builtin_expect (sym->st_shndx != SHN_UNDEF, 1)
+          && __builtin_expect (!skip_ifunc, 1))
+        value = elf_ifunc_invoke (value);
+
+      switch (r_type)
+        {
+# ifndef RESOLVE_CONFLICT_FIND_MAP
+          case R_OR1K_COPY:
+            if (sym == NULL)
+              /* This can happen in trace mode if an object could not be
+                 found.  */
+              break;
+            if (__builtin_expect (sym->st_size > refsym->st_size, 0)
+                || (__builtin_expect (sym->st_size < refsym->st_size, 0)
+                  && GLRO(dl_verbose)))
+            {
+              const char *strtab;
+
+              strtab = (const char *) D_PTR (map, l_info[DT_STRTAB]);
+              _dl_error_printf ("\
+%s: Symbol `%s' has different size in shared object, consider re-linking\n",
+                  rtld_progname ?: "<program name unknown>",
+                  strtab + refsym->st_name);
+            }
+            memcpy (reloc_addr_arg, (void *) value,
+                MIN (sym->st_size, refsym->st_size));
+            break;
+#endif
+          case R_OR1K_32:
+	    {
+	      /* Handle mis-aligned offsets */
+	      struct unaligned
+		{
+		  Elf32_Addr x;
+		} __attribute__ ((packed, may_alias));
+
+	      /* Support relocations on mis-aligned offsets.  */
+	      ((struct unaligned *) reloc_addr)->x = value + reloc->r_addend;
+	      break;
+	    }
+	  case R_OR1K_GLOB_DAT:
+	  case R_OR1K_JMP_SLOT:
+	    *reloc_addr = value + reloc->r_addend;
+	    break;
+	  case R_OR1K_TLS_DTPMOD:
+# ifdef RTLD_BOOTSTRAP
+	    /* During startup the dynamic linker is always the module
+	       with index 1. */
+	    *reloc_addr = 1;
+# else
+	    if (sym_map != NULL)
+	      *reloc_addr = sym_map->l_tls_modid;
+# endif
+	    break;
+	  case R_OR1K_TLS_DTPOFF:
+# ifndef RTLD_BOOTSTRAP
+	    *reloc_addr = (sym == NULL ? 0 : sym->st_value) + reloc->r_addend;
+# endif
+	    break;
+
+          case R_OR1K_TLS_TPOFF:
+# ifdef RTLD_BOOTSTRAP
+	    *reloc_addr = sym->st_value + reloc->r_addend +
+	      map->l_tls_offset - TLS_TCB_SIZE;
+# else
+	    if (sym_map != NULL)
+	      {
+		CHECK_STATIC_TLS (map, sym_map);
+		*reloc_addr = sym->st_value + reloc->r_addend +
+		  sym_map->l_tls_offset - TLS_TCB_SIZE;
+	      }
+# endif
+	    break;
+          default:
+            _dl_fatal_printf("Unhandled reloc: %u\n", r_type);
+            _dl_reloc_bad_type (map, r_type, 0);
+            break;
+        }
+    }
+}
+
+auto inline void
+__attribute__ ((always_inline))
+elf_machine_rela_relative (Elf32_Addr l_addr, const Elf32_Rela *reloc,
+                           void *const reloc_addr_arg)
+{
+  Elf32_Addr *const reloc_addr = reloc_addr_arg;
+  *reloc_addr = l_addr + reloc->r_addend;
+}
+
+auto inline void
+__attribute__ ((always_inline))
+elf_machine_lazy_rel (struct link_map *map,
+                      Elf32_Addr l_addr, const Elf32_Rela *reloc,
+                      int skip_ifunc)
+{
+  Elf32_Addr *const reloc_addr = (void *) (l_addr + reloc->r_offset);
+  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
+
+  if (__builtin_expect (r_type == R_OR1K_JMP_SLOT, 1))
+      *reloc_addr += l_addr;
+  else if (__builtin_expect (r_type == R_OR1K_NONE, 0))
+    return;
+  else
+    {
+      _dl_fatal_printf("Unhandled lazy reloc: %u\n", r_type);
+      _dl_reloc_bad_type (map, r_type, 1);
+    }
+}
+
+#endif /* RESOLVE_MAP */
diff --git a/sysdeps/or1k/dl-start.S b/sysdeps/or1k/dl-start.S
new file mode 100644
index 0000000000..95cb0f2396
--- /dev/null
+++ b/sysdeps/or1k/dl-start.S
@@ -0,0 +1,101 @@
+/* Machine-dependent ELF startup code.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+
+/* Initial entry point code for the dynamic linker.
+   The C function `_dl_start' is the real entry point;
+   it's return value is the user program's entry point.  */
+ENTRY(_start)
+	/* Count arguments in r11 */
+	l.ori	r3, r1, 0
+	l.movhi	r11, 0
+1:
+	l.addi	r3, r3, 4
+	l.lwz	r12, 0(r3)
+	l.sfnei	r12, 0
+	l.addi	r11, r11, 1
+	l.bf	1b
+	 l.nop
+	l.addi	r11, r11, -1
+	/* store argument counter to stack.  */
+	l.sw	0(r1), r11
+
+	l.jal	.LPC0
+	 l.nop
+	/* Load the PIC register.  */
+.LPC0:
+	l.movhi	r16, gotpchi(_GLOBAL_OFFSET_TABLE_+(.-.LPC0))
+	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+(.-.LPC0))
+	l.add	r16, r16, r9
+
+	l.ori	r3, r1, 0
+
+	l.jal	_dl_start
+	 l.nop
+	/* Save user entry in a call saved reg.  */
+	l.ori	r22, r11, 0
+	/* Fall through to _dl_start_user.  */
+
+_dl_start_user:
+	/* Set up for _dl_init. */
+
+	/* Load _rtld_local (a.k.a _dl_loaded).  */
+	l.lwz	r12, got(_rtld_local)(r16)
+	l.lwz	r3, 0(r12)
+
+	/* Load argc */
+	l.lwz	r18, got(_dl_argc)(r16)
+	l.lwz	r4, 0(r18)
+
+	/* Load argv */
+	l.lwz	r20, got(_dl_argv)(r16)
+	l.lwz	r5, 0(r20)
+
+	/* Load envp = &argv[argc + 1].  */
+	l.slli	r6, r4, 2
+	l.addi	r6, r6, 4
+	l.add	r6, r6, r5
+
+	l.jal	plt(_dl_init)
+	 l.nop
+
+	/* Now set up for user entry.
+	   The already defined ABI loads argc and argv from the stack.
+
+	   argc = 0(r1)
+	   argv = r1 + 4
+	*/
+
+	/* Load SP as argv - 4.  */
+	l.lwz	r3, 0(r20)
+	l.addi	r1, r3, -4
+
+	/* Save argc.  */
+	l.lwz	r3, 0(r18)
+	l.sw	0(r1), r3
+
+	/* Load termination function address.
+	   Pass this in r9 to the _start function.
+	   start.S will then pass this to __libc_start_main.  */
+	l.lwz	r9, got(_dl_fini)(r16)
+
+	l.jr	r22
+	 l.nop
+
+END(_start)
diff --git a/sysdeps/or1k/dl-tls.h b/sysdeps/or1k/dl-tls.h
new file mode 100644
index 0000000000..105dd575e1
--- /dev/null
+++ b/sysdeps/or1k/dl-tls.h
@@ -0,0 +1,28 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public License as
+   published by the Free Software Foundation; either version 2.1 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+/* Type used for the representation of TLS information in the GOT.  */
+typedef struct
+{
+  unsigned long int ti_module;
+  unsigned long int ti_offset;
+} tls_index;
+
+
+extern void *__tls_get_addr (tls_index *ti);
+
diff --git a/sysdeps/or1k/dl-trampoline.S b/sysdeps/or1k/dl-trampoline.S
new file mode 100644
index 0000000000..b06aa50f76
--- /dev/null
+++ b/sysdeps/or1k/dl-trampoline.S
@@ -0,0 +1,82 @@
+/* Machine-dependent ELF runtime symbol resolution, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+/* This code is used to call _dl_linux_resolver (dl-runtime.c).
+
+   We assume that R11 contain relocation offset and R12 contains
+   link_map (_DYNAMIC). This must be consistent with the JUMP_SLOT
+   layout generated by binutils. */
+
+	.section .text
+	.align 4
+
+	.global	_dl_runtime_resolve
+	.type	_dl_runtime_resolve, @function
+
+_dl_runtime_resolve:
+	.cfi_startproc
+	l.sw	-4(r1), r9
+	l.sw	-8(r1), r1
+
+	/* save function arguments.  */
+	l.sw	-12(r1), r3
+	l.sw	-16(r1), r4
+	l.sw	-20(r1), r5
+	l.sw	-24(r1), r6
+	l.sw	-28(r1), r7
+	l.sw	-32(r1), r8
+
+	.cfi_offset 9, -4
+	.cfi_offset 1, -8
+	.cfi_offset 3, -12
+	.cfi_offset 4, -16
+	.cfi_offset 5, -20
+	.cfi_offset 6, -24
+	.cfi_offset 7, -28
+	.cfi_offset 8, -32
+
+	l.addi	r1,r1, -32
+	.cfi_def_cfa_offset 32
+
+	l.ori	r3, r12, 0
+	l.ori	r4, r11, 0
+
+	l.jal	_dl_fixup
+	 l.nop
+
+	/* Restore function arguments.  */
+	l.addi	r1,r1, 32
+	l.lwz	r8, -32(r1)
+	l.lwz	r7, -28(r1)
+	l.lwz	r6, -24(r1)
+	l.lwz	r5, -20(r1)
+	l.lwz	r4, -16(r1)
+	l.lwz	r3, -12(r1)
+
+	/* restore return address.  */
+	l.lwz	r9, -4(r1)
+
+	l.jr	r11
+	 l.nop
+
+	.cfi_endproc
+	.size	_dl_runtime_resolve, . - _dl_runtime_resolve
+
+/* TODO: _dl_runtime_profile */
+
diff --git a/sysdeps/or1k/fpu/fclrexcpt.c b/sysdeps/or1k/fpu/fclrexcpt.c
new file mode 100644
index 0000000000..6ddc9cd337
--- /dev/null
+++ b/sysdeps/or1k/fpu/fclrexcpt.c
@@ -0,0 +1,41 @@
+/* Clear given exceptions in current floating-point environment.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+feclearexcept (int excepts)
+{
+  fpu_control_t cw;
+
+  /* Mask out unsupported bits/exceptions.  */
+  excepts &= FE_ALL_EXCEPT;
+
+  /* Read the complete control word.  */
+  _FPU_GETCW (cw);
+
+  cw &= ~excepts;
+
+  /* Put the new data in effect.  */
+  _FPU_SETCW (cw);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (feclearexcept)
diff --git a/sysdeps/or1k/fpu/fegetenv.c b/sysdeps/or1k/fpu/fegetenv.c
new file mode 100644
index 0000000000..c15c733ed4
--- /dev/null
+++ b/sysdeps/or1k/fpu/fegetenv.c
@@ -0,0 +1,32 @@
+/* Store current floating-point environment.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__fegetenv (fenv_t *envp)
+{
+  _FPU_GETCW (*envp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__fegetenv)
+weak_alias (__fegetenv, fegetenv)
+libm_hidden_weak (fegetenv)
diff --git a/sysdeps/or1k/fpu/fegetmode.c b/sysdeps/or1k/fpu/fegetmode.c
new file mode 100644
index 0000000000..b20c551b0a
--- /dev/null
+++ b/sysdeps/or1k/fpu/fegetmode.c
@@ -0,0 +1,27 @@
+/* Store current floating-point control modes.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fegetmode (femode_t *modep)
+{
+  _FPU_GETCW (*modep);
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fegetround.c b/sysdeps/or1k/fpu/fegetround.c
new file mode 100644
index 0000000000..de34c247cb
--- /dev/null
+++ b/sysdeps/or1k/fpu/fegetround.c
@@ -0,0 +1,34 @@
+/* Return current rounding direction.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__fegetround (void)
+{
+  fpu_control_t cw;
+
+  /* Get control word.  */
+  _FPU_GETCW (cw);
+
+  return cw & (0x3 << 1);
+}
+libm_hidden_def (__fegetround)
+weak_alias (__fegetround, fegetround)
+libm_hidden_weak (fegetround)
diff --git a/sysdeps/or1k/fpu/feholdexcpt.c b/sysdeps/or1k/fpu/feholdexcpt.c
new file mode 100644
index 0000000000..b81d83a65e
--- /dev/null
+++ b/sysdeps/or1k/fpu/feholdexcpt.c
@@ -0,0 +1,41 @@
+/* Store current floating-point environment and clear exceptions.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__feholdexcept (fenv_t *envp)
+{
+  fpu_control_t cw;
+
+  /* Store the environment.  */
+  _FPU_GETCW (cw);
+  *envp = cw;
+
+  /* Clear the status flags.  */
+  cw &= ~FE_ALL_EXCEPT;
+
+  _FPU_SETCW (cw);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__feholdexcept)
+weak_alias (__feholdexcept, feholdexcept)
+libm_hidden_weak (feholdexcept)
diff --git a/sysdeps/or1k/fpu/fesetenv.c b/sysdeps/or1k/fpu/fesetenv.c
new file mode 100644
index 0000000000..1fe7230c58
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetenv.c
@@ -0,0 +1,35 @@
+/* Install given floating-point environment.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__fesetenv (const fenv_t *envp)
+{
+  if (envp == FE_DFL_ENV)
+    _FPU_SETCW (_FPU_DEFAULT);
+  else
+    _FPU_SETCW (*envp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__fesetenv)
+weak_alias (__fesetenv, fesetenv)
+libm_hidden_weak (fesetenv)
diff --git a/sysdeps/or1k/fpu/fesetexcept.c b/sysdeps/or1k/fpu/fesetexcept.c
new file mode 100644
index 0000000000..192e92bbca
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetexcept.c
@@ -0,0 +1,32 @@
+/* Set given exception flags.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fesetexcept (int excepts)
+{
+  fpu_control_t cw;
+
+  _FPU_GETCW (cw);
+  cw |= excepts & FE_ALL_EXCEPT;
+  _FPU_SETCW (cw);
+
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fesetmode.c b/sysdeps/or1k/fpu/fesetmode.c
new file mode 100644
index 0000000000..007ef8b54f
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetmode.c
@@ -0,0 +1,42 @@
+/* Install given floating-point control modes.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+/* Mask to allow setting all writeable flags.  */
+#define FPCSR_STATUS (0x3 << 1)
+
+int
+fesetmode (const femode_t *modep)
+{
+  fpu_control_t cw;
+
+  _FPU_GETCW (cw);
+  /* First clear all flags.  */
+  cw &= ~FPCSR_STATUS;
+
+  /* Next, set the flags to those passed in.  */
+  if (modep == FE_DFL_MODE)
+    cw |= _FPU_DEFAULT;
+  else
+    cw |= *modep & FPCSR_STATUS;
+  _FPU_SETCW (cw);
+
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fesetround.c b/sysdeps/or1k/fpu/fesetround.c
new file mode 100644
index 0000000000..c6484a1959
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetround.c
@@ -0,0 +1,44 @@
+/* Set current rounding direction.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__fesetround (int round)
+{
+  fpu_control_t cw;
+
+  switch (round)
+    {
+    case FE_TONEAREST:
+    case FE_TOWARDZERO:
+    case FE_DOWNWARD:
+    case FE_UPWARD:
+      _FPU_GETCW (cw);
+      cw &= ~(0x3 << 1);
+      cw |= round;
+      _FPU_SETCW (cw);
+      return 0;
+    default:
+      return round; /* A nonzero value.  */
+    }
+}
+libm_hidden_def (__fesetround)
+weak_alias (__fesetround, fesetround)
+libm_hidden_weak (fesetround)
diff --git a/sysdeps/or1k/fpu/feupdateenv.c b/sysdeps/or1k/fpu/feupdateenv.c
new file mode 100644
index 0000000000..5fa081023b
--- /dev/null
+++ b/sysdeps/or1k/fpu/feupdateenv.c
@@ -0,0 +1,44 @@
+/* Install given floating-point environment and raise exceptions.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__feupdateenv (const fenv_t *envp)
+{
+  fpu_control_t temp;
+
+  /* Save current exceptions.  */
+  _FPU_GETCW (temp);
+  temp &= FE_ALL_EXCEPT;
+
+  /* Install new environment.  */
+  __fesetenv (envp);
+
+  /* Raise the safed exception.  Incidently for us the implementation
+     defined format of the values in objects of type fexcept_t is the
+     same as the ones specified using the FE_* constants.  */
+  __feraiseexcept (temp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__feupdateenv)
+weak_alias (__feupdateenv, feupdateenv)
+libm_hidden_weak (feupdateenv)
diff --git a/sysdeps/or1k/fpu/fgetexcptflg.c b/sysdeps/or1k/fpu/fgetexcptflg.c
new file mode 100644
index 0000000000..320ea08547
--- /dev/null
+++ b/sysdeps/or1k/fpu/fgetexcptflg.c
@@ -0,0 +1,37 @@
+/* Store current representation for exceptions.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fegetexceptflag (fexcept_t *flagp, int excepts)
+{
+  fpu_control_t temp;
+
+  /* Get the current exceptions.  */
+  _FPU_GETCW (temp);
+
+  /* We only save the relevant bits here. In particular, care has to be
+     taken with the CAUSE bits, as an inadvertent restore later on could
+     generate unexpected exceptions.  */
+  *flagp = temp & excepts & FE_ALL_EXCEPT;
+
+  /* Success.  */
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fraiseexcpt.c b/sysdeps/or1k/fpu/fraiseexcpt.c
new file mode 100644
index 0000000000..7a9cfa3bdf
--- /dev/null
+++ b/sysdeps/or1k/fpu/fraiseexcpt.c
@@ -0,0 +1,82 @@
+/* Raise given exceptions.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+#include <float.h>
+#include <math.h>
+
+int
+__feraiseexcept (int excepts)
+{
+  fpu_control_t cw;
+
+  if (excepts == 0)
+    return 0;
+
+
+  /* Raise exceptions represented by EXPECTS.  */
+
+  if (excepts & FE_INEXACT)
+  {
+    float d = 1.0, x = 3.0;
+    __asm__ volatile ("lf.div.s %0, %0, %1" : "+r" (d) : "r" (x));
+  }
+
+  if (excepts & FE_UNDERFLOW)
+  {
+    float d = FLT_MIN;
+    __asm__ volatile ("lf.mul.s %0, %0, %0" : "+r" (d));
+  }
+
+  if (excepts & FE_OVERFLOW)
+  {
+    float d = FLT_MAX;
+    __asm__ volatile ("lf.mul.s %0, %0, %0" : "+r" (d) : "r" (d));
+  }
+
+  if (excepts & FE_DIVBYZERO)
+  {
+    float d = 1.0, x = 0.0;
+    __asm__ volatile ("lf.div.s %0, %0, %1" : "+r" (d) : "r" (x));
+  }
+
+  if (excepts & FE_INVALID)
+  {
+    float d = HUGE_VAL, x = 0.0;
+    __asm__ volatile ("lf.mul.s %0, %1, %0" : "+r" (d) : "r" (x));
+  }
+
+  /* Get current state.  */
+  _FPU_GETCW (cw);
+
+  /* Set flag bits (which are accumulative), and *also* set the
+     cause bits. The setting of the cause bits is what actually causes
+     the hardware to generate the exception, if the corresponding enable
+     bit is set as well.  */
+
+  cw |= (excepts &= FE_ALL_EXCEPT);
+
+  /* Set new state.  */
+  _FPU_SETCW (cw);
+
+  return 0;
+}
+libm_hidden_def (__feraiseexcept)
+weak_alias (__feraiseexcept, feraiseexcept)
+libm_hidden_weak (feraiseexcept)
diff --git a/sysdeps/or1k/fpu/fsetexcptflg.c b/sysdeps/or1k/fpu/fsetexcptflg.c
new file mode 100644
index 0000000000..641eba2a0e
--- /dev/null
+++ b/sysdeps/or1k/fpu/fsetexcptflg.c
@@ -0,0 +1,40 @@
+/* Set floating-point environment exception handling.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fesetexceptflag (const fexcept_t *flagp, int excepts)
+{
+  fpu_control_t temp;
+
+  /* Get the current exceptions.  */
+  _FPU_GETCW (temp);
+
+  /* Make sure the flags we want restored are legal.  */
+  excepts &= FE_ALL_EXCEPT;
+
+  /* Now clear the bits called for, and copy them in from flagp. Note that
+     we ignore all non-flag bits from *flagp, so they don't matter.  */
+  temp = (temp & ~excepts) | (*flagp & excepts);
+
+  _FPU_SETCW (temp);
+
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/ftestexcept.c b/sysdeps/or1k/fpu/ftestexcept.c
new file mode 100644
index 0000000000..8a7f1d1320
--- /dev/null
+++ b/sysdeps/or1k/fpu/ftestexcept.c
@@ -0,0 +1,32 @@
+/* Test exception in current environment.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+fetestexcept (int excepts)
+{
+  fpu_control_t cw;
+
+  /* Get current control word.  */
+  _FPU_GETCW (cw);
+
+  return cw & (excepts & FE_ALL_EXCEPT);
+}
+libm_hidden_def (fetestexcept)
diff --git a/sysdeps/or1k/fpu/get-rounding-mode.h b/sysdeps/or1k/fpu/get-rounding-mode.h
new file mode 100644
index 0000000000..3ad5216f38
--- /dev/null
+++ b/sysdeps/or1k/fpu/get-rounding-mode.h
@@ -0,0 +1,38 @@
+/* Determine floating-point rounding mode within libc.  OpenRISC version.
+
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _OR1K_GET_ROUNDING_MODE_H
+#define _OR1K_GET_ROUNDING_MODE_H	1
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+/* Return the floating-point rounding mode.  */
+
+static inline int
+get_rounding_mode (void)
+{
+  fpu_control_t cw;
+
+  _FPU_GETCW (cw);
+  return cw & (0x3 << 1);
+}
+
+#endif /* get-rounding-mode.h */
diff --git a/sysdeps/or1k/fpu_control.h b/sysdeps/or1k/fpu_control.h
new file mode 100644
index 0000000000..10d1e7b2d7
--- /dev/null
+++ b/sysdeps/or1k/fpu_control.h
@@ -0,0 +1,49 @@
+/* FPU control word bits.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _FPU_CONTROL_H
+#define _FPU_CONTROL_H
+
+#if !defined(__or1k_hard_float__)
+
+# define _FPU_RESERVED 0xffffffff
+# define _FPU_DEFAULT  0x00000000
+typedef unsigned int fpu_control_t;
+# define _FPU_GETCW(cw) (cw) = 0
+# define _FPU_SETCW(cw) (void) (cw)
+extern fpu_control_t __fpu_control;
+
+#else /* __or1k_hard_float__ */
+
+# define _FPU_RESERVED 0xfffff000
+# define _FPU_DEFAULT  0
+# define _FPU_IEEE     _FPU_DEFAULT
+
+/* Type of the control word.  */
+typedef unsigned int fpu_control_t;
+
+/* Macros for accessing the hardware control word.  */
+# define _FPU_GETCW(cw) __asm__ volatile ("l.mfspr %0,r0,20" : "=r" (cw))
+# define _FPU_SETCW(cw) __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (cw))
+
+/* Default control word set at startup.  */
+extern fpu_control_t __fpu_control;
+
+#endif
+
+#endif	/* fpu_control.h */
diff --git a/sysdeps/or1k/jmpbuf-offsets.h b/sysdeps/or1k/jmpbuf-offsets.h
new file mode 100644
index 0000000000..54dabe122e
--- /dev/null
+++ b/sysdeps/or1k/jmpbuf-offsets.h
@@ -0,0 +1,23 @@
+/* Private macros for accessing __jmp_buf contents.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define __JMP_BUF_SP    0
+
+/* Helper for generic ____longjmp_chk(). */
+#define JB_FRAME_ADDRESS(buf) \
+    ((void *) (unsigned long) (buf[__JMP_BUF_SP]))
diff --git a/sysdeps/or1k/jmpbuf-unwind.h b/sysdeps/or1k/jmpbuf-unwind.h
new file mode 100644
index 0000000000..1a2428f840
--- /dev/null
+++ b/sysdeps/or1k/jmpbuf-unwind.h
@@ -0,0 +1,35 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <setjmp.h>
+#include <jmpbuf-offsets.h>
+#include <stdint.h>
+#include <unwind.h>
+
+/* Test if longjmp to JMPBUF would unwind the frame
+   containing a local variable at ADDRESS.  */
+#define _JMPBUF_UNWINDS(jmpbuf, address, demangle) \
+  ((void *) (address) < (void *) demangle (jmpbuf[__JMP_BUF_SP]))
+
+#define _JMPBUF_CFA_UNWINDS_ADJ(_jmpbuf, _context, _adj) \
+  _JMPBUF_UNWINDS_ADJ (_jmpbuf, (void *) _Unwind_GetCFA (_context), _adj)
+
+#define _JMPBUF_UNWINDS_ADJ(_jmpbuf, _address, _adj) \
+  ((uintptr_t) (_address) - (_adj) < (uintptr_t) (_jmpbuf)[__JMP_BUF_SP] - (_adj))
+
+/* We use the normal longjmp for unwinding.  */
+#define __libc_unwind_longjmp(buf, val) __libc_longjmp (buf, val)
diff --git a/sysdeps/or1k/ldsodefs.h b/sysdeps/or1k/ldsodefs.h
new file mode 100644
index 0000000000..7b0323429f
--- /dev/null
+++ b/sysdeps/or1k/ldsodefs.h
@@ -0,0 +1,40 @@
+/* Run-time dynamic linker data structures for loaded ELF shared objects.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef	_SH_LDSODEFS_H
+#define	_SH_LDSODEFS_H	1
+
+#include <elf.h>
+
+struct La_or1k_regs;
+struct La_or1k_retval;
+
+#define ARCH_PLTENTER_MEMBERS						\
+    uintptr_t (*or1k_gnu_pltenter) (Elf32_Sym *, unsigned int, uintptr_t *, \
+				  uintptr_t *, struct La_or1k_regs *, \
+				  unsigned int *, const char *name,	\
+				  long int *framesizep)
+
+#define ARCH_PLTEXIT_MEMBERS						\
+    unsigned int (*or1k_gnu_pltexit) (Elf32_Sym *, unsigned int, uintptr_t *, \
+				    uintptr_t *, const struct La_or1k_regs *, \
+				    struct La_or1k_retval *, const char *)
+
+#include_next <ldsodefs.h>
+
+#endif
diff --git a/sysdeps/or1k/libc-tls.c b/sysdeps/or1k/libc-tls.c
new file mode 100644
index 0000000000..b0a278c640
--- /dev/null
+++ b/sysdeps/or1k/libc-tls.c
@@ -0,0 +1,32 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public License as
+   published by the Free Software Foundation; either version 2.1 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <csu/libc-tls.c>
+#include <dl-tls.h>
+
+/* On OpenRISC, linker optimizations are not required, so __tls_get_addr
+   can be called even in statically linked binaries.  In this case module
+   must be always 1 and PT_TLS segment exist in the binary, otherwise it
+   would not link.  */
+
+void *
+__tls_get_addr (tls_index *ti)
+{
+  dtv_t *dtv = THREAD_DTV ();
+  return (char *) dtv[1].pointer.val + ti->ti_offset;
+}
diff --git a/sysdeps/or1k/libm-test-ulps b/sysdeps/or1k/libm-test-ulps
new file mode 100644
index 0000000000..883e75bb03
--- /dev/null
+++ b/sysdeps/or1k/libm-test-ulps
@@ -0,0 +1,1107 @@
+# Begin of automatic generation
+
+# Maximal error of functions:
+Function: "acos":
+float: 1
+
+Function: "acos_downward":
+double: 1
+float: 1
+
+Function: "acos_towardzero":
+double: 1
+float: 1
+
+Function: "acos_upward":
+double: 1
+float: 1
+
+Function: "acosh":
+double: 2
+float: 2
+
+Function: "acosh_downward":
+double: 2
+float: 2
+
+Function: "acosh_towardzero":
+double: 2
+float: 2
+
+Function: "acosh_upward":
+double: 2
+float: 2
+
+Function: "asin":
+float: 1
+
+Function: "asin_downward":
+double: 1
+float: 1
+
+Function: "asin_towardzero":
+double: 1
+float: 1
+
+Function: "asin_upward":
+double: 1
+float: 1
+
+Function: "asinh":
+double: 1
+float: 2
+
+Function: "asinh_downward":
+double: 3
+float: 3
+
+Function: "asinh_towardzero":
+double: 2
+float: 2
+
+Function: "asinh_upward":
+double: 3
+float: 3
+
+Function: "atan":
+float: 1
+
+Function: "atan2":
+float: 1
+
+Function: "atan2_downward":
+double: 5
+float: 2
+
+Function: "atan2_towardzero":
+double: 5
+float: 2
+
+Function: "atan2_upward":
+double: 8
+float: 2
+
+Function: "atan_downward":
+double: 1
+float: 2
+
+Function: "atan_towardzero":
+double: 1
+float: 1
+
+Function: "atan_upward":
+double: 1
+float: 2
+
+Function: "atanh":
+double: 2
+float: 2
+
+Function: "atanh_downward":
+double: 3
+float: 3
+
+Function: "atanh_towardzero":
+double: 2
+float: 2
+
+Function: "atanh_upward":
+double: 3
+float: 3
+
+Function: "cabs":
+double: 1
+
+Function: "cabs_downward":
+double: 1
+
+Function: "cabs_towardzero":
+double: 1
+
+Function: "cabs_upward":
+double: 1
+
+Function: Real part of "cacos":
+double: 1
+float: 2
+
+Function: Imaginary part of "cacos":
+double: 2
+float: 2
+
+Function: Real part of "cacos_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_downward":
+double: 5
+float: 3
+
+Function: Real part of "cacos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "cacos_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacos_upward":
+double: 5
+float: 7
+
+Function: Real part of "cacosh":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacosh":
+double: 1
+float: 2
+
+Function: Real part of "cacosh_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "cacosh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "cacosh_upward":
+double: 4
+float: 3
+
+Function: Imaginary part of "cacosh_upward":
+double: 3
+float: 2
+
+Function: "carg":
+float: 1
+
+Function: "carg_downward":
+double: 5
+float: 2
+
+Function: "carg_towardzero":
+double: 5
+float: 2
+
+Function: "carg_upward":
+double: 8
+float: 2
+
+Function: Real part of "casin":
+double: 1
+float: 1
+
+Function: Imaginary part of "casin":
+double: 2
+float: 2
+
+Function: Real part of "casin_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_downward":
+double: 5
+float: 3
+
+Function: Real part of "casin_towardzero":
+double: 3
+float: 1
+
+Function: Imaginary part of "casin_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "casin_upward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_upward":
+double: 5
+float: 7
+
+Function: Real part of "casinh":
+double: 2
+float: 2
+
+Function: Imaginary part of "casinh":
+double: 1
+float: 1
+
+Function: Real part of "casinh_downward":
+double: 5
+float: 3
+
+Function: Imaginary part of "casinh_downward":
+double: 3
+float: 2
+
+Function: Real part of "casinh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "casinh_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "casinh_upward":
+double: 5
+float: 7
+
+Function: Imaginary part of "casinh_upward":
+double: 3
+float: 2
+
+Function: Real part of "catan":
+double: 1
+float: 1
+
+Function: Imaginary part of "catan":
+double: 1
+float: 1
+
+Function: Real part of "catan_downward":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_downward":
+double: 2
+float: 2
+
+Function: Real part of "catan_towardzero":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "catan_upward":
+double: 2
+float: 1
+
+Function: Imaginary part of "catan_upward":
+double: 2
+float: 2
+
+Function: Real part of "catanh":
+double: 1
+float: 1
+
+Function: Imaginary part of "catanh":
+double: 1
+float: 1
+
+Function: Real part of "catanh_downward":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_downward":
+double: 1
+float: 2
+
+Function: Real part of "catanh_towardzero":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_towardzero":
+double: 1
+float: 2
+
+Function: Real part of "catanh_upward":
+double: 4
+float: 4
+
+Function: Imaginary part of "catanh_upward":
+double: 2
+float: 1
+
+Function: "cbrt":
+double: 3
+float: 1
+
+Function: "cbrt_downward":
+double: 4
+float: 1
+
+Function: "cbrt_towardzero":
+double: 3
+float: 1
+
+Function: "cbrt_upward":
+double: 5
+float: 1
+
+Function: Real part of "ccos":
+double: 1
+float: 1
+
+Function: Imaginary part of "ccos":
+double: 1
+float: 1
+
+Function: Real part of "ccos_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "ccos_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccos_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccos_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccos_upward":
+double: 2
+float: 2
+
+Function: Real part of "ccosh":
+double: 1
+float: 1
+
+Function: Imaginary part of "ccosh":
+double: 1
+float: 1
+
+Function: Real part of "ccosh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cexp":
+double: 2
+float: 1
+
+Function: Imaginary part of "cexp":
+double: 1
+float: 2
+
+Function: Real part of "cexp_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_downward":
+double: 3
+float: 3
+
+Function: Real part of "cexp_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "cexp_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cexp_upward":
+double: 3
+float: 2
+
+Function: Real part of "clog":
+double: 3
+float: 3
+
+Function: Imaginary part of "clog":
+float: 1
+
+Function: Real part of "clog10":
+double: 3
+float: 4
+
+Function: Imaginary part of "clog10":
+double: 2
+float: 2
+
+Function: Real part of "clog10_downward":
+double: 7
+float: 5
+
+Function: Imaginary part of "clog10_downward":
+double: 8
+float: 4
+
+Function: Real part of "clog10_towardzero":
+double: 5
+float: 5
+
+Function: Imaginary part of "clog10_towardzero":
+double: 8
+float: 4
+
+Function: Real part of "clog10_upward":
+double: 6
+float: 5
+
+Function: Imaginary part of "clog10_upward":
+double: 5
+float: 4
+
+Function: Real part of "clog_downward":
+double: 4
+float: 3
+
+Function: Imaginary part of "clog_downward":
+double: 5
+float: 2
+
+Function: Real part of "clog_towardzero":
+double: 8
+float: 4
+
+Function: Imaginary part of "clog_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "clog_upward":
+double: 8
+float: 3
+
+Function: Imaginary part of "clog_upward":
+double: 8
+float: 2
+
+Function: "cos":
+double: 1
+float: 1
+
+Function: "cos_downward":
+double: 1
+float: 1
+
+Function: "cos_towardzero":
+double: 4
+float: 1
+
+Function: "cos_upward":
+double: 4
+float: 1
+
+Function: "cosh":
+double: 1
+float: 2
+
+Function: "cosh_downward":
+double: 2
+float: 1
+
+Function: "cosh_towardzero":
+double: 2
+float: 1
+
+Function: "cosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cpow":
+double: 2
+float: 5
+
+Function: Imaginary part of "cpow":
+float: 2
+
+Function: Real part of "cpow_downward":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_downward":
+double: 2
+float: 2
+
+Function: Real part of "cpow_towardzero":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "cpow_upward":
+double: 4
+float: 1
+
+Function: Imaginary part of "cpow_upward":
+double: 2
+float: 2
+
+Function: Real part of "csin":
+double: 1
+float: 1
+
+Function: Real part of "csin_downward":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_downward":
+double: 3
+float: 1
+
+Function: Real part of "csin_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "csin_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "csin_upward":
+double: 1
+float: 2
+
+Function: Real part of "csinh":
+float: 1
+
+Function: Imaginary part of "csinh":
+double: 1
+float: 1
+
+Function: Real part of "csinh_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "csinh_downward":
+double: 3
+float: 3
+
+Function: Real part of "csinh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "csinh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "csinh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "csinh_upward":
+double: 2
+float: 2
+
+Function: Real part of "csqrt":
+double: 2
+float: 2
+
+Function: Imaginary part of "csqrt":
+double: 2
+float: 2
+
+Function: Real part of "csqrt_downward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_downward":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Imaginary part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_upward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_upward":
+double: 3
+float: 3
+
+Function: Real part of "ctan":
+double: 1
+float: 1
+
+Function: Imaginary part of "ctan":
+double: 2
+float: 2
+
+Function: Real part of "ctan_downward":
+double: 6
+float: 5
+
+Function: Imaginary part of "ctan_downward":
+double: 3
+float: 2
+
+Function: Real part of "ctan_towardzero":
+double: 5
+float: 3
+
+Function: Imaginary part of "ctan_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "ctan_upward":
+double: 2
+float: 4
+
+Function: Imaginary part of "ctan_upward":
+double: 2
+float: 1
+
+Function: Real part of "ctanh":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh":
+double: 2
+float: 2
+
+Function: Real part of "ctanh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_downward":
+double: 6
+float: 5
+
+Function: Real part of "ctanh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "ctanh_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh_upward":
+double: 2
+float: 3
+
+Function: "erf":
+double: 1
+float: 1
+
+Function: "erf_downward":
+double: 1
+float: 1
+
+Function: "erf_towardzero":
+double: 1
+float: 1
+
+Function: "erf_upward":
+double: 1
+float: 1
+
+Function: "erfc":
+double: 3
+float: 3
+
+Function: "erfc_downward":
+double: 5
+float: 6
+
+Function: "erfc_towardzero":
+double: 3
+float: 4
+
+Function: "erfc_upward":
+double: 5
+float: 6
+
+Function: "exp":
+float: 1
+
+Function: "exp10":
+double: 2
+float: 1
+
+Function: "exp10_downward":
+double: 3
+
+Function: "exp10_towardzero":
+double: 3
+
+Function: "exp10_upward":
+double: 2
+float: 1
+
+Function: "exp2":
+double: 1
+
+Function: "exp2_downward":
+double: 1
+
+Function: "exp2_towardzero":
+double: 1
+
+Function: "exp2_upward":
+double: 1
+float: 1
+
+Function: "exp_downward":
+double: 1
+float: 1
+
+Function: "exp_towardzero":
+double: 1
+float: 1
+
+Function: "exp_upward":
+double: 1
+float: 1
+
+Function: "expm1":
+double: 1
+float: 1
+
+Function: "expm1_downward":
+double: 1
+float: 1
+
+Function: "expm1_towardzero":
+double: 1
+float: 2
+
+Function: "expm1_upward":
+double: 1
+float: 1
+
+Function: "gamma":
+double: 4
+float: 7
+
+Function: "gamma_downward":
+double: 7
+float: 7
+
+Function: "gamma_towardzero":
+double: 7
+float: 7
+
+Function: "gamma_upward":
+double: 5
+float: 6
+
+Function: "hypot":
+double: 1
+
+Function: "hypot_downward":
+double: 1
+
+Function: "hypot_towardzero":
+double: 1
+
+Function: "hypot_upward":
+double: 1
+
+Function: "j0":
+double: 2
+float: 8
+
+Function: "j0_downward":
+double: 2
+float: 4
+
+Function: "j0_towardzero":
+double: 4
+float: 5
+
+Function: "j0_upward":
+double: 4
+float: 5
+
+Function: "j1":
+double: 2
+float: 9
+
+Function: "j1_downward":
+double: 4
+float: 5
+
+Function: "j1_towardzero":
+double: 4
+float: 2
+
+Function: "j1_upward":
+double: 3
+float: 5
+
+Function: "jn":
+double: 4
+float: 4
+
+Function: "jn_downward":
+double: 7
+float: 9
+
+Function: "jn_towardzero":
+double: 7
+float: 9
+
+Function: "jn_upward":
+double: 7
+float: 9
+
+Function: "lgamma":
+double: 4
+float: 7
+
+Function: "lgamma_downward":
+double: 7
+float: 7
+
+Function: "lgamma_towardzero":
+double: 7
+float: 7
+
+Function: "lgamma_upward":
+double: 5
+float: 6
+
+Function: "log10":
+double: 2
+float: 2
+
+Function: "log10_downward":
+double: 2
+float: 3
+
+Function: "log10_towardzero":
+double: 2
+float: 1
+
+Function: "log10_upward":
+double: 2
+float: 2
+
+Function: "log1p":
+double: 1
+float: 1
+
+Function: "log1p_downward":
+double: 2
+float: 2
+
+Function: "log1p_towardzero":
+double: 2
+float: 2
+
+Function: "log1p_upward":
+double: 2
+float: 2
+
+Function: "log2":
+float: 1
+
+Function: "log2_downward":
+double: 1
+
+Function: "log2_towardzero":
+double: 1
+
+Function: "log2_upward":
+double: 1
+
+Function: "pow":
+double: 1
+
+Function: "pow_downward":
+double: 1
+float: 1
+
+Function: "pow_towardzero":
+double: 1
+float: 1
+
+Function: "pow_upward":
+double: 1
+float: 1
+
+Function: "sin":
+double: 1
+float: 1
+
+Function: "sin_downward":
+double: 4
+float: 1
+
+Function: "sin_towardzero":
+double: 3
+float: 1
+
+Function: "sin_upward":
+double: 7
+float: 1
+
+Function: "sincos":
+double: 1
+
+Function: "sincos_downward":
+double: 1
+float: 1
+
+Function: "sincos_towardzero":
+double: 4
+float: 1
+
+Function: "sincos_upward":
+double: 1
+float: 1
+
+Function: "sinh":
+double: 2
+float: 2
+
+Function: "sinh_downward":
+double: 3
+float: 3
+
+Function: "sinh_towardzero":
+double: 2
+float: 2
+
+Function: "sinh_upward":
+double: 3
+float: 3
+
+Function: "tan":
+float: 1
+
+Function: "tan_downward":
+double: 1
+float: 2
+
+Function: "tan_towardzero":
+double: 1
+float: 1
+
+Function: "tan_upward":
+double: 1
+float: 1
+
+Function: "tanh":
+double: 2
+float: 2
+
+Function: "tanh_downward":
+double: 3
+float: 3
+
+Function: "tanh_towardzero":
+double: 2
+float: 2
+
+Function: "tanh_upward":
+double: 3
+float: 3
+
+Function: "tgamma":
+double: 5
+float: 8
+
+Function: "tgamma_downward":
+double: 9
+float: 9
+
+Function: "tgamma_towardzero":
+double: 9
+float: 8
+
+Function: "tgamma_upward":
+double: 9
+float: 8
+
+Function: "y0":
+double: 3
+float: 8
+
+Function: "y0_downward":
+double: 3
+float: 6
+
+Function: "y0_towardzero":
+double: 3
+float: 3
+
+Function: "y0_upward":
+double: 3
+float: 6
+
+Function: "y1":
+double: 3
+float: 2
+
+Function: "y1_downward":
+double: 6
+float: 7
+
+Function: "y1_towardzero":
+double: 3
+float: 3
+
+Function: "y1_upward":
+double: 7
+float: 5
+
+Function: "yn":
+double: 3
+float: 3
+
+Function: "yn_downward":
+double: 6
+float: 8
+
+Function: "yn_towardzero":
+double: 8
+float: 8
+
+Function: "yn_upward":
+double: 8
+float: 8
+
+# end of automatic generation
diff --git a/sysdeps/or1k/libm-test-ulps-name b/sysdeps/or1k/libm-test-ulps-name
new file mode 100644
index 0000000000..0af6591fd9
--- /dev/null
+++ b/sysdeps/or1k/libm-test-ulps-name
@@ -0,0 +1 @@
+OpenRISC
diff --git a/sysdeps/or1k/machine-gmon.h b/sysdeps/or1k/machine-gmon.h
new file mode 100644
index 0000000000..abc1d097d5
--- /dev/null
+++ b/sysdeps/or1k/machine-gmon.h
@@ -0,0 +1,24 @@
+/* Profiling support.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+/* Accept 'frompc' address as argument from the function that calls
+   _mcount for profiling.  Use  __builtin_return_address (0)
+   for the 'selfpc' address.  */
+
+#include <sysdep.h>
+#include <sysdeps/generic/machine-gmon.h>
diff --git a/sysdeps/or1k/math-tests-trap.h b/sysdeps/or1k/math-tests-trap.h
new file mode 100644
index 0000000000..882479be30
--- /dev/null
+++ b/sysdeps/or1k/math-tests-trap.h
@@ -0,0 +1,27 @@
+/* Configuration for math tests: support for enabling exception traps.
+   OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_MATH_TESTS_TRAP_H
+#define OR1K_MATH_TESTS_TRAP_H 1
+
+#include <fenv.h>
+
+#define EXCEPTION_ENABLE_SUPPORTED(EXCEPT)	((EXCEPT) == 0)
+
+#endif /* math-tests-trap.h.  */
diff --git a/sysdeps/or1k/memusage.h b/sysdeps/or1k/memusage.h
new file mode 100644
index 0000000000..cdd33c1b7c
--- /dev/null
+++ b/sysdeps/or1k/memusage.h
@@ -0,0 +1,20 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define GETSP() ({ register uintptr_t stack_ptr asm ("r1"); stack_ptr; })
+
+#include <sysdeps/generic/memusage.h>
diff --git a/sysdeps/or1k/nofpu/Implies b/sysdeps/or1k/nofpu/Implies
new file mode 100644
index 0000000000..abcbadb25f
--- /dev/null
+++ b/sysdeps/or1k/nofpu/Implies
@@ -0,0 +1 @@
+ieee754/soft-fp
diff --git a/sysdeps/or1k/nofpu/math-tests-exceptions.h b/sysdeps/or1k/nofpu/math-tests-exceptions.h
new file mode 100644
index 0000000000..2aea76d73d
--- /dev/null
+++ b/sysdeps/or1k/nofpu/math-tests-exceptions.h
@@ -0,0 +1,29 @@
+/* Configuration for math tests: support for exceptions.  OpenRISC no-FPU
+   version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_NOFPU_MATH_TESTS_EXCEPTIONS_H
+#define OR1K_NOFPU_MATH_TESTS_EXCEPTIONS_H 1
+
+/* We support setting floating-point exception flags on hard-float
+   targets.  These are not supported on soft-float targets.  */
+#define EXCEPTION_TESTS_float 0
+#define EXCEPTION_TESTS_double        0
+#define EXCEPTION_TESTS_long_double   0
+
+#endif /* math-tests-exceptions.h.  */
diff --git a/sysdeps/or1k/nofpu/math-tests-rounding.h b/sysdeps/or1k/nofpu/math-tests-rounding.h
new file mode 100644
index 0000000000..ab90ee3cda
--- /dev/null
+++ b/sysdeps/or1k/nofpu/math-tests-rounding.h
@@ -0,0 +1,28 @@
+/* Configuration for math tests: rounding mode support.  OpenRISC no-FPU
+   version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_NOFPU_MATH_TESTS_ROUNDING_H
+#define OR1K_NOFPU_MATH_TESTS_ROUNDING_H 1
+
+/* On soft-float targets we only support the "to nearest" rounding mode.  */
+#define ROUNDING_TESTS_float(MODE)		((MODE) == FE_TONEAREST)
+#define ROUNDING_TESTS_double(MODE)		((MODE) == FE_TONEAREST)
+#define ROUNDING_TESTS_long_double(MODE)	((MODE) == FE_TONEAREST)
+
+#endif /* math-tests-rounding.h.  */
diff --git a/sysdeps/or1k/nptl/Makefile b/sysdeps/or1k/nptl/Makefile
new file mode 100644
index 0000000000..f5828b7ec8
--- /dev/null
+++ b/sysdeps/or1k/nptl/Makefile
@@ -0,0 +1,21 @@
+# Copyright (C) 2020 Free Software Foundation, Inc.
+#
+# This file is part of the GNU C Library.
+#
+# The GNU C Library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# The GNU C Library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with the GNU C Library.  If not, see
+# <https://www.gnu.org/licenses/>.
+
+ifeq ($(subdir),csu)
+gen-as-const-headers += tcb-offsets.sym
+endif
diff --git a/sysdeps/or1k/nptl/bits/pthreadtypes-arch.h b/sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
new file mode 100644
index 0000000000..f3cf63b472
--- /dev/null
+++ b/sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
@@ -0,0 +1,48 @@
+/* Machine-specific pthread type layouts.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _BITS_PTHREADTYPES_H
+#define _BITS_PTHREADTYPES_H	1
+
+#include <bits/wordsize.h>
+
+/* Opaque union sizes for:
+     pthread_attr_t - internally pthread_attr
+     pthread_mutex_t - internally __pthread_mutex_s
+     pthread_mutexattr_t - internally pthread_mutexattr
+     pthread_cond_t - internally __pthread_cond_s
+     pthread_condattr_t - internally pthread_condattr
+     pthread_rwlock_t - internally __pthread_rwlock_arch_t
+     pthread_rwlockattr_t - internally pthread_rwlockattr
+     pthread_barrier_t - internally pthread_barrier
+     pthread_barrierattr_t - internally pthread_barrierattr  */
+
+#define __SIZEOF_PTHREAD_ATTR_T 32
+#define __SIZEOF_PTHREAD_MUTEX_T 32
+#define __SIZEOF_PTHREAD_MUTEXATTR_T 4
+#define __SIZEOF_PTHREAD_COND_T 48
+#define __SIZEOF_PTHREAD_CONDATTR_T 4
+#define __SIZEOF_PTHREAD_RWLOCK_T 44
+#define __SIZEOF_PTHREAD_RWLOCKATTR_T 8
+#define __SIZEOF_PTHREAD_BARRIER_T 20
+#define __SIZEOF_PTHREAD_BARRIERATTR_T 4
+
+#define __LOCK_ALIGNMENT
+#define __ONCE_ALIGNMENT
+
+#endif	/* bits/pthreadtypes.h */
diff --git a/sysdeps/or1k/nptl/bits/semaphore.h b/sysdeps/or1k/nptl/bits/semaphore.h
new file mode 100644
index 0000000000..473594fcfc
--- /dev/null
+++ b/sysdeps/or1k/nptl/bits/semaphore.h
@@ -0,0 +1,34 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SEMAPHORE_H
+# error "Never use <bits/semaphore.h> directly; include <semaphore.h> instead."
+#endif
+
+
+#define __SIZEOF_SEM_T	16
+
+
+/* Value returned if `sem_open' failed.  */
+#define SEM_FAILED      ((sem_t *) 0)
+
+
+typedef union
+{
+  char __size[__SIZEOF_SEM_T];
+  long int __align;
+} sem_t;
diff --git a/sysdeps/or1k/nptl/pthreaddef.h b/sysdeps/or1k/nptl/pthreaddef.h
new file mode 100644
index 0000000000..b0c48371f0
--- /dev/null
+++ b/sysdeps/or1k/nptl/pthreaddef.h
@@ -0,0 +1,32 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public License as
+   published by the Free Software Foundation; either version 2.1 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+/* Default stack size.  */
+#define ARCH_STACK_DEFAULT_SIZE (2 * 1024 * 1024)
+
+/* Required stack pointer alignment at beginning.  */
+#define STACK_ALIGN 16
+
+/* Minimal stack size after allocating thread descriptor and guard size.  */
+#define MINIMAL_REST_STACK 2048
+
+/* Alignment requirement for TCB.  Needs to be >= to STACK_ALIGN.  */
+#define TCB_ALIGNMENT 16
+
+/* Location of current stack frame.  */
+#define CURRENT_STACK_FRAME __builtin_frame_address (0)
diff --git a/sysdeps/or1k/nptl/tcb-offsets.sym b/sysdeps/or1k/nptl/tcb-offsets.sym
new file mode 100644
index 0000000000..86025a402d
--- /dev/null
+++ b/sysdeps/or1k/nptl/tcb-offsets.sym
@@ -0,0 +1,6 @@
+#include <sysdep.h>
+#include <tls.h>
+
+MULTIPLE_THREADS_OFFSET         offsetof (struct pthread, header.multiple_threads)
+TID_OFFSET                      offsetof (struct pthread, tid)
+TP_TO_PTHREAD_OFFSET            -(sizeof (struct pthread) + sizeof (tcbhead_t))
diff --git a/sysdeps/or1k/nptl/tls.h b/sysdeps/or1k/nptl/tls.h
new file mode 100644
index 0000000000..f241f5f097
--- /dev/null
+++ b/sysdeps/or1k/nptl/tls.h
@@ -0,0 +1,193 @@
+/* Definition for thread-local data handling.  NPTL/OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _TLS_H
+#define _TLS_H  1
+
+#include <dl-sysdep.h>
+
+#ifndef __ASSEMBLER__
+# include <stdbool.h>
+# include <stddef.h>
+# include <stdint.h>
+# include <dl-dtv.h>
+
+typedef struct
+{
+  dtv_t *dtv;
+  void *__padding[3]; /* To maintain 16 byte padding, needed by STACK_ALIGN.  */
+} tcbhead_t;
+
+register tcbhead_t *__thread_self __asm__("r10");
+
+# define TLS_MULTIPLE_THREADS_IN_TCB 1
+
+#else /* __ASSEMBLER__ */
+# include <tcb-offsets.h>
+#endif /* __ASSEMBLER__ */
+
+#ifndef __ASSEMBLER__
+
+/* Get system call information.  */
+# include <sysdep.h>
+
+/* The TP points to the start of the TLS block.
+   As I understand it, this isn't strictly that "TP points to DTV" - it's
+   more where to place the TCB in the TLS block. This will place it in 
+   the beginning.
+
+   Layout:
+    ------------------------------------
+    | PRE | TCB | TLS MEMORY ..        |
+   ------------------------------------
+                 ^ r10 / TP
+
+   PRE is the struct pthread described below
+   TCB is tcbhead_t
+   TLS memory is where the TLS program sections are loaded
+
+   See _dl_allocate_tls_storage and __libc_setup_tls for more information.  */
+
+# define TLS_DTV_AT_TP  1
+# define TLS_TCB_AT_TP  0
+
+/* Get the thread descriptor definition.  */
+# include <nptl/descr.h>
+
+/* Requirements for the TCB.  */
+# define TLS_INIT_TCB_SIZE    sizeof (tcbhead_t)
+# define TLS_INIT_TCB_ALIGN   __alignof__ (struct pthread)
+
+# define TLS_TCB_SIZE         sizeof (tcbhead_t)
+# define TLS_TCB_ALIGN        __alignof__ (struct pthread)
+
+/* This is the size of the TCB.  */
+
+/* This is the size we need before TCB.
+   To support THREAD_GETMEM with friends we want to have a
+   struct pthread available.
+   Yank it in infront of everything, I'm sure nobody will mind.
+
+   This memory is really allocated PRE the TLS block, so it's possible
+   to do ((char*)tlsblock) - TLS_PRE_TCB_SIZE to access it.
+   This is done for THREAD_SELF.  */
+
+# define TLS_PRE_TCB_SIZE sizeof (struct pthread)
+
+
+/* Install the dtv pointer.
+   When called, dtvp is a pointer not the DTV per say (which should start
+   with the generation counter) but to the length of the DTV.
+   We can always index with -1, so we store dtvp[1].  */
+
+# define INSTALL_DTV(tcbp, dtvp) \
+  (((tcbhead_t *) (tcbp))->dtv = (dtvp) + 1)
+
+/* Install new dtv for current thread
+   In a logicial world dtv here would also point to the length of the DTV.
+   However it does not, this time it points to the generation counter,
+   so just store it.
+
+   Note: -1 is still valid and contains the length.  */
+
+# define INSTALL_NEW_DTV(dtv) (THREAD_DTV() = (dtv))
+
+/* Return dtv of given thread descriptor.  */
+# define GET_DTV(tcbp) (((tcbhead_t *) (tcbp))->dtv)
+
+/* Code to initially initialize the thread pointer.
+
+   Set TP to the address _after_ tcbhead_t. This will allow us
+   to change the size of tcbhead_t without having to re-link everything.
+
+   This has to return NULL on success (or a string with the failure text).
+   It's hard to fail this, so return NULL always.  */
+
+# define TLS_INIT_TP(tcbp) \
+  ({__thread_self = ((tcbhead_t *)tcbp + 1); NULL;})
+
+/* Value passed to 'clone' for initialization of the thread register.  */
+# define TLS_DEFINE_INIT_TP(tp, pd) \
+  void *tp = ((char *) pd + TLS_PRE_TCB_SIZE + TLS_INIT_TCB_SIZE)
+
+/* Return the address of the dtv for the current thread.
+
+   Dereference TP, offset to dtv - really straightforward.
+   Remember that we made TP point to after tcb, so we need to reverse that.  */
+
+#  define THREAD_DTV() \
+  ((((tcbhead_t *)__thread_self)-1)->dtv)
+
+/* Return the thread descriptor for the current thread.
+
+   Return a pointer to the TLS_PRE area where we allocated space for
+   a struct pthread. Again, TP points to after tcbhead_t, compensate with
+   TLS_INIT_TCB_SIZE.
+
+   I regard this is a seperate system from the "normal" TLS.  */
+
+# define THREAD_SELF \
+  ((struct pthread *) ((char *) __thread_self - TLS_INIT_TCB_SIZE \
+    - TLS_PRE_TCB_SIZE))
+
+/* Magic for libthread_db to know how to do THREAD_SELF.  */
+
+# define DB_THREAD_SELF \
+  CONST_THREAD_AREA (32, sizeof (struct pthread))
+
+/* Access to data in the thread descriptor is easy.  */
+
+#define THREAD_GETMEM(descr, member) \
+  descr->member
+#define THREAD_GETMEM_NC(descr, member, idx) \
+  descr->member[idx]
+#define THREAD_SETMEM(descr, member, value) \
+  descr->member = (value)
+#define THREAD_SETMEM_NC(descr, member, idx, value) \
+  descr->member[idx] = (value)
+
+/* Get and set the global scope generation counter in struct pthread.  */
+
+#define THREAD_GSCOPE_IN_TCB      1
+#define THREAD_GSCOPE_FLAG_UNUSED 0
+#define THREAD_GSCOPE_FLAG_USED   1
+#define THREAD_GSCOPE_FLAG_WAIT   2
+#define THREAD_GSCOPE_RESET_FLAG()					\
+  do									\
+    {									\
+      int __res = atomic_exchange_rel (&THREAD_SELF->header.gscope_flag,\
+				       THREAD_GSCOPE_FLAG_UNUSED);	\
+      if (__res == THREAD_GSCOPE_FLAG_WAIT)				\
+	  lll_futex_wake (&THREAD_SELF->header.gscope_flag, 1,		\
+			  LLL_PRIVATE);					\
+    }									\
+  while (0)
+#define THREAD_GSCOPE_SET_FLAG()					\
+  do									\
+    {									\
+      THREAD_SELF->header.gscope_flag = THREAD_GSCOPE_FLAG_USED;	\
+      atomic_write_barrier ();						\
+    }									\
+  while (0)
+#define THREAD_GSCOPE_WAIT() \
+  GL(dl_wait_lookup_done) ()
+
+#endif /* __ASSEMBLER__ */
+
+#endif  /* tls.h */
+
diff --git a/sysdeps/or1k/preconfigure b/sysdeps/or1k/preconfigure
new file mode 100644
index 0000000000..a253d14d52
--- /dev/null
+++ b/sysdeps/or1k/preconfigure
@@ -0,0 +1,38 @@
+#
+# This is free and unencumbered software released into the public domain.
+# 
+# Anyone is free to copy, modify, publish, use, compile, sell, or
+# distribute this software, either in source code form or as a compiled
+# binary, for any purpose, commercial or non-commercial, and by any
+# means.
+# 
+# In jurisdictions that recognize copyright laws, the author or authors
+# of this software dedicate any and all copyright interest in the
+# software to the public domain. We make this dedication for the benefit
+# of the public at large and to the detriment of our heirs and
+# successors. We intend this dedication to be an overt act of
+# relinquishment in perpetuity of all present and future rights to this
+# software under copyright law.
+# 
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+
+case "$machine" in
+or1k*)
+  base_machine=or1k
+  machine=or1k
+
+  # Needed for relro detection
+  libc_commonpagesize=0x2000
+  libc_relro_required=yes
+
+  with_fp_cond="defined __or1k_hard_float__"
+  ;;
+esac
+
diff --git a/sysdeps/or1k/setjmp.S b/sysdeps/or1k/setjmp.S
new file mode 100644
index 0000000000..62a967f769
--- /dev/null
+++ b/sysdeps/or1k/setjmp.S
@@ -0,0 +1,56 @@
+/* setjmp, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdep.h>
+#define _ASM
+#define _SETJMP_H
+#include <bits/setjmp.h>
+
+ENTRY (_setjmp)
+	l.addi	r4, r0, 0     /* Set second argument to 0.  */
+	l.j	.Local__sigsetjmp
+	 l.nop
+END (_setjmp)
+libc_hidden_def (_setjmp)
+
+ENTRY (setjmp)
+	l.addi	r4, r0, 1     /* Set second argument to 1.  */
+	l.j	.Local__sigsetjmp
+	 l.nop
+END (setjmp)
+
+ENTRY (__sigsetjmp)
+.Local__sigsetjmp:
+	l.sw	0(r3), r1
+	l.sw	4(r3), r2
+	l.sw	8(r3), r9
+	l.sw	12(r3), r10
+	l.sw	16(r3), r14
+	l.sw	20(r3), r16
+	l.sw	24(r3), r18
+	l.sw	28(r3), r20
+	l.sw	32(r3), r22
+	l.sw	36(r3), r24
+	l.sw	40(r3), r26
+	l.sw	44(r3), r28
+	l.sw	48(r3), r30
+	l.j	__sigjmp_save
+	 l.nop
+END (__sigsetjmp)
+hidden_def (__sigsetjmp)
diff --git a/sysdeps/or1k/sfp-machine.h b/sysdeps/or1k/sfp-machine.h
new file mode 100644
index 0000000000..e91155e2fb
--- /dev/null
+++ b/sysdeps/or1k/sfp-machine.h
@@ -0,0 +1,102 @@
+/* OpenRISC softfloat definitions.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define _FP_W_TYPE_SIZE		32
+#define _FP_W_TYPE		unsigned long
+#define _FP_WS_TYPE		signed long
+#define _FP_I_TYPE		long
+
+#define _FP_MUL_MEAT_S(R,X,Y)				\
+  _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_D(R,X,Y)				\
+  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_Q(R,X,Y)				\
+  _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
+#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_loop(S,R,X,Y)
+#define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
+#define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
+
+#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
+#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1), -1
+#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1, -1, -1
+#define _FP_NANSIGN_S		0
+#define _FP_NANSIGN_D		0
+#define _FP_NANSIGN_Q		0
+
+#define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
+
+/* Someone please check this.  */
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
+  do {								\
+    if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs)		\
+	&& !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs))	\
+      {								\
+	R##_s = Y##_s;						\
+	_FP_FRAC_COPY_##wc(R,Y);				\
+      }								\
+    else							\
+      {								\
+	R##_s = X##_s;						\
+	_FP_FRAC_COPY_##wc(R,X);				\
+      }								\
+    R##_c = FP_CLS_NAN;						\
+  } while (0)
+
+/* Handle getting and setting rounding mode for soft fp operations.  */
+
+#define FP_RND_NEAREST		(0x0 << 1)
+#define FP_RND_ZERO		(0x1 << 1)
+#define FP_RND_PINF		(0x2 << 1)
+#define FP_RND_MINF		(0x3 << 1)
+#define FP_RND_MASK		(0x3 << 1)
+
+#define FP_EX_OVERFLOW		1 << 3
+#define FP_EX_UNDERFLOW		1 << 4
+#define FP_EX_INEXACT		1 << 8
+#define FP_EX_INVALID		1 << 9
+#define FP_EX_DIVZERO		1 << 11
+#define FP_EX_ALL \
+	(FP_EX_INVALID | FP_EX_DIVZERO | FP_EX_OVERFLOW | FP_EX_UNDERFLOW \
+	 | FP_EX_INEXACT)
+
+#define _FP_DECL_EX \
+  unsigned int _fpcsr __attribute__ ((unused)) = FP_RND_NEAREST
+
+#define FP_ROUNDMODE (_fpcsr & FP_RND_MASK)
+
+#ifdef __or1k_hard_float__
+#define FP_INIT_ROUNDMODE					\
+do {								\
+  __asm__ volatile ("l.mfspr %0,r0,20" : "=r" (_fpcsr));	\
+} while (0)
+
+#define FP_HANDLE_EXCEPTIONS					\
+do {								\
+  if (__builtin_expect (_fex, 0))				\
+    {								\
+      _fpcsr &= ~FP_EX_ALL;					\
+      _fpcsr |= _fex;						\
+      __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (_fpcsr));	\
+    }								\
+} while (0)
+#endif
+
+#define _FP_TININESS_AFTER_ROUNDING 1
diff --git a/sysdeps/or1k/sotruss-lib.c b/sysdeps/or1k/sotruss-lib.c
new file mode 100644
index 0000000000..e071156026
--- /dev/null
+++ b/sysdeps/or1k/sotruss-lib.c
@@ -0,0 +1,51 @@
+/* Override generic sotruss-lib.c to define actual functions for OpenRISC.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define HAVE_ARCH_PLTENTER
+#define HAVE_ARCH_PLTEXIT
+
+#include <elf/sotruss-lib.c>
+
+ElfW(Addr)
+la_or1k_gnu_pltenter (ElfW(Sym) *sym __attribute__ ((unused)),
+		       unsigned int ndx __attribute__ ((unused)),
+		       uintptr_t *refcook, uintptr_t *defcook,
+		       La_or1k_regs *regs, unsigned int *flags,
+		       const char *symname, long int *framesizep)
+{
+  print_enter (refcook, defcook, symname,
+	       regs->lr_reg[0], regs->lr_reg[1], regs->lr_reg[2],
+	       *flags);
+
+  /* No need to copy anything, we will not need the parameters in any case.  */
+  *framesizep = 0;
+
+  return sym->st_value;
+}
+
+unsigned int
+la_or1k_gnu_pltexit (ElfW(Sym) *sym, unsigned int ndx, uintptr_t *refcook,
+		      uintptr_t *defcook,
+		      const struct La_or1k_regs *inregs,
+		      struct La_or1k_retval *outregs,
+		      const char *symname)
+{
+  print_exit (refcook, defcook, symname, outregs->lrv_r3);
+
+  return 0;
+}
diff --git a/sysdeps/or1k/stackinfo.h b/sysdeps/or1k/stackinfo.h
new file mode 100644
index 0000000000..1b031bcbb3
--- /dev/null
+++ b/sysdeps/or1k/stackinfo.h
@@ -0,0 +1,33 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+/* This file contains a bit of information about the stack allocation
+   of the processor.  */
+
+#ifndef _STACKINFO_H
+#define _STACKINFO_H	1
+
+#include <elf.h>
+
+/* On or1k the stack grows down.  */
+#define _STACK_GROWS_DOWN	1
+
+/* Default to an executable stack.  PF_X can be overridden if PT_GNU_STACK is
+ * present, but it is presumed absent.  */
+#define DEFAULT_STACK_PERMS (PF_R|PF_W|PF_X)
+
+#endif /* stackinfo.h */
diff --git a/sysdeps/or1k/start.S b/sysdeps/or1k/start.S
new file mode 100644
index 0000000000..339e0ddcc2
--- /dev/null
+++ b/sysdeps/or1k/start.S
@@ -0,0 +1,116 @@
+/* start, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+/* Stick in a dummy reference to main(), so that if an application
+   is linking when the main() function is in a static library (.a)
+   we can be sure that main() actually gets linked in.  */
+
+	.type main, %function
+
+/* This is the canonical entry point, usually the first thing in the text
+   segment.
+
+   sp   The stack contains the arguments and environment:
+    0(sp)     argc
+    4(sp)     argv[0]
+    ...
+    (4*argc)(sp)    NULL
+    (4*(argc+1))(sp)  envp[0]
+    ...
+    NULL
+ */
+
+#include <features.h>
+
+.text
+	.globl	_start
+	.type	_start, %function
+	.global	_start
+_start:
+
+	/* rtld_fini = the dynamic fini address.
+	  This is set by dl-start.S or just plain NULL if called directly. */
+	l.ori	r8, r9, 0
+
+#ifdef SHARED
+	/* Obtain a pointer to .got in r16 */
+	l.jal	.LPC0
+	 l.nop
+.LPC0:
+	l.movhi	r16, gotpchi(_GLOBAL_OFFSET_TABLE_+(.-.LPC0))
+	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+(.-.LPC0))
+	l.add	r16, r16, r9
+#endif
+
+	/* Push stack limit onto the stack.
+	   This arovides highest stack address to user code (as stack grows
+	   downwards.
+	   This is the seventh argument to __libc_start_main and thus needs to
+	   be passed on the stack.  */
+	l.sw	-4(r1), r1
+
+	/* Take values for argc and argv off the stack.
+	   These will be passed as arguments two and three to main
+	   and thus go in registers r4 and r5, respectively.  */
+	l.lwz	r4, 0(r1)
+	l.addi	r5, r1, 4
+
+#ifdef SHARED
+	l.lwz	r3, got(main)(r16)
+#else
+	l.movhi r3, hi(main)
+	l.ori	r3, r3, lo(main)
+#endif
+
+	/* Put the constructor and destructor initialization as args four and
+	   five into r6 and r7.  */
+#ifdef SHARED
+	l.lwz	r6, got(__libc_csu_init)(r16)
+	l.lwz	r7, got(__libc_csu_fini)(r16)
+#else
+	l.movhi	r6, hi(__libc_csu_init)
+	l.ori	r6, r6, lo(__libc_csu_init)
+	l.movhi	r7, hi(__libc_csu_fini)
+	l.ori	r7, r7, lo(__libc_csu_fini)
+#endif
+
+	/* Adjust stack to account for a total of 7 args (i.e. the last one is
+	   on the stack.  */
+	l.addi	r1, r1, -4
+
+	/* Clear the frame pointer and link register since this is the
+	   outermost frame.  */
+	l.add	r2, r0, r0
+	l.add	r9, r0, r0
+
+	/* Let the libc call main and exit with its return code.  */
+#ifdef SHARED
+	l.j	plt(__libc_start_main)
+#else
+	l.j	__libc_start_main
+#endif
+  	 l.nop
+
+	/* Define a symbol for the first piece of initialized data.  */
+	.data
+	.globl __data_start
+__data_start:
+	.long 0
+	.weak data_start
+	data_start = __data_start
diff --git a/sysdeps/or1k/sysdep.h b/sysdeps/or1k/sysdep.h
new file mode 100644
index 0000000000..217a341b52
--- /dev/null
+++ b/sysdeps/or1k/sysdep.h
@@ -0,0 +1,77 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdeps/generic/sysdep.h>
+#include <features.h>
+
+#if defined __ASSEMBLER__ || defined REQUEST_ASSEMBLER_MACROS
+
+/* Make use of .size directive.  */
+#define ASM_SIZE_DIRECTIVE(name) .size name,.-name;
+
+/* Define an entry point visible from C.  */
+#define ENTRY(name)                                                           \
+  .globl C_SYMBOL_NAME(name);                                                 \
+  .type C_SYMBOL_NAME(name), at function;                                        \
+  .align 4;                                                                   \
+  C_LABEL(name)                                                               \
+  cfi_startproc;                                                              \
+  CALL_MCOUNT
+
+#undef  END
+#define END(name)                                                             \
+  cfi_endproc;                                                                \
+  ASM_SIZE_DIRECTIVE(name)
+
+/* Since C identifiers are not normally prefixed with an underscore
+   on this system, the asm identifier `syscall_error' intrudes on the
+   C name space.  Make sure we use an innocuous name.  */
+#define syscall_error   __syscall_error
+#define mcount          __mcount
+
+/* If compiled for profiling, call `mcount' at the start of each function.  */
+#ifdef  PROF
+# ifdef __PIC__
+#  define CALL_MCOUNT						\
+	l.addi	r1, r1, -4;					\
+	l.sw	0(r1), r9;					\
+	l.j	plt(_mcount);					\
+	 l.nop;							\
+	l.lwz	r9, 0(r1);					\
+	l.addi	r1, r1, 4;
+# else
+#  define CALL_MCOUNT						\
+	l.addi	r1, r1, -4;					\
+	l.sw	0(r1), r9;					\
+	l.movhi r15, hi(_mcount);				\
+	l.ori	r15, r15, lo(_mcount);				\
+	l.jr	r15;						\
+	 l.nop;							\
+	l.lwz	r9, 0(r1);					\
+	l.addi	r1, r1, 4;
+# endif
+#else
+#define CALL_MCOUNT             /* Do nothing.  */
+#endif
+
+/* Local label name for asm code. */
+#define L(name)         .L##name
+
+/* Specify the size in bytes of a machine register.  */
+#define REGSIZE         4
+
+#endif /* __ASSEMBLER__ */
diff --git a/sysdeps/or1k/tininess.h b/sysdeps/or1k/tininess.h
new file mode 100644
index 0000000000..1db37790f8
--- /dev/null
+++ b/sysdeps/or1k/tininess.h
@@ -0,0 +1 @@
+#define TININESS_AFTER_ROUNDING	1
diff --git a/sysdeps/or1k/tls-macros.h b/sysdeps/or1k/tls-macros.h
new file mode 100644
index 0000000000..71d228b01e
--- /dev/null
+++ b/sysdeps/or1k/tls-macros.h
@@ -0,0 +1,82 @@
+/* Macros to support TLS testing, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define TLS_LOAD_GOT \
+  ({ register long lr __asm__ ("r9");					\
+     long got;								\
+     asm ("l.jal    0x8\n\t"						\
+	  " l.movhi %0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n\t"		\
+	  "l.ori    %0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n\t"	\
+	  "l.add    %0, %0, %1"						\
+	  : "=r" (got), "=r" (lr));					\
+     got; })
+
+/* General Dynamic:
+
+     l.movhi r17, tlsgdhi(symbol)
+     l.ori   r17, r17, tlsgdlo(symbol)
+     l.add   r17, r17, r16
+     l.or    r3, r17, r17
+     l.jal   plt(__tls_get_addr)
+      l.nop  */
+
+#define TLS_GD(x)					\
+  ({ void *__tlsgd;					\
+     extern void *__tls_get_addr (void *);          	\
+     asm ("l.movhi %0, tlsgdhi(" #x ")\n\t"		\
+	  "l.ori   %0, %0, tlsgdlo(" #x ")\n\t"		\
+	  : "=r" (__tlsgd));				\
+     (int *) __tls_get_addr (TLS_LOAD_GOT + __tlsgd); })
+
+#define TLS_LD(x) TLS_GD(x)
+
+/* Initial Exec:
+
+     l.movhi r17, gottpoffhi(symbol)
+     l.add   r17, r17, r16
+     l.lwz   r17, gottpofflo(symbol)(r17)
+     l.add   r17, r17, r10
+     l.lbs   r17, 0(r17)  */
+
+#define TLS_IE(x)					\
+  ({ register long __tls __asm__ ("r10");		\
+     void *__tlsie;					\
+     asm ("l.movhi  %0, gottpoffhi(" #x ")\n\t"		\
+	  "l.add    %0, %0, %1\n\t"			\
+	  "l.lwz    %0, gottpofflo(" #x ")(%0)\n\t"	\
+	  "l.add    %0, %0, %2\n\t"			\
+	  : "=&r" (__tlsie) : "r" (TLS_LOAD_GOT),	\
+	    "r" (__tls) : "memory");			\
+     __tlsie; })
+
+/* Local Exec:
+
+     l.movhi r17, tpoffha(symbol)
+     l.add   r17, r17, r10
+     l.addi  r17, r17, tpofflo(symbol)
+     l.lbs   r17, 0(r17)  */
+
+#define TLS_LE(x)					\
+  ({ register long __tls __asm__ ("r10");		\
+     void *__tlsle;					\
+     asm ("l.movhi  %0, tpoffha(" #x ")\n\t"		\
+	  "l.add    %0, %0, %1\n\t"			\
+	  "l.addi   %0, %0, tpofflo(" #x ")\n\t"	\
+	  : "=&r" (__tlsle) : "r" (__tls) : "memory");	\
+     __tlsle; })
diff --git a/sysdeps/or1k/tst-audit.h b/sysdeps/or1k/tst-audit.h
new file mode 100644
index 0000000000..ee95ded044
--- /dev/null
+++ b/sysdeps/or1k/tst-audit.h
@@ -0,0 +1,24 @@
+/* Definitions for testing PLT entry/exit auditing.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define pltenter la_or1k_gnu_pltenter
+#define pltexit la_or1k_gnu_pltexit
+#define La_regs La_or1k_regs
+#define La_retval La_or1k_retval
+#define int_retval lrv_r3
diff --git a/sysdeps/unix/sysv/linux/or1k/Implies b/sysdeps/unix/sysv/linux/or1k/Implies
new file mode 100644
index 0000000000..f39f16c04a
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/Implies
@@ -0,0 +1,3 @@
+or1k/nptl
+unix/sysv/linux/generic/wordsize-32
+unix/sysv/linux/generic
diff --git a/sysdeps/unix/sysv/linux/or1k/Makefile b/sysdeps/unix/sysv/linux/or1k/Makefile
new file mode 100644
index 0000000000..be20320b2f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/Makefile
@@ -0,0 +1,12 @@
+ifeq ($(subdir),misc)
+  sysdep_routines += prctl or1k_clone
+endif
+
+ifeq ($(subdir),stdlib)
+gen-as-const-headers += ucontext_i.sym
+endif
+
+# pull in __syscall_error routine
+libpthread-routines += sysdep
+librt-routines += sysdep
+
diff --git a/sysdeps/unix/sysv/linux/or1k/arch-syscall.h b/sysdeps/unix/sysv/linux/or1k/arch-syscall.h
new file mode 100644
index 0000000000..f2f47b325c
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/arch-syscall.h
@@ -0,0 +1,315 @@
+/* AUTOGENERATED by update-syscall-lists.py.  */
+#define __NR_accept 202
+#define __NR_accept4 242
+#define __NR_acct 89
+#define __NR_add_key 217
+#define __NR_adjtimex 171
+#define __NR_bind 200
+#define __NR_bpf 280
+#define __NR_brk 214
+#define __NR_capget 90
+#define __NR_capset 91
+#define __NR_chdir 49
+#define __NR_chroot 51
+#define __NR_clock_adjtime 266
+#define __NR_clock_adjtime64 405
+#define __NR_clock_getres 114
+#define __NR_clock_getres_time64 406
+#define __NR_clock_gettime 113
+#define __NR_clock_gettime64 403
+#define __NR_clock_nanosleep 115
+#define __NR_clock_nanosleep_time64 407
+#define __NR_clock_settime 112
+#define __NR_clock_settime64 404
+#define __NR_clone 220
+#define __NR_clone3 435
+#define __NR_close 57
+#define __NR_connect 203
+#define __NR_copy_file_range 285
+#define __NR_delete_module 106
+#define __NR_dup 23
+#define __NR_dup3 24
+#define __NR_epoll_create1 20
+#define __NR_epoll_ctl 21
+#define __NR_epoll_pwait 22
+#define __NR_eventfd2 19
+#define __NR_execve 221
+#define __NR_execveat 281
+#define __NR_exit 93
+#define __NR_exit_group 94
+#define __NR_faccessat 48
+#define __NR_fadvise64_64 223
+#define __NR_fallocate 47
+#define __NR_fanotify_init 262
+#define __NR_fanotify_mark 263
+#define __NR_fchdir 50
+#define __NR_fchmod 52
+#define __NR_fchmodat 53
+#define __NR_fchown 55
+#define __NR_fchownat 54
+#define __NR_fcntl64 25
+#define __NR_fdatasync 83
+#define __NR_fgetxattr 10
+#define __NR_finit_module 273
+#define __NR_flistxattr 13
+#define __NR_flock 32
+#define __NR_fremovexattr 16
+#define __NR_fsconfig 431
+#define __NR_fsetxattr 7
+#define __NR_fsmount 432
+#define __NR_fsopen 430
+#define __NR_fspick 433
+#define __NR_fstat64 80
+#define __NR_fstatat64 79
+#define __NR_fstatfs64 44
+#define __NR_fsync 82
+#define __NR_ftruncate64 46
+#define __NR_futex 98
+#define __NR_futex_time64 422
+#define __NR_get_mempolicy 236
+#define __NR_get_robust_list 100
+#define __NR_getcpu 168
+#define __NR_getcwd 17
+#define __NR_getdents64 61
+#define __NR_getegid 177
+#define __NR_geteuid 175
+#define __NR_getgid 176
+#define __NR_getgroups 158
+#define __NR_getitimer 102
+#define __NR_getpeername 205
+#define __NR_getpgid 155
+#define __NR_getpid 172
+#define __NR_getppid 173
+#define __NR_getpriority 141
+#define __NR_getrandom 278
+#define __NR_getresgid 150
+#define __NR_getresuid 148
+#define __NR_getrlimit 163
+#define __NR_getrusage 165
+#define __NR_getsid 156
+#define __NR_getsockname 204
+#define __NR_getsockopt 209
+#define __NR_gettid 178
+#define __NR_gettimeofday 169
+#define __NR_getuid 174
+#define __NR_getxattr 8
+#define __NR_init_module 105
+#define __NR_inotify_add_watch 27
+#define __NR_inotify_init1 26
+#define __NR_inotify_rm_watch 28
+#define __NR_io_cancel 3
+#define __NR_io_destroy 1
+#define __NR_io_getevents 4
+#define __NR_io_pgetevents 292
+#define __NR_io_pgetevents_time64 416
+#define __NR_io_setup 0
+#define __NR_io_submit 2
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_io_uring_setup 425
+#define __NR_ioctl 29
+#define __NR_ioprio_get 31
+#define __NR_ioprio_set 30
+#define __NR_kcmp 272
+#define __NR_kexec_file_load 294
+#define __NR_kexec_load 104
+#define __NR_keyctl 219
+#define __NR_kill 129
+#define __NR_lgetxattr 9
+#define __NR_linkat 37
+#define __NR_listen 201
+#define __NR_listxattr 11
+#define __NR_llistxattr 12
+#define __NR_llseek 62
+#define __NR_lookup_dcookie 18
+#define __NR_lremovexattr 15
+#define __NR_lsetxattr 6
+#define __NR_madvise 233
+#define __NR_mbind 235
+#define __NR_membarrier 283
+#define __NR_memfd_create 279
+#define __NR_migrate_pages 238
+#define __NR_mincore 232
+#define __NR_mkdirat 34
+#define __NR_mknodat 33
+#define __NR_mlock 228
+#define __NR_mlock2 284
+#define __NR_mlockall 230
+#define __NR_mmap2 222
+#define __NR_mount 40
+#define __NR_move_mount 429
+#define __NR_move_pages 239
+#define __NR_mprotect 226
+#define __NR_mq_getsetattr 185
+#define __NR_mq_notify 184
+#define __NR_mq_open 180
+#define __NR_mq_timedreceive 183
+#define __NR_mq_timedreceive_time64 419
+#define __NR_mq_timedsend 182
+#define __NR_mq_timedsend_time64 418
+#define __NR_mq_unlink 181
+#define __NR_mremap 216
+#define __NR_msgctl 187
+#define __NR_msgget 186
+#define __NR_msgrcv 188
+#define __NR_msgsnd 189
+#define __NR_msync 227
+#define __NR_munlock 229
+#define __NR_munlockall 231
+#define __NR_munmap 215
+#define __NR_name_to_handle_at 264
+#define __NR_nanosleep 101
+#define __NR_nfsservctl 42
+#define __NR_open_by_handle_at 265
+#define __NR_open_tree 428
+#define __NR_openat 56
+#define __NR_openat2 437
+#define __NR_or1k_atomic 244
+#define __NR_perf_event_open 241
+#define __NR_personality 92
+#define __NR_pidfd_getfd 438
+#define __NR_pidfd_open 434
+#define __NR_pidfd_send_signal 424
+#define __NR_pipe2 59
+#define __NR_pivot_root 41
+#define __NR_pkey_alloc 289
+#define __NR_pkey_free 290
+#define __NR_pkey_mprotect 288
+#define __NR_ppoll 73
+#define __NR_ppoll_time64 414
+#define __NR_prctl 167
+#define __NR_pread64 67
+#define __NR_preadv 69
+#define __NR_preadv2 286
+#define __NR_prlimit64 261
+#define __NR_process_vm_readv 270
+#define __NR_process_vm_writev 271
+#define __NR_pselect6 72
+#define __NR_pselect6_time64 413
+#define __NR_ptrace 117
+#define __NR_pwrite64 68
+#define __NR_pwritev 70
+#define __NR_pwritev2 287
+#define __NR_quotactl 60
+#define __NR_read 63
+#define __NR_readahead 213
+#define __NR_readlinkat 78
+#define __NR_readv 65
+#define __NR_reboot 142
+#define __NR_recvfrom 207
+#define __NR_recvmmsg 243
+#define __NR_recvmmsg_time64 417
+#define __NR_recvmsg 212
+#define __NR_remap_file_pages 234
+#define __NR_removexattr 14
+#define __NR_renameat 38
+#define __NR_renameat2 276
+#define __NR_request_key 218
+#define __NR_restart_syscall 128
+#define __NR_rseq 293
+#define __NR_rt_sigaction 134
+#define __NR_rt_sigpending 136
+#define __NR_rt_sigprocmask 135
+#define __NR_rt_sigqueueinfo 138
+#define __NR_rt_sigreturn 139
+#define __NR_rt_sigsuspend 133
+#define __NR_rt_sigtimedwait 137
+#define __NR_rt_sigtimedwait_time64 421
+#define __NR_rt_tgsigqueueinfo 240
+#define __NR_sched_get_priority_max 125
+#define __NR_sched_get_priority_min 126
+#define __NR_sched_getaffinity 123
+#define __NR_sched_getattr 275
+#define __NR_sched_getparam 121
+#define __NR_sched_getscheduler 120
+#define __NR_sched_rr_get_interval 127
+#define __NR_sched_rr_get_interval_time64 423
+#define __NR_sched_setaffinity 122
+#define __NR_sched_setattr 274
+#define __NR_sched_setparam 118
+#define __NR_sched_setscheduler 119
+#define __NR_sched_yield 124
+#define __NR_seccomp 277
+#define __NR_semctl 191
+#define __NR_semget 190
+#define __NR_semop 193
+#define __NR_semtimedop 192
+#define __NR_semtimedop_time64 420
+#define __NR_sendfile64 71
+#define __NR_sendmmsg 269
+#define __NR_sendmsg 211
+#define __NR_sendto 206
+#define __NR_set_mempolicy 237
+#define __NR_set_robust_list 99
+#define __NR_set_tid_address 96
+#define __NR_setdomainname 162
+#define __NR_setfsgid 152
+#define __NR_setfsuid 151
+#define __NR_setgid 144
+#define __NR_setgroups 159
+#define __NR_sethostname 161
+#define __NR_setitimer 103
+#define __NR_setns 268
+#define __NR_setpgid 154
+#define __NR_setpriority 140
+#define __NR_setregid 143
+#define __NR_setresgid 149
+#define __NR_setresuid 147
+#define __NR_setreuid 145
+#define __NR_setrlimit 164
+#define __NR_setsid 157
+#define __NR_setsockopt 208
+#define __NR_settimeofday 170
+#define __NR_setuid 146
+#define __NR_setxattr 5
+#define __NR_shmat 196
+#define __NR_shmctl 195
+#define __NR_shmdt 197
+#define __NR_shmget 194
+#define __NR_shutdown 210
+#define __NR_sigaltstack 132
+#define __NR_signalfd4 74
+#define __NR_socket 198
+#define __NR_socketpair 199
+#define __NR_splice 76
+#define __NR_statfs64 43
+#define __NR_statx 291
+#define __NR_swapoff 225
+#define __NR_swapon 224
+#define __NR_symlinkat 36
+#define __NR_sync 81
+#define __NR_sync_file_range 84
+#define __NR_syncfs 267
+#define __NR_sysinfo 179
+#define __NR_syslog 116
+#define __NR_tee 77
+#define __NR_tgkill 131
+#define __NR_timer_create 107
+#define __NR_timer_delete 111
+#define __NR_timer_getoverrun 109
+#define __NR_timer_gettime 108
+#define __NR_timer_gettime64 408
+#define __NR_timer_settime 110
+#define __NR_timer_settime64 409
+#define __NR_timerfd_create 85
+#define __NR_timerfd_gettime 87
+#define __NR_timerfd_gettime64 410
+#define __NR_timerfd_settime 86
+#define __NR_timerfd_settime64 411
+#define __NR_times 153
+#define __NR_tkill 130
+#define __NR_truncate64 45
+#define __NR_umask 166
+#define __NR_umount2 39
+#define __NR_uname 160
+#define __NR_unlinkat 35
+#define __NR_unshare 97
+#define __NR_userfaultfd 282
+#define __NR_utimensat 88
+#define __NR_utimensat_time64 412
+#define __NR_vhangup 58
+#define __NR_vmsplice 75
+#define __NR_wait4 260
+#define __NR_waitid 95
+#define __NR_write 64
+#define __NR_writev 66
diff --git a/sysdeps/unix/sysv/linux/or1k/bits/fcntl.h b/sysdeps/unix/sysv/linux/or1k/bits/fcntl.h
new file mode 100644
index 0000000000..3b2544a27a
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/bits/fcntl.h
@@ -0,0 +1,49 @@
+/* O_*, F_*, FD_* bit values for Linux.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef	_FCNTL_H
+# error "Never use <bits/fcntl.h> directly; include <fcntl.h> instead."
+#endif
+
+struct flock
+  {
+    short int l_type;	/* Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK.	*/
+    short int l_whence;	/* Where `l_start' is relative to (like `lseek').  */
+#ifndef __USE_FILE_OFFSET64
+    __off_t l_start;	/* Offset where the lock begins.  */
+    __off_t l_len;	/* Size of the locked area; zero means until EOF.  */
+#else
+    __off64_t l_start;	/* Offset where the lock begins.  */
+    __off64_t l_len;	/* Size of the locked area; zero means until EOF.  */
+#endif
+    __pid_t l_pid;	/* Process holding the lock.  */
+  };
+
+#ifdef __USE_LARGEFILE64
+struct flock64
+  {
+    short int l_type;	/* Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK.	*/
+    short int l_whence;	/* Where `l_start' is relative to (like `lseek').  */
+    __off64_t l_start;	/* Offset where the lock begins.  */
+    __off64_t l_len;	/* Size of the locked area; zero means until EOF.  */
+    __pid_t l_pid;	/* Process holding the lock.  */
+  };
+#endif
+
+/* Include generic Linux declarations.  */
+#include <bits/fcntl-linux.h>
diff --git a/sysdeps/unix/sysv/linux/or1k/bits/mman.h b/sysdeps/unix/sysv/linux/or1k/bits/mman.h
new file mode 100644
index 0000000000..ea85772d71
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/bits/mman.h
@@ -0,0 +1,44 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Christian Svensson <blue@cmd.nu>
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_MMAN_H
+# error "Never use <bits/mman.h> directly; include <sys/mman.h> instead."
+#endif
+
+/* The following definitions basically come from the kernel headers.
+   But the kernel header is not namespace clean.  */
+
+#ifdef __USE_MISC
+# define MAP_GROWSDOWN  0x0100          /* stack-like segment */
+# define MAP_DENYWRITE  0x0800          /* ETXTBSY */
+# define MAP_EXECUTABLE 0x1000          /* mark it as an executable */
+# define MAP_LOCKED     0x2000          /* pages are locked */
+# define MAP_NORESERVE  0x4000          /* don't check for reservations */
+# define MAP_POPULATE   0x8000          /* populate (prefault) pagetables */
+# define MAP_NONBLOCK   0x10000         /* do not block on IO */
+# define MAP_STACK      0x20000         /* give out an address that is best suited for process/thread stacks */
+# define MAP_HUGETLB    0x40000         /* create a huge page mapping */
+#endif
+
+/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+
+#define MCL_CURRENT     1               /* lock all current mappings */
+#define MCL_FUTURE      2               /* lock all future mappings */
+
+/* Include generic Linux declarations.  */
+#include <bits/mman-linux.h>
diff --git a/sysdeps/unix/sysv/linux/or1k/c++-types.data b/sysdeps/unix/sysv/linux/or1k/c++-types.data
new file mode 100644
index 0000000000..303f4570c8
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/c++-types.data
@@ -0,0 +1,67 @@
+blkcnt64_t:x
+blkcnt_t:l
+blksize_t:i
+caddr_t:Pc
+clockid_t:i
+clock_t:l
+daddr_t:i
+dev_t:y
+fd_mask:l
+fsblkcnt64_t:y
+fsblkcnt_t:m
+fsfilcnt64_t:y
+fsfilcnt_t:m
+fsid_t:8__fsid_t
+gid_t:j
+id_t:j
+ino64_t:y
+ino_t:m
+int16_t:s
+int32_t:i
+int64_t:x
+int8_t:a
+intptr_t:i
+key_t:i
+loff_t:x
+mode_t:j
+nlink_t:j
+off64_t:x
+off_t:l
+pid_t:i
+pthread_attr_t:14pthread_attr_t
+pthread_barrier_t:17pthread_barrier_t
+pthread_barrierattr_t:21pthread_barrierattr_t
+pthread_cond_t:14pthread_cond_t
+pthread_condattr_t:18pthread_condattr_t
+pthread_key_t:j
+pthread_mutex_t:15pthread_mutex_t
+pthread_mutexattr_t:19pthread_mutexattr_t
+pthread_once_t:i
+pthread_rwlock_t:16pthread_rwlock_t
+pthread_rwlockattr_t:20pthread_rwlockattr_t
+pthread_spinlock_t:i
+pthread_t:m
+quad_t:x
+register_t:i
+rlim64_t:y
+rlim_t:m
+sigset_t:10__sigset_t
+size_t:j
+socklen_t:j
+ssize_t:i
+suseconds_t:l
+time_t:l
+u_char:h
+uid_t:j
+uint:j
+u_int:j
+u_int16_t:t
+u_int32_t:j
+u_int64_t:y
+u_int8_t:h
+ulong:m
+u_long:m
+u_quad_t:y
+useconds_t:j
+ushort:t
+u_short:t
diff --git a/sysdeps/unix/sysv/linux/or1k/clone.c b/sysdeps/unix/sysv/linux/or1k/clone.c
new file mode 100644
index 0000000000..f9dc4d2106
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/clone.c
@@ -0,0 +1,59 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <stdarg.h>
+#include <sysdep.h>
+
+extern int __or1k_clone (int (*fn)(void *), void *child_stack,
+			 int flags, void *arg, pid_t *ptid,
+			 void *tls, pid_t *ctid);
+
+
+/* or1k ABI uses stack for varargs, syscall uses registers.
+ * This function moves from varargs to regs. */
+int
+__clone (int (*fn)(void *), void *child_stack,
+	 int flags, void *arg, ...
+	 /* pid_t *ptid, struct user_desc *tls, pid_t *ctid */ )
+{
+  void *ptid;
+  void *tls;
+  void *ctid;
+  va_list ap;
+  int err;
+
+  va_start (ap, arg);
+  ptid = va_arg (ap, void *);
+  tls = va_arg (ap, void *);
+  ctid = va_arg (ap, void *);
+  va_end (ap);
+
+  /* Sanity check the arguments */
+  err = -EINVAL;
+  if (!fn)
+    goto syscall_error;
+  if (!child_stack)
+    goto syscall_error;
+
+  return __or1k_clone (fn, child_stack, flags, arg, ptid, tls, ctid);
+
+syscall_error:
+  __set_errno (-err);
+  return -1;
+}
+libc_hidden_def (__clone)
+weak_alias (__clone, clone)
diff --git a/sysdeps/unix/sysv/linux/or1k/configure b/sysdeps/unix/sysv/linux/or1k/configure
new file mode 100644
index 0000000000..420b8cab0e
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/configure
@@ -0,0 +1,4 @@
+# This file is generated from configure.ac by Autoconf.  DO NOT EDIT!
+ # Local configure fragment for sysdeps/unix/sysv/linux/or1k.
+
+arch_minimum_kernel=3.4.0
diff --git a/sysdeps/unix/sysv/linux/or1k/configure.ac b/sysdeps/unix/sysv/linux/or1k/configure.ac
new file mode 100644
index 0000000000..505530d5c3
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/configure.ac
@@ -0,0 +1,4 @@
+GLIBC_PROVIDES dnl See aclocal.m4 in the top level source directory.
+# Local configure fragment for sysdeps/unix/sysv/linux/or1k.
+
+arch_minimum_kernel=3.4.0
diff --git a/sysdeps/unix/sysv/linux/or1k/getcontext.S b/sysdeps/unix/sysv/linux/or1k/getcontext.S
new file mode 100644
index 0000000000..7d8acc3019
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/getcontext.S
@@ -0,0 +1,72 @@
+/* Save current context.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+#include "ucontext_i.h"
+
+/* int getcontext (ucontext_t *ucp)
+
+   Returns 0 on success -1 and errno on failure.
+ */
+	.text
+ENTRY(__getcontext)
+	/* Store r1, the stack pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  1*4)(r3), r1
+	/* Store r2, the frame pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  2*4)(r3), r2
+	/* Store r9, the link register.  */
+	l.sw	(UCONTEXT_MCONTEXT +  9*4)(r3), r9
+	/* Store r9 to reg[11] too, as we need two links for makecontext().  */
+	l.sw	(UCONTEXT_MCONTEXT + 11*4)(r3), r9
+	/* Store r10, the TLS register.  */
+	l.sw	(UCONTEXT_MCONTEXT + 10*4)(r3), r10
+	/* Store r14-r30 even, callee saved registers.  */
+	l.sw	(UCONTEXT_MCONTEXT + 14*4)(r3), r14
+	l.sw	(UCONTEXT_MCONTEXT + 16*4)(r3), r16
+	l.sw	(UCONTEXT_MCONTEXT + 18*4)(r3), r18
+	l.sw	(UCONTEXT_MCONTEXT + 20*4)(r3), r20
+	l.sw	(UCONTEXT_MCONTEXT + 22*4)(r3), r22
+	l.sw	(UCONTEXT_MCONTEXT + 24*4)(r3), r24
+	l.sw	(UCONTEXT_MCONTEXT + 26*4)(r3), r26
+	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
+	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
+
+	/* Get signal mask.  */
+	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.addi	r5, r3, UCONTEXT_SIGMASK
+	l.ori	r4, r0, 0
+	l.ori	r3, r0, SIG_BLOCK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys	1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+	l.jr	r9
+ 	 l.ori r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END(__getcontext)
+weak_alias(__getcontext, getcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/ioctl.c b/sysdeps/unix/sysv/linux/or1k/ioctl.c
new file mode 100644
index 0000000000..7aa0268481
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/ioctl.c
@@ -0,0 +1,40 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <stdarg.h>
+#include <sys/ioctl.h>
+#include <sysdep.h>
+
+/* The or1k ABI uses stack for varargs, syscall uses registers.
+   This function moves arguments from varargs to registers.  */
+int
+__ioctl (int fd, unsigned long int request, ...)
+{
+  void *arg;
+  va_list ap;
+  int result;
+
+  va_start (ap, request);
+  arg = va_arg (ap, void *);
+
+  result = INLINE_SYSCALL (ioctl, 3, fd, request, arg);
+  va_end (ap);
+
+  return result;
+}
+libc_hidden_def (__ioctl)
+weak_alias (__ioctl, ioctl)
diff --git a/sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h b/sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
new file mode 100644
index 0000000000..1d46e841a8
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
@@ -0,0 +1,41 @@
+/* jump buffer constants, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+/* Produced by this program:
+
+   #include <stdio.h>
+   #include <unistd.h>
+   #include <setjmp.h>
+   #include <stddef.h>
+
+   int main (int argc, char **argv)
+   {
+       printf ("#define JMP_BUF_SIZE %d\n", sizeof (jmp_buf));
+       printf ("#define JMP_BUF_ALIGN %d\n", __alignof__ (jmp_buf));
+       printf ("#define SIGJMP_BUF_SIZE %d\n", sizeof (sigjmp_buf));
+       printf ("#define SIGJMP_BUF_ALIGN %d\n", __alignof__ (sigjmp_buf));
+       printf ("#define MASK_WAS_SAVED_OFFSET %d\n", offsetof (struct __jmp_buf_tag, __mask_was_saved));
+       printf ("#define SAVED_MASK_OFFSET %d\n", offsetof (struct __jmp_buf_tag, __saved_mask));
+   } */
+
+#define JMP_BUF_SIZE 184
+#define JMP_BUF_ALIGN 4
+#define SIGJMP_BUF_SIZE 184
+#define SIGJMP_BUF_ALIGN 4
+#define MASK_WAS_SAVED_OFFSET 52
+#define SAVED_MASK_OFFSET 56
diff --git a/sysdeps/unix/sysv/linux/or1k/kernel-features.h b/sysdeps/unix/sysv/linux/or1k/kernel-features.h
new file mode 100644
index 0000000000..0974c60739
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/kernel-features.h
@@ -0,0 +1,24 @@
+/* Set flags signalling availability of kernel features based on given
+   kernel version number.  OpenRISC version.
+
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include_next <kernel-features.h>
+
+#undef __ASSUME_SET_ROBUST_LIST
diff --git a/sysdeps/unix/sysv/linux/or1k/ld.abilist b/sysdeps/unix/sysv/linux/or1k/ld.abilist
new file mode 100644
index 0000000000..048f17c848
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/ld.abilist
@@ -0,0 +1,5 @@
+GLIBC_2.32 __libc_stack_end D 0x4
+GLIBC_2.32 __stack_chk_guard D 0x4
+GLIBC_2.32 __tls_get_addr F
+GLIBC_2.32 _dl_mcount F
+GLIBC_2.32 _r_debug D 0x14
diff --git a/sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist b/sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
new file mode 100644
index 0000000000..b0869cec1f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
@@ -0,0 +1 @@
+GLIBC_2.32 __ctype_get_mb_cur_max F
diff --git a/sysdeps/unix/sysv/linux/or1k/libanl.abilist b/sysdeps/unix/sysv/linux/or1k/libanl.abilist
new file mode 100644
index 0000000000..ba513bd028
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libanl.abilist
@@ -0,0 +1,4 @@
+GLIBC_2.32 gai_cancel F
+GLIBC_2.32 gai_error F
+GLIBC_2.32 gai_suspend F
+GLIBC_2.32 getaddrinfo_a F
diff --git a/sysdeps/unix/sysv/linux/or1k/libc.abilist b/sysdeps/unix/sysv/linux/or1k/libc.abilist
new file mode 100644
index 0000000000..7772171bf1
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libc.abilist
@@ -0,0 +1,2081 @@
+GLIBC_2.32 _Exit F
+GLIBC_2.32 _IO_2_1_stderr_ D 0x98
+GLIBC_2.32 _IO_2_1_stdin_ D 0x98
+GLIBC_2.32 _IO_2_1_stdout_ D 0x98
+GLIBC_2.32 _IO_adjust_column F
+GLIBC_2.32 _IO_adjust_wcolumn F
+GLIBC_2.32 _IO_default_doallocate F
+GLIBC_2.32 _IO_default_finish F
+GLIBC_2.32 _IO_default_pbackfail F
+GLIBC_2.32 _IO_default_uflow F
+GLIBC_2.32 _IO_default_xsgetn F
+GLIBC_2.32 _IO_default_xsputn F
+GLIBC_2.32 _IO_do_write F
+GLIBC_2.32 _IO_doallocbuf F
+GLIBC_2.32 _IO_fclose F
+GLIBC_2.32 _IO_fdopen F
+GLIBC_2.32 _IO_feof F
+GLIBC_2.32 _IO_ferror F
+GLIBC_2.32 _IO_fflush F
+GLIBC_2.32 _IO_fgetpos F
+GLIBC_2.32 _IO_fgetpos64 F
+GLIBC_2.32 _IO_fgets F
+GLIBC_2.32 _IO_file_attach F
+GLIBC_2.32 _IO_file_close F
+GLIBC_2.32 _IO_file_close_it F
+GLIBC_2.32 _IO_file_doallocate F
+GLIBC_2.32 _IO_file_finish F
+GLIBC_2.32 _IO_file_fopen F
+GLIBC_2.32 _IO_file_init F
+GLIBC_2.32 _IO_file_jumps D 0x54
+GLIBC_2.32 _IO_file_open F
+GLIBC_2.32 _IO_file_overflow F
+GLIBC_2.32 _IO_file_read F
+GLIBC_2.32 _IO_file_seek F
+GLIBC_2.32 _IO_file_seekoff F
+GLIBC_2.32 _IO_file_setbuf F
+GLIBC_2.32 _IO_file_stat F
+GLIBC_2.32 _IO_file_sync F
+GLIBC_2.32 _IO_file_underflow F
+GLIBC_2.32 _IO_file_write F
+GLIBC_2.32 _IO_file_xsputn F
+GLIBC_2.32 _IO_flockfile F
+GLIBC_2.32 _IO_flush_all F
+GLIBC_2.32 _IO_flush_all_linebuffered F
+GLIBC_2.32 _IO_fopen F
+GLIBC_2.32 _IO_fprintf F
+GLIBC_2.32 _IO_fputs F
+GLIBC_2.32 _IO_fread F
+GLIBC_2.32 _IO_free_backup_area F
+GLIBC_2.32 _IO_free_wbackup_area F
+GLIBC_2.32 _IO_fsetpos F
+GLIBC_2.32 _IO_fsetpos64 F
+GLIBC_2.32 _IO_ftell F
+GLIBC_2.32 _IO_ftrylockfile F
+GLIBC_2.32 _IO_funlockfile F
+GLIBC_2.32 _IO_fwrite F
+GLIBC_2.32 _IO_getc F
+GLIBC_2.32 _IO_getline F
+GLIBC_2.32 _IO_getline_info F
+GLIBC_2.32 _IO_gets F
+GLIBC_2.32 _IO_init F
+GLIBC_2.32 _IO_init_marker F
+GLIBC_2.32 _IO_init_wmarker F
+GLIBC_2.32 _IO_iter_begin F
+GLIBC_2.32 _IO_iter_end F
+GLIBC_2.32 _IO_iter_file F
+GLIBC_2.32 _IO_iter_next F
+GLIBC_2.32 _IO_least_wmarker F
+GLIBC_2.32 _IO_link_in F
+GLIBC_2.32 _IO_list_all D 0x4
+GLIBC_2.32 _IO_list_lock F
+GLIBC_2.32 _IO_list_resetlock F
+GLIBC_2.32 _IO_list_unlock F
+GLIBC_2.32 _IO_marker_delta F
+GLIBC_2.32 _IO_marker_difference F
+GLIBC_2.32 _IO_padn F
+GLIBC_2.32 _IO_peekc_locked F
+GLIBC_2.32 _IO_popen F
+GLIBC_2.32 _IO_printf F
+GLIBC_2.32 _IO_proc_close F
+GLIBC_2.32 _IO_proc_open F
+GLIBC_2.32 _IO_putc F
+GLIBC_2.32 _IO_puts F
+GLIBC_2.32 _IO_remove_marker F
+GLIBC_2.32 _IO_seekmark F
+GLIBC_2.32 _IO_seekoff F
+GLIBC_2.32 _IO_seekpos F
+GLIBC_2.32 _IO_seekwmark F
+GLIBC_2.32 _IO_setb F
+GLIBC_2.32 _IO_setbuffer F
+GLIBC_2.32 _IO_setvbuf F
+GLIBC_2.32 _IO_sgetn F
+GLIBC_2.32 _IO_sprintf F
+GLIBC_2.32 _IO_sputbackc F
+GLIBC_2.32 _IO_sputbackwc F
+GLIBC_2.32 _IO_sscanf F
+GLIBC_2.32 _IO_str_init_readonly F
+GLIBC_2.32 _IO_str_init_static F
+GLIBC_2.32 _IO_str_overflow F
+GLIBC_2.32 _IO_str_pbackfail F
+GLIBC_2.32 _IO_str_seekoff F
+GLIBC_2.32 _IO_str_underflow F
+GLIBC_2.32 _IO_sungetc F
+GLIBC_2.32 _IO_sungetwc F
+GLIBC_2.32 _IO_switch_to_get_mode F
+GLIBC_2.32 _IO_switch_to_main_wget_area F
+GLIBC_2.32 _IO_switch_to_wbackup_area F
+GLIBC_2.32 _IO_switch_to_wget_mode F
+GLIBC_2.32 _IO_un_link F
+GLIBC_2.32 _IO_ungetc F
+GLIBC_2.32 _IO_unsave_markers F
+GLIBC_2.32 _IO_unsave_wmarkers F
+GLIBC_2.32 _IO_vfprintf F
+GLIBC_2.32 _IO_vsprintf F
+GLIBC_2.32 _IO_wdefault_doallocate F
+GLIBC_2.32 _IO_wdefault_finish F
+GLIBC_2.32 _IO_wdefault_pbackfail F
+GLIBC_2.32 _IO_wdefault_uflow F
+GLIBC_2.32 _IO_wdefault_xsgetn F
+GLIBC_2.32 _IO_wdefault_xsputn F
+GLIBC_2.32 _IO_wdo_write F
+GLIBC_2.32 _IO_wdoallocbuf F
+GLIBC_2.32 _IO_wfile_jumps D 0x54
+GLIBC_2.32 _IO_wfile_overflow F
+GLIBC_2.32 _IO_wfile_seekoff F
+GLIBC_2.32 _IO_wfile_sync F
+GLIBC_2.32 _IO_wfile_underflow F
+GLIBC_2.32 _IO_wfile_xsputn F
+GLIBC_2.32 _IO_wmarker_delta F
+GLIBC_2.32 _IO_wsetb F
+GLIBC_2.32 ___brk_addr D 0x4
+GLIBC_2.32 __adjtimex F
+GLIBC_2.32 __after_morecore_hook D 0x4
+GLIBC_2.32 __argz_count F
+GLIBC_2.32 __argz_next F
+GLIBC_2.32 __argz_stringify F
+GLIBC_2.32 __asprintf F
+GLIBC_2.32 __asprintf_chk F
+GLIBC_2.32 __assert F
+GLIBC_2.32 __assert_fail F
+GLIBC_2.32 __assert_perror_fail F
+GLIBC_2.32 __backtrace F
+GLIBC_2.32 __backtrace_symbols F
+GLIBC_2.32 __backtrace_symbols_fd F
+GLIBC_2.32 __bsd_getpgrp F
+GLIBC_2.32 __bzero F
+GLIBC_2.32 __check_rhosts_file D 0x4
+GLIBC_2.32 __chk_fail F
+GLIBC_2.32 __clone F
+GLIBC_2.32 __close F
+GLIBC_2.32 __cmsg_nxthdr F
+GLIBC_2.32 __confstr_chk F
+GLIBC_2.32 __connect F
+GLIBC_2.32 __ctype_b_loc F
+GLIBC_2.32 __ctype_get_mb_cur_max F
+GLIBC_2.32 __ctype_tolower_loc F
+GLIBC_2.32 __ctype_toupper_loc F
+GLIBC_2.32 __curbrk D 0x4
+GLIBC_2.32 __cxa_at_quick_exit F
+GLIBC_2.32 __cxa_atexit F
+GLIBC_2.32 __cxa_finalize F
+GLIBC_2.32 __cxa_thread_atexit_impl F
+GLIBC_2.32 __cyg_profile_func_enter F
+GLIBC_2.32 __cyg_profile_func_exit F
+GLIBC_2.32 __daylight D 0x4
+GLIBC_2.32 __dcgettext F
+GLIBC_2.32 __default_morecore F
+GLIBC_2.32 __dgettext F
+GLIBC_2.32 __dprintf_chk F
+GLIBC_2.32 __dup2 F
+GLIBC_2.32 __duplocale F
+GLIBC_2.32 __endmntent F
+GLIBC_2.32 __environ D 0x4
+GLIBC_2.32 __errno_location F
+GLIBC_2.32 __explicit_bzero_chk F
+GLIBC_2.32 __fbufsize F
+GLIBC_2.32 __fcntl F
+GLIBC_2.32 __fdelt_chk F
+GLIBC_2.32 __fdelt_warn F
+GLIBC_2.32 __ffs F
+GLIBC_2.32 __fgets_chk F
+GLIBC_2.32 __fgets_unlocked_chk F
+GLIBC_2.32 __fgetws_chk F
+GLIBC_2.32 __fgetws_unlocked_chk F
+GLIBC_2.32 __finite F
+GLIBC_2.32 __finitef F
+GLIBC_2.32 __flbf F
+GLIBC_2.32 __fork F
+GLIBC_2.32 __fpending F
+GLIBC_2.32 __fprintf_chk F
+GLIBC_2.32 __fpu_control D 0x4
+GLIBC_2.32 __fpurge F
+GLIBC_2.32 __fread_chk F
+GLIBC_2.32 __fread_unlocked_chk F
+GLIBC_2.32 __freadable F
+GLIBC_2.32 __freading F
+GLIBC_2.32 __free_hook D 0x4
+GLIBC_2.32 __freelocale F
+GLIBC_2.32 __fsetlocking F
+GLIBC_2.32 __fwprintf_chk F
+GLIBC_2.32 __fwritable F
+GLIBC_2.32 __fwriting F
+GLIBC_2.32 __fxstat F
+GLIBC_2.32 __fxstat64 F
+GLIBC_2.32 __fxstatat F
+GLIBC_2.32 __fxstatat64 F
+GLIBC_2.32 __getauxval F
+GLIBC_2.32 __getcwd_chk F
+GLIBC_2.32 __getdelim F
+GLIBC_2.32 __getdomainname_chk F
+GLIBC_2.32 __getgroups_chk F
+GLIBC_2.32 __gethostname_chk F
+GLIBC_2.32 __getlogin_r_chk F
+GLIBC_2.32 __getmntent_r F
+GLIBC_2.32 __getpagesize F
+GLIBC_2.32 __getpgid F
+GLIBC_2.32 __getpid F
+GLIBC_2.32 __gets_chk F
+GLIBC_2.32 __gettimeofday F
+GLIBC_2.32 __getwd_chk F
+GLIBC_2.32 __gmtime_r F
+GLIBC_2.32 __h_errno_location F
+GLIBC_2.32 __isalnum_l F
+GLIBC_2.32 __isalpha_l F
+GLIBC_2.32 __isascii_l F
+GLIBC_2.32 __isblank_l F
+GLIBC_2.32 __iscntrl_l F
+GLIBC_2.32 __isctype F
+GLIBC_2.32 __isdigit_l F
+GLIBC_2.32 __isgraph_l F
+GLIBC_2.32 __isinf F
+GLIBC_2.32 __isinff F
+GLIBC_2.32 __islower_l F
+GLIBC_2.32 __isnan F
+GLIBC_2.32 __isnanf F
+GLIBC_2.32 __isoc99_fscanf F
+GLIBC_2.32 __isoc99_fwscanf F
+GLIBC_2.32 __isoc99_scanf F
+GLIBC_2.32 __isoc99_sscanf F
+GLIBC_2.32 __isoc99_swscanf F
+GLIBC_2.32 __isoc99_vfscanf F
+GLIBC_2.32 __isoc99_vfwscanf F
+GLIBC_2.32 __isoc99_vscanf F
+GLIBC_2.32 __isoc99_vsscanf F
+GLIBC_2.32 __isoc99_vswscanf F
+GLIBC_2.32 __isoc99_vwscanf F
+GLIBC_2.32 __isoc99_wscanf F
+GLIBC_2.32 __isprint_l F
+GLIBC_2.32 __ispunct_l F
+GLIBC_2.32 __isspace_l F
+GLIBC_2.32 __isupper_l F
+GLIBC_2.32 __iswalnum_l F
+GLIBC_2.32 __iswalpha_l F
+GLIBC_2.32 __iswblank_l F
+GLIBC_2.32 __iswcntrl_l F
+GLIBC_2.32 __iswctype F
+GLIBC_2.32 __iswctype_l F
+GLIBC_2.32 __iswdigit_l F
+GLIBC_2.32 __iswgraph_l F
+GLIBC_2.32 __iswlower_l F
+GLIBC_2.32 __iswprint_l F
+GLIBC_2.32 __iswpunct_l F
+GLIBC_2.32 __iswspace_l F
+GLIBC_2.32 __iswupper_l F
+GLIBC_2.32 __iswxdigit_l F
+GLIBC_2.32 __isxdigit_l F
+GLIBC_2.32 __ivaliduser F
+GLIBC_2.32 __key_decryptsession_pk_LOCAL D 0x4
+GLIBC_2.32 __key_encryptsession_pk_LOCAL D 0x4
+GLIBC_2.32 __key_gendes_LOCAL D 0x4
+GLIBC_2.32 __libc_allocate_rtsig F
+GLIBC_2.32 __libc_calloc F
+GLIBC_2.32 __libc_current_sigrtmax F
+GLIBC_2.32 __libc_current_sigrtmin F
+GLIBC_2.32 __libc_free F
+GLIBC_2.32 __libc_freeres F
+GLIBC_2.32 __libc_init_first F
+GLIBC_2.32 __libc_mallinfo F
+GLIBC_2.32 __libc_malloc F
+GLIBC_2.32 __libc_mallopt F
+GLIBC_2.32 __libc_memalign F
+GLIBC_2.32 __libc_pvalloc F
+GLIBC_2.32 __libc_realloc F
+GLIBC_2.32 __libc_sa_len F
+GLIBC_2.32 __libc_start_main F
+GLIBC_2.32 __libc_valloc F
+GLIBC_2.32 __longjmp_chk F
+GLIBC_2.32 __lseek F
+GLIBC_2.32 __lxstat F
+GLIBC_2.32 __lxstat64 F
+GLIBC_2.32 __malloc_hook D 0x4
+GLIBC_2.32 __mbrlen F
+GLIBC_2.32 __mbrtowc F
+GLIBC_2.32 __mbsnrtowcs_chk F
+GLIBC_2.32 __mbsrtowcs_chk F
+GLIBC_2.32 __mbstowcs_chk F
+GLIBC_2.32 __memalign_hook D 0x4
+GLIBC_2.32 __memcpy_chk F
+GLIBC_2.32 __memmove_chk F
+GLIBC_2.32 __mempcpy F
+GLIBC_2.32 __mempcpy_chk F
+GLIBC_2.32 __memset_chk F
+GLIBC_2.32 __monstartup F
+GLIBC_2.32 __morecore D 0x4
+GLIBC_2.32 __nanosleep F
+GLIBC_2.32 __newlocale F
+GLIBC_2.32 __nl_langinfo_l F
+GLIBC_2.32 __nss_configure_lookup F
+GLIBC_2.32 __nss_hostname_digits_dots F
+GLIBC_2.32 __obstack_printf_chk F
+GLIBC_2.32 __obstack_vprintf_chk F
+GLIBC_2.32 __open F
+GLIBC_2.32 __open64 F
+GLIBC_2.32 __open64_2 F
+GLIBC_2.32 __open_2 F
+GLIBC_2.32 __openat64_2 F
+GLIBC_2.32 __openat_2 F
+GLIBC_2.32 __overflow F
+GLIBC_2.32 __pipe F
+GLIBC_2.32 __poll F
+GLIBC_2.32 __poll_chk F
+GLIBC_2.32 __posix_getopt F
+GLIBC_2.32 __ppoll_chk F
+GLIBC_2.32 __pread64 F
+GLIBC_2.32 __pread64_chk F
+GLIBC_2.32 __pread_chk F
+GLIBC_2.32 __printf_chk F
+GLIBC_2.32 __printf_fp F
+GLIBC_2.32 __profile_frequency F
+GLIBC_2.32 __progname D 0x4
+GLIBC_2.32 __progname_full D 0x4
+GLIBC_2.32 __ptsname_r_chk F
+GLIBC_2.32 __pwrite64 F
+GLIBC_2.32 __rawmemchr F
+GLIBC_2.32 __rcmd_errstr D 0x4
+GLIBC_2.32 __read F
+GLIBC_2.32 __read_chk F
+GLIBC_2.32 __readlink_chk F
+GLIBC_2.32 __readlinkat_chk F
+GLIBC_2.32 __realloc_hook D 0x4
+GLIBC_2.32 __realpath_chk F
+GLIBC_2.32 __recv_chk F
+GLIBC_2.32 __recvfrom_chk F
+GLIBC_2.32 __register_atfork F
+GLIBC_2.32 __res_init F
+GLIBC_2.32 __res_nclose F
+GLIBC_2.32 __res_ninit F
+GLIBC_2.32 __res_randomid F
+GLIBC_2.32 __res_state F
+GLIBC_2.32 __rpc_thread_createerr F
+GLIBC_2.32 __rpc_thread_svc_fdset F
+GLIBC_2.32 __rpc_thread_svc_max_pollfd F
+GLIBC_2.32 __rpc_thread_svc_pollfd F
+GLIBC_2.32 __sbrk F
+GLIBC_2.32 __sched_cpualloc F
+GLIBC_2.32 __sched_cpucount F
+GLIBC_2.32 __sched_cpufree F
+GLIBC_2.32 __sched_get_priority_max F
+GLIBC_2.32 __sched_get_priority_min F
+GLIBC_2.32 __sched_getparam F
+GLIBC_2.32 __sched_getscheduler F
+GLIBC_2.32 __sched_setscheduler F
+GLIBC_2.32 __sched_yield F
+GLIBC_2.32 __select F
+GLIBC_2.32 __send F
+GLIBC_2.32 __setmntent F
+GLIBC_2.32 __setpgid F
+GLIBC_2.32 __sigaction F
+GLIBC_2.32 __signbit F
+GLIBC_2.32 __signbitf F
+GLIBC_2.32 __sigpause F
+GLIBC_2.32 __sigsetjmp F
+GLIBC_2.32 __sigsuspend F
+GLIBC_2.32 __snprintf_chk F
+GLIBC_2.32 __sprintf_chk F
+GLIBC_2.32 __stack_chk_fail F
+GLIBC_2.32 __statfs F
+GLIBC_2.32 __stpcpy F
+GLIBC_2.32 __stpcpy_chk F
+GLIBC_2.32 __stpncpy F
+GLIBC_2.32 __stpncpy_chk F
+GLIBC_2.32 __strcasecmp F
+GLIBC_2.32 __strcasecmp_l F
+GLIBC_2.32 __strcasestr F
+GLIBC_2.32 __strcat_chk F
+GLIBC_2.32 __strcoll_l F
+GLIBC_2.32 __strcpy_chk F
+GLIBC_2.32 __strdup F
+GLIBC_2.32 __strerror_r F
+GLIBC_2.32 __strfmon_l F
+GLIBC_2.32 __strftime_l F
+GLIBC_2.32 __strncasecmp_l F
+GLIBC_2.32 __strncat_chk F
+GLIBC_2.32 __strncpy_chk F
+GLIBC_2.32 __strndup F
+GLIBC_2.32 __strsep_g F
+GLIBC_2.32 __strtod_internal F
+GLIBC_2.32 __strtod_l F
+GLIBC_2.32 __strtof_internal F
+GLIBC_2.32 __strtof_l F
+GLIBC_2.32 __strtok_r F
+GLIBC_2.32 __strtol_internal F
+GLIBC_2.32 __strtol_l F
+GLIBC_2.32 __strtold_internal F
+GLIBC_2.32 __strtold_l F
+GLIBC_2.32 __strtoll_internal F
+GLIBC_2.32 __strtoll_l F
+GLIBC_2.32 __strtoul_internal F
+GLIBC_2.32 __strtoul_l F
+GLIBC_2.32 __strtoull_internal F
+GLIBC_2.32 __strtoull_l F
+GLIBC_2.32 __strverscmp F
+GLIBC_2.32 __strxfrm_l F
+GLIBC_2.32 __swprintf_chk F
+GLIBC_2.32 __sysconf F
+GLIBC_2.32 __syslog_chk F
+GLIBC_2.32 __sysv_signal F
+GLIBC_2.32 __timezone D 0x4
+GLIBC_2.32 __toascii_l F
+GLIBC_2.32 __tolower_l F
+GLIBC_2.32 __toupper_l F
+GLIBC_2.32 __towctrans F
+GLIBC_2.32 __towctrans_l F
+GLIBC_2.32 __towlower_l F
+GLIBC_2.32 __towupper_l F
+GLIBC_2.32 __ttyname_r_chk F
+GLIBC_2.32 __tzname D 0x8
+GLIBC_2.32 __uflow F
+GLIBC_2.32 __underflow F
+GLIBC_2.32 __uselocale F
+GLIBC_2.32 __vasprintf_chk F
+GLIBC_2.32 __vdprintf_chk F
+GLIBC_2.32 __vfork F
+GLIBC_2.32 __vfprintf_chk F
+GLIBC_2.32 __vfscanf F
+GLIBC_2.32 __vfwprintf_chk F
+GLIBC_2.32 __vprintf_chk F
+GLIBC_2.32 __vsnprintf F
+GLIBC_2.32 __vsnprintf_chk F
+GLIBC_2.32 __vsprintf_chk F
+GLIBC_2.32 __vsscanf F
+GLIBC_2.32 __vswprintf_chk F
+GLIBC_2.32 __vsyslog_chk F
+GLIBC_2.32 __vwprintf_chk F
+GLIBC_2.32 __wait F
+GLIBC_2.32 __waitpid F
+GLIBC_2.32 __wcpcpy_chk F
+GLIBC_2.32 __wcpncpy_chk F
+GLIBC_2.32 __wcrtomb_chk F
+GLIBC_2.32 __wcscasecmp_l F
+GLIBC_2.32 __wcscat_chk F
+GLIBC_2.32 __wcscoll_l F
+GLIBC_2.32 __wcscpy_chk F
+GLIBC_2.32 __wcsftime_l F
+GLIBC_2.32 __wcsncasecmp_l F
+GLIBC_2.32 __wcsncat_chk F
+GLIBC_2.32 __wcsncpy_chk F
+GLIBC_2.32 __wcsnrtombs_chk F
+GLIBC_2.32 __wcsrtombs_chk F
+GLIBC_2.32 __wcstod_internal F
+GLIBC_2.32 __wcstod_l F
+GLIBC_2.32 __wcstof_internal F
+GLIBC_2.32 __wcstof_l F
+GLIBC_2.32 __wcstol_internal F
+GLIBC_2.32 __wcstol_l F
+GLIBC_2.32 __wcstold_internal F
+GLIBC_2.32 __wcstold_l F
+GLIBC_2.32 __wcstoll_internal F
+GLIBC_2.32 __wcstoll_l F
+GLIBC_2.32 __wcstombs_chk F
+GLIBC_2.32 __wcstoul_internal F
+GLIBC_2.32 __wcstoul_l F
+GLIBC_2.32 __wcstoull_internal F
+GLIBC_2.32 __wcstoull_l F
+GLIBC_2.32 __wcsxfrm_l F
+GLIBC_2.32 __wctomb_chk F
+GLIBC_2.32 __wctrans_l F
+GLIBC_2.32 __wctype_l F
+GLIBC_2.32 __wmemcpy_chk F
+GLIBC_2.32 __wmemmove_chk F
+GLIBC_2.32 __wmempcpy_chk F
+GLIBC_2.32 __wmemset_chk F
+GLIBC_2.32 __woverflow F
+GLIBC_2.32 __wprintf_chk F
+GLIBC_2.32 __write F
+GLIBC_2.32 __wuflow F
+GLIBC_2.32 __wunderflow F
+GLIBC_2.32 __xmknod F
+GLIBC_2.32 __xmknodat F
+GLIBC_2.32 __xpg_basename F
+GLIBC_2.32 __xpg_sigpause F
+GLIBC_2.32 __xpg_strerror_r F
+GLIBC_2.32 __xstat F
+GLIBC_2.32 __xstat64 F
+GLIBC_2.32 _authenticate F
+GLIBC_2.32 _dl_mcount_wrapper F
+GLIBC_2.32 _dl_mcount_wrapper_check F
+GLIBC_2.32 _environ D 0x4
+GLIBC_2.32 _exit F
+GLIBC_2.32 _flushlbf F
+GLIBC_2.32 _libc_intl_domainname D 0x5
+GLIBC_2.32 _longjmp F
+GLIBC_2.32 _mcleanup F
+GLIBC_2.32 _mcount F
+GLIBC_2.32 _nl_default_dirname D 0x12
+GLIBC_2.32 _nl_domain_bindings D 0x4
+GLIBC_2.32 _nl_msg_cat_cntr D 0x4
+GLIBC_2.32 _null_auth D 0xc
+GLIBC_2.32 _obstack_allocated_p F
+GLIBC_2.32 _obstack_begin F
+GLIBC_2.32 _obstack_begin_1 F
+GLIBC_2.32 _obstack_free F
+GLIBC_2.32 _obstack_memory_used F
+GLIBC_2.32 _obstack_newchunk F
+GLIBC_2.32 _res D 0x200
+GLIBC_2.32 _res_hconf D 0x30
+GLIBC_2.32 _rpc_dtablesize F
+GLIBC_2.32 _seterr_reply F
+GLIBC_2.32 _setjmp F
+GLIBC_2.32 _sys_errlist D 0x21c
+GLIBC_2.32 _sys_nerr D 0x4
+GLIBC_2.32 _sys_siglist D 0x104
+GLIBC_2.32 _tolower F
+GLIBC_2.32 _toupper F
+GLIBC_2.32 a64l F
+GLIBC_2.32 abort F
+GLIBC_2.32 abs F
+GLIBC_2.32 accept F
+GLIBC_2.32 accept4 F
+GLIBC_2.32 access F
+GLIBC_2.32 acct F
+GLIBC_2.32 addmntent F
+GLIBC_2.32 addseverity F
+GLIBC_2.32 adjtime F
+GLIBC_2.32 adjtimex F
+GLIBC_2.32 alarm F
+GLIBC_2.32 aligned_alloc F
+GLIBC_2.32 alphasort F
+GLIBC_2.32 alphasort64 F
+GLIBC_2.32 argp_err_exit_status D 0x4
+GLIBC_2.32 argp_error F
+GLIBC_2.32 argp_failure F
+GLIBC_2.32 argp_help F
+GLIBC_2.32 argp_parse F
+GLIBC_2.32 argp_program_bug_address D 0x4
+GLIBC_2.32 argp_program_version D 0x4
+GLIBC_2.32 argp_program_version_hook D 0x4
+GLIBC_2.32 argp_state_help F
+GLIBC_2.32 argp_usage F
+GLIBC_2.32 argz_add F
+GLIBC_2.32 argz_add_sep F
+GLIBC_2.32 argz_append F
+GLIBC_2.32 argz_count F
+GLIBC_2.32 argz_create F
+GLIBC_2.32 argz_create_sep F
+GLIBC_2.32 argz_delete F
+GLIBC_2.32 argz_extract F
+GLIBC_2.32 argz_insert F
+GLIBC_2.32 argz_next F
+GLIBC_2.32 argz_replace F
+GLIBC_2.32 argz_stringify F
+GLIBC_2.32 asctime F
+GLIBC_2.32 asctime_r F
+GLIBC_2.32 asprintf F
+GLIBC_2.32 atof F
+GLIBC_2.32 atoi F
+GLIBC_2.32 atol F
+GLIBC_2.32 atoll F
+GLIBC_2.32 authdes_create F
+GLIBC_2.32 authdes_getucred F
+GLIBC_2.32 authdes_pk_create F
+GLIBC_2.32 authnone_create F
+GLIBC_2.32 authunix_create F
+GLIBC_2.32 authunix_create_default F
+GLIBC_2.32 backtrace F
+GLIBC_2.32 backtrace_symbols F
+GLIBC_2.32 backtrace_symbols_fd F
+GLIBC_2.32 basename F
+GLIBC_2.32 bcmp F
+GLIBC_2.32 bcopy F
+GLIBC_2.32 bind F
+GLIBC_2.32 bind_textdomain_codeset F
+GLIBC_2.32 bindresvport F
+GLIBC_2.32 bindtextdomain F
+GLIBC_2.32 brk F
+GLIBC_2.32 bsd_signal F
+GLIBC_2.32 bsearch F
+GLIBC_2.32 btowc F
+GLIBC_2.32 bzero F
+GLIBC_2.32 c16rtomb F
+GLIBC_2.32 c32rtomb F
+GLIBC_2.32 calloc F
+GLIBC_2.32 callrpc F
+GLIBC_2.32 canonicalize_file_name F
+GLIBC_2.32 capget F
+GLIBC_2.32 capset F
+GLIBC_2.32 catclose F
+GLIBC_2.32 catgets F
+GLIBC_2.32 catopen F
+GLIBC_2.32 cbc_crypt F
+GLIBC_2.32 cfgetispeed F
+GLIBC_2.32 cfgetospeed F
+GLIBC_2.32 cfmakeraw F
+GLIBC_2.32 cfsetispeed F
+GLIBC_2.32 cfsetospeed F
+GLIBC_2.32 cfsetspeed F
+GLIBC_2.32 chdir F
+GLIBC_2.32 chflags F
+GLIBC_2.32 chmod F
+GLIBC_2.32 chown F
+GLIBC_2.32 chroot F
+GLIBC_2.32 clearenv F
+GLIBC_2.32 clearerr F
+GLIBC_2.32 clearerr_unlocked F
+GLIBC_2.32 clnt_broadcast F
+GLIBC_2.32 clnt_create F
+GLIBC_2.32 clnt_pcreateerror F
+GLIBC_2.32 clnt_perrno F
+GLIBC_2.32 clnt_perror F
+GLIBC_2.32 clnt_spcreateerror F
+GLIBC_2.32 clnt_sperrno F
+GLIBC_2.32 clnt_sperror F
+GLIBC_2.32 clntraw_create F
+GLIBC_2.32 clnttcp_create F
+GLIBC_2.32 clntudp_bufcreate F
+GLIBC_2.32 clntudp_create F
+GLIBC_2.32 clntunix_create F
+GLIBC_2.32 clock F
+GLIBC_2.32 clock_adjtime F
+GLIBC_2.32 clock_getcpuclockid F
+GLIBC_2.32 clock_getres F
+GLIBC_2.32 clock_gettime F
+GLIBC_2.32 clock_nanosleep F
+GLIBC_2.32 clock_settime F
+GLIBC_2.32 clone F
+GLIBC_2.32 close F
+GLIBC_2.32 closedir F
+GLIBC_2.32 closelog F
+GLIBC_2.32 confstr F
+GLIBC_2.32 connect F
+GLIBC_2.32 copy_file_range F
+GLIBC_2.32 copysign F
+GLIBC_2.32 copysignf F
+GLIBC_2.32 copysignl F
+GLIBC_2.32 creat F
+GLIBC_2.32 creat64 F
+GLIBC_2.32 ctermid F
+GLIBC_2.32 ctime F
+GLIBC_2.32 ctime_r F
+GLIBC_2.32 cuserid F
+GLIBC_2.32 daemon F
+GLIBC_2.32 daylight D 0x4
+GLIBC_2.32 dcgettext F
+GLIBC_2.32 dcngettext F
+GLIBC_2.32 delete_module F
+GLIBC_2.32 des_setparity F
+GLIBC_2.32 dgettext F
+GLIBC_2.32 difftime F
+GLIBC_2.32 dirfd F
+GLIBC_2.32 dirname F
+GLIBC_2.32 div F
+GLIBC_2.32 dl_iterate_phdr F
+GLIBC_2.32 dngettext F
+GLIBC_2.32 dprintf F
+GLIBC_2.32 drand48 F
+GLIBC_2.32 drand48_r F
+GLIBC_2.32 dup F
+GLIBC_2.32 dup2 F
+GLIBC_2.32 dup3 F
+GLIBC_2.32 duplocale F
+GLIBC_2.32 dysize F
+GLIBC_2.32 eaccess F
+GLIBC_2.32 ecb_crypt F
+GLIBC_2.32 ecvt F
+GLIBC_2.32 ecvt_r F
+GLIBC_2.32 endaliasent F
+GLIBC_2.32 endfsent F
+GLIBC_2.32 endgrent F
+GLIBC_2.32 endhostent F
+GLIBC_2.32 endmntent F
+GLIBC_2.32 endnetent F
+GLIBC_2.32 endnetgrent F
+GLIBC_2.32 endprotoent F
+GLIBC_2.32 endpwent F
+GLIBC_2.32 endrpcent F
+GLIBC_2.32 endservent F
+GLIBC_2.32 endsgent F
+GLIBC_2.32 endspent F
+GLIBC_2.32 endttyent F
+GLIBC_2.32 endusershell F
+GLIBC_2.32 endutent F
+GLIBC_2.32 endutxent F
+GLIBC_2.32 environ D 0x4
+GLIBC_2.32 envz_add F
+GLIBC_2.32 envz_entry F
+GLIBC_2.32 envz_get F
+GLIBC_2.32 envz_merge F
+GLIBC_2.32 envz_remove F
+GLIBC_2.32 envz_strip F
+GLIBC_2.32 epoll_create F
+GLIBC_2.32 epoll_create1 F
+GLIBC_2.32 epoll_ctl F
+GLIBC_2.32 epoll_pwait F
+GLIBC_2.32 epoll_wait F
+GLIBC_2.32 erand48 F
+GLIBC_2.32 erand48_r F
+GLIBC_2.32 err F
+GLIBC_2.32 error F
+GLIBC_2.32 error_at_line F
+GLIBC_2.32 error_message_count D 0x4
+GLIBC_2.32 error_one_per_line D 0x4
+GLIBC_2.32 error_print_progname D 0x4
+GLIBC_2.32 errx F
+GLIBC_2.32 ether_aton F
+GLIBC_2.32 ether_aton_r F
+GLIBC_2.32 ether_hostton F
+GLIBC_2.32 ether_line F
+GLIBC_2.32 ether_ntoa F
+GLIBC_2.32 ether_ntoa_r F
+GLIBC_2.32 ether_ntohost F
+GLIBC_2.32 euidaccess F
+GLIBC_2.32 eventfd F
+GLIBC_2.32 eventfd_read F
+GLIBC_2.32 eventfd_write F
+GLIBC_2.32 execl F
+GLIBC_2.32 execle F
+GLIBC_2.32 execlp F
+GLIBC_2.32 execv F
+GLIBC_2.32 execve F
+GLIBC_2.32 execvp F
+GLIBC_2.32 execvpe F
+GLIBC_2.32 exit F
+GLIBC_2.32 explicit_bzero F
+GLIBC_2.32 faccessat F
+GLIBC_2.32 fallocate F
+GLIBC_2.32 fallocate64 F
+GLIBC_2.32 fanotify_init F
+GLIBC_2.32 fanotify_mark F
+GLIBC_2.32 fchdir F
+GLIBC_2.32 fchflags F
+GLIBC_2.32 fchmod F
+GLIBC_2.32 fchmodat F
+GLIBC_2.32 fchown F
+GLIBC_2.32 fchownat F
+GLIBC_2.32 fclose F
+GLIBC_2.32 fcloseall F
+GLIBC_2.32 fcntl F
+GLIBC_2.32 fcntl64 F
+GLIBC_2.32 fcvt F
+GLIBC_2.32 fcvt_r F
+GLIBC_2.32 fdatasync F
+GLIBC_2.32 fdopen F
+GLIBC_2.32 fdopendir F
+GLIBC_2.32 feof F
+GLIBC_2.32 feof_unlocked F
+GLIBC_2.32 ferror F
+GLIBC_2.32 ferror_unlocked F
+GLIBC_2.32 fexecve F
+GLIBC_2.32 fflush F
+GLIBC_2.32 fflush_unlocked F
+GLIBC_2.32 ffs F
+GLIBC_2.32 ffsl F
+GLIBC_2.32 ffsll F
+GLIBC_2.32 fgetc F
+GLIBC_2.32 fgetc_unlocked F
+GLIBC_2.32 fgetgrent F
+GLIBC_2.32 fgetgrent_r F
+GLIBC_2.32 fgetpos F
+GLIBC_2.32 fgetpos64 F
+GLIBC_2.32 fgetpwent F
+GLIBC_2.32 fgetpwent_r F
+GLIBC_2.32 fgets F
+GLIBC_2.32 fgets_unlocked F
+GLIBC_2.32 fgetsgent F
+GLIBC_2.32 fgetsgent_r F
+GLIBC_2.32 fgetspent F
+GLIBC_2.32 fgetspent_r F
+GLIBC_2.32 fgetwc F
+GLIBC_2.32 fgetwc_unlocked F
+GLIBC_2.32 fgetws F
+GLIBC_2.32 fgetws_unlocked F
+GLIBC_2.32 fgetxattr F
+GLIBC_2.32 fileno F
+GLIBC_2.32 fileno_unlocked F
+GLIBC_2.32 finite F
+GLIBC_2.32 finitef F
+GLIBC_2.32 finitel F
+GLIBC_2.32 flistxattr F
+GLIBC_2.32 flock F
+GLIBC_2.32 flockfile F
+GLIBC_2.32 fmemopen F
+GLIBC_2.32 fmtmsg F
+GLIBC_2.32 fnmatch F
+GLIBC_2.32 fopen F
+GLIBC_2.32 fopen64 F
+GLIBC_2.32 fopencookie F
+GLIBC_2.32 fork F
+GLIBC_2.32 fpathconf F
+GLIBC_2.32 fprintf F
+GLIBC_2.32 fputc F
+GLIBC_2.32 fputc_unlocked F
+GLIBC_2.32 fputs F
+GLIBC_2.32 fputs_unlocked F
+GLIBC_2.32 fputwc F
+GLIBC_2.32 fputwc_unlocked F
+GLIBC_2.32 fputws F
+GLIBC_2.32 fputws_unlocked F
+GLIBC_2.32 fread F
+GLIBC_2.32 fread_unlocked F
+GLIBC_2.32 free F
+GLIBC_2.32 freeaddrinfo F
+GLIBC_2.32 freeifaddrs F
+GLIBC_2.32 freelocale F
+GLIBC_2.32 fremovexattr F
+GLIBC_2.32 freopen F
+GLIBC_2.32 freopen64 F
+GLIBC_2.32 frexp F
+GLIBC_2.32 frexpf F
+GLIBC_2.32 frexpl F
+GLIBC_2.32 fscanf F
+GLIBC_2.32 fseek F
+GLIBC_2.32 fseeko F
+GLIBC_2.32 fseeko64 F
+GLIBC_2.32 fsetpos F
+GLIBC_2.32 fsetpos64 F
+GLIBC_2.32 fsetxattr F
+GLIBC_2.32 fstatfs F
+GLIBC_2.32 fstatfs64 F
+GLIBC_2.32 fstatvfs F
+GLIBC_2.32 fstatvfs64 F
+GLIBC_2.32 fsync F
+GLIBC_2.32 ftell F
+GLIBC_2.32 ftello F
+GLIBC_2.32 ftello64 F
+GLIBC_2.32 ftime F
+GLIBC_2.32 ftok F
+GLIBC_2.32 ftruncate F
+GLIBC_2.32 ftruncate64 F
+GLIBC_2.32 ftrylockfile F
+GLIBC_2.32 fts64_children F
+GLIBC_2.32 fts64_close F
+GLIBC_2.32 fts64_open F
+GLIBC_2.32 fts64_read F
+GLIBC_2.32 fts64_set F
+GLIBC_2.32 fts_children F
+GLIBC_2.32 fts_close F
+GLIBC_2.32 fts_open F
+GLIBC_2.32 fts_read F
+GLIBC_2.32 fts_set F
+GLIBC_2.32 ftw F
+GLIBC_2.32 ftw64 F
+GLIBC_2.32 funlockfile F
+GLIBC_2.32 futimens F
+GLIBC_2.32 futimes F
+GLIBC_2.32 futimesat F
+GLIBC_2.32 fwide F
+GLIBC_2.32 fwprintf F
+GLIBC_2.32 fwrite F
+GLIBC_2.32 fwrite_unlocked F
+GLIBC_2.32 fwscanf F
+GLIBC_2.32 gai_strerror F
+GLIBC_2.32 gcvt F
+GLIBC_2.32 get_avphys_pages F
+GLIBC_2.32 get_current_dir_name F
+GLIBC_2.32 get_myaddress F
+GLIBC_2.32 get_nprocs F
+GLIBC_2.32 get_nprocs_conf F
+GLIBC_2.32 get_phys_pages F
+GLIBC_2.32 getaddrinfo F
+GLIBC_2.32 getaliasbyname F
+GLIBC_2.32 getaliasbyname_r F
+GLIBC_2.32 getaliasent F
+GLIBC_2.32 getaliasent_r F
+GLIBC_2.32 getauxval F
+GLIBC_2.32 getc F
+GLIBC_2.32 getc_unlocked F
+GLIBC_2.32 getchar F
+GLIBC_2.32 getchar_unlocked F
+GLIBC_2.32 getcontext F
+GLIBC_2.32 getcpu F
+GLIBC_2.32 getcwd F
+GLIBC_2.32 getdate F
+GLIBC_2.32 getdate_err D 0x4
+GLIBC_2.32 getdate_r F
+GLIBC_2.32 getdelim F
+GLIBC_2.32 getdents64 F
+GLIBC_2.32 getdirentries F
+GLIBC_2.32 getdirentries64 F
+GLIBC_2.32 getdomainname F
+GLIBC_2.32 getdtablesize F
+GLIBC_2.32 getegid F
+GLIBC_2.32 getentropy F
+GLIBC_2.32 getenv F
+GLIBC_2.32 geteuid F
+GLIBC_2.32 getfsent F
+GLIBC_2.32 getfsfile F
+GLIBC_2.32 getfsspec F
+GLIBC_2.32 getgid F
+GLIBC_2.32 getgrent F
+GLIBC_2.32 getgrent_r F
+GLIBC_2.32 getgrgid F
+GLIBC_2.32 getgrgid_r F
+GLIBC_2.32 getgrnam F
+GLIBC_2.32 getgrnam_r F
+GLIBC_2.32 getgrouplist F
+GLIBC_2.32 getgroups F
+GLIBC_2.32 gethostbyaddr F
+GLIBC_2.32 gethostbyaddr_r F
+GLIBC_2.32 gethostbyname F
+GLIBC_2.32 gethostbyname2 F
+GLIBC_2.32 gethostbyname2_r F
+GLIBC_2.32 gethostbyname_r F
+GLIBC_2.32 gethostent F
+GLIBC_2.32 gethostent_r F
+GLIBC_2.32 gethostid F
+GLIBC_2.32 gethostname F
+GLIBC_2.32 getifaddrs F
+GLIBC_2.32 getipv4sourcefilter F
+GLIBC_2.32 getitimer F
+GLIBC_2.32 getline F
+GLIBC_2.32 getloadavg F
+GLIBC_2.32 getlogin F
+GLIBC_2.32 getlogin_r F
+GLIBC_2.32 getmntent F
+GLIBC_2.32 getmntent_r F
+GLIBC_2.32 getnameinfo F
+GLIBC_2.32 getnetbyaddr F
+GLIBC_2.32 getnetbyaddr_r F
+GLIBC_2.32 getnetbyname F
+GLIBC_2.32 getnetbyname_r F
+GLIBC_2.32 getnetent F
+GLIBC_2.32 getnetent_r F
+GLIBC_2.32 getnetgrent F
+GLIBC_2.32 getnetgrent_r F
+GLIBC_2.32 getnetname F
+GLIBC_2.32 getopt F
+GLIBC_2.32 getopt_long F
+GLIBC_2.32 getopt_long_only F
+GLIBC_2.32 getpagesize F
+GLIBC_2.32 getpass F
+GLIBC_2.32 getpeername F
+GLIBC_2.32 getpgid F
+GLIBC_2.32 getpgrp F
+GLIBC_2.32 getpid F
+GLIBC_2.32 getppid F
+GLIBC_2.32 getpriority F
+GLIBC_2.32 getprotobyname F
+GLIBC_2.32 getprotobyname_r F
+GLIBC_2.32 getprotobynumber F
+GLIBC_2.32 getprotobynumber_r F
+GLIBC_2.32 getprotoent F
+GLIBC_2.32 getprotoent_r F
+GLIBC_2.32 getpt F
+GLIBC_2.32 getpublickey F
+GLIBC_2.32 getpw F
+GLIBC_2.32 getpwent F
+GLIBC_2.32 getpwent_r F
+GLIBC_2.32 getpwnam F
+GLIBC_2.32 getpwnam_r F
+GLIBC_2.32 getpwuid F
+GLIBC_2.32 getpwuid_r F
+GLIBC_2.32 getrandom F
+GLIBC_2.32 getresgid F
+GLIBC_2.32 getresuid F
+GLIBC_2.32 getrlimit F
+GLIBC_2.32 getrlimit64 F
+GLIBC_2.32 getrpcbyname F
+GLIBC_2.32 getrpcbyname_r F
+GLIBC_2.32 getrpcbynumber F
+GLIBC_2.32 getrpcbynumber_r F
+GLIBC_2.32 getrpcent F
+GLIBC_2.32 getrpcent_r F
+GLIBC_2.32 getrpcport F
+GLIBC_2.32 getrusage F
+GLIBC_2.32 gets F
+GLIBC_2.32 getsecretkey F
+GLIBC_2.32 getservbyname F
+GLIBC_2.32 getservbyname_r F
+GLIBC_2.32 getservbyport F
+GLIBC_2.32 getservbyport_r F
+GLIBC_2.32 getservent F
+GLIBC_2.32 getservent_r F
+GLIBC_2.32 getsgent F
+GLIBC_2.32 getsgent_r F
+GLIBC_2.32 getsgnam F
+GLIBC_2.32 getsgnam_r F
+GLIBC_2.32 getsid F
+GLIBC_2.32 getsockname F
+GLIBC_2.32 getsockopt F
+GLIBC_2.32 getsourcefilter F
+GLIBC_2.32 getspent F
+GLIBC_2.32 getspent_r F
+GLIBC_2.32 getspnam F
+GLIBC_2.32 getspnam_r F
+GLIBC_2.32 getsubopt F
+GLIBC_2.32 gettext F
+GLIBC_2.32 gettid F
+GLIBC_2.32 gettimeofday F
+GLIBC_2.32 getttyent F
+GLIBC_2.32 getttynam F
+GLIBC_2.32 getuid F
+GLIBC_2.32 getusershell F
+GLIBC_2.32 getutent F
+GLIBC_2.32 getutent_r F
+GLIBC_2.32 getutid F
+GLIBC_2.32 getutid_r F
+GLIBC_2.32 getutline F
+GLIBC_2.32 getutline_r F
+GLIBC_2.32 getutmp F
+GLIBC_2.32 getutmpx F
+GLIBC_2.32 getutxent F
+GLIBC_2.32 getutxid F
+GLIBC_2.32 getutxline F
+GLIBC_2.32 getw F
+GLIBC_2.32 getwc F
+GLIBC_2.32 getwc_unlocked F
+GLIBC_2.32 getwchar F
+GLIBC_2.32 getwchar_unlocked F
+GLIBC_2.32 getwd F
+GLIBC_2.32 getxattr F
+GLIBC_2.32 glob F
+GLIBC_2.32 glob64 F
+GLIBC_2.32 glob_pattern_p F
+GLIBC_2.32 globfree F
+GLIBC_2.32 globfree64 F
+GLIBC_2.32 gmtime F
+GLIBC_2.32 gmtime_r F
+GLIBC_2.32 gnu_dev_major F
+GLIBC_2.32 gnu_dev_makedev F
+GLIBC_2.32 gnu_dev_minor F
+GLIBC_2.32 gnu_get_libc_release F
+GLIBC_2.32 gnu_get_libc_version F
+GLIBC_2.32 grantpt F
+GLIBC_2.32 group_member F
+GLIBC_2.32 gsignal F
+GLIBC_2.32 gtty F
+GLIBC_2.32 h_errlist D 0x14
+GLIBC_2.32 h_nerr D 0x4
+GLIBC_2.32 hasmntopt F
+GLIBC_2.32 hcreate F
+GLIBC_2.32 hcreate_r F
+GLIBC_2.32 hdestroy F
+GLIBC_2.32 hdestroy_r F
+GLIBC_2.32 herror F
+GLIBC_2.32 host2netname F
+GLIBC_2.32 hsearch F
+GLIBC_2.32 hsearch_r F
+GLIBC_2.32 hstrerror F
+GLIBC_2.32 htonl F
+GLIBC_2.32 htons F
+GLIBC_2.32 iconv F
+GLIBC_2.32 iconv_close F
+GLIBC_2.32 iconv_open F
+GLIBC_2.32 if_freenameindex F
+GLIBC_2.32 if_indextoname F
+GLIBC_2.32 if_nameindex F
+GLIBC_2.32 if_nametoindex F
+GLIBC_2.32 imaxabs F
+GLIBC_2.32 imaxdiv F
+GLIBC_2.32 in6addr_any D 0x10
+GLIBC_2.32 in6addr_loopback D 0x10
+GLIBC_2.32 index F
+GLIBC_2.32 inet6_opt_append F
+GLIBC_2.32 inet6_opt_find F
+GLIBC_2.32 inet6_opt_finish F
+GLIBC_2.32 inet6_opt_get_val F
+GLIBC_2.32 inet6_opt_init F
+GLIBC_2.32 inet6_opt_next F
+GLIBC_2.32 inet6_opt_set_val F
+GLIBC_2.32 inet6_option_alloc F
+GLIBC_2.32 inet6_option_append F
+GLIBC_2.32 inet6_option_find F
+GLIBC_2.32 inet6_option_init F
+GLIBC_2.32 inet6_option_next F
+GLIBC_2.32 inet6_option_space F
+GLIBC_2.32 inet6_rth_add F
+GLIBC_2.32 inet6_rth_getaddr F
+GLIBC_2.32 inet6_rth_init F
+GLIBC_2.32 inet6_rth_reverse F
+GLIBC_2.32 inet6_rth_segments F
+GLIBC_2.32 inet6_rth_space F
+GLIBC_2.32 inet_addr F
+GLIBC_2.32 inet_aton F
+GLIBC_2.32 inet_lnaof F
+GLIBC_2.32 inet_makeaddr F
+GLIBC_2.32 inet_netof F
+GLIBC_2.32 inet_network F
+GLIBC_2.32 inet_nsap_addr F
+GLIBC_2.32 inet_nsap_ntoa F
+GLIBC_2.32 inet_ntoa F
+GLIBC_2.32 inet_ntop F
+GLIBC_2.32 inet_pton F
+GLIBC_2.32 init_module F
+GLIBC_2.32 initgroups F
+GLIBC_2.32 initstate F
+GLIBC_2.32 initstate_r F
+GLIBC_2.32 innetgr F
+GLIBC_2.32 inotify_add_watch F
+GLIBC_2.32 inotify_init F
+GLIBC_2.32 inotify_init1 F
+GLIBC_2.32 inotify_rm_watch F
+GLIBC_2.32 insque F
+GLIBC_2.32 ioctl F
+GLIBC_2.32 iruserok F
+GLIBC_2.32 iruserok_af F
+GLIBC_2.32 isalnum F
+GLIBC_2.32 isalnum_l F
+GLIBC_2.32 isalpha F
+GLIBC_2.32 isalpha_l F
+GLIBC_2.32 isascii F
+GLIBC_2.32 isatty F
+GLIBC_2.32 isblank F
+GLIBC_2.32 isblank_l F
+GLIBC_2.32 iscntrl F
+GLIBC_2.32 iscntrl_l F
+GLIBC_2.32 isctype F
+GLIBC_2.32 isdigit F
+GLIBC_2.32 isdigit_l F
+GLIBC_2.32 isfdtype F
+GLIBC_2.32 isgraph F
+GLIBC_2.32 isgraph_l F
+GLIBC_2.32 isinf F
+GLIBC_2.32 isinff F
+GLIBC_2.32 isinfl F
+GLIBC_2.32 islower F
+GLIBC_2.32 islower_l F
+GLIBC_2.32 isnan F
+GLIBC_2.32 isnanf F
+GLIBC_2.32 isnanl F
+GLIBC_2.32 isprint F
+GLIBC_2.32 isprint_l F
+GLIBC_2.32 ispunct F
+GLIBC_2.32 ispunct_l F
+GLIBC_2.32 isspace F
+GLIBC_2.32 isspace_l F
+GLIBC_2.32 isupper F
+GLIBC_2.32 isupper_l F
+GLIBC_2.32 iswalnum F
+GLIBC_2.32 iswalnum_l F
+GLIBC_2.32 iswalpha F
+GLIBC_2.32 iswalpha_l F
+GLIBC_2.32 iswblank F
+GLIBC_2.32 iswblank_l F
+GLIBC_2.32 iswcntrl F
+GLIBC_2.32 iswcntrl_l F
+GLIBC_2.32 iswctype F
+GLIBC_2.32 iswctype_l F
+GLIBC_2.32 iswdigit F
+GLIBC_2.32 iswdigit_l F
+GLIBC_2.32 iswgraph F
+GLIBC_2.32 iswgraph_l F
+GLIBC_2.32 iswlower F
+GLIBC_2.32 iswlower_l F
+GLIBC_2.32 iswprint F
+GLIBC_2.32 iswprint_l F
+GLIBC_2.32 iswpunct F
+GLIBC_2.32 iswpunct_l F
+GLIBC_2.32 iswspace F
+GLIBC_2.32 iswspace_l F
+GLIBC_2.32 iswupper F
+GLIBC_2.32 iswupper_l F
+GLIBC_2.32 iswxdigit F
+GLIBC_2.32 iswxdigit_l F
+GLIBC_2.32 isxdigit F
+GLIBC_2.32 isxdigit_l F
+GLIBC_2.32 jrand48 F
+GLIBC_2.32 jrand48_r F
+GLIBC_2.32 key_decryptsession F
+GLIBC_2.32 key_decryptsession_pk F
+GLIBC_2.32 key_encryptsession F
+GLIBC_2.32 key_encryptsession_pk F
+GLIBC_2.32 key_gendes F
+GLIBC_2.32 key_get_conv F
+GLIBC_2.32 key_secretkey_is_set F
+GLIBC_2.32 key_setnet F
+GLIBC_2.32 key_setsecret F
+GLIBC_2.32 kill F
+GLIBC_2.32 killpg F
+GLIBC_2.32 klogctl F
+GLIBC_2.32 l64a F
+GLIBC_2.32 labs F
+GLIBC_2.32 lchmod F
+GLIBC_2.32 lchown F
+GLIBC_2.32 lckpwdf F
+GLIBC_2.32 lcong48 F
+GLIBC_2.32 lcong48_r F
+GLIBC_2.32 ldexp F
+GLIBC_2.32 ldexpf F
+GLIBC_2.32 ldexpl F
+GLIBC_2.32 ldiv F
+GLIBC_2.32 lfind F
+GLIBC_2.32 lgetxattr F
+GLIBC_2.32 link F
+GLIBC_2.32 linkat F
+GLIBC_2.32 listen F
+GLIBC_2.32 listxattr F
+GLIBC_2.32 llabs F
+GLIBC_2.32 lldiv F
+GLIBC_2.32 llistxattr F
+GLIBC_2.32 localeconv F
+GLIBC_2.32 localtime F
+GLIBC_2.32 localtime_r F
+GLIBC_2.32 lockf F
+GLIBC_2.32 lockf64 F
+GLIBC_2.32 longjmp F
+GLIBC_2.32 lrand48 F
+GLIBC_2.32 lrand48_r F
+GLIBC_2.32 lremovexattr F
+GLIBC_2.32 lsearch F
+GLIBC_2.32 lseek F
+GLIBC_2.32 lseek64 F
+GLIBC_2.32 lsetxattr F
+GLIBC_2.32 lutimes F
+GLIBC_2.32 madvise F
+GLIBC_2.32 makecontext F
+GLIBC_2.32 mallinfo F
+GLIBC_2.32 malloc F
+GLIBC_2.32 malloc_info F
+GLIBC_2.32 malloc_stats F
+GLIBC_2.32 malloc_trim F
+GLIBC_2.32 malloc_usable_size F
+GLIBC_2.32 mallopt F
+GLIBC_2.32 mallwatch D 0x4
+GLIBC_2.32 mblen F
+GLIBC_2.32 mbrlen F
+GLIBC_2.32 mbrtoc16 F
+GLIBC_2.32 mbrtoc32 F
+GLIBC_2.32 mbrtowc F
+GLIBC_2.32 mbsinit F
+GLIBC_2.32 mbsnrtowcs F
+GLIBC_2.32 mbsrtowcs F
+GLIBC_2.32 mbstowcs F
+GLIBC_2.32 mbtowc F
+GLIBC_2.32 mcheck F
+GLIBC_2.32 mcheck_check_all F
+GLIBC_2.32 mcheck_pedantic F
+GLIBC_2.32 mcount F
+GLIBC_2.32 memalign F
+GLIBC_2.32 memccpy F
+GLIBC_2.32 memchr F
+GLIBC_2.32 memcmp F
+GLIBC_2.32 memcpy F
+GLIBC_2.32 memfd_create F
+GLIBC_2.32 memfrob F
+GLIBC_2.32 memmem F
+GLIBC_2.32 memmove F
+GLIBC_2.32 mempcpy F
+GLIBC_2.32 memrchr F
+GLIBC_2.32 memset F
+GLIBC_2.32 mincore F
+GLIBC_2.32 mkdir F
+GLIBC_2.32 mkdirat F
+GLIBC_2.32 mkdtemp F
+GLIBC_2.32 mkfifo F
+GLIBC_2.32 mkfifoat F
+GLIBC_2.32 mkostemp F
+GLIBC_2.32 mkostemp64 F
+GLIBC_2.32 mkostemps F
+GLIBC_2.32 mkostemps64 F
+GLIBC_2.32 mkstemp F
+GLIBC_2.32 mkstemp64 F
+GLIBC_2.32 mkstemps F
+GLIBC_2.32 mkstemps64 F
+GLIBC_2.32 mktemp F
+GLIBC_2.32 mktime F
+GLIBC_2.32 mlock F
+GLIBC_2.32 mlock2 F
+GLIBC_2.32 mlockall F
+GLIBC_2.32 mmap F
+GLIBC_2.32 mmap64 F
+GLIBC_2.32 modf F
+GLIBC_2.32 modff F
+GLIBC_2.32 modfl F
+GLIBC_2.32 moncontrol F
+GLIBC_2.32 monstartup F
+GLIBC_2.32 mount F
+GLIBC_2.32 mprobe F
+GLIBC_2.32 mprotect F
+GLIBC_2.32 mrand48 F
+GLIBC_2.32 mrand48_r F
+GLIBC_2.32 mremap F
+GLIBC_2.32 msgctl F
+GLIBC_2.32 msgget F
+GLIBC_2.32 msgrcv F
+GLIBC_2.32 msgsnd F
+GLIBC_2.32 msync F
+GLIBC_2.32 mtrace F
+GLIBC_2.32 munlock F
+GLIBC_2.32 munlockall F
+GLIBC_2.32 munmap F
+GLIBC_2.32 muntrace F
+GLIBC_2.32 name_to_handle_at F
+GLIBC_2.32 nanosleep F
+GLIBC_2.32 netname2host F
+GLIBC_2.32 netname2user F
+GLIBC_2.32 newlocale F
+GLIBC_2.32 nftw F
+GLIBC_2.32 nftw64 F
+GLIBC_2.32 ngettext F
+GLIBC_2.32 nice F
+GLIBC_2.32 nl_langinfo F
+GLIBC_2.32 nl_langinfo_l F
+GLIBC_2.32 nrand48 F
+GLIBC_2.32 nrand48_r F
+GLIBC_2.32 ntohl F
+GLIBC_2.32 ntohs F
+GLIBC_2.32 ntp_adjtime F
+GLIBC_2.32 ntp_gettime F
+GLIBC_2.32 ntp_gettimex F
+GLIBC_2.32 obstack_alloc_failed_handler D 0x4
+GLIBC_2.32 obstack_exit_failure D 0x4
+GLIBC_2.32 obstack_free F
+GLIBC_2.32 obstack_printf F
+GLIBC_2.32 obstack_vprintf F
+GLIBC_2.32 on_exit F
+GLIBC_2.32 open F
+GLIBC_2.32 open64 F
+GLIBC_2.32 open_by_handle_at F
+GLIBC_2.32 open_memstream F
+GLIBC_2.32 open_wmemstream F
+GLIBC_2.32 openat F
+GLIBC_2.32 openat64 F
+GLIBC_2.32 opendir F
+GLIBC_2.32 openlog F
+GLIBC_2.32 optarg D 0x4
+GLIBC_2.32 opterr D 0x4
+GLIBC_2.32 optind D 0x4
+GLIBC_2.32 optopt D 0x4
+GLIBC_2.32 parse_printf_format F
+GLIBC_2.32 passwd2des F
+GLIBC_2.32 pathconf F
+GLIBC_2.32 pause F
+GLIBC_2.32 pclose F
+GLIBC_2.32 perror F
+GLIBC_2.32 personality F
+GLIBC_2.32 pipe F
+GLIBC_2.32 pipe2 F
+GLIBC_2.32 pivot_root F
+GLIBC_2.32 pkey_alloc F
+GLIBC_2.32 pkey_free F
+GLIBC_2.32 pkey_get F
+GLIBC_2.32 pkey_mprotect F
+GLIBC_2.32 pkey_set F
+GLIBC_2.32 pmap_getmaps F
+GLIBC_2.32 pmap_getport F
+GLIBC_2.32 pmap_rmtcall F
+GLIBC_2.32 pmap_set F
+GLIBC_2.32 pmap_unset F
+GLIBC_2.32 poll F
+GLIBC_2.32 popen F
+GLIBC_2.32 posix_fadvise F
+GLIBC_2.32 posix_fadvise64 F
+GLIBC_2.32 posix_fallocate F
+GLIBC_2.32 posix_fallocate64 F
+GLIBC_2.32 posix_madvise F
+GLIBC_2.32 posix_memalign F
+GLIBC_2.32 posix_openpt F
+GLIBC_2.32 posix_spawn F
+GLIBC_2.32 posix_spawn_file_actions_addchdir_np F
+GLIBC_2.32 posix_spawn_file_actions_addclose F
+GLIBC_2.32 posix_spawn_file_actions_adddup2 F
+GLIBC_2.32 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.32 posix_spawn_file_actions_addopen F
+GLIBC_2.32 posix_spawn_file_actions_destroy F
+GLIBC_2.32 posix_spawn_file_actions_init F
+GLIBC_2.32 posix_spawnattr_destroy F
+GLIBC_2.32 posix_spawnattr_getflags F
+GLIBC_2.32 posix_spawnattr_getpgroup F
+GLIBC_2.32 posix_spawnattr_getschedparam F
+GLIBC_2.32 posix_spawnattr_getschedpolicy F
+GLIBC_2.32 posix_spawnattr_getsigdefault F
+GLIBC_2.32 posix_spawnattr_getsigmask F
+GLIBC_2.32 posix_spawnattr_init F
+GLIBC_2.32 posix_spawnattr_setflags F
+GLIBC_2.32 posix_spawnattr_setpgroup F
+GLIBC_2.32 posix_spawnattr_setschedparam F
+GLIBC_2.32 posix_spawnattr_setschedpolicy F
+GLIBC_2.32 posix_spawnattr_setsigdefault F
+GLIBC_2.32 posix_spawnattr_setsigmask F
+GLIBC_2.32 posix_spawnp F
+GLIBC_2.32 ppoll F
+GLIBC_2.32 prctl F
+GLIBC_2.32 pread F
+GLIBC_2.32 pread64 F
+GLIBC_2.32 preadv F
+GLIBC_2.32 preadv2 F
+GLIBC_2.32 preadv64 F
+GLIBC_2.32 preadv64v2 F
+GLIBC_2.32 printf F
+GLIBC_2.32 printf_size F
+GLIBC_2.32 printf_size_info F
+GLIBC_2.32 prlimit F
+GLIBC_2.32 prlimit64 F
+GLIBC_2.32 process_vm_readv F
+GLIBC_2.32 process_vm_writev F
+GLIBC_2.32 profil F
+GLIBC_2.32 program_invocation_name D 0x4
+GLIBC_2.32 program_invocation_short_name D 0x4
+GLIBC_2.32 pselect F
+GLIBC_2.32 psiginfo F
+GLIBC_2.32 psignal F
+GLIBC_2.32 pthread_attr_destroy F
+GLIBC_2.32 pthread_attr_getdetachstate F
+GLIBC_2.32 pthread_attr_getinheritsched F
+GLIBC_2.32 pthread_attr_getschedparam F
+GLIBC_2.32 pthread_attr_getschedpolicy F
+GLIBC_2.32 pthread_attr_getscope F
+GLIBC_2.32 pthread_attr_init F
+GLIBC_2.32 pthread_attr_setdetachstate F
+GLIBC_2.32 pthread_attr_setinheritsched F
+GLIBC_2.32 pthread_attr_setschedparam F
+GLIBC_2.32 pthread_attr_setschedpolicy F
+GLIBC_2.32 pthread_attr_setscope F
+GLIBC_2.32 pthread_cond_broadcast F
+GLIBC_2.32 pthread_cond_destroy F
+GLIBC_2.32 pthread_cond_init F
+GLIBC_2.32 pthread_cond_signal F
+GLIBC_2.32 pthread_cond_timedwait F
+GLIBC_2.32 pthread_cond_wait F
+GLIBC_2.32 pthread_condattr_destroy F
+GLIBC_2.32 pthread_condattr_init F
+GLIBC_2.32 pthread_equal F
+GLIBC_2.32 pthread_exit F
+GLIBC_2.32 pthread_getschedparam F
+GLIBC_2.32 pthread_mutex_destroy F
+GLIBC_2.32 pthread_mutex_init F
+GLIBC_2.32 pthread_mutex_lock F
+GLIBC_2.32 pthread_mutex_unlock F
+GLIBC_2.32 pthread_self F
+GLIBC_2.32 pthread_setcancelstate F
+GLIBC_2.32 pthread_setcanceltype F
+GLIBC_2.32 pthread_setschedparam F
+GLIBC_2.32 pthread_sigmask F
+GLIBC_2.32 ptrace F
+GLIBC_2.32 ptsname F
+GLIBC_2.32 ptsname_r F
+GLIBC_2.32 putc F
+GLIBC_2.32 putc_unlocked F
+GLIBC_2.32 putchar F
+GLIBC_2.32 putchar_unlocked F
+GLIBC_2.32 putenv F
+GLIBC_2.32 putgrent F
+GLIBC_2.32 putpwent F
+GLIBC_2.32 puts F
+GLIBC_2.32 putsgent F
+GLIBC_2.32 putspent F
+GLIBC_2.32 pututline F
+GLIBC_2.32 pututxline F
+GLIBC_2.32 putw F
+GLIBC_2.32 putwc F
+GLIBC_2.32 putwc_unlocked F
+GLIBC_2.32 putwchar F
+GLIBC_2.32 putwchar_unlocked F
+GLIBC_2.32 pvalloc F
+GLIBC_2.32 pwrite F
+GLIBC_2.32 pwrite64 F
+GLIBC_2.32 pwritev F
+GLIBC_2.32 pwritev2 F
+GLIBC_2.32 pwritev64 F
+GLIBC_2.32 pwritev64v2 F
+GLIBC_2.32 qecvt F
+GLIBC_2.32 qecvt_r F
+GLIBC_2.32 qfcvt F
+GLIBC_2.32 qfcvt_r F
+GLIBC_2.32 qgcvt F
+GLIBC_2.32 qsort F
+GLIBC_2.32 qsort_r F
+GLIBC_2.32 quick_exit F
+GLIBC_2.32 quotactl F
+GLIBC_2.32 raise F
+GLIBC_2.32 rand F
+GLIBC_2.32 rand_r F
+GLIBC_2.32 random F
+GLIBC_2.32 random_r F
+GLIBC_2.32 rawmemchr F
+GLIBC_2.32 rcmd F
+GLIBC_2.32 rcmd_af F
+GLIBC_2.32 re_comp F
+GLIBC_2.32 re_compile_fastmap F
+GLIBC_2.32 re_compile_pattern F
+GLIBC_2.32 re_exec F
+GLIBC_2.32 re_match F
+GLIBC_2.32 re_match_2 F
+GLIBC_2.32 re_search F
+GLIBC_2.32 re_search_2 F
+GLIBC_2.32 re_set_registers F
+GLIBC_2.32 re_set_syntax F
+GLIBC_2.32 re_syntax_options D 0x4
+GLIBC_2.32 read F
+GLIBC_2.32 readahead F
+GLIBC_2.32 readdir F
+GLIBC_2.32 readdir64 F
+GLIBC_2.32 readdir64_r F
+GLIBC_2.32 readdir_r F
+GLIBC_2.32 readlink F
+GLIBC_2.32 readlinkat F
+GLIBC_2.32 readv F
+GLIBC_2.32 realloc F
+GLIBC_2.32 reallocarray F
+GLIBC_2.32 realpath F
+GLIBC_2.32 reboot F
+GLIBC_2.32 recv F
+GLIBC_2.32 recvfrom F
+GLIBC_2.32 recvmmsg F
+GLIBC_2.32 recvmsg F
+GLIBC_2.32 regcomp F
+GLIBC_2.32 regerror F
+GLIBC_2.32 regexec F
+GLIBC_2.32 regfree F
+GLIBC_2.32 register_printf_function F
+GLIBC_2.32 register_printf_modifier F
+GLIBC_2.32 register_printf_specifier F
+GLIBC_2.32 register_printf_type F
+GLIBC_2.32 registerrpc F
+GLIBC_2.32 remap_file_pages F
+GLIBC_2.32 remove F
+GLIBC_2.32 removexattr F
+GLIBC_2.32 remque F
+GLIBC_2.32 rename F
+GLIBC_2.32 renameat F
+GLIBC_2.32 renameat2 F
+GLIBC_2.32 revoke F
+GLIBC_2.32 rewind F
+GLIBC_2.32 rewinddir F
+GLIBC_2.32 rexec F
+GLIBC_2.32 rexec_af F
+GLIBC_2.32 rexecoptions D 0x4
+GLIBC_2.32 rindex F
+GLIBC_2.32 rmdir F
+GLIBC_2.32 rpc_createerr D 0x10
+GLIBC_2.32 rpmatch F
+GLIBC_2.32 rresvport F
+GLIBC_2.32 rresvport_af F
+GLIBC_2.32 rtime F
+GLIBC_2.32 ruserok F
+GLIBC_2.32 ruserok_af F
+GLIBC_2.32 ruserpass F
+GLIBC_2.32 sbrk F
+GLIBC_2.32 scalbn F
+GLIBC_2.32 scalbnf F
+GLIBC_2.32 scalbnl F
+GLIBC_2.32 scandir F
+GLIBC_2.32 scandir64 F
+GLIBC_2.32 scandirat F
+GLIBC_2.32 scandirat64 F
+GLIBC_2.32 scanf F
+GLIBC_2.32 sched_get_priority_max F
+GLIBC_2.32 sched_get_priority_min F
+GLIBC_2.32 sched_getaffinity F
+GLIBC_2.32 sched_getcpu F
+GLIBC_2.32 sched_getparam F
+GLIBC_2.32 sched_getscheduler F
+GLIBC_2.32 sched_rr_get_interval F
+GLIBC_2.32 sched_setaffinity F
+GLIBC_2.32 sched_setparam F
+GLIBC_2.32 sched_setscheduler F
+GLIBC_2.32 sched_yield F
+GLIBC_2.32 secure_getenv F
+GLIBC_2.32 seed48 F
+GLIBC_2.32 seed48_r F
+GLIBC_2.32 seekdir F
+GLIBC_2.32 select F
+GLIBC_2.32 semctl F
+GLIBC_2.32 semget F
+GLIBC_2.32 semop F
+GLIBC_2.32 semtimedop F
+GLIBC_2.32 send F
+GLIBC_2.32 sendfile F
+GLIBC_2.32 sendfile64 F
+GLIBC_2.32 sendmmsg F
+GLIBC_2.32 sendmsg F
+GLIBC_2.32 sendto F
+GLIBC_2.32 setaliasent F
+GLIBC_2.32 setbuf F
+GLIBC_2.32 setbuffer F
+GLIBC_2.32 setcontext F
+GLIBC_2.32 setdomainname F
+GLIBC_2.32 setegid F
+GLIBC_2.32 setenv F
+GLIBC_2.32 seteuid F
+GLIBC_2.32 setfsent F
+GLIBC_2.32 setfsgid F
+GLIBC_2.32 setfsuid F
+GLIBC_2.32 setgid F
+GLIBC_2.32 setgrent F
+GLIBC_2.32 setgroups F
+GLIBC_2.32 sethostent F
+GLIBC_2.32 sethostid F
+GLIBC_2.32 sethostname F
+GLIBC_2.32 setipv4sourcefilter F
+GLIBC_2.32 setitimer F
+GLIBC_2.32 setjmp F
+GLIBC_2.32 setlinebuf F
+GLIBC_2.32 setlocale F
+GLIBC_2.32 setlogin F
+GLIBC_2.32 setlogmask F
+GLIBC_2.32 setmntent F
+GLIBC_2.32 setnetent F
+GLIBC_2.32 setnetgrent F
+GLIBC_2.32 setns F
+GLIBC_2.32 setpgid F
+GLIBC_2.32 setpgrp F
+GLIBC_2.32 setpriority F
+GLIBC_2.32 setprotoent F
+GLIBC_2.32 setpwent F
+GLIBC_2.32 setregid F
+GLIBC_2.32 setresgid F
+GLIBC_2.32 setresuid F
+GLIBC_2.32 setreuid F
+GLIBC_2.32 setrlimit F
+GLIBC_2.32 setrlimit64 F
+GLIBC_2.32 setrpcent F
+GLIBC_2.32 setservent F
+GLIBC_2.32 setsgent F
+GLIBC_2.32 setsid F
+GLIBC_2.32 setsockopt F
+GLIBC_2.32 setsourcefilter F
+GLIBC_2.32 setspent F
+GLIBC_2.32 setstate F
+GLIBC_2.32 setstate_r F
+GLIBC_2.32 settimeofday F
+GLIBC_2.32 setttyent F
+GLIBC_2.32 setuid F
+GLIBC_2.32 setusershell F
+GLIBC_2.32 setutent F
+GLIBC_2.32 setutxent F
+GLIBC_2.32 setvbuf F
+GLIBC_2.32 setxattr F
+GLIBC_2.32 sgetsgent F
+GLIBC_2.32 sgetsgent_r F
+GLIBC_2.32 sgetspent F
+GLIBC_2.32 sgetspent_r F
+GLIBC_2.32 shmat F
+GLIBC_2.32 shmctl F
+GLIBC_2.32 shmdt F
+GLIBC_2.32 shmget F
+GLIBC_2.32 shutdown F
+GLIBC_2.32 sigaction F
+GLIBC_2.32 sigaddset F
+GLIBC_2.32 sigaltstack F
+GLIBC_2.32 sigandset F
+GLIBC_2.32 sigblock F
+GLIBC_2.32 sigdelset F
+GLIBC_2.32 sigemptyset F
+GLIBC_2.32 sigfillset F
+GLIBC_2.32 siggetmask F
+GLIBC_2.32 sighold F
+GLIBC_2.32 sigignore F
+GLIBC_2.32 siginterrupt F
+GLIBC_2.32 sigisemptyset F
+GLIBC_2.32 sigismember F
+GLIBC_2.32 siglongjmp F
+GLIBC_2.32 signal F
+GLIBC_2.32 signalfd F
+GLIBC_2.32 sigorset F
+GLIBC_2.32 sigpause F
+GLIBC_2.32 sigpending F
+GLIBC_2.32 sigprocmask F
+GLIBC_2.32 sigqueue F
+GLIBC_2.32 sigrelse F
+GLIBC_2.32 sigreturn F
+GLIBC_2.32 sigset F
+GLIBC_2.32 sigsetmask F
+GLIBC_2.32 sigstack F
+GLIBC_2.32 sigsuspend F
+GLIBC_2.32 sigtimedwait F
+GLIBC_2.32 sigwait F
+GLIBC_2.32 sigwaitinfo F
+GLIBC_2.32 sleep F
+GLIBC_2.32 snprintf F
+GLIBC_2.32 sockatmark F
+GLIBC_2.32 socket F
+GLIBC_2.32 socketpair F
+GLIBC_2.32 splice F
+GLIBC_2.32 sprintf F
+GLIBC_2.32 sprofil F
+GLIBC_2.32 srand F
+GLIBC_2.32 srand48 F
+GLIBC_2.32 srand48_r F
+GLIBC_2.32 srandom F
+GLIBC_2.32 srandom_r F
+GLIBC_2.32 sscanf F
+GLIBC_2.32 ssignal F
+GLIBC_2.32 sstk F
+GLIBC_2.32 statfs F
+GLIBC_2.32 statfs64 F
+GLIBC_2.32 statvfs F
+GLIBC_2.32 statvfs64 F
+GLIBC_2.32 statx F
+GLIBC_2.32 stderr D 0x4
+GLIBC_2.32 stdin D 0x4
+GLIBC_2.32 stdout D 0x4
+GLIBC_2.32 stpcpy F
+GLIBC_2.32 stpncpy F
+GLIBC_2.32 strcasecmp F
+GLIBC_2.32 strcasecmp_l F
+GLIBC_2.32 strcasestr F
+GLIBC_2.32 strcat F
+GLIBC_2.32 strchr F
+GLIBC_2.32 strchrnul F
+GLIBC_2.32 strcmp F
+GLIBC_2.32 strcoll F
+GLIBC_2.32 strcoll_l F
+GLIBC_2.32 strcpy F
+GLIBC_2.32 strcspn F
+GLIBC_2.32 strdup F
+GLIBC_2.32 strerror F
+GLIBC_2.32 strerror_l F
+GLIBC_2.32 strerror_r F
+GLIBC_2.32 strfmon F
+GLIBC_2.32 strfmon_l F
+GLIBC_2.32 strfromd F
+GLIBC_2.32 strfromf F
+GLIBC_2.32 strfromf32 F
+GLIBC_2.32 strfromf32x F
+GLIBC_2.32 strfromf64 F
+GLIBC_2.32 strfroml F
+GLIBC_2.32 strfry F
+GLIBC_2.32 strftime F
+GLIBC_2.32 strftime_l F
+GLIBC_2.32 strlen F
+GLIBC_2.32 strncasecmp F
+GLIBC_2.32 strncasecmp_l F
+GLIBC_2.32 strncat F
+GLIBC_2.32 strncmp F
+GLIBC_2.32 strncpy F
+GLIBC_2.32 strndup F
+GLIBC_2.32 strnlen F
+GLIBC_2.32 strpbrk F
+GLIBC_2.32 strptime F
+GLIBC_2.32 strptime_l F
+GLIBC_2.32 strrchr F
+GLIBC_2.32 strsep F
+GLIBC_2.32 strsignal F
+GLIBC_2.32 strspn F
+GLIBC_2.32 strstr F
+GLIBC_2.32 strtod F
+GLIBC_2.32 strtod_l F
+GLIBC_2.32 strtof F
+GLIBC_2.32 strtof32 F
+GLIBC_2.32 strtof32_l F
+GLIBC_2.32 strtof32x F
+GLIBC_2.32 strtof32x_l F
+GLIBC_2.32 strtof64 F
+GLIBC_2.32 strtof64_l F
+GLIBC_2.32 strtof_l F
+GLIBC_2.32 strtoimax F
+GLIBC_2.32 strtok F
+GLIBC_2.32 strtok_r F
+GLIBC_2.32 strtol F
+GLIBC_2.32 strtol_l F
+GLIBC_2.32 strtold F
+GLIBC_2.32 strtold_l F
+GLIBC_2.32 strtoll F
+GLIBC_2.32 strtoll_l F
+GLIBC_2.32 strtoq F
+GLIBC_2.32 strtoul F
+GLIBC_2.32 strtoul_l F
+GLIBC_2.32 strtoull F
+GLIBC_2.32 strtoull_l F
+GLIBC_2.32 strtoumax F
+GLIBC_2.32 strtouq F
+GLIBC_2.32 strverscmp F
+GLIBC_2.32 strxfrm F
+GLIBC_2.32 strxfrm_l F
+GLIBC_2.32 stty F
+GLIBC_2.32 svc_exit F
+GLIBC_2.32 svc_fdset D 0x80
+GLIBC_2.32 svc_getreq F
+GLIBC_2.32 svc_getreq_common F
+GLIBC_2.32 svc_getreq_poll F
+GLIBC_2.32 svc_getreqset F
+GLIBC_2.32 svc_max_pollfd D 0x4
+GLIBC_2.32 svc_pollfd D 0x4
+GLIBC_2.32 svc_register F
+GLIBC_2.32 svc_run F
+GLIBC_2.32 svc_sendreply F
+GLIBC_2.32 svc_unregister F
+GLIBC_2.32 svcauthdes_stats D 0xc
+GLIBC_2.32 svcerr_auth F
+GLIBC_2.32 svcerr_decode F
+GLIBC_2.32 svcerr_noproc F
+GLIBC_2.32 svcerr_noprog F
+GLIBC_2.32 svcerr_progvers F
+GLIBC_2.32 svcerr_systemerr F
+GLIBC_2.32 svcerr_weakauth F
+GLIBC_2.32 svcfd_create F
+GLIBC_2.32 svcraw_create F
+GLIBC_2.32 svctcp_create F
+GLIBC_2.32 svcudp_bufcreate F
+GLIBC_2.32 svcudp_create F
+GLIBC_2.32 svcudp_enablecache F
+GLIBC_2.32 svcunix_create F
+GLIBC_2.32 svcunixfd_create F
+GLIBC_2.32 swab F
+GLIBC_2.32 swapcontext F
+GLIBC_2.32 swapoff F
+GLIBC_2.32 swapon F
+GLIBC_2.32 swprintf F
+GLIBC_2.32 swscanf F
+GLIBC_2.32 symlink F
+GLIBC_2.32 symlinkat F
+GLIBC_2.32 sync F
+GLIBC_2.32 sync_file_range F
+GLIBC_2.32 syncfs F
+GLIBC_2.32 sys_errlist D 0x21c
+GLIBC_2.32 sys_nerr D 0x4
+GLIBC_2.32 sys_sigabbrev D 0x104
+GLIBC_2.32 sys_siglist D 0x104
+GLIBC_2.32 syscall F
+GLIBC_2.32 sysconf F
+GLIBC_2.32 sysinfo F
+GLIBC_2.32 syslog F
+GLIBC_2.32 system F
+GLIBC_2.32 sysv_signal F
+GLIBC_2.32 tcdrain F
+GLIBC_2.32 tcflow F
+GLIBC_2.32 tcflush F
+GLIBC_2.32 tcgetattr F
+GLIBC_2.32 tcgetpgrp F
+GLIBC_2.32 tcgetsid F
+GLIBC_2.32 tcsendbreak F
+GLIBC_2.32 tcsetattr F
+GLIBC_2.32 tcsetpgrp F
+GLIBC_2.32 tdelete F
+GLIBC_2.32 tdestroy F
+GLIBC_2.32 tee F
+GLIBC_2.32 telldir F
+GLIBC_2.32 tempnam F
+GLIBC_2.32 textdomain F
+GLIBC_2.32 tfind F
+GLIBC_2.32 tgkill F
+GLIBC_2.32 thrd_current F
+GLIBC_2.32 thrd_equal F
+GLIBC_2.32 thrd_sleep F
+GLIBC_2.32 thrd_yield F
+GLIBC_2.32 time F
+GLIBC_2.32 timegm F
+GLIBC_2.32 timelocal F
+GLIBC_2.32 timerfd_create F
+GLIBC_2.32 timerfd_gettime F
+GLIBC_2.32 timerfd_settime F
+GLIBC_2.32 times F
+GLIBC_2.32 timespec_get F
+GLIBC_2.32 timezone D 0x4
+GLIBC_2.32 tmpfile F
+GLIBC_2.32 tmpfile64 F
+GLIBC_2.32 tmpnam F
+GLIBC_2.32 tmpnam_r F
+GLIBC_2.32 toascii F
+GLIBC_2.32 tolower F
+GLIBC_2.32 tolower_l F
+GLIBC_2.32 toupper F
+GLIBC_2.32 toupper_l F
+GLIBC_2.32 towctrans F
+GLIBC_2.32 towctrans_l F
+GLIBC_2.32 towlower F
+GLIBC_2.32 towlower_l F
+GLIBC_2.32 towupper F
+GLIBC_2.32 towupper_l F
+GLIBC_2.32 tr_break F
+GLIBC_2.32 truncate F
+GLIBC_2.32 truncate64 F
+GLIBC_2.32 tsearch F
+GLIBC_2.32 ttyname F
+GLIBC_2.32 ttyname_r F
+GLIBC_2.32 ttyslot F
+GLIBC_2.32 twalk F
+GLIBC_2.32 twalk_r F
+GLIBC_2.32 tzname D 0x8
+GLIBC_2.32 tzset F
+GLIBC_2.32 ualarm F
+GLIBC_2.32 ulckpwdf F
+GLIBC_2.32 ulimit F
+GLIBC_2.32 umask F
+GLIBC_2.32 umount F
+GLIBC_2.32 umount2 F
+GLIBC_2.32 uname F
+GLIBC_2.32 ungetc F
+GLIBC_2.32 ungetwc F
+GLIBC_2.32 unlink F
+GLIBC_2.32 unlinkat F
+GLIBC_2.32 unlockpt F
+GLIBC_2.32 unsetenv F
+GLIBC_2.32 unshare F
+GLIBC_2.32 updwtmp F
+GLIBC_2.32 updwtmpx F
+GLIBC_2.32 uselocale F
+GLIBC_2.32 user2netname F
+GLIBC_2.32 usleep F
+GLIBC_2.32 utime F
+GLIBC_2.32 utimensat F
+GLIBC_2.32 utimes F
+GLIBC_2.32 utmpname F
+GLIBC_2.32 utmpxname F
+GLIBC_2.32 valloc F
+GLIBC_2.32 vasprintf F
+GLIBC_2.32 vdprintf F
+GLIBC_2.32 verr F
+GLIBC_2.32 verrx F
+GLIBC_2.32 versionsort F
+GLIBC_2.32 versionsort64 F
+GLIBC_2.32 vfork F
+GLIBC_2.32 vfprintf F
+GLIBC_2.32 vfscanf F
+GLIBC_2.32 vfwprintf F
+GLIBC_2.32 vfwscanf F
+GLIBC_2.32 vhangup F
+GLIBC_2.32 vlimit F
+GLIBC_2.32 vmsplice F
+GLIBC_2.32 vprintf F
+GLIBC_2.32 vscanf F
+GLIBC_2.32 vsnprintf F
+GLIBC_2.32 vsprintf F
+GLIBC_2.32 vsscanf F
+GLIBC_2.32 vswprintf F
+GLIBC_2.32 vswscanf F
+GLIBC_2.32 vsyslog F
+GLIBC_2.32 vtimes F
+GLIBC_2.32 vwarn F
+GLIBC_2.32 vwarnx F
+GLIBC_2.32 vwprintf F
+GLIBC_2.32 vwscanf F
+GLIBC_2.32 wait F
+GLIBC_2.32 wait3 F
+GLIBC_2.32 wait4 F
+GLIBC_2.32 waitid F
+GLIBC_2.32 waitpid F
+GLIBC_2.32 warn F
+GLIBC_2.32 warnx F
+GLIBC_2.32 wcpcpy F
+GLIBC_2.32 wcpncpy F
+GLIBC_2.32 wcrtomb F
+GLIBC_2.32 wcscasecmp F
+GLIBC_2.32 wcscasecmp_l F
+GLIBC_2.32 wcscat F
+GLIBC_2.32 wcschr F
+GLIBC_2.32 wcschrnul F
+GLIBC_2.32 wcscmp F
+GLIBC_2.32 wcscoll F
+GLIBC_2.32 wcscoll_l F
+GLIBC_2.32 wcscpy F
+GLIBC_2.32 wcscspn F
+GLIBC_2.32 wcsdup F
+GLIBC_2.32 wcsftime F
+GLIBC_2.32 wcsftime_l F
+GLIBC_2.32 wcslen F
+GLIBC_2.32 wcsncasecmp F
+GLIBC_2.32 wcsncasecmp_l F
+GLIBC_2.32 wcsncat F
+GLIBC_2.32 wcsncmp F
+GLIBC_2.32 wcsncpy F
+GLIBC_2.32 wcsnlen F
+GLIBC_2.32 wcsnrtombs F
+GLIBC_2.32 wcspbrk F
+GLIBC_2.32 wcsrchr F
+GLIBC_2.32 wcsrtombs F
+GLIBC_2.32 wcsspn F
+GLIBC_2.32 wcsstr F
+GLIBC_2.32 wcstod F
+GLIBC_2.32 wcstod_l F
+GLIBC_2.32 wcstof F
+GLIBC_2.32 wcstof32 F
+GLIBC_2.32 wcstof32_l F
+GLIBC_2.32 wcstof32x F
+GLIBC_2.32 wcstof32x_l F
+GLIBC_2.32 wcstof64 F
+GLIBC_2.32 wcstof64_l F
+GLIBC_2.32 wcstof_l F
+GLIBC_2.32 wcstoimax F
+GLIBC_2.32 wcstok F
+GLIBC_2.32 wcstol F
+GLIBC_2.32 wcstol_l F
+GLIBC_2.32 wcstold F
+GLIBC_2.32 wcstold_l F
+GLIBC_2.32 wcstoll F
+GLIBC_2.32 wcstoll_l F
+GLIBC_2.32 wcstombs F
+GLIBC_2.32 wcstoq F
+GLIBC_2.32 wcstoul F
+GLIBC_2.32 wcstoul_l F
+GLIBC_2.32 wcstoull F
+GLIBC_2.32 wcstoull_l F
+GLIBC_2.32 wcstoumax F
+GLIBC_2.32 wcstouq F
+GLIBC_2.32 wcswcs F
+GLIBC_2.32 wcswidth F
+GLIBC_2.32 wcsxfrm F
+GLIBC_2.32 wcsxfrm_l F
+GLIBC_2.32 wctob F
+GLIBC_2.32 wctomb F
+GLIBC_2.32 wctrans F
+GLIBC_2.32 wctrans_l F
+GLIBC_2.32 wctype F
+GLIBC_2.32 wctype_l F
+GLIBC_2.32 wcwidth F
+GLIBC_2.32 wmemchr F
+GLIBC_2.32 wmemcmp F
+GLIBC_2.32 wmemcpy F
+GLIBC_2.32 wmemmove F
+GLIBC_2.32 wmempcpy F
+GLIBC_2.32 wmemset F
+GLIBC_2.32 wordexp F
+GLIBC_2.32 wordfree F
+GLIBC_2.32 wprintf F
+GLIBC_2.32 write F
+GLIBC_2.32 writev F
+GLIBC_2.32 wscanf F
+GLIBC_2.32 xdecrypt F
+GLIBC_2.32 xdr_accepted_reply F
+GLIBC_2.32 xdr_array F
+GLIBC_2.32 xdr_authdes_cred F
+GLIBC_2.32 xdr_authdes_verf F
+GLIBC_2.32 xdr_authunix_parms F
+GLIBC_2.32 xdr_bool F
+GLIBC_2.32 xdr_bytes F
+GLIBC_2.32 xdr_callhdr F
+GLIBC_2.32 xdr_callmsg F
+GLIBC_2.32 xdr_char F
+GLIBC_2.32 xdr_cryptkeyarg F
+GLIBC_2.32 xdr_cryptkeyarg2 F
+GLIBC_2.32 xdr_cryptkeyres F
+GLIBC_2.32 xdr_des_block F
+GLIBC_2.32 xdr_double F
+GLIBC_2.32 xdr_enum F
+GLIBC_2.32 xdr_float F
+GLIBC_2.32 xdr_free F
+GLIBC_2.32 xdr_getcredres F
+GLIBC_2.32 xdr_hyper F
+GLIBC_2.32 xdr_int F
+GLIBC_2.32 xdr_int16_t F
+GLIBC_2.32 xdr_int32_t F
+GLIBC_2.32 xdr_int64_t F
+GLIBC_2.32 xdr_int8_t F
+GLIBC_2.32 xdr_key_netstarg F
+GLIBC_2.32 xdr_key_netstres F
+GLIBC_2.32 xdr_keybuf F
+GLIBC_2.32 xdr_keystatus F
+GLIBC_2.32 xdr_long F
+GLIBC_2.32 xdr_longlong_t F
+GLIBC_2.32 xdr_netnamestr F
+GLIBC_2.32 xdr_netobj F
+GLIBC_2.32 xdr_opaque F
+GLIBC_2.32 xdr_opaque_auth F
+GLIBC_2.32 xdr_pmap F
+GLIBC_2.32 xdr_pmaplist F
+GLIBC_2.32 xdr_pointer F
+GLIBC_2.32 xdr_quad_t F
+GLIBC_2.32 xdr_reference F
+GLIBC_2.32 xdr_rejected_reply F
+GLIBC_2.32 xdr_replymsg F
+GLIBC_2.32 xdr_rmtcall_args F
+GLIBC_2.32 xdr_rmtcallres F
+GLIBC_2.32 xdr_short F
+GLIBC_2.32 xdr_sizeof F
+GLIBC_2.32 xdr_string F
+GLIBC_2.32 xdr_u_char F
+GLIBC_2.32 xdr_u_hyper F
+GLIBC_2.32 xdr_u_int F
+GLIBC_2.32 xdr_u_long F
+GLIBC_2.32 xdr_u_longlong_t F
+GLIBC_2.32 xdr_u_quad_t F
+GLIBC_2.32 xdr_u_short F
+GLIBC_2.32 xdr_uint16_t F
+GLIBC_2.32 xdr_uint32_t F
+GLIBC_2.32 xdr_uint64_t F
+GLIBC_2.32 xdr_uint8_t F
+GLIBC_2.32 xdr_union F
+GLIBC_2.32 xdr_unixcred F
+GLIBC_2.32 xdr_vector F
+GLIBC_2.32 xdr_void F
+GLIBC_2.32 xdr_wrapstring F
+GLIBC_2.32 xdrmem_create F
+GLIBC_2.32 xdrrec_create F
+GLIBC_2.32 xdrrec_endofrecord F
+GLIBC_2.32 xdrrec_eof F
+GLIBC_2.32 xdrrec_skiprecord F
+GLIBC_2.32 xdrstdio_create F
+GLIBC_2.32 xencrypt F
+GLIBC_2.32 xprt_register F
+GLIBC_2.32 xprt_unregister F
diff --git a/sysdeps/unix/sysv/linux/or1k/libcrypt.abilist b/sysdeps/unix/sysv/linux/or1k/libcrypt.abilist
new file mode 100644
index 0000000000..6bd253453e
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libcrypt.abilist
@@ -0,0 +1,2 @@
+GLIBC_2.32 crypt F
+GLIBC_2.32 crypt_r F
diff --git a/sysdeps/unix/sysv/linux/or1k/libdl.abilist b/sysdeps/unix/sysv/linux/or1k/libdl.abilist
new file mode 100644
index 0000000000..bf20b0c404
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libdl.abilist
@@ -0,0 +1,9 @@
+GLIBC_2.32 dladdr F
+GLIBC_2.32 dladdr1 F
+GLIBC_2.32 dlclose F
+GLIBC_2.32 dlerror F
+GLIBC_2.32 dlinfo F
+GLIBC_2.32 dlmopen F
+GLIBC_2.32 dlopen F
+GLIBC_2.32 dlsym F
+GLIBC_2.32 dlvsym F
diff --git a/sysdeps/unix/sysv/linux/or1k/libm.abilist b/sysdeps/unix/sysv/linux/or1k/libm.abilist
new file mode 100644
index 0000000000..4338563657
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libm.abilist
@@ -0,0 +1,699 @@
+GLIBC_2.32 __clog10 F
+GLIBC_2.32 __clog10f F
+GLIBC_2.32 __clog10l F
+GLIBC_2.32 __finite F
+GLIBC_2.32 __finitef F
+GLIBC_2.32 __fpclassify F
+GLIBC_2.32 __fpclassifyf F
+GLIBC_2.32 __iseqsig F
+GLIBC_2.32 __iseqsigf F
+GLIBC_2.32 __issignaling F
+GLIBC_2.32 __issignalingf F
+GLIBC_2.32 __signbit F
+GLIBC_2.32 __signbitf F
+GLIBC_2.32 __signgam D 0x4
+GLIBC_2.32 acos F
+GLIBC_2.32 acosf F
+GLIBC_2.32 acosf32 F
+GLIBC_2.32 acosf32x F
+GLIBC_2.32 acosf64 F
+GLIBC_2.32 acosh F
+GLIBC_2.32 acoshf F
+GLIBC_2.32 acoshf32 F
+GLIBC_2.32 acoshf32x F
+GLIBC_2.32 acoshf64 F
+GLIBC_2.32 acoshl F
+GLIBC_2.32 acosl F
+GLIBC_2.32 asin F
+GLIBC_2.32 asinf F
+GLIBC_2.32 asinf32 F
+GLIBC_2.32 asinf32x F
+GLIBC_2.32 asinf64 F
+GLIBC_2.32 asinh F
+GLIBC_2.32 asinhf F
+GLIBC_2.32 asinhf32 F
+GLIBC_2.32 asinhf32x F
+GLIBC_2.32 asinhf64 F
+GLIBC_2.32 asinhl F
+GLIBC_2.32 asinl F
+GLIBC_2.32 atan F
+GLIBC_2.32 atan2 F
+GLIBC_2.32 atan2f F
+GLIBC_2.32 atan2f32 F
+GLIBC_2.32 atan2f32x F
+GLIBC_2.32 atan2f64 F
+GLIBC_2.32 atan2l F
+GLIBC_2.32 atanf F
+GLIBC_2.32 atanf32 F
+GLIBC_2.32 atanf32x F
+GLIBC_2.32 atanf64 F
+GLIBC_2.32 atanh F
+GLIBC_2.32 atanhf F
+GLIBC_2.32 atanhf32 F
+GLIBC_2.32 atanhf32x F
+GLIBC_2.32 atanhf64 F
+GLIBC_2.32 atanhl F
+GLIBC_2.32 atanl F
+GLIBC_2.32 cabs F
+GLIBC_2.32 cabsf F
+GLIBC_2.32 cabsf32 F
+GLIBC_2.32 cabsf32x F
+GLIBC_2.32 cabsf64 F
+GLIBC_2.32 cabsl F
+GLIBC_2.32 cacos F
+GLIBC_2.32 cacosf F
+GLIBC_2.32 cacosf32 F
+GLIBC_2.32 cacosf32x F
+GLIBC_2.32 cacosf64 F
+GLIBC_2.32 cacosh F
+GLIBC_2.32 cacoshf F
+GLIBC_2.32 cacoshf32 F
+GLIBC_2.32 cacoshf32x F
+GLIBC_2.32 cacoshf64 F
+GLIBC_2.32 cacoshl F
+GLIBC_2.32 cacosl F
+GLIBC_2.32 canonicalize F
+GLIBC_2.32 canonicalizef F
+GLIBC_2.32 canonicalizef32 F
+GLIBC_2.32 canonicalizef32x F
+GLIBC_2.32 canonicalizef64 F
+GLIBC_2.32 canonicalizel F
+GLIBC_2.32 carg F
+GLIBC_2.32 cargf F
+GLIBC_2.32 cargf32 F
+GLIBC_2.32 cargf32x F
+GLIBC_2.32 cargf64 F
+GLIBC_2.32 cargl F
+GLIBC_2.32 casin F
+GLIBC_2.32 casinf F
+GLIBC_2.32 casinf32 F
+GLIBC_2.32 casinf32x F
+GLIBC_2.32 casinf64 F
+GLIBC_2.32 casinh F
+GLIBC_2.32 casinhf F
+GLIBC_2.32 casinhf32 F
+GLIBC_2.32 casinhf32x F
+GLIBC_2.32 casinhf64 F
+GLIBC_2.32 casinhl F
+GLIBC_2.32 casinl F
+GLIBC_2.32 catan F
+GLIBC_2.32 catanf F
+GLIBC_2.32 catanf32 F
+GLIBC_2.32 catanf32x F
+GLIBC_2.32 catanf64 F
+GLIBC_2.32 catanh F
+GLIBC_2.32 catanhf F
+GLIBC_2.32 catanhf32 F
+GLIBC_2.32 catanhf32x F
+GLIBC_2.32 catanhf64 F
+GLIBC_2.32 catanhl F
+GLIBC_2.32 catanl F
+GLIBC_2.32 cbrt F
+GLIBC_2.32 cbrtf F
+GLIBC_2.32 cbrtf32 F
+GLIBC_2.32 cbrtf32x F
+GLIBC_2.32 cbrtf64 F
+GLIBC_2.32 cbrtl F
+GLIBC_2.32 ccos F
+GLIBC_2.32 ccosf F
+GLIBC_2.32 ccosf32 F
+GLIBC_2.32 ccosf32x F
+GLIBC_2.32 ccosf64 F
+GLIBC_2.32 ccosh F
+GLIBC_2.32 ccoshf F
+GLIBC_2.32 ccoshf32 F
+GLIBC_2.32 ccoshf32x F
+GLIBC_2.32 ccoshf64 F
+GLIBC_2.32 ccoshl F
+GLIBC_2.32 ccosl F
+GLIBC_2.32 ceil F
+GLIBC_2.32 ceilf F
+GLIBC_2.32 ceilf32 F
+GLIBC_2.32 ceilf32x F
+GLIBC_2.32 ceilf64 F
+GLIBC_2.32 ceill F
+GLIBC_2.32 cexp F
+GLIBC_2.32 cexpf F
+GLIBC_2.32 cexpf32 F
+GLIBC_2.32 cexpf32x F
+GLIBC_2.32 cexpf64 F
+GLIBC_2.32 cexpl F
+GLIBC_2.32 cimag F
+GLIBC_2.32 cimagf F
+GLIBC_2.32 cimagf32 F
+GLIBC_2.32 cimagf32x F
+GLIBC_2.32 cimagf64 F
+GLIBC_2.32 cimagl F
+GLIBC_2.32 clog F
+GLIBC_2.32 clog10 F
+GLIBC_2.32 clog10f F
+GLIBC_2.32 clog10f32 F
+GLIBC_2.32 clog10f32x F
+GLIBC_2.32 clog10f64 F
+GLIBC_2.32 clog10l F
+GLIBC_2.32 clogf F
+GLIBC_2.32 clogf32 F
+GLIBC_2.32 clogf32x F
+GLIBC_2.32 clogf64 F
+GLIBC_2.32 clogl F
+GLIBC_2.32 conj F
+GLIBC_2.32 conjf F
+GLIBC_2.32 conjf32 F
+GLIBC_2.32 conjf32x F
+GLIBC_2.32 conjf64 F
+GLIBC_2.32 conjl F
+GLIBC_2.32 copysign F
+GLIBC_2.32 copysignf F
+GLIBC_2.32 copysignf32 F
+GLIBC_2.32 copysignf32x F
+GLIBC_2.32 copysignf64 F
+GLIBC_2.32 copysignl F
+GLIBC_2.32 cos F
+GLIBC_2.32 cosf F
+GLIBC_2.32 cosf32 F
+GLIBC_2.32 cosf32x F
+GLIBC_2.32 cosf64 F
+GLIBC_2.32 cosh F
+GLIBC_2.32 coshf F
+GLIBC_2.32 coshf32 F
+GLIBC_2.32 coshf32x F
+GLIBC_2.32 coshf64 F
+GLIBC_2.32 coshl F
+GLIBC_2.32 cosl F
+GLIBC_2.32 cpow F
+GLIBC_2.32 cpowf F
+GLIBC_2.32 cpowf32 F
+GLIBC_2.32 cpowf32x F
+GLIBC_2.32 cpowf64 F
+GLIBC_2.32 cpowl F
+GLIBC_2.32 cproj F
+GLIBC_2.32 cprojf F
+GLIBC_2.32 cprojf32 F
+GLIBC_2.32 cprojf32x F
+GLIBC_2.32 cprojf64 F
+GLIBC_2.32 cprojl F
+GLIBC_2.32 creal F
+GLIBC_2.32 crealf F
+GLIBC_2.32 crealf32 F
+GLIBC_2.32 crealf32x F
+GLIBC_2.32 crealf64 F
+GLIBC_2.32 creall F
+GLIBC_2.32 csin F
+GLIBC_2.32 csinf F
+GLIBC_2.32 csinf32 F
+GLIBC_2.32 csinf32x F
+GLIBC_2.32 csinf64 F
+GLIBC_2.32 csinh F
+GLIBC_2.32 csinhf F
+GLIBC_2.32 csinhf32 F
+GLIBC_2.32 csinhf32x F
+GLIBC_2.32 csinhf64 F
+GLIBC_2.32 csinhl F
+GLIBC_2.32 csinl F
+GLIBC_2.32 csqrt F
+GLIBC_2.32 csqrtf F
+GLIBC_2.32 csqrtf32 F
+GLIBC_2.32 csqrtf32x F
+GLIBC_2.32 csqrtf64 F
+GLIBC_2.32 csqrtl F
+GLIBC_2.32 ctan F
+GLIBC_2.32 ctanf F
+GLIBC_2.32 ctanf32 F
+GLIBC_2.32 ctanf32x F
+GLIBC_2.32 ctanf64 F
+GLIBC_2.32 ctanh F
+GLIBC_2.32 ctanhf F
+GLIBC_2.32 ctanhf32 F
+GLIBC_2.32 ctanhf32x F
+GLIBC_2.32 ctanhf64 F
+GLIBC_2.32 ctanhl F
+GLIBC_2.32 ctanl F
+GLIBC_2.32 daddl F
+GLIBC_2.32 ddivl F
+GLIBC_2.32 dmull F
+GLIBC_2.32 drem F
+GLIBC_2.32 dremf F
+GLIBC_2.32 dreml F
+GLIBC_2.32 dsubl F
+GLIBC_2.32 erf F
+GLIBC_2.32 erfc F
+GLIBC_2.32 erfcf F
+GLIBC_2.32 erfcf32 F
+GLIBC_2.32 erfcf32x F
+GLIBC_2.32 erfcf64 F
+GLIBC_2.32 erfcl F
+GLIBC_2.32 erff F
+GLIBC_2.32 erff32 F
+GLIBC_2.32 erff32x F
+GLIBC_2.32 erff64 F
+GLIBC_2.32 erfl F
+GLIBC_2.32 exp F
+GLIBC_2.32 exp10 F
+GLIBC_2.32 exp10f F
+GLIBC_2.32 exp10f32 F
+GLIBC_2.32 exp10f32x F
+GLIBC_2.32 exp10f64 F
+GLIBC_2.32 exp10l F
+GLIBC_2.32 exp2 F
+GLIBC_2.32 exp2f F
+GLIBC_2.32 exp2f32 F
+GLIBC_2.32 exp2f32x F
+GLIBC_2.32 exp2f64 F
+GLIBC_2.32 exp2l F
+GLIBC_2.32 expf F
+GLIBC_2.32 expf32 F
+GLIBC_2.32 expf32x F
+GLIBC_2.32 expf64 F
+GLIBC_2.32 expl F
+GLIBC_2.32 expm1 F
+GLIBC_2.32 expm1f F
+GLIBC_2.32 expm1f32 F
+GLIBC_2.32 expm1f32x F
+GLIBC_2.32 expm1f64 F
+GLIBC_2.32 expm1l F
+GLIBC_2.32 f32addf32x F
+GLIBC_2.32 f32addf64 F
+GLIBC_2.32 f32divf32x F
+GLIBC_2.32 f32divf64 F
+GLIBC_2.32 f32mulf32x F
+GLIBC_2.32 f32mulf64 F
+GLIBC_2.32 f32subf32x F
+GLIBC_2.32 f32subf64 F
+GLIBC_2.32 f32xaddf64 F
+GLIBC_2.32 f32xdivf64 F
+GLIBC_2.32 f32xmulf64 F
+GLIBC_2.32 f32xsubf64 F
+GLIBC_2.32 fabs F
+GLIBC_2.32 fabsf F
+GLIBC_2.32 fabsf32 F
+GLIBC_2.32 fabsf32x F
+GLIBC_2.32 fabsf64 F
+GLIBC_2.32 fabsl F
+GLIBC_2.32 fadd F
+GLIBC_2.32 faddl F
+GLIBC_2.32 fdim F
+GLIBC_2.32 fdimf F
+GLIBC_2.32 fdimf32 F
+GLIBC_2.32 fdimf32x F
+GLIBC_2.32 fdimf64 F
+GLIBC_2.32 fdiml F
+GLIBC_2.32 fdiv F
+GLIBC_2.32 fdivl F
+GLIBC_2.32 feclearexcept F
+GLIBC_2.32 fedisableexcept F
+GLIBC_2.32 feenableexcept F
+GLIBC_2.32 fegetenv F
+GLIBC_2.32 fegetexcept F
+GLIBC_2.32 fegetexceptflag F
+GLIBC_2.32 fegetmode F
+GLIBC_2.32 fegetround F
+GLIBC_2.32 feholdexcept F
+GLIBC_2.32 feraiseexcept F
+GLIBC_2.32 fesetenv F
+GLIBC_2.32 fesetexcept F
+GLIBC_2.32 fesetexceptflag F
+GLIBC_2.32 fesetmode F
+GLIBC_2.32 fesetround F
+GLIBC_2.32 fetestexcept F
+GLIBC_2.32 fetestexceptflag F
+GLIBC_2.32 feupdateenv F
+GLIBC_2.32 finite F
+GLIBC_2.32 finitef F
+GLIBC_2.32 finitel F
+GLIBC_2.32 floor F
+GLIBC_2.32 floorf F
+GLIBC_2.32 floorf32 F
+GLIBC_2.32 floorf32x F
+GLIBC_2.32 floorf64 F
+GLIBC_2.32 floorl F
+GLIBC_2.32 fma F
+GLIBC_2.32 fmaf F
+GLIBC_2.32 fmaf32 F
+GLIBC_2.32 fmaf32x F
+GLIBC_2.32 fmaf64 F
+GLIBC_2.32 fmal F
+GLIBC_2.32 fmax F
+GLIBC_2.32 fmaxf F
+GLIBC_2.32 fmaxf32 F
+GLIBC_2.32 fmaxf32x F
+GLIBC_2.32 fmaxf64 F
+GLIBC_2.32 fmaxl F
+GLIBC_2.32 fmaxmag F
+GLIBC_2.32 fmaxmagf F
+GLIBC_2.32 fmaxmagf32 F
+GLIBC_2.32 fmaxmagf32x F
+GLIBC_2.32 fmaxmagf64 F
+GLIBC_2.32 fmaxmagl F
+GLIBC_2.32 fmin F
+GLIBC_2.32 fminf F
+GLIBC_2.32 fminf32 F
+GLIBC_2.32 fminf32x F
+GLIBC_2.32 fminf64 F
+GLIBC_2.32 fminl F
+GLIBC_2.32 fminmag F
+GLIBC_2.32 fminmagf F
+GLIBC_2.32 fminmagf32 F
+GLIBC_2.32 fminmagf32x F
+GLIBC_2.32 fminmagf64 F
+GLIBC_2.32 fminmagl F
+GLIBC_2.32 fmod F
+GLIBC_2.32 fmodf F
+GLIBC_2.32 fmodf32 F
+GLIBC_2.32 fmodf32x F
+GLIBC_2.32 fmodf64 F
+GLIBC_2.32 fmodl F
+GLIBC_2.32 fmul F
+GLIBC_2.32 fmull F
+GLIBC_2.32 frexp F
+GLIBC_2.32 frexpf F
+GLIBC_2.32 frexpf32 F
+GLIBC_2.32 frexpf32x F
+GLIBC_2.32 frexpf64 F
+GLIBC_2.32 frexpl F
+GLIBC_2.32 fromfp F
+GLIBC_2.32 fromfpf F
+GLIBC_2.32 fromfpf32 F
+GLIBC_2.32 fromfpf32x F
+GLIBC_2.32 fromfpf64 F
+GLIBC_2.32 fromfpl F
+GLIBC_2.32 fromfpx F
+GLIBC_2.32 fromfpxf F
+GLIBC_2.32 fromfpxf32 F
+GLIBC_2.32 fromfpxf32x F
+GLIBC_2.32 fromfpxf64 F
+GLIBC_2.32 fromfpxl F
+GLIBC_2.32 fsub F
+GLIBC_2.32 fsubl F
+GLIBC_2.32 gamma F
+GLIBC_2.32 gammaf F
+GLIBC_2.32 gammal F
+GLIBC_2.32 getpayload F
+GLIBC_2.32 getpayloadf F
+GLIBC_2.32 getpayloadf32 F
+GLIBC_2.32 getpayloadf32x F
+GLIBC_2.32 getpayloadf64 F
+GLIBC_2.32 getpayloadl F
+GLIBC_2.32 hypot F
+GLIBC_2.32 hypotf F
+GLIBC_2.32 hypotf32 F
+GLIBC_2.32 hypotf32x F
+GLIBC_2.32 hypotf64 F
+GLIBC_2.32 hypotl F
+GLIBC_2.32 ilogb F
+GLIBC_2.32 ilogbf F
+GLIBC_2.32 ilogbf32 F
+GLIBC_2.32 ilogbf32x F
+GLIBC_2.32 ilogbf64 F
+GLIBC_2.32 ilogbl F
+GLIBC_2.32 j0 F
+GLIBC_2.32 j0f F
+GLIBC_2.32 j0f32 F
+GLIBC_2.32 j0f32x F
+GLIBC_2.32 j0f64 F
+GLIBC_2.32 j0l F
+GLIBC_2.32 j1 F
+GLIBC_2.32 j1f F
+GLIBC_2.32 j1f32 F
+GLIBC_2.32 j1f32x F
+GLIBC_2.32 j1f64 F
+GLIBC_2.32 j1l F
+GLIBC_2.32 jn F
+GLIBC_2.32 jnf F
+GLIBC_2.32 jnf32 F
+GLIBC_2.32 jnf32x F
+GLIBC_2.32 jnf64 F
+GLIBC_2.32 jnl F
+GLIBC_2.32 ldexp F
+GLIBC_2.32 ldexpf F
+GLIBC_2.32 ldexpf32 F
+GLIBC_2.32 ldexpf32x F
+GLIBC_2.32 ldexpf64 F
+GLIBC_2.32 ldexpl F
+GLIBC_2.32 lgamma F
+GLIBC_2.32 lgamma_r F
+GLIBC_2.32 lgammaf F
+GLIBC_2.32 lgammaf32 F
+GLIBC_2.32 lgammaf32_r F
+GLIBC_2.32 lgammaf32x F
+GLIBC_2.32 lgammaf32x_r F
+GLIBC_2.32 lgammaf64 F
+GLIBC_2.32 lgammaf64_r F
+GLIBC_2.32 lgammaf_r F
+GLIBC_2.32 lgammal F
+GLIBC_2.32 lgammal_r F
+GLIBC_2.32 llogb F
+GLIBC_2.32 llogbf F
+GLIBC_2.32 llogbf32 F
+GLIBC_2.32 llogbf32x F
+GLIBC_2.32 llogbf64 F
+GLIBC_2.32 llogbl F
+GLIBC_2.32 llrint F
+GLIBC_2.32 llrintf F
+GLIBC_2.32 llrintf32 F
+GLIBC_2.32 llrintf32x F
+GLIBC_2.32 llrintf64 F
+GLIBC_2.32 llrintl F
+GLIBC_2.32 llround F
+GLIBC_2.32 llroundf F
+GLIBC_2.32 llroundf32 F
+GLIBC_2.32 llroundf32x F
+GLIBC_2.32 llroundf64 F
+GLIBC_2.32 llroundl F
+GLIBC_2.32 log F
+GLIBC_2.32 log10 F
+GLIBC_2.32 log10f F
+GLIBC_2.32 log10f32 F
+GLIBC_2.32 log10f32x F
+GLIBC_2.32 log10f64 F
+GLIBC_2.32 log10l F
+GLIBC_2.32 log1p F
+GLIBC_2.32 log1pf F
+GLIBC_2.32 log1pf32 F
+GLIBC_2.32 log1pf32x F
+GLIBC_2.32 log1pf64 F
+GLIBC_2.32 log1pl F
+GLIBC_2.32 log2 F
+GLIBC_2.32 log2f F
+GLIBC_2.32 log2f32 F
+GLIBC_2.32 log2f32x F
+GLIBC_2.32 log2f64 F
+GLIBC_2.32 log2l F
+GLIBC_2.32 logb F
+GLIBC_2.32 logbf F
+GLIBC_2.32 logbf32 F
+GLIBC_2.32 logbf32x F
+GLIBC_2.32 logbf64 F
+GLIBC_2.32 logbl F
+GLIBC_2.32 logf F
+GLIBC_2.32 logf32 F
+GLIBC_2.32 logf32x F
+GLIBC_2.32 logf64 F
+GLIBC_2.32 logl F
+GLIBC_2.32 lrint F
+GLIBC_2.32 lrintf F
+GLIBC_2.32 lrintf32 F
+GLIBC_2.32 lrintf32x F
+GLIBC_2.32 lrintf64 F
+GLIBC_2.32 lrintl F
+GLIBC_2.32 lround F
+GLIBC_2.32 lroundf F
+GLIBC_2.32 lroundf32 F
+GLIBC_2.32 lroundf32x F
+GLIBC_2.32 lroundf64 F
+GLIBC_2.32 lroundl F
+GLIBC_2.32 modf F
+GLIBC_2.32 modff F
+GLIBC_2.32 modff32 F
+GLIBC_2.32 modff32x F
+GLIBC_2.32 modff64 F
+GLIBC_2.32 modfl F
+GLIBC_2.32 nan F
+GLIBC_2.32 nanf F
+GLIBC_2.32 nanf32 F
+GLIBC_2.32 nanf32x F
+GLIBC_2.32 nanf64 F
+GLIBC_2.32 nanl F
+GLIBC_2.32 nearbyint F
+GLIBC_2.32 nearbyintf F
+GLIBC_2.32 nearbyintf32 F
+GLIBC_2.32 nearbyintf32x F
+GLIBC_2.32 nearbyintf64 F
+GLIBC_2.32 nearbyintl F
+GLIBC_2.32 nextafter F
+GLIBC_2.32 nextafterf F
+GLIBC_2.32 nextafterf32 F
+GLIBC_2.32 nextafterf32x F
+GLIBC_2.32 nextafterf64 F
+GLIBC_2.32 nextafterl F
+GLIBC_2.32 nextdown F
+GLIBC_2.32 nextdownf F
+GLIBC_2.32 nextdownf32 F
+GLIBC_2.32 nextdownf32x F
+GLIBC_2.32 nextdownf64 F
+GLIBC_2.32 nextdownl F
+GLIBC_2.32 nexttoward F
+GLIBC_2.32 nexttowardf F
+GLIBC_2.32 nexttowardl F
+GLIBC_2.32 nextup F
+GLIBC_2.32 nextupf F
+GLIBC_2.32 nextupf32 F
+GLIBC_2.32 nextupf32x F
+GLIBC_2.32 nextupf64 F
+GLIBC_2.32 nextupl F
+GLIBC_2.32 pow F
+GLIBC_2.32 powf F
+GLIBC_2.32 powf32 F
+GLIBC_2.32 powf32x F
+GLIBC_2.32 powf64 F
+GLIBC_2.32 powl F
+GLIBC_2.32 remainder F
+GLIBC_2.32 remainderf F
+GLIBC_2.32 remainderf32 F
+GLIBC_2.32 remainderf32x F
+GLIBC_2.32 remainderf64 F
+GLIBC_2.32 remainderl F
+GLIBC_2.32 remquo F
+GLIBC_2.32 remquof F
+GLIBC_2.32 remquof32 F
+GLIBC_2.32 remquof32x F
+GLIBC_2.32 remquof64 F
+GLIBC_2.32 remquol F
+GLIBC_2.32 rint F
+GLIBC_2.32 rintf F
+GLIBC_2.32 rintf32 F
+GLIBC_2.32 rintf32x F
+GLIBC_2.32 rintf64 F
+GLIBC_2.32 rintl F
+GLIBC_2.32 round F
+GLIBC_2.32 roundeven F
+GLIBC_2.32 roundevenf F
+GLIBC_2.32 roundevenf32 F
+GLIBC_2.32 roundevenf32x F
+GLIBC_2.32 roundevenf64 F
+GLIBC_2.32 roundevenl F
+GLIBC_2.32 roundf F
+GLIBC_2.32 roundf32 F
+GLIBC_2.32 roundf32x F
+GLIBC_2.32 roundf64 F
+GLIBC_2.32 roundl F
+GLIBC_2.32 scalb F
+GLIBC_2.32 scalbf F
+GLIBC_2.32 scalbl F
+GLIBC_2.32 scalbln F
+GLIBC_2.32 scalblnf F
+GLIBC_2.32 scalblnf32 F
+GLIBC_2.32 scalblnf32x F
+GLIBC_2.32 scalblnf64 F
+GLIBC_2.32 scalblnl F
+GLIBC_2.32 scalbn F
+GLIBC_2.32 scalbnf F
+GLIBC_2.32 scalbnf32 F
+GLIBC_2.32 scalbnf32x F
+GLIBC_2.32 scalbnf64 F
+GLIBC_2.32 scalbnl F
+GLIBC_2.32 setpayload F
+GLIBC_2.32 setpayloadf F
+GLIBC_2.32 setpayloadf32 F
+GLIBC_2.32 setpayloadf32x F
+GLIBC_2.32 setpayloadf64 F
+GLIBC_2.32 setpayloadl F
+GLIBC_2.32 setpayloadsig F
+GLIBC_2.32 setpayloadsigf F
+GLIBC_2.32 setpayloadsigf32 F
+GLIBC_2.32 setpayloadsigf32x F
+GLIBC_2.32 setpayloadsigf64 F
+GLIBC_2.32 setpayloadsigl F
+GLIBC_2.32 signgam D 0x4
+GLIBC_2.32 significand F
+GLIBC_2.32 significandf F
+GLIBC_2.32 significandl F
+GLIBC_2.32 sin F
+GLIBC_2.32 sincos F
+GLIBC_2.32 sincosf F
+GLIBC_2.32 sincosf32 F
+GLIBC_2.32 sincosf32x F
+GLIBC_2.32 sincosf64 F
+GLIBC_2.32 sincosl F
+GLIBC_2.32 sinf F
+GLIBC_2.32 sinf32 F
+GLIBC_2.32 sinf32x F
+GLIBC_2.32 sinf64 F
+GLIBC_2.32 sinh F
+GLIBC_2.32 sinhf F
+GLIBC_2.32 sinhf32 F
+GLIBC_2.32 sinhf32x F
+GLIBC_2.32 sinhf64 F
+GLIBC_2.32 sinhl F
+GLIBC_2.32 sinl F
+GLIBC_2.32 sqrt F
+GLIBC_2.32 sqrtf F
+GLIBC_2.32 sqrtf32 F
+GLIBC_2.32 sqrtf32x F
+GLIBC_2.32 sqrtf64 F
+GLIBC_2.32 sqrtl F
+GLIBC_2.32 tan F
+GLIBC_2.32 tanf F
+GLIBC_2.32 tanf32 F
+GLIBC_2.32 tanf32x F
+GLIBC_2.32 tanf64 F
+GLIBC_2.32 tanh F
+GLIBC_2.32 tanhf F
+GLIBC_2.32 tanhf32 F
+GLIBC_2.32 tanhf32x F
+GLIBC_2.32 tanhf64 F
+GLIBC_2.32 tanhl F
+GLIBC_2.32 tanl F
+GLIBC_2.32 tgamma F
+GLIBC_2.32 tgammaf F
+GLIBC_2.32 tgammaf32 F
+GLIBC_2.32 tgammaf32x F
+GLIBC_2.32 tgammaf64 F
+GLIBC_2.32 tgammal F
+GLIBC_2.32 totalorder F
+GLIBC_2.32 totalorderf F
+GLIBC_2.32 totalorderf32 F
+GLIBC_2.32 totalorderf32x F
+GLIBC_2.32 totalorderf64 F
+GLIBC_2.32 totalorderl F
+GLIBC_2.32 totalordermag F
+GLIBC_2.32 totalordermagf F
+GLIBC_2.32 totalordermagf32 F
+GLIBC_2.32 totalordermagf32x F
+GLIBC_2.32 totalordermagf64 F
+GLIBC_2.32 totalordermagl F
+GLIBC_2.32 trunc F
+GLIBC_2.32 truncf F
+GLIBC_2.32 truncf32 F
+GLIBC_2.32 truncf32x F
+GLIBC_2.32 truncf64 F
+GLIBC_2.32 truncl F
+GLIBC_2.32 ufromfp F
+GLIBC_2.32 ufromfpf F
+GLIBC_2.32 ufromfpf32 F
+GLIBC_2.32 ufromfpf32x F
+GLIBC_2.32 ufromfpf64 F
+GLIBC_2.32 ufromfpl F
+GLIBC_2.32 ufromfpx F
+GLIBC_2.32 ufromfpxf F
+GLIBC_2.32 ufromfpxf32 F
+GLIBC_2.32 ufromfpxf32x F
+GLIBC_2.32 ufromfpxf64 F
+GLIBC_2.32 ufromfpxl F
+GLIBC_2.32 y0 F
+GLIBC_2.32 y0f F
+GLIBC_2.32 y0f32 F
+GLIBC_2.32 y0f32x F
+GLIBC_2.32 y0f64 F
+GLIBC_2.32 y0l F
+GLIBC_2.32 y1 F
+GLIBC_2.32 y1f F
+GLIBC_2.32 y1f32 F
+GLIBC_2.32 y1f32x F
+GLIBC_2.32 y1f64 F
+GLIBC_2.32 y1l F
+GLIBC_2.32 yn F
+GLIBC_2.32 ynf F
+GLIBC_2.32 ynf32 F
+GLIBC_2.32 ynf32x F
+GLIBC_2.32 ynf64 F
+GLIBC_2.32 ynl F
diff --git a/sysdeps/unix/sysv/linux/or1k/libnsl.abilist b/sysdeps/unix/sysv/linux/or1k/libnsl.abilist
new file mode 100644
index 0000000000..aff212ade6
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libnsl.abilist
@@ -0,0 +1,121 @@
+GLIBC_2.32 __free_fdresult F
+GLIBC_2.32 __nis_default_access F
+GLIBC_2.32 __nis_default_group F
+GLIBC_2.32 __nis_default_owner F
+GLIBC_2.32 __nis_default_ttl F
+GLIBC_2.32 __nis_finddirectory F
+GLIBC_2.32 __nis_hash F
+GLIBC_2.32 __nisbind_connect F
+GLIBC_2.32 __nisbind_create F
+GLIBC_2.32 __nisbind_destroy F
+GLIBC_2.32 __nisbind_next F
+GLIBC_2.32 __yp_check F
+GLIBC_2.32 nis_add F
+GLIBC_2.32 nis_add_entry F
+GLIBC_2.32 nis_addmember F
+GLIBC_2.32 nis_checkpoint F
+GLIBC_2.32 nis_clone_directory F
+GLIBC_2.32 nis_clone_object F
+GLIBC_2.32 nis_clone_result F
+GLIBC_2.32 nis_creategroup F
+GLIBC_2.32 nis_destroy_object F
+GLIBC_2.32 nis_destroygroup F
+GLIBC_2.32 nis_dir_cmp F
+GLIBC_2.32 nis_domain_of F
+GLIBC_2.32 nis_domain_of_r F
+GLIBC_2.32 nis_first_entry F
+GLIBC_2.32 nis_free_directory F
+GLIBC_2.32 nis_free_object F
+GLIBC_2.32 nis_free_request F
+GLIBC_2.32 nis_freenames F
+GLIBC_2.32 nis_freeresult F
+GLIBC_2.32 nis_freeservlist F
+GLIBC_2.32 nis_freetags F
+GLIBC_2.32 nis_getnames F
+GLIBC_2.32 nis_getservlist F
+GLIBC_2.32 nis_ismember F
+GLIBC_2.32 nis_leaf_of F
+GLIBC_2.32 nis_leaf_of_r F
+GLIBC_2.32 nis_lerror F
+GLIBC_2.32 nis_list F
+GLIBC_2.32 nis_local_directory F
+GLIBC_2.32 nis_local_group F
+GLIBC_2.32 nis_local_host F
+GLIBC_2.32 nis_local_principal F
+GLIBC_2.32 nis_lookup F
+GLIBC_2.32 nis_mkdir F
+GLIBC_2.32 nis_modify F
+GLIBC_2.32 nis_modify_entry F
+GLIBC_2.32 nis_name_of F
+GLIBC_2.32 nis_name_of_r F
+GLIBC_2.32 nis_next_entry F
+GLIBC_2.32 nis_perror F
+GLIBC_2.32 nis_ping F
+GLIBC_2.32 nis_print_directory F
+GLIBC_2.32 nis_print_entry F
+GLIBC_2.32 nis_print_group F
+GLIBC_2.32 nis_print_group_entry F
+GLIBC_2.32 nis_print_link F
+GLIBC_2.32 nis_print_object F
+GLIBC_2.32 nis_print_result F
+GLIBC_2.32 nis_print_rights F
+GLIBC_2.32 nis_print_table F
+GLIBC_2.32 nis_read_obj F
+GLIBC_2.32 nis_remove F
+GLIBC_2.32 nis_remove_entry F
+GLIBC_2.32 nis_removemember F
+GLIBC_2.32 nis_rmdir F
+GLIBC_2.32 nis_servstate F
+GLIBC_2.32 nis_sperrno F
+GLIBC_2.32 nis_sperror F
+GLIBC_2.32 nis_sperror_r F
+GLIBC_2.32 nis_stats F
+GLIBC_2.32 nis_verifygroup F
+GLIBC_2.32 nis_write_obj F
+GLIBC_2.32 readColdStartFile F
+GLIBC_2.32 writeColdStartFile F
+GLIBC_2.32 xdr_cback_data F
+GLIBC_2.32 xdr_domainname F
+GLIBC_2.32 xdr_keydat F
+GLIBC_2.32 xdr_mapname F
+GLIBC_2.32 xdr_obj_p F
+GLIBC_2.32 xdr_peername F
+GLIBC_2.32 xdr_valdat F
+GLIBC_2.32 xdr_yp_buf F
+GLIBC_2.32 xdr_ypall F
+GLIBC_2.32 xdr_ypbind_binding F
+GLIBC_2.32 xdr_ypbind_resp F
+GLIBC_2.32 xdr_ypbind_resptype F
+GLIBC_2.32 xdr_ypbind_setdom F
+GLIBC_2.32 xdr_ypdelete_args F
+GLIBC_2.32 xdr_ypmap_parms F
+GLIBC_2.32 xdr_ypmaplist F
+GLIBC_2.32 xdr_yppush_status F
+GLIBC_2.32 xdr_yppushresp_xfr F
+GLIBC_2.32 xdr_ypreq_key F
+GLIBC_2.32 xdr_ypreq_nokey F
+GLIBC_2.32 xdr_ypreq_xfr F
+GLIBC_2.32 xdr_ypresp_all F
+GLIBC_2.32 xdr_ypresp_key_val F
+GLIBC_2.32 xdr_ypresp_maplist F
+GLIBC_2.32 xdr_ypresp_master F
+GLIBC_2.32 xdr_ypresp_order F
+GLIBC_2.32 xdr_ypresp_val F
+GLIBC_2.32 xdr_ypresp_xfr F
+GLIBC_2.32 xdr_ypstat F
+GLIBC_2.32 xdr_ypupdate_args F
+GLIBC_2.32 xdr_ypxfrstat F
+GLIBC_2.32 yp_all F
+GLIBC_2.32 yp_bind F
+GLIBC_2.32 yp_first F
+GLIBC_2.32 yp_get_default_domain F
+GLIBC_2.32 yp_maplist F
+GLIBC_2.32 yp_master F
+GLIBC_2.32 yp_match F
+GLIBC_2.32 yp_next F
+GLIBC_2.32 yp_order F
+GLIBC_2.32 yp_unbind F
+GLIBC_2.32 yp_update F
+GLIBC_2.32 ypbinderr_string F
+GLIBC_2.32 yperr_string F
+GLIBC_2.32 ypprot_err F
diff --git a/sysdeps/unix/sysv/linux/or1k/libpthread.abilist b/sysdeps/unix/sysv/linux/or1k/libpthread.abilist
new file mode 100644
index 0000000000..f730affc5a
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libpthread.abilist
@@ -0,0 +1,216 @@
+GLIBC_2.32 _IO_flockfile F
+GLIBC_2.32 _IO_ftrylockfile F
+GLIBC_2.32 _IO_funlockfile F
+GLIBC_2.32 __close F
+GLIBC_2.32 __connect F
+GLIBC_2.32 __errno_location F
+GLIBC_2.32 __h_errno_location F
+GLIBC_2.32 __libc_allocate_rtsig F
+GLIBC_2.32 __libc_current_sigrtmax F
+GLIBC_2.32 __libc_current_sigrtmin F
+GLIBC_2.32 __lseek F
+GLIBC_2.32 __open F
+GLIBC_2.32 __open64 F
+GLIBC_2.32 __pread64 F
+GLIBC_2.32 __pthread_cleanup_routine F
+GLIBC_2.32 __pthread_getspecific F
+GLIBC_2.32 __pthread_key_create F
+GLIBC_2.32 __pthread_mutex_destroy F
+GLIBC_2.32 __pthread_mutex_init F
+GLIBC_2.32 __pthread_mutex_lock F
+GLIBC_2.32 __pthread_mutex_trylock F
+GLIBC_2.32 __pthread_mutex_unlock F
+GLIBC_2.32 __pthread_mutexattr_destroy F
+GLIBC_2.32 __pthread_mutexattr_init F
+GLIBC_2.32 __pthread_mutexattr_settype F
+GLIBC_2.32 __pthread_once F
+GLIBC_2.32 __pthread_register_cancel F
+GLIBC_2.32 __pthread_register_cancel_defer F
+GLIBC_2.32 __pthread_rwlock_destroy F
+GLIBC_2.32 __pthread_rwlock_init F
+GLIBC_2.32 __pthread_rwlock_rdlock F
+GLIBC_2.32 __pthread_rwlock_tryrdlock F
+GLIBC_2.32 __pthread_rwlock_trywrlock F
+GLIBC_2.32 __pthread_rwlock_unlock F
+GLIBC_2.32 __pthread_rwlock_wrlock F
+GLIBC_2.32 __pthread_setspecific F
+GLIBC_2.32 __pthread_unregister_cancel F
+GLIBC_2.32 __pthread_unregister_cancel_restore F
+GLIBC_2.32 __pthread_unwind_next F
+GLIBC_2.32 __pwrite64 F
+GLIBC_2.32 __read F
+GLIBC_2.32 __res_state F
+GLIBC_2.32 __send F
+GLIBC_2.32 __sigaction F
+GLIBC_2.32 __write F
+GLIBC_2.32 _pthread_cleanup_pop F
+GLIBC_2.32 _pthread_cleanup_pop_restore F
+GLIBC_2.32 _pthread_cleanup_push F
+GLIBC_2.32 _pthread_cleanup_push_defer F
+GLIBC_2.32 accept F
+GLIBC_2.32 call_once F
+GLIBC_2.32 close F
+GLIBC_2.32 cnd_broadcast F
+GLIBC_2.32 cnd_destroy F
+GLIBC_2.32 cnd_init F
+GLIBC_2.32 cnd_signal F
+GLIBC_2.32 cnd_timedwait F
+GLIBC_2.32 cnd_wait F
+GLIBC_2.32 connect F
+GLIBC_2.32 flockfile F
+GLIBC_2.32 fsync F
+GLIBC_2.32 ftrylockfile F
+GLIBC_2.32 funlockfile F
+GLIBC_2.32 lseek F
+GLIBC_2.32 lseek64 F
+GLIBC_2.32 msync F
+GLIBC_2.32 mtx_destroy F
+GLIBC_2.32 mtx_init F
+GLIBC_2.32 mtx_lock F
+GLIBC_2.32 mtx_timedlock F
+GLIBC_2.32 mtx_trylock F
+GLIBC_2.32 mtx_unlock F
+GLIBC_2.32 open F
+GLIBC_2.32 open64 F
+GLIBC_2.32 pause F
+GLIBC_2.32 pread F
+GLIBC_2.32 pread64 F
+GLIBC_2.32 pthread_attr_getaffinity_np F
+GLIBC_2.32 pthread_attr_getguardsize F
+GLIBC_2.32 pthread_attr_getstack F
+GLIBC_2.32 pthread_attr_getstackaddr F
+GLIBC_2.32 pthread_attr_getstacksize F
+GLIBC_2.32 pthread_attr_setaffinity_np F
+GLIBC_2.32 pthread_attr_setguardsize F
+GLIBC_2.32 pthread_attr_setstack F
+GLIBC_2.32 pthread_attr_setstackaddr F
+GLIBC_2.32 pthread_attr_setstacksize F
+GLIBC_2.32 pthread_barrier_destroy F
+GLIBC_2.32 pthread_barrier_init F
+GLIBC_2.32 pthread_barrier_wait F
+GLIBC_2.32 pthread_barrierattr_destroy F
+GLIBC_2.32 pthread_barrierattr_getpshared F
+GLIBC_2.32 pthread_barrierattr_init F
+GLIBC_2.32 pthread_barrierattr_setpshared F
+GLIBC_2.32 pthread_cancel F
+GLIBC_2.32 pthread_clockjoin_np F
+GLIBC_2.32 pthread_cond_broadcast F
+GLIBC_2.32 pthread_cond_clockwait F
+GLIBC_2.32 pthread_cond_signal F
+GLIBC_2.32 pthread_cond_timedwait F
+GLIBC_2.32 pthread_cond_wait F
+GLIBC_2.32 pthread_condattr_getclock F
+GLIBC_2.32 pthread_condattr_getpshared F
+GLIBC_2.32 pthread_condattr_setclock F
+GLIBC_2.32 pthread_condattr_setpshared F
+GLIBC_2.32 pthread_create F
+GLIBC_2.32 pthread_detach F
+GLIBC_2.32 pthread_exit F
+GLIBC_2.32 pthread_getaffinity_np F
+GLIBC_2.32 pthread_getattr_default_np F
+GLIBC_2.32 pthread_getattr_np F
+GLIBC_2.32 pthread_getconcurrency F
+GLIBC_2.32 pthread_getcpuclockid F
+GLIBC_2.32 pthread_getname_np F
+GLIBC_2.32 pthread_getspecific F
+GLIBC_2.32 pthread_join F
+GLIBC_2.32 pthread_key_create F
+GLIBC_2.32 pthread_key_delete F
+GLIBC_2.32 pthread_kill F
+GLIBC_2.32 pthread_kill_other_threads_np F
+GLIBC_2.32 pthread_mutex_clocklock F
+GLIBC_2.32 pthread_mutex_consistent F
+GLIBC_2.32 pthread_mutex_consistent_np F
+GLIBC_2.32 pthread_mutex_destroy F
+GLIBC_2.32 pthread_mutex_getprioceiling F
+GLIBC_2.32 pthread_mutex_init F
+GLIBC_2.32 pthread_mutex_lock F
+GLIBC_2.32 pthread_mutex_setprioceiling F
+GLIBC_2.32 pthread_mutex_timedlock F
+GLIBC_2.32 pthread_mutex_trylock F
+GLIBC_2.32 pthread_mutex_unlock F
+GLIBC_2.32 pthread_mutexattr_destroy F
+GLIBC_2.32 pthread_mutexattr_getkind_np F
+GLIBC_2.32 pthread_mutexattr_getprioceiling F
+GLIBC_2.32 pthread_mutexattr_getprotocol F
+GLIBC_2.32 pthread_mutexattr_getpshared F
+GLIBC_2.32 pthread_mutexattr_getrobust F
+GLIBC_2.32 pthread_mutexattr_getrobust_np F
+GLIBC_2.32 pthread_mutexattr_gettype F
+GLIBC_2.32 pthread_mutexattr_init F
+GLIBC_2.32 pthread_mutexattr_setkind_np F
+GLIBC_2.32 pthread_mutexattr_setprioceiling F
+GLIBC_2.32 pthread_mutexattr_setprotocol F
+GLIBC_2.32 pthread_mutexattr_setpshared F
+GLIBC_2.32 pthread_mutexattr_setrobust F
+GLIBC_2.32 pthread_mutexattr_setrobust_np F
+GLIBC_2.32 pthread_mutexattr_settype F
+GLIBC_2.32 pthread_once F
+GLIBC_2.32 pthread_rwlock_clockrdlock F
+GLIBC_2.32 pthread_rwlock_clockwrlock F
+GLIBC_2.32 pthread_rwlock_destroy F
+GLIBC_2.32 pthread_rwlock_init F
+GLIBC_2.32 pthread_rwlock_rdlock F
+GLIBC_2.32 pthread_rwlock_timedrdlock F
+GLIBC_2.32 pthread_rwlock_timedwrlock F
+GLIBC_2.32 pthread_rwlock_tryrdlock F
+GLIBC_2.32 pthread_rwlock_trywrlock F
+GLIBC_2.32 pthread_rwlock_unlock F
+GLIBC_2.32 pthread_rwlock_wrlock F
+GLIBC_2.32 pthread_rwlockattr_destroy F
+GLIBC_2.32 pthread_rwlockattr_getkind_np F
+GLIBC_2.32 pthread_rwlockattr_getpshared F
+GLIBC_2.32 pthread_rwlockattr_init F
+GLIBC_2.32 pthread_rwlockattr_setkind_np F
+GLIBC_2.32 pthread_rwlockattr_setpshared F
+GLIBC_2.32 pthread_setaffinity_np F
+GLIBC_2.32 pthread_setattr_default_np F
+GLIBC_2.32 pthread_setcancelstate F
+GLIBC_2.32 pthread_setcanceltype F
+GLIBC_2.32 pthread_setconcurrency F
+GLIBC_2.32 pthread_setname_np F
+GLIBC_2.32 pthread_setschedprio F
+GLIBC_2.32 pthread_setspecific F
+GLIBC_2.32 pthread_sigqueue F
+GLIBC_2.32 pthread_spin_destroy F
+GLIBC_2.32 pthread_spin_init F
+GLIBC_2.32 pthread_spin_lock F
+GLIBC_2.32 pthread_spin_trylock F
+GLIBC_2.32 pthread_spin_unlock F
+GLIBC_2.32 pthread_testcancel F
+GLIBC_2.32 pthread_timedjoin_np F
+GLIBC_2.32 pthread_tryjoin_np F
+GLIBC_2.32 pthread_yield F
+GLIBC_2.32 pwrite F
+GLIBC_2.32 pwrite64 F
+GLIBC_2.32 raise F
+GLIBC_2.32 read F
+GLIBC_2.32 recv F
+GLIBC_2.32 recvfrom F
+GLIBC_2.32 recvmsg F
+GLIBC_2.32 sem_clockwait F
+GLIBC_2.32 sem_close F
+GLIBC_2.32 sem_destroy F
+GLIBC_2.32 sem_getvalue F
+GLIBC_2.32 sem_init F
+GLIBC_2.32 sem_open F
+GLIBC_2.32 sem_post F
+GLIBC_2.32 sem_timedwait F
+GLIBC_2.32 sem_trywait F
+GLIBC_2.32 sem_unlink F
+GLIBC_2.32 sem_wait F
+GLIBC_2.32 send F
+GLIBC_2.32 sendmsg F
+GLIBC_2.32 sendto F
+GLIBC_2.32 sigaction F
+GLIBC_2.32 sigwait F
+GLIBC_2.32 tcdrain F
+GLIBC_2.32 thrd_create F
+GLIBC_2.32 thrd_detach F
+GLIBC_2.32 thrd_exit F
+GLIBC_2.32 thrd_join F
+GLIBC_2.32 tss_create F
+GLIBC_2.32 tss_delete F
+GLIBC_2.32 tss_get F
+GLIBC_2.32 tss_set F
+GLIBC_2.32 write F
diff --git a/sysdeps/unix/sysv/linux/or1k/libresolv.abilist b/sysdeps/unix/sysv/linux/or1k/libresolv.abilist
new file mode 100644
index 0000000000..c5edf99ea9
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libresolv.abilist
@@ -0,0 +1,79 @@
+GLIBC_2.32 __b64_ntop F
+GLIBC_2.32 __b64_pton F
+GLIBC_2.32 __dn_comp F
+GLIBC_2.32 __dn_count_labels F
+GLIBC_2.32 __dn_expand F
+GLIBC_2.32 __dn_skipname F
+GLIBC_2.32 __fp_nquery F
+GLIBC_2.32 __fp_query F
+GLIBC_2.32 __fp_resstat F
+GLIBC_2.32 __hostalias F
+GLIBC_2.32 __loc_aton F
+GLIBC_2.32 __loc_ntoa F
+GLIBC_2.32 __p_cdname F
+GLIBC_2.32 __p_cdnname F
+GLIBC_2.32 __p_class F
+GLIBC_2.32 __p_class_syms D 0x54
+GLIBC_2.32 __p_fqname F
+GLIBC_2.32 __p_fqnname F
+GLIBC_2.32 __p_option F
+GLIBC_2.32 __p_query F
+GLIBC_2.32 __p_rcode F
+GLIBC_2.32 __p_time F
+GLIBC_2.32 __p_type F
+GLIBC_2.32 __p_type_syms D 0x228
+GLIBC_2.32 __putlong F
+GLIBC_2.32 __putshort F
+GLIBC_2.32 __res_close F
+GLIBC_2.32 __res_dnok F
+GLIBC_2.32 __res_hnok F
+GLIBC_2.32 __res_hostalias F
+GLIBC_2.32 __res_isourserver F
+GLIBC_2.32 __res_mailok F
+GLIBC_2.32 __res_mkquery F
+GLIBC_2.32 __res_nameinquery F
+GLIBC_2.32 __res_nmkquery F
+GLIBC_2.32 __res_nquery F
+GLIBC_2.32 __res_nquerydomain F
+GLIBC_2.32 __res_nsearch F
+GLIBC_2.32 __res_nsend F
+GLIBC_2.32 __res_ownok F
+GLIBC_2.32 __res_queriesmatch F
+GLIBC_2.32 __res_query F
+GLIBC_2.32 __res_querydomain F
+GLIBC_2.32 __res_search F
+GLIBC_2.32 __res_send F
+GLIBC_2.32 __sym_ntop F
+GLIBC_2.32 __sym_ntos F
+GLIBC_2.32 __sym_ston F
+GLIBC_2.32 _getlong F
+GLIBC_2.32 _getshort F
+GLIBC_2.32 inet_net_ntop F
+GLIBC_2.32 inet_net_pton F
+GLIBC_2.32 inet_neta F
+GLIBC_2.32 ns_datetosecs F
+GLIBC_2.32 ns_format_ttl F
+GLIBC_2.32 ns_get16 F
+GLIBC_2.32 ns_get32 F
+GLIBC_2.32 ns_initparse F
+GLIBC_2.32 ns_makecanon F
+GLIBC_2.32 ns_msg_getflag F
+GLIBC_2.32 ns_name_compress F
+GLIBC_2.32 ns_name_ntol F
+GLIBC_2.32 ns_name_ntop F
+GLIBC_2.32 ns_name_pack F
+GLIBC_2.32 ns_name_pton F
+GLIBC_2.32 ns_name_rollback F
+GLIBC_2.32 ns_name_skip F
+GLIBC_2.32 ns_name_uncompress F
+GLIBC_2.32 ns_name_unpack F
+GLIBC_2.32 ns_parse_ttl F
+GLIBC_2.32 ns_parserr F
+GLIBC_2.32 ns_put16 F
+GLIBC_2.32 ns_put32 F
+GLIBC_2.32 ns_samedomain F
+GLIBC_2.32 ns_samename F
+GLIBC_2.32 ns_skiprr F
+GLIBC_2.32 ns_sprintrr F
+GLIBC_2.32 ns_sprintrrf F
+GLIBC_2.32 ns_subdomain F
diff --git a/sysdeps/unix/sysv/linux/or1k/librt.abilist b/sysdeps/unix/sysv/linux/or1k/librt.abilist
new file mode 100644
index 0000000000..fda2b20c01
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/librt.abilist
@@ -0,0 +1,35 @@
+GLIBC_2.32 __mq_open_2 F
+GLIBC_2.32 aio_cancel F
+GLIBC_2.32 aio_cancel64 F
+GLIBC_2.32 aio_error F
+GLIBC_2.32 aio_error64 F
+GLIBC_2.32 aio_fsync F
+GLIBC_2.32 aio_fsync64 F
+GLIBC_2.32 aio_init F
+GLIBC_2.32 aio_read F
+GLIBC_2.32 aio_read64 F
+GLIBC_2.32 aio_return F
+GLIBC_2.32 aio_return64 F
+GLIBC_2.32 aio_suspend F
+GLIBC_2.32 aio_suspend64 F
+GLIBC_2.32 aio_write F
+GLIBC_2.32 aio_write64 F
+GLIBC_2.32 lio_listio F
+GLIBC_2.32 lio_listio64 F
+GLIBC_2.32 mq_close F
+GLIBC_2.32 mq_getattr F
+GLIBC_2.32 mq_notify F
+GLIBC_2.32 mq_open F
+GLIBC_2.32 mq_receive F
+GLIBC_2.32 mq_send F
+GLIBC_2.32 mq_setattr F
+GLIBC_2.32 mq_timedreceive F
+GLIBC_2.32 mq_timedsend F
+GLIBC_2.32 mq_unlink F
+GLIBC_2.32 shm_open F
+GLIBC_2.32 shm_unlink F
+GLIBC_2.32 timer_create F
+GLIBC_2.32 timer_delete F
+GLIBC_2.32 timer_getoverrun F
+GLIBC_2.32 timer_gettime F
+GLIBC_2.32 timer_settime F
diff --git a/sysdeps/unix/sysv/linux/or1k/libthread_db.abilist b/sysdeps/unix/sysv/linux/or1k/libthread_db.abilist
new file mode 100644
index 0000000000..dcbc4a8fbe
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libthread_db.abilist
@@ -0,0 +1,40 @@
+GLIBC_2.32 td_init F
+GLIBC_2.32 td_log F
+GLIBC_2.32 td_symbol_list F
+GLIBC_2.32 td_ta_clear_event F
+GLIBC_2.32 td_ta_delete F
+GLIBC_2.32 td_ta_enable_stats F
+GLIBC_2.32 td_ta_event_addr F
+GLIBC_2.32 td_ta_event_getmsg F
+GLIBC_2.32 td_ta_get_nthreads F
+GLIBC_2.32 td_ta_get_ph F
+GLIBC_2.32 td_ta_get_stats F
+GLIBC_2.32 td_ta_map_id2thr F
+GLIBC_2.32 td_ta_map_lwp2thr F
+GLIBC_2.32 td_ta_new F
+GLIBC_2.32 td_ta_reset_stats F
+GLIBC_2.32 td_ta_set_event F
+GLIBC_2.32 td_ta_setconcurrency F
+GLIBC_2.32 td_ta_thr_iter F
+GLIBC_2.32 td_ta_tsd_iter F
+GLIBC_2.32 td_thr_clear_event F
+GLIBC_2.32 td_thr_dbresume F
+GLIBC_2.32 td_thr_dbsuspend F
+GLIBC_2.32 td_thr_event_enable F
+GLIBC_2.32 td_thr_event_getmsg F
+GLIBC_2.32 td_thr_get_info F
+GLIBC_2.32 td_thr_getfpregs F
+GLIBC_2.32 td_thr_getgregs F
+GLIBC_2.32 td_thr_getxregs F
+GLIBC_2.32 td_thr_getxregsize F
+GLIBC_2.32 td_thr_set_event F
+GLIBC_2.32 td_thr_setfpregs F
+GLIBC_2.32 td_thr_setgregs F
+GLIBC_2.32 td_thr_setprio F
+GLIBC_2.32 td_thr_setsigpending F
+GLIBC_2.32 td_thr_setxregs F
+GLIBC_2.32 td_thr_sigsetmask F
+GLIBC_2.32 td_thr_tls_get_addr F
+GLIBC_2.32 td_thr_tlsbase F
+GLIBC_2.32 td_thr_tsd F
+GLIBC_2.32 td_thr_validate F
diff --git a/sysdeps/unix/sysv/linux/or1k/libutil.abilist b/sysdeps/unix/sysv/linux/or1k/libutil.abilist
new file mode 100644
index 0000000000..61f73bc34e
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/libutil.abilist
@@ -0,0 +1,6 @@
+GLIBC_2.32 forkpty F
+GLIBC_2.32 login F
+GLIBC_2.32 login_tty F
+GLIBC_2.32 logout F
+GLIBC_2.32 logwtmp F
+GLIBC_2.32 openpty F
diff --git a/sysdeps/unix/sysv/linux/or1k/localplt.data b/sysdeps/unix/sysv/linux/or1k/localplt.data
new file mode 100644
index 0000000000..0ed8650b65
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/localplt.data
@@ -0,0 +1,13 @@
+# See scripts/check-localplt.awk for how this file is processed.
+# PLT use is required for the malloc family and for matherr because
+# users can define their own functions and have library internals call them.
+libc.so: calloc
+libc.so: free
+libc.so: malloc
+libc.so: memalign
+libc.so: realloc
+# The TLS-enabled version of these functions is interposed from libc.so.
+ld.so: _dl_signal_error
+ld.so: _dl_catch_error
+ld.so: _dl_signal_exception
+ld.so: _dl_catch_exception
diff --git a/sysdeps/unix/sysv/linux/or1k/lowlevellock.h b/sysdeps/unix/sysv/linux/or1k/lowlevellock.h
new file mode 100644
index 0000000000..1ab277ad19
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/lowlevellock.h
@@ -0,0 +1,23 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _OR1K_LOWLEVELLOCK_H
+#define _OR1K_LOWLEVELLOCK_H	1
+
+#include <sysdeps/nptl/lowlevellock.h>
+
+#endif /* lowlevellock.h */
diff --git a/sysdeps/unix/sysv/linux/or1k/makecontext.c b/sysdeps/unix/sysv/linux/or1k/makecontext.c
new file mode 100644
index 0000000000..e1626b1ad6
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/makecontext.c
@@ -0,0 +1,77 @@
+/* Create new context.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <ucontext.h>
+
+/* makecontext sets up a stack and the registers for the
+   user context.  The stack looks like this:
+
+               +-----------------------+
+	       | padding as required   |
+               +-----------------------+
+    sp ->      | parameters 7 to n     |
+               +-----------------------+
+
+   The registers are set up like this:
+     r3-r8  : parameters 1 to 6
+     r14    : uc_link
+     r1     : stack pointer
+     r2     : frame pointer, set to NULL
+*/
+void
+__makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
+{
+  extern void __startcontext (void);
+  unsigned long *sp;
+  va_list ap;
+  int i;
+
+  sp = (unsigned long *)
+    ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
+
+  /* Allocate stack arguments.  */
+  sp -= argc < 6 ? 0 : argc - 6;
+
+  /* Keep the stack aligned.  */
+  sp = (unsigned long*) (((uintptr_t) sp) & -4L);
+
+  /* Keep uc_link in r14.  */
+  ucp->uc_mcontext.__gprs[14] = (uintptr_t) ucp->uc_link;
+  /* Return address points to __startcontext().  */
+  ucp->uc_mcontext.__gprs[9] = (uintptr_t) &__startcontext;
+  /* Frame pointer is null.  */
+  ucp->uc_mcontext.__gprs[2] = (uintptr_t) 0;
+  /* Restart in user-space starting at 'func'.  */
+  ucp->uc_mcontext.__gprs[11] = (uintptr_t) func;
+  /* Set stack pointer.  */
+  ucp->uc_mcontext.__gprs[1] = (uintptr_t) sp;
+
+  va_start (ap, argc);
+  for (i = 0; i < argc; ++i)
+    if (i < 6)
+      ucp->uc_mcontext.__gprs[i + 3] = va_arg (ap, unsigned long);
+    else
+      sp[i - 6] = va_arg (ap, unsigned long);
+
+  va_end (ap);
+}
+
+weak_alias (__makecontext, makecontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/mmap_internal.h b/sysdeps/unix/sysv/linux/or1k/mmap_internal.h
new file mode 100644
index 0000000000..79cefe667b
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/mmap_internal.h
@@ -0,0 +1,29 @@
+/* Common mmap definition for Linux implementation.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef MMAP_OR1K_INTERNAL_LINUX_H
+#define MMAP_OR1K_INTERNAL_LINUX_H
+
+/* Linux allows PAGE_SHIFT in range of [12-16] and expect
+   mmap2 offset to be provided in based on the configured pagesize.
+   Determine the shift dynamically with getpagesize.  */
+#define MMAP2_PAGE_UNIT -1
+
+#include_next <mmap_internal.h>
+
+#endif
diff --git a/sysdeps/unix/sysv/linux/or1k/or1k_clone.S b/sysdeps/unix/sysv/linux/or1k/or1k_clone.S
new file mode 100644
index 0000000000..9157736278
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/or1k_clone.S
@@ -0,0 +1,112 @@
+/* clone helper __or1k_clone for OpenRISC.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdep.h>
+#include <tls.h>
+#define __ASSEMBLY__
+#include <linux/sched.h>
+
+	.text
+ENTRY(__or1k_clone)
+
+	/* To handle GCC varargs we need to use our __clone wrapper to pop
+	   everything from the stack for us.
+	   Now everything is placed in the registers which saves us a lot
+	   of trouble.
+
+	   The userland implementation is:
+
+	     int clone (int (*fn)(void *), void *child_stack,
+			int flags, void *arg, pid_t *ptid,
+			struct user_desc *tls, pid_t *ctid);
+	   The kernel entry is:
+
+	     int clone (long flags, void *child_stack, int *parent_tid,
+			int *child_tid, struct void *tls)
+
+	     NB: tls isn't really an argument, it is read from r7 directly.  */
+
+	/* Put 'fn', 'arg' and 'flags' on the child stack.  */
+	l.addi	r4, r4, -12
+	l.sw	8(r4), r3
+	l.sw	4(r4), r6
+	l.sw	0(r4), r5
+
+	l.ori	r3, r5, 0
+	/* The child_stack is already in r4.  */
+	l.ori	r5, r7, 0
+	l.lwz	r6, 0(r1)
+	l.ori	r7, r8, 0
+
+	DO_CALL (clone)
+
+	l.sfgeui r11, 0xf001
+	l.bf	L(error)
+	 l.nop
+
+	/* If we are not the child, return the pidi.  */
+	l.sfeqi	r11, 0
+	l.bf	L(child)
+	 l.nop
+
+	l.jr	r9
+	 l.nop
+
+L(child):
+	/* Load flags.  */
+	l.lwz	r3, 0(r1)
+
+	/* Update PID, but only if we do not share the same PID
+	   as our parent.  */
+	l.srli 	r4, r3, 16
+	l.andi	r4, r4, hi(CLONE_THREAD)
+	l.sfnei	r4, 0
+	l.bf	L(oldpid)
+	 l.nop
+
+	/* If we share the same memory space, reset the PID/TID values.
+	   Apparently getpid caches, so we want to make sure it's flushed.  */
+	l.ori	r11, r0, -1
+	l.andi	r4, r3, CLONE_VM
+	l.sfnei	r4, 0
+	l.bf	L(setpid)
+	 l.nop
+
+	/* Else we update them.  */
+	DO_CALL (getpid)
+
+L(setpid):
+	l.addi	r3, r10, TP_TO_PTHREAD_OFFSET
+	l.sw	TID_OFFSET(r3), r11
+
+L(oldpid):
+	/* Load function from stack.  */
+	l.lwz	r11, 8(r1)
+	l.jalr	r11
+	 l.lwz	r3, 4(r1)
+
+	/* Exit the child thread.  */
+	l.ori	r3, r11, 0
+	DO_CALL (exit)
+
+L(error):
+	l.j	SYSCALL_ERROR_NAME
+	 l.ori	r3,r11,0
+
+PSEUDO_END (__or1k_clone)
diff --git a/sysdeps/unix/sysv/linux/or1k/prctl.c b/sysdeps/unix/sysv/linux/or1k/prctl.c
new file mode 100644
index 0000000000..fc7e823974
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/prctl.c
@@ -0,0 +1,41 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <stdarg.h>
+#include <sysdep.h>
+
+/* or1k ABI uses stack for varargs, syscall uses registers.
+ * This function moves from varargs to regs. */
+int
+__prctl (int __option, ...)
+{
+  va_list ap;
+  unsigned long arg2;
+  unsigned long arg3;
+  unsigned long arg4;
+  unsigned long arg5;
+
+  va_start (ap, __option);
+  arg2 = va_arg (ap, unsigned long);
+  arg3 = va_arg (ap, unsigned long);
+  arg4 = va_arg (ap, unsigned long);
+  arg5 = va_arg (ap, unsigned long);
+  va_end (ap);
+
+  return INLINE_SYSCALL (prctl, 5, __option, arg2, arg3, arg4, arg5);
+}
+weak_alias (__prctl, prctl)
diff --git a/sysdeps/unix/sysv/linux/or1k/pt-vfork.c b/sysdeps/unix/sysv/linux/or1k/pt-vfork.c
new file mode 100644
index 0000000000..0169ec4f60
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/pt-vfork.c
@@ -0,0 +1,30 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <errno.h>
+#include <unistd.h>
+
+/* If we don't have vfork, fork is close enough.  */
+
+__pid_t
+__vfork (void)
+{
+  return __fork ();
+}
+libc_hidden_def (__vfork)
+
+weak_alias (__vfork, vfork)
diff --git a/sysdeps/unix/sysv/linux/or1k/setcontext.S b/sysdeps/unix/sysv/linux/or1k/setcontext.S
new file mode 100644
index 0000000000..9adfc56728
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/setcontext.S
@@ -0,0 +1,110 @@
+/* Set current context.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+#include "ucontext_i.h"
+
+/* int setcontext (const ucontext_t *ucp) */
+	.text
+ENTRY(__setcontext)
+	l.ori	r12, r3, 0
+
+	/* Restore signal mask.  */
+	/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.ori	r5, r0, 0
+	l.addi	r4, r3, UCONTEXT_SIGMASK
+	l.ori	r3, r0, SIG_SETMASK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys 1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+	/* Restore argument registers, for the makecontext() case.  */
+	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r12)
+	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r12)
+	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r12)
+	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r12)
+	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r12)
+	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r12)
+
+	/* Restore registers stored in getcontext().  */
+	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r12)
+	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r12)
+	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r12)
+	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r12)
+	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r12)
+	/* Restore r14-r30 even, callee saved registers.  */
+	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r12)
+	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r12)
+	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r12)
+	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r12)
+	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r12)
+	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r12)
+	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r12)
+	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r12)
+	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r12)
+
+	l.jr	r11
+ 	 l.ori	r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END (__setcontext)
+weak_alias (__setcontext, setcontext)
+
+	/* We add a NOP here because when the unwinder is looking for the
+	   enclosing function of the link register (r9) address FDE lookup will
+	   use '$r9 - 1' finding setcontext which is wrong.  This is because in
+	   makecontext we have set r9 to the start of &__startcontext.
+
+	   If this NOP did not exist the unwinder would repeatedly find
+	   __setcontext's FDE in an infinite loop.  Modifiying/deleting the below
+	   __startcontext's FDE has no help on this.  */
+	l.nop
+
+ENTRY(__startcontext)
+
+	l.ori	r3, r14, 0
+	l.sfeq	r3, r0
+	/* If uc_link is not 0 resume there, otherwise exit.  */
+	l.bnf	__setcontext
+	 l.nop
+
+#ifdef SHARED
+	/* Obtain a pointer to .got in r16 */
+	l.jal	.LPC0
+	 l.nop
+.LPC0:
+	l.movhi	r16, gotpchi(_GLOBAL_OFFSET_TABLE_+(.-.LPC0))
+	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+(.-.LPC0))
+	l.add	r16, r16, r9
+	l.lwz	r16, got(exit)(r16)
+	l.jr	r16
+#else
+	l.j	exit
+#endif
+	 l.nop
+
+END(__startcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/shlib-versions b/sysdeps/unix/sysv/linux/or1k/shlib-versions
new file mode 100644
index 0000000000..c2217b3243
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/shlib-versions
@@ -0,0 +1,2 @@
+DEFAULT                 GLIBC_2.32
+ld=ld-linux-or1k.so.1
diff --git a/sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h b/sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
new file mode 100644
index 0000000000..a42a55d976
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
@@ -0,0 +1,28 @@
+/* Profile counter helper to get PC from sigcontext. OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SIGCONTEXTINFO_H
+#define _SIGCONTEXTINFO_H
+
+static inline uintptr_t
+sigcontext_get_pc (const ucontext_t *ctx)
+{
+  return ctx->uc_mcontext.__pc;
+}
+
+#endif
diff --git a/sysdeps/unix/sysv/linux/or1k/swapcontext.S b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
new file mode 100644
index 0000000000..67d3fa67b8
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
@@ -0,0 +1,116 @@
+/* Swap two contexts.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+#include "ucontext_i.h"
+
+/* int swapcontext (ucontext_t *oucp, const ucontext_t *ucp) */
+	.text
+ENTRY(__swapcontext)
+
+	/* Same as getcontext().  */
+	/* Store r1, the stack pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  1*4)(r3), r1
+	/* Store r2, the frame pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  2*4)(r3), r2
+	/* Store r9, the link register.  */
+	l.sw	(UCONTEXT_MCONTEXT +  9*4)(r3), r9
+	/* Store r9 to reg[11] too, as we need two links for makecontext().  */
+	l.sw	(UCONTEXT_MCONTEXT + 11*4)(r3), r9
+	/* Store r10, the TLS register.  */
+	l.sw	(UCONTEXT_MCONTEXT + 10*4)(r3), r10
+	/* Store r14-r30 even, callee saved registers.  */
+	l.sw	(UCONTEXT_MCONTEXT + 14*4)(r3), r14
+	l.sw	(UCONTEXT_MCONTEXT + 16*4)(r3), r16
+	l.sw	(UCONTEXT_MCONTEXT + 18*4)(r3), r18
+	l.sw	(UCONTEXT_MCONTEXT + 20*4)(r3), r20
+	l.sw	(UCONTEXT_MCONTEXT + 22*4)(r3), r22
+	l.sw	(UCONTEXT_MCONTEXT + 24*4)(r3), r24
+	l.sw	(UCONTEXT_MCONTEXT + 26*4)(r3), r26
+	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
+	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
+
+	/* Store ucp to non-argument syscall preserved resiger.  */
+	l.ori	r12, r4, 0
+
+	/* Get signal mask.  */
+	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.addi	r5, r3, UCONTEXT_SIGMASK
+	l.ori	r4, r0, 0
+	l.ori	r3, r0, SIG_BLOCK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys	1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+	/* Same as setcontext().  */
+
+	/* Restore signal mask.  */
+	/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.ori	r5, r0, 0
+	l.addi	r4, r12, UCONTEXT_SIGMASK
+	l.ori	r3, r0, SIG_SETMASK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys 1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+	/* Restore argument registers, for the makecontext() case.  */
+	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r12)
+	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r12)
+	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r12)
+	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r12)
+	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r12)
+	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r12)
+
+	/* Restore registers stored in getcontext().  */
+	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r12)
+	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r12)
+	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r12)
+	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r12)
+	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r12)
+	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r12)
+	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r12)
+	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r12)
+	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r12)
+	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r12)
+	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r12)
+	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r12)
+	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r12)
+	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r12)
+
+	l.jr	r11
+ 	 l.ori	r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END (__swapcontext)
+weak_alias (__swapcontext, swapcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/sys/procfs.h b/sysdeps/unix/sysv/linux/or1k/sys/procfs.h
new file mode 100644
index 0000000000..3147f8a818
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sys/procfs.h
@@ -0,0 +1,120 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_PROCFS_H
+#define _SYS_PROCFS_H	1
+
+/* This is somewhat modelled after the file of the same name on SVR4
+   systems.  It provides a definition of the core file format for ELF
+   used on Linux.  It doesn't have anything to do with the /proc file
+   system, even though Linux has one.
+
+   Anyway, the whole purpose of this file is for GDB and GDB only.
+   Don't read too much into it.  Don't use it for anything other than
+   GDB unless you know what you are doing.  */
+
+#include <features.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/user.h>
+#include <asm/elf.h>
+
+/* TODO: this looks like a complete copy, is it needed?  */
+
+__BEGIN_DECLS
+
+/* Type for a general-purpose register.  */
+typedef unsigned long elf_greg_t;
+
+/* And the whole bunch of them.  We could have used `struct
+   user_regs' directly in the typedef, but tradition says that
+   the register set is an array, which does have some peculiar
+   semantics, so leave it that way.  */
+
+/* Signal info.  */
+struct elf_siginfo
+  {
+    int si_signo;			/* Signal number.  */
+    int si_code;			/* Extra code.  */
+    int si_errno;			/* Errno.  */
+  };
+
+/* Definitions to generate Intel SVR4-like core files.  These mostly
+   have the same names as the SVR4 types with "elf_" tacked on the
+   front to prevent clashes with Linux definitions, and the typedef
+   forms have been avoided.  This is mostly like the SVR4 structure,
+   but more Linuxy, with things that Linux does not support and which
+   GDB doesn't really use excluded.  */
+
+struct elf_prstatus
+  {
+    struct elf_siginfo pr_info;		/* Info associated with signal.  */
+    short int pr_cursig;		/* Current signal.  */
+    unsigned long int pr_sigpend;	/* Set of pending signals.  */
+    unsigned long int pr_sighold;	/* Set of held signals.  */
+    __pid_t pr_pid;
+    __pid_t pr_ppid;
+    __pid_t pr_pgrp;
+    __pid_t pr_sid;
+    struct timeval pr_utime;		/* User time.  */
+    struct timeval pr_stime;		/* System time.  */
+    struct timeval pr_cutime;		/* Cumulative user time.  */
+    struct timeval pr_cstime;		/* Cumulative system time.  */
+    elf_gregset_t pr_reg;		/* GP registers.  */
+    int pr_fpvalid;			/* True if math copro being used.  */
+  };
+
+
+#define ELF_PRARGSZ     (80)    /* Number of chars for args.  */
+
+struct elf_prpsinfo
+  {
+    char pr_state;			/* Numeric process state.  */
+    char pr_sname;			/* Char for pr_state.  */
+    char pr_zomb;			/* Zombie.  */
+    char pr_nice;			/* Nice val.  */
+    unsigned long int pr_flag;		/* Flags.  */
+    unsigned short int pr_uid;
+    unsigned short int pr_gid;
+    int pr_pid, pr_ppid, pr_pgrp, pr_sid;
+    /* Lots missing */
+    char pr_fname[16];			/* Filename of executable.  */
+    char pr_psargs[ELF_PRARGSZ];	/* Initial part of arg list.  */
+  };
+
+/* The rest of this file provides the types for emulation of the
+   Solaris <proc_service.h> interfaces that should be implemented by
+   users of libthread_db.  */
+
+/* Addresses.  */
+typedef void *psaddr_t;
+
+/* Register sets.  Linux has different names.  */
+typedef elf_gregset_t prgregset_t;
+typedef elf_fpregset_t prfpregset_t;
+
+/* We don't have any differences between processes and threads,
+   therefore have only one PID type.  */
+typedef __pid_t lwpid_t;
+
+/* Process status and info.  In the end we do provide typedefs for them.  */
+typedef struct elf_prstatus prstatus_t;
+typedef struct elf_prpsinfo prpsinfo_t;
+
+__END_DECLS
+
+#endif	/* sys/procfs.h */
diff --git a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
new file mode 100644
index 0000000000..5fef2c3c5b
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
@@ -0,0 +1,48 @@
+/* ucontext_t definition, OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+/* System V/OpenRISC compliant context switching support.  */
+
+#ifndef _SYS_UCONTEXT_H
+#define _SYS_UCONTEXT_H	1
+
+#include <features.h>
+
+#include <bits/types/sigset_t.h>
+#include <bits/types/stack_t.h>
+
+
+/* Context to describe whole processor state.  */
+typedef struct
+  {
+    unsigned long __gprs[32];
+    unsigned long __pc;
+    unsigned long __sr;
+  } mcontext_t;
+
+/* Userlevel context.  */
+typedef struct ucontext_t
+  {
+    unsigned long __uc_flags;    /* getcontext() 1, ... */
+    struct ucontext_t *uc_link;  /* user setup before makecontext () */
+    stack_t uc_stack;            /* user setup before make context() */
+    mcontext_t uc_mcontext;      /* getcontext() regs, v2    : makecontext() func, sp, RA=__startcontext, args injected */
+    sigset_t uc_sigmask;         /* getcontext() sigprocmask : */
+  } ucontext_t;
+
+#endif /* sys/ucontext.h */
diff --git a/sysdeps/unix/sysv/linux/or1k/sys/user.h b/sysdeps/unix/sysv/linux/or1k/sys/user.h
new file mode 100644
index 0000000000..c871f1a03d
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sys/user.h
@@ -0,0 +1 @@
+/* This file is not needed, but in practice gdb might try to include it.  */
diff --git a/sysdeps/unix/sysv/linux/or1k/syscall.c b/sysdeps/unix/sysv/linux/or1k/syscall.c
new file mode 100644
index 0000000000..6d491bb4b5
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/syscall.c
@@ -0,0 +1,45 @@
+/* System call interface.  OpenRISC version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+#include <stdarg.h>
+
+long int
+syscall (long int syscall_number, ...)
+{
+  unsigned long arg1, arg2, arg3, arg4, arg5, arg6;
+  va_list arg;
+  long int ret;
+
+  va_start (arg, syscall_number);
+  arg1 = va_arg (arg, unsigned long);
+  arg2 = va_arg (arg, unsigned long);
+  arg3 = va_arg (arg, unsigned long);
+  arg4 = va_arg (arg, unsigned long);
+  arg5 = va_arg (arg, unsigned long);
+  arg6 = va_arg (arg, unsigned long);
+  va_end (arg);
+
+  ret = INTERNAL_SYSCALL_NCS (syscall_number, 6, arg1, arg2, arg3, arg4,
+			      arg5, arg6);
+
+  if (INTERNAL_SYSCALL_ERROR_P (ret))
+    return __syscall_error (ret);
+
+  return ret;
+}
diff --git a/sysdeps/unix/sysv/linux/or1k/sysdep.c b/sysdeps/unix/sysv/linux/or1k/sysdep.c
new file mode 100644
index 0000000000..3b681e14aa
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sysdep.c
@@ -0,0 +1,33 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdep.h>
+#include <errno.h>
+
+long __syscall_error (long err);
+hidden_proto (__syscall_error)
+
+/* This routine is jumped to by all the syscall handlers, to stash
+   an error number into errno.  */
+long
+__syscall_error (long err)
+{
+  __set_errno (- err);
+  return -1;
+}
+hidden_def (__syscall_error)
diff --git a/sysdeps/unix/sysv/linux/or1k/sysdep.h b/sysdeps/unix/sysv/linux/or1k/sysdep.h
new file mode 100644
index 0000000000..9ab37af64f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sysdep.h
@@ -0,0 +1,167 @@
+/* Copyright (C) 2020 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sysdeps/or1k/sysdep.h>
+#include <sysdeps/unix/sysv/linux/generic/sysdep.h>
+#include <sys/syscall.h>
+
+#undef SYS_ify
+#define SYS_ify(syscall_name)   (__NR_##syscall_name)
+
+/* Linux uses a negative return value to indicate syscall errors,
+   unlike most Unices, which use the condition codes' carry flag.
+
+   Since version 2.1 the return value of a system call might be
+   negative even if the call succeeded.  E.g., the `lseek' system call
+   might return a large offset.  Therefore we must not anymore test
+   for < 0, but test for a real error by making sure the value in R0
+   is a real error number.  Linus said he will make sure the no syscall
+   returns a value in -1 .. -4095 as a valid result so we can safely
+   test with -4095.  */
+
+#ifdef __ASSEMBLER__
+
+/* Macros used in syscall-template.S */
+#define ret          l.jr r9; l.nop
+#define ret_NOERRNO  l.jr r9; l.nop
+
+#undef	DO_CALL
+#define DO_CALL(syscall_name) \
+  l.addi r11, r0, SYS_ify (syscall_name); \
+  l.sys 1; \
+   l.nop
+
+#undef	PSEUDO
+#define PSEUDO(name, syscall_name, args) \
+  ENTRY (name); \
+  DO_CALL(syscall_name); \
+  /* if -4096 < ret < 0 holds, it's an error */ \
+  l.sfgeui r11, 0xf001; \
+  l.bf L(pseudo_end); \
+   l.nop
+
+#undef	PSEUDO_NOERRNO
+#define PSEUDO_NOERRNO(name, syscall_name, args)  \
+  ENTRY (name);           \
+  DO_CALL(syscall_name)
+
+#undef	PSEUDO_END
+#define PSEUDO_END(name) \
+L(pseudo_end): \
+  l.j SYSCALL_ERROR_NAME; \
+  l.ori r3,r11,0; \
+  END (name)
+
+#undef	PSEUDO_END_NOERRNO
+#define PSEUDO_END_NOERRNO(name) \
+  END (name)
+
+#ifndef PIC
+/* For static code, on error jump to __syscall_error directly. */
+# define SYSCALL_ERROR_NAME __syscall_error
+#elif !IS_IN (libc)
+/* Use the internal name for libc/libpthread shared objects. */
+# define SYSCALL_ERROR_NAME __GI___syscall_error
+#else
+/* Otherwise, on error do a full PLT jump. */
+# define SYSCALL_ERROR_NAME plt(__syscall_error)
+#endif
+
+#else /* not __ASSEMBLER__ */
+
+#include <errno.h>
+
+extern long int __syscall_error (long int neg_errno);
+
+/* Pointer mangling is not yet supported for or1k.  */
+#define PTR_MANGLE(var) (void) (var)
+#define PTR_DEMANGLE(var) (void) (var)
+
+#undef INTERNAL_SYSCALL
+#define INTERNAL_SYSCALL(name, nr, args...) \
+	INTERNAL_SYSCALL_NCS (SYS_ify (name), nr, args)
+
+/* The _NCS variant allows non-constant syscall numbers.  */
+#undef INTERNAL_SYSCALL_NCS
+#define INTERNAL_SYSCALL_NCS(number, nr, args...) \
+        ({ unsigned long __sys_result;                                         \
+          {                                                                    \
+            long _sc_ret = (long) number;                                      \
+            LOAD_ARGS_##nr (args)                                              \
+            register long __sc_ret __asm__ ("r11") = _sc_ret;                  \
+            __asm__ __volatile__ ("l.sys 1\n\t"                                \
+				  " l.nop\n\t"                                 \
+                                  : "+r" (__sc_ret)                            \
+                                  : ASM_ARGS_##nr                              \
+                                  : ASM_CLOBBERS_##nr                          \
+                                    "r12", "r13", "r15", "r17", "r19",         \
+                                    "r21", "r23", "r25", "r27", "r29",         \
+                                    "r31", "memory");                          \
+            __sys_result = __sc_ret;                                           \
+          }                                                                    \
+          (long) __sys_result; })
+
+/* From here on we have nested macros that generate code for
+ * storing arguments to the syscall */
+
+#define LOAD_ARGS_0()
+
+#define ASM_ARGS_0
+#define ASM_CLOBBERS_0  "r3", ASM_CLOBBERS_1
+
+#define LOAD_ARGS_1(a) \
+  long _a = (long)(a);                                      \
+  register long __a __asm__ ("r3") = _a;
+#define ASM_ARGS_1 "r" (__a)
+#define ASM_CLOBBERS_1  "r4", ASM_CLOBBERS_2
+
+#define LOAD_ARGS_2(a, b) \
+  long _b = (long)(b);                                     \
+  LOAD_ARGS_1 (a)                                          \
+  register long __b __asm__ ("r4") = _b;
+#define ASM_ARGS_2 ASM_ARGS_1, "r" (__b)
+#define ASM_CLOBBERS_2  "r5", ASM_CLOBBERS_3
+
+#define LOAD_ARGS_3(a, b, c) \
+  long _c = (long)(c);                                     \
+  LOAD_ARGS_2 (a, b)                                       \
+  register long __c __asm__ ("r5") = _c;
+#define ASM_ARGS_3 ASM_ARGS_2, "r" (__c)
+#define ASM_CLOBBERS_3  "r6", ASM_CLOBBERS_4
+
+#define LOAD_ARGS_4(a, b, c, d) \
+    LOAD_ARGS_3 (a, b, c)                                  \
+  long _d = (long)(d);                                     \
+  register long __d __asm__ ("r6") = _d;
+#define ASM_ARGS_4 ASM_ARGS_3, "r" (__d)
+#define ASM_CLOBBERS_4  "r7", ASM_CLOBBERS_5
+
+#define LOAD_ARGS_5(a, b, c, d, e) \
+  long _e = (long)(e);                                     \
+  LOAD_ARGS_4 (a, b, c, d)                                 \
+  register long __e __asm__ ("r7") = _e;
+#define ASM_ARGS_5 ASM_ARGS_4, "r" (__e)
+#define ASM_CLOBBERS_5  "r8", ASM_CLOBBERS_6
+
+#define LOAD_ARGS_6(a, b, c, d, e, f) \
+  long _f = (long)(f);                                     \
+  LOAD_ARGS_5 (a, b, c, d, e)                              \
+  register long __f __asm__ ("r8") = _f;
+#define ASM_ARGS_6 ASM_ARGS_5, "r" (__f)
+#define ASM_CLOBBERS_6
+
+#endif
diff --git a/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym b/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym
new file mode 100644
index 0000000000..a8d4db080f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym
@@ -0,0 +1,26 @@
+#include <inttypes.h>
+#include <signal.h>
+#include <stddef.h>
+#include <sys/ucontext.h>
+
+-- Constants used by the rt_sigprocmask call.
+
+SIG_BLOCK
+SIG_SETMASK
+
+_NSIG8				(_NSIG / 8)
+
+-- Offsets of the fields in the ucontext_t structure.
+#define ucontext(member)	offsetof (ucontext_t, member)
+#define stack(member)		ucontext (uc_stack.member)
+
+UCONTEXT_LINK			ucontext (uc_link)
+UCONTEXT_STACK			ucontext (uc_stack)
+UCONTEXT_MCONTEXT		ucontext (uc_mcontext)
+UCONTEXT_SIGMASK		ucontext (uc_sigmask)
+
+STACK_SP			stack (ss_sp)
+STACK_SIZE			stack (ss_size)
+STACK_FLAGS			stack (ss_flags)
+
+UCONTEXT_SIZE			sizeof (ucontext_t)
diff --git a/sysdeps/unix/sysv/linux/syscall-names.list b/sysdeps/unix/sysv/linux/syscall-names.list
index 21a62a06f4..fa434fd477 100644
--- a/sysdeps/unix/sysv/linux/syscall-names.list
+++ b/sysdeps/unix/sysv/linux/syscall-names.list
@@ -296,6 +296,7 @@ open_by_handle_at
 open_tree
 openat
 openat2
+or1k_atomic
 osf_adjtime
 osf_afs_syscall
 osf_alt_plock
-- 
2.26.2

