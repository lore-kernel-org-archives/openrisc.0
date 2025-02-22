Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6B6FC3
	for <linux-openrisc@vger.kernel.org>; Sat, 22 Feb 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224125; cv=none; b=L2ncS2kLSb2CD+S45pI6uYogj39nWUO4HvICszW6EbvdMul4elF/1cnI46RxqlppK0hQx5sFyEZZ6tdxsPjfh8C3Hc+Ma+FiKT/Is5HMvBMJTE2/Jx2zaR7aymMf40SNcKN0Ag3h+eJTJhINdaLabyrXAe8h9PUlvqcWESklC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224125; c=relaxed/simple;
	bh=iMNYxxPAt+2uom4UKvuC53XAs49AQcNV0pEiq21N57g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhBZ3isDxJ+h2RAltnxVL/tGL/VrN83p5dL2ZX9XDLQsLQoN6VYrIngqU2m0OnhvcmA+QSZU14zyoOqzJvsDDuBcbU/P5wgLJs58Xpe7JIUnI5BGbqy71JzjxNCQdPCTZEmYlmzwXP3kWGwO7l9eadJgP0lt0IcJy2IFhuNfpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCAgqo0k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCAgqo0k"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22101839807so63221995ad.3
        for <linux-openrisc@vger.kernel.org>; Sat, 22 Feb 2025 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740224123; x=1740828923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e819J5uqRGmV0V5qaTm/PvijEZVMnEbll6rRo4hiZps=;
        b=HCAgqo0kvqIieXlqGgwcp4SZBoXO6WNpXKzkd1uTeLKM4p93dJA3YYBnyBMAlppSgU
         KDgxva6+cObhb07+YZxwERK/942dRiUU1SZRM37cojVgkLb65uPy4b1ypU8VEyGOvrrE
         1lA4dFsMUnL9d5JAvP9HJsgkRERn/aUUD4Xo0R0WOqz12qqf3hkpk4+xEh2wMCjc/bUe
         Yi8V3euuKnQHsWDlU12wJsg0N0X3gO2c7Mr8a2m9DteY6gOJFS6UndsbX3eZa6N0haho
         cQoDA29sohIHjT0+zBbFP+r0krGmynCtPcCdJjzFV3dNrpHCD6Yx1aT1jF44vejE/tFd
         0g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224123; x=1740828923;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e819J5uqRGmV0V5qaTm/PvijEZVMnEbll6rRo4hiZps=;
        b=OTgbo9nVaaHAQqIME0LMubaHywVNJ5loXZXpdP68T7SDCdDvAAwhQ12DH0Ccs6ibwJ
         3eAL7ducRE43QGWuks+MPZTlxHOOb21hH3RMej4736QrnzoinSopjfNFOyp8GgCcCzYw
         uH7u14H4AJltKZl5rzvXzot0ReoMGqyqYQYOGQ8YhTpcb3IkSmvBA/7OqyBe5OuX8Cna
         NTEQ718x35ZHk+nPVZWFF155N21fIZ7kOZZ12nyU0yz/4j65a8/4+iM4uIkzgKN1j0KE
         JNMJ8wNWFKBJBHKHTf6Qo53hr3DEZYJZlu3Yfgj+f2Qa7iddhxJMsIR8nJXLyPNhke56
         WhTA==
X-Gm-Message-State: AOJu0YwgpV0Cv9bGrlwtdXvPtdfo8j9IRyNeo7yTBPE7bkqx+Ltom90+
	36X1+fuUotQc1XUQBuqpM4vpucTwR2T0zNm7kmXzGdl4pulXjY+A
X-Gm-Gg: ASbGncv2/nsZ1U+fSA4WCfsMhzrga/xEGQnsEq/RlLazBFblkUCQyFqM6yNS6fZ3rZ1
	z0IUDWnqYZCN744WvS3K17+MIpIFE6QVqBgtg1DfO2+N2wgfVCc917PAkodrxuPJ1O5pVWnz/NE
	bCC1wPwB294Ftv6eFOWWksbjy86W+hivRLn6tCFRgn300Q2HivFTKI1R6avfY/J5fStUmCUrNd2
	zoZ7Ro7+9iDpTa2EzeXLQOVHoxS/fmWSADksdl/VLUdY8q2Vl+qMb+k+2zKhEPTkojKi58=
X-Google-Smtp-Source: AGHT+IGXs1McznvQDkH7znfpO8gkePLeyXunMHjtxsxOkWv8PzL8AEncwbKD5AHGNVtbizJqNp8tZg==
X-Received: by 2002:a05:6a20:6a22:b0:1ee:5cf2:9c07 with SMTP id adf61e73a8af0-1eef3c716admr10554980637.3.1740224123356;
        Sat, 22 Feb 2025 03:35:23 -0800 (PST)
Received: from [192.168.1.18] ([223.233.86.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e2fesm17269697b3a.118.2025.02.22.03.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 03:35:22 -0800 (PST)
Message-ID: <259dc6a2-1d72-4860-b677-be9b100b422d@gmail.com>
Date: Sat, 22 Feb 2025 17:05:05 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Queries regarding OpenRISC CPU cache
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec> <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec> <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
 <Z5STI5WUqCXPwcNF@antec> <ae00d43a-f8bb-4919-8ee1-079a30bc6f42@gmail.com>
 <d789bca7-0266-44e1-bc36-966a70adcf26@gmail.com>
 <b6ba7708-6c4d-41df-b057-9f92b4e938f9@gmail.com> <Z7bH2zKIi6GHsqm9@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z7bH2zKIi6GHsqm9@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/20/25 11:42 AM, Stafford Horne wrote:
> Hi Sahil,
> 
> Sorry I missed replying to your last mail.

No worries :)

> On Wed, Feb 19, 2025 at 01:08:18AM +0530, Sahil Siddiq wrote:
>> Hi,
>>
>> On 2/12/25 8:59 PM, Sahil Siddiq wrote:
>>> Hi,
>>>
>>> I have started working on implementing cacheinfo support for OpenRISC, and
>>> I have got a few queries.
>>>
>>> Q1.
>>> Does OpenRISC support multilevel cache hierarchy? I couldn't find anything
>>> in the architecture manual [1] mentioning the possibility of a multilevel
>>> cache hierarchy. I wasn't able to find anything in the verilog implementation
>>> either [2].
> 
> Currently all implementations support only a single level of cache.  I think if
> we would support multiple levels ever we could use device tree to define L2
> caches, etc.
> 
> See for example:
> 
>    Documentation/devicetree/bindings/cache/freescale-l2cache.txt
> 
> These are the device tree bindings for a freescale l2cache.

Got it, this makes sense.

>>> Q2.
>>> In /sys/devices/system/cpu/cpuX/cache, each indexY directory corresponds
>>> to a CPU cache. According to the OpenRISC 1000 Architecture specification [1],
>>> it is possible to have a unified cache. In such a case, registers controlling
>>> the instruction and data cache represent the same thing (section 9.1 of the
>>> manual).
>>>
>>> Consequently, should there be only one index (i.e. index0), or should there
>>> be 2 index directories (index0 and index1) with identical content? If a unified
>>> cache is used, will the DCP and ICP bits both be set in the UPR register?
> 
> If we have a unified cache, I think there is actually no way to tell its unified
> from the configuration registers.  So I think we have to treat it as if we have
> both iCache and dCache.
> 
> So we should have index0 and index1.
> 

Understood. I guess another configuration register can be added in the future,
if ever there's a requirement to distinguish between a unified and split cache.

>>> Q3.
>>> Cache-related arithmetic performed in arch/openrisc/kernel/setup.c:setup_cpuinfo() [3]
>>> cannot be avoided. But we can expose this info in sysfs instead of cpuinfo as
>>> specified in this mail [4]. So, I was thinking of moving these calculations to
>>> arch/openrisc/kernel/cacheinfo.c in init_cache_level().
>>>
>>> What are your thoughts on this?
> 
> Yes, I think so too.
> 
>>> Another thing I noticed in the current implementation is that these calculations
>>> are performed for icache and dcache before using the UPR register to check if
>>> they even exist. Should these calculations instead be performed after determining
>>> that they exist?
>>> [...]
> 
> Yes, that would be better.

Thank you for the clarification.

>> Building on my previous mail, I noticed another thing:
>>
>> On 1/25/25 1:00 PM, Stafford Horne wrote:
>>> On my x86 machine I see:
>>>
>>>       $ tree /sys/devices/system/cpu/cpu0/cache/
>>>       /sys/devices/system/cpu/cpu0/cache/
>>>       ├── index0
>>>       │   ├── coherency_line_size
>>>       │   ├── id
>>>       │   ├── level
>>>       │   ├── number_of_sets
>>>       │   ├── physical_line_partition
>>>       │   ├── shared_cpu_list
>>>
>>> On or1k I only see (no cache info yet):
>>>
>>>       $ tree /sys/devices/system/cpu/cpu0/
>>>       /sys/devices/system/cpu/cpu0/
>>>       |-- of_node -> ../../../../firmware/devicetree/base/cpus/cpu@0
>>>       |-- subsystem -> ../../../../bus/cpu
>>>       |-- topology
>>>       |   |-- core_cpus
>>>       |   |-- core_cpus_list
>>>       |   |-- core_id
>>>       |   |-- core_siblings
>>>       |   |-- core_siblings_list
>>>       |   |-- package_cpus
>>>       |   |-- package_cpus_list
>>>       |   |-- physical_package_id
>>>       |   |-- thread_siblings
>>>       |   `-- thread_siblings_list
>>>       `-- uevent
>>>
>>> But we do have some cache info available via cpuinfo:
>>>
>>>       $ cat /proc/cpuinfo | head -n16
>>>       processor               : 0
>>>       cpu                     : OpenRISC-13
>>>       revision                : 8
>>>       frequency               : 20000000
>>>       dcache size             : 256 bytes
>>>       dcache block size       : 16 bytes
>>>       dcache ways             : 1
>>>       icache size             : 32 bytes
>>>       icache block size       : 16 bytes
>>>       icache ways             : 2
>>>       immu                    : 128 entries, 1 ways
>>>       dmmu                    : 128 entries, 1 ways
>>>       bogomips                : 40.00
>>>       features                : orbis32  orfpx32
>>>
>>
>> While I can see icache and dcache info in /proc/cpuinfo, dmesg reports
>> that the caches have been disabled.
>>
>> OF: reserved mem: Reserved memory: No reserved-memory node in the DT
>> CPU: OpenRISC-13 (revision 8) @20 MHz
>> -- dcache disabled
>> -- icache disabled
>> -- dmmu:  128 entries, 1 way(s)
>> -- immu:  128 entries, 1 way(s)
>> -- additional features:
>> -- power management
>> -- PIC
>> -- timer
>>
>> This is because the value of upr is 0x719 and the value of SPR_UPR_DCP is
>> 0x2. ANDing both values gives 0 which, according to the arch manual [1], means
>> there's no dcache. The same thing applies to icache.
> 
> If you are using qemu this is correct.
> 
>    target/openrisc/cpu.c:    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;

Yes, I am using QEMU.

> There is no cache in qemu as we use the actual host cpu cache to speed up
> memory operations.  You could modify qemu to help with testing your cacheinfo
> changes though.

I'll modify QEMU in that case. It'll help verify that cache-related calculations
are performed correctly only after detecting they exist.

Thanks,
Sahil

