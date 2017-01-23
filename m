From: Richard Henderson <rth@twiddle.net>
Date: Mon, 23 Jan 2017 10:08:47 -0800
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <20170120163918.GD7836@lianli.shorne-pla.net>
References: <20170113215720.29598-1-shorne@gmail.com>
 <20170113220252.GE25986@lianli.shorne-pla.net>
 <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
 <20170114080435.GF25986@lianli.shorne-pla.net>
 <20170120163918.GD7836@lianli.shorne-pla.net>
Message-ID: <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 01/20/2017 08:39 AM, Stafford Horne wrote:
> (+CC Rth)
> 
> I believe you also have some experience with openrisc.  Any thought on
> the below?
> 
> On Sat, Jan 14, 2017 at 05:04:35PM +0900, Stafford Horne wrote:
>> Hello,
>>
>> On Sat, Jan 14, 2017 at 12:29:32PM +0800, Jia Liu wrote:
>>> Hi all,
>>>
>>> On Sat, Jan 14, 2017 at 6:02 AM, Stafford Horne <shorne@gmail.com> wrote:
>>>> Hello,
>>>>
>>>> Sorry for the duplicate. There was an issue with my copy to qemu-devel
>>>> group.  Resent to everyone with proper cc to qemu-devel.
>>>>
>>>> Please ignore this one.
>>>>
>>>> -Stafford
>>>>
>>>> On Sat, Jan 14, 2017 at 06:57:20AM +0900, Stafford Horne wrote:
>>>>> I am working on testing instruction emulation patches for the linux
>>>>> kernel. During testing I found these 2 issues:
>>>>>
>>>>>  - sets DSX (delay slot exception) but never clears it
>>>>>  - EEAR for illegal insns should point to the bad exception (as per
>>>>>    openrisc spec) but its not
>>>>>
>>>>> This patch fixes these two issues by clearing the DSX flag when not in a
>>>>> delay slot and by setting EEAR to exception PC when handling illegal
>>>>> instruction exceptions.
>>>>>
>>>>> After this patch the openrisc kernel with latest patches boots great on
>>>>> qemu and instruction emulation works.
>>>>>
>>>>> Cc: qemu-trivial at nongnu.org
>>>>> Cc: openrisc at lists.librecores.org
>>>>> Signed-off-by: Stafford Horne <shorne@gmail.com>
>>>>> ---
>>>>>  target/openrisc/interrupt.c | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
>>>>> index 5fe3f11..e1b0142 100644
>>>>> --- a/target/openrisc/interrupt.c
>>>>> +++ b/target/openrisc/interrupt.c
>>>>> @@ -38,10 +38,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>>>>>          env->flags &= ~D_FLAG;
>>>>>          env->sr |= SR_DSX;
>>>>>          env->epcr -= 4;
>>>>> +    } else {
>>>>> +        env->sr &= ~SR_DSX;
>>>>>      }
>>>>>      if (cs->exception_index == EXCP_SYSCALL) {
>>>>>          env->epcr += 4;
>>>>>      }
>>>>> +    /* When we have an illegal instruction the error effective address
>>>>> +       shall be set to the illegal instruction address.  */
>>>>> +    if (cs->exception_index == EXCP_ILLEGAL) {
>>>>> +        env->eear = env->pc;
>>>>> +    }
>>>>>
>>>>>      /* For machine-state changed between user-mode and supervisor mode,
>>>>>         we need flush TLB when we enter&exit EXCP.  */

This patch seems sane, and I'm fine with it.  That said, I don't know what
"latest patches" means, and was not able to find a kernel version that works.

>>> +static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
>>> +{
>>> +    TCGv ea, val;
>>> +    TCGLabel *lab_fail, *lab_done;
>>> +
>>> +    ea = tcg_temp_new();
>>> +    tcg_gen_addi_tl(ea, ra, ofs);
>>> +
>>> +    lab_fail = gen_new_label();
>>> +    lab_done = gen_new_label();
>>> +    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
>>> +    tcg_temp_free(ea);
>>> +
>>> +    val = tcg_temp_new();
>>> +    tcg_gen_qemu_ld_tl(val, cpu_lock_addr, dc->mem_idx, MO_TEUL);
>>> +    tcg_gen_brcond_tl(TCG_COND_NE, val, cpu_lock_value, lab_fail);
>>> +
>>> +    tcg_gen_qemu_st_tl(rb, cpu_lock_addr, dc->mem_idx, MO_TEUL);
>>> +    tcg_gen_movi_i32(env_btaken, 0x1);
>>> +    tcg_gen_br(lab_done);
>>> +
>>> +    gen_set_label(lab_fail);
>>> +    tcg_gen_movi_i32(env_btaken, 0x0);
>>> +
>>> +    gen_set_label(lab_done);
>>> +    tcg_gen_movi_tl(cpu_lock_addr, -1);
>>> +}

This one needs to be updated to work with the atomic operations now present in
TCG.  See target/alpha/translate.c, gen_store_conditional among the many examples.


r~
