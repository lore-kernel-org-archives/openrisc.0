From: Rob Herring <robh@kernel.org>
Date: Thu, 26 Oct 2017 22:19:50 -0500
Subject: [OpenRISC] [PATCH v3 05/13] irqchip: add initial support for
	ompic
In-Reply-To: <20171022031600.29612-6-shorne@gmail.com>
References: <20171022031600.29612-1-shorne@gmail.com>
 <20171022031600.29612-6-shorne@gmail.com>
Message-ID: <20171027031950.wce52pj3eklsbwyj@rob-hp-laptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Oct 22, 2017 at 12:15:52PM +0900, Stafford Horne wrote:
> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> 
> IPI driver for the Open Multi-Processor Interrupt Controller (ompic) as
> described in the Multi-core support section of the OpenRISC 1.2
> proposed architecture specification:
> 
>   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> 
> Each OpenRISC core contains a full interrupt controller which is used in
> the SMP architecture for interrupt balancing.  This IPI device, the
> ompic, is the only external device required for enabling SMP on
> OpenRISC.
> 
> Pending ops are stored in a memory bit mask which can allow multiple
> pending operations to be set and serviced at a time. This is mostly
> borrowed from the alpha IPI implementation.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> 
> Changes since v2
>  - Fixed some issues with missing static
>  - Fixed spelling issue with multi-core
>  - Added back #interrupt-cells
> 
> Changes since v1
>  - Added openrisc, prefix
>  - Clarified 8 bytes per cpu
>  - Removed #interrupt-cells as this will not be an irq parent
>  - Changed ops to be percpu
>  - Added DTS and intialization failure validations
> 
> 
>  .../interrupt-controller/openrisc,ompic.txt        |  22 +++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   1 +
>  arch/openrisc/Kconfig                              |   1 +
>  drivers/irqchip/Kconfig                            |   3 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-ompic.c                        | 205 +++++++++++++++++++++
>  6 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
>  create mode 100644 drivers/irqchip/irq-ompic.c
