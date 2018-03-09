From: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 09 Mar 2018 09:56:20 -0800 (PST)
Subject: [OpenRISC] Make set_handle_irq and handle_arch_irq generic, v3
In-Reply-To: <alpine.DEB.2.21.1803091113460.1364@nanos.tec.linutronix.de>
Message-ID: <mhng-df44504d-acc2-4ef9-9660-9959298ae26c@palmer-si-x1c4>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, 09 Mar 2018 02:20:12 PST (-0800), tglx at linutronix.de wrote:
> On Wed, 7 Mar 2018, Palmer Dabbelt wrote:
>
>> This is my third version of this patch set, but the original cover
>> letter is still the most relevant description I can come up with.
>>
>>     This patch set has been sitting around for a while, but it got a bit lost
>>     in the shuffle.  In RISC-V land we currently couple do_IRQ (the C entry
>>     point for interrupt handling) to our first-level interrupt controller.
>>     While this isn't completely crazy (as the first-level interrupt controller
>>     is specified by the ISA), it is a bit awkward.
>>
>>     This patch set decouples our trap handler from our first-level IRQ chip
>>     driver by copying what a handful of other architectures are doing.  This
>>     does add an additional load to the interrupt handling path, but there's a
>>     handful of performance problems in there that I've been meaning to look at
>>     so I don't mind adding another one for now.  The advantage is that our
>>     irqchip driver is decoupled from our arch port, at least at compile time.
>>
>> I've build tested this with defconfigs on all the modified architectures
>> after both patch 1 and 5.  I've left the old acks in for the later
>> patches as the patch set has changed very little since I last submitted
>> it.
>
> This looks sensible. We have two options for getting this merged:
>
> 1)   I'll take the whole lot through tip/irq/core
>
> 2)   I'll apply patch 1/N to a special branch in tip. That branch will contain
>      only this commit on top of 4.16-rc4 and can be pulled by the relevant
>      architecture maintainers, so they can apply their architecture specific
>      patches.

Option 1 seems like the lowest overhead, as that way we don't need to sequence
the patches between multiple trees.  If all the other arch maintianers are OK
with it then that works for me.  The 0-day robot found a new build warning on
openrisc.  I was plannning on submitting a v4 with this fix in it

    diff --git a/arch/openrisc/include/asm/irq.h b/arch/openrisc/include/asm/irq.h
    index d9eee0a2b7b4..eb612b1865d2 100644
    --- a/arch/openrisc/include/asm/irq.h
    +++ b/arch/openrisc/include/asm/irq.h
    @@ -24,6 +24,4 @@
    
     #define NO_IRQ         (-1)
    
    -extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
    -
     #endif /* __ASM_OPENRISC_IRQ_H__ */

I can submit a v4, or you can just grab it from

    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=review-irq-1-cleanup

Thanks!
