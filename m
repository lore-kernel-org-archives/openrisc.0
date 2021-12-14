From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Tue, 14 Dec 2021 17:53:20 -0300
Subject: [OpenRISC] [PATCH v3 03/13] or1k: ABI Implementation
In-Reply-To: <20211210233456.4146479-4-shorne@gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-4-shorne@gmail.com>
Message-ID: <a0644ab7-85a5-e22d-607e-4e6761d87610@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> This code deals with the OpenRISC ABI.

Some comments below.

> ---
>  sysdeps/or1k/__longjmp.S       | 55 ++++++++++++++++++++++
>  sysdeps/or1k/bits/endianness.h | 11 +++++
>  sysdeps/or1k/bits/setjmp.h     | 32 +++++++++++++
>  sysdeps/or1k/bsd-_setjmp.S     |  1 +
>  sysdeps/or1k/bsd-setjmp.S      |  1 +
>  sysdeps/or1k/dl-trampoline.S   | 79 ++++++++++++++++++++++++++++++++
>  sysdeps/or1k/jmpbuf-offsets.h  | 23 ++++++++++
>  sysdeps/or1k/jmpbuf-unwind.h   | 36 +++++++++++++++
>  sysdeps/or1k/machine-gmon.h    | 35 ++++++++++++++
>  sysdeps/or1k/memusage.h        | 21 +++++++++
>  sysdeps/or1k/setjmp.S          | 56 +++++++++++++++++++++++
>  sysdeps/or1k/sysdep.h          | 83 ++++++++++++++++++++++++++++++++++
>  12 files changed, 433 insertions(+)
>  create mode 100644 sysdeps/or1k/__longjmp.S
>  create mode 100644 sysdeps/or1k/bits/endianness.h
>  create mode 100644 sysdeps/or1k/bits/setjmp.h
>  create mode 100644 sysdeps/or1k/bsd-_setjmp.S
>  create mode 100644 sysdeps/or1k/bsd-setjmp.S
>  create mode 100644 sysdeps/or1k/dl-trampoline.S
>  create mode 100644 sysdeps/or1k/jmpbuf-offsets.h
>  create mode 100644 sysdeps/or1k/jmpbuf-unwind.h
>  create mode 100644 sysdeps/or1k/machine-gmon.h
>  create mode 100644 sysdeps/or1k/memusage.h
>  create mode 100644 sysdeps/or1k/setjmp.S
>  create mode 100644 sysdeps/or1k/sysdep.h
> 
> diff --git a/sysdeps/or1k/__longjmp.S b/sysdeps/or1k/__longjmp.S
> new file mode 100644
> index 0000000000..f8aa5dda8f
> --- /dev/null
> +++ b/sysdeps/or1k/__longjmp.S
> @@ -0,0 +1,55 @@
> +/* longjmp, OpenRISC version.
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
> +#include <features.h>
> +#define _ASM
> +#define _SETJMP_H
> +#include <bits/setjmp.h>
> +
> +	.globl	__longjmp;
> +	.type	__longjmp, @function;
> +	.align	4;
> +
> +__longjmp:

Use ENTRY/END here, as other setjmp functions are doing.

> +	l.lwz	r1, 0(r3)
> +	l.lwz	r2, 4(r3)
> +
> +	/* if r4 is 0, something wrong, so set it to 1 */
> +	l.sfeqi	r4, 0x0
> +	l.bnf	1f		/* r4 != 0, longjmp value sensible */
> +	 l.nop
> +	l.ori	r4, r0, 0x1	/* make nonzero */
> +1:
> +	l.addi	r11, r4, 0
> +	l.lwz	r9, 8(r3)
> +	l.lwz	r10, 12(r3)
> +	l.lwz	r14, 16(r3)
> +	l.lwz	r16, 20(r3)
> +	l.lwz	r18, 24(r3)
> +	l.lwz	r20, 28(r3)
> +	l.lwz	r22, 32(r3)
> +	l.lwz	r24, 36(r3)
> +	l.lwz	r26, 40(r3)
> +	l.lwz	r28, 44(r3)
> +	l.lwz	r30, 48(r3)
> +	l.jr	r9
> +	 l.nop
> +	.size	__longjmp, . - __longjmp
> +
> +libc_hidden_def(__longjmp)
> diff --git a/sysdeps/or1k/bits/endianness.h b/sysdeps/or1k/bits/endianness.h
> new file mode 100644
> index 0000000000..7b61d8adb7
> --- /dev/null
> +++ b/sysdeps/or1k/bits/endianness.h
> @@ -0,0 +1,11 @@
> +#ifndef _BITS_ENDIANNESS_H
> +#define _BITS_ENDIANNESS_H 1
> +
> +#ifndef _BITS_ENDIAN_H
> +# error "Never use <bits/endianness.h> directly; include <endian.h> instead."
> +#endif
> +
> +/* OpenRISC is big-endian.  */
> +#define __BYTE_ORDER __BIG_ENDIAN
> +
> +#endif /* bits/endianness.h */

Ok.

> diff --git a/sysdeps/or1k/bits/setjmp.h b/sysdeps/or1k/bits/setjmp.h
> new file mode 100644
> index 0000000000..dac511c904
> --- /dev/null
> +++ b/sysdeps/or1k/bits/setjmp.h
> @@ -0,0 +1,32 @@
> +/* Define the machine-dependent type `jmp_buf'.  OpenRISC version.
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
> +
> +#ifndef _OR1K_BITS_SETJMP_H
> +#define _OR1K_BITS_SETJMP_H  1
> +
> +#if !defined _SETJMP_H && !defined _PTHREAD_H
> +# error "Never include <bits/setjmp.h> directly; use <setjmp.h> instead."
> +#endif
> +
> +#ifndef _ASM
> +typedef long int __jmp_buf[13];
> +#endif
> +
> +#endif /* _OR1K_BITS_SETJMP_H */

Ok.

> diff --git a/sysdeps/or1k/bsd-_setjmp.S b/sysdeps/or1k/bsd-_setjmp.S
> new file mode 100644
> index 0000000000..4e6a2da560
> --- /dev/null
> +++ b/sysdeps/or1k/bsd-_setjmp.S
> @@ -0,0 +1 @@
> +/* _setjmp is in setjmp.S  */
> diff --git a/sysdeps/or1k/bsd-setjmp.S b/sysdeps/or1k/bsd-setjmp.S
> new file mode 100644
> index 0000000000..1da848d2f1
> --- /dev/null
> +++ b/sysdeps/or1k/bsd-setjmp.S
> @@ -0,0 +1 @@
> +/* setjmp is in setjmp.S  */
> diff --git a/sysdeps/or1k/dl-trampoline.S b/sysdeps/or1k/dl-trampoline.S
> new file mode 100644
> index 0000000000..9ebc68f525
> --- /dev/null
> +++ b/sysdeps/or1k/dl-trampoline.S
> @@ -0,0 +1,79 @@
> +/* Machine-dependent ELF runtime symbol resolution, OpenRISC version.
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
> +/* This code is used to call _dl_linux_resolver (dl-runtime.c).
> +
> +   We assume that R11 contains the relocation offset and R12 contains
> +   link_map (_DYNAMIC).  This must be consistent with the JUMP_SLOT
> +   layout generated by binutils.  */
> +
> +	.section .text
> +	.align 4
> +
> +	.global	_dl_runtime_resolve
> +	.type	_dl_runtime_resolve, @function
> +
> +_dl_runtime_resolve:
> +	.cfi_startproc
> +	l.sw	-4(r1), r9
> +	l.sw	-8(r1), r1
> +
> +	/* save function arguments.  */
> +	l.sw	-12(r1), r3
> +	l.sw	-16(r1), r4
> +	l.sw	-20(r1), r5
> +	l.sw	-24(r1), r6
> +	l.sw	-28(r1), r7
> +	l.sw	-32(r1), r8
> +
> +	.cfi_offset 9, -4
> +	.cfi_offset 1, -8
> +	.cfi_offset 3, -12
> +	.cfi_offset 4, -16
> +	.cfi_offset 5, -20
> +	.cfi_offset 6, -24
> +	.cfi_offset 7, -28
> +	.cfi_offset 8, -32
> +
> +	l.addi	r1,r1, -32
> +	.cfi_def_cfa_offset 32
> +
> +	l.ori	r3, r12, 0
> +	l.ori	r4, r11, 0
> +
> +	l.jal	_dl_fixup
> +	 l.nop
> +
> +	/* Restore function arguments.  */
> +	l.addi	r1,r1, 32
> +	l.lwz	r8, -32(r1)
> +	l.lwz	r7, -28(r1)
> +	l.lwz	r6, -24(r1)
> +	l.lwz	r5, -20(r1)
> +	l.lwz	r4, -16(r1)
> +	l.lwz	r3, -12(r1)
> +
> +	/* restore return address.  */
> +	l.lwz	r9, -4(r1)
> +
> +	l.jr	r11
> +	 l.nop
> +
> +	.cfi_endproc
> +	.size	_dl_runtime_resolve, . - _dl_runtime_resolve

It seems that _dl_runtime_profile is not implemented and explicit disabled
on sysdeps/or1k/dl-machine.h.  In this case I think it would be better to
explicit disable it on configure:

diff --git a/configure.ac b/configure.ac
index 277d3527d2..6883069b36 100644
--- a/configure.ac
+++ b/configure.ac
@@ -525,6 +525,9 @@ libc_config_ok=no
 # whether to use such directories.
 with_fp_cond=1
 
+# A preconfigure script may disable profile support
+with_profile=yes
+
 dnl Let sysdeps/*/preconfigure act here.
 LIBC_PRECONFIGURE([$srcdir], [for sysdeps])
 
@@ -1891,6 +1894,12 @@ LIBC_CONFIG_VAR([enable-static-pie], [$libc_cv_static_pie])
 libc_cv_multidir=`${CC-cc} $CFLAGS $CPPFLAGS -print-multi-directory`
 AC_SUBST(libc_cv_multidir)
 
+if test "x$profile" != xno; then
+  if test "x$with_profile" == xno; then
+    AC_MSG_ERROR([ABI does not support profiling])
+  fi
+fi
+
 AC_SUBST(profile)
 AC_SUBST(static_nss)
 
diff --git a/sysdeps/or1k/preconfigure b/sysdeps/or1k/preconfigure
index d1b1fb1843..b8d4f8c716 100644
--- a/sysdeps/or1k/preconfigure
+++ b/sysdeps/or1k/preconfigure
@@ -32,3 +32,4 @@ or1k*)
   ;;
 esac
 
+with_profile=no


> diff --git a/sysdeps/or1k/jmpbuf-offsets.h b/sysdeps/or1k/jmpbuf-offsets.h
> new file mode 100644
> index 0000000000..e33105cc03
> --- /dev/null
> +++ b/sysdeps/or1k/jmpbuf-offsets.h
> @@ -0,0 +1,23 @@
> +/* Private macros for accessing __jmp_buf contents.  OpenRISC version.
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
> +#define __JMP_BUF_SP    0
> +
> +/* Helper for generic function ____longjmp_chk.  */
> +#define JB_FRAME_ADDRESS(buf) \
> +    ((void *) (unsigned long) (buf[__JMP_BUF_SP]))
> diff --git a/sysdeps/or1k/jmpbuf-unwind.h b/sysdeps/or1k/jmpbuf-unwind.h
> new file mode 100644
> index 0000000000..6710dea989
> --- /dev/null
> +++ b/sysdeps/or1k/jmpbuf-unwind.h
> @@ -0,0 +1,36 @@
> +/* Macros to help frame unwinding using jmpbuf.  OpenRISC version.
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
> +#include <setjmp.h>
> +#include <jmpbuf-offsets.h>
> +#include <stdint.h>
> +#include <unwind.h>
> +
> +/* Test if longjmp to JMPBUF would unwind the frame
> +   containing a local variable at ADDRESS.  */
> +#define _JMPBUF_UNWINDS(jmpbuf, address, demangle) \
> +  ((void *) (address) < (void *) demangle (jmpbuf[__JMP_BUF_SP]))
> +
> +#define _JMPBUF_CFA_UNWINDS_ADJ(_jmpbuf, _context, _adj) \
> +  _JMPBUF_UNWINDS_ADJ (_jmpbuf, (void *) _Unwind_GetCFA (_context), _adj)
> +
> +#define _JMPBUF_UNWINDS_ADJ(_jmpbuf, _address, _adj) \
> +  ((uintptr_t) (_address) - (_adj) < (uintptr_t) (_jmpbuf)[__JMP_BUF_SP] - (_adj))
> +
> +/* We use the normal longjmp for unwinding.  */
> +#define __libc_unwind_longjmp(buf, val) __libc_longjmp (buf, val)
> diff --git a/sysdeps/or1k/machine-gmon.h b/sysdeps/or1k/machine-gmon.h
> new file mode 100644
> index 0000000000..7152105eec
> --- /dev/null
> +++ b/sysdeps/or1k/machine-gmon.h
> @@ -0,0 +1,35 @@
> +/* Machine-dependent definitions for profiling support.  OpenRISC version.
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
> +
> +#define _MCOUNT_DECL(frompc, selfpc)					\
> +static void								\
> +__mcount_internal (unsigned long int frompc, unsigned long int selfpc)
> +
> +/* This is very simple as gcc does all the heavy lifting at the _mcount
> +   call site.  GCC passes in the return address of the function calling
> +   _mcount.  */
> +
> +#define MCOUNT								\
> +void									\
> +_mcount (void *frompc)							\
> +{									\
> +  __mcount_internal ((unsigned long int) frompc,			\
> +		     (unsigned long int) __builtin_return_address (0));	\
> +}
> diff --git a/sysdeps/or1k/memusage.h b/sysdeps/or1k/memusage.h
> new file mode 100644
> index 0000000000..a62da17e61
> --- /dev/null
> +++ b/sysdeps/or1k/memusage.h
> @@ -0,0 +1,21 @@
> +/* Definitions for memory usage profiling.  OpenRISC version.
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
> +#define GETSP() ({ register uintptr_t stack_ptr asm ("r1"); stack_ptr; })
> +
> +#include <sysdeps/generic/memusage.h>
> diff --git a/sysdeps/or1k/setjmp.S b/sysdeps/or1k/setjmp.S
> new file mode 100644
> index 0000000000..660995b493
> --- /dev/null
> +++ b/sysdeps/or1k/setjmp.S
> @@ -0,0 +1,56 @@
> +/* setjmp, OpenRISC version.
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
> +#define _ASM
> +#define _SETJMP_H
> +#include <bits/setjmp.h>
> +
> +ENTRY (_setjmp)
> +	l.addi	r4, r0, 0     /* Set second argument to 0.  */
> +	l.j	.Local__sigsetjmp
> +	 l.nop
> +END (_setjmp)
> +libc_hidden_def (_setjmp)
> +
> +ENTRY (setjmp)
> +	l.addi	r4, r0, 1     /* Set second argument to 1.  */
> +	l.j	.Local__sigsetjmp
> +	 l.nop
> +END (setjmp)
> +
> +ENTRY (__sigsetjmp)
> +.Local__sigsetjmp:
> +	l.sw	0(r3), r1
> +	l.sw	4(r3), r2
> +	l.sw	8(r3), r9
> +	l.sw	12(r3), r10
> +	l.sw	16(r3), r14
> +	l.sw	20(r3), r16
> +	l.sw	24(r3), r18
> +	l.sw	28(r3), r20
> +	l.sw	32(r3), r22
> +	l.sw	36(r3), r24
> +	l.sw	40(r3), r26
> +	l.sw	44(r3), r28
> +	l.sw	48(r3), r30
> +	l.j	__sigjmp_save
> +	 l.nop
> +END (__sigsetjmp)
> +hidden_def (__sigsetjmp)
> diff --git a/sysdeps/or1k/sysdep.h b/sysdeps/or1k/sysdep.h
> new file mode 100644
> index 0000000000..61a135afe7
> --- /dev/null
> +++ b/sysdeps/or1k/sysdep.h
> @@ -0,0 +1,83 @@
> +/* Assembler macro definitions.  OpenRISC version.
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
> +#include <sysdeps/generic/sysdep.h>
> +#include <features.h>
> +
> +#if defined __ASSEMBLER__ || defined REQUEST_ASSEMBLER_MACROS
> +
> +/* Make use of .size directive.  */
> +#define ASM_SIZE_DIRECTIVE(name) .size name,.-name;
> +
> +/* Define an entry point visible from C.  */
> +#define ENTRY(name)                                                           \
> +  .globl C_SYMBOL_NAME(name);                                                 \
> +  .type C_SYMBOL_NAME(name), at function;                                        \
> +  .align 4;                                                                   \
> +  C_LABEL(name)                                                               \
> +  cfi_startproc;                                                              \
> +  CALL_MCOUNT
> +
> +#undef  END
> +#define END(name)                                                             \
> +  cfi_endproc;                                                                \
> +  ASM_SIZE_DIRECTIVE(name)
> +
> +/* Since C identifiers are not normally prefixed with an underscore
> +   on this system, the asm identifier `syscall_error' intrudes on the
> +   C name space.  Make sure we use an innocuous name.  */
> +#define syscall_error   __syscall_error
> +
> +/* If compiled for profiling, call `mcount' at the start of each function.  */
> +#ifdef  PROF
> +# ifdef __PIC__
> +#  define CALL_MCOUNT						\
> +	l.addi	r1, r1, -8;					\
> +	l.sw	0(r1), r9;					\
> +	l.sw	4(r1), r3;					\
> +	l.ori	r3, r9, 0;					\
> +	l.j	plt(_mcount);					\
> +	 l.nop;							\
> +	l.lwz	r9, 0(r1);					\
> +	l.lwz	r3, 4(r1);					\
> +	l.addi	r1, r1, 8;
> +# else
> +#  define CALL_MCOUNT						\
> +	l.addi	r1, r1, -8;					\
> +	l.sw	0(r1), r9;					\
> +	l.sw	4(r1), r3;					\
> +	l.ori	r3, r9, 0;					\
> +	l.movhi r15, hi(_mcount);				\
> +	l.ori	r15, r15, lo(_mcount);				\
> +	l.jr	r15;						\
> +	 l.nop;							\
> +	l.lwz	r9, 0(r1);					\
> +	l.lwz	r3, 4(r1);					\
> +	l.addi	r1, r1, 8;
> +# endif
> +#else
> +# define CALL_MCOUNT             /* Do nothing.  */
> +#endif
> +
> +/* Local label name for asm code.  */
> +#define L(name)         .L##name
> +
> +/* Specify the size in bytes of a machine register.  */
> +#define REGSIZE         4
> +
> +#endif /* __ASSEMBLER__ */
