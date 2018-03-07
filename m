From: Palmer Dabbelt <palmer@sifive.com>
Date: Wed,  7 Mar 2018 15:57:26 -0800
Subject: [OpenRISC] Make set_handle_irq and handle_arch_irq generic, v3
Message-ID: <20180307235731.22627-1-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is my third version of this patch set, but the original cover
letter is still the most relevant description I can come up with.

    This patch set has been sitting around for a while, but it got a bit lost
    in the shuffle.  In RISC-V land we currently couple do_IRQ (the C entry
    point for interrupt handling) to our first-level interrupt controller.
    While this isn't completely crazy (as the first-level interrupt controller
    is specified by the ISA), it is a bit awkward.

    This patch set decouples our trap handler from our first-level IRQ chip
    driver by copying what a handful of other architectures are doing.  This
    does add an additional load to the interrupt handling path, but there's a
    handful of performance problems in there that I've been meaning to look at
    so I don't mind adding another one for now.  The advantage is that our
    irqchip driver is decoupled from our arch port, at least at compile time.

I've build tested this with defconfigs on all the modified architectures
after both patch 1 and 5.  I've left the old acks in for the later
patches as the patch set has changed very little since I last submitted
it.

Changes since v2:

* This is now called CONFIG_GENERIC_IRQ_MULTI_HANDLER instead of
  MULTI_IRQ_HANDLER.
* Rather than converting the ARM code to generic code, this adds new
  generic code (based on the ARM implementation) and then provides
  separate patches to convert each architecture over to use
  CONFIG_GENERIC_IRQ_MULTI_HANDLER.

Changes since v1:

* I based this on arm instead of arm64, which means we guard the selection of
  these routines with CONFIG_MULTI_IRQ_HANDLER.
* The changes are in kernel/irq/handle.c and include/linux/irq.h instead of
  lib.
* I've converted the arm, arm64, and openrisc ports to use the generic versions
  of these routines.


[PATCH v3 1/5] irq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 2/5] RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 3/5] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 4/5] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 5/5] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
