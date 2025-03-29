Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61218641;
	Sat, 29 Mar 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743231662; cv=none; b=A+LexYXNPDrDbuDxpw4v1MQysEH0D6TZBghcNrROOeiFe6Clkt4WkY/ZJfV9DrDh+6lACM9zoVtCQS84gt5vNGitkJ42qJ4HQpoPiGBUvm6wcEABPdkZZEu4qnx4jhBS86h9jAFZBTBQwi1iGmHWw6HWP+JfnVsrDlC2yoTdIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743231662; c=relaxed/simple;
	bh=SIgxLnOI5/TBUEB96Qt9TXxf6PQWCf+1f5n0SZ3olnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTGG91pM8FCuPUA2ywHIx0gL93Lco7Syq+WFFTVN6OilBPu/AeyXz3fk+G3YpkqaIarcSByaD8bqMyfd/RYW/GvKiCWt63rXiX6wbs5Msh+VRu/Ghlmm5CjquUUXtqTOz5y//5j8aWP21YgkZDWIF2WKbRmqo/XMW0PbOQWUKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp8hwALT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp8hwALT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so58366375ad.1;
        Sat, 29 Mar 2025 00:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743231660; x=1743836460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YN4WtqthsWkXxUqce00UcuHYVqDvhZTDgvAWdF2pTa8=;
        b=Mp8hwALTCeVqXkAqP5fdtxN6BX7TjWTAENgPv/3qAUF+9j2O54L4O8KUVTZwU2zxCk
         9Z+kxDlBVsM9nTtd1EYW9o59WRVA0ORdgcWGFs3GCFZj1Sap/bQrz6TK5UXYL5blC9Ec
         PLkReI8eaM9xbuDCEEEIsePvr15J1O1CSdYWicGx+LFscrTmjjp7djf5DsjVKMu5HtUB
         B6fpO1OEalyjBtmmjXvcuJTnzYhkqaog21CGDtybUHk2U1wMq8Ejz0vCv8NdXdY9+74+
         q0kxsQqRCPLee3EArgDdNwmRehhn4nLT487lxtlw8AL2ZjadBLG/8mQG8ufEgcQhFJ6I
         L+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743231660; x=1743836460;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN4WtqthsWkXxUqce00UcuHYVqDvhZTDgvAWdF2pTa8=;
        b=ANMA9Apz8CUuxd6F5rGApIF32GoTPsXKDKbJc9lhUM0rUsBz6ydg/UP7lOI209hdr7
         FkrNHYO1p4ad1GQHUzii9wiCvy+ZUo270cB0Zq6iYQYI63SGhAw85b93jAVynNgNB1hS
         Ge7mYVGr2DepJOUYFCazuvcN7S85weTNhiHi+f82LZ5w9PIpDjnGgB9DlzLl4MLDgz2o
         KImHlPqE1JifEcmOlgBjo29Wx9FrEM80cIGXP2g12wL5O3XS9d6H2IDd+vPY0NZiLYY9
         S7DFUJiJxmaKif+mXhSOnUzx2RLnstJ/N8XHjfc4iq7fWqGFbs/3lpSSsjdoDuHpmSJE
         TGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJGnBjl0oypc+TNhkZbPF2W4IYwkinYUdHEq0vy6iug7DtuIAyQFujazZCGBUIF3dsyVNiioLEw7cZr50RnWk=@vger.kernel.org, AJvYcCXXcdqERNBzSx/9AptELjh54pqkq4y8RNJ1cHfa9gzEdU48Se2lnQ2pq+11ABRPFfV3b7qfYNr3bavt1+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLE/dPlStwbwiXtk9zxUed2TbfIDfknEwqVKOjyfsdyeaaPYDf
	M9u6JCdffvrN5GvLErcokZr7zhMY9+A57jSX9mF9/H4qDH4dGXqG
X-Gm-Gg: ASbGncuN4bi3IBJw26QYavzblWHfTW0l+Cn9uc5UuFYT1KCGvp7zY1GPj6SOAoZtd7U
	VbxA6O4h9eYqFz0il1XUo2xRNumFzxht8r+uXb1LWDNw6rb2oLRRn3BEwH4kDqweyaDCi6yDU9L
	pGBY4Z3AALO5MdOwWohmLXA/5YASeIr8mPbgdE6WAP/kX6tVZ8lsFwQMDq2LuhxhIqAuszZasQN
	quMgTA3SfH1n4i40VSuyn8r95Aphl+1pIvZBiFuHCI/Nqz3hmZ5tJ/3uh6NZDLhBMqC6XA44qqX
	UR35iLsCE29djVjUWG2286Hcii78LgUJqYNOvO85CeDRh3WtJtDvrxCveDEw1JiB97RV3UvdCu9
	1WjM8kF0=
X-Google-Smtp-Source: AGHT+IGprp313xVlqEgzUJTa5QBlXqqlQP1W/B++E5Rb4AP4oIoboJipGCREYWl/oiECUeFm4sWNxQ==
X-Received: by 2002:a17:902:ebc7:b0:224:160d:3f54 with SMTP id d9443c01a7336-2292f97caa0mr33858535ad.31.1743231659870;
        Sat, 29 Mar 2025 00:00:59 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6? ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf93esm29287565ad.154.2025.03.29.00.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 00:00:59 -0700 (PDT)
Message-ID: <79beab1d-550f-462f-93b5-a887f9208a8e@gmail.com>
Date: Sat, 29 Mar 2025 12:30:53 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] openrisc: Introduce new utility functions to flush
 and invalidate caches
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250328202632.72809-1-sahilcdq@proton.me>
 <20250328202632.72809-3-sahilcdq@proton.me> <Z-cZLwdbkemRGOJT@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z-cZLwdbkemRGOJT@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/29/25 3:18 AM, Stafford Horne wrote:
> On Sat, Mar 29, 2025 at 01:56:31AM +0530, Sahil Siddiq wrote:
>> [...]
>> diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
>> index 82f5d4c06314..e46afbfe9b5a 100644
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
>> @@ -34,4 +37,16 @@ struct cpuinfo_or1k {
>>   extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
>>   extern void setup_cpuinfo(void);
>>   
>> +/*
>> + * Check if the cache component exists.
>> + */
>> +extern bool cpu_cache_is_present(const unsigned int cache_type);
> 
> This is used in cacheinfo.  OK.
> 
>> +/*
>> + * Check if the cache block flush/invalidate register is implemented for the
>> + * cache component.
>> + */
>> +extern bool cb_inv_flush_is_implemented(const unsigned int reg,
>> +					const unsigned int cache_type);
> 
> But this function doesnt seem to be used anywhere but in cache.c. Does it need
> to be public?
> 

Right, this doesn't have to be public. However, based on the description below, it's
better to remove this function.

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
>> index eb43b73f3855..3bf6d728d2d2 100644
>> --- a/arch/openrisc/mm/cache.c
>> +++ b/arch/openrisc/mm/cache.c
>> @@ -14,31 +14,63 @@
>>   #include <asm/spr_defs.h>
>>   #include <asm/cache.h>
>>   #include <asm/cacheflush.h>
>> +#include <asm/cpuinfo.h>
>>   #include <asm/tlbflush.h>
>>   
>> -static __always_inline void cache_loop(struct page *page, const unsigned int reg)
>> +static __always_inline void cache_loop(unsigned long paddr, unsigned long end,
>> +				       const unsigned int reg, const unsigned int cache_type)
>>   {
>> -	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>> -	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
>> +	if (!cpu_cache_is_present(cache_type))
>> +		return;
>> +
>> +	if (!cb_inv_flush_is_implemented(reg, cache_type))
>> +		return;
>>   
>> -	while (line < paddr + PAGE_SIZE) {
>> -		mtspr(reg, line);
>> -		line += L1_CACHE_BYTES;
>> +	while (paddr < end) {
>> +		mtspr(reg, paddr);
>> +		paddr += L1_CACHE_BYTES;
>>   	}
>>   }
>>   
>> +static void cache_loop_page(struct page *page, const unsigned int reg,
>> +					    const unsigned int cache_type)
>> +{
>> +	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>> +	unsigned long end = paddr + PAGE_SIZE;
>> +
>> +	paddr &= ~(L1_CACHE_BYTES - 1);
>> +
>> +	cache_loop(paddr, end, reg, cache_type);
>> +}
>> +
>>   void local_dcache_page_flush(struct page *page)
>>   {
>> -	cache_loop(page, SPR_DCBFR);
>> +	cache_loop_page(page, SPR_DCBFR, SPR_UPR_DCP);
>>   }
>>   EXPORT_SYMBOL(local_dcache_page_flush);
>>   
>>   void local_icache_page_inv(struct page *page)
>>   {
>> -	cache_loop(page, SPR_ICBIR);
>> +	cache_loop_page(page, SPR_ICBIR, SPR_UPR_ICP);
>>   }
>>   EXPORT_SYMBOL(local_icache_page_inv);
>>   
>> +void local_dcache_range_flush(unsigned long start, unsigned long end)
>> +{
>> +	cache_loop(start, end, SPR_DCBFR, SPR_UPR_DCP);
>> +}
>> +
>> +void local_dcache_range_inv(unsigned long start, unsigned long end)
>> +{
>> +	cache_loop(start, end, SPR_DCBIR, SPR_UPR_DCP);
>> +}
>> +
>> +void local_icache_range_inv(unsigned long start, unsigned long end)
>> +{
>> +	cache_loop(start, end, SPR_ICBIR, SPR_UPR_ICP);
>> +}
>> +
>> +
> 
> There is an extra newline here.

Oh, I missed this. I'll fix it.

>>   void update_cache(struct vm_area_struct *vma, unsigned long address,
>>   	pte_t *pte)
>>   {
>> @@ -59,3 +91,42 @@ void update_cache(struct vm_area_struct *vma, unsigned long address,
>>   	}
>>   }
>>   
>> +/*
>> + * Check if the cache component exists.
>> + */
>> +bool cpu_cache_is_present(const unsigned int cache_type)
>> +{
>> +	unsigned long upr = mfspr(SPR_UPR);
>> +
>> +	return !!(upr & (SPR_UPR_UP | cache_type));
>> +}
>> +
>> + /*
>> +  * Check if the cache block flush/invalidate register is implemented for the
>> +  * cache component.
>> +  */
>> +bool cb_inv_flush_is_implemented(const unsigned int reg,
>> +				 const unsigned int cache_type)
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
>> +	 * The cache block flush register is not implemented for the instruction
>> +	 * cache.
>> +	 */
>> +	if (cache_type == SPR_UPR_ICP) {
>> +		cfgr = mfspr(SPR_ICCFGR);
>> +		return !!(cfgr & SPR_ICCFGR_CBIRI);
>> +	}
>> +
>> +	return false;
>> +}
> 
> Usually we try to define functions before they are used.  This and
> cpu_cache_is_present should be above cache_loop.

Got it. I'll shift this.

> As I mentioned, this may be a bit overkill, OpenRISC completely ignore writes to
> SPR registers that are not implemented.  They are basically nops.  It may help
> to avoid running cache loops, but really there are no implementations I know of
> that have caches (SPR_UPR_UP) but no cache invalidation/flush registers.
> 

Understood. I'll remove this function.

Thanks,
Sahil
