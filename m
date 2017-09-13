From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 13 Sep 2017 18:21:39 +0100
Subject: [OpenRISC] [PATCH v2 06/14] irqchip: add initial support for
	ompic
In-Reply-To: <20170910064926.5874-7-shorne@gmail.com> (Stafford Horne's
 message of "Sun, 10 Sep 2017 15:49:18 +0900")
References: <20170910064926.5874-1-shorne@gmail.com>
 <20170910064926.5874-7-shorne@gmail.com>
Message-ID: <86h8w6see4.fsf@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Sep 10 2017 at  3:49:18 pm BST, Stafford Horne <shorne@gmail.com> wrote:
> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>
> IPI driver for the Open Multi-Processor Interrupt Controller (ompic) as
> described in the Multicore support section of the OpenRISC 1.2
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
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>
> Changes since v1
>  - Added openrisc, prefix
>  - Clarified 8 bytes per cpu
>  - Removed #interrupt-cells as this will not be an irq parent
>  - Changed ops to be percpu
>  - Added DTS and intialization failure validations
>
>  .../interrupt-controller/openrisc,ompic.txt        |  19 ++
>  arch/openrisc/Kconfig                              |   1 +
>  drivers/irqchip/Kconfig                            |   3 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-ompic.c                        | 205 +++++++++++++++++++++
>  5 files changed, 229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
>  create mode 100644 drivers/irqchip/irq-ompic.c
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt b/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> new file mode 100644
> index 000000000000..346e6042d62f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> @@ -0,0 +1,19 @@
> +Open Multi-Processor Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : This should be "openrisc,ompic"
> +- reg : Specifies base physical address and size of the register space. The
> +  size is based on the number of cores the controller has been configured
> +  to handle, this should be set to 8 bytes per cpu core.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- interrupts : Specifies the interrupt line to which the ompic is wired.
> +
> +Example:
> +
> +ompic: ompic {
> +	compatible = "openrisc,ompic";
> +	reg = <0x98000000 16>;
> +	interrupt-controller;
> +	interrupts = <1>;
> +};
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index b49acda5e8f4..34eb4e90f56c 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -30,6 +30,7 @@ config OPENRISC
>  	select NO_BOOTMEM
>  	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_USE_QUEUED_RWLOCKS
> +	select OMPIC if SMP
>  
>  config CPU_BIG_ENDIAN
>  	def_bool y
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index f1fd5f44d1d4..0e4c96c90b86 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -145,6 +145,9 @@ config CLPS711X_IRQCHIP
>  	select SPARSE_IRQ
>  	default y
>  
> +config OMPIC
> +	bool
> +
>  config OR1K_PIC
>  	bool
>  	select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e88d856cc09c..123047d7a20d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
>  obj-$(CONFIG_METAG)			+= irq-metag-ext.o
>  obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
>  obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
> +obj-$(CONFIG_OMPIC)			+= irq-ompic.o
>  obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
>  obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
>  obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
> diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
> new file mode 100644
> index 000000000000..cd2616b6639b
> --- /dev/null
> +++ b/drivers/irqchip/irq-ompic.c
> @@ -0,0 +1,205 @@
> +/*
> + * Open Multi-Processor Interrupt Controller driver
> + *
> + * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> + * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * The ompic device handles IPI communication because cores in mulicore
> + * OpenRISC systems.

Should the above read "between cores"?

> + *
> + * Registers
> + *
> + * For each CPU the ompic has 2 registers. The control register for sending
> + * and acking IPIs and the status register for receiving IPIs. The register
> + * layouts are as follows:
> + *
> + *  Control register
> + *  +---------+---------+----------+---------+
> + *  | 31      | 30      | 29 .. 16 | 15 .. 0 |
> + *  ----------+---------+----------+----------
> + *  | IRQ ACK | IRQ GEN | DST CORE | DATA    |
> + *  +---------+---------+----------+---------+
> + *
> + *  Status register
> + *  +----------+-------------+----------+---------+
> + *  | 31       | 30          | 29 .. 16 | 15 .. 0 |
> + *  -----------+-------------+----------+---------+
> + *  | Reserved | IRQ Pending | SRC CORE | DATA    |
> + *  +----------+-------------+----------+---------+
> + *
> + * Architecture
> + *
> + * - The ompic generates a level interrupt to the CPU PIC when a message is
> + *   ready.  Messages are delivered via the memory bus.
> + * - The ompic does not have any interrupt input lines.
> + * - The ompic is wired to the same irq line on each core.
> + * - Devices are wired to the same irq line on each core.
> + *
> + *   +---------+                         +---------+
> + *   | CPU     |                         | CPU     |
> + *   |  Core 0 |<==\ (memory access) /==>|  Core 1 |
> + *   |  [ PIC ]|   |                 |   |  [ PIC ]|
> + *   +----^-^--+   |                 |   +----^-^--+
> + *        | |      v                 v        | |
> + *   <====|=|=================================|=|==> (memory bus)
> + *        | |      ^                  ^       | |
> + *  (ipi  | +------|---------+--------|-------|-+ (device irq)
> + *   irq  |        |         |        |       |
> + *  core0)| +------|---------|--------|-------+ (ipi irq core1)
> + *        | |      |         |        |
> + *   +----o-o-+    |    +--------+    |
> + *   | ompic  |<===/    | Device |<===/
> + *   |  IPI   |         +--------+
> + *   +--------+*
> + *
> + */
> +
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +#include <linux/smp.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +
> +#include <linux/irqchip.h>
> +
> +#define OMPIC_CPUBYTES		8
> +#define OMPIC_CTRL(cpu)		(0x0 + (cpu * OMPIC_CPUBYTES))
> +#define OMPIC_STAT(cpu)		(0x4 + (cpu * OMPIC_CPUBYTES))
> +
> +#define OMPIC_CTRL_IRQ_ACK	(1 << 31)
> +#define OMPIC_CTRL_IRQ_GEN	(1 << 30)
> +#define OMPIC_CTRL_DST(cpu)	(((cpu) & 0x3fff) << 16)
> +
> +#define OMPIC_STAT_IRQ_PENDING	(1 << 30)
> +
> +#define OMPIC_DATA(x)		((x) & 0xffff)
> +
> +DEFINE_PER_CPU(unsigned long, ops);
> +
> +static void __iomem *ompic_base;
> +
> +static inline u32 ompic_readreg(void __iomem *base, loff_t offset)
> +{
> +	return ioread32be(base + offset);
> +}
> +
> +static void ompic_writereg(void __iomem *base, loff_t offset, u32 data)
> +{
> +	iowrite32be(data, base + offset);
> +}
> +
> +void ompic_raise_softirq(const struct cpumask *mask, unsigned int ipi_msg)

Please make this static.

> +{
> +	unsigned int dst_cpu;
> +	unsigned int src_cpu = smp_processor_id();
> +
> +	for_each_cpu(dst_cpu, mask) {
> +		set_bit(ipi_msg, &per_cpu(ops, dst_cpu));
> +
> +		/*
> +		 * On OpenRISC the atomic set_bit() call implies a memory
> +		 * barrier.  Otherwise we would need: smp_wmb(); paired
> +		 * with the read in ompic_ipi_handler.
> +		 */

One last question on this, because the architecture document is terribly
unclear: If you have CPU0 doing an atomic operation A0, CPU1 seeing A0
and doeing another atomic A1 (the set_bit above) followed by an IPI to
CPU2, is CPU2 *guaranteed* to observe both A0 *and* A1? Because that's
required by the IPI semantics, and you wouldn't see that kind of issue
with only two CPUs.

> +
> +		ompic_writereg(ompic_base, OMPIC_CTRL(src_cpu),
> +			       OMPIC_CTRL_IRQ_GEN |
> +			       OMPIC_CTRL_DST(dst_cpu) |
> +			       OMPIC_DATA(1));
> +	}
> +}
> +
> +irqreturn_t ompic_ipi_handler(int irq, void *dev_id)

This should be static.

> +{
> +	unsigned int cpu = smp_processor_id();
> +	unsigned long *pending_ops = &per_cpu(ops, cpu);
> +	unsigned long ops;
> +
> +	ompic_writereg(ompic_base, OMPIC_CTRL(cpu), OMPIC_CTRL_IRQ_ACK);
> +	while ((ops = xchg(pending_ops, 0)) != 0) {
> +
> +		/*
> +		 * On OpenRISC the atomic xchg() call implies a memory
> +		 * barrier.  Otherwise we may need an smp_rmb(); paired
> +		 * with the write in ompic_raise_softirq.
> +		 */
> +
> +		do {
> +			unsigned long ipi_msg;
> +
> +			ipi_msg = __ffs(ops);
> +			ops &= ~(1UL << ipi_msg);
> +
> +			handle_IPI(ipi_msg);
> +		} while (ops);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction ompi_ipi_irqaction = {
> +	.handler =      ompic_ipi_handler,
> +	.flags =        IRQF_PERCPU,
> +	.name =         "ompic_ipi",
> +};
> +
> +int __init ompic_of_init(struct device_node *node, struct device_node *parent)

static again.

> +{
> +	struct resource res;
> +	int irq;
> +	int ret;
> +
> +	/* Validate the DT */
> +	if (ompic_base) {
> +		pr_err("ompic: duplicate ompic's are not supported");
> +		return -EEXIST;
> +	}
> +
> +	if (of_address_to_resource(node, 0, &res)) {
> +		pr_err("ompic: reg property requires an address and size");
> +		return -EINVAL;
> +	}
> +
> +	if (resource_size(&res) < (num_possible_cpus() * OMPIC_CPUBYTES)) {
> +		pr_err("ompic: reg size, currently %d must be at least %d",
> +			resource_size(&res),
> +			(num_possible_cpus() * OMPIC_CPUBYTES));
> +		return -EINVAL;
> +	}
> +
> +	/* Setup the device */
> +	ompic_base = ioremap(res.start, resource_size(&res));
> +	if (IS_ERR(ompic_base)) {
> +		pr_err("ompic: unable to map registers");
> +		return PTR_ERR(ompic_base);
> +	}
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0) {
> +		pr_err("ompic: unable to parse device irq");
> +		ret = -EINVAL;
> +		goto out_unmap;
> +	}
> +
> +	ret = setup_irq(irq, &ompi_ipi_irqaction);
> +	if (ret)
> +		goto out_irq_disp;
> +
> +	set_smp_cross_call(ompic_raise_softirq);
> +
> +	return 0;
> +
> +out_irq_disp:
> +	irq_dispose_mapping(irq);
> +out_unmap:
> +	iounmap(ompic_base);
> +	ompic_base = NULL;
> +	return ret;
> +}
> +IRQCHIP_DECLARE(ompic, "openrisc,ompic", ompic_of_init);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
