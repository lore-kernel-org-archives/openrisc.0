Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A231E9907;
	Sat, 22 Mar 2025 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651485; cv=none; b=ox3BQWWxyGcuV//Dc7QrcRmkwDKAR2JRkmN9k9U8dulD0tgt8JCXNe4kB1Gpmmqjpoyy9DX4vvb3YImiM7Qloya2hfR8FuJqlj/HAvCOHEaBeyryubJNTBvT1HCwV1VyeHI7sfM2Me7eE6s7dXzYJ9yzhUjEe6voRCPNRRjOS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651485; c=relaxed/simple;
	bh=AXgKldIJDFxGGTSesb7GOpU8h0qDcUTcY0vEC43gwss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wx9oa16xjtIVOw89QrDXNjuG0b4hkCpCuQf26CrTt/tMd+SPZxT0rHjtoFU0Vl5wHhK6N3Yw2U+OJKcLfbfntK6FNbfDXMbPoHz22VcyF6JnAWns3EPFNGduSWfmq0U6C+XPhFFiiDsDsShD+PxwqLEW5Y5B6+eQ5wEtawCxZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7+3VPJo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7+3VPJo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225b5448519so57745785ad.0;
        Sat, 22 Mar 2025 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742651483; x=1743256283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9hoE3iAQOV2Sj7MhPY6vXJpvggMasHemIzplUShugBI=;
        b=e7+3VPJoBzgK6tBKmwo+VFLB8v5acNxU9zSlWsnSYFKui5AG+wqhZ9ypcl7PB5Y5KD
         Mx9LJS+YT6Tvj17IY6oVnry2M9NZHKkr8Hq106u9pyOwHYTK8kbj+SNdTAmHjEumsdpb
         ssDV5+jbYMugcEH/u9rVsi/0FB3G872AWTyNArOT9s995zE9TQQLFPZOHN34h8B4jF7t
         7mP4xdQYPjrGJlRSdTa6cFcUq490IBj4FOWFR+D1WzREFoZ3H80VEWYk9LuKzoNOlNJf
         8eadWgyo98zjAj+fYg7VuhLVx4bdJioqVYDmsPrmJuFeHe+UwvZLc1q2U/xOr//JEOT4
         xC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742651483; x=1743256283;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hoE3iAQOV2Sj7MhPY6vXJpvggMasHemIzplUShugBI=;
        b=puUeQsa5pLdqf1qi2/5f636bolyq1zfAAcYOk058FMLoQA5U/YaCKJ19nInwo2c8oo
         rnKow4UvQp47mdgU/vdSkpsdVZ07KIpT7Um968alMXRWg6yx4T0tWFPvklRjlzfoQvBg
         /8B154b1eWIZpibPkKWpwJQzQxUe/aMC1q50simOO6BJ9QxGPQ28SrYjrXVTNukTF/XP
         VGWfJ7CgJi5QXvhcjvrTEtrpRRjWUHPlqIpCKwEiFromJsq8ivXzL53V3jlHP0NS3voO
         xKwa1cR+E8NTWrTPwtvYsuvPUg1dgOfBGUBYQcgRbso75rQIYR7JvKyBDnbRSWnVP6vs
         N2dg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZh4J6L2pfzTkVHHZ5bc5N7sM6JKac5KUxMyKf6VF5CnzTdJPuUAggZi4Z7bGNE6PcVOVFquMOLMJ2gE1wZ4=@vger.kernel.org, AJvYcCVd0O7ITeE+FYWFGIMf4Pbf4cPIyBiPw80fIowW2TXs5T9DswuNkzyIjshtbqlCJpCTXZbgFeU7ZdguSNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsB69kJNNYLwZiiUdICLO3vfOKUSmqt006Kv0olM3pDx2ktF2h
	BSeCyuaWnliFEjtf6M0Y+p2Pm/f9m9mFmWFGhVJNoe+sI7Zp158b
X-Gm-Gg: ASbGncuTlqmDNTixXJGzlZdqIz7gEKxMrxX/UALmG5bvegUOjbMYc+c7x/xHejwuHqM
	h5PvSNB8fmtFLFpJK6DOmkaBJUtAImCMyAuDuXviifQDJ2Qor2PaNaRVBDINV0DosdhAj6gVJDG
	fshDjMDFUNeF1Kv8TOgSqpGC+IomNKZO4I6UOQGxHqvQwolYimkm6z/9eqJ41tqEFeEeF6leBzI
	CE9EkuJl6Ke7QiFnq35oPY6UPX4j/4w9mkHrbruvCgdWoCWVkQ2wxywo7okBHmDGdwtoFHshnJk
	XUR3C4Sp57kBvu5p46V8MT0LDNpfwZ/g//0T8PW7CJV937U12zBcCr1Nv3EVFa/jCzJGffiOQNC
	mT4Z3nvQiDlbu
X-Google-Smtp-Source: AGHT+IHuerATWGFhIPO0eIxScwtZUhrScb0YX7Ezgxo/yo5HB/H2u0y3pK9K+pI33jtz02wbUqSfcA==
X-Received: by 2002:a17:902:f68a:b0:21f:85d0:828 with SMTP id d9443c01a7336-22780e0782amr122080015ad.41.1742651482730;
        Sat, 22 Mar 2025 06:51:22 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b? ([2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811c1b8fsm35451155ad.154.2025.03.22.06.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 06:51:22 -0700 (PDT)
Message-ID: <10b01724-d47f-4f0f-87ea-2793e67b18b9@gmail.com>
Date: Sat, 22 Mar 2025 19:21:18 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
To: Stafford Horne <shorne@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq@proton.me>
References: <20250315203937.77017-1-sahilcdq@proton.me>
 <Z9Z2sjWQHKgGJyGo@antec>
 <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
 <Z9gOwYl6kmoPY9-C@antec> <d54849db-956b-4c1a-ab93-4705394af637@gmail.com>
 <Z9kkE3uQru_VxLqA@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z9kkE3uQru_VxLqA@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stafford,

On 3/18/25 1:13 PM, Stafford Horne wrote:
> On Tue, Mar 18, 2025 at 12:06:30AM +0530, Sahil Siddiq wrote:
>> On 3/17/25 1:55 PM, Geert Uytterhoeven wrote:
>>> On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
>>> [...]
>>>> @@ -176,8 +177,11 @@ void __init paging_init(void)
>>>>    	barrier();
>>>>    	/* Invalidate instruction caches after code modification */
>>>> -	mtspr(SPR_ICBIR, 0x900);
>>>> -	mtspr(SPR_ICBIR, 0xa00);
>>>> +	upr = mfspr(SPR_UPR);
>>>> +	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
>>>> +		mtspr(SPR_ICBIR, 0x900);
>>>> +		mtspr(SPR_ICBIR, 0xa00);
>>>> +	}
>>> Here we could use new utilities such as local_icache_range_inv(0x900,
>>> L1_CACHE_BYTES);
>>>
>>> Or something like local_icache_block_inv(0x900).  This only needs to flush a
>>> single block as the code it is invalidating is just 2 instructions 8 bytes:
>>>
>>>       .org 0x900
>>> 	l.j     boot_dtlb_miss_handler
>>> 	 l.nop
>>>
>>>       .org 0xa00
>>> 	l.j     boot_itlb_miss_handler
>>> 	 l.nop
>>
>> Given that there'll be generic local_(i|d)cache_range_inv(start, stop) utility
>> functions, would it make sense to simply have a macro defined as:
>>
>> #define local_icache_block_inv(addr) local_icache_range_inv(start, L1_CACHE_BYTES)
>>
>> instead of having a separate function for invalidating a single cache line? This would
>> still use cache_loop() under the hood. The alternative would be to use
>> local_icache_range_inv(start, L1_CACHE_BYTES) directly but using the macro might be
>> more readable.
> 
> Yes, I think a macro would be fine.  Should we use cache_desc.block_size or
> L1_CACHE_BYTES?  It doesn't make much difference as L1_CACHE_BYTES is defined as
> 16 bytes which is the minimum block size and using that will always invalidate a
> whole block.  It would be good to have a comment explaining why using
> L1_CACHE_BYTES is enough.
> 

While working on the patch's v3, I realized I am a bit unclear here. Is the ".org"
macro used to set the address at which the instructions are stored in memory? If so,
the first two instructions should occupy the memory area 0x900 through 0x907, right?
Similarly, the next two instructions will occupy 0xa00-0xa07.

Since the two instructions are 256 bytes apart, they shouldn't be cached in the same
cache line, right? Maybe one cache line will have 16 bytes starting from 0x900 while
another cache line will have 16 bytes starting from 0xa00.

If the above is true, I think it'll be better to simply call mtspr() for each address
individually.

Thanks,
Sahil
