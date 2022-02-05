From: Stafford Horne <shorne@gmail.com>
Date: Sat, 5 Feb 2022 15:58:13 +0900
Subject: [OpenRISC] [RFC V1 22/31] openrisc/mm: Enable
 ARCH_HAS_VM_GET_PAGE_PROT
In-Reply-To: <1643029028-12710-23-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-23-git-send-email-anshuman.khandual@arm.com>
Message-ID: <Yf4gBd1nJNeQYSJr@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 24, 2022 at 06:26:59PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: openrisc at lists.librecores.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

For one thing this is easier to read than the __P000 codes.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig               |  1 +
>  arch/openrisc/include/asm/pgtable.h | 18 -------------
>  arch/openrisc/mm/init.c             | 41 +++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index f724b3f1aeed..842a61426816 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>  	select COMMON_CLK
>  	select OF
>  	select OF_EARLY_FLATTREE
> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index cdd657f80bfa..fe686c4b7065 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -176,24 +176,6 @@ extern void paging_init(void);
>  	__pgprot(_PAGE_ALL | _PAGE_SRE | _PAGE_SWE \
>  		 | _PAGE_SHARED | _PAGE_DIRTY | _PAGE_EXEC | _PAGE_CI)
>  
> -#define __P000	PAGE_NONE
> -#define __P001	PAGE_READONLY_X
> -#define __P010	PAGE_COPY
> -#define __P011	PAGE_COPY_X
> -#define __P100	PAGE_READONLY
> -#define __P101	PAGE_READONLY_X
> -#define __P110	PAGE_COPY
> -#define __P111	PAGE_COPY_X
> -
> -#define __S000	PAGE_NONE
> -#define __S001	PAGE_READONLY_X
> -#define __S010	PAGE_SHARED
> -#define __S011	PAGE_SHARED_X
> -#define __S100	PAGE_READONLY
> -#define __S101	PAGE_READONLY_X
> -#define __S110	PAGE_SHARED
> -#define __S111	PAGE_SHARED_X
> -
>  /* zero page used for uninitialized stuff */
>  extern unsigned long empty_zero_page[2048];
>  #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 97305bde1b16..c9f5e7d6bb59 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -210,3 +210,44 @@ void __init mem_init(void)
>  	mem_init_done = 1;
>  	return;
>  }
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return PAGE_NONE;
> +	case VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_READ | VM_WRITE:
> +		return PAGE_COPY_X;
> +	case VM_EXEC:
> +		return PAGE_READONLY;
> +	case VM_EXEC | VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_EXEC | VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_COPY_X;
> +	case VM_SHARED:
> +		return PAGE_NONE;
> +	case VM_SHARED | VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_SHARED | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_READ | VM_WRITE:
> +		return PAGE_SHARED_X;
> +	case VM_SHARED | VM_EXEC:
> +		return PAGE_READONLY;
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_SHARED_X;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);
> -- 
> 2.25.1
> 
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
