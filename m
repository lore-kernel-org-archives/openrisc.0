From: Stafford Horne <shorne@gmail.com>
Date: Sat, 18 Dec 2021 08:03:33 +0900
Subject: [OpenRISC] [PATCH v3 04/13] or1k: startup and dynamic linking
 code
In-Reply-To: <3aec1cdb-54af-af1c-acec-38efe55c63cf@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-5-shorne@gmail.com>
 <3aec1cdb-54af-af1c-acec-38efe55c63cf@linaro.org>
Message-ID: <Yb0XRd4smFroTwHr@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 16, 2021 at 07:42:46AM -0300, Adhemerval Zanella wrote:
> 
> 
> On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> > Code for C runtime startup and dynamic loading including PLT layout.
> 
> Patch looks ok, although I comment much on ABI and assembly code. Some
> comments below.
> 
> > ---
> >  sysdeps/or1k/bits/link.h   |  51 ++++++
> >  sysdeps/or1k/dl-machine.h  | 323 +++++++++++++++++++++++++++++++++++++
> >  sysdeps/or1k/dl-start.S    |  98 +++++++++++
> >  sysdeps/or1k/ldsodefs.h    |  40 +++++
> >  sysdeps/or1k/sotruss-lib.c |  51 ++++++
> >  sysdeps/or1k/start.S       |  99 ++++++++++++
> >  sysdeps/or1k/tst-audit.h   |  24 +++
> >  7 files changed, 686 insertions(+)
> >  create mode 100644 sysdeps/or1k/bits/link.h
> >  create mode 100644 sysdeps/or1k/dl-machine.h
> >  create mode 100644 sysdeps/or1k/dl-start.S
> >  create mode 100644 sysdeps/or1k/ldsodefs.h
> >  create mode 100644 sysdeps/or1k/sotruss-lib.c
> >  create mode 100644 sysdeps/or1k/start.S
> >  create mode 100644 sysdeps/or1k/tst-audit.h
> > 
> > diff --git a/sysdeps/or1k/bits/link.h b/sysdeps/or1k/bits/link.h
> > new file mode 100644
> > index 0000000000..ad183c9625
> > --- /dev/null
> > +++ b/sysdeps/or1k/bits/link.h
> > @@ -0,0 +1,51 @@
> > +/* Declarations for dynamic linker interface. OpenRISC version.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library.  If not, see
> > +   <https://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef _LINK_H
> > +# error "Never include <bits/link.h> directly; use <link.h> instead."
> > +#endif
> > +
> > +/* Registers for entry into PLT.  */
> > +typedef struct La_or1k_regs
> > +{
> > +  uint32_t lr_reg[31];
> > +} La_or1k_regs;
> > +
> 
> So is the intent is to provide caller all the register, no only the caller-saved 
> registers?

As I see it...

Shouldn't these usually be the argument registers used in la_pltenter to print
our the function call? i.e.

  print_enter (refcook, defcook, symname,
               regs->lr_reg[0], regs->lr_reg[1], regs->lr_reg[2],
               *flags);

These registers get setup in sysdeps/{arch}/dl-trampoline.S by
_dl_runtime_profile, which then pass them to _dl_profile_fixup.

The problem is openrisc doesn't implement _dl_runtime_profile so we haven't
defined what the registers are.

I noticed the same for arc, csky, riscv.

These are needed to be defined for sotruss, but I dont seem them being used.

Is that correct?

> > +/* Return values for calls from PLT.  */
> > +typedef struct La_or1k_retval
> > +{
> > +  uint32_t lrv_r3;
> > +} La_or1k_retval;
> > +
> > +__BEGIN_DECLS
> > +
> > +extern ElfW(Addr) la_or1k_gnu_pltenter (ElfW(Sym) *__sym, unsigned int __ndx,
> > +					uintptr_t *__refcook,
> > +					uintptr_t *__defcook,
> > +					La_or1k_regs *__regs,
> > +					unsigned int *__flags,
> > +					const char *__symname,
> > +					long int *__framesizep);
> > +extern unsigned int la_or1k_gnu_pltexit (ElfW(Sym) *__sym, unsigned int __ndx,
> > +					 uintptr_t *__refcook,
> > +					 uintptr_t *__defcook,
> > +					 const La_or1k_regs *__inregs,
> > +					 La_or1k_retval *__outregs,
> > +					 const char *__symname);
> > +
> > +__END_DECLS
> > diff --git a/sysdeps/or1k/dl-machine.h b/sysdeps/or1k/dl-machine.h
> > new file mode 100644
> > index 0000000000..d41554769e
> > --- /dev/null
> > +++ b/sysdeps/or1k/dl-machine.h
> > @@ -0,0 +1,323 @@
> > +/* Machine-dependent ELF dynamic relocation inline functions.  OpenRISC version.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library; if not, see
> > +   <https://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef dl_machine_h
> > +#define dl_machine_h
> > +
> > +#define ELF_MACHINE_NAME "or1k"
> > +
> > +#include <sys/cdefs.h>
> > +#include <sys/param.h>
> > +#include <tls.h>
> > +#include <dl-irel.h>
> > +#include <dl-static-tls.h>
> > +#include <dl-machine-rel.h>
> > +
> > +/* Return nonzero iff ELF header is compatible with the running host.  */
> > +static inline int __attribute__ ((unused))
> > +elf_machine_matches_host (const Elf32_Ehdr *ehdr)
> > +{
> > +  return ehdr->e_machine == EM_OPENRISC;
> > +}
> > +
> > +static inline Elf32_Addr *
> > +or1k_get_got (void)
> > +{
> > +  Elf32_Addr *got;
> > +  register long int linkreg asm ("r9");
> 
> Is the 'r9' a required register by the ABI to use on this assembly snippet?
> I am asking because local name 'registers' are only a hint to gcc, as we
> found recently [1], if you really need 'r9' you will probably need to use 
> a global name resgister.

The r9 is to avoid the snippet from clobbering r9.  The result of l.jal will
update r9 (link register) we want to make sure that is what we used for %1.

I think there were issues with other ways I tried.

Let me look into it more.

> > +  asm ("l.jal    0x8\n"
> > +       " l.movhi %0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n"
> > +       "l.ori    %0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n"
> > +       "l.add    %0, %0, %1\n"
> > +       : "=r" (got), "=r" (linkreg));
> > +
> > +  return got;
> > +}
> > +
> > +/* Return the link-time address of _DYNAMIC.  Conveniently, this is the
> > +   first element of the GOT.  */
> > +static inline Elf32_Addr
> > +elf_machine_dynamic (void)
> > +{
> > +  Elf32_Addr *got = or1k_get_got();
> 
> Space before '('.

OK.

> > +  return *got;
> > +}
> > +
> > +
> > +/* Return the run-time load address of the shared object.  */
> > +static inline Elf32_Addr
> > +elf_machine_load_address (void)
> > +{
> > +  /* Compute the difference between the runtime address of _DYNAMIC as seen
> > +     by a GOTOFF reference, and the link-time address found in the special
> > +     unrelocated first GOT entry.  */
> > +  Elf32_Addr dyn;
> > +  Elf32_Addr *got = or1k_get_got();
> 
> Space before '('.

OK.

> > +
> > +  asm ("l.movhi %0, gotoffhi(_DYNAMIC);"
> > +       "l.ori   %0, %0, gotofflo(_DYNAMIC);"
> > +       "l.add   %0, %0, %1;"
> > +       : "=&r"(dyn) : "r"(got));
> > +
> > +  return dyn - *got;
> > +}
> > +
> > +/* Initial entry point code for the dynamic linker.  The function _dl_start
> > +   is the real entry point; it's return value is the user program's entry
> > +   point.
> > +
> > +   Code is really located in dl-start.S, just tell the linker that it
> > +   exists.  */
> > +#define RTLD_START asm (".globl _dl_start");
> > +
> > +/* ELF_RTYPE_CLASS_PLT iff TYPE describes relocation of a PLT entry or
> > +   TLS variable, so undefined references should not be allowed to
> > +   define the value.
> > +   ELF_RTYPE_CLASS_NOCOPY iff TYPE should not be allowed to resolve to one
> > +   of the main executable's symbols, as for a COPY reloc.  */
> > +
> > +#define elf_machine_type_class(type) \
> > +  (((type) == R_OR1K_JMP_SLOT \
> > +   || (type) == R_OR1K_TLS_DTPMOD \
> > +   || (type) == R_OR1K_TLS_DTPOFF \
> > +   || (type) == R_OR1K_TLS_TPOFF) * ELF_RTYPE_CLASS_PLT \
> > +   | ((type) == R_OR1K_COPY) * ELF_RTYPE_CLASS_COPY)
> > +
> > +/* A reloc type used for ld.so cmdline arg lookups to reject PLT entries.  */
> > +#define ELF_MACHINE_JMP_SLOT    R_OR1K_JMP_SLOT
> > +
> > +#define ARCH_LA_PLTENTER or1k_gnu_pltenter
> > +#define ARCH_LA_PLTEXIT or1k_gnu_pltexit
> > +
> > +/* Set up the loaded object described by L so its unrelocated PLT
> > +   entries will jump to the on-demand fixup code in dl-runtime.c.  */
> > +static inline int __attribute__ ((unused, always_inline))
> > +elf_machine_runtime_setup (struct link_map *l, struct r_scope_elem *scope[],
> > +			   int lazy, int profile)
> > +{
> > +  ElfW(Addr) *pltgot;
> > +  extern void _dl_runtime_resolve (ElfW(Word));
> > +  extern void _dl_runtime_profile (ElfW(Word));
> > +
> > +  if (l->l_info[DT_JMPREL] && lazy)
> > +    {
> > +      pltgot = (ElfW(Addr) *) D_PTR (l, l_info[DT_PLTGOT]);
> > +
> > +      /* Fill in initial entrys of the plt */
> > +
> > +      /* Register the link_map address in the plt at pltgot[1].
> > +	 This will also be used in the resolver for accessing the
> > +	 link_map structure.  */
> > +      pltgot[1] = (ElfW(Addr)) l;
> > +
> > +      /* The pltgot[2] entry contains the address of a function which gets
> > +	 called to get the address of a so far unresolved function and
> > +	 jump to it.  The profiling extension of the dynamic linker allows
> > +	 to intercept the calls to collect information.  In this case we
> > +	 don't store the address in the GOT so that all future calls also
> > +	 end in this function.  */
> > +#if 0 /* Profiling not supported in OpenRISC yet (need to implement
> > +	 _dl_runtime_profile).  */
> > +      if ( profile)
> > +	{
> > +	   pltgot[2] = (ElfW(Addr)) &_dl_runtime_profile;
> > +
> > +	  if (GLRO(dl_profile) != NULL
> > +	      && _dl_name_match_p (GLRO(dl_profile), l))
> > +	    /* Say that we really want profiling and the timers are
> > +	       started.  */
> > +	    GL(dl_profile_map) = l;
> > +	}
> > +      else
> > +#endif
> 
> I think it would be better to remove the commented code and add a comment stating
> LD_PROFILE is not currently supported.

OK.

> > +	{
> > +	  /* This function will get called to fix up the GOT entry
> > +	     indicated by the offset on the stack, and then jump to
> > +	     the resolved address.  */
> > +	  pltgot[2] = (ElfW(Addr)) &_dl_runtime_resolve;
> > +	}
> > +
> > +    }
> > +
> > +  return lazy;
> > +}
> > +
> > +/* Mask identifying addresses reserved for the user program,
> > +   where the dynamic linker should not map anything.  */
> > +#define ELF_MACHINE_USER_ADDRESS_MASK   0xf8000000UL
> > +
> > +/* We define an initialization functions.  This is called very early in
> > +   _dl_sysdep_start.  */
> > +#define DL_PLATFORM_INIT dl_platform_init ()
> > +
> > +static inline void __attribute__ ((unused))
> > +dl_platform_init (void)
> > +{
> > +  if (GLRO(dl_platform) != NULL && *GLRO(dl_platform) == '\0')
> > +    /* Avoid an empty string which would disturb us.  */
> > +    GLRO(dl_platform) = NULL;
> > +}
> > +
> > +static inline ElfW(Addr)
> > +elf_machine_fixup_plt (struct link_map *map, lookup_t t,
> > +		       const ElfW(Sym) *refsym, const ElfW(Sym) *sym,
> > +		       const ElfW(Rela) *reloc,
> > +		       ElfW(Addr) *reloc_addr, ElfW(Addr) value)
> > +{
> > +  return *reloc_addr = value;
> > +}
> > +
> > +/* Return the final value of a plt relocation.  */
> > +static inline Elf32_Addr
> > +elf_machine_plt_value (struct link_map *map, const Elf32_Rela *reloc,
> > +		       Elf32_Addr value)
> > +{
> > +  return value + reloc->r_addend;
> > +}
> > +
> > +
> > +#endif /* !dl_machine_h */
> > +
> > +#ifdef RESOLVE_MAP
> > +
> > +/* Perform the relocation specified by RELOC and SYM (which is fully resolved).
> > +   MAP is the object containing the reloc.  */
> > +
> > +static inline void
> > +__attribute ((always_inline))
> > +elf_machine_rela (struct link_map *map, struct r_scope_elem *scope[],
> > +		  const ElfW(Rela) *reloc, const ElfW(Sym) *sym,
> > +		  const struct r_found_version *version,
> > +		  void *const reloc_addr_arg, int skip_ifunc)
> > +{
> > +  Elf32_Addr *const reloc_addr = reloc_addr_arg;
> > +  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
> > +
> > +  if (__glibc_unlikely (r_type == R_OR1K_NONE))
> > +    return;
> > +  else
> > +    {
> > +# ifndef RESOLVE_CONFLICT_FIND_MAP
> > +      const Elf32_Sym *const refsym = sym;
> > +# endif
> > +      struct link_map *sym_map = RESOLVE_MAP (map, scope, &sym, version,
> > +					      r_type);
> > +      Elf32_Addr value = SYMBOL_ADDRESS (sym_map, sym, true);
> > +
> > +      if (sym != NULL
> > +	  && __glibc_unlikely (ELFW(ST_TYPE) (sym->st_info) == STT_GNU_IFUNC)
> > +	  && __glibc_likely (sym->st_shndx != SHN_UNDEF)
> > +	  && __glibc_likely (!skip_ifunc))
> > +	value = elf_ifunc_invoke (value);
> > +
> > +      switch (r_type)
> > +	{
> > +# ifndef RESOLVE_CONFLICT_FIND_MAP
> > +	  case R_OR1K_COPY:
> > +	    if (sym == NULL)
> > +	      /* This can happen in trace mode if an object could not be
> > +		 found.  */
> > +	      break;
> > +	    if (__glibc_unlikely (sym->st_size > refsym->st_size)
> > +		|| (__glibc_unlikely (sym->st_size < refsym->st_size)
> > +		  && GLRO(dl_verbose)))
> > +	    {
> > +	      const char *strtab;
> > +
> > +	      strtab = (const char *) D_PTR (map, l_info[DT_STRTAB]);
> > +	      _dl_error_printf ("\
> > +%s: Symbol `%s' has different size in shared object, consider re-linking\n",
> > +		  rtld_progname ?: "<program name unknown>",
> > +		  strtab + refsym->st_name);
> > +	    }
> > +	    memcpy (reloc_addr_arg, (void *) value,
> > +		MIN (sym->st_size, refsym->st_size));
> > +	    break;
> > +# endif /* !RESOLVE_CONFLICT_FIND_MAP */
> > +	  case R_OR1K_32:
> > +	    /* Support relocations on mis-aligned offsets.  */
> > +	    value += reloc->r_addend;
> > +	    memcpy (reloc_addr_arg, &value, 4);
> > +	    break;
> > +	  case R_OR1K_GLOB_DAT:
> > +	  case R_OR1K_JMP_SLOT:
> > +	    *reloc_addr = value + reloc->r_addend;
> > +	    break;
> > +	  case R_OR1K_TLS_DTPMOD:
> > +# ifdef RTLD_BOOTSTRAP
> > +	    /* During startup the dynamic linker is always the module
> > +	       with index 1.  */
> > +	    *reloc_addr = 1;
> > +# else
> > +	    if (sym_map != NULL)
> > +	      *reloc_addr = sym_map->l_tls_modid;
> > +# endif
> > +	    break;
> > +	  case R_OR1K_TLS_DTPOFF:
> > +# ifndef RTLD_BOOTSTRAP
> > +	    *reloc_addr = (sym == NULL ? 0 : sym->st_value) + reloc->r_addend;
> > +# endif
> > +	    break;
> > +
> > +	  case R_OR1K_TLS_TPOFF:
> > +# ifdef RTLD_BOOTSTRAP
> > +	    *reloc_addr = sym->st_value + reloc->r_addend +
> > +	      map->l_tls_offset - TLS_TCB_SIZE;
> > +# else
> > +	    if (sym_map != NULL)
> > +	      {
> > +		CHECK_STATIC_TLS (map, sym_map);
> > +		*reloc_addr = sym->st_value + reloc->r_addend +
> > +		  sym_map->l_tls_offset - TLS_TCB_SIZE;
> > +	      }
> > +# endif
> > +	    break;
> > +	  default:
> > +	    _dl_reloc_bad_type (map, r_type, 0);
> > +	    break;
> > +	}
> > +    }
> > +}
> > +
> > +static inline void
> > +__attribute__ ((always_inline))
> > +elf_machine_rela_relative (Elf32_Addr l_addr, const Elf32_Rela *reloc,
> > +			   void *const reloc_addr_arg)
> > +{
> > +  Elf32_Addr *const reloc_addr = reloc_addr_arg;
> > +  *reloc_addr = l_addr + reloc->r_addend;
> > +}
> > +
> > +static inline void
> > +__attribute__ ((always_inline))
> > +elf_machine_lazy_rel (struct link_map *map, struct r_scope_elem *scope[],
> > +		      ElfW(Addr) l_addr, const ElfW(Rela) *reloc,
> > +		      int skip_ifunc)
> > +{
> > +  Elf32_Addr *const reloc_addr = (void *) (l_addr + reloc->r_offset);
> > +  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
> > +
> > +  if (__glibc_likely (r_type == R_OR1K_JMP_SLOT))
> > +      *reloc_addr += l_addr;
> > +  else if (__glibc_unlikely (r_type == R_OR1K_NONE))
> > +    return;
> > +  else
> > +    _dl_reloc_bad_type (map, r_type, 1);
> > +}
> > +
> > +#endif /* RESOLVE_MAP */
> > diff --git a/sysdeps/or1k/dl-start.S b/sysdeps/or1k/dl-start.S
> > new file mode 100644
> > index 0000000000..ecb1505427
> > --- /dev/null
> > +++ b/sysdeps/or1k/dl-start.S
> > @@ -0,0 +1,98 @@
> > +/* Machine-dependent ELF startup code.  OpenRISC version.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library; if not, see
> > +   <https://www.gnu.org/licenses/>.  */
> > +
> > +#include <sysdep.h>
> > +
> > +/* Initial entry point code for the dynamic linker.
> > +   The function _dl_start is the real entry point;
> > +   it's return value is the user program's entry point.  */
> > +ENTRY (_start)
> > +	/* Count arguments in r11 */
> > +	l.ori	r3, r1, 0
> > +	l.movhi	r11, 0
> > +1:
> > +	l.addi	r3, r3, 4
> > +	l.lwz	r12, 0(r3)
> > +	l.sfnei	r12, 0
> > +	l.addi	r11, r11, 1
> > +	l.bf	1b
> > +	 l.nop
> > +	l.addi	r11, r11, -1
> > +	/* store argument counter to stack.  */
> > +	l.sw	0(r1), r11
> > +
> > +	/* Load the PIC register.  */
> > +	l.jal	0x8
> > +	 l.movhi r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
> > +	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
> > +	l.add	r16, r16, r9
> > +
> > +	l.ori	r3, r1, 0
> > +
> > +	l.jal	_dl_start
> > +	 l.nop
> > +	/* Save user entry in a call saved reg.  */
> > +	l.ori	r22, r11, 0
> > +	/* Fall through to _dl_start_user.  */
> > +
> > +_dl_start_user:
> > +	/* Set up for _dl_init.  */
> > +
> > +	/* Load _rtld_local (a.k.a _dl_loaded).  */
> > +	l.lwz	r12, got(_rtld_local)(r16)
> > +	l.lwz	r3, 0(r12)
> > +
> > +	/* Load argc */
> > +	l.lwz	r18, got(_dl_argc)(r16)
> > +	l.lwz	r4, 0(r18)
> > +
> > +	/* Load argv */
> > +	l.lwz	r20, got(_dl_argv)(r16)
> > +	l.lwz	r5, 0(r20)
> > +
> > +	/* Load envp = &argv[argc + 1].  */
> > +	l.slli	r6, r4, 2
> > +	l.addi	r6, r6, 4
> > +	l.add	r6, r6, r5
> > +
> > +	l.jal	plt(_dl_init)
> > +	 l.nop
> > +
> > +	/* Now set up for user entry.
> > +	   The already defined ABI loads argc and argv from the stack.
> > +
> > +	   argc = 0(r1)
> > +	   argv = r1 + 4
> > +	*/
> > +
> > +	/* Load SP as argv - 4.  */
> > +	l.lwz	r3, 0(r20)
> > +	l.addi	r1, r3, -4
> > +
> > +	/* Save argc.  */
> > +	l.lwz	r3, 0(r18)
> > +	l.sw	0(r1), r3
> > +
> > +	/* Pass _dl_fini function address to _start.
> > +	   Next start.S will then pass this as rtld_fini to __libc_start_main.  */
> > +	l.lwz	r3, got(_dl_fini)(r16)
> > +
> > +	l.jr	r22
> > +	 l.nop
> > +
> > +END (_start)
> > diff --git a/sysdeps/or1k/ldsodefs.h b/sysdeps/or1k/ldsodefs.h
> > new file mode 100644
> > index 0000000000..89713fcc70
> > --- /dev/null
> > +++ b/sysdeps/or1k/ldsodefs.h
> > @@ -0,0 +1,40 @@
> > +/* Run-time dynamic linker data structures for loaded ELF shared objects.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library; if not, see
> > +   <https://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef	_OR1K_LDSODEFS_H
> > +#define	_OR1K_LDSODEFS_H	1
> > +
> > +#include <elf.h>
> > +
> > +struct La_or1k_regs;
> > +struct La_or1k_retval;
> > +
> > +#define ARCH_PLTENTER_MEMBERS						\
> > +    uintptr_t (*or1k_gnu_pltenter) (Elf32_Sym *, unsigned int, uintptr_t *, \
> > +				  uintptr_t *, struct La_or1k_regs *, \
> > +				  unsigned int *, const char *name,	\
> > +				  long int *framesizep)
> > +
> > +#define ARCH_PLTEXIT_MEMBERS						\
> > +    unsigned int (*or1k_gnu_pltexit) (Elf32_Sym *, unsigned int, uintptr_t *, \
> > +				    uintptr_t *, const struct La_or1k_regs *, \
> > +				    struct La_or1k_retval *, const char *)
> > +
> > +#include_next <ldsodefs.h>
> > +
> > +#endif
> > diff --git a/sysdeps/or1k/sotruss-lib.c b/sysdeps/or1k/sotruss-lib.c
> > new file mode 100644
> > index 0000000000..ee16f84456
> > --- /dev/null
> > +++ b/sysdeps/or1k/sotruss-lib.c
> > @@ -0,0 +1,51 @@
> > +/* Override generic sotruss-lib.c to define actual functions for OpenRISC.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library.  If not, see
> > +   <https://www.gnu.org/licenses/>.  */
> > +
> > +#define HAVE_ARCH_PLTENTER
> > +#define HAVE_ARCH_PLTEXIT
> > +
> > +#include <elf/sotruss-lib.c>
> > +
> > +ElfW(Addr)
> > +la_or1k_gnu_pltenter (ElfW(Sym) *sym __attribute__ ((unused)),
> > +		       unsigned int ndx __attribute__ ((unused)),
> > +		       uintptr_t *refcook, uintptr_t *defcook,
> > +		       La_or1k_regs *regs, unsigned int *flags,
> > +		       const char *symname, long int *framesizep)
> > +{
> > +  print_enter (refcook, defcook, symname,
> > +	       regs->lr_reg[0], regs->lr_reg[1], regs->lr_reg[2],
> > +	       *flags);
> > +
> > +  /* No need to copy anything, we will not need the parameters in any case.  */
> > +  *framesizep = 0;
> > +
> > +  return sym->st_value;
> > +}
> > +
> > +unsigned int
> > +la_or1k_gnu_pltexit (ElfW(Sym) *sym, unsigned int ndx, uintptr_t *refcook,
> > +		      uintptr_t *defcook,
> > +		      const struct La_or1k_regs *inregs,
> > +		      struct La_or1k_retval *outregs,
> > +		      const char *symname)
> > +{
> > +  print_exit (refcook, defcook, symname, outregs->lrv_r3);
> > +
> > +  return 0;
> > +}
> > diff --git a/sysdeps/or1k/start.S b/sysdeps/or1k/start.S
> > new file mode 100644
> > index 0000000000..0424355f36
> > --- /dev/null
> > +++ b/sysdeps/or1k/start.S
> > @@ -0,0 +1,99 @@
> > +/* start, OpenRISC version.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library; if not, write to the Free
> > +   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> > +   02111-1307 USA.  */
> > +
> > +/* This is the canonical entry point, usually the first thing in the text
> > +   segment.
> > +
> > +   sp   The stack contains the arguments and environment:
> > +    0(sp)     argc
> > +    4(sp)     argv[0]
> > +    ...
> > +    (4*argc)(sp)    NULL
> > +    (4*(argc+1))(sp)  envp[0]
> > +    ...
> > +    NULL
> > + */
> > +
> > +#define __ASSEMBLY__
> > +#include <sysdep.h>
> > +#include <entry.h>
> > +
> > +ENTRY (ENTRY_POINT)
> > +
> > +	/* Setup Arguments to the __libc_start_main function.  */
> > +
> > +	/* Take values for argc and argv off the stack.
> > +	   These will be passed as arguments two and three to main
> > +	   and thus go in registers r4 and r5, respectively.  */
> > +	l.lwz	r4, 0(r1)
> > +	l.addi	r5, r1, 4
> > +
> > +	/* Pass in rtld_fini from dl-start.S.  */
> > +	l.or	r8, r3, r3
> > +
> > +#ifdef PIC
> > +	/* Obtain a pointer to .got in r16 */
> > +	l.jal	0x8
> > +	 l.movhi r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
> > +	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
> > +	l.add	r16, r16, r9
> > +
> > +	/* Pass in the the main symbol.  */
> > +	l.lwz	r3, got(main)(r16)
> > +#else
> > +	/* Pass in the the main symbol.  */
> > +	l.movhi r3, hi(main)
> > +	l.ori	r3, r3, lo(main)
> > +#endif
> > +	/* Used to be init and fini.  */
> > +	l.movhi	r6, 0x0
> > +	l.movhi	r7, 0x0
> > +
> > +	/* Push stack limit onto the stack.
> > +	   This provides the highest stack address to user code (as stack grows
> > +	   downwards.
> > +	   This is the seventh argument to __libc_start_main and thus needs to
> > +	   be passed on the stack.  */
> > +	l.sw	-4(r1), r1
> > +
> > +	/* Adjust stack to account for a total of 7 args (i.e. the last one is
> > +	   on the stack.  */
> > +	l.addi	r1, r1, -4
> > +
> > +	/* Clear the frame pointer and link register since this is the
> > +	   outermost frame.  */
> > +	l.movhi	r2, 0x0
> > +	l.movhi	r9, 0x0
> > +
> > +	/* Let the libc call main and exit with its return code.  */
> > +#ifdef PIC
> > +	l.j	plt(__libc_start_main)
> > +#else
> > +	l.j	__libc_start_main
> > +#endif
> > +	 l.nop
> > +END (ENTRY_POINT)
> > +
> > +	/* Define a symbol for the first piece of initialized data.  */
> > +	.data
> > +	.globl __data_start
> > +__data_start:
> > +	.long 0
> > +	.weak data_start
> > +	data_start = __data_start
> > diff --git a/sysdeps/or1k/tst-audit.h b/sysdeps/or1k/tst-audit.h
> > new file mode 100644
> > index 0000000000..79ee1b7b02
> > --- /dev/null
> > +++ b/sysdeps/or1k/tst-audit.h
> > @@ -0,0 +1,24 @@
> > +/* Definitions for testing PLT entry/exit auditing.  OpenRISC version.
> > +   Copyright (C) 2021 Free Software Foundation, Inc.
> > +
> > +   This file is part of the GNU C Library.
> > +
> > +   The GNU C Library is free software; you can redistribute it and/or
> > +   modify it under the terms of the GNU Lesser General Public
> > +   License as published by the Free Software Foundation; either
> > +   version 2.1 of the License, or (at your option) any later version.
> > +
> > +   The GNU C Library is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +   Lesser General Public License for more details.
> > +
> > +   You should have received a copy of the GNU Lesser General Public
> > +   License along with the GNU C Library.  If not, see
> > +   <https://www.gnu.org/licenses/>.  */
> > +
> > +#define pltenter la_or1k_gnu_pltenter
> > +#define pltexit la_or1k_gnu_pltexit
> > +#define La_regs La_or1k_regs
> > +#define La_retval La_or1k_retval
> > +#define int_retval lrv_r3
> 
> [1] https://sourceware.org/pipermail/libc-alpha/2021-December/134176.html

Ill try to change it and test.

Thanks for the comments.

-Stafford
