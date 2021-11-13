From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 12:16:35 +0900
Subject: [OpenRISC] [PATCH v2 09/13] or1k: Linux ABI
In-Reply-To: <20211113031639.2402161-1-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
Message-ID: <20211113031639.2402161-10-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

---
 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h    |  48 ++++++++
 sysdeps/or1k/nptl/pthreaddef.h                |  35 ++++++
 sysdeps/unix/sysv/linux/or1k/bits/procfs.h    |  38 ++++++
 sysdeps/unix/sysv/linux/or1k/getcontext.S     |  72 +++++++++++
 sysdeps/unix/sysv/linux/or1k/makecontext.c    |  77 ++++++++++++
 sysdeps/unix/sysv/linux/or1k/setcontext.S     | 108 ++++++++++++++++
 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h |  28 +++++
 sysdeps/unix/sysv/linux/or1k/swapcontext.S    | 116 ++++++++++++++++++
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |  53 ++++++++
 sysdeps/unix/sysv/linux/or1k/sys/user.h       |   1 +
 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |  26 ++++
 11 files changed, 602 insertions(+)
 create mode 100644 sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
 create mode 100644 sysdeps/or1k/nptl/pthreaddef.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/bits/procfs.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/makecontext.c
 create mode 100644 sysdeps/unix/sysv/linux/or1k/setcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/swapcontext.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/sys/user.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym

diff --git a/sysdeps/or1k/nptl/bits/pthreadtypes-arch.h b/sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
new file mode 100644
index 0000000000..56a62a7161
--- /dev/null
+++ b/sysdeps/or1k/nptl/bits/pthreadtypes-arch.h
@@ -0,0 +1,48 @@
+/* Machine-specific pthread type layouts.  OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
diff --git a/sysdeps/or1k/nptl/pthreaddef.h b/sysdeps/or1k/nptl/pthreaddef.h
new file mode 100644
index 0000000000..eff4025a89
--- /dev/null
+++ b/sysdeps/or1k/nptl/pthreaddef.h
@@ -0,0 +1,35 @@
+/* Copyright (C) 2021 Free Software Foundation, Inc.
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
+/* Minimum guard size.  */
+#define ARCH_MIN_GUARD_SIZE 0
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
diff --git a/sysdeps/unix/sysv/linux/or1k/bits/procfs.h b/sysdeps/unix/sysv/linux/or1k/bits/procfs.h
new file mode 100644
index 0000000000..b50c92efb1
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/bits/procfs.h
@@ -0,0 +1,38 @@
+/* Types for registers for sys/procfs.h.  OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
+#ifndef _SYS_PROCFS_H
+# error "Never include <bits/procfs.h> directly; use <sys/procfs.h> instead."
+#endif
+
+#include <sys/ucontext.h>
+
+#define ELF_NGREG __NGREG
+
+/* Type for a general-purpose register.  */
+typedef unsigned long int elf_greg_t;
+
+/* And the array of general-purpose registers.  We could have used `struct
+   user_regs' directly, but tradition says that the register set is an array,
+   which does have some peculiar semantics, so leave it that way.
+   GDB uses this for prtrace GETREGSET, on OpenRISC the regset contains 32
+   gprs the PC and the SR, 34 longs.  */
+typedef elf_greg_t elf_gregset_t[34];
+
+/* Register set for the floating-point registers.  */
+typedef elf_greg_t elf_fpregset_t[32];
diff --git a/sysdeps/unix/sysv/linux/or1k/getcontext.S b/sysdeps/unix/sysv/linux/or1k/getcontext.S
new file mode 100644
index 0000000000..3964901da3
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/getcontext.S
@@ -0,0 +1,72 @@
+/* Save current context.  OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
+	 l.ori r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END(__getcontext)
+weak_alias(__getcontext, getcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/makecontext.c b/sysdeps/unix/sysv/linux/or1k/makecontext.c
new file mode 100644
index 0000000000..928c63bada
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/makecontext.c
@@ -0,0 +1,77 @@
+/* Create new context.  OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
+		+-----------------------+
+		| padding as required   |
+		+-----------------------+
+    sp ->      | parameters 7 to n     |
+		+-----------------------+
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
+  unsigned long int *sp;
+  va_list ap;
+  int i;
+
+  sp = (unsigned long int *)
+    ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
+
+  /* Allocate stack arguments.  */
+  sp -= argc < 6 ? 0 : argc - 6;
+
+  /* Keep the stack aligned.  */
+  sp = (unsigned long int *) (((uintptr_t) sp) & -4L);
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
+      ucp->uc_mcontext.__gprs[i + 3] = va_arg (ap, unsigned long int);
+    else
+      sp[i - 6] = va_arg (ap, unsigned long int);
+
+  va_end (ap);
+}
+
+weak_alias (__makecontext, makecontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/setcontext.S b/sysdeps/unix/sysv/linux/or1k/setcontext.S
new file mode 100644
index 0000000000..d55a16b2dd
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/setcontext.S
@@ -0,0 +1,108 @@
+/* Set current context.  OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
+	l.ori	r30, r3, 0
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
+	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
+	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
+	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r30)
+	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r30)
+	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r30)
+	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r30)
+
+	/* Restore registers stored in getcontext().  */
+	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r30)
+	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r30)
+	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r30)
+	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r30)
+	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r30)
+	/* Restore r14-r30 even, callee saved registers.  */
+	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r30)
+	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r30)
+	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r30)
+	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r30)
+	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r30)
+	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r30)
+	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r30)
+	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r30)
+	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r30)
+
+	l.jr	r11
+	 l.ori	r11, r0, 0
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
+	l.jal	0x8
+	 l.movhi r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
+	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
+	l.add	r16, r16, r9
+	l.lwz	r16, got(exit)(r16)
+	l.jr	r16
+#else
+	l.j	exit
+#endif
+	 l.nop
+
+END(__startcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h b/sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
new file mode 100644
index 0000000000..3cafa6ff49
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sigcontextinfo.h
@@ -0,0 +1,28 @@
+/* Profile counter helper to get PC from sigcontext. OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
index 0000000000..9624eb986c
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
@@ -0,0 +1,116 @@
+/* Swap two contexts.  OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
+	/* Store ucp to non-argument syscall preserved register.  */
+	l.ori	r30, r4, 0
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
+	l.addi	r4, r30, UCONTEXT_SIGMASK
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
+	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
+	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
+	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r30)
+	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r30)
+	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r30)
+	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r30)
+
+	/* Restore registers stored in getcontext().  */
+	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r30)
+	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r30)
+	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r30)
+	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r30)
+	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r30)
+	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r30)
+	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r30)
+	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r30)
+	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r30)
+	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r30)
+	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r30)
+	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r30)
+	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r30)
+	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r30)
+
+	l.jr	r11
+	 l.ori	r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END (__swapcontext)
+weak_alias (__swapcontext, swapcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
new file mode 100644
index 0000000000..274309fef9
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
@@ -0,0 +1,53 @@
+/* ucontext_t definition, OpenRISC version.
+   Copyright (C) 2021 Free Software Foundation, Inc.
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
+/* Number of general registers.  */
+#define __NGREG	32
+#ifdef __USE_MISC
+# define NGREG	__NGREG
+#endif
+
+/* Context to describe whole processor state.  */
+typedef struct
+  {
+    unsigned long int __gprs[__NGREG];
+    unsigned long int __pc;
+    unsigned long int __sr;
+  } mcontext_t;
+
+/* Userlevel context.  */
+typedef struct ucontext_t
+  {
+    unsigned long int __uc_flags;/* getcontext() 1, ... */
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
-- 
2.31.1

