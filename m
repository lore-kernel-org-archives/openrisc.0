From: Jonas Bonn <jonas@southpole.se>
Date: Mon, 19 Sep 2016 16:37:52 +0200
Subject: [OpenRISC] openrisc: Consolidate setup to use memblock instead
	of bootmem
In-Reply-To: <20160918152255.GA29400@roeck-us.net>
References: <1459937321-22393-1-git-send-email-shorne@gmail.com>
 <20160918152255.GA29400@roeck-us.net>
Message-ID: <57DFF840.6050605@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 09/18/2016 05:22 PM, Guenter Roeck wrote:
> On Wed, Apr 06, 2016 at 07:08:41PM +0900, Stafford Horne wrote:
>> Clearing out one todo item. This simplifies the boot process by using
>> the memblock api throughout the init process.
>>
>> The old logic bootstrapped from memblock -> bootmem -> buddy allocator
>> This is now simplified by using NO_BOOTMEM.
>>
>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> FWIW:
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

It's worth a lot.  I asked for a Tested-by on this patch many months 
ago... never heard from anybody.

Thanks.  This one is upstream material.

Acked-by: Jonas <jonas@southpole.se>

Stafford, queue this one up for upstream.

/Jonas

>
> Guenter
>
>> ---
>>   arch/openrisc/Kconfig               |  1 +
>>   arch/openrisc/TODO.openrisc         |  3 ---
>>   arch/openrisc/include/asm/pgalloc.h |  1 -
>>   arch/openrisc/kernel/setup.c        | 34 ++++++++++++----------------------
>>   arch/openrisc/mm/init.c             |  2 +-
>>   arch/openrisc/mm/ioremap.c          |  4 ----
>>   6 files changed, 14 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
>> index f1030d2..e760c83 100644
>> --- a/arch/openrisc/Kconfig
>> +++ b/arch/openrisc/Kconfig
>> @@ -27,6 +27,7 @@ config OPENRISC
>>   	select HAVE_DEBUG_STACKOVERFLOW
>>   	select OR1K_PIC
>>   	select OMPIC if SMP
>> +	select NO_BOOTMEM
>>   
>>   config MMU
>>   	def_bool y
>> diff --git a/arch/openrisc/TODO.openrisc b/arch/openrisc/TODO.openrisc
>> index a2bda7b..c43d4e1 100644
>> --- a/arch/openrisc/TODO.openrisc
>> +++ b/arch/openrisc/TODO.openrisc
>> @@ -5,9 +5,6 @@ that are due for investigation shortly, i.e. our TODO list:
>>   
>>   -- Implement the rest of the DMA API... dma_map_sg, etc.
>>   
>> --- Consolidate usage of memblock and bootmem... move everything over to
>> -   memblock.
>> -
>>   -- Finish the renaming cleanup... there are references to or32 in the code
>>      which was an older name for the architecture.  The name we've settled on is
>>      or1k and this change is slowly trickling through the stack.  For the time
>> diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
>> index 21484e5b..9c9f2ba 100644
>> --- a/arch/openrisc/include/asm/pgalloc.h
>> +++ b/arch/openrisc/include/asm/pgalloc.h
>> @@ -23,7 +23,6 @@
>>   #include <linux/threads.h>
>>   #include <linux/mm.h>
>>   #include <linux/memblock.h>
>> -#include <linux/bootmem.h>
>>   
>>   extern int mem_init_done;
>>   
>> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
>> index 745ff14..60f784e 100644
>> --- a/arch/openrisc/kernel/setup.c
>> +++ b/arch/openrisc/kernel/setup.c
>> @@ -51,18 +51,16 @@
>>   
>>   #include "vmlinux.h"
>>   
>> -static unsigned long __init setup_memory(void)
>> +static void __init setup_memory(void)
>>   {
>> -	unsigned long bootmap_size;
>>   	unsigned long ram_start_pfn;
>> -	unsigned long free_ram_start_pfn;
>>   	unsigned long ram_end_pfn;
>>   	phys_addr_t memory_start, memory_end;
>>   	struct memblock_region *region;
>>   
>>   	memory_end = memory_start = 0;
>>   
>> -	/* Find main memory where is the kernel */
>> +	/* Find main memory where is the kernel, we assume its the only one */
>>   	for_each_memblock(memory, region) {
>>   		memory_start = region->base;
>>   		memory_end = region->base + region->size;
>> @@ -75,10 +73,11 @@ static unsigned long __init setup_memory(void)
>>   	}
>>   
>>   	ram_start_pfn = PFN_UP(memory_start);
>> -	/* free_ram_start_pfn is first page after kernel */
>> -	free_ram_start_pfn = PFN_UP(__pa(_end));
>>   	ram_end_pfn = PFN_DOWN(memblock_end_of_DRAM());
>>   
>> +	/* setup bootmem globals (we use no_bootmem, but mm still depends on this) */
>> +	min_low_pfn = ram_start_pfn;
>> +	max_low_pfn = ram_end_pfn;
>>   	max_pfn = ram_end_pfn;
>>   
>>   	/*
>> @@ -86,22 +85,13 @@ static unsigned long __init setup_memory(void)
>>   	 *
>>   	 * This makes the memory from the end of the kernel to the end of
>>   	 * RAM usable.
>> -	 * init_bootmem sets the global values min_low_pfn, max_low_pfn.
>>   	 */
>> -	bootmap_size = init_bootmem(free_ram_start_pfn,
>> -				    ram_end_pfn - ram_start_pfn);
>> -	free_bootmem(PFN_PHYS(free_ram_start_pfn),
>> -		     (ram_end_pfn - free_ram_start_pfn) << PAGE_SHIFT);
>> -	reserve_bootmem(PFN_PHYS(free_ram_start_pfn), bootmap_size,
>> -			BOOTMEM_DEFAULT);
>> -
>> -	for_each_memblock(reserved, region) {
>> -		printk(KERN_INFO "Reserved - 0x%08x-0x%08x\n",
>> -		       (u32) region->base, (u32) region->size);
>> -		reserve_bootmem(region->base, region->size, BOOTMEM_DEFAULT);
>> -	}
>> +	memblock_reserve(__pa(_stext), _end - _stext);
>> +
>> +	early_init_fdt_reserve_self();
>> +	early_init_fdt_scan_reserved_mem();
>>   
>> -	return ram_end_pfn;
>> +	memblock_dump_all();
>>   }
>>   
>>   struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
>> @@ -327,8 +317,8 @@ void __init setup_arch(char **cmdline_p)
>>   	initrd_below_start_ok = 1;
>>   #endif
>>   
>> -	/* setup bootmem allocator */
>> -	max_low_pfn = setup_memory();
>> +	/* setup memblock allocator */
>> +	setup_memory();
>>   
>>   	/* paging_init() sets up the MMU and marks all pages as reserved */
>>   	paging_init();
>> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
>> index f85b73d..6972d5d 100644
>> --- a/arch/openrisc/mm/init.c
>> +++ b/arch/openrisc/mm/init.c
>> @@ -106,7 +106,7 @@ static void __init map_ram(void)
>>   			}
>>   
>>   			/* Alloc one page for holding PTE's... */
>> -			pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
>> +			pte = (pte_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
>>   			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
>>   
>>   			/* Fill the newly allocated page with PTE'S */
>> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
>> index 62b08ef..d11a594 100644
>> --- a/arch/openrisc/mm/ioremap.c
>> +++ b/arch/openrisc/mm/ioremap.c
>> @@ -124,11 +124,7 @@ pte_t __init_refok *pte_alloc_one_kernel(struct mm_struct *mm,
>>   	if (likely(mem_init_done)) {
>>   		pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_REPEAT);
>>   	} else {
>> -		pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
>> -#if 0
>> -		/* FIXME: use memblock... */
>>   		pte = (pte_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
>> -#endif
>>   	}
>>   
>>   	if (pte)


