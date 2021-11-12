From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 07:59:39 +0900
Subject: [OpenRISC] [RFC PATCH] or1k: Fix clobbering of _mcount argument
 if fPIC is enabled
In-Reply-To: <20211109121308.583835-1-shorne@gmail.com>
References: <20211109121308.583835-1-shorne@gmail.com>
Message-ID: <YY7x2yEgOHAjPsD1@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I have committed this as is.

-Stafford

On Tue, Nov 09, 2021 at 09:13:08PM +0900, Stafford Horne wrote:
> Recently we changed the PROFILE_HOOK _mcount call to pass in the link
> register as an argument.  This actually does not work when the _mcount
> call uses a PLT because the GOT register setup code ends up getting
> inserted before the PROFILE_HOOK and clobbers the link register
> argument.
> 
> These glibc tests are failing:
>   gmon/tst-gmon-pie-gprof
>   gmon/tst-gmon-static-gprof
> 
> This patch fixes this by saving the instruction that stores the Link
> Register to the _mcount argument and then inserts the GOT register setup
> instructions after that.
> 
> For example:
> 
> main.c:
> 
>     extern int e;
> 
>     int f2(int a) {
>       return a + e;
>     }
> 
>     int f1(int a) {
>       return f2 (a + a);
>     }
> 
>     int main(int argc, char ** argv) {
>       return f1 (argc);
>     }
> 
> Compiled:
> 
>     or1k-smh-linux-gnu-gcc -Wall -c -O2 -fPIC -pg -S main.c
> 
> Before Fix:
> 
>     main:
>         l.addi  r1, r1, -16
>         l.sw    8(r1), r2
>         l.sw    0(r1), r16
>         l.addi  r2, r1, 16   # Keeping FP, but not needed
>         l.sw    4(r1), r18
>         l.sw    12(r1), r9
>         l.jal   8            # GOT Setup clobbers r9 (Link Register)
>          l.movhi        r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
>         l.ori   r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
>         l.add   r16, r16, r9
>         l.or    r18, r3, r3
>         l.or    r3, r9, r9    # This is not the original LR
>         l.jal   plt(_mcount)
>          l.nop
> 
>         l.jal   plt(f1)
>          l.or    r3, r18, r18
>         l.lwz   r9, 12(r1)
>         l.lwz   r16, 0(r1)
>         l.lwz   r18, 4(r1)
>         l.lwz   r2, 8(r1)
>         l.jr    r9
>          l.addi  r1, r1, 16
> 
> After the fix:
> 
>     main:
>         l.addi  r1, r1, -12
>         l.sw    0(r1), r16
>         l.sw    4(r1), r18
>         l.sw    8(r1), r9
>         l.or    r18, r3, r3
>         l.or    r3, r9, r9    # We now have r9 (LR) set early
>         l.jal   8             # Clobbers r9 (Link Register)
>          l.movhi        r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
>         l.ori   r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
>         l.add   r16, r16, r9
>         l.jal   plt(_mcount)
>          l.nop
> 
>         l.jal   plt(f1)
>          l.or    r3, r18, r18
>         l.lwz   r9, 8(r1)
>         l.lwz   r16, 0(r1)
>         l.lwz   r18, 4(r1)
>         l.jr    r9
>          l.addi  r1, r1, 12
> 
> Fixes: 308531d148a ("or1k: Add return address argument to _mcount call")
> 
> gcc/ChangeLog:
> 	* config/or1k/or1k-protos.h (or1k_profile_hook): New function.
> 	* config/or1k/or1k.h (PROFILE_HOOK): Change macro to reference
> 	new function or1k_profile_hook.
> 	* config/or1k/or1k.c (struct machine_function): Add new field
> 	set_mcount_arg_insn.
> 	(or1k_profile_hook): New function.
> 	(or1k_init_pic_reg): Update to inject pic rtx after _mcount arg
> 	when profiling.
> 	(or1k_frame_pointer_required): Frame pointer no longer needed
> 	when profiling.
> ---
> I am sending this as RFC as I think there should be a better way to handle
> this but I am not sure how that would be.
> 
> An earlier patch I tried was to store the link register to a temporary register
> then pass the temporary register as an argument to _mcount, however
> optimizations caused the link register to still get clobbered.
> 
> Any thoughts will be helpful.
> 
> -Stafford
> 
>  gcc/config/or1k/or1k-protos.h |  1 +
>  gcc/config/or1k/or1k.c        | 49 ++++++++++++++++++++++++++++-------
>  gcc/config/or1k/or1k.h        |  8 +-----
>  3 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/gcc/config/or1k/or1k-protos.h b/gcc/config/or1k/or1k-protos.h
> index bbb54c8f790..56554f2937f 100644
> --- a/gcc/config/or1k/or1k-protos.h
> +++ b/gcc/config/or1k/or1k-protos.h
> @@ -20,6 +20,7 @@ along with GCC; see the file COPYING3.  If not see
>  extern HOST_WIDE_INT or1k_initial_elimination_offset (int, int);
>  extern void or1k_expand_prologue (void);
>  extern void or1k_expand_epilogue (void);
> +extern void or1k_profile_hook (void);
>  extern void or1k_expand_eh_return (rtx);
>  extern rtx  or1k_initial_frame_addr (void);
>  extern rtx  or1k_dynamic_chain_addr (rtx);
> diff --git a/gcc/config/or1k/or1k.c b/gcc/config/or1k/or1k.c
> index e772a7addea..335c4c5decf 100644
> --- a/gcc/config/or1k/or1k.c
> +++ b/gcc/config/or1k/or1k.c
> @@ -73,6 +73,10 @@ struct GTY(()) machine_function
>  
>    /* Remember where the set_got_placeholder is located.  */
>    rtx_insn *set_got_insn;
> +
> +  /* Remember where mcount args are stored so we can insert set_got_insn
> +     after.  */
> +  rtx_insn *set_mcount_arg_insn;
>  };
>  
>  /* Zero initialization is OK for all current fields.  */
> @@ -415,6 +419,25 @@ or1k_expand_epilogue (void)
>  			   EH_RETURN_STACKADJ_RTX));
>  }
>  
> +/* Worker for PROFILE_HOOK.
> +   The OpenRISC profile hook uses the link register which will get clobbered by
> +   the GOT setup RTX.  This sets up a placeholder to allow injecting of the GOT
> +   setup RTX to avoid clobbering.  */
> +
> +void
> +or1k_profile_hook (void)
> +{
> +  rtx a1 = gen_rtx_REG (Pmode, 3);
> +  rtx ra = get_hard_reg_initial_val (Pmode, LR_REGNUM);
> +  rtx fun = gen_rtx_SYMBOL_REF (Pmode, "_mcount");
> +
> +  /* Keep track of where we setup the _mcount argument so we can insert the
> +     GOT setup RTX after it.  */
> +  cfun->machine->set_mcount_arg_insn = emit_move_insn (a1, ra);
> +
> +  emit_library_call (fun, LCT_NORMAL, VOIDmode, a1, Pmode);
> +}
> +
>  /* Worker for TARGET_INIT_PIC_REG.
>     Initialize the cfun->machine->set_got_insn rtx and insert it at the entry
>     of the current function.  The rtx is just a temporary placeholder for
> @@ -423,17 +446,25 @@ or1k_expand_epilogue (void)
>  static void
>  or1k_init_pic_reg (void)
>  {
> -  start_sequence ();
>  
> -  cfun->machine->set_got_insn
> -    = emit_insn (gen_set_got_tmp (pic_offset_table_rtx));
> +  if (crtl->profile)
> +    cfun->machine->set_got_insn =
> +      emit_insn_after (gen_set_got_tmp (pic_offset_table_rtx),
> +		       cfun->machine->set_mcount_arg_insn);
> +  else
> +    {
> +      start_sequence ();
> +
> +      cfun->machine->set_got_insn =
> +	emit_insn (gen_set_got_tmp (pic_offset_table_rtx));
>  
> -  rtx_insn *seq = get_insns ();
> -  end_sequence ();
> +      rtx_insn *seq = get_insns ();
> +      end_sequence ();
>  
> -  edge entry_edge = single_succ_edge (ENTRY_BLOCK_PTR_FOR_FN (cfun));
> -  insert_insn_on_edge (seq, entry_edge);
> -  commit_one_edge_insertion (entry_edge);
> +      edge entry_edge = single_succ_edge (ENTRY_BLOCK_PTR_FOR_FN (cfun));
> +      insert_insn_on_edge (seq, entry_edge);
> +      commit_one_edge_insertion (entry_edge);
> +    }
>  }
>  
>  #undef TARGET_INIT_PIC_REG
> @@ -480,7 +511,7 @@ or1k_frame_pointer_required ()
>  {
>    /* ??? While IRA checks accesses_prior_frames, reload does not.
>       We do want the frame pointer for this case.  */
> -  return (crtl->accesses_prior_frames || crtl->profile);
> +  return (crtl->accesses_prior_frames);
>  }
>  
>  /* Expand the "eh_return" pattern.
> diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
> index 4603cb67160..ce0a47dfa66 100644
> --- a/gcc/config/or1k/or1k.h
> +++ b/gcc/config/or1k/or1k.h
> @@ -385,13 +385,7 @@ do {                                                    \
>  
>  /* Emit rtl for profiling.  Output assembler code to call "_mcount" for
>     profiling a function entry.  */
> -#define PROFILE_HOOK(LABEL)						\
> -  {									\
> -    rtx fun, ra;							\
> -    ra = get_hard_reg_initial_val (Pmode, LR_REGNUM);			\
> -    fun = gen_rtx_SYMBOL_REF (Pmode, "_mcount");			\
> -    emit_library_call (fun, LCT_NORMAL, VOIDmode, ra, Pmode);		\
> -  }
> +#define PROFILE_HOOK(LABEL)  or1k_profile_hook()
>  
>  /* All the work is done in PROFILE_HOOK, but this is still required.  */
>  #define FUNCTION_PROFILER(STREAM, LABELNO) do { } while (0)
> -- 
> 2.31.1
> 
