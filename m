Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB21E47A8;
	Fri, 28 Mar 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190823; cv=none; b=scEtpgEX1BovSKC90xynQzGh+hwWDRDffQC2i58uLsHZHoDo4ZHNGgM+yZqzteeCUS3oUxcngHLCo/CwfqqW+Nd5ysaZBhj/Xz3tOqTxYb9AwWLHowxjUk8wUIChMg/KZzuHOebVGjAdR8vqg4WMyCBOeZQRsUl97RY/wpecU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190823; c=relaxed/simple;
	bh=KKsyUxQ4/2JEE6+ClC2SNHy3GGNOF2LGSwEg6SNrX+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/OvwupEtFj5JAa3m5YvIFOHGRKnGkOUtgFEiGSUNRm8yBhBiN3+o3dp5UuL8C6RXEPczEqsvI0GjtWzZTmvG0zc1t7+wYHEd4Cig8Bf/tWZ3VX0YfbClKMCR0/kYca26Qdx5hmR7pT7MkmaYL7Vvv+dWtTFLCHpPxTxcbYfkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEYrYeAz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEYrYeAz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22622ddcc35so15508505ad.2;
        Fri, 28 Mar 2025 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743190821; x=1743795621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+1j76gMNeF+UKc3KMqp9AFFWx61AcVlZYyQ1Yks6V18=;
        b=ZEYrYeAzruyRqrqEmnzt9J2N5+dHKb/O5m0gwjDY5R9+RU5IBYdCNOy80OLrHVq468
         8konMbq5dUr4sbuDRhpzxdpkrUvckanvRfg0q9Hj/eU+9lCLP4VutZr3ZFWEJY2+t2Te
         7fkauQXhGY804EqpVKSOIaerA3fTjFcM6Ede9Z1WdZO06zwcDRflw5v5pga1HdhLpItB
         NB63PXnAlinT6BENU6s/QUhwLgEdZuZVAaMr265UOpHHcorNEwsroYfogWGMh66RahXI
         8g56MlFDv/6NFTSPYoRlojDD5GaTpiRrFYWRdQIO1cvz8clBTk3CHTwj1B1QAoZgNSDG
         nkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190821; x=1743795621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1j76gMNeF+UKc3KMqp9AFFWx61AcVlZYyQ1Yks6V18=;
        b=u6HHIl43Ppk7DD6pvmpzLWnvBQKvzXuW37tKH/dvl9qD8+gp1EtzJoWIqDYvua5ZDZ
         IKF3gkxEJzuhH/wen7Bskuh79RyaVbVl6cfqWV1NLH9SljDy1P70d+mFXYIFZq9NMxFj
         sVjGSkR0KL8PuBBYSRPln1GHKIWsVAwvJRTIICbr7KeSDMiNyMuFK9S9YMuNewnUa45y
         gXMkfUw03ETNsaSXodPJr8/pQNcC1Lu28frDlKfYH/6o0mAMe0LPy6Sq1fFL36cFyMpO
         J41xMo+CvvRAi/3bpeIOLgdwZxSO8rw5FmeZNghLTQe2N4P1+VMfhPwKtG1UR7Bf5Ue8
         QGpA==
X-Forwarded-Encrypted: i=1; AJvYcCVO7N20QlP97bsF3aDzZ6BrSC6loADWJdnFOx3uqDqQWZ2A+ru4dCid8BherXlyFt3hmuvavvR6XaFr4oI=@vger.kernel.org, AJvYcCWd1owRoyq5e23I97xPubLvpSQh4/MmPUZb+tuhVKJD+ys0iOpbdIzbOr/w6EWUS8RPaLyC0tfV0N8/wp88FtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhbC/4wv9KMOAeGTK+noX438A1usDP6BvkebtsUZn9WDxYg4d
	tNJpdvFr4Lh0gOiawqLGYM4nLKFQPKtthqhvQiYBRPxEcTaSSxKKoo3qLA==
X-Gm-Gg: ASbGncv0F3fRaburfFkssPSz8djj9GXDO6ZaIxFiYriyLD9MLg9a0QCIDzar2KcsAx8
	x50/eQ4Oj2qKI9+b0ciBZ4htejDoxa7N10WmAXcR//FkDUuYUdN9P+CJwAi74saNysS//qwRALL
	REBa2BYTpbLQPHIAZAolQIMwQCOn3Lnv3xAPOKqmTN6bbEJFeyHp3nfTCowQM1i3nFOl9f7sIfz
	ehTSwInB4NggwjC/7y7wsM+U0rtYVCEsTdTTDTEGwMuavE9uE037pT8UjRfc0ZOfSYW8lME5ch7
	rBXVoQ+qy06TJ6D4sHmwcuCU9ovr3QtYzANJGmw/3Qgc/qZIeEzzrQWUUfIj4iHLVBLzY7jpRih
	4kUEIGN/xabNg
X-Google-Smtp-Source: AGHT+IEmpk3kF1M9aSJxpWUx5foJSOKCpx3QH1t670AMmybb2Xyokz9GqYU6LbfCz/yHw8PYjMX5Ww==
X-Received: by 2002:a17:903:240a:b0:223:65a9:ab86 with SMTP id d9443c01a7336-2292f9547e3mr8082045ad.12.1743190820622;
        Fri, 28 Mar 2025 12:40:20 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d? ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f8badsm22325135ad.246.2025.03.28.12.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 12:40:20 -0700 (PDT)
Message-ID: <5a62c225-243e-49c6-b1ea-c30fef2313b9@gmail.com>
Date: Sat, 29 Mar 2025 01:10:15 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] openrisc: Introduce new utility functions to flush
 and invalidate caches
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250323195544.152948-1-sahilcdq@proton.me>
 <20250323195544.152948-3-sahilcdq@proton.me> <Z-Q1XChWkZjrt_6t@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z-Q1XChWkZjrt_6t@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thank you for the review.

On 3/26/25 10:41 PM, Stafford Horne wrote:
> On Mon, Mar 24, 2025 at 01:25:43AM +0530, Sahil Siddiq wrote:
>> According to the OpenRISC architecture manual, the dcache and icache may
>> not be present. When these caches are present, the invalidate and flush
>> registers may be absent. The current implementation does not perform
>> checks to verify their presence before utilizing cache registers, or
>> invalidating and flushing cache blocks.
>>
>> Introduce new functions to detect the presence of cache components and
>> related special-purpose registers.
>>
>> There are a few places where a range of addresses have to be flushed or
>> invalidated and the implementation is duplicated. Introduce new utility
>> functions and macros that generalize this implementation and reduce
>> duplication.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> ---
>> Changes from v2 -> v3:
>> - arch/openrisc/include/asm/cacheflush.h: Declare new functions and macros.
>> - arch/openrisc/include/asm/cpuinfo.h: Implement new functions.
>>    (cpu_cache_is_present):
>>    1. The implementation of this function was strewn all over the place in
>>       the previous versions.
>>    2. Fix condition. The condition in the previous version was incorrect.
>>    (cb_inv_flush_is_implemented): New function.
>> - arch/openrisc/kernel/dma.c: Use new functions.
>> - arch/openrisc/mm/cache.c:
>>    (cache_loop): Extend function.
>>    (local_*_page_*): Use new cache_loop interface.
>>    (local_*_range_*): Implement new functions.
>> - arch/openrisc/mm/init.c: Use new functions.
>>
>>   arch/openrisc/include/asm/cacheflush.h | 17 +++++++++
>>   arch/openrisc/include/asm/cpuinfo.h    | 42 +++++++++++++++++++++
>>   arch/openrisc/kernel/dma.c             | 18 ++-------
>>   arch/openrisc/mm/cache.c               | 52 ++++++++++++++++++++++----
>>   arch/openrisc/mm/init.c                |  5 ++-
>>   5 files changed, 110 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
>> index 984c331ff5f4..0e60af486ec1 100644
>> --- a/arch/openrisc/include/asm/cacheflush.h
>> +++ b/arch/openrisc/include/asm/cacheflush.h
>> @@ -23,6 +23,9 @@
>>    */
>>   extern void local_dcache_page_flush(struct page *page);
>>   extern void local_icache_page_inv(struct page *page);
>> +extern void local_dcache_range_flush(unsigned long start, unsigned long end);
>> +extern void local_dcache_range_inv(unsigned long start, unsigned long end);
>> +extern void local_icache_range_inv(unsigned long start, unsigned long end);
>>   
>>   /*
>>    * Data cache flushing always happen on the local cpu. Instruction cache
>> @@ -38,6 +41,20 @@ extern void local_icache_page_inv(struct page *page);
>>   extern void smp_icache_page_inv(struct page *page);
>>   #endif /* CONFIG_SMP */
>>   
>> +/*
>> + * Even if the actual block size is larger than L1_CACHE_BYTES, paddr
>> + * can be incremented by L1_CACHE_BYTES. When paddr is written to the
>> + * invalidate register, the entire cache line encompassing this address
>> + * is invalidated. Each subsequent reference to the same cache line will
>> + * not affect the invalidation process.
>> + */
>> +#define local_dcache_block_flush(addr) \
>> +	local_dcache_range_flush(addr, addr + L1_CACHE_BYTES)
>> +#define local_dcache_block_inv(addr) \
>> +	local_dcache_range_inv(addr, addr + L1_CACHE_BYTES)
>> +#define local_icache_block_inv(addr) \
>> +	local_icache_range_inv(addr, addr + L1_CACHE_BYTES)
>> +
>>   /*
>>    * Synchronizes caches. Whenever a cpu writes executable code to memory, this
>>    * should be called to make sure the processor sees the newly written code.
>> diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
>> index 82f5d4c06314..7839c41152af 100644
>> --- a/arch/openrisc/include/asm/cpuinfo.h
>> +++ b/arch/openrisc/include/asm/cpuinfo.h
>> @@ -15,6 +15,9 @@
>>   #ifndef __ASM_OPENRISC_CPUINFO_H
>>   #define __ASM_OPENRISC_CPUINFO_H
>>   
>> +#include <asm/spr.h>
>> +#include <asm/spr_defs.h>
>> +
>>   struct cache_desc {
>>   	u32 size;
>>   	u32 sets;
>> @@ -34,4 +37,43 @@ struct cpuinfo_or1k {
>>   extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
>>   extern void setup_cpuinfo(void);
>>   
>> +/*
>> + * Check if the cache component exists.
>> + */
>> +static inline bool cpu_cache_is_present(const unsigned int cache_type)
>> +{
>> +	unsigned long upr = mfspr(SPR_UPR);
>> +
>> +	return !!(upr & (SPR_UPR_UP | cache_type));
>> +}
>> +
>> +/*
>> + * Check if the cache block flush/invalidate register is implemented for the
>> + * cache component.
>> + */
>> +static inline bool cb_inv_flush_is_implemented(const unsigned int reg,
>> +					       const unsigned int cache_type)
>> +{
>> +	unsigned long cfgr;
>> +
>> +	if (cache_type == SPR_UPR_DCP) {
>> +		cfgr = mfspr(SPR_DCCFGR);
>> +		if (reg == SPR_DCBFR)
>> +			return !!(cfgr & SPR_DCCFGR_CBFRI);
>> +
>> +		if (reg == SPR_DCBIR)
>> +			return !!(cfgr & SPR_DCCFGR_CBIRI);
>> +	}
>> +
>> +	/*
>> +	 * The cache block flush register is not implemented for the instruction cache.
>> +	 */
>> +	if (cache_type == SPR_UPR_ICP) {
>> +		cfgr = mfspr(SPR_ICCFGR);
>> +		return !!(cfgr & SPR_ICCFGR_CBIRI);
>> +	}
>> +
>> +	return false;
>> +}
> 
> Could these 2 functions move to cache.c?

Sure, I'll do that.

>>   #endif /* __ASM_OPENRISC_CPUINFO_H */
>> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
>> index b3edbb33b621..3a7b5baaa450 100644
>> --- a/arch/openrisc/kernel/dma.c
>> +++ b/arch/openrisc/kernel/dma.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/pagewalk.h>
>>   
>>   #include <asm/cpuinfo.h>
>> +#include <asm/cacheflush.h>
>>   #include <asm/spr_defs.h>
>>   #include <asm/tlbflush.h>
>>   
>> @@ -24,9 +25,6 @@ static int
>>   page_set_nocache(pte_t *pte, unsigned long addr,
>>   		 unsigned long next, struct mm_walk *walk)
>>   {
>> -	unsigned long cl;
>> -	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
>> -
>>   	pte_val(*pte) |= _PAGE_CI;
>>   
>>   	/*
>> @@ -36,8 +34,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
>>   	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>   
>>   	/* Flush page out of dcache */
>> -	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
>> -		mtspr(SPR_DCBFR, cl);
>> +	local_dcache_range_flush(__pa(addr), __pa(next));
>>   
>>   	return 0;
>>   }
>> @@ -98,21 +95,14 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
>>   void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
>>   		enum dma_data_direction dir)
>>   {
>> -	unsigned long cl;
>> -	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
>> -
>>   	switch (dir) {
>>   	case DMA_TO_DEVICE:
>>   		/* Flush the dcache for the requested range */
>> -		for (cl = addr; cl < addr + size;
>> -		     cl += cpuinfo->dcache_block_size)
>> -			mtspr(SPR_DCBFR, cl);
>> +		local_dcache_range_flush(addr, addr + size);
>>   		break;
>>   	case DMA_FROM_DEVICE:
>>   		/* Invalidate the dcache for the requested range */
>> -		for (cl = addr; cl < addr + size;
>> -		     cl += cpuinfo->dcache_block_size)
>> -			mtspr(SPR_DCBIR, cl);
>> +		local_dcache_range_inv(addr, addr + size);
>>   		break;
>>   	default:
>>   		/*
>> diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
>> index eb43b73f3855..aca64c5a20b3 100644
>> --- a/arch/openrisc/mm/cache.c
>> +++ b/arch/openrisc/mm/cache.c
>> @@ -14,31 +14,67 @@
>>   #include <asm/spr_defs.h>
>>   #include <asm/cache.h>
>>   #include <asm/cacheflush.h>
>> +#include <asm/cpuinfo.h>
>>   #include <asm/tlbflush.h>
>>   
>> -static __always_inline void cache_loop(struct page *page, const unsigned int reg)
>> +static __always_inline void cache_loop(struct page *page, unsigned long *start,
>> +				       unsigned long *end, const unsigned int reg,
>> +				       const unsigned int cache_type)
>>   {
>> -	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>> -	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
>> +	unsigned long paddr, next;
>>   
>> -	while (line < paddr + PAGE_SIZE) {
>> -		mtspr(reg, line);
>> -		line += L1_CACHE_BYTES;
>> +	if (!cpu_cache_is_present(cache_type))
>> +		return;
>> +
>> +	if (!cb_inv_flush_is_implemented(reg, cache_type))
>> +		return;
> 
> This check may be a bit overkill, but OK.

I thought I would implement this because I was not sure of what would happen
when attempting to read from these registers in a processor that didn't have
them.

>> +	if (page) {
>> +		paddr = page_to_pfn(page) << PAGE_SHIFT;
>> +		next = paddr + PAGE_SIZE;
>> +		paddr &= ~(L1_CACHE_BYTES - 1);
>> +	} else if (start && end) {
>> +		paddr = *start;
>> +		next = *end;
> 
> Overloading the one function with page and start/end seems a bit messy.
> 
> It may be nicer to have 2 functions:
> 
>    cache_loop_page(page, reg, cache_type) {
>       unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>       unsiogned long end = paddr + PAGE_SIZE;
>       paddr &= ~(L1_CACHE_BYTES - 1);
>       cache_loop(paddr, end, reg, cache_type);
>    }
> 
>    cache_loop(start, end, reg, cache_type)
> 
>> +	} else {
>> +		printk(KERN_ERR "Missing start and/or end address.\n");
>> +		return;
> 
> Then this could be removed.

I agree. This is cleaner. I'll make the relevant changes.

Thanks,
Sahil
