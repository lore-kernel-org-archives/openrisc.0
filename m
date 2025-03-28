Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558121E1E11;
	Fri, 28 Mar 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743198518; cv=none; b=G+eZJgKVfOiYiFG1JLbA2D6MvXjCLUY6XD82CHbl+Y3wLbJbaJjiKyYF9oiAkD+7N+5FIu0le9vA6lbDKmWXd9j08lB7VkI+j52PbEPOBBO17ybvrueh+TYcfujzLyb65fLzqLBqyrqMdFEq3Lt5eG5ZX1k5xFyOIQQUIznOY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743198518; c=relaxed/simple;
	bh=PTAMxxTM6FsYSHG/HXkQ812e1Wt8BpGdOX7pTiMV2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPvgsBZhsNxv3tz6waGQWV4LIupFu8ea+tqFQgepQAZ8t+pSamp/ig7owX9FAFhi+pzguSmVIpIPFl/EnGlCiUmO9qTbjWTHkx7iMkOenTjMrNIYdfT2QOFcYq2tBFhj6hXmnjMrKmUTdMIkVCamMwdxZRN4FAoADwh2vlWlErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/0+vsD5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/0+vsD5"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac9aea656so2168721f8f.3;
        Fri, 28 Mar 2025 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743198514; x=1743803314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDNJBvdxN4v/xlhcoMzRKdm1ex0S6ze06N+sTjesL3A=;
        b=d/0+vsD5OsGQiU5tp+rPnrD3MSY6HOJSe05c33/qCb85znMjHTasA631Gh8USWxvcg
         M0o9XOhfWOo8JEBAudoGXGWyOvRZhyFwTthfjl7S+Ve7y+QdKKR4QuZ/pWEezSMiYY47
         4XcmZZcEhnEiH9FQrEczCCIu4CSXmYwfksnyHIwb/lX741B9/6cCmxH3hfjVEOv+llFp
         YOyNr7uCwtQjlSMsUyoEGXDlVSiwTjlBIyosshw4rfc9+Ty+x5CwfNEQo0aESSEnuBk0
         JyI/LAfccugPU22byMiYAlNncXs9Ev5OaAlQokiepLZzn7wy+2fxlamGeF/te36XVGOX
         5KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743198514; x=1743803314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDNJBvdxN4v/xlhcoMzRKdm1ex0S6ze06N+sTjesL3A=;
        b=FU8U6t1tME15v/ezlfh5jOcNv2xut6ysqKeSOOpEmM8oWmCw0IUk+s+WYgPjzA1ag8
         QFD0ENhIa9Kh5lm+wHDnzTOPtyY3AUVM3/pmc/OjmvBkemXL7YRHjkMI8AvfrKvmSi0V
         2O8WZaPoA8tHFmjrjtPzMFdxa9k4Xlt05jebpnQwNwkvMyfqaN+t8zdbyZ0n151aqFpz
         h6hlH9qw64nRjlbfrBs1ZOrLx6dPanrIrK8GIxDP91lsEGKb0itbCdisyK1d/rEZwl7q
         bM5i2r2Xxa5Gb2OskiLT64MPJMYlMCRz3LffAFlowuxbiAAIQpYhA3cSiT0Zwczo+/db
         zuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNFAmKqiIu/NoXMyrDX9Em8jDPXEWz/2kPrRS/JgTo0AJvh90c7/nRULdJ4MQzk1VjwF54GKLJLTtxkNQ=@vger.kernel.org, AJvYcCWU7JwuvZ0ezGZfODB3tR30OEwZ9l1ijf0OyIEgrbhAKq+SCJTBIw7Pc22VIrMy0lky7UKVpMuTIM8Fx/LbFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvlfHWKbKyaZ8CtzE2DaWN64OHWJF05ZAEEJAK50Q3knAM/Nh
	XeZ3Zj6w6TXuqY3Qx1OpDmVYrT3IuwBoBkHFaP8aYlc/DlB8w3CMM+DICQ==
X-Gm-Gg: ASbGncs6nqvTiPSLGBsdy2rgBD3HsWnLcyjaBPhBpWYKktRb3CZlTbpBcL+2yOP8JTO
	Xeb93mAjRTR5tpThc9ZSB/GlixwUtq8LnkNBGADGdTj8OBdtiolSpnhP34G//VGLshhwXnSD6e+
	Z8T5pymElyTz6Sby5yAID2ZasLz3vccVq8DA1VQXbBQOxKmhn5bu6fPm3vMPRyt/+xIMstZdQvW
	srnW4FerJQYnm1ujv2+72shifhEAQHS0h0fI7sXhlwhJT0q0uq818kEnA45rGQ6wuYgDQtVdy1h
	38rH8NKzS/0InKcaxnWw9KuskfJ6pri9WCMuh47lLYtRq4FtcDTEGf7KO9GL8D2kB+/5GeBRTL+
	B60pth4JX
X-Google-Smtp-Source: AGHT+IGYRDPOzK7bFi3Lm1VmIoYpyMfrs3VMGMSmJwDxySHel4doBSQhPROG5NJxlrKB6EqjnuiomQ==
X-Received: by 2002:a5d:64c6:0:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-39c12117d3emr568230f8f.44.1743198514246;
        Fri, 28 Mar 2025 14:48:34 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66cafdsm3848839f8f.56.2025.03.28.14.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 14:48:32 -0700 (PDT)
Date: Fri, 28 Mar 2025 21:48:31 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] openrisc: Introduce new utility functions to
 flush and invalidate caches
Message-ID: <Z-cZLwdbkemRGOJT@antec>
References: <20250328202632.72809-1-sahilcdq@proton.me>
 <20250328202632.72809-3-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328202632.72809-3-sahilcdq@proton.me>

On Sat, Mar 29, 2025 at 01:56:31AM +0530, Sahil Siddiq wrote:
> According to the OpenRISC architecture manual, the dcache and icache may
> not be present. When these caches are present, the invalidate and flush
> registers may be absent. The current implementation does not perform
> checks to verify their presence before utilizing cache registers, or
> invalidating and flushing cache blocks.
> 
> Introduce new functions to detect the presence of cache components and
> related special-purpose registers.
> 
> There are a few places where a range of addresses have to be flushed or
> invalidated and the implementation is duplicated. Introduce new utility
> functions and macros that generalize this implementation and reduce
> duplication.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v3 -> v4:
> - arch/openrisc/include/asm/cpuinfo.h: Move new definitions to cache.c.
> - arch/openrisc/mm/cache.c:
>   (cache_loop): Split function.
>   (cache_loop_page): New function.
>   (cpu_cache_is_present): Move definition here.
>   (cb_inv_flush_is_implemented): Move definition here.
> 
> Changes from v2 -> v3:
> - arch/openrisc/include/asm/cacheflush.h: Declare new functions and macros.
> - arch/openrisc/include/asm/cpuinfo.h: Implement new functions.
>   (cpu_cache_is_present):
>   1. The implementation of this function was strewn all over the place in
>      the previous versions.
>   2. Fix condition. The condition in the previous version was incorrect.
>   (cb_inv_flush_is_implemented): New function.
> - arch/openrisc/kernel/dma.c: Use new functions.
> - arch/openrisc/mm/cache.c:
>   (cache_loop): Extend function.
>   (local_*_page_*): Use new cache_loop interface.
>   (local_*_range_*): Implement new functions.
> - arch/openrisc/mm/init.c: Use new functions.
> 
>  arch/openrisc/include/asm/cacheflush.h | 17 +++++
>  arch/openrisc/include/asm/cpuinfo.h    | 15 +++++
>  arch/openrisc/kernel/dma.c             | 18 ++----
>  arch/openrisc/mm/cache.c               | 87 +++++++++++++++++++++++---
>  arch/openrisc/mm/init.c                |  5 +-
>  5 files changed, 118 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
> index 984c331ff5f4..0e60af486ec1 100644
> --- a/arch/openrisc/include/asm/cacheflush.h
> +++ b/arch/openrisc/include/asm/cacheflush.h
> @@ -23,6 +23,9 @@
>   */
>  extern void local_dcache_page_flush(struct page *page);
>  extern void local_icache_page_inv(struct page *page);
> +extern void local_dcache_range_flush(unsigned long start, unsigned long end);
> +extern void local_dcache_range_inv(unsigned long start, unsigned long end);
> +extern void local_icache_range_inv(unsigned long start, unsigned long end);
>  
>  /*
>   * Data cache flushing always happen on the local cpu. Instruction cache
> @@ -38,6 +41,20 @@ extern void local_icache_page_inv(struct page *page);
>  extern void smp_icache_page_inv(struct page *page);
>  #endif /* CONFIG_SMP */
>  
> +/*
> + * Even if the actual block size is larger than L1_CACHE_BYTES, paddr
> + * can be incremented by L1_CACHE_BYTES. When paddr is written to the
> + * invalidate register, the entire cache line encompassing this address
> + * is invalidated. Each subsequent reference to the same cache line will
> + * not affect the invalidation process.
> + */
> +#define local_dcache_block_flush(addr) \
> +	local_dcache_range_flush(addr, addr + L1_CACHE_BYTES)
> +#define local_dcache_block_inv(addr) \
> +	local_dcache_range_inv(addr, addr + L1_CACHE_BYTES)
> +#define local_icache_block_inv(addr) \
> +	local_icache_range_inv(addr, addr + L1_CACHE_BYTES)
> +
>  /*
>   * Synchronizes caches. Whenever a cpu writes executable code to memory, this
>   * should be called to make sure the processor sees the newly written code.
> diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
> index 82f5d4c06314..e46afbfe9b5a 100644
> --- a/arch/openrisc/include/asm/cpuinfo.h
> +++ b/arch/openrisc/include/asm/cpuinfo.h
> @@ -15,6 +15,9 @@
>  #ifndef __ASM_OPENRISC_CPUINFO_H
>  #define __ASM_OPENRISC_CPUINFO_H
>  
> +#include <asm/spr.h>
> +#include <asm/spr_defs.h>
> +
>  struct cache_desc {
>  	u32 size;
>  	u32 sets;
> @@ -34,4 +37,16 @@ struct cpuinfo_or1k {
>  extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
>  extern void setup_cpuinfo(void);
>  
> +/*
> + * Check if the cache component exists.
> + */
> +extern bool cpu_cache_is_present(const unsigned int cache_type);

This is used in cacheinfo.  OK.

> +/*
> + * Check if the cache block flush/invalidate register is implemented for the
> + * cache component.
> + */
> +extern bool cb_inv_flush_is_implemented(const unsigned int reg,
> +					const unsigned int cache_type);

But this function doesnt seem to be used anywhere but in cache.c. Does it need
to be public?

>  #endif /* __ASM_OPENRISC_CPUINFO_H */
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index b3edbb33b621..3a7b5baaa450 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -17,6 +17,7 @@
>  #include <linux/pagewalk.h>
>  
>  #include <asm/cpuinfo.h>
> +#include <asm/cacheflush.h>
>  #include <asm/spr_defs.h>
>  #include <asm/tlbflush.h>
>  
> @@ -24,9 +25,6 @@ static int
>  page_set_nocache(pte_t *pte, unsigned long addr,
>  		 unsigned long next, struct mm_walk *walk)
>  {
> -	unsigned long cl;
> -	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> -
>  	pte_val(*pte) |= _PAGE_CI;
>  
>  	/*
> @@ -36,8 +34,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
>  	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>  
>  	/* Flush page out of dcache */
> -	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
> -		mtspr(SPR_DCBFR, cl);
> +	local_dcache_range_flush(__pa(addr), __pa(next));
>  
>  	return 0;
>  }
> @@ -98,21 +95,14 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
>  void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
>  		enum dma_data_direction dir)
>  {
> -	unsigned long cl;
> -	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> -
>  	switch (dir) {
>  	case DMA_TO_DEVICE:
>  		/* Flush the dcache for the requested range */
> -		for (cl = addr; cl < addr + size;
> -		     cl += cpuinfo->dcache_block_size)
> -			mtspr(SPR_DCBFR, cl);
> +		local_dcache_range_flush(addr, addr + size);
>  		break;
>  	case DMA_FROM_DEVICE:
>  		/* Invalidate the dcache for the requested range */
> -		for (cl = addr; cl < addr + size;
> -		     cl += cpuinfo->dcache_block_size)
> -			mtspr(SPR_DCBIR, cl);
> +		local_dcache_range_inv(addr, addr + size);
>  		break;
>  	default:
>  		/*
> diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> index eb43b73f3855..3bf6d728d2d2 100644
> --- a/arch/openrisc/mm/cache.c
> +++ b/arch/openrisc/mm/cache.c
> @@ -14,31 +14,63 @@
>  #include <asm/spr_defs.h>
>  #include <asm/cache.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpuinfo.h>
>  #include <asm/tlbflush.h>
>  
> -static __always_inline void cache_loop(struct page *page, const unsigned int reg)
> +static __always_inline void cache_loop(unsigned long paddr, unsigned long end,
> +				       const unsigned int reg, const unsigned int cache_type)
>  {
> -	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> -	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> +	if (!cpu_cache_is_present(cache_type))
> +		return;
> +
> +	if (!cb_inv_flush_is_implemented(reg, cache_type))
> +		return;
>  
> -	while (line < paddr + PAGE_SIZE) {
> -		mtspr(reg, line);
> -		line += L1_CACHE_BYTES;
> +	while (paddr < end) {
> +		mtspr(reg, paddr);
> +		paddr += L1_CACHE_BYTES;
>  	}
>  }
>  
> +static void cache_loop_page(struct page *page, const unsigned int reg,
> +					    const unsigned int cache_type)
> +{
> +	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> +	unsigned long end = paddr + PAGE_SIZE;
> +
> +	paddr &= ~(L1_CACHE_BYTES - 1);
> +
> +	cache_loop(paddr, end, reg, cache_type);
> +}
> +
>  void local_dcache_page_flush(struct page *page)
>  {
> -	cache_loop(page, SPR_DCBFR);
> +	cache_loop_page(page, SPR_DCBFR, SPR_UPR_DCP);
>  }
>  EXPORT_SYMBOL(local_dcache_page_flush);
>  
>  void local_icache_page_inv(struct page *page)
>  {
> -	cache_loop(page, SPR_ICBIR);
> +	cache_loop_page(page, SPR_ICBIR, SPR_UPR_ICP);
>  }
>  EXPORT_SYMBOL(local_icache_page_inv);
>  
> +void local_dcache_range_flush(unsigned long start, unsigned long end)
> +{
> +	cache_loop(start, end, SPR_DCBFR, SPR_UPR_DCP);
> +}
> +
> +void local_dcache_range_inv(unsigned long start, unsigned long end)
> +{
> +	cache_loop(start, end, SPR_DCBIR, SPR_UPR_DCP);
> +}
> +
> +void local_icache_range_inv(unsigned long start, unsigned long end)
> +{
> +	cache_loop(start, end, SPR_ICBIR, SPR_UPR_ICP);
> +}
> +
> +

There is an extra newline here.

>  void update_cache(struct vm_area_struct *vma, unsigned long address,
>  	pte_t *pte)
>  {
> @@ -59,3 +91,42 @@ void update_cache(struct vm_area_struct *vma, unsigned long address,
>  	}
>  }
>  
> +/*
> + * Check if the cache component exists.
> + */
> +bool cpu_cache_is_present(const unsigned int cache_type)
> +{
> +	unsigned long upr = mfspr(SPR_UPR);
> +
> +	return !!(upr & (SPR_UPR_UP | cache_type));
> +}
> +
> + /*
> +  * Check if the cache block flush/invalidate register is implemented for the
> +  * cache component.
> +  */
> +bool cb_inv_flush_is_implemented(const unsigned int reg,
> +				 const unsigned int cache_type)
> +{
> +	unsigned long cfgr;
> +
> +	if (cache_type == SPR_UPR_DCP) {
> +		cfgr = mfspr(SPR_DCCFGR);
> +		if (reg == SPR_DCBFR)
> +			return !!(cfgr & SPR_DCCFGR_CBFRI);
> +
> +		if (reg == SPR_DCBIR)
> +			return !!(cfgr & SPR_DCCFGR_CBIRI);
> +	}
> +
> +	/*
> +	 * The cache block flush register is not implemented for the instruction
> +	 * cache.
> +	 */
> +	if (cache_type == SPR_UPR_ICP) {
> +		cfgr = mfspr(SPR_ICCFGR);
> +		return !!(cfgr & SPR_ICCFGR_CBIRI);
> +	}
> +
> +	return false;
> +}

Usually we try to define functions before they are used.  This and
cpu_cache_is_present should be above cache_loop.

As I mentioned, this may be a bit overkill, OpenRISC completely ignore writes to
SPR registers that are not implemented.  They are basically nops.  It may help
to avoid running cache loops, but really there are no implementations I know of
that have caches (SPR_UPR_UP) but no cache invalidation/flush registers.

-Stafford

> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index d0cb1a0126f9..46b8720db08e 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -35,6 +35,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
> +#include <asm/cacheflush.h>
>  
>  int mem_init_done;
>  
> @@ -176,8 +177,8 @@ void __init paging_init(void)
>  	barrier();
>  
>  	/* Invalidate instruction caches after code modification */
> -	mtspr(SPR_ICBIR, 0x900);
> -	mtspr(SPR_ICBIR, 0xa00);
> +	local_icache_block_inv(0x900);
> +	local_icache_block_inv(0xa00);
>  
>  	/* New TLB miss handlers and kernel page tables are in now place.
>  	 * Make sure that page flags get updated for all pages in TLB by
> -- 
> 2.48.1
> 
