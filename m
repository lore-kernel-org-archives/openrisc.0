From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Tue, 10 Mar 2020 14:27:47 +0100
Subject: [OpenRISC] [PATCH V2] mm/special: Create generic fallbacks for
 pte_special() and pte_mkspecial()
In-Reply-To: <1583802551-15406-1-git-send-email-anshuman.khandual@arm.com>
References: <1583802551-15406-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20200310132747.GA12601@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 10, 2020 at 06:39:11AM +0530, Anshuman Khandual wrote:
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index aef5378f909c..8e4e4be1ca00 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -269,6 +269,36 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>   */
>  extern pgd_t swapper_pg_dir[];
>  
> +/*
> + * Platform specific pte_special() and pte_mkspecial() definitions
> + * are required only when ARCH_HAS_PTE_SPECIAL is enabled.
> + */
> +#if !defined(CONFIG_32BIT) && !defined(CONFIG_CPU_HAS_RIXI)

this looks wrong.

current Kconfig statement is

select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)

so we can't use PTE_SPECIAL on 32bit _and_ CPUs with RIXI support.

Why can't we use

#if defined(CONFIG_ARCH_HAS_PTE_SPECIAL)

here as the comment already suggests ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
