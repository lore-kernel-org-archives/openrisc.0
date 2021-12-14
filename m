From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Tue, 14 Dec 2021 17:25:09 -0300
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <20211210233456.4146479-1-shorne@gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
Message-ID: <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> This is the OpenRISC port for glibc that I have been working on.
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
>    The full suite is running using the gcc-11 branch of GCC, mainline shows
>    issues with math soft-fp.
> 
>    Note, there are a few more failures compared to before, this is due to me
>    running with a timeout of 30 vs usual 300.  It allows the tests to complete
>    faster, but I get a few more timeouts.  There were 15 timeouts which I
>    confirm do work if I increase the timeoutfactor. The 2 real failures marked
>    with * below.
> 
>     # test start:    2021-12-08T19:59:00+09:00
> 
>     # failures
>     FAIL:*elf/tst-bz15311

This seems to be a real issue, the output shows the new sorting algorithm seems 
not be enabled (the output shows the destructor order for dynamic_sort=1).  We 
need to figure out what is happening here.

>     FAIL: locale/tst-localedef-path-norm
>     FAIL: malloc/tst-dynarray-fail
>     FAIL: malloc/tst-dynarray-fail-mem
>     FAIL: nptl/tst-mutex10
>     FAIL: nss/tst-nss-files-hosts-getent
>     FAIL: nss/tst-nss-files-hosts-multi
>     FAIL: posix/tst-regcomp-truncated
>     FAIL: stdio-common/tst-vfprintf-width-prec
>     FAIL: stdio-common/tst-vfprintf-width-prec-alloc
>     FAIL: stdio-common/tst-vfprintf-width-prec-mem
>     FAIL: string/test-memcpy
>     FAIL: string/test-memcpy-large
>     FAIL: string/test-mempcpy
>     FAIL: string/tst-cmp
>     FAIL: support/tst-support_blob_repeat
>     FAIL:*timezone/tst-tzset

It seems the testing file system does not support sparse files or at least
has some limits of the file size and support_descriptor_supports_holes is
no deteting it.

I think we should use a large write_offset and block_headroom, maybe
something larger than 32-bit offset to actually check it.  Could you
check if increasing both values does make the test unsupported.

> 
>     # test finish:   2021-12-10T22:04:56+09:00
>     # test duration: 2 days 2 hours 5 minutes and 56 seconds
>     # test for file: tests.sum
>     # test wrapper:  /home/shorne/work/gnu-toolchain/glibc/scripts/cross-test-ssh.sh --timeoutfactor 30 10.0.0.5
> 
>     # summary
> 	 17 FAIL
>        4063 PASS
> 	 28 UNSUPPORTED
> 	 18 XFAIL
> 
>     tst-bz15311.out: https://gist.github.com/5a5dacaeef1eac1f2f5d89701d14c0ad
>     tst-tzset.out: https://gist.github.com/b3a548d82cfc9367905e115821a52754
>     tests.sum:     https://gist.github.com/f85a81012c8329b9a95370a30c7b27fe

Since 8d1927d8dc5aad0f01c929123086be3a5b799d18 it will need an additional
fix to correctly build glibc:

diff --git a/sysdeps/or1k/nptl/tls.h b/sysdeps/or1k/nptl/tls.h
index dc11610920..3fc63eb4e8 100644
--- a/sysdeps/or1k/nptl/tls.h
+++ b/sysdeps/or1k/nptl/tls.h
@@ -150,6 +150,8 @@ register tcbhead_t *__thread_self __asm__("r10");
 # define DB_THREAD_SELF \
   REGISTER (32, 32, 10 * 4, - TLS_INIT_TCB_SIZE - TLS_PRE_TCB_SIZE)
 
+# include <tcb-access.h>
+
 /* Access to data in the thread descriptor is easy.  */
 
 #define THREAD_GETMEM(descr, member) \

With the above fix I can bootstrap a compiler with build-many-glibcs.py.

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
>  NEWS                                          |    4 +
>  README                                        |    1 +
>  elf/elf.h                                     |   37 +
>  scripts/build-many-glibcs.py                  |    5 +
>  sysdeps/or1k/Implies                          |    3 +
>  sysdeps/or1k/Makefile                         |    7 +
>  sysdeps/or1k/__longjmp.S                      |   55 +
>  sysdeps/or1k/atomic-machine.h                 |   79 +
>  sysdeps/or1k/bits/endianness.h                |   11 +
>  sysdeps/or1k/bits/fenv.h                      |   69 +
>  sysdeps/or1k/bits/link.h                      |   51 +
>  sysdeps/or1k/bits/setjmp.h                    |   32 +
>  sysdeps/or1k/bsd-_setjmp.S                    |    1 +
>  sysdeps/or1k/bsd-setjmp.S                     |    1 +
>  sysdeps/or1k/dl-machine.h                     |  323 +++
>  sysdeps/or1k/dl-start.S                       |   98 +
>  sysdeps/or1k/dl-tls.h                         |   27 +
>  sysdeps/or1k/dl-trampoline.S                  |   79 +
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
>  sysdeps/or1k/nptl/Makefile                    |   21 +
>  sysdeps/or1k/nptl/bits/pthreadtypes-arch.h    |   48 +
>  sysdeps/or1k/nptl/pthreaddef.h                |   36 +
>  sysdeps/or1k/nptl/tcb-offsets.sym             |    6 +
>  sysdeps/or1k/nptl/tls.h                       |  189 ++
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
>  sysdeps/unix/sysv/linux/or1k/Makefile         |   12 +
>  sysdeps/unix/sysv/linux/or1k/arch-syscall.h   |  325 +++
>  sysdeps/unix/sysv/linux/or1k/bits/procfs.h    |   38 +
>  sysdeps/unix/sysv/linux/or1k/bits/timesize.h  |   19 +
>  sysdeps/unix/sysv/linux/or1k/c++-types.data   |   67 +
>  sysdeps/unix/sysv/linux/or1k/clone.c          |   61 +
>  sysdeps/unix/sysv/linux/or1k/configure        |    4 +
>  sysdeps/unix/sysv/linux/or1k/configure.ac     |    4 +
>  sysdeps/unix/sysv/linux/or1k/getcontext.S     |   72 +
>  sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h |   41 +
>  sysdeps/unix/sysv/linux/or1k/ld.abilist       |    5 +
>  .../sysv/linux/or1k/libBrokenLocale.abilist   |    1 +
>  sysdeps/unix/sysv/linux/or1k/libanl.abilist   |    1 +
>  sysdeps/unix/sysv/linux/or1k/libc.abilist     | 2122 +++++++++++++++++
>  .../sysv/linux/or1k/libc_malloc_debug.abilist |   26 +
>  sysdeps/unix/sysv/linux/or1k/libcrypt.abilist |    2 +
>  sysdeps/unix/sysv/linux/or1k/libdl.abilist    |    0
>  sysdeps/unix/sysv/linux/or1k/libm.abilist     |  759 ++++++
>  sysdeps/unix/sysv/linux/or1k/libnsl.abilist   |  121 +
>  .../unix/sysv/linux/or1k/libpthread.abilist   |    0
>  .../unix/sysv/linux/or1k/libresolv.abilist    |   55 +
>  sysdeps/unix/sysv/linux/or1k/librt.abilist    |    0
>  .../unix/sysv/linux/or1k/libthread_db.abilist |   40 +
>  sysdeps/unix/sysv/linux/or1k/libutil.abilist  |    1 +
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
>  82 files changed, 7575 insertions(+)
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
>  create mode 100644 sysdeps/or1k/nptl/Makefile
>  create mode 100644 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
>  create mode 100644 sysdeps/or1k/nptl/pthreaddef.h
>  create mode 100644 sysdeps/or1k/nptl/tcb-offsets.sym
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
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/timesize.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/c++-types.data
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/clone.c
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/configure
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/configure.ac
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext.S
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/ld.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libanl.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libc.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libc_malloc_debug.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libcrypt.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libdl.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libm.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libnsl.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libpthread.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libresolv.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/librt.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libthread_db.abilist
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/libutil.abilist
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
