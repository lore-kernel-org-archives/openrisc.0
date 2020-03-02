From: Stafford Horne <shorne@gmail.com>
Date: Mon, 2 Mar 2020 18:16:35 +0900
Subject: [OpenRISC] [PATCH] mm/special: Create generic fallbacks for
 pte_special() and pte_mkspecial()
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20200302091635.GK7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Mar 02, 2020 at 07:26:30AM +0530, Anshuman Khandual wrote:

> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index 248d22d8faa7..7f3fb9ceb083 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -236,8 +236,6 @@ static inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_WRITE; }
>  static inline int pte_exec(pte_t pte)  { return pte_val(pte) & _PAGE_EXEC; }
>  static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
>  static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
> -static inline int pte_special(pte_t pte) { return 0; }
> -static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {

For openrisc bits:

Acked-by: Stafford Horne <shorne@gmail.com>
 
