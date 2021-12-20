From: Stafford Horne <shorne@gmail.com>
Date: Tue, 21 Dec 2021 06:40:42 +0900
Subject: [OpenRISC] [PATCH v3 04/13] or1k: startup and dynamic linking
 code
In-Reply-To: <bc0015db-fc33-6ce1-9f41-615676bc4266@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-5-shorne@gmail.com>
 <3aec1cdb-54af-af1c-acec-38efe55c63cf@linaro.org>
 <Yb0XRd4smFroTwHr@antec>
 <bc0015db-fc33-6ce1-9f41-615676bc4266@linaro.org>
Message-ID: <YcD4WgWHa1dXQIai@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 20, 2021 at 04:45:21PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 17/12/2021 20:03, Stafford Horne wrote:
> > On Thu, Dec 16, 2021 at 07:42:46AM -0300, Adhemerval Zanella wrote:
> >>
> >>
> >> On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> >>> Code for C runtime startup and dynamic loading including PLT layout.
> >>
> >> Patch looks ok, although I comment much on ABI and assembly code. Some
> >> comments below.
> >>
> >>> ---
> >>>  sysdeps/or1k/bits/link.h   |  51 ++++++
> >>>  sysdeps/or1k/dl-machine.h  | 323 +++++++++++++++++++++++++++++++++++++
> >>>  sysdeps/or1k/dl-start.S    |  98 +++++++++++
> >>>  sysdeps/or1k/ldsodefs.h    |  40 +++++
> >>>  sysdeps/or1k/sotruss-lib.c |  51 ++++++
> >>>  sysdeps/or1k/start.S       |  99 ++++++++++++
> >>>  sysdeps/or1k/tst-audit.h   |  24 +++
> >>>  7 files changed, 686 insertions(+)
> >>>  create mode 100644 sysdeps/or1k/bits/link.h
> >>>  create mode 100644 sysdeps/or1k/dl-machine.h
> >>>  create mode 100644 sysdeps/or1k/dl-start.S
> >>>  create mode 100644 sysdeps/or1k/ldsodefs.h
> >>>  create mode 100644 sysdeps/or1k/sotruss-lib.c
> >>>  create mode 100644 sysdeps/or1k/start.S
> >>>  create mode 100644 sysdeps/or1k/tst-audit.h
> >>>
> >>> diff --git a/sysdeps/or1k/bits/link.h b/sysdeps/or1k/bits/link.h
> >>> new file mode 100644
> >>> index 0000000000..ad183c9625
> >>> --- /dev/null
> >>> +++ b/sysdeps/or1k/bits/link.h
> >>> @@ -0,0 +1,51 @@
> >>> +/* Declarations for dynamic linker interface. OpenRISC version.
> >>> +   Copyright (C) 2021 Free Software Foundation, Inc.
> >>> +   This file is part of the GNU C Library.
> >>> +
> >>> +   The GNU C Library is free software; you can redistribute it and/or
> >>> +   modify it under the terms of the GNU Lesser General Public
> >>> +   License as published by the Free Software Foundation; either
> >>> +   version 2.1 of the License, or (at your option) any later version.
> >>> +
> >>> +   The GNU C Library is distributed in the hope that it will be useful,
> >>> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >>> +   Lesser General Public License for more details.
> >>> +
> >>> +   You should have received a copy of the GNU Lesser General Public
> >>> +   License along with the GNU C Library.  If not, see
> >>> +   <https://www.gnu.org/licenses/>.  */
> >>> +
> >>> +#ifndef _LINK_H
> >>> +# error "Never include <bits/link.h> directly; use <link.h> instead."
> >>> +#endif
> >>> +
> >>> +/* Registers for entry into PLT.  */
> >>> +typedef struct La_or1k_regs
> >>> +{
> >>> +  uint32_t lr_reg[31];
> >>> +} La_or1k_regs;
> >>> +
> >>
> >> So is the intent is to provide caller all the register, no only the caller-saved 
> >> registers?
> > 
> > As I see it...
> > 
> > Shouldn't these usually be the argument registers used in la_pltenter to print
> > our the function call? i.e.
> > 
> >   print_enter (refcook, defcook, symname,
> >                regs->lr_reg[0], regs->lr_reg[1], regs->lr_reg[2],
> >                *flags);
> > 
> > These registers get setup in sysdeps/{arch}/dl-trampoline.S by
> > _dl_runtime_profile, which then pass them to _dl_profile_fixup.
> > 
> > The problem is openrisc doesn't implement _dl_runtime_profile so we haven't
> > defined what the registers are.
> > 
> > I noticed the same for arc, csky, riscv.
> > 
> > These are needed to be defined for sotruss, but I dont seem them being used.
> > 
> > Is that correct?
> 
> The register are really dependend of the function calling ABI of the architecture,
> if you check other architecture like x86 and powerpc you will see that La_i86_regs
> and La_ppc64_regs only saves the caller-saved ones.  It is mainly because for
> PLT tracking, as done by audit modules, other register are not really useful 
> (since they are just internal ones to the caller function).

I see, but isn't this register saving done in _dl_profile_resolve?

OpenRISC doesn't define _dl_profile_resolve.

I can change the definition  of La_or1k_regs, but as I see it it is currently
not used other than building sotruss-lib and audit modules.  But I don't see
how pltenter will be called without implementing _dl_profile_resolve.

> > 
> >>> +/* Return values for calls from PLT.  */
> >>> +typedef struct La_or1k_retval
> >>> +{
> >>> +  uint32_t lrv_r3;
> >>> +} La_or1k_retval;
> >>> +
> >>> +__BEGIN_DECLS
> >>> +
> >>> +extern ElfW(Addr) la_or1k_gnu_pltenter (ElfW(Sym) *__sym, unsigned int __ndx,
> >>> +					uintptr_t *__refcook,
> >>> +					uintptr_t *__defcook,
> >>> +					La_or1k_regs *__regs,
> >>> +					unsigned int *__flags,
> >>> +					const char *__symname,
> >>> +					long int *__framesizep);
> >>> +extern unsigned int la_or1k_gnu_pltexit (ElfW(Sym) *__sym, unsigned int __ndx,
> >>> +					 uintptr_t *__refcook,
> >>> +					 uintptr_t *__defcook,
> >>> +					 const La_or1k_regs *__inregs,
> >>> +					 La_or1k_retval *__outregs,
> >>> +					 const char *__symname);
> >>> +
> >>> +__END_DECLS
> >>> diff --git a/sysdeps/or1k/dl-machine.h b/sysdeps/or1k/dl-machine.h
> >>> new file mode 100644
> >>> index 0000000000..d41554769e
> >>> --- /dev/null
> >>> +++ b/sysdeps/or1k/dl-machine.h
> >>> @@ -0,0 +1,323 @@
> >>> +/* Machine-dependent ELF dynamic relocation inline functions.  OpenRISC version.
> >>> +   Copyright (C) 2021 Free Software Foundation, Inc.
> >>> +   This file is part of the GNU C Library.
> >>> +
> >>> +   The GNU C Library is free software; you can redistribute it and/or
> >>> +   modify it under the terms of the GNU Lesser General Public
> >>> +   License as published by the Free Software Foundation; either
> >>> +   version 2.1 of the License, or (at your option) any later version.
> >>> +
> >>> +   The GNU C Library is distributed in the hope that it will be useful,
> >>> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >>> +   Lesser General Public License for more details.
> >>> +
> >>> +   You should have received a copy of the GNU Lesser General Public
> >>> +   License along with the GNU C Library; if not, see
> >>> +   <https://www.gnu.org/licenses/>.  */
> >>> +
> >>> +#ifndef dl_machine_h
> >>> +#define dl_machine_h
> >>> +
> >>> +#define ELF_MACHINE_NAME "or1k"
> >>> +
> >>> +#include <sys/cdefs.h>
> >>> +#include <sys/param.h>
> >>> +#include <tls.h>
> >>> +#include <dl-irel.h>
> >>> +#include <dl-static-tls.h>
> >>> +#include <dl-machine-rel.h>
> >>> +
> >>> +/* Return nonzero iff ELF header is compatible with the running host.  */
> >>> +static inline int __attribute__ ((unused))
> >>> +elf_machine_matches_host (const Elf32_Ehdr *ehdr)
> >>> +{
> >>> +  return ehdr->e_machine == EM_OPENRISC;
> >>> +}
> >>> +
> >>> +static inline Elf32_Addr *
> >>> +or1k_get_got (void)
> >>> +{
> >>> +  Elf32_Addr *got;
> >>> +  register long int linkreg asm ("r9");
> >>
> >> Is the 'r9' a required register by the ABI to use on this assembly snippet?
> >> I am asking because local name 'registers' are only a hint to gcc, as we
> >> found recently [1], if you really need 'r9' you will probably need to use 
> >> a global name resgister.
> > 
> > The r9 is to avoid the snippet from clobbering r9.  The result of l.jal will
> > update r9 (link register) we want to make sure that is what we used for %1.
> > 
> > I think there were issues with other ways I tried.
> 
> Should you add it the clobbered list instead?
> 
> > 
> > Let me look into it more.
> > 
> >>> +  asm ("l.jal    0x8\n"
> >>> +       " l.movhi %0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n"
> >>> +       "l.ori    %0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n"
> >>> +       "l.add    %0, %0, %1\n"
> >>> +       : "=r" (got), "=r" (linkreg));
> 
> With something like (unstested):
> 
> 
>   static inline Elf32_Addr *
>   or1k_get_got (void)
>   {
>     Elf32_Addr *got;
>     asm ("l.jal    0x8\n"
>          " l.movhi %0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n"
>          "l.ori    %0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n"
>          "l.add    %0, %0, %1\n"
>          : "=r" (got)
>          :
>          : "r9");
>   }

Yes, this is what I ended up changing it to.

Is the indentation important here? I had it as:

    static inline Elf32_Addr *
    or1k_get_got (void)
    {
      Elf32_Addr *got;

      asm ("l.jal    0x8\n"
	   " l.movhi %0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n"
	   "l.ori    %0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n"
	   "l.add    %0, %0, r9\n"
	   : "=r" (got) : : "r9");

      return got;
    }

-Stafford
