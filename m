From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Mon, 3 Jan 2022 15:35:54 -0300
Subject: [OpenRISC] [PATCH v4 00/13] Glibc OpenRISC port
In-Reply-To: <20211229044251.2203653-1-shorne@gmail.com>
References: <20211229044251.2203653-1-shorne@gmail.com>
Message-ID: <4aae3a4a-d975-a6da-3773-8486158b8216@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 29/12/2021 01:42, Stafford Horne via Libc-alpha wrote:
> This is the OpenRISC port for glibc that I have been working on.
> 
> Changes since v3:
>  - Fix suggestion from Paul Eggert
>    - Fix Docs typo pore/port
>  - Fixed suggestions from Adhemerval:
>    - Used ENTRY/END asm macros where missing
>    - Remove block in dl-machine.h suggesting LD_PROFILE
>    - Remove jmp_buf-macros.h  macros and use new default.
>    - Remove tcb-offsets.sym file and Makefile reference.
>    - Remove tcb-offsets.h include in tls.h.
>    - Define lib-audit register layout inline with other architectures.
>    - Fix usage of locally defined register in or1k_get_got.  Also, fixup
>      indentation when using or1k_get_got.
>    - Cleanup abilists after rebasing, adding rseq and removing
>      empty files.
>    - Remove prctl and other unused entries in the linux Makefile.
>    - Fix STACK_ALIGN to 4 bytes, from incorrect copy-n-paste 16 bytes.
>    - Use default pthreadtypes-arch.h.
>    - Mention only soft-float supported in NEWS.
>    - Remove sysdeps/unix/sysv/linux/or1k/bits/timesize.h and use new
>      default.
> 
> Changes since v2:
>  - Fixed suggestions from Joseph Myers:
>    - Fix comment style, and description on top of each file
>    - Make sure macros have parentheses when needed,
>    - Bump required kernel down to 5.4.0 and document
>    - Regenerate arch-syscall.h
>  - Fixed suggestions from Adhemerval:
>    - Remove kernel_stat.h
>    - Just set MMAP2_PAGE_UNIT to 8K
>    - Remove ioctl.c and syscall.c files
>  - Update TCB alignment to 32 bytes
> 
> Changes since v1:
>  - Update api's as suggested by Florian
>  - Remove hard float support
>  - Updates to get all tests passing
>  - Split patch into managable bits similar to recent ARC port
> 
> Documentation:
> 
>   Architecture / ABI docs:
>    https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> 
> Test Results:
> 
>   build-many-glibcs.py:
> 
>    PASS with mainline ang gcc-11.
> 
>   Full test suite:
> 
>   This time I ran the test suite with timeout of 300 and with patch for forcing
>   O_LARGEFILE in open64 [0].  The test has one failure but it seems like flaky
>   test as it passed after the second run.
> 
>     # results in file: /home/shorne/work/gnu-toolchain/log/test--20211226-162029.log
>     # test start:    2021-12-26T16:20:29+09:00
> 
>     # failures
>     FAIL: posix/tst-execveat   /* Running second time passes */
> 
>     # test finish:   2021-12-29T12:54:08+09:00
>     # test duration: 2 days 20 hours 33 minutes and 39 seconds
>     # test for file: tests.sum
>     # test wrapper:  /home/shorne/work/gnu-toolchain/glibc/scripts/cross-test-ssh.sh --timeoutfactor 300 10.0.0.5
> 
>     # summary
> 	  1 FAIL
>        4148 PASS
> 	 31 UNSUPPORTED
> 	 16 XFAIL
> 	  2 XPASS
> 
>     posix/tst-execveat.out:
> 	Timed out: killed the child process
> 	Termination time: 2021-12-29T01:02:42.433964340
> 	Last write to standard output: 2021-12-28T23:22:40.266363000
> 
>     tests.sum: https://gist.github.com/stffrdhrn/88c1fce0c54350258f1f5869068d015a
> 
>  [0] https://sourceware.org/pipermail/libc-alpha/2021-December/134634.html

The port seems to be in good shape I would recommend to send just another versions
with the nits and fixes me an Joseph raised:

  - Use Elf32_Addr and Elf32_Sym on link.h and sotruss-lib.c.
  - Check if the inline assembly dl-machine.h requires the 'memory' clobber.
  - Remove the superflous atomic typedefs on atomic-machine.h.
  - Add the _dl_find_object on libc.abilist.
  - Remove libnsl.abilist.
  - Maybe use the current wording for the NEWS entry.

I think with a v5 with the above fixed we can push it for 2.35.

> 
> Stafford Horne (13):
>   elf: Add reloc for OpenRISC
>   linux/syscalls: Add or1k_atomic syscall for OpenRISC
>   or1k: ABI Implementation
>   or1k: startup and dynamic linking code
>   or1k: Thread Local Storage support
>   or1k: Atomics and Locking primitives
>   or1k: math soft float support
>   or1k: Linux Syscall Interface
>   or1k: Linux ABI
>   or1k: ABI lists
>   or1k: Build Infrastructure
>   build-many-glibcs.py: add OpenRISC support
>   Documentation for OpenRISC port
> 
>  NEWS                                          |    5 +
>  README                                        |    1 +
>  elf/elf.h                                     |   37 +
>  scripts/build-many-glibcs.py                  |    5 +
>  sysdeps/or1k/Implies                          |    3 +
>  sysdeps/or1k/Makefile                         |    7 +
>  sysdeps/or1k/__longjmp.S                      |   50 +
>  sysdeps/or1k/atomic-machine.h                 |   79 +
>  sysdeps/or1k/bits/endianness.h                |   11 +
>  sysdeps/or1k/bits/fenv.h                      |   69 +
>  sysdeps/or1k/bits/link.h                      |   54 +
>  sysdeps/or1k/bits/setjmp.h                    |   32 +
>  sysdeps/or1k/bsd-_setjmp.S                    |    1 +
>  sysdeps/or1k/bsd-setjmp.S                     |    1 +
>  sysdeps/or1k/dl-machine.h                     |  300 +++
>  sysdeps/or1k/dl-start.S                       |   98 +
>  sysdeps/or1k/dl-tls.h                         |   27 +
>  sysdeps/or1k/dl-trampoline.S                  |   73 +
>  sysdeps/or1k/jmpbuf-offsets.h                 |   23 +
>  sysdeps/or1k/jmpbuf-unwind.h                  |   36 +
>  sysdeps/or1k/ldsodefs.h                       |   40 +
>  sysdeps/or1k/libc-tls.c                       |   34 +
>  sysdeps/or1k/libm-test-ulps                   | 1112 +++++++++
>  sysdeps/or1k/libm-test-ulps-name              |    1 +
>  sysdeps/or1k/machine-gmon.h                   |   35 +
>  sysdeps/or1k/memusage.h                       |   21 +
>  sysdeps/or1k/nofpu/Implies                    |    1 +
>  sysdeps/or1k/nofpu/math-tests-exceptions.h    |   29 +
>  sysdeps/or1k/nofpu/math-tests-rounding.h      |   28 +
>  sysdeps/or1k/nptl/pthreaddef.h                |   36 +
>  sysdeps/or1k/nptl/tls.h                       |  184 ++
>  sysdeps/or1k/preconfigure                     |   34 +
>  sysdeps/or1k/setjmp.S                         |   56 +
>  sysdeps/or1k/sfp-machine.h                    |   93 +
>  sysdeps/or1k/sotruss-lib.c                    |   51 +
>  sysdeps/or1k/stackinfo.h                      |   34 +
>  sysdeps/or1k/start.S                          |   99 +
>  sysdeps/or1k/sysdep.h                         |   83 +
>  sysdeps/or1k/tininess.h                       |    1 +
>  sysdeps/or1k/tst-audit.h                      |   24 +
>  sysdeps/unix/sysv/linux/or1k/Implies          |    3 +
>  sysdeps/unix/sysv/linux/or1k/Makefile         |    8 +
>  sysdeps/unix/sysv/linux/or1k/arch-syscall.h   |  325 +++
>  sysdeps/unix/sysv/linux/or1k/bits/procfs.h    |   38 +
>  sysdeps/unix/sysv/linux/or1k/c++-types.data   |   67 +
>  sysdeps/unix/sysv/linux/or1k/clone.c          |   61 +
>  sysdeps/unix/sysv/linux/or1k/configure        |    4 +
>  sysdeps/unix/sysv/linux/or1k/configure.ac     |    4 +
>  sysdeps/unix/sysv/linux/or1k/getcontext.S     |   72 +
>  sysdeps/unix/sysv/linux/or1k/ld.abilist       |    8 +
>  .../sysv/linux/or1k/libBrokenLocale.abilist   |    1 +
>  sysdeps/unix/sysv/linux/or1k/libc.abilist     | 2122 +++++++++++++++++
>  .../sysv/linux/or1k/libc_malloc_debug.abilist |   26 +
>  sysdeps/unix/sysv/linux/or1k/libcrypt.abilist |    2 +
>  sysdeps/unix/sysv/linux/or1k/libm.abilist     |  759 ++++++
>  sysdeps/unix/sysv/linux/or1k/libnsl.abilist   |  121 +
>  .../unix/sysv/linux/or1k/libresolv.abilist    |   55 +
>  .../unix/sysv/linux/or1k/libthread_db.abilist |   40 +
>  sysdeps/unix/sysv/linux/or1k/localplt.data    |   14 +
>  sysdeps/unix/sysv/linux/or1k/makecontext.c    |   77 +
>  sysdeps/unix/sysv/linux/or1k/mmap_internal.h  |   28 +
>  sysdeps/unix/sysv/linux/or1k/or1k_clone.S     |   89 +
>  sysdeps/unix/sysv/linux/or1k/setcontext.S     |  108 +
>  sysdeps/unix/sysv/linux/or1k/shlib-versions   |    2 +
>  sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h |   28 +
>  sysdeps/unix/sysv/linux/or1k/swapcontext.S    |  116 +
>  sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |   53 +
>  sysdeps/unix/sysv/linux/or1k/sys/user.h       |    1 +
>  sysdeps/unix/sysv/linux/or1k/sysdep.c         |   34 +
>  sysdeps/unix/sysv/linux/or1k/sysdep.h         |  201 ++
>  sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |   26 +
>  sysdeps/unix/sysv/linux/syscall-names.list    |    1 +
>  72 files changed, 7402 insertions(+)
>  create mode 100644 sysdeps/or1k/Implies
>  create mode 100644 sysdeps/or1k/Makefile
>  create mode 100644 sysdeps/or1k/__longjmp.S
>  create mode 100644 sysdeps/or1k/atomic-machine.h
>  create mode 100644 sysdeps/or1k/bits/endianness.h
>  create mode 100644 sysdeps/or1k/bits/fenv.h
>  create mode 100644 sysdeps/or1k/bits/link.h
>  create mode 100644 sysdeps/or1k/bits/setjmp.h
>  create mode 100644 sysdeps/or1k/bsd-_setjmp.S
>  create mode 100644 sysdeps/or1k/bsd-setjmp.S
>  create mode 100644 sysdeps/or1k/dl-machine.h
>  create mode 100644 sysdeps/or1k/dl-start.S
>  create mode 100644 sysdeps/or1k/dl-tls.h
>  create mode 100644 sysdeps/or1k/dl-trampoline.S
>  create mode 100644 sysdeps/or1k/jmpbuf-offsets.h
>  create mode 100644 sysdeps/or1k/jmpbuf-unwind.h
>  create mode 100644 sysdeps/or1k/ldsodefs.h
>  create mode 100644 sysdeps/or1k/libc-tls.c
>  create mode 100644 sysdeps/or1k/libm-test-ulps
>  create mode 100644 sysdeps/or1k/libm-test-ulps-name
>  create mode 100644 sysdeps/or1k/machine-gmon.h
>  create mode 100644 sysdeps/or1k/memusage.h
>  create mode 100644 sysdeps/or1k/nofpu/Implies
>  create mode 100644 sysdeps/or1k/nofpu/math-tests-exceptions.h
>  create mode 100644 sysdeps/or1k/nofpu/math-tests-rounding.h
>  create mode 100644 sysdeps/or1k/nptl/pthreaddef.h
>  create mode 100644 sysdeps/or1k/nptl/tls.h
>  create mode 100644 sysdeps/or1k/preconfigure
>  create mode 100644 sysdeps/or1k/setjmp.S
>  create mode 100644 sysdeps/or1k/sfp-machine.h
>  create mode 100644 sysdeps/or1k/sotruss-lib.c
>  create mode 100644 sysdeps/or1k/stackinfo.h
>  create mode 100644 sysdeps/or1k/start.S
>  create mode 100644 sysdeps/or1k/sysdep.h
>  create mode 100644 sysdeps/or1k/tininess.h
>  create mode 100644 sysdeps/or1k/tst-audit.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/Implies
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/Makefile
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/arch-syscall.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/procfs.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/c++-types.data
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/clone.c
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/configure
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/configure.ac
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext.S
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/ld.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libc.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libc_malloc_debug.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libcrypt.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libm.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libnsl.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libresolv.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libthread_db.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/localplt.data
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/makecontext.c
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/mmap_internal.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/or1k_clone.S
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/setcontext.S
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/shlib-versions
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/swapcontext.S
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/user.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/sysdep.c
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/sysdep.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym
> 
