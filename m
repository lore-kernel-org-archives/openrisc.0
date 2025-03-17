Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D11C8602;
	Mon, 17 Mar 2025 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236599; cv=none; b=iTV/fPrtgDM9DXsaTkfYoQsLECVN4sdHvrq0ZRE14GfMW+VZFSm57QNKQTQ7QlaZB+0xcFT65mUZ0ulZMB3Rbr2WsKJ5cU1AHI25RoZb4Q3sZFSxl7CJEVF90tJrQI8HqdwhgkIINeR7UeDOoxN/LCixad9Tz/l++ZXS845AKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236599; c=relaxed/simple;
	bh=KrPfI8u+KTHxiIfxreoPc062SIJpqGxycaHqTqTQ2Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=me5TbdCoE3tmQIaUhL1KqbPnLXUm78HN2Bf8Y1IsoyoLvkCif+XL5YWhgNhTKku94iHu//R7j/VQ5JFtn2eUY8MV9sUqMiEXQPHas/rFsUy+igLHVVFw7fjpkF+Ve31mHnV85lWE9yaHEygiAM2YWK7aGQufXDQn1lu52VIV+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkoUtzEr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkoUtzEr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223a7065ff8so52305305ad.0;
        Mon, 17 Mar 2025 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742236596; x=1742841396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=35xW/q0P3gfqWEbO9Z//OBJEMGPEl1K3Vv4FMtFvJhU=;
        b=lkoUtzEr0Jo2OBrB+YiF5ha6g6Th+LCM670mF4Ojy54BethUQOWghrHCxdEj067QNu
         xVVqKe5T9lj00cVTC+UuMNE06Hh3+vAZDLONjKSYgsnhLUN2zGUZAkLV4HjvUeitmCjf
         o41UiFsRF3mIkazBy9DOcxRgT/y2KiISIDQmVXq72zmV+gt4jsoH6QDYo7Vc43wWuafT
         w5N5KUss8u5FECM+3w/AiXxtBnE8+REpa2JjHf7Tr/8RHQYGXHrYqJ2gKmL94QEF3hd2
         dPCCquBuExFeT03Ae8jwznijLSvUCQMlUgvCEQ/fpdBCpcZkpp89whXDzEr3MrRST7+7
         2gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742236596; x=1742841396;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35xW/q0P3gfqWEbO9Z//OBJEMGPEl1K3Vv4FMtFvJhU=;
        b=ThrPb3NH1l6k8O2fSRv3pLnRHBqECKwTjrnPKSS+/cjYzIvQAU4nwHXJR1zUciPtl0
         Y9EMFgy/W9oqu9EZcESM2UwbGzg/ca4RrT+j5rel/SREilj1g166wI70Uw1ZoO7jbYAk
         a7bPxivAODjsET4FrzE87/lOaufyzSvqhXsuJplKnsJ+Ch1cbZm8cQpF/F2PJij2Tjn2
         +fKyqbwLWsoac4xKRSGgdjMY6wx9ur00Yx2FOdZF92mgzhOK8seqFbV+2QNWndYESnAK
         vCRhqIcn3+lvySQVIkcBhBjOmRNXRq8idR9xaKqII0AEG3SSs/ZwrnvP5j/z8cg+uSH/
         iiWg==
X-Forwarded-Encrypted: i=1; AJvYcCUVmCL+xWNfX9mqrtmpiNwA6Bwz5FivAa83QISbOpZpsMvH7wYIzPzHBAcq7DoIQl3hrc0xiQ593U1+Llb2DXY=@vger.kernel.org, AJvYcCW8oNqZugbqINSgQTgku1n3S3+7YIm9DwkOaIzFppMwvyE0NWMzBG4MhQyD/iUnKCJThHDeQvTRS46RS1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4ABvCxRnHO5Z/ERoSHjPUDG/Wpn9f0GXW5j7wsKORSxf+qBJ
	3o7tV5gp0d6yieByw5FvGKVpgqTvnuiSH1unesqhUDK9L9IzPhbm
X-Gm-Gg: ASbGncsU5oixYavVT3JrHvzC4jo9e8Hnh7ThBQCS+QyeO3LAVN82K5TjozhOPX+EMLk
	6DxmGvHIjrZEVfUNXXliHawJAHHGuvHBwOKOt5aJXfRJg/thNAws8BArnsV2Ahbv5YT/HWmj8qc
	+V+D1OrA0vCV7xWo16pWdIcgrOCBAA3NKDWSBfqVJtSTZrXpojgpir0lOuzGKoHrp/+CIJmandA
	6sKVIqeZPbRDbSNPice5ecsckaLz0GwGtKSxRBNJexdYiQnCG5EUDPz3j08Gq8VtuSHaAaWGRC1
	dXDtFgZdF6Lo3UC7
X-Google-Smtp-Source: AGHT+IHrr/LRS1M+JxVQAyURwncywZDsb1BQPKD9BMtZ274xbCp4WAlnp8+qlpymCZwNRNnEczAa7A==
X-Received: by 2002:a17:902:d584:b0:223:517a:d2e2 with SMTP id d9443c01a7336-225e0b658b8mr191550475ad.53.1742236596362;
        Mon, 17 Mar 2025 11:36:36 -0700 (PDT)
Received: from [192.168.0.106] ([182.48.209.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883dbsm79007275ad.19.2025.03.17.11.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 11:36:35 -0700 (PDT)
Message-ID: <d54849db-956b-4c1a-ab93-4705394af637@gmail.com>
Date: Tue, 18 Mar 2025 00:06:30 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
To: Stafford Horne <shorne@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20250315203937.77017-1-sahilcdq@proton.me>
 <Z9Z2sjWQHKgGJyGo@antec>
 <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
 <Z9gOwYl6kmoPY9-C@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z9gOwYl6kmoPY9-C@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Stafford and Geert,

Thank you for the reviews.

On 3/17/25 1:55 PM, Geert Uytterhoeven wrote:
> On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
>> [...]
>>> +struct cache_desc {
>>> +     u32 size;
>>> +     u32 sets;
>>> +     u32 block_size;
>>> +     u32 ways;
>>
>> Considering the changes below to add cache available checks, maybe we
>> want to add a field here, such as `bool present`.  Or a flags field like
>> is used in loongarch?
> 
> I assume cache_desc.size is zero when the cache is not present?

Yes, cache_desc.size will be zero when there's no cache component since
cpuinfo_or1k[NR_CPUS] is declared as a global variable in setup.c. The
cache attributes are stored in this struct.

On 3/17/25 5:30 PM, Stafford Horne wrote:
> [...]
> Yes, good point, would be clean too work too.  I was not too happy with using
> cache_desc.ways as is done below.  Also there ended up bieng 2 different ways
> that were used.
>
> I am happy to use size too, but I think checking the SPR would be faster or just
> as fast as using the struct.  I am not too fussed either way.

There are a few places (e.g. cache_loop() in cache.c) where
cpuinfo_or1k[smp_processor_id()] is not being referenced. This will have to be
referenced to access cache_desc. In these cases, I think it would be better to
read from the SPR instead. For consistency, the SPR can also be read where
cpuinfo_or1k[smp_processor_id()] is already being referenced.

On 3/16/25 12:28 PM, Stafford Horne wrote:
> On Sun, Mar 16, 2025 at 02:09:37AM +0530, Sahil Siddiq wrote:
>> Add cacheinfo support for OpenRISC.
>> [...]
>> diff --git a/arch/openrisc/kernel/cacheinfo.c b/arch/openrisc/kernel/cacheinfo.c
>> new file mode 100644
>> index 000000000000..6bb81e246f7e
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/cacheinfo.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * OpenRISC cacheinfo support
>> + *
>> + * Based on work done for MIPS and LoongArch. All original copyrights
>> + * apply as per the original source declaration.
>> + *
>> + * OpenRISC implementation:
>> + * Copyright (C) 2025 Sahil Siddiq <sahilcdq@proton.me>
>> + */
>> +
>> +#include <linux/cacheinfo.h>
>> +#include <asm/cpuinfo.h>
>> +#include <asm/spr.h>
>> +#include <asm/spr_defs.h>
>> +
>> +static inline void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
>> +				unsigned int level, struct cache_desc *cache, int cpu)
>> +{
>> +	this_leaf->type = type;
>> +	this_leaf->level = level;
>> +	this_leaf->coherency_line_size = cache->block_size;
>> +	this_leaf->number_of_sets = cache->sets;
>> +	this_leaf->ways_of_associativity = cache->ways;
>> +	this_leaf->size = cache->size;
>> +	cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
>> +}
>> +
>> +int init_cache_level(unsigned int cpu)
>> +{
>> +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
>> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>> +	int leaves = 0, levels = 0;
>> +	unsigned long upr = mfspr(SPR_UPR);
>> +	unsigned long iccfgr, dccfgr;
>> +
>> +	if (!(upr & SPR_UPR_UP)) {
>> +		printk(KERN_INFO
>> +		       "-- no UPR register... unable to detect configuration\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (upr & SPR_UPR_DCP) {
>> +		dccfgr = mfspr(SPR_DCCFGR);
>> +		cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
>> +		cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
>> +		cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
>> +		cpuinfo->dcache.size =
>> +		    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
>> +		leaves += 1;
>> +		printk(KERN_INFO
>> +		       "-- dcache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
>> +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
>> +			   cpuinfo->dcache.sets,
>> +		       cpuinfo->dcache.ways);
> 
> The indentation of sets looks a bit off here.
> 
>> +	} else
>> +		printk(KERN_INFO "-- dcache disabled\n");
>> +
>> +	if (upr & SPR_UPR_ICP) {
>> +		iccfgr = mfspr(SPR_ICCFGR);
>> +		cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
>> +		cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
>> +		cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
>> +		cpuinfo->icache.size =
>> +		    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
>> +		leaves += 1;
>> +		printk(KERN_INFO
>> +		       "-- icache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
>> +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
>> +			   cpuinfo->icache.sets,
>> +		       cpuinfo->icache.ways);
> 
> The indentation of sets looks a bit off here. Maybe its the others that are out
> of line, but can you fix?  Also I think sets and ways could be on the same line.

Sorry, I must have missed this. I'll fix it.

>> [...]
>> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
>> index b3edbb33b621..ffb161e41e9d 100644
>> --- a/arch/openrisc/kernel/dma.c
>> +++ b/arch/openrisc/kernel/dma.c
>> @@ -36,8 +36,10 @@ page_set_nocache(pte_t *pte, unsigned long addr,
>>   	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>   
>>   	/* Flush page out of dcache */
>> -	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
>> -		mtspr(SPR_DCBFR, cl);
>> +	if (cpuinfo->dcache.ways) {
>> +		for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache.block_size)
>> +			mtspr(SPR_DCBFR, cl);
>> +	}
> 
> I think it would be better to move this to cacheflush.h as a function like
> flush_dcache_range() or local_dcache_range_flush().
> 
>>   	return 0;
>>   }
>> @@ -104,15 +106,19 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
>>   	switch (dir) {
>>   	case DMA_TO_DEVICE:
>>   		/* Flush the dcache for the requested range */
>> -		for (cl = addr; cl < addr + size;
>> -		     cl += cpuinfo->dcache_block_size)
>> -			mtspr(SPR_DCBFR, cl);
>> +		if (cpuinfo->dcache.ways) {
>> +			for (cl = addr; cl < addr + size;
>> +			     cl += cpuinfo->dcache.block_size)
>> +				mtspr(SPR_DCBFR, cl);
>> +		}
> 
> Also here,I think it would be better to move this to cacheflush.h as a function like
> flush_dcache_range().
> 
> Or, local_dcache_range_flush(), which seems to be the convention we use in
> cacheflush.h/cache.c.
> 
> 
>>   		break;
>>   	case DMA_FROM_DEVICE:
>>   		/* Invalidate the dcache for the requested range */
>> -		for (cl = addr; cl < addr + size;
>> -		     cl += cpuinfo->dcache_block_size)
>> -			mtspr(SPR_DCBIR, cl);
>> +		if (cpuinfo->dcache.ways) {
>> +			for (cl = addr; cl < addr + size;
>> +			     cl += cpuinfo->dcache.block_size)
>> +				mtspr(SPR_DCBIR, cl);
>> +		}
> 
> This one could be invalidate_dcache_range().   Note, this will also be useful
> for the kexec patches that I am working on.
> 
> Or, local_dcache_range_inv(), which seems to be the convention we use in
> cacheflush.h/cache.c.

Understood.

>> [...]
>> @@ -29,13 +34,13 @@ static __always_inline void cache_loop(struct page *page, const unsigned int reg
>>   
>>   void local_dcache_page_flush(struct page *page)
>>   {
>> -	cache_loop(page, SPR_DCBFR);
>> +	cache_loop(page, SPR_DCBFR, SPR_UPR_DCP);
>>   }
>>   EXPORT_SYMBOL(local_dcache_page_flush);
>>   
>>   void local_icache_page_inv(struct page *page)
>>   {
>> -	cache_loop(page, SPR_ICBIR);
>> +	cache_loop(page, SPR_ICBIR, SPR_UPR_ICP);
>>   }
>>   EXPORT_SYMBOL(local_icache_page_inv);
> 
> OK, if we move the range flush and invalidate here we will need to add to this
> cache_loop a bit more.

Right. I'll see what can be done to keep it concise.

>> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
>> index d0cb1a0126f9..bbe16546c5b9 100644
>> --- a/arch/openrisc/mm/init.c
>> +++ b/arch/openrisc/mm/init.c
>> @@ -124,6 +124,7 @@ static void __init map_ram(void)
>>   void __init paging_init(void)
>>   {
>>   	int i;
>> +	unsigned long upr;
>>   
>>   	printk(KERN_INFO "Setting up paging and PTEs.\n");
>>   
>> @@ -176,8 +177,11 @@ void __init paging_init(void)
>>   	barrier();
>>   
>>   	/* Invalidate instruction caches after code modification */
>> -	mtspr(SPR_ICBIR, 0x900);
>> -	mtspr(SPR_ICBIR, 0xa00);
>> +	upr = mfspr(SPR_UPR);
>> +	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
>> +		mtspr(SPR_ICBIR, 0x900);
>> +		mtspr(SPR_ICBIR, 0xa00);
>> +	}
> 
> Here we could use new utilities such as local_icache_range_inv(0x900,
> L1_CACHE_BYTES);
> 
> Or something like local_icache_block_inv(0x900).  This only needs to flush a
> single block as the code it is invalidating is just 2 instructions 8 bytes:
> 
>      .org 0x900
> 	l.j     boot_dtlb_miss_handler
> 	 l.nop
> 
>      .org 0xa00
> 	l.j     boot_itlb_miss_handler
> 	 l.nop

Given that there'll be generic local_(i|d)cache_range_inv(start, stop) utility
functions, would it make sense to simply have a macro defined as:

#define local_icache_block_inv(addr) local_icache_range_inv(start, L1_CACHE_BYTES)

instead of having a separate function for invalidating a single cache line? This would
still use cache_loop() under the hood. The alternative would be to use
local_icache_range_inv(start, L1_CACHE_BYTES) directly but using the macro might be
more readable.

Thanks,
Sahil
