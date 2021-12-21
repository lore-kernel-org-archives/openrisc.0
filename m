From: Stafford Horne <shorne@gmail.com>
Date: Tue, 21 Dec 2021 20:46:27 +0900
Subject: [OpenRISC] [PATCH v3 04/13] or1k: startup and dynamic linking
 code
In-Reply-To: <ebd7b34d-39f2-0fc4-a835-e6adc3932686@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-5-shorne@gmail.com>
 <3aec1cdb-54af-af1c-acec-38efe55c63cf@linaro.org>
 <Yb0XRd4smFroTwHr@antec>
 <bc0015db-fc33-6ce1-9f41-615676bc4266@linaro.org>
 <YcD4WgWHa1dXQIai@antec>
 <ebd7b34d-39f2-0fc4-a835-e6adc3932686@linaro.org>
Message-ID: <YcG+kxdZa0jLcreq@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 21, 2021 at 08:09:11AM -0300, Adhemerval Zanella wrote:
> 
> 
> On 20/12/2021 18:40, Stafford Horne wrote:
> > On Mon, Dec 20, 2021 at 04:45:21PM -0300, Adhemerval Zanella wrote:
> >>
> >>
> >> On 17/12/2021 20:03, Stafford Horne wrote:
> >>> On Thu, Dec 16, 2021 at 07:42:46AM -0300, Adhemerval Zanella wrote:
> >>>>
> >>>>
> >>>> On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> >>>>> Code for C runtime startup and dynamic loading including PLT layout.
> >>>>
> >>>> Patch looks ok, although I comment much on ABI and assembly code. Some
> >>>> comments below.
> >>>>
> >>>>> ---
> >>>>>  sysdeps/or1k/bits/link.h   |  51 ++++++
> >>>>>  sysdeps/or1k/dl-machine.h  | 323 +++++++++++++++++++++++++++++++++++++
> >>>>>  sysdeps/or1k/dl-start.S    |  98 +++++++++++
> >>>>>  sysdeps/or1k/ldsodefs.h    |  40 +++++
> >>>>>  sysdeps/or1k/sotruss-lib.c |  51 ++++++
> >>>>>  sysdeps/or1k/start.S       |  99 ++++++++++++
> >>>>>  sysdeps/or1k/tst-audit.h   |  24 +++
> >>>>>  7 files changed, 686 insertions(+)
> >>>>>  create mode 100644 sysdeps/or1k/bits/link.h
> >>>>>  create mode 100644 sysdeps/or1k/dl-machine.h
> >>>>>  create mode 100644 sysdeps/or1k/dl-start.S
> >>>>>  create mode 100644 sysdeps/or1k/ldsodefs.h
> >>>>>  create mode 100644 sysdeps/or1k/sotruss-lib.c
> >>>>>  create mode 100644 sysdeps/or1k/start.S
> >>>>>  create mode 100644 sysdeps/or1k/tst-audit.h
> >>>>>
> >>>>> diff --git a/sysdeps/or1k/bits/link.h b/sysdeps/or1k/bits/link.h
> >>>>> new file mode 100644
> >>>>> index 0000000000..ad183c9625
> >>>>> --- /dev/null
> >>>>> +++ b/sysdeps/or1k/bits/link.h
> >>>>> @@ -0,0 +1,51 @@
> >>>>> +/* Declarations for dynamic linker interface. OpenRISC version.
> >>>>> +   Copyright (C) 2021 Free Software Foundation, Inc.
> >>>>> +   This file is part of the GNU C Library.
> >>>>> +
> >>>>> +   The GNU C Library is free software; you can redistribute it and/or
> >>>>> +   modify it under the terms of the GNU Lesser General Public
> >>>>> +   License as published by the Free Software Foundation; either
> >>>>> +   version 2.1 of the License, or (at your option) any later version.
> >>>>> +
> >>>>> +   The GNU C Library is distributed in the hope that it will be useful,
> >>>>> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>>> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >>>>> +   Lesser General Public License for more details.
> >>>>> +
> >>>>> +   You should have received a copy of the GNU Lesser General Public
> >>>>> +   License along with the GNU C Library.  If not, see
> >>>>> +   <https://www.gnu.org/licenses/>.  */
> >>>>> +
> >>>>> +#ifndef _LINK_H
> >>>>> +# error "Never include <bits/link.h> directly; use <link.h> instead."
> >>>>> +#endif
> >>>>> +
> >>>>> +/* Registers for entry into PLT.  */
> >>>>> +typedef struct La_or1k_regs
> >>>>> +{
> >>>>> +  uint32_t lr_reg[31];
> >>>>> +} La_or1k_regs;
> >>>>> +
> >>>>
> >>>> So is the intent is to provide caller all the register, no only the caller-saved 
> >>>> registers?
> >>>
> >>> As I see it...
> >>>
> >>> Shouldn't these usually be the argument registers used in la_pltenter to print
> >>> our the function call? i.e.
> >>>
> >>>   print_enter (refcook, defcook, symname,
> >>>                regs->lr_reg[0], regs->lr_reg[1], regs->lr_reg[2],
> >>>                *flags);
> >>>
> >>> These registers get setup in sysdeps/{arch}/dl-trampoline.S by
> >>> _dl_runtime_profile, which then pass them to _dl_profile_fixup.
> >>>
> >>> The problem is openrisc doesn't implement _dl_runtime_profile so we haven't
> >>> defined what the registers are.
> >>>
> >>> I noticed the same for arc, csky, riscv.
> >>>
> >>> These are needed to be defined for sotruss, but I dont seem them being used.
> >>>
> >>> Is that correct?
> >>
> >> The register are really dependend of the function calling ABI of the architecture,
> >> if you check other architecture like x86 and powerpc you will see that La_i86_regs
> >> and La_ppc64_regs only saves the caller-saved ones.  It is mainly because for
> >> PLT tracking, as done by audit modules, other register are not really useful 
> >> (since they are just internal ones to the caller function).
> > 
> > I see, but isn't this register saving done in _dl_profile_resolve?
> > 
> > OpenRISC doesn't define _dl_profile_resolve.
> > 
> > I can change the definition  of La_or1k_regs, but as I see it it is currently
> > not used other than building sotruss-lib and audit modules.  But I don't see
> > how pltenter will be called without implementing _dl_profile_resolve.
> 
> The issue is the definition you set now will define the current audit ABI
> (LAV_CURRENT), which means if you eventually implement _dl_profile_resolve
> support for or1k you will need to either save/restore all registers or
> zero the non calles-saved ones.  
> 
> That's why modeling the audit PLT register structure over the ABI calling
> functions makes more sense.

Understood, that makes it clear.  I will make updates.

-Stafford

