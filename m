From: Stafford Horne <shorne@gmail.com>
Date: Wed, 30 Nov 2016 19:30:26 +0900 (JST)
Subject: [OpenRISC] [PATCH v2 2/4] gdb: Add OpenRISC or1k and or1knd
 target support (fwd)
In-Reply-To: <b73227fd-e2a6-15d7-c39d-e89d48480b09@embecosm.com>
References: <alpine.LFD.2.20.1611292334190.29569@lianli.shorne-pla.net>
 <b73227fd-e2a6-15d7-c39d-e89d48480b09@embecosm.com>
Message-ID: <alpine.LFD.2.20.1611301223050.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

Forwarding this to the list again.  My previous attempts the message was
way too large (80K+) to make it past the maillist size filters (max 40K).

I removed some parts of the patch to make it though.

On Tue, 29 Nov 2016, Jeremy Bennett wrote:

> On 29/11/16 14:53, Stafford Horne wrote:
>>
>> Hi Jeremy,
>>
>> You have probably seen the below. I am wondering if you have any
>> concerns with some of the suggestions. Specifically:
>>
>> * Removing copyright Embecosm Limited and changing to Contributed
>> by Embecosm Limited.
>
> Hi Stafford,
>
> This is no problem. We have corporate FSF approvals in place. Just
> change it to contributed by Jeremy Bennett <jeremy.bennett@embecosm.com>
>
>> * Franck doesn't have copyright assignment, he mentioned you might
>> push the code on his behalf. Since I am pushing the code now what
>> do you think?
>
> Franck needs to send me an email stating that a) he wishes to assign
> his copyright to Embecosm Limited on condition we immediately assign
> it to the FSF and b) he has the authority to make such an assignment
> of copyright. I'll reply accepting the copyright assignment under
> these terms. That gives a legally valid audit trail, since Franck's
> work is owned by us and we have the right to contribute code.
>
> At that point Embecosm can accept the code from Franck and immediately
> assign it to FSF. It probably is safest to use "contributed by Franck
> Julien <email addr> on behalf of Embecosm Limited", but check Franck
> is happy with that. Otherwise someone may quibble about him not being
> on the list.
>
>> The freedback in general is great I think. I have started to clean
>> up several things. But it will take time.
>
> You should think about getting your own FSF approval in place, so you
> can do the final submission.
>
> I'm a bit surprised about the code formatting being wrong, unless it
> is a complaint about commenting. It would be worth checking that this
> is all Yao Qi is concerned about.
>
> My work was used for a tutorial application note, and had detailed
> Doxygen style formatting surrounded by comment lines
> /*---------------------*/. You'll need to strip these down to GNU format.
>
> This is a pain in the neck, because it means the comments will have to
> be moved into and maintained in the tutorial, which has been available
> for years on the GDB wiki. However the fight over inline documentation
> has been going on for years (the GPL and GFDL are not compatible), and
> this submission is not the place for that fight.
>
> You may find the indent tool on Linux useful in auto formatting to GNU
> style.
>
> I'll ask Andrew Burgess to keep an eye out for your postings to review
> them.
>
> Best wishes,
>
>
> Jeremy
>
>> -Stafford
>>
>> ---------- Forwarded message ---------- Date: Tue, 29 Nov 2016
>> 19:06:03 From: Yao Qi <qiyaoltc@gmail.com> To: Stafford Horne
>> <shorne@gmail.com> Cc: gdb-patches at sourceware.org,
>> openrisc at lists.librecores.org, Franck Jullien
>> <franck.jullien@gmail.com> Subject: Re: [PATCH v2 2/4] gdb: Add
>> OpenRISC or1k and or1knd target support
>>
>> On Sun, Nov 27, 2016 at 03:16:44PM +0900, Stafford Horne wrote:
>>> From: Franck Jullien <franck.jullien@gmail.com>
>>>
>>> This patch prepates the current GDB port of the openrisc
>>> processor from https://github.com/openrisc/binutils-gdb for
>>> upstream merging.
>>>
>>> Testing has been done with a cgen sim provided in a separate
>>> patch. This has been tested with 2 toolchains. GCC [1] 5.4.0 from
>>> the openrisc project with Newlib [2] and GCC 5.4.0 with Musl [3]
>>> 1.1.4.
>>>
>>> It supports or1knd (no delay slot target). The default target is
>>> or1k (with delay slot).
>>>
>>> You can change the target arch with:
>>>
>>> (gdb) set architecture or1knd The target architecture is assumed
>>> to be or1knd
>>>
>>> [1] https://github.com/openrisc/or1k-gcc [2]
>>> https://github.com/openrisc/newlib [3]
>>> https://github.com/openrisc/musl-cross
>>
>> Hi Stafford, The code style in or1k-tdep.{c,h} is completely
>> different from GNU coding standard.  Take a look at
>> https://sourceware.org/gdb/wiki/ContributionChecklist and please
>> also reference other new added ports about code style, like
>> nios2-tdep.c.
>>
>>>
>>> gdb/doc/ChangeLog:
>>>
>>> 2016-03-13  Stefan Wallentowitz  <stefan@wallentowitz.de>
>>>
>>> * gdb.texinfo (Embedded Processors): Add openrisc to suppress
>>> error.
>>>
>>> 2013-01-31  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> * gdb.texinfo: Add / merge OpenRISC documentation from old svn.
>>>
>>> 2008-08-13  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>>
>>> * gdb.texinfo: Sections relating to OpenRISC 1000 rewritten
>>>
>>> gdb/ChangeLog:
>>>
>>> 2016-11-23  Stafford Horne  <shorne@gmail.com>
>>>
>>> Updates after Yao Qi's breakpoint refactor. * or1k-tdep.c
>>> (or1k_breakpoint_kind_from_pc): New function.
>>> (or1k_sw_breakpoint_from_kind): New function.
>>> (or1k_breakpoint_from_pc): Remove. (or1k_gdbarch_init): Use new
>>> functions.
>>>
>>> 2016-11-23  Stafford Horne  <shorne@gmail.com>
>>>
>>> Corelow is no longer needed for or1k as its in by default. *
>>> configure.tgt: Remove corelow.o for or1k linux.
>>>
>>> 2016-11-16  Stafford Horne  <shorne@gmail.com>
>>>
>>> Updates after rebase to upstream master. * or1k-tdep.c
>>> (or1k_fetch_instruction): Dont pass status directly to
>>> memory_error as they are different types.
>>> (or1k_pseudo_register_read): Return proper typed REG_UNKNOWN.
>>> (or1k_frame_cache): Cast result to trad_frame_cache.
>>> (or1k_gdbarch_init): Init gdbarch_tdep with XNEW.
>>>
>>> 2016-05-22  Stafford Horne  <shorne@gmail.com>
>>>
>>> Upstream merge fixes. * or1k-tdep.c (or1k_return_value): Fix
>>> return conventions handling of arrays and literals to match gcc.
>>> (or1k_push_dummy_call): Properly handle vararg dummy args by
>>> pushing a pointer to args as per conventions.
>>>
>>> 2016-03-13  Stefan Wallentowitz  <stefan@wallentowitz.de>
>>>
>>> Upstream merge fixes. * or1k-tdep.c (or1k_analyse_inst): Change
>>> fatal to throw_quit. (or1k_skip_prologue): Use SYMTAB_COMPUNIT
>>> and COMPUNIT_DEBUGFORMAT. (or1k_frame_cache): Change fatal to
>>> throw_quit. (or1k_regset_from_core_section): Remove.
>>> (or1k_iterate_over_regset_sections): Create, blank
>>> implementation.
>>>
>>> 2013-10-01  Stefan Kristiansson
>>> <stefan.kristiansson@saunalahti.fi>
>>>
>>> Upstream merge fixes. * or1k-tdep.c (or1k_fetch_instruction):
>>> Change char to gdb_byte to prevent pointer signedness error.
>>> (or1k_push_dummy_code): Likewise.
>>>
>>> 2013-03-15  Stefan Kristiansson
>>> <stefan.kristiansson@saunalahti.fi>
>>>
>>> * or1k-tdep.c (or1k_regset_firom_core_section) : Silence gcc
>>> warning by using %z format for size_t.
>>>
>>> 2013-02-22  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> * or1k-tdep.c (or1k_push_dummy_code) : Use or1k_frame_align to
>>> align the stack pointer.
>>>
>>> 2013-02-17  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> Add target descriptor support. * or1k-tdep.c
>>> (or1k_register_name): Conditionally pull register names from
>>> tdesc_register_name if we can. (or1k_registers_info): Fetch
>>> register via target_fetch_registers if it is not cached.
>>> (or1k_register_reggroup_p): Check register groups in target
>>> descriptor before falling back to default reg groups.
>>> (create_register_group): New Function. (get_feature_registers):
>>> New Function. (or1k_gdbarch_init): Init the register details from
>>> target_desc. (_initialize_or1k_tdep): Tell remote we support
>>> target description xml.
>>>
>>> 2013-02-16  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> * or1k-tdep.c: Use OR1K_NUM_REGS_CACHED. * or1k-tdep.h: Add
>>> OR1K_NUM_REGS_CACHED. Add OR1K_MAX_SPR_REGS.
>>>
>>> 2013-02-14  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> * or1k-tdep.c (or1k_push_dummy_code): New function.
>>> (or1k_gdbarch_init): Override default behavior and call dummy
>>> from the stack. Set the push_dummy_code handler to
>>> or1k_push_dummy_code.
>>>
>>> 2013-02-13  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> * or1k-tdep.c (or1k_skip_prologue): Add a check for NULL pointer
>>> while comparing debugformat to "dwarf".
>>>
>>> 2013-01-31  Franck Jullien  <franck.jullien@gmail.com>
>>>
>>> * or1k-tdesc.c  : Add file for or1k support from old svn *
>>> or1k-tdesc.h  : Add file for or1k support from old svn *
>>> configure.tgt : Add or1k targets from old svn
>>>
>>> 2010-06-30  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>>
>>> * or1k-tdep.c (or1k_fetch_instruction): Logic flow made clearer.
>>> (or1k_analyse_inst, or1k_analyse_L_addi) (or1k_analyse_l_sw):
>>> Added. (or1k_frame_size, or1k_frame_fp_loc,
>>> or1k_frame_size_check) (or1k_link_address, or1k_get_saved_reg):
>>> Removed. (or1k_skip_prologue, or1k_frame_unwind_cache): Rewritten
>>> to use or1k_analyse_inst functions. * or1k_tdep.h
>>> <OR1K_FIRST_SAVED_REGNUM, OR1K_INSTBITLEN>: #define added.
>>>
>>> 2008-11-08  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>>
>>> * or1k-tdep.c (or1k_read_spr, or1k_write_spr): Moved here from
>>> remote-or1k.c and made local to this file. Rewritten to use
>>> commands via the target remote command (to_rcmd) function. *
>>> or1k-tdep.c (or1k_spr_command). Invalidates register cache when
>>> SPR is written. * or1k-tdep.h: or1k_read_spr and Or1k_write_spr
>>> are removed as global functions. * or1k-tdep.c (or1k_read_spr,
>>> or1k_write_spr). Functions removed and made local to or1k-tdep.c.
>>> All or1k-tdep.c references to these functions changed to use
>>> or1k_jtag_read_spr and or1k_jtag_write_spr (for which these were
>>> only wrappers). * or1k-tdep.c (or1k_rcmd): Function added to
>>> process SPR access requests.
>>>
>>> 2008-10-23  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>>
>>> * or1k-tdep.h, or1k-tdep.c: Extend the number of registers to
>>> include the PPC as well as the NPC
>>>
>>> 2008-07-30  Jeremy Bennett  <jeremy.bennett@embecosm.com>
>>>
>>> * or1k-tdep.c: New file, based on the OpenCores 5.3 port *
>>> or1k-tdep.h: New file, based on the OpenCores 5.3 port *
>>> configure.tgt: Updated description of OpenRISC 1000 files
>>
>> Please merge all ChangeLog entries into one, but with all
>> contributors listed as author.
>>
>>>
>>> +or1k-*-linux*) +    # Target: OpenCores OpenRISC 1000 32-bit
>>> implementation for Linux +    gdb_target_obs="or1k-tdep.o" +
>>> gdb_sim=../sim/or1k/libsim.a +    build_gdbserver=yes +    ;;
>>
>> build_gdbserver=no?  We don't have OpenRISC GDBserver yet.
>> Secondly, we don't have or1k-linux-tdep.c, so I don't think
>> or1k-*-linux target is supported.  Let us remove it...
>>
>>> + +or1k-*-*) +    # Target: OpenCores OpenRISC 1000 32-bit
>>> implementation bare metal +    gdb_target_obs="or1k-tdep.o" +
>>> gdb_sim=../sim/or1k/libsim.a +    ;; + +or1knd-*-linux*) +    #
>>> Target: OpenCores OpenRISC 1000 32-bit implementation for Linux,
>>> without delay slot +    gdb_target_obs="or1k-tdep.o" +
>>> gdb_sim=../sim/or1k/libsim.a +    build_gdbserver=yes +    ;;
>>
>> Likewise, let us remove it.
>>
>>> diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c new file mode
>>> 100644 index 0000000..3592ac9 --- /dev/null +++
>>> b/gdb/or1k-tdep.c @@ -0,0 +1,3285 @@ +/* Target-dependent code
>>> for the 32-bit OpenRISC 1000, for the GNU Debugger. + +
>>> Copyright 1988-2008, Free Software Foundation, Inc. +   Copyright
>>> (C) 2008, 2010 Embecosm Limited
>>
>> If the patch is contributed to FSF project, FSF should be the
>> copyright owner.  All the contributors should agree on this.
>>
>>> + +   Contributed by Alessandro Forin(af at cs.cmu.edu at CMU +
>>> and by Per Bothner(bothner at cs.wisc.edu) at U.Wisconsin. + +
>>> Contributor Jeremy Bennett <jeremy.bennett@embecosm.com> + +
>>> Contributor Franck Jullien <elec4fun@gmail.com> +
>>
>> Franck doesn't have FSF copyright assignment.
>>
>>> +/*-----------------------------------------------------------------------------
>>>
>>>
>>>
> +   This version for the OpenRISC 1000 architecture is a rewrite by
>>> Jeremy +   Bennett of the old GDB 5.3 interface to make use of
>>> gdbarch for GDB 6.8. It +   has since been updated for GDB 7.2
>>> and GDB 7.5.
>>
>> Once we add or1k-tdep.c into GDB mainline, these notes are not
>> useful anymore.
>>
>>> + +   The code tries to follow the GDB coding style. + +
>>> Commenting is Doxygen compatible.
>>
>> We don't write comments in Doxygen style.
>>
>>> + +   Notes on the GDB 7.5 version +
>>> ============================ + +   This version is just an
>>> upgrade of the previous port. It does use CGEN +   for

*** SNIP ***

>>> new debug +   interface does not support hardware trace, so there
>>> is no plan to reinstate +   this functionality. + +   Support for
>>> multiple contexts (which was rudimentary, and not working) has +
>>> been removed.*/
>>> +/*---------------------------------------------------------------------------*/
>>>
>>>
>>>
> +
>>
>> These comments/notes are not useful.  Please remove it.
>>
>>> + + +/* Enum describing different kinds of breakpoints for or1k
>>> */ + +enum or1k_breakpoint_kind +{ +  /* 32-bit standard OpenRISC
>>> breakpoint */ +  OR1K_BP_KIND_OR1K = 2, +}; + +/* The
>>> gdbarch_tdep structure.  */ + +/*! OR1K specific per-architecture
>>> information. Replaces +    struct_or1k_implementation. A lot of
>>> this info comes from the config regs, +    so cannot be put in
>>> place until we have the actual target. Up until then +    we have
>>> reasonable defaults. */ +struct gdbarch_tdep +{ +  unsigned int
>>> num_matchpoints;    /* Total matchpoints available. */
>>
>> num_matchpoints is not used in this patch.  Can we remove it?
>>
>>> +  unsigned int  num_gpr_regs;        /* Number of general
>>> registers.  */
>>
>> It is an invariant, OR1K_MAX_GPR_REGS.  We can use the macro
>> directly.
>>

*** SNIP ***

-Stafford

