From: Michal Simek <monstr@monstr.eu>
Date: Mon, 2 Sep 2019 16:16:52 +0200
Subject: [OpenRISC] [PATCH 03/26] m68k,
 microblaze: remove ioremap_fullcache
In-Reply-To: <20190817073253.27819-4-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-4-hch@lst.de>
Message-ID: <9a11ddb0-0799-c64a-f5aa-0504c564998f@monstr.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 17. 08. 19 9:32, Christoph Hellwig wrote:
> No callers of this function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/m68k/include/asm/kmap.h     | 7 -------
>  arch/microblaze/include/asm/io.h | 1 -
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
> index aac7f045f7f0..03d904fe6087 100644
> --- a/arch/m68k/include/asm/kmap.h
> +++ b/arch/m68k/include/asm/kmap.h
> @@ -43,13 +43,6 @@ static inline void __iomem *ioremap_wt(unsigned long physaddr,
>  	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
>  }
>  
> -#define ioremap_fullcache ioremap_fullcache
> -static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
> -					      unsigned long size)
> -{
> -	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
> -}
> -
>  #define memset_io memset_io
>  static inline void memset_io(volatile void __iomem *addr, unsigned char val,
>  			     int count)
> diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
> index c7968139486f..86c95b2a1ce1 100644
> --- a/arch/microblaze/include/asm/io.h
> +++ b/arch/microblaze/include/asm/io.h
> @@ -40,7 +40,6 @@ extern void iounmap(volatile void __iomem *addr);
>  
>  extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
>  #define ioremap_nocache(addr, size)		ioremap((addr), (size))
> -#define ioremap_fullcache(addr, size)		ioremap((addr), (size))
>  #define ioremap_wc(addr, size)			ioremap((addr), (size))
>  #define ioremap_wt(addr, size)			ioremap((addr), (size))
>  
> 

Acked-by: Michal Simek <monstr@monstr.eu> (for Microblaze)

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
Size: 195 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190902/926382d9/attachment.sig>
