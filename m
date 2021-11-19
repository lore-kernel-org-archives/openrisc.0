From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Fri, 19 Nov 2021 09:27:40 -0300
Subject: [OpenRISC] [PATCH v2 08/13] or1k: Linux Syscall Interface
In-Reply-To: <20211113031639.2402161-9-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
 <20211113031639.2402161-9-shorne@gmail.com>
Message-ID: <2efe0402-2e0a-883b-f5f7-38c6b45ebbc3@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 13/11/2021 00:16, Stafford Horne via Libc-alpha wrote:
> +#define __TIMESIZE	64

Maybe we should refactor to make this the default for newer ports and make
old ports to redefine it.

> diff --git a/sysdeps/unix/sysv/linux/or1k/ioctl.c b/sysdeps/unix/sysv/linux/or1k/ioctl.c
> new file mode 100644
> index 0000000000..c8b6c4d3f4
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/ioctl.c
> @@ -0,0 +1,40 @@
> +/* Copyright (C) 2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library; if not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#include <stdarg.h>
> +#include <sys/ioctl.h>
> +#include <sysdep.h>
> +
> +/* The or1k ABI uses stack for varargs, syscall uses registers.
> +   This function moves arguments from varargs to registers.  */
> +int
> +__ioctl (int fd, unsigned long int request, ...)
> +{
> +  void *arg;
> +  va_list ap;
> +  int result;
> +
> +  va_start (ap, request);
> +  arg = va_arg (ap, void *);
> +
> +  result = INLINE_SYSCALL (ioctl, 3, fd, request, arg);

Use INLINE_SYSCALL_CALL.

> +  va_end (ap);
> +
> +  return result;
> +}
> +libc_hidden_def (__ioctl)
> +weak_alias (__ioctl, ioctl)

I think it would be better to make it the default implementation.  
Unfortunately it might result in worse code, but I think the assumption
on auto-generation syscall that varargs are always passed in register
also fragile.

> diff --git a/sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h b/sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
> new file mode 100644
> index 0000000000..3c5c1826ab
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/jmp_buf-macros.h
> @@ -0,0 +1,41 @@
> +/* jump buffer constants, OpenRISC version.
> +   Copyright (C) 2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +/* Produced by this program:
> +
> +   #include <stdio.h>
> +   #include <unistd.h>
> +   #include <setjmp.h>
> +   #include <stddef.h>
> +
> +   int main (int argc, char **argv)
> +   {
> +       printf ("#define JMP_BUF_SIZE %d\n", sizeof (jmp_buf));
> +       printf ("#define JMP_BUF_ALIGN %d\n", __alignof__ (jmp_buf));
> +       printf ("#define SIGJMP_BUF_SIZE %d\n", sizeof (sigjmp_buf));
> +       printf ("#define SIGJMP_BUF_ALIGN %d\n", __alignof__ (sigjmp_buf));
> +       printf ("#define MASK_WAS_SAVED_OFFSET %d\n", offsetof (struct __jmp_buf_tag, __mask_was_saved));
> +       printf ("#define SAVED_MASK_OFFSET %d\n", offsetof (struct __jmp_buf_tag, __saved_mask));
> +   } */
> +
> +#define JMP_BUF_SIZE 184
> +#define JMP_BUF_ALIGN 4
> +#define SIGJMP_BUF_SIZE 184
> +#define SIGJMP_BUF_ALIGN 4
> +#define MASK_WAS_SAVED_OFFSET 52
> +#define SAVED_MASK_OFFSET 56

This is replicated for all architectures and it can be replaced with a
gen-as-const-headers file.  I will fix it upstream, so there won't be
the need to add this new header.

> diff --git a/sysdeps/unix/sysv/linux/or1k/kernel_stat.h b/sysdeps/unix/sysv/linux/or1k/kernel_stat.h
> new file mode 100644
> index 0000000000..aa458a65f1
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/kernel_stat.h
> @@ -0,0 +1,24 @@
> +/* Copyright (C) 2021-2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#include <bits/wordsize.h>
> +
> +#define STAT_IS_KERNEL_STAT 1
> +#define STAT64_IS_KERNEL_STAT64 1
> +
> +#define XSTAT_IS_XSTAT64 1
> +#define STATFS_IS_STATFS64 0

So the generic Linux interface only misses the STAT64_IS_KERNEL_STAT64, right?
I think we can add it and thus or1k just need to ajust __STATFS_MATCHES_STATFS64.

> diff --git a/sysdeps/unix/sysv/linux/or1k/mmap_internal.h b/sysdeps/unix/sysv/linux/or1k/mmap_internal.h
> new file mode 100644
> index 0000000000..aad425d11e
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/mmap_internal.h
> @@ -0,0 +1,30 @@
> +/* Common mmap definition for Linux implementation.  OpenRISC version.
> +   Copyright (C) 2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library; if not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#ifndef MMAP_OR1K_INTERNAL_LINUX_H
> +#define MMAP_OR1K_INTERNAL_LINUX_H
> +
> +/* OpenRISC Linux sets the page shift to 13 and mmap2 expects
> +   offsets to be provided in 8K pages.  Set MMAP2_PAGE_UNIT to -1
> +   to allow mmap_internal.h to determine the page size dynamically with
> +   getpagesize.  */
> +#define MMAP2_PAGE_UNIT -1
> +
> +#include_next <mmap_internal.h>
> +
> +#endif

MMAP2_PAGE_UNIT set to -1 means the architecture supports multiple
page size, but from the comment my understanding it only support 8k.
If it where the case it would be simpler to just set MMAP2_PAGE_UNIT
to 8192ULL.

As a side note, maybe arc should do it as well.


> diff --git a/sysdeps/unix/sysv/linux/or1k/or1k_clone.S b/sysdeps/unix/sysv/linux/or1k/or1k_clone.S
> new file mode 100644
> index 0000000000..337eb17d06
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/or1k_clone.S
> @@ -0,0 +1,89 @@
> +/* clone helper __or1k_clone for OpenRISC.
> +   Copyright (C) 2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library; if not, write to the Free
> +   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> +   02111-1307 USA.  */
> +
> +#include <sysdep.h>
> +#include <tls.h>
> +#define __ASSEMBLY__
> +#include <linux/sched.h>
> +
> +	.text
> +ENTRY(__or1k_clone)
> +
> +	/* To handle GCC varargs we need to use our __clone wrapper to pop
> +	   everything from the stack for us.
> +	   Now everything is placed in the registers which saves us a lot
> +	   of trouble.
> +
> +	   The userland implementation is:
> +
> +	     int clone (int (*fn)(void *), void *child_stack,
> +			int flags, void *arg, pid_t *ptid,
> +			struct user_desc *tls, pid_t *ctid);
> +	   The kernel entry is:
> +
> +	     int clone (long flags, void *child_stack, int *parent_tid,
> +			int *child_tid, struct void *tls)
> +
> +	     NB: tls isn't really an argument, it is read from r7 directly.  */
> +
> +	/* First, align the stack to 4 bytes.  */
> +	l.xori	r11, r0, -4
> +	l.and	r4, r4, r11
> +
> +	/* Put 'fn', 'arg' and 'flags' on the child stack.  */
> +	l.addi	r4, r4, -12
> +	l.sw	8(r4), r3
> +	l.sw	4(r4), r6
> +	l.sw	0(r4), r5
> +
> +	l.ori	r3, r5, 0
> +	/* The child_stack is already in r4.  */
> +	l.ori	r5, r7, 0
> +	l.lwz	r6, 0(r1)
> +	l.ori	r7, r8, 0
> +
> +	DO_CALL (clone)
> +
> +	l.sfgeui r11, 0xf001
> +	l.bf	L(error)
> +	 l.nop
> +
> +	/* If we are not the child, return the pid.  */
> +	l.sfeqi	r11, 0
> +	l.bf	L(thread_start)
> +	 l.nop
> +
> +	l.jr	r9
> +	 l.nop
> +
> +L(thread_start):
> +	/* Load function from stack.  */
> +	l.lwz	r11, 8(r1)
> +	l.jalr	r11
> +	 l.lwz	r3, 4(r1)
> +
> +	/* Exit the child thread.  */
> +	l.ori	r3, r11, 0
> +	DO_CALL (exit)
> +
> +L(error):
> +	l.j	SYSCALL_ERROR_NAME
> +	 l.ori	r3, r11, 0
> +
> +PSEUDO_END (__or1k_clone)
> diff --git a/sysdeps/unix/sysv/linux/or1k/syscall.c b/sysdeps/unix/sysv/linux/or1k/syscall.c
> new file mode 100644
> index 0000000000..a1dbafa237
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/syscall.c
> @@ -0,0 +1,45 @@
> +/* System call interface.  OpenRISC version.
> +   Copyright (C) 2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#include <sysdep.h>
> +#include <stdarg.h>
> +
> +long int
> +syscall (long int syscall_number, ...)
> +{
> +  unsigned long int arg1, arg2, arg3, arg4, arg5, arg6;
> +  va_list arg;
> +  long int ret;
> +
> +  va_start (arg, syscall_number);
> +  arg1 = va_arg (arg, unsigned long int);
> +  arg2 = va_arg (arg, unsigned long int);
> +  arg3 = va_arg (arg, unsigned long int);
> +  arg4 = va_arg (arg, unsigned long int);
> +  arg5 = va_arg (arg, unsigned long int);
> +  arg6 = va_arg (arg, unsigned long int);
> +  va_end (arg);
> +
> +  ret = INTERNAL_SYSCALL_NCS (syscall_number, 6, arg1, arg2, arg3, arg4,
> +			      arg5, arg6);
> +
> +  if (INTERNAL_SYSCALL_ERROR_P (ret))
> +    return __syscall_error (ret);
> +
> +  return ret;
> +}

As for ioctl.c, I also think this should the set as the default implementation.
It would allows us to remove the hppa version as well.

(maybe also add a INTERNAL_SYSCALL_CALL_NCS, to get rid of the requirement to
pass the number of arguments).

> diff --git a/sysdeps/unix/sysv/linux/or1k/sysdep.c b/sysdeps/unix/sysv/linux/or1k/sysdep.c
> new file mode 100644
> index 0000000000..8f193fd4e8
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/sysdep.c
> @@ -0,0 +1,33 @@
> +/* Copyright (C) 2021 Free Software Foundation, Inc.
> +
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#include <sysdep.h>
> +#include <errno.h>
> +
> +long int __syscall_error (long int err);
> +hidden_proto (__syscall_error)
> +
> +/* This routine is jumped to by all the syscall handlers, to stash
> +   an error number into errno.  */
> +long int
> +__syscall_error (long int err)
> +{
> +  __set_errno (- err);
> +  return -1;
> +}
> +hidden_def (__syscall_error)

This is another thing I have in my backlog to cleanup: I think we also should
move it to default implementation.  The architectures that uses non standard
call procedure already implement it with assembly routines.

> diff --git a/sysdeps/unix/sysv/linux/or1k/sysdep.h b/sysdeps/unix/sysv/linux/or1k/sysdep.h
> new file mode 100644
> index 0000000000..41a9af5ecf
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/sysdep.h
> @@ -0,0 +1,195 @@
> +/* Copyright (C) 2021 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#include <sysdeps/or1k/sysdep.h>
> +#include <sysdeps/unix/sysv/linux/generic/sysdep.h>
> +#include <tls.h>
> +
> +/* "workarounds" for generic code needing to handle 64-bit time_t.  */
> +
> +#undef __NR_clock_getres
> +#undef __NR_futex
> +#undef __NR_ppoll
> +#undef __NR_pselect6
> +#undef __NR_recvmmsg
> +#undef __NR_rt_sigtimedwait
> +#undef __NR_semtimedop
> +#undef __NR_utimensat

I think we might need to update update-syscall-lists.py to *not* emit
no emit 32-bit time syscalls if the architecture only exports 64-bit
interfaces.

> +
> +/* Fix sysdeps/unix/sysv/linux/clock_getcpuclockid.c.  */
> +#define __NR_clock_getres	__NR_clock_getres_time64
> +/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> +#define __NR_futex		__NR_futex_time64
> +/* Fix sysdeps/unix/sysv/linux/pause.c.  */
> +#define __NR_ppoll		__NR_ppoll_time64
> +/* Fix sysdeps/unix/sysv/linux/select.c.  */
> +#define __NR_pselect6		__NR_pselect6_time64
> +/* Fix sysdeps/unix/sysv/linux/recvmmsg.c.  */
> +#define __NR_recvmmsg		__NR_recvmmsg_time64
> +/* Fix sysdeps/unix/sysv/linux/sigtimedwait.c.  */
> +#define __NR_rt_sigtimedwait	__NR_rt_sigtimedwait_time64
> +/* Fix sysdeps/unix/sysv/linux/semtimedop.c.  */
> +#define __NR_semtimedop		__NR_semtimedop_time64
> +/* Hack sysdeps/unix/sysv/linux/generic/utimes.c.  */
> +#define __NR_utimensat		__NR_utimensat_time64
> +
> +#undef SYS_ify
> +#define SYS_ify(syscall_name)   (__NR_##syscall_name)
> +
> +/* Linux uses a negative return value to indicate syscall errors,
> +   unlike most Unices, which use the condition codes' carry flag.
> +
> +   Since version 2.1 the return value of a system call might be
> +   negative even if the call succeeded.  E.g., the `lseek' system call
> +   might return a large offset.  Therefore we must not anymore test
> +   for < 0, but test for a real error by making sure the value in R0
> +   is a real error number.  Linus said he will make sure the no syscall
> +   returns a value in -1 .. -4095 as a valid result so we can safely
> +   test with -4095.  */
> +
> +#ifdef __ASSEMBLER__
> +
> +/* Macros used in syscall-template.S */
> +#define ret          l.jr r9; l.nop
> +#define ret_NOERRNO  l.jr r9; l.nop
> +
> +#undef	DO_CALL
> +#define DO_CALL(syscall_name) \
> +  l.addi r11, r0, SYS_ify (syscall_name); \
> +  l.sys 1; \
> +   l.nop
> +
> +#undef	PSEUDO
> +#define PSEUDO(name, syscall_name, args) \
> +  ENTRY (name); \
> +  DO_CALL(syscall_name); \
> +  /* if -4096 < ret < 0 holds, it's an error */ \
> +  l.sfgeui r11, 0xf001; \
> +  l.bf L(pseudo_end); \
> +   l.nop
> +
> +#undef	PSEUDO_NOERRNO
> +#define PSEUDO_NOERRNO(name, syscall_name, args)  \
> +  ENTRY (name);           \
> +  DO_CALL(syscall_name)
> +
> +#undef	PSEUDO_END
> +#define PSEUDO_END(name) \
> +L(pseudo_end): \
> +  l.j SYSCALL_ERROR_NAME; \
> +  l.ori r3,r11,0; \
> +  END (name)
> +
> +#undef	PSEUDO_END_NOERRNO
> +#define PSEUDO_END_NOERRNO(name) \
> +  END (name)
> +
> +#ifndef PIC
> +/* For static code, on error jump to __syscall_error directly. */
> +# define SYSCALL_ERROR_NAME __syscall_error
> +#elif !IS_IN (libc)
> +/* Use the internal name for libc/libpthread shared objects. */
> +# define SYSCALL_ERROR_NAME __GI___syscall_error
> +#else
> +/* Otherwise, on error do a full PLT jump. */
> +# define SYSCALL_ERROR_NAME plt(__syscall_error)
> +#endif
> +
> +#else /* not __ASSEMBLER__ */
> +
> +#include <errno.h>
> +
> +extern long int __syscall_error (long int neg_errno);
> +
> +/* Pointer mangling is not yet supported for or1k.  */
> +#define PTR_MANGLE(var) (void) (var)
> +#define PTR_DEMANGLE(var) (void) (var)
> +
> +#undef INTERNAL_SYSCALL
> +#define INTERNAL_SYSCALL(name, nr, args...) \
> +	INTERNAL_SYSCALL_NCS (SYS_ify (name), nr, args)
> +
> +/* The _NCS variant allows non-constant syscall numbers.  */
> +#undef INTERNAL_SYSCALL_NCS
> +#define INTERNAL_SYSCALL_NCS(number, nr, args...) \
> +        ({ unsigned long int __sys_result;                                     \
> +          {                                                                    \
> +            long int _sc_ret = (long int) number;                              \
> +            LOAD_ARGS_##nr (args)                                              \
> +            register long int __sc_ret __asm__ ("r11") = _sc_ret;              \
> +            __asm__ __volatile__ ("l.sys 1\n\t"                                \
> +				  " l.nop\n\t"                                 \
> +                                  : "+r" (__sc_ret)                            \
> +                                  : ASM_ARGS_##nr                              \
> +                                  : ASM_CLOBBERS_##nr                          \
> +                                    "r12", "r13", "r15", "r17", "r19",         \
> +                                    "r21", "r23", "r25", "r27", "r29",         \
> +                                    "r31", "memory");                          \
> +            __sys_result = __sc_ret;                                           \
> +          }                                                                    \
> +          (long int) __sys_result; })
> +
> +/* From here on we have nested macros that generate code for
> + * storing arguments to the syscall */
> +
> +#define LOAD_ARGS_0()
> +
> +#define ASM_ARGS_0
> +#define ASM_CLOBBERS_0  "r3", ASM_CLOBBERS_1
> +
> +#define LOAD_ARGS_1(a) \
> +  long int _a = (long int)(a);                             \
> +  register long int __a __asm__ ("r3") = _a;
> +#define ASM_ARGS_1 "r" (__a)
> +#define ASM_CLOBBERS_1  "r4", ASM_CLOBBERS_2
> +
> +#define LOAD_ARGS_2(a, b) \
> +  long int _b = (long int)(b);                             \
> +  LOAD_ARGS_1 (a)                                          \
> +  register long int __b __asm__ ("r4") = _b;
> +#define ASM_ARGS_2 ASM_ARGS_1, "r" (__b)
> +#define ASM_CLOBBERS_2  "r5", ASM_CLOBBERS_3
> +
> +#define LOAD_ARGS_3(a, b, c) \
> +  long int _c = (long int)(c);                             \
> +  LOAD_ARGS_2 (a, b)                                       \
> +  register long int __c __asm__ ("r5") = _c;
> +#define ASM_ARGS_3 ASM_ARGS_2, "r" (__c)
> +#define ASM_CLOBBERS_3  "r6", ASM_CLOBBERS_4
> +
> +#define LOAD_ARGS_4(a, b, c, d) \
> +    LOAD_ARGS_3 (a, b, c)                                  \
> +  long int _d = (long int)(d);                             \
> +  register long int __d __asm__ ("r6") = _d;
> +#define ASM_ARGS_4 ASM_ARGS_3, "r" (__d)
> +#define ASM_CLOBBERS_4  "r7", ASM_CLOBBERS_5
> +
> +#define LOAD_ARGS_5(a, b, c, d, e) \
> +  long int _e = (long int)(e);                             \
> +  LOAD_ARGS_4 (a, b, c, d)                                 \
> +  register long int __e __asm__ ("r7") = _e;
> +#define ASM_ARGS_5 ASM_ARGS_4, "r" (__e)
> +#define ASM_CLOBBERS_5  "r8", ASM_CLOBBERS_6
> +
> +#define LOAD_ARGS_6(a, b, c, d, e, f) \
> +  long int _f = (long int)(f);                             \
> +  LOAD_ARGS_5 (a, b, c, d, e)                              \
> +  register long int __f __asm__ ("r8") = _f;
> +#define ASM_ARGS_6 ASM_ARGS_5, "r" (__f)
> +#define ASM_CLOBBERS_6
> +
> +#endif
> 
