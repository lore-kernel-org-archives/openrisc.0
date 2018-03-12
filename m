From: Palmer Dabbelt <palmer@sifive.com>
Date: Mon, 12 Mar 2018 12:24:26 -0700 (PDT)
Subject: [OpenRISC] Make set_handle_irq and handle_arch_irq generic, v3
In-Reply-To: <alpine.DEB.2.21.1803092358120.1570@nanos.tec.linutronix.de>
Message-ID: <mhng-da14b043-f8f5-4339-879e-aa45b877fcb1@palmer-si-x1c4>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, 09 Mar 2018 15:00:56 PST (-0800), tglx at linutronix.de wrote:
> On Fri, 9 Mar 2018, Palmer Dabbelt wrote:
>> On Fri, 09 Mar 2018 02:20:12 PST (-0800), tglx at linutronix.de wrote:
>> > This looks sensible. We have two options for getting this merged:
>> >
>> > 1)   I'll take the whole lot through tip/irq/core
>> >
>> > 2)   I'll apply patch 1/N to a special branch in tip. That branch will
>> > contain
>> >      only this commit on top of 4.16-rc4 and can be pulled by the relevant
>> >      architecture maintainers, so they can apply their architecture specific
>> >      patches.
>>
>> Option 1 seems like the lowest overhead, as that way we don't need to sequence
>> the patches between multiple trees.  If all the other arch maintianers are OK
>> with it then that works for me.
>
> Ok, I wait for someone to yell NO until tuesday. If that doesn't happen I
> pick it up.
>
>> The 0-day robot found a new build warning on openrisc.  I was plannning
>> on submitting a v4 with this fix in it
>>
>>    diff --git a/arch/openrisc/include/asm/irq.h
>> b/arch/openrisc/include/asm/irq.h
>>    index d9eee0a2b7b4..eb612b1865d2 100644
>>    --- a/arch/openrisc/include/asm/irq.h
>>    +++ b/arch/openrisc/include/asm/irq.h
>>    @@ -24,6 +24,4 @@
>>        #define NO_IRQ         (-1)
>>       -extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>>    -
>>     #endif /* __ASM_OPENRISC_IRQ_H__ */
>>
>> I can submit a v4, or you can just grab it from
>
> Just reply on the v3 openrisc patch with a v4 and I grab it from there.

OK, I just did -- sorry it took a while, I had to prepare for the ELC
hackathon.
