From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Wed, 14 Apr 2021 11:10:42 +0200
Subject: [OpenRISC] [PATCH] init: consolidate trap_init()
In-Reply-To: <20210414165808.458a3d11@xhacker.debian>
References: <20210414165808.458a3d11@xhacker.debian>
Message-ID: <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 14/04/2021 à 10:58, Jisheng Zhang a écrit :
> Many architectures implement the trap_init() as NOP, since there is
> no such default for trap_init(), this empty stub is duplicated among
> these architectures. Provide a generic but weak NOP implementation
> to drop the empty stubs of trap_init() in these architectures.

You define the weak function in the __init section.

Most but not all architectures had it in __init section.

And the remaining ones may not be defined in __init section. For instance look at the one in alpha 
architecture.

Have you checked that it is not a problem ? It would be good to say something about it in the commit 
description.


> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>   arch/arc/kernel/traps.c      |  5 -----
>   arch/arm/kernel/traps.c      |  5 -----
>   arch/h8300/kernel/traps.c    | 13 -------------
>   arch/hexagon/kernel/traps.c  |  4 ----
>   arch/nds32/kernel/traps.c    |  5 -----
>   arch/nios2/kernel/traps.c    |  5 -----
>   arch/openrisc/kernel/traps.c |  5 -----
>   arch/parisc/kernel/traps.c   |  4 ----
>   arch/powerpc/kernel/traps.c  |  5 -----
>   arch/riscv/kernel/traps.c    |  5 -----
>   arch/um/kernel/trap.c        |  4 ----
>   init/main.c                  |  2 ++
>   12 files changed, 2 insertions(+), 60 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 53b278845b88..4bdbe2928530 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -790,6 +790,8 @@ static inline void initcall_debug_enable(void)
>   }
>   #endif
>   
> +void __init __weak trap_init(void) { }
> +

I think in a C file we don't try to save space as much as in a header file.

I would prefer something like:


void __init __weak trap_init(void)
{
}


>   /* Report memory auto-initialization states for this boot. */
>   static void __init report_meminit(void)
>   {
> 
