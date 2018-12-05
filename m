From: Michal Simek <monstr@monstr.eu>
Date: Wed, 5 Dec 2018 16:29:40 +0100
Subject: [OpenRISC] [PATCH v2 2/6] microblaze: prefer memblock API
 returning virtual address
In-Reply-To: <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>
Message-ID: <0a5e0aef-15fd-2d0c-765c-e7ba60219b00@monstr.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 03. 12. 18 16:47, Mike Rapoport wrote:
> Rather than use the memblock_alloc_base that returns a physical address and
> then convert this address to the virtual one, use appropriate memblock
> function that returns a virtual address.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/microblaze/mm/init.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index b17fd8a..44f4b89 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -363,8 +363,9 @@ void __init *early_get_page(void)
>  	 * Mem start + kernel_tlb -> here is limit
>  	 * because of mem mapping from head.S
>  	 */
> -	return __va(memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
> -				memory_start + kernel_tlb));
> +	return memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
> +				MEMBLOCK_LOW_LIMIT, memory_start + kernel_tlb,
> +				NUMA_NO_NODE);
>  }
>  
>  #endif /* CONFIG_MMU */
> 

I can't see any issue with functionality when this patch is applied.
If you want me to take this via my tree please let me know.
Otherwise:

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20181205/a9ba388b/attachment-0001.sig>
