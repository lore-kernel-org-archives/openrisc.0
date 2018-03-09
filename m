From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 9 Mar 2018 11:20:12 +0100 (CET)
Subject: [OpenRISC] Make set_handle_irq and handle_arch_irq generic, v3
In-Reply-To: <20180307235731.22627-1-palmer@sifive.com>
References: <20180307235731.22627-1-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.1803091113460.1364@nanos.tec.linutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 7 Mar 2018, Palmer Dabbelt wrote:

> This is my third version of this patch set, but the original cover
> letter is still the most relevant description I can come up with.
> 
>     This patch set has been sitting around for a while, but it got a bit lost
>     in the shuffle.  In RISC-V land we currently couple do_IRQ (the C entry
>     point for interrupt handling) to our first-level interrupt controller.
>     While this isn't completely crazy (as the first-level interrupt controller
>     is specified by the ISA), it is a bit awkward.
> 
>     This patch set decouples our trap handler from our first-level IRQ chip
>     driver by copying what a handful of other architectures are doing.  This
>     does add an additional load to the interrupt handling path, but there's a
>     handful of performance problems in there that I've been meaning to look at
>     so I don't mind adding another one for now.  The advantage is that our
>     irqchip driver is decoupled from our arch port, at least at compile time.
> 
> I've build tested this with defconfigs on all the modified architectures
> after both patch 1 and 5.  I've left the old acks in for the later
> patches as the patch set has changed very little since I last submitted
> it.

This looks sensible. We have two options for getting this merged:

1)   I'll take the whole lot through tip/irq/core

2)   I'll apply patch 1/N to a special branch in tip. That branch will contain
     only this commit on top of 4.16-rc4 and can be pulled by the relevant
     architecture maintainers, so they can apply their architecture specific
     patches.

Please let me know how you want to proceed.

Thanks,

	tglx
