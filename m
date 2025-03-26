Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C71F790B;
	Wed, 26 Mar 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009122; cv=none; b=ZMhQ1r7iYKPA5eLj12S0TcDp2ISBz9iAuZt/3cpuTOdIl6Nt1ojvTaLroFgmXdgJBQosFjiI7q8pTw8m/GFvFfUa9LixvLGhvwBGTILURAktdnngPujWorqFZeZNrbOGXfTxxPbz84oYNdTU1XUB+ZlHFu6VsL6XX8nvrV46T20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009122; c=relaxed/simple;
	bh=YgoK/n1T4gsNCRaFhfb2GKLoS12x/ltE0K32dRIJRAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwYUkWttNXmzHIdxLw1ikEuuplSCvnVWeZ8Ws0JRXv+Kfzf5+NneuM58r5bUancHLCdT6ml/kA1KFgU1ucuVBu1oFF+irJvbZYzM9M34SIbstQRG6Jm06TkgmzsFcgbIY+/SC/3KcbYzh0vfQOvaAxcKulC7+K9fB+73yyrnXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLEtBF1N; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLEtBF1N"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3997205e43eso17747f8f.0;
        Wed, 26 Mar 2025 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743009119; x=1743613919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjIbYQE8S52VLwV1uBwVTxvI3pZ14Z1snzutWP5RyW0=;
        b=WLEtBF1Ni4NEVIdS0LBWoDx4Z9WwJopoEd2aAr3sgQ3CRf3KueKMF4nNuiRutuNE3l
         C+wmyCOs5gchHVlSeiyKVc7gUEhNb22FZ49nLcSRJrV9FC0EQmqHS9ba1/Iu/Pg1E3dN
         QRSNMCcaAZaRpfCGLoOrlmtrE1OAbk7sY+t8K9y3uRMfsGmu86nhF48Tn1SzlQjHvUl1
         r2h1yPshDm8nMuD1G7Ty0sk35aUyljipQZMiagGLWfXwFn13HnrczkN2H2Ba6m/6Z3Nz
         sltJn7QhsNTDwfthxRS88RPWHmGlBhOWjrHBKhbdotVzHPloaCPDqBLjYDSxl3NSYnym
         RNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009119; x=1743613919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjIbYQE8S52VLwV1uBwVTxvI3pZ14Z1snzutWP5RyW0=;
        b=ZkIJsd6ZtrCPbpSFnKydbD1H48Ncp0w5TqVmZe5w72TdJYiuEDwgOlNpDU+Os4Aeyw
         CWB8k+rcocnbXZPMXLoZU2Qn6K6PJKRT+sQm9ge3ixvsvGW7UbUI2jZ+hD7IoSkBysl9
         boNZepMmheHOpQjTerSj1ZSuzSzA94S3SQT0tGWP7Nb7vQKaKxbk93AY9lAS0g9STwin
         VInQNyDvR6AKNdy+V3e7zTcGYHnpPq8c93aAcDPtMhlXt5PmfHVYXHuIjNe59HqlaLKr
         687TU7gsChFOChcUAXq11wFDKA2+SJ1y3+36HZWEc0532UqarxBAhIxLKGVh0UvPGo39
         E8dw==
X-Forwarded-Encrypted: i=1; AJvYcCWFkUZSerHjBc/fbGYH1dKKEF1zzg4/OMGKX3aBsIOc6xT03kJHB+PtUh+R2pfO79AebuxJm3H05Eo9P3Kr39s=@vger.kernel.org, AJvYcCXeLclPoRWORk0CipBek/t2JJIgzHT+NV59TS1W6Wo9x3DwNGKKsCi1fbdFA7Xd/G7inS3Cbx4Kcmu6Vjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywpfclC5H5twRMaoPQIDAwOdxwme5WICJYlkgj5p2NMq8/UMpU
	v8Um/FAg+V7+DcBbnPf9dM8IBeNEIkPO2SE3NlVwfFKpOXlYw87ojxwZlQ==
X-Gm-Gg: ASbGncu/O7sKLGY2J67SNzXYLCJHezgGR6b8X/ULWQumbIJa0quVIwZ6+Smog4nx+rL
	Q+AwiX3ji+wvX4kpla08XmOjxTlaN8I3Djprlnr1aAZuchSZBic2W6wbj4/uuogX24Ti02ytY6Z
	vi4uOXqCKrvD0CDFHFa6xZJSSS7pZ2IOang+52lQKfyCk0v8GgWdiiSFCuuHWHiXmFZirmHhoVe
	svhJq4m/SLSEgsd7/5X0WQFTnnvgYwZvFv7QqrD7f8KX9shvWMHHoIqQ1/dKOockwhrTITobLkc
	jPBg3LQhWp8cN0UlHhKIfkfrJBbzUWe76pOPskIQd8Gy2FUluDzXDzPIQCm9QGCUtLQwewB7w/l
	2nUdWd9sc
X-Google-Smtp-Source: AGHT+IGq1fI35gik96GCCWyr5+ysttTI1uvzCXcbmtTPSdAO/DNcMcX+K4afMszvX747WiJOvVxbhg==
X-Received: by 2002:a5d:6483:0:b0:38d:dfb8:3679 with SMTP id ffacd0b85a97d-39ad174c842mr215483f8f.17.1743009118657;
        Wed, 26 Mar 2025 10:11:58 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a325csm17223763f8f.22.2025.03.26.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:11:57 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:11:56 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] openrisc: Introduce new utility functions to
 flush and invalidate caches
Message-ID: <Z-Q1XChWkZjrt_6t@antec>
References: <20250323195544.152948-1-sahilcdq@proton.me>
 <20250323195544.152948-3-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323195544.152948-3-sahilcdq@proton.me>

On Mon, Mar 24, 2025 at 01:25:43AM +0530, Sahil Siddiq wrote:
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
>  arch/openrisc/include/asm/cacheflush.h | 17 +++++++++
>  arch/openrisc/include/asm/cpuinfo.h    | 42 +++++++++++++++++++++
>  arch/openrisc/kernel/dma.c             | 18 ++-------
>  arch/openrisc/mm/cache.c               | 52 ++++++++++++++++++++++----
>  arch/openrisc/mm/init.c                |  5 ++-
>  5 files changed, 110 insertions(+), 24 deletions(-)
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
> index 82f5d4c06314..7839c41152af 100644
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
> @@ -34,4 +37,43 @@ struct cpuinfo_or1k {
>  extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
>  extern void setup_cpuinfo(void);
>  
> +/*
> + * Check if the cache component exists.
> + */
> +static inline bool cpu_cache_is_present(const unsigned int cache_type)
> +{
> +	unsigned long upr = mfspr(SPR_UPR);
> +
> +	return !!(upr & (SPR_UPR_UP | cache_type));
> +}
> +
> +/*
> + * Check if the cache block flush/invalidate register is implemented for the
> + * cache component.
> + */
> +static inline bool cb_inv_flush_is_implemented(const unsigned int reg,
> +					       const unsigned int cache_type)
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
> +	 * The cache block flush register is not implemented for the instruction cache.
> +	 */
> +	if (cache_type == SPR_UPR_ICP) {
> +		cfgr = mfspr(SPR_ICCFGR);
> +		return !!(cfgr & SPR_ICCFGR_CBIRI);
> +	}
> +
> +	return false;
> +}

Could these 2 functions move to cache.c?

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
> index eb43b73f3855..aca64c5a20b3 100644
> --- a/arch/openrisc/mm/cache.c
> +++ b/arch/openrisc/mm/cache.c
> @@ -14,31 +14,67 @@
>  #include <asm/spr_defs.h>
>  #include <asm/cache.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpuinfo.h>
>  #include <asm/tlbflush.h>
>  
> -static __always_inline void cache_loop(struct page *page, const unsigned int reg)
> +static __always_inline void cache_loop(struct page *page, unsigned long *start,
> +				       unsigned long *end, const unsigned int reg,
> +				       const unsigned int cache_type)
>  {
> -	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> -	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> +	unsigned long paddr, next;
>  
> -	while (line < paddr + PAGE_SIZE) {
> -		mtspr(reg, line);
> -		line += L1_CACHE_BYTES;
> +	if (!cpu_cache_is_present(cache_type))
> +		return;
> +
> +	if (!cb_inv_flush_is_implemented(reg, cache_type))
> +		return;

This check may be a bit overkill, but OK.

> +	if (page) {
> +		paddr = page_to_pfn(page) << PAGE_SHIFT;
> +		next = paddr + PAGE_SIZE;
> +		paddr &= ~(L1_CACHE_BYTES - 1);
> +	} else if (start && end) {
> +		paddr = *start;
> +		next = *end;

Overloading the one function with page and start/end seems a bit messy.

It may be nicer to have 2 functions:

  cache_loop_page(page, reg, cache_type) {
     unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
     unsiogned long end = paddr + PAGE_SIZE;
     paddr &= ~(L1_CACHE_BYTES - 1);
     cache_loop(paddr, end, reg, cache_type);
  }

  cache_loop(start, end, reg, cache_type)

> +	} else {
> +		printk(KERN_ERR "Missing start and/or end address.\n");
> +		return;

Then this could be removed.

> +	}
> +
> +	while (paddr < next) {
> +		mtspr(reg, paddr);
> +		paddr += L1_CACHE_BYTES;
>  	}
>  }
>  
>  void local_dcache_page_flush(struct page *page)
>  {
> -	cache_loop(page, SPR_DCBFR);
> +	cache_loop(page, NULL, NULL, SPR_DCBFR, SPR_UPR_DCP);
>  }
>  EXPORT_SYMBOL(local_dcache_page_flush);
>  
>  void local_icache_page_inv(struct page *page)
>  {
> -	cache_loop(page, SPR_ICBIR);
> +	cache_loop(page, NULL, NULL, SPR_ICBIR, SPR_UPR_ICP);
>  }
>  EXPORT_SYMBOL(local_icache_page_inv);
>  
> +void local_dcache_range_flush(unsigned long start, unsigned long end)
> +{
> +	cache_loop(NULL, &start, &end, SPR_DCBFR, SPR_UPR_DCP);
> +}
> +
> +void local_dcache_range_inv(unsigned long start, unsigned long end)
> +{
> +	cache_loop(NULL, &start, &end, SPR_DCBIR, SPR_UPR_DCP);
> +}
> +
> +void local_icache_range_inv(unsigned long start, unsigned long end)
> +{
> +	cache_loop(NULL, &start, &end, SPR_ICBIR, SPR_UPR_ICP);
> +}
> +
> +
>  void update_cache(struct vm_area_struct *vma, unsigned long address,
>  	pte_t *pte)
>  {
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

OK.

>  	/* New TLB miss handlers and kernel page tables are in now place.
>  	 * Make sure that page flags get updated for all pages in TLB by
> -- 
> 2.48.1
> 
