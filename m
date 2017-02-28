From: Stafford Horne <shorne@gmail.com>
Date: Tue, 28 Feb 2017 20:07:53 +0900
Subject: [OpenRISC] [PATCH v2 4/6] sim: or1k: add or1k target to sim
In-Reply-To: <20170214185208.GJ28432@vapier>
References: <cover.1484967575.git.shorne@gmail.com>
 <92c04bd768b66a48e03850af185e975d01605435.1484967575.git.shorne@gmail.com>
 <20170214185208.GJ28432@vapier>
Message-ID: <20170228110753.GY2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 14, 2017 at 01:52:08PM -0500, Mike Frysinger wrote:
> On 21 Jan 2017 12:03, Stafford Horne wrote:
> > --- /dev/null
> > +++ b/sim/or1k/Makefile.in
> >
> > +# Extra headers included by sim-main.h.
> 
> you shouldn't need to do any manual dep management.  i'd suggest
> deleting all this logic and seeing if things still work.

Hi Mike,

I have started to look into this.  Its kind of interesting, what the
original author was doing here is putting both 32 and 64 bit families in
the same sim, something that I think is not currently supported by the
cgen dep management.

If I try to general all, I rightly get:
  ERROR: app requires all selected cpu families to have same word size

Would you have a suggestion for this?

 - Should 32 and 64 bits be in separate sim_arch directories?
 - SHould we modify cgen to support handling different word sizes at the
   same time?  Like the author has done here?

At the moment I think I will work on getting the 32bit sim working
alone.

-Stafford

> > --- /dev/null
> > +++ b/sim/or1k/configure.ac
> > @@ -0,0 +1,41 @@
> > +dnl Process this file with autoconf to produce a configure script.
> > +AC_PREREQ(2.64)dnl
> > +AC_INIT(Makefile.in)
> > +sinclude(../common/acinclude.m4)
> > +
> > +  case "${target_alias}" in
> 
> drop the indentation
> 
> > +  or1k-linux*|or1knd-linux*)
> > +    traps_obj=traps32-linux.o
> > +    ;;
> > +  or1k-*|or1knd-*)
> > +    traps_obj=traps32.o
> > +    ;;
> > +  esac
> 
> we really don't like to see this kind of logic.  can't you do a single
> build and then select the right details at runtime ?
> 
> --- /dev/null
> > +++ b/sim/or1k/or1k.h
> > @@ -0,0 +1,38 @@
> > +#ifndef OR1K_H
> > +#define OR1K_H
> 
> all files should have a header with copyright & license info
> 
> also, please use namespaced defines like SIM_OR1K_H
> 
> > --- /dev/null
> > +++ b/sim/or1k/sim-if.c
> > @@ -0,0 +1,318 @@
> > +/* Main simulator entry points specific to the OR1K.
> > +   Copyright (C) 1996-1999, 2003, 2007-2012 Free Software Foundation,
> > +   Inc.
> > +   Contributed by Cygnus Support.
> 
> looks like you need to double check where you copied & pasted things from.
> cygnus isn't doing this port ;).
> 
> > +SIM_DESC
> > +sim_open (kind, callback, abfd, argv)
> > +     SIM_OPEN_KIND kind;
> > +     host_callback *callback;
> > +     struct bfd *abfd;
> > +     char * const *argv;
> 
> you need to update all your prototypes.  we don't do old style ones like
> this anymore.
> 
> > +#ifdef HAVE_DV_SOCKSER /* FIXME: was done differently before */
> > +  if (dv_sockser_install (sd) != SIM_RC_OK)
> > +    {
> > +      free_state (sd);
> > +      return 0;
> > +    }
> > +#endif
> 
> delete this.  common code handles it for you now.
> 
> > +  /* Allocate core managed memory if none specified by user.
> > +     Use address 4 here in case the user wanted address 0 unmapped.  */
> > +  if (sim_core_read_buffer (sd, NULL, read_map, &c, 4, 1) == 0) {
> > +    sim_do_commandf (sd, "memory region 0,0x%x", OR1K_DEFAULT_MEM_SIZE);
> > +  }
> 
> this isn't using GNU style for the braces/if body.  this comes up
> multiple times in this patch, so please fix them all.
> 
> > +  /* check for/establish the reference program image */
> 
> this comment isn't using GNU style.  this comes up
> multiple times in this patch, so please fix them all.
> 
> > +
> > +  for (c = 0; c < MAX_NR_PROCESSORS; ++c)
> > +    {
> > +      SIM_CPU *cpu = STATE_CPU (sd, i);
> > +      /* Only needed for profiling, but the structure member is small.  */
> > +      memset (CPU_OR1K_MISC_PROFILE (cpu), 0,
> > +	      sizeof (* CPU_OR1K_MISC_PROFILE (cpu)));
> > +
> > +#ifdef WANT_CPU_OR1K32BF
> > +      or1k32bf_h_spr_set_raw(cpu, SPR_ADDR(SYS,VR),      or1k_vr);
> > +      or1k32bf_h_spr_set_raw(cpu, SPR_ADDR(SYS,UPR),     or1k_upr);
> > +      or1k32bf_h_spr_set_raw(cpu, SPR_ADDR(SYS,CPUCFGR), or1k_cpucfgr);
> > +
> > +      or1k32bf_cpu_init (sd, cpu);
> > +#endif
> > +    }
> 
> this loop has to call these funcs:
> 	CPU_REG_FETCH
> 	CPU_REG_STORE
> 	CPU_PC_FETCH
> 	CPU_PC_STORE
> 
> > +  /* Store in a global so things like sparc32_dump_regs can be invoked
> > +     from the gdb command line.  */
> > +  current_state = sd;
> 
> you must kill current_state.  we do not allow global state anymore.
> 
> > --- /dev/null
> > +++ b/sim/or1k/sim-main.h
> >
> > +typedef IAI sim_cia;
> > +#define CIA_GET(cpu) CPU_PC_GET (cpu)
> > +#define CIA_SET(cpu,val) CPU_PC_SET ((cpu),(val))
> 
> these defines are dead -> delete
> 
> > +typedef struct _sim_cpu SIM_CPU;
> 
> delete this
> 
> > +#ifdef OR1K_LINUX
> 
> nothing defines this -> delete
> 
> > +#if (WITH_SMP)
> > +#define STATE_CPU(sd, n) ((sd)->cpu[n])
> > +#else
> > +#define STATE_CPU(sd, n) ((sd)->cpu[0])
> > +#endif
> 
> delete these -- common code does it for you now
> -mike


