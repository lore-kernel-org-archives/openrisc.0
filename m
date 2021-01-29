From: Stafford Horne <shorne@gmail.com>
Date: Sat, 30 Jan 2021 07:16:43 +0900
Subject: [OpenRISC] [PATCH] openrisc: use device tree to determine
 present cpus
In-Reply-To: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
Message-ID: <20210129221643.GZ2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jan 29, 2021 at 07:29:31PM +0100, Jan Henrik Weinstock wrote:
> This patch proposes to use the device tree to determine the present cpus
> instead of assuming all CONFIG_NRCPUS are actually present in the system.
> 
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
>  arch/openrisc/kernel/smp.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 29c82ef2e..75be7e34f 100644
> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c
> @@ -16,6 +16,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/irq.h>
> +#include <linux/of.h>
>  #include <asm/cpuinfo.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -68,14 +69,25 @@ void __init smp_init_cpus(void)
> 
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	int i;
> +	u32 cpu_id;
> +	struct device_node *cpu, *cpus;
> 
>  	/*
>  	 * Initialise the present map, which describes the set of CPUs
>  	 * actually populated at the present time.
>  	 */
> -	for (i = 0; i < max_cpus; i++)
> -		set_cpu_present(i, true);
> +	cpus = of_find_node_by_path("/cpus");
> +	for_each_child_of_node(cpus, cpu) {
> +		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> +			pr_warn("%s missing reg property", cpu->full_name);
> +			continue;
> +		}
> +
> +		if (cpu_id >= max_cpus)
> +			continue;
> +
> +		set_cpu_present(cpu_id, true);
> +	}

Hello, I looked into what other architectures do.  Risc-V does something similar
but it does the setup in 2 parts:

 - it uses the device tree to set possible CPU's in setup_smp. Using
   for_each_of_cpu_node and set_cpu_possible.

 - Then in smp_prepare_cpus, it loops over possible cpus with
   for_each_possible_cpu.

Note, it seems risc-v does't actually check max_cpus when setting
set_cpu_present which may be a bug.

I think the two part approach is what we want to do:

 - we should do set_cpu_possible in smp_init_cpus based on device tree.
   Basically the same as your loop above but using for_each_of_cpu_node
   and NR_CPUS.
 - we can then do set_cpu_present using for_each_possible_cpu in
   smp_prepare_cpus.

What do you think?

-Stafford

>  }
> 
>  void __init smp_cpus_done(unsigned int max_cpus)
> -- 
> 2.17.1
> 


