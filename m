Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5019ABBB;
	Sat, 15 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742070920; cv=none; b=mzSzwWye/zF0Ix+Bw3ycz56t+clHhPrCEGDaqVE82GKCiizkBsoFtp94MB/gDqpCrDpISX9sZxrUDbSy1s8nhTwMQGIKQFgXvb0of/yzIVSI9EDXIIbVxzfiKKr2WnzHolxwE+mbTn80bORb3K6DukbNepBaRjYOqWWxLEsHJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742070920; c=relaxed/simple;
	bh=cbHJPlQHdxBDuZ9TmeGd4HwvWAnbk9EjvzXh9h2JZIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5iDNGamb1GAmCFoVE+LddH8fRP7b/6EWbBWbFUbOK/NqYuQwi0vSD4V5RwitHWaTXHRM4KuQBS1V7b/DtZ17UsqV4/qCjZEORbMBiN+sBFe0cQkX8AzQnR3VGqRSTDYhJt2LjJYnoN7JqwE3hd83gD0YywNkITx5Bo35BBDZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnKj1NXT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnKj1NXT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240b4de12bso5084945ad.2;
        Sat, 15 Mar 2025 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742070915; x=1742675715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tgbRB7Tx6ptOc5hD+AtsdrN5NMXfoCM8cquqsM2wuxI=;
        b=XnKj1NXTySBK01w3S8tUmNnENHActEb44tWnDKtJYlbRo6jN1vDw07gYZJE7cSD4IK
         iHkKVHMsus82XTF9ejkPzib9Wf631Su68i0YxH4Uc4Aj9uSxEHfiFLluhgEO+pgDAQn+
         9LWml+ME3vbJB91TnVckRsg3sz0H35pVzsXAWe25ocZeRq5HlqG0KMzEeSWnJcqlC3Az
         6RtlnAtGMciwianTHKqu6Wcf3Mm02DKWPC3i/hzjnVwXRYqtUEInXdOB25Qtz/ARSLVu
         t09UIMmd6T47N3SSLR0Z03I2f5rO9R+tiQHXIlJVyZ6MdAxdx1h0kSfN9D06A5tZ5DpR
         b+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742070915; x=1742675715;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgbRB7Tx6ptOc5hD+AtsdrN5NMXfoCM8cquqsM2wuxI=;
        b=SBmNbRJSGVJNPL4Z7GBd6ERm4F+iBxcH9U2qlytqbKH+LvrcWWJgsf4tDyalL7lrff
         uoLSjn+zoHn99YIpjbNcSuOFU2hrZf/N7lAfoSrCh5fuDHTyxwvEwiSEG8voZUslfNDj
         ehYcyCJBauyceqjUTFjCKlXT2ZnIS/P9EO8Gjg/3FW5c9Zj0rzYYnjjnmcPgzavRoKIh
         5+d0Ggtu+8uvgMYNd+r26iuT0PzcrMxvzZgeYbD9jTb3XcjkVQQrmEROnn8Q8IUFoJn7
         5zwVR4D/JgNJqcumylUA3igj2iSxugDFZyAogpB4GTpmGYu70Ddk5QGqFLWgN/RciBwj
         VA0g==
X-Forwarded-Encrypted: i=1; AJvYcCUorxRQ39VaFzB/zTZ1E9fAasvQ2RMrVcuBp/7xqVJYtSIcA4QJOoa8Dp1qHT1nMLECO+LtkT6QLETKE+c=@vger.kernel.org, AJvYcCWi6lR0U90V36rVPSmdhjIoPEfeBtqJ9bxeQegccVqo6pZM8gO55ekpFnb1YCbFKUfFREI1Lx0VTQzZs+hMND4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aqWyM2Zw/NRcJgm1yRnWUBsQKvj2QniRzIBxf3vDoSXKv+C7
	LvNJFXwhNvueGncgNptOpzfvnbzuunQHCItH+sJojqSgL1PeZAuK
X-Gm-Gg: ASbGncujSDDda8BBkm17kAidr0CNsQBN7BEnpxMtdZGIBwChwypY+mBv61EXb+kia3Z
	ZunuzaTCmCYPZa6qbm8Wzb3Q4NzSkGy0PvbAkZ4Xc6XaSdGCpVbZN3SMa20n7xWpdBCcRDbe7Lm
	tjXvSsbvgVkEdXvhR9cCsXnN8nNhvmVLw/6+5dVOVNCq3llSZNela+7aMdDH5ok8OWS64XukAzB
	q3VywFW6okjzjDUqrKVBrbO4X5S+5008psohsG3xmuYcAYRbZPyiVKTizE+b2RSegfpL0qAyqT5
	qlqaXuyK6+20VRQ=
X-Google-Smtp-Source: AGHT+IHTdUWPFpNLyF6C9ZzwVDHxEeknm+yjY9ZjUCbqgOiPviQEpldl17XAhGW5X/QRpJts4pdhnA==
X-Received: by 2002:a17:902:f650:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-225e0b18f43mr94780805ad.32.1742070914554;
        Sat, 15 Mar 2025 13:35:14 -0700 (PDT)
Received: from [192.168.0.106] ([182.48.208.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5a61sm47866815ad.250.2025.03.15.13.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 13:35:14 -0700 (PDT)
Message-ID: <ce766986-79cb-4c7d-9acc-845ef1db9ad1@gmail.com>
Date: Sun, 16 Mar 2025 02:05:09 +0530
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
 <Z9NM8K92M8kS6t4k@antec> <ee43f507-c0a2-45ed-818e-f24babf07d60@gmail.com>
 <Z9SX7thyConoDjLT@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z9SX7thyConoDjLT@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/15/25 2:26 AM, Stafford Horne wrote:
> On Sat, Mar 15, 2025 at 01:34:03AM +0530, Sahil Siddiq wrote:
>> On 3/14/25 2:54 AM, Stafford Horne wrote:
>>> On Tue, Mar 11, 2025 at 12:43:57AM +0530, Sahil Siddiq wrote:
>>>> Add cacheinfo support for OpenRISC.
>>>>
>>>> [...]
>>>> None of the functions in drivers/base/cacheinfo.c that are capable of
>>>> pulling these details (e.g.: cache_size) have been used. This is because
>>>> they pull these details by reading properties present in the device tree
>>>> file. In setup.c, for example, the value of "clock-frequency" is pulled
>>>> from the device tree file.
>>>>
>>>> Cache related properties are currently not present in OpenRISC's device
>>>> tree files.
>>>
>>> If we want to add L2 caches and define them in the device tree would
>>> it "just work" or is more work needed?
>>>
>>
>> A little more work will have to be done. The implementation of "init_cache_level"
>> and "populate_cache_leaves" will have to be extended. To pull L2 cache attributes,
>> they'll need to make calls to the "of_get_property" family of functions similar to
>> what's being done for RISC-V and PowerPC.
>>
>> Shall I resubmit this patch with those extensions? I think I'll be able to test
>> those changes with a modified device tree file that has an L2 cache component.
> 
> Since we don't have any such hardware now I don't think its needed.
> > [...]
>>> Currently this is the case, but it could be possible to create an SoC with L2
>>> caches.  I could imagine these would be outside of the CPU and we could define
>>> them with the device tree.
>>
>> In this case, some extra work will have to be done to set the "shared_cpu_map"
>> appropriately. But I think the modifications will be quite small. If the L2 cache
>> is external to all CPUs, then all online CPUs will have their corresponding bit
>> set in the "shared_cpu_map".
> 
> Yes, it could be so.  For now, let's not do this as no such hardware exists.

Understood.

>>>> [...]
>>>> +
>>>> +int init_cache_level(unsigned int cpu)
>>>> +{
>>>> +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
>>>> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>>>> +	int leaves = 0, levels = 0;
>>>> +	unsigned long upr = mfspr(SPR_UPR);
>>>> +	unsigned long iccfgr, dccfgr;
>>>> +
>>>> +	if (!(upr & SPR_UPR_UP)) {
>>>> +		printk(KERN_INFO
>>>> +		       "-- no UPR register... unable to detect configuration\n");
>>>> +		return -ENOENT;
>>>> +	}
>>>> +
>>>> +	if (upr & SPR_UPR_DCP) {
>>>> +		dccfgr = mfspr(SPR_DCCFGR);
>>>> +		cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
>>>> +		cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
>>>> +		cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
>>>> +		cpuinfo->dcache.size =
>>>> +		    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
>>>> +		leaves += 1;
>>>> +		printk(KERN_INFO
>>>> +		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
>>>> +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
>>>> +		       cpuinfo->dcache.ways);
>>>
>>> Can we print the number of sets here too?  Also is there a reason to pad these
>>> int's with 4 and 2 spaces? I am not sure the padding is needed.
>>>
>>>> +	} else
>>>> +		printk(KERN_INFO "-- dcache disabled\n");
>>>> +
>>>> +	if (upr & SPR_UPR_ICP) {
>>>> +		iccfgr = mfspr(SPR_ICCFGR);
>>>> +		cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
>>>> +		cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
>>>> +		cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
>>>> +		cpuinfo->icache.size =
>>>> +		    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
>>>> +		leaves += 1;
>>>> +		printk(KERN_INFO
>>>> +		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
>>>> +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
>>>> +		       cpuinfo->icache.ways);
>>>
>>> Same here.
>>
>>
>> Sure, I'll print the number of sets as well.
>>
>> I don't think there's any reason for the padding. It was part of the original
>> implementation in setup.c. There shouldn't be any issues in removing them.
> 
> Right, it would be good to fix.
> 

I have incorporated these changes in v2 of the patch.

I realized that the kernel hangs during booting when using QEMU without the DC
and IC config register changes. I have added a few more changes so the kernel
can be booted with and without these QEMU changes.

Thanks,
Sahil
