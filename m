From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 14 Mar 2018 18:07:35 +0100 (CET)
Subject: [OpenRISC] [PATCH v3 3/5] arm: Convert to
	GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <20180307235731.22627-4-palmer@sifive.com>
References: <20180307235731.22627-1-palmer@sifive.com>
 <20180307235731.22627-4-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.1803141806580.2481@nanos.tec.linutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 7 Mar 2018, Palmer Dabbelt wrote:

> This converts the ARM port to use the recently added
> GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
> existhing MULTI_IRQ_HANDLER.  The only changes are:
> 
> * handle_arch_irq is now defined in a generic C file instead of an
>   arm-specific assembly file.
> * handle_arch_irq is not marked as __ro_after_init.

Why? What prevents the generic implementation from doing so?

Thanks,

	tglx

