From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Thu, 5 Mar 2020 13:04:19 +0530
Subject: [OpenRISC] [PATCH] mm/special: Create generic fallbacks for
 pte_special() and pte_mkspecial()
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <58aecdcf-ea16-c958-0deb-97541792e081@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


On 03/02/2020 07:26 AM, Anshuman Khandual wrote:
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
> +#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> +static inline int pte_special(pte_t pte)
> +{
> +	return pte.pte_low & _PAGE_SPECIAL;
> +}
> +
> +static inline pte_t pte_mkspecial(pte_t pte)
> +{
> +	pte.pte_low |= _PAGE_SPECIAL;
> +	return pte;
> +}
> +#else
> +static inline int pte_special(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SPECIAL;
> +}
> +
> +static inline pte_t pte_mkspecial(pte_t pte)
> +{
> +	pte_val(pte) |= _PAGE_SPECIAL;
> +	return pte;
> +}
> +#endif
> +#endif
> +

Hello Ralf/Paul,

This change now restricts mips definitions for pte_special() and pte_mkspecial()
and makes them visible only for configs where ARCH_HAS_PTE_SPECIAL is enabled.
Does this look okay ? In almost all other platforms we drop the stub definitions
for pte_special() and pte_mkspecial().

- Anshuman
