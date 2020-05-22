From: Florian Weimer <fweimer@redhat.com>
Date: Fri, 22 May 2020 14:56:40 +0200
Subject: [OpenRISC] [PATCH 1/1] Initial support for OpenRISC
In-Reply-To: <20200522113633.209664-2-shorne@gmail.com> (Stafford Horne via
 Libc-alpha's message of "Fri, 22 May 2020 20:36:33 +0900")
References: <20200522113633.209664-1-shorne@gmail.com>
 <20200522113633.209664-2-shorne@gmail.com>
Message-ID: <87eerc3z7b.fsf@oldenburg2.str.redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

* Stafford Horne via Libc-alpha:

> diff --git a/elf/elf.h b/elf/elf.h
> index 51e9968405..1e8a8e74c4 100644
> --- a/elf/elf.h
> +++ b/elf/elf.h
> @@ -4096,6 +4096,43 @@ enum
>  #define R_ARC_TLS_LE_S9		0x4a
>  #define R_ARC_TLS_LE_32		0x4b
>  
> +/* OpenRISC 1000 specific relocs.  */
> +#define R_OR1K_NONE		0
> +#define R_OR1K_32		1
> +#define R_OR1K_16		2
> +#define R_OR1K_8		3
> +#define R_OR1K_LO_16_IN_INSN	4
> +#define R_OR1K_HI_16_IN_INSN	5
> +#define R_OR1K_INSN_REL_26	6
> +#define R_OR1K_GNU_VTENTRY	7
> +#define R_OR1K_GNU_VTINHERIT	8
> +#define R_OR1K_32_PCREL		9
> +#define R_OR1K_16_PCREL		10
> +#define R_OR1K_8_PCREL		11
> +#define R_OR1K_GOTPC_HI16	12
> +#define R_OR1K_GOTPC_LO16	13
> +#define R_OR1K_GOT16		14
> +#define R_OR1K_PLT26		15
> +#define R_OR1K_GOTOFF_HI16	16
> +#define R_OR1K_GOTOFF_LO16	17
> +#define R_OR1K_COPY		18
> +#define R_OR1K_GLOB_DAT		19
> +#define R_OR1K_JMP_SLOT		20
> +#define R_OR1K_RELATIVE		21
> +#define R_OR1K_TLS_GD_HI16	22
> +#define R_OR1K_TLS_GD_LO16	23
> +#define R_OR1K_TLS_LDM_HI16	24
> +#define R_OR1K_TLS_LDM_LO16	25
> +#define R_OR1K_TLS_LDO_HI16	26
> +#define R_OR1K_TLS_LDO_LO16	27
> +#define R_OR1K_TLS_IE_HI16	28
> +#define R_OR1K_TLS_IE_LO16	29
> +#define R_OR1K_TLS_LE_HI16	30
> +#define R_OR1K_TLS_LE_LO16	31
> +#define R_OR1K_TLS_TPOFF	32
> +#define R_OR1K_TLS_DTPOFF	33
> +#define R_OR1K_TLS_DTPMOD	34
> +
>  __END_DECLS

Please post this separately, it can be reviewed and go in before the
actual port goes in.

> diff --git a/sysdeps/or1k/Implies b/sysdeps/or1k/Implies
> new file mode 100644
> index 0000000000..ff699c7dd5
> --- /dev/null
> +++ b/sysdeps/or1k/Implies
> @@ -0,0 +1,4 @@
> +init_array
> +wordsize-32
> +ieee754/dbl-64
> +ieee754/flt-32

The init_array subdirectory does not exist anymore.

> diff --git a/sysdeps/or1k/bits/endianness.h b/sysdeps/or1k/bits/endianness.h
> new file mode 100644
> index 0000000000..96fd5ae5ef
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
> +/* HP-PA is big-endian.  */
> +#define __BYTE_ORDER __BIG_ENDIAN
> +
> +#endif /* bits/endianness.h */

HP-PA?

> diff --git a/sysdeps/or1k/bits/setjmp.h b/sysdeps/or1k/bits/setjmp.h
> new file mode 100644
> index 0000000000..dd07fce68c
> --- /dev/null
> +++ b/sysdeps/or1k/bits/setjmp.h
> @@ -0,0 +1,36 @@
> +/* Define the machine-dependent type `jmp_buf'.  OpenRISC version.
> +   Copyright (C) 2020 Free Software Foundation, Inc.
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
> +#if defined __USE_MISC || defined _ASM
> +# define JB_SP     0  /* GPR1 */
> +#endif

It's odd to define this in an installed header.  I think it's unused
anyway.  Looks like yet another hppa remnant.

> diff --git a/sysdeps/or1k/dl-machine.h b/sysdeps/or1k/dl-machine.h
> new file mode 100644
> index 0000000000..0bcdc9888c
> --- /dev/null
> +++ b/sysdeps/or1k/dl-machine.h
> @@ -0,0 +1,339 @@

> +auto inline void
> +__attribute ((always_inline))
> +elf_machine_rela (struct link_map *map, const Elf32_Rela *reloc,
> +                  const Elf32_Sym *sym, const struct r_found_version *version,
> +                  void *const reloc_addr_arg, int skip_ifunc)
> +{
> +  Elf32_Addr *const reloc_addr = reloc_addr_arg;
> +  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
> +
> +  if (__builtin_expect (r_type == R_OR1K_NONE, 0))
> +    return;

Please use __glibc_likely and __glibc_unlikely.

> +          case R_OR1K_32:
> +	    {
> +	      /* Handle mis-aligned offsets */
> +	      struct unaligned
> +		{
> +		  Elf32_Addr x;
> +		} __attribute__ ((packed, may_alias));
> +
> +	      /* Support relocations on mis-aligned offsets.  */
> +	      ((struct unaligned *) reloc_addr)->x = value + reloc->r_addend;
> +	      break;

Would it be clearer to use memcpy here?  The generated code is likely
the same.

> +          default:
> +            _dl_fatal_printf("Unhandled reloc: %u\n", r_type);
> +            _dl_reloc_bad_type (map, r_type, 0);
> +            break;

_dl_reloc_bad_type is unreachable here.

> +auto inline void
> +__attribute__ ((always_inline))
> +elf_machine_lazy_rel (struct link_map *map,
> +                      Elf32_Addr l_addr, const Elf32_Rela *reloc,
> +                      int skip_ifunc)
> +{
> +  Elf32_Addr *const reloc_addr = (void *) (l_addr + reloc->r_offset);
> +  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
> +
> +  if (__builtin_expect (r_type == R_OR1K_JMP_SLOT, 1))
> +      *reloc_addr += l_addr;
> +  else if (__builtin_expect (r_type == R_OR1K_NONE, 0))
> +    return;
> +  else
> +    {
> +      _dl_fatal_printf("Unhandled lazy reloc: %u\n", r_type);
> +      _dl_reloc_bad_type (map, r_type, 1);
> +    }

Likewise.

> diff --git a/sysdeps/or1k/dl-start.S b/sysdeps/or1k/dl-start.S
> new file mode 100644
> index 0000000000..95cb0f2396
> --- /dev/null
> +++ b/sysdeps/or1k/dl-start.S

> @@ -0,0 +1,101 @@
> +	/* Load termination function address.
> +	   Pass this in r9 to the _start function.
> +	   start.S will then pass this to __libc_start_main.  */
> +	l.lwz	r9, got(_dl_fini)(r16)

The fini argument to __libc_start_main is unused, so this shouldn't be
necessary.


> diff --git a/sysdeps/or1k/memusage.h b/sysdeps/or1k/memusage.h
> new file mode 100644
> index 0000000000..cdd33c1b7c
> --- /dev/null
> +++ b/sysdeps/or1k/memusage.h

> +#define GETSP() ({ register uintptr_t stack_ptr asm ("r1"); stack_ptr; })

I think it's more future-proof to use the appropriate compiler builtin.

> diff --git a/sysdeps/or1k/start.S b/sysdeps/or1k/start.S
> new file mode 100644
> index 0000000000..339e0ddcc2
> --- /dev/null
> +++ b/sysdeps/or1k/start.S
> @@ -0,0 +1,116 @@

> +	/* rtld_fini = the dynamic fini address.
> +	  This is set by dl-start.S or just plain NULL if called directly. */
> +	l.ori	r8, r9, 0

I think this is outdated, see above.

> diff --git a/sysdeps/unix/sysv/linux/or1k/clone.c b/sysdeps/unix/sysv/linux/or1k/clone.c
> new file mode 100644
> index 0000000000..f9dc4d2106
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/clone.c
> @@ -0,0 +1,59 @@
> +/* Copyright (C) 2020 Free Software Foundation, Inc.
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
> +#include <sysdep.h>
> +
> +extern int __or1k_clone (int (*fn)(void *), void *child_stack,
> +			 int flags, void *arg, pid_t *ptid,
> +			 void *tls, pid_t *ctid);
> +
> +
> +/* or1k ABI uses stack for varargs, syscall uses registers.
> + * This function moves from varargs to regs. */
> +int
> +__clone (int (*fn)(void *), void *child_stack,
> +	 int flags, void *arg, ...
> +	 /* pid_t *ptid, struct user_desc *tls, pid_t *ctid */ )
> +{
> +  void *ptid;
> +  void *tls;
> +  void *ctid;
> +  va_list ap;
> +  int err;
> +
> +  va_start (ap, arg);
> +  ptid = va_arg (ap, void *);
> +  tls = va_arg (ap, void *);
> +  ctid = va_arg (ap, void *);
> +  va_end (ap);
> +
> +  /* Sanity check the arguments */
> +  err = -EINVAL;
> +  if (!fn)
> +    goto syscall_error;
> +  if (!child_stack)
> +    goto syscall_error;
> +
> +  return __or1k_clone (fn, child_stack, flags, arg, ptid, tls, ctid);
> +
> +syscall_error:
> +  __set_errno (-err);
> +  return -1;
> +}

Would it be possible to make the __clone function not varargs?  Or is
this too big a portability hazard?

> diff --git a/sysdeps/unix/sysv/linux/or1k/lowlevellock.h b/sysdeps/unix/sysv/linux/or1k/lowlevellock.h
> new file mode 100644
> index 0000000000..1ab277ad19
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/lowlevellock.h
> @@ -0,0 +1,23 @@
> +/* Copyright (C) 2020 Free Software Foundation, Inc.
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
> +#ifndef _OR1K_LOWLEVELLOCK_H
> +#define _OR1K_LOWLEVELLOCK_H	1
> +
> +#include <sysdeps/nptl/lowlevellock.h>
> +
> +#endif /* lowlevellock.h */

Is this really necessary?  Doesn't the search path take care of that?

> diff --git a/sysdeps/unix/sysv/linux/or1k/mmap_internal.h b/sysdeps/unix/sysv/linux/or1k/mmap_internal.h
> new file mode 100644
> index 0000000000..79cefe667b
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/mmap_internal.h
> @@ -0,0 +1,29 @@
> +/* Common mmap definition for Linux implementation.  OpenRISC version.
> +   Copyright (C) 2020 Free Software Foundation, Inc.
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
> +/* Linux allows PAGE_SHIFT in range of [12-16] and expect
> +   mmap2 offset to be provided in based on the configured pagesize.
> +   Determine the shift dynamically with getpagesize.  */
> +#define MMAP2_PAGE_UNIT -1
> +
> +#include_next <mmap_internal.h>
> +
> +#endif

Does OpenRISC really have a dynamic page size?

I do not see any of the required support code for this.

> diff --git a/sysdeps/unix/sysv/linux/or1k/prctl.c b/sysdeps/unix/sysv/linux/or1k/prctl.c
> new file mode 100644
> index 0000000000..fc7e823974
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/prctl.c
> +/* or1k ABI uses stack for varargs, syscall uses registers.
> + * This function moves from varargs to regs. */
> +int
> +__prctl (int __option, ...)
> +{
> +  va_list ap;
> +  unsigned long arg2;
> +  unsigned long arg3;
> +  unsigned long arg4;
> +  unsigned long arg5;
> +
> +  va_start (ap, __option);
> +  arg2 = va_arg (ap, unsigned long);
> +  arg3 = va_arg (ap, unsigned long);
> +  arg4 = va_arg (ap, unsigned long);
> +  arg5 = va_arg (ap, unsigned long);
> +  va_end (ap);
> +
> +  return INLINE_SYSCALL (prctl, 5, __option, arg2, arg3, arg4, arg5);
> +}
> +weak_alias (__prctl, prctl)

This should use unsigned long int.

> diff --git a/sysdeps/unix/sysv/linux/or1k/pt-vfork.c b/sysdeps/unix/sysv/linux/or1k/pt-vfork.c
> new file mode 100644
> index 0000000000..0169ec4f60
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/pt-vfork.c
> @@ -0,0 +1,30 @@
> +/* Copyright (C) 2020 Free Software Foundation, Inc.
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
> +#include <errno.h>
> +#include <unistd.h>
> +
> +/* If we don't have vfork, fork is close enough.  */

This is no longer true for our posix_spawn implementation.

But this file should be unused anyway.  Can you remove it?


> diff --git a/sysdeps/unix/sysv/linux/or1k/syscall.c b/sysdeps/unix/sysv/linux/or1k/syscall.c
> new file mode 100644
> index 0000000000..6d491bb4b5
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/syscall.c
> @@ -0,0 +1,45 @@

> +long int
> +syscall (long int syscall_number, ...)
> +{
> +  unsigned long arg1, arg2, arg3, arg4, arg5, arg6;
> +  va_list arg;
> +  long int ret;
> +
> +  va_start (arg, syscall_number);
> +  arg1 = va_arg (arg, unsigned long);
> +  arg2 = va_arg (arg, unsigned long);
> +  arg3 = va_arg (arg, unsigned long);
> +  arg4 = va_arg (arg, unsigned long);
> +  arg5 = va_arg (arg, unsigned long);
> +  arg6 = va_arg (arg, unsigned long);
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

Likewise, this should use unsigned long int.  I suspect you can use
INTERNAL_SYSCALL_CALL directly, too.

> diff --git a/sysdeps/unix/sysv/linux/or1k/sysdep.c b/sysdeps/unix/sysv/linux/or1k/sysdep.c
> new file mode 100644
> index 0000000000..3b681e14aa
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/sysdep.c

> +long __syscall_error (long err);
> +hidden_proto (__syscall_error)
> +
> +/* This routine is jumped to by all the syscall handlers, to stash
> +   an error number into errno.  */
> +long
> +__syscall_error (long err)
> +{
> +  __set_errno (- err);
> +  return -1;
> +}
> +hidden_def (__syscall_error)

Should use long int throughout.  Also applies to sysdep.h below.

> diff --git a/sysdeps/unix/sysv/linux/syscall-names.list b/sysdeps/unix/sysv/linux/syscall-names.list
> index 21a62a06f4..fa434fd477 100644
> --- a/sysdeps/unix/sysv/linux/syscall-names.list
> +++ b/sysdeps/unix/sysv/linux/syscall-names.list
> @@ -296,6 +296,7 @@ open_by_handle_at
>  open_tree
>  openat
>  openat2
> +or1k_atomic
>  osf_adjtime
>  osf_afs_syscall
>  osf_alt_plock

Please post this separately, it can go in immediately.

This is not a complete review; I can't comment on the
architecture-specific bits, the atomics, and the math interfaces.

There are a few TODOs/TO-DOs left, please have a look.

You also need to document which ABIs are supported (in INSTALL, with a
brief entry in NEWS).  Are any specific GCC and binutils version
requirements, or kernel header requirements (beyond the already
documented minimums)?

I see a bunch of ifdef's for hard float, but this appears to be a
hard-float-only port.

Thanks,
Florian

