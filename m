From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Wed, 17 Mar 2021 06:48:15 +0100
Subject: [OpenRISC] [PATCH v2] mm: Move mem_init_print_info() into
 mm_init()
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Message-ID: <3f6959d6-1f37-8baf-a12e-3fbda6a17c7d@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 17/03/2021 à 02:52, Kefeng Wang a écrit :
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - Cleanup 'str' line suggested by Christophe and ACK
> 
>   arch/alpha/mm/init.c             |  1 -
>   arch/arc/mm/init.c               |  1 -
>   arch/arm/mm/init.c               |  2 --
>   arch/arm64/mm/init.c             |  2 --
>   arch/csky/mm/init.c              |  1 -
>   arch/h8300/mm/init.c             |  2 --
>   arch/hexagon/mm/init.c           |  1 -
>   arch/ia64/mm/init.c              |  1 -
>   arch/m68k/mm/init.c              |  1 -
>   arch/microblaze/mm/init.c        |  1 -
>   arch/mips/loongson64/numa.c      |  1 -
>   arch/mips/mm/init.c              |  1 -
>   arch/mips/sgi-ip27/ip27-memory.c |  1 -
>   arch/nds32/mm/init.c             |  1 -
>   arch/nios2/mm/init.c             |  1 -
>   arch/openrisc/mm/init.c          |  2 --
>   arch/parisc/mm/init.c            |  2 --
>   arch/powerpc/mm/mem.c            |  1 -
>   arch/riscv/mm/init.c             |  1 -
>   arch/s390/mm/init.c              |  2 --
>   arch/sh/mm/init.c                |  1 -
>   arch/sparc/mm/init_32.c          |  2 --
>   arch/sparc/mm/init_64.c          |  1 -
>   arch/um/kernel/mem.c             |  1 -
>   arch/x86/mm/init_32.c            |  2 --
>   arch/x86/mm/init_64.c            |  2 --
>   arch/xtensa/mm/init.c            |  1 -
>   include/linux/mm.h               |  2 +-
>   init/main.c                      |  1 +
>   mm/page_alloc.c                  | 10 +++++-----
>   30 files changed, 7 insertions(+), 42 deletions(-)
> 

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 89314651dd62..c2e0b3495c5a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2373,7 +2373,7 @@ extern unsigned long free_reserved_area(void *start, void *end,
>   					int poison, const char *s);
>   
>   extern void adjust_managed_page_count(struct page *page, long count);
> -extern void mem_init_print_info(const char *str);
> +extern void mem_init_print_info(void);

Sorry I didn't see that in previous patch.

'extern' keyword is pointless for function prototypes and is deprecated, you should remove it.

That said,

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr> # focussed on powerpc

>   
>   extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
>   
