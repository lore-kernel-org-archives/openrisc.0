From: Daniel Axtens <dja@axtens.net>
Date: Tue, 04 Aug 2020 23:53:15 +1000
Subject: [OpenRISC] [PATCH v2 01/17] KVM: PPC: Book3S HV: simplify
 kvm_cma_reserve()
In-Reply-To: <20200802163601.8189-2-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-2-rppt@kernel.org>
Message-ID: <87tuxio6us.fsf@dja-thinkpad.axtens.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Mike,

>
> The memory size calculation in kvm_cma_reserve() traverses memblock.memory
> rather than simply call memblock_phys_mem_size(). The comment in that
> function suggests that at some point there should have been call to
> memblock_analyze() before memblock_phys_mem_size() could be used.
> As of now, there is no memblock_analyze() at all and
> memblock_phys_mem_size() can be used as soon as cold-plug memory is
> registerd with memblock.
>
> Replace loop over memblock.memory with a call to memblock_phys_mem_size().
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_builtin.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index 7cd3cf3d366b..56ab0d28de2a 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -95,22 +95,15 @@ EXPORT_SYMBOL_GPL(kvm_free_hpt_cma);
>  void __init kvm_cma_reserve(void)
>  {
>  	unsigned long align_size;
> -	struct memblock_region *reg;
> -	phys_addr_t selected_size = 0;
> +	phys_addr_t selected_size;
>  
>  	/*
>  	 * We need CMA reservation only when we are in HV mode
>  	 */
>  	if (!cpu_has_feature(CPU_FTR_HVMODE))
>  		return;
> -	/*
> -	 * We cannot use memblock_phys_mem_size() here, because
> -	 * memblock_analyze() has not been called yet.
> -	 */
> -	for_each_memblock(memory, reg)
> -		selected_size += memblock_region_memory_end_pfn(reg) -
> -				 memblock_region_memory_base_pfn(reg);
>  
> +	selected_size = PHYS_PFN(memblock_phys_mem_size());
>  	selected_size = (selected_size * kvm_cma_resv_ratio / 100) << PAGE_SHIFT;

I think this is correct, but PHYS_PFN does x >> PAGE_SHIFT and then the
next line does x << PAGE_SHIFT, so I think we could combine those two
lines as:

selected_size = PAGE_ALIGN(memblock_phys_mem_size() * kvm_cma_resv_ratio / 100);

(I think that might technically change it from aligning down to aligning
up but I don't think 1 page matters here.)

Kind regards,
Daniel


>  	if (selected_size) {
>  		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
> -- 
> 2.26.2
