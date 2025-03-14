Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB10207A08;
	Fri, 14 Mar 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982652; cv=none; b=rMBwG8gf/FwAZ6zoekN9s4ayy//JoleBHj7UzQKLVO1/cA7h6QDciHEYaQyAq9veJ1JGxkB42vG0HuDlKoKYd+GzceWI2YCo20AfNAK5zYvB3SZpz36fuzyUmEblTni7mz4GiV1aP+G7frWuJXuONMI48lwo1VuJNCobfrEFmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982652; c=relaxed/simple;
	bh=0lZ7TV+HuFhnNRmrc+D71R8kElOW83LxTSLgJtaFRD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoW0/tnPFgWOCsH2QLLTwMMK40Ly+FRjYBYuilxIBeWF4PTEqopUzKWYX660ALq2JpvafjkRi4f6iC7SFYgP/NTeYbzoc4xu2HVHhMYuNM+Rb33kg8EqmAT+b/R1I1GYanlxx7jPC4pRqTctFCOy6L0koGExDlcKzNwHLpAvvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqxSA2Ev; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqxSA2Ev"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so44233995ad.0;
        Fri, 14 Mar 2025 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741982649; x=1742587449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Bf2S/fpp2wK4pGyIW5xYqNeXGgwH4UybUfrV/yXw8=;
        b=HqxSA2EvXP41z/CXYJrkL8nh2I5u8zodI2/A5dm7Yekebo9zoyig8+wy4UlF8XFFQB
         Acw/0mkhA2NUsnHksdjaQV/Ih8xKkyoiT8jznPRzNdcNL71JesR6IRZ9G0nUfNl7504m
         pHu1MtE0ExsJhjctcEAmANc1S5JryLXpQP3IgPy3GRSBxI5aw62UaBV6hs3+IcXJxpY/
         GDY3kFiRQakvA7T0slbJTY7HxzR76sQJsZjogdDezsRc5Cq0w/0WOk0e8FWaPSwm836n
         dcKUmGzSxKP5MwSP0pm9dHapOXV6g7V0VI83/r5x2SodKRsvLh5UAKE+evi3+sA8q1Af
         xk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982649; x=1742587449;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Bf2S/fpp2wK4pGyIW5xYqNeXGgwH4UybUfrV/yXw8=;
        b=L/mkeY6fF0KD+nvqLQIVBg64GBpKYwiCtlcxvOjl7D7GWci1+zMsBRZ6+2GFjjOg63
         hK0QRbih24/OCFaO1X67ZXVsBKD+4u9loFBh0cQiKrLSRTmYwIjmKveuMBvV00X8hCas
         O7A5evp9O3ddtK7BQQSQNIK+BiKjs/Yf7RU0jSa+Qu9t9gsfAo1Z8q/sI1+godBvsMq5
         qcmIex+2kfDHa1ryuYunT6GcBHTp/pMZfOq5Vazl+aHliVw6FHbxwLXC094vz7Ld6iAC
         ycuCSUr4GxSSi/E8PCjnkyk3qU7WjOYKBJ8uyyKYsTplWoN94AJHmrx58H456xjTTmRU
         mtwA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pV7ZZdeBZPPEIzbXl8Cch1TYu0YuaE+sqdY9App8CYgB95JB2cHzRDkG17RAZsxN2mja6LMIqZLQNmk=@vger.kernel.org, AJvYcCXO3NUG8oXCpek4FAY+yZrfy507xYSbDc9zyMxw8Wp3EMxH5Pj4XOaZ9S1xkuBdfEjY15stpD4pQtoIFKblIqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWCXycUfsIngIPbP5SZpTtNy6SYSOHYD6p9P+oMrd8ZfgHo7Q
	CTTUELCAQ3uTjRd/wWRSvZRn6/9L1/gGtvNOpRTQmq2Lifpt7a/rCy4U4g==
X-Gm-Gg: ASbGnctOGTIYImLN2qg+ZlYTV77M1Eh4LC4T1Q6vPszHl5q4HEVAcStctoI+X+E+YEm
	t1B4wPPgasfEfo5n8JHDnaO+I9sf7/Ws4mp1IHHUZCKxU+EMfNi15qD+K+cPOUG9XyqwJRKZYTe
	V53mq2lJ4MgJvgg4ocAslhQ8D28j1M+gO20RtSHWuJjW2oLuwQAADA6YnyVRmzWjIxyV4icgvYG
	Wr9KHaGHRn6yP3bjfoHmbcXAfIDdMpnyTGet4Y7JbyHN0e55CHqDA/vw+1e12fuit/QiaqglcnT
	egC9alshsCJMxqqetYD3m2u+fFI=
X-Google-Smtp-Source: AGHT+IF/L2vWRzyEe3FGeTPphEvEl0w1P6eGyMd5yfheVvq7B7m4L8vQ047h58PYN+Jc3LKeHuT+pQ==
X-Received: by 2002:a05:6a00:929e:b0:737:9b:581c with SMTP id d2e1a72fcca58-7372238e7bdmr4482897b3a.7.1741982648648;
        Fri, 14 Mar 2025 13:04:08 -0700 (PDT)
Received: from [192.168.0.106] ([114.79.174.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529641sm3256623b3a.7.2025.03.14.13.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 13:04:08 -0700 (PDT)
Message-ID: <ee43f507-c0a2-45ed-818e-f24babf07d60@gmail.com>
Date: Sat, 15 Mar 2025 01:34:03 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] openrisc: Add cacheinfo support
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310191358.67912-1-sahilcdq@proton.me>
 <Z9NM8K92M8kS6t4k@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z9NM8K92M8kS6t4k@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/14/25 2:54 AM, Stafford Horne wrote:
> On Tue, Mar 11, 2025 at 12:43:57AM +0530, Sahil Siddiq wrote:
>> Add cacheinfo support for OpenRISC.
>>
>> [...]
>> None of the functions in drivers/base/cacheinfo.c that are capable of
>> pulling these details (e.g.: cache_size) have been used. This is because
>> they pull these details by reading properties present in the device tree
>> file. In setup.c, for example, the value of "clock-frequency" is pulled
>> from the device tree file.
>>
>> Cache related properties are currently not present in OpenRISC's device
>> tree files.
> 
> If we want to add L2 caches and define them in the device tree would
> it "just work" or is more work needed?
> 

A little more work will have to be done. The implementation of "init_cache_level"
and "populate_cache_leaves" will have to be extended. To pull L2 cache attributes,
they'll need to make calls to the "of_get_property" family of functions similar to
what's being done for RISC-V and PowerPC.

Shall I resubmit this patch with those extensions? I think I'll be able to test
those changes with a modified device tree file that has an L2 cache component.

>> Regarding the "shared_cpu_map" cache attribute, I wasn't able to find
>> anything in the OpenRISC architecture manual to indicate that processors
>> in a multi-processor system may share the same cache component. MIPS uses
>> "globalnumber" to detect siblings. LoongArch uses a "CACHE_PRIVATE" flag
>> to detect siblings sharing the same cache.
> 
> In SMP environment the L1 caches are not shared they are specific to each CPU.
> 
> Also, we do not have hyperthreading in OpenRISC so shared_cpu_map should be a
> 1-to-1 mapping with the cpu.  Do you need to do extra work to setup that
> mapping?
> 

No extra work has to be done to set up the 1-to-1 mapping. This is already being
done in "ci_leaf_init()".

>> I am running with the assumption that every OpenRISC core has its own
>> icache and dcache. Given that OpenRISC does not support a multi-level
>> cache architecture and that icache and dcache are like L1 caches, I
>> think this assumption is reasonable. What are your thoughts on this?
> 
> Currently this is the case, but it could be possible to create an SoC with L2
> caches.  I could imagine these would be outside of the CPU and we could define
> them with the device tree.

In this case, some extra work will have to be done to set the "shared_cpu_map"
appropriately. But I think the modifications will be quite small. If the L2 cache
is external to all CPUs, then all online CPUs will have their corresponding bit
set in the "shared_cpu_map".

>> Another issue I noticed is that the unit used in ...cache/indexN/size
>> is KB. The actual value of the size is right-shifted by 10 before being
>> reported. When testing these changes using QEMU (and without making any
>> modifications to the values stored in DCCFGR and ICCFGR), the cache size
>> is far smaller than 1KB. Consequently, this is reported as 0K. For cache
>> sizes smaller than 1KB, should something be done to report it in another
>> unit? Reporting 0K seems a little misleading.
> 
> I think this is fine, as long as we pass in the correct size in bytes.

Understood.

>> [...]
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
>> +		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
>> +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
>> +		       cpuinfo->dcache.ways);
> 
> Can we print the number of sets here too?  Also is there a reason to pad these
> int's with 4 and 2 spaces? I am not sure the padding is needed.
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
>> +		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
>> +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
>> +		       cpuinfo->icache.ways);
> 
> Same here.


Sure, I'll print the number of sets as well.

I don't think there's any reason for the padding. It was part of the original
implementation in setup.c. There shouldn't be any issues in removing them.

>> [...]
>>   	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
>> -	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
>> -	seq_printf(m, "dcache block size\t: %d bytes\n",
>> -		   cpuinfo->dcache_block_size);
>> -	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
>> -	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
>> -	seq_printf(m, "icache block size\t: %d bytes\n",
>> -		   cpuinfo->icache_block_size);
>> -	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
>>   	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
>>   		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
>>   		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
>> -- 
>> 2.48.1
>>
> 
> This pretty much looks ok to me.
>

Thank you for the review.

Thanks,
Sahil

