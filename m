From: Stafford Horne <shorne@gmail.com>
Date: Sun, 31 Jan 2021 08:03:10 +0900
Subject: [OpenRISC] [PATCH] openrisc: use device tree to determine
 present cpus
In-Reply-To: <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
Message-ID: <20210130230310.GC2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jan 30, 2021 at 12:00:10PM +0100, Jan Henrik Weinstock wrote:
> Hi Stafford, Geert,
> 
> thanks for your feedback. I have made the following changes to the patch:

Hi, Thanks for the updates.

> 1. use for_each_of_cpu_node
> 2. possible_cpus is now what is in the devicetree, up to NR_CPUS
> 3. present_cpus is now all possible cpus, up to max_cpus

This looks good, one small comment below.  Can you send the next patch as a v2?

Using 'git format-patch -v2 ...'

> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
You can include the 'Changes since v1' in the space here after '---'.

>  arch/openrisc/kernel/smp.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 29c82ef2e..83cbf43d4 100644
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
> @@ -60,22 +61,32 @@ void __init smp_prepare_boot_cpu(void)
> 
>  void __init smp_init_cpus(void)
>  {
> -	int i;
> +	struct device_node* cpu;
> +	u32 cpu_id;
> 
> -	for (i = 0; i < NR_CPUS; i++)
> -		set_cpu_possible(i, true);
> +	for_each_of_cpu_node(cpu) {
> +		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> +			pr_warn("%s missing reg property", cpu->full_name);
> +			continue;
> +		}
> +
> +		if (cpu_id < NR_CPUS)

Should we warn on the else case?

> +			set_cpu_possible(cpu_id, true);
> +	}
>  }

-Stafford
