Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1251514E4
	for <linux-openrisc@vger.kernel.org>; Fri,  3 Jan 2025 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735876453; cv=none; b=STapVyHFhKBGF+MR/DcuPvKpyA4v7NpvMM6wxHz9V40+R/7rdSOCKs4gcJBONc4iJ6pK1uyAS/2YRafQz17ensQQwcHWCWs1WjBC1zDkyY8uAoIhY/fdkOS9MCu+TUHi2bLettoymNiLcuvS20e7JOt2EDS2lQ2y7sFqtbKO/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735876453; c=relaxed/simple;
	bh=FQ5D1Kx+YlPJIwMGyXspAy7bXvtTs/Tb+GWLn9dccaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HT6lh+wPnUxXX8VzLLNBxDmx1osbNZ41Q66yhZPVlcBmQccGltcEXzLiZKsljMtbJmzY0K9PEfsLoloEIgtyYlw3yzM2I2cq8dlEJBKYJoEA08T3u8WYtcAvmZNf2pLeK7AxO2QlmzBlF+sbjZ2OBIwDeD2Lpnginxx0uwplzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AZBWcdEZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AZBWcdEZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163bd70069so65841425ad.0
        for <linux-openrisc@vger.kernel.org>; Thu, 02 Jan 2025 19:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735876451; x=1736481251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExtURrdtg4wvz/5S73kPKLfYL+g+cN7JWlBZcDSiUw0=;
        b=AZBWcdEZaNC+rG26GO/MJaHvesaAdqBYdCjqcv6/fSF/L5W7TfSueFG2l17j+ZqY6/
         NHIOaEeVcHvVNP9c4kPWAIeb1z4JuGhHO/I0Uwt+mS82ciXOzhiV6LnFuVfei2UcAykk
         el+lfLVCXLI1EkRAOSEq+V+3xwqJ516kTNVSDlJYluIP+vRf50A8JnTHwfMX14avKLFt
         mH/9xFwtxGmwdJ7klxqWgT9TeIOA1aPk/jdmVDLeDr0ipsnRwKkefLIlMElWD5MH9jVn
         vhhtfVrY9m7kUStZKCRKilFUc1fj3lIHLVNIs8uEYcSDfwxfeQpVrBAxaP8kwUDxDM7U
         RI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735876451; x=1736481251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExtURrdtg4wvz/5S73kPKLfYL+g+cN7JWlBZcDSiUw0=;
        b=LD7F6XuNgMXYgt0tboVEffjQtajc173sQ9WTrbaD1aZCDCIaypLFjuAKq5E2eo+pyf
         5zw0OkB06b6cH9ccRDctaJ+pqO6PNrqqIl+eZ7lRGnAlAhwLT8N6cH4SKL+MPB+IZg83
         SZGAGhzBa470qNJZdJNRafs4Yr2zpjCtwPr1Q5ekOE5//+CncZyKUaxJaBPYKibb2jvj
         syxLAl74wpkTiQOMgDDsGhiYFBh+EFlTvEPOoYj4U1VbKrKxuuVSBSyQi+0VvvWMKpjT
         nHzBk/zUlP9OkOggFTb/1QYozwhh96ZM5nlsYlz3OA4exDNVrK1HRUUfR/GG1CrB/Ez2
         x5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVR6qT1q4pNuY5b7lq5jr09QXzYKRwDILfqtTQTrR5GrvjOH7vDpNsv9/K+alFtZ6rJnSp+gJcREc6CPoN9JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzycTAKftynMeHhSVS3BGkx8auqVgDYoI7t2c61fNo5qKfzTo0Y
	SiZ7gVWBdilrstRsZ0IL8ibNY2i5DgP3Otqak8eMsj9/BJUK+JF66TT/eO/4CqA=
X-Gm-Gg: ASbGnctKcZGpey3iqNI9azD4XtazoAR4zDNTD82WnhUSKI0DxTwajNh2+M4+efOABw1
	1W2Rs+RXpcBcfaEOf0gjXHFgKb7eHGFT5ZXYLHPkCVCBZ/xSXwiSl8FZXrim7m84PM1xt+SpXb9
	hRKFHwrEoz+dAoiqq1Sg4qPHD+w9v0R6tqpNxVb4yf8jIsUBEGuSXh9RsrqF6952hmVrcj0Y4ei
	+J+RW7edlVZoBSOT1XPzGNMMpbNwzclzn3YMxPUbSIf46/QFFpFrhOoym6p8l5dUR0phkZKAJXe
	PTw2gw==
X-Google-Smtp-Source: AGHT+IGRLBberTsNPcVz5fDDiJ496OTTAGvxwwTdPWwuUiji7gMKzctc+wxIQ/Y0LkCE8MhlfHWUlw==
X-Received: by 2002:a05:6a21:6d86:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1e5e081179bmr90059001637.31.1735876450877;
        Thu, 02 Jan 2025 19:54:10 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fba98sm25284573b3a.161.2025.01.02.19.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 19:54:10 -0800 (PST)
Message-ID: <77c202bf-e0a3-45e7-bf8d-eef7903e3c64@bytedance.com>
Date: Fri, 3 Jan 2025 11:53:56 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] mm: pgtable: add statistics for P4D level page
 table
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <2fa644e37ab917292f5c342e40fa805aa91afbbd.1735549103.git.zhengqi.arch@bytedance.com>
 <237a3bf6-c24f-4feb-8d3d-bb3beb2fd18e@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <237a3bf6-c24f-4feb-8d3d-bb3beb2fd18e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/3 00:53, Kevin Brodsky wrote:
> On 30/12/2024 10:07, Qi Zheng wrote:
>> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
>> index 551d614d3369c..3466fbe2e508d 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>>   static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>>   				  unsigned long addr)
>>   {
>> -	if (pgtable_l5_enabled)
>> +	if (pgtable_l5_enabled) {
>> +		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
>> +
>> +		pagetable_p4d_dtor(ptdesc);
>>   		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
> 
> Nit: could use the new ptdesc variable here instead of calling
> virt_to_ptdesc().

Right, but we will remove pagetable_p4d_dtor() in patch #10, so this
may not matter.

Thanks!

> 
> - Kevin
