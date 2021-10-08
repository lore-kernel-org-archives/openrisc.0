From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 08 Oct 2021 22:01:15 +1100
Subject: [OpenRISC] [PATCH 07/12] powerpc: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-8-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-8-robh@kernel.org>
Message-ID: <8735pbok5g.fsf@mpe.ellerman.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Rob Herring <robh@kernel.org> writes:
> Replace open coded parsing of CPU nodes' 'reg' property with
> of_get_cpu_hwid().
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev at lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/powerpc/kernel/smp.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9cc7d3dbf439..d96b0e361a73 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1313,18 +1313,13 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  int cpu_to_core_id(int cpu)
>  {
>  	struct device_node *np;
> -	const __be32 *reg;
>  	int id = -1;
>  
>  	np = of_get_cpu_node(cpu, NULL);
>  	if (!np)
>  		goto out;
>  
> -	reg = of_get_property(np, "reg", NULL);
> -	if (!reg)
> -		goto out;
> -
> -	id = be32_to_cpup(reg);
> +	id = of_get_cpu_hwid(np, 0);
>  out:
>  	of_node_put(np);
>  	return id;

This looks OK to me.

All the systems I can find have a /cpus/#address-cells of 1, so the
change to use of_n_addr_cells() in of_get_cpu_hwid() should be fine.

I booted it on a bunch of systems with no issues.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
