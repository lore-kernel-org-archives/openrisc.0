From: Stafford Horne <shorne@gmail.com>
Date: Mon, 9 Oct 2017 22:03:05 +0900
Subject: [OpenRISC] [PATCH v5 3/6] sim: or1k: add or1k target to sim
In-Reply-To: <2a5f900c-99e7-cb4b-9211-b9dab8414de5@polymtl.ca>
References: <20171005134912.26799-1-shorne@gmail.com>
 <20171005134912.26799-4-shorne@gmail.com>
 <2a5f900c-99e7-cb4b-9211-b9dab8414de5@polymtl.ca>
Message-ID: <20171009130305.GC2958@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Oct 07, 2017 at 05:14:42PM -0400, Simon Marchi wrote:
> On 2017-10-05 09:49 AM, Stafford Horne wrote:
> > This adds the OpenRISC 32-bit sim target.  The OpenRISC sim is a CGEN
> > based sim so the bulk of the code is generated from the .cpu files by
> > CGEN.  The engine decode and execute logic in mloop uses scache with
> > pseudo-basic-block extraction and supports both full and fast (switch)
> > modes.
> > 
> > The sim does not implement an mmu at the moment.  The sim does implement
> > fpu instructions via the common sim-fpu implementation.
> > 
> > sim/ChangeLog:
> > 
> > 2017-09-13  Stafford Horne  <shorne@gmail.com>
> > 	    Peter Gavin  <pgavin@gmail.com>
> > 
> > 	* configure.tgt: Add or1k sim.
> > 	* or1k/Makefile.in: New file.
> > 	* or1k/configure.ac: New file.> 	* or1k/mloop.in: New file.
> > 	* or1k/or1k-sim.h: New file.
> > 	* or1k/or1k.c: New file.
> > 	* or1k/sim-if.c: New file.
> > 	* or1k/sim-main.h: New file.
> > 	* or1k/traps.c: New file.
> > ---
> >  sim/configure.tgt     |   4 +
> >  sim/or1k/Makefile.in  | 147 +++++++++++++++++++++
> >  sim/or1k/configure.ac |  17 +++
> >  sim/or1k/mloop.in     | 242 ++++++++++++++++++++++++++++++++++
> >  sim/or1k/or1k-sim.h   |  95 ++++++++++++++
> >  sim/or1k/or1k.c       | 355 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  sim/or1k/sim-if.c     | 281 +++++++++++++++++++++++++++++++++++++++
> >  sim/or1k/sim-main.h   |  81 ++++++++++++
> >  sim/or1k/traps.c      | 299 ++++++++++++++++++++++++++++++++++++++++++
> >  9 files changed, 1521 insertions(+)
> >  create mode 100644 sim/or1k/Makefile.in
> >  create mode 100644 sim/or1k/configure.ac
> >  create mode 100644 sim/or1k/mloop.in
> >  create mode 100644 sim/or1k/or1k-sim.h
> >  create mode 100644 sim/or1k/or1k.c
> >  create mode 100644 sim/or1k/sim-if.c
> >  create mode 100644 sim/or1k/sim-main.h
> >  create mode 100644 sim/or1k/traps.c
> > 
> > diff --git a/sim/configure.tgt b/sim/configure.tgt
> > index c958fb3174..82b0e89240 100644
> > --- a/sim/configure.tgt
> > +++ b/sim/configure.tgt
> > @@ -76,6 +76,10 @@ case "${target}" in
> >     msp430*-*-*)
> >         SIM_ARCH(msp430)
> >         ;;
> > +   or1k-*-* | or1knd-*-*)
> > +       SIM_ARCH(or1k)
> > +       sim_testsuite=yes
> 
> sim_testsuite seems like it has been removed some time ago.

Right, removed.

> > +       ;;
> >     rl78-*-*)
> >         SIM_ARCH(rl78)
> >         ;;
> > diff --git a/sim/or1k/Makefile.in b/sim/or1k/Makefile.in
> > new file mode 100644
> > index 0000000000..fdc0f01ae1
> > --- /dev/null
> > +++ b/sim/or1k/Makefile.in
> > @@ -0,0 +1,147 @@
> > +# Makefile template for configure for the or1k simulator
> > +# Copyright (C) 1996-2017 Free Software Foundation, Inc.
> 
> You used 1996 as the starting date for the copyright for all the files,
> is it right?  If your code was originally copied from existing code with
> that date, or if the code really dates from 1996, that's fine.  Otherwise,
> it should probably be 2017 or the year the work started.

It was started in the last few years, not 1996.  But I will put 2017 as the
year it finally gets commited (hopefully).

> > diff --git a/sim/or1k/or1k-sim.h b/sim/or1k/or1k-sim.h
> > new file mode 100644
> > index 0000000000..4cb6dd8b4c
> > --- /dev/null
> > +++ b/sim/or1k/or1k-sim.h
> > @@ -0,0 +1,95 @@
> > +/* OpenRISC simulator support code header
> > +   Copyright (C) 1996-2017 Free Software Foundation, Inc.
> > +
> > +   This file is part of GDB, the GNU debugger.
> > +
> > +   This program is free software; you can redistribute it and/or modify
> > +   it under the terms of the GNU General Public License as published by
> > +   the Free Software Foundation; either version 3 of the License, or
> > +   (at your option) any later version.
> > +
> > +   This program is distributed in the hope that it will be useful,
> > +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +   GNU General Public License for more details.
> > +
> > +   You should have received a copy of the GNU General Public License
> > +   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef OR1K_SIM_H
> > +#define OR1K_SIM_H
> > +
> > +#include "symcat.h"
> > +
> > +/* GDB register numbers.  */
> > +#define PPC_REGNUM	32
> > +#define PC_REGNUM	33
> > +#define SR_REGNUM	34
> > +
> > +/* Misc. profile data.  */
> > +typedef struct
> > +{
> > +} OR1K_MISC_PROFILE;
> > +
> > +/* Nop codes used in nop simulation.  */
> > +#define NOP_NOP         0x0
> > +#define NOP_EXIT        0x1
> > +#define NOP_REPORT      0x2
> > +#define NOP_PUTC        0x4
> > +#define NOP_CNT_RESET   0x5
> > +#define NOP_GET_TICKS   0x6
> > +#define NOP_GET_PS      0x7
> > +#define NOP_TRACE_ON    0x8
> > +#define NOP_TRACE_OFF   0x9
> > +#define NOP_RANDOM      0xa
> > +#define NOP_OR1KSIM     0xb
> > +#define NOP_EXIT_SILENT 0xc
> > +
> > +#define NUM_SPR 0x20000
> > +#define SPR_GROUP_SHIFT 11
> > +#define SPR_GROUP_FIRST(group) (((UWI) SPR_GROUP_##group) << SPR_GROUP_SHIFT)
> > +#define SPR_ADDR(group,index) (SPR_GROUP_FIRST(group) | ((UWI) SPR_INDEX_##group##_##index))
> 
> Unless sim/ has some special rule allowing things to overflow 80 columns, these
> lines will have to be wrapped.

OK

> > +
> > +/* Define word getters and setter helpers based on those from sim/common/cgen-mem.h.  */
> > +#define GETTWI GETTSI
> > +#define SETTWI SETTSI
> > +
> > +void or1k_cpu_init (SIM_DESC sd, sim_cpu * current_cpu, const USI or1k_vr,
> 
> Throughout, there are spurious after * in types.

OK, there are a few cases `char * const *argv, char * const *envp)` which
look strange, but I see other examples with similar format.  I would
usually do 'const char **argv` but is the before-mentioned ok?

> > +#define CHECK_SPR_FIELD(GROUP, INDEX, FIELD, test)                      \
> > +  do {                                                                  \
> > +    USI field = GET_H_##SYS##_##INDEX##_##FIELD ();                     \
> > +    if (!(test)) {                                                      \
> > +      sim_io_eprintf(sd, "WARNING: unsupported %s field in %s register: 0x%x\n", \
> 
> 80 columns.

OK, also noted the other issues like 'do {' should have '{' on the next
line.

> > +                     #FIELD, #INDEX, field);                            \
> > +    }                                                                   \
> > +  } while (0)
> > +
> > +  /* Set flags indicating if we are in a delay slot or not.  */
> > +  current_cpu->next_delay_slot = 0;
> > +  current_cpu->delay_slot = 0;> > +
> > +  /* Verify any user passed fields and warn on configurations we don't
> > +     support.  */
> > +  CHECK_SPR_FIELD (SYS, UPR, UP, field == 1);
> > +  CHECK_SPR_FIELD (SYS, UPR, DCP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, ICP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, DMP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, MP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, IMP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, DUP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, PCUP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, PICP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, PMP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, TTP, field == 0);
> > +  CHECK_SPR_FIELD (SYS, UPR, CUP, field == 0);
> > +
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, NSGR, field == 0);
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, CGF, field == 0);
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, OB32S, field == 1);
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, OF32S, field == 1);
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, OB64S, field == 0);
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, OF64S, field == 0);
> > +  CHECK_SPR_FIELD (SYS, CPUCFGR, OV64S, field == 0);
> > +
> > +#undef CHECK_SPR_FIELD
> > +
> > +  /* Configure the fpu operations and mark fpu available.  */
> > +  cgen_init_accurate_fpu (current_cpu, CGEN_CPU_FPU (current_cpu),
> > +			  or1k32bf_fpu_error);
> > +  SET_H_SYS_CPUCFGR_OF32S (1);
> > +
> > +  /* Set the UPR[UP] flag, even if the user tried to unset it, as we always
> > +     support the Unit Present Register.  */
> > +  SET_H_SYS_UPR_UP (1);
> > +
> > +  /* Set the supervisor register to indicate we are in suprevisor mode and
> 
> "suprevisor"

OK.

> > +/* Build an address value used for load and store instructions.  For
> > +   example, the instruction 'l.lws rD, I(rA)' will require to load data
> > +   from the 4 byte address represented by rA + I.  Here the argument base
> > +   is rA, offset is I and the size is the address size in bytes.  */
> > +
> > +USI
> > +or1k32bf_make_load_store_addr (sim_cpu * current_cpu, USI base, SI offset,
> > +			       int size)
> > +{
> > +  SIM_DESC sd = CPU_STATE (current_cpu);
> > +
> > +  USI addr = base + offset;
> > +
> > +  if (GET_H_SYS_SR_LEE ())
> > +    {
> > +      switch (size)
> > +	{
> > +
> > +	case 4:
> > +	  break;
> > +
> > +	case 2:
> > +	  addr ^= 0x2;
> > +	  break;
> > +
> > +	case 1:
> > +	  addr ^= 0x3;
> > +	  break;
> > +
> > +	default:
> > +	  SIM_ASSERT (0);
> > +	  return 0;
> > +	}
> > +    }
> 
> That code looks strange to me.  Enabling byte reordering (SR[LEE]) makes it so that each
> group of 4 bytes appears swapped in memory?  Is this something a program can turn on/off
> at any time?  There isn't much detail about that in the spec it seems.

I have added some more comments to this in the next patch series.  I am not
to sure as to the 'why' for this functionality.  But I assume its probably
to interact with hardware like graphics cards which only support
little-endian addressing.  The SR[LEE] would only be available to change in
supervisor mode, so not just any program could change it.

The above code only handles the address translation (note for half-word
access openrisc requires the address to be half-word aligned).

> > +/* Implement the OpenRISC exception function.  This is mostly used by the
> > +   CGEN generated files.  For example, this is used when handling a
> > +   overflow exception during a multiplication instruction. */
> > +
> > +void
> > +or1k32bf_exception (sim_cpu * current_cpu, USI pc, USI exnum)
> > +{
> > +  SIM_DESC sd = CPU_STATE (current_cpu);
> > +
> > +  if (exnum == EXCEPT_TRAP)
> > +    {
> > +      /* Trap, used for breakpoints, sends control back to gdb breakpoint
> > +	 handling.  */
> > +      sim_engine_halt (sd, current_cpu, NULL, pc, sim_stopped, SIM_SIGTRAP);
> > +    }
> > +  else
> > +    {
> > +
> > +      /* Calculate the exception program counter.  */
> > +      switch (exnum)
> > +	{
> > +	case EXCEPT_RESET:
> > +	  break;
> > +
> > +	case EXCEPT_FPE:
> > +	case EXCEPT_SYSCALL:
> > +	  SET_H_SYS_EPCR0 (pc + 4 - (current_cpu->delay_slot ? 4 : 0));
> > +	  break;
> > +
> > +	case EXCEPT_BUSERR:
> > +	case EXCEPT_ALIGN:
> > +	case EXCEPT_ILLEGAL:
> > +	case EXCEPT_RANGE:
> > +	  SET_H_SYS_EPCR0 (pc - (current_cpu->delay_slot ? 4 : 0));
> > +	  break;
> > +
> > +	default:
> > +	  sim_io_error (sd, "unexpected exception 0x%x raised at PC 0x%08x",
> > +			exnum, pc);
> > +	  break;
> > +	}
> > +
> > +      /* Store the curent SR into ESR0.  */
> 
> "curent"
>

OK.

FYI, also the testsuite patch aas a few long lines like:

	/* The sign extension produces unexpected results here.  */
	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFFFFFF - 1, 0xFFFF  /* 0xFFFF gets sign-extended to 0xFFFFFFFF.  */
	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFF7FFF, 0x8000  /* 0x8000 gets sign-extended to 0xFFFF8000.  */

I guess it should be like this?  I don't mind the inline comments, but I
guess convention is convention?

	/* 0xFFFF gets sign-extended to 0xFFFFFFFF.  */
	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFFFFFF - 1, 0xFFFF
	/* 0x8000 gets sign-extended to 0xFFFF8000.  */
	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFF7FFF, 0x8000

Thank you,

Stafford
