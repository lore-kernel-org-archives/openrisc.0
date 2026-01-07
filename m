Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179F314B6E
	for <linux-openrisc@vger.kernel.org>; Wed,  7 Jan 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778161; cv=none; b=NXc+j4nnKacEuSVdm0zD2Wqy9yxZvzFVb2IEjxzyLB2yAcHWusgm8hegCKsmrIzn4In9dXTY7gMQSJrKwYi3CImKXto0YjNvfffi83Wno00AKoK7kY2ADDHvntG41c8fS+r9UdKoliAnLC3k7kpetBWPdlwBNXsNi5lJveNBqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778161; c=relaxed/simple;
	bh=YskUE8ivh/0bvl2ccHBh6Q13s6fd7XMp1/zObXA0Cvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m38J1JTepaMifydpNqVCogqr+CWdvrEPSBYu5R23/RxTRrvPaALHF2fldlIO65fgtZBB8PpR5RmnADR0yeepZMjBPwiht/HaieNilDHFGmMgvcwPpCO0K213Gh/Lc7dJk3dX4mykF1X9CFZ1BSqbPjYPupQpHqZ5eaiNyNfYkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIlItCdC; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIlItCdC"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6420c0cf4abso1644907d50.1
        for <linux-openrisc@vger.kernel.org>; Wed, 07 Jan 2026 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767778158; x=1768382958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk512LwmO/uZGHz1Ojwhz3Ek5WphQWvtFTpjZjwnzlQ=;
        b=jIlItCdCO+29xFklzf+kYmWbmp9vEkdwKe4DgaGTN5PvbI14G7qGJ9fwL/BxrTiVUf
         hYxurE7YuZivK5W2RabpAX2WpTXF0ajn0kVmzKSpGhTAA0cZov58Okejo7QPUQ/txNrB
         gPt5EZAYu+PhFi9OPeVJRP6v/Dc8PnsPA53SULfBoSsNprlf8NXMVwxEWSseavRrg/0p
         Kd7ArR9HUnk8S0GAsbRnQCTD7uC0bOlLlnkn3SMiVNabPr6LesfkN3bR0MUJfJDxckkS
         uehEHp4k0vWtnd+4asRC3kDGiAhZ/sybWaF+MZs+kX2noA6zaLKzcwwhEeDbg/Tp0rsX
         oUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778158; x=1768382958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk512LwmO/uZGHz1Ojwhz3Ek5WphQWvtFTpjZjwnzlQ=;
        b=QDM0Qy8HZmGpY5f8Ss+xNGZj9pGAFPmYyPgYG4Az6YToO56SSX6TrfZw1UTD7J/Bv4
         AMrkO0Jes+cvH+GNzWb3+dAC3Ieu+48WJaHAr0uLoVVbqqcZMHvuz/db2JSsaLte+Gao
         ZV30P2nzL8QQceLQ0/X1fZSH6LLjwvorCBS/+bsF518GZGUg/+0PWG8QoH+ZkwFVUpKw
         nPPt2gjNXR1KCJnX+s1mcIpRdVTS+npR1w7/ZMdCYZ24jJbSVPfNBn9jrXYultfZYXtN
         47tACliemJkmxW/9HPl2csY7GfmBBQWsOrsm8/ze0ekGrK+75hQ0x8pt3IggUa7mIgVE
         hkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGhcOXaQjft8l+KzRPX7AZVMufcp6sroMrfuhW1fXcXEhNU+upweW2yZmnUNZZLOKaImECDY0AKRkj4ZcTeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTl6QFymCqqj0IyzBMBXMCclP2AcPXeekhArtIUwj1imApA0N8
	mv6lQ2v27ZhHkIbWMNIDII6PL7tz1cAFofLEpMp00AB5vYQ+s3PXWaoN
X-Gm-Gg: AY/fxX6j4uGN5qHdmfIQYuNpnnUKHh4XqTEiu0Q+bdwMcdUAVapDEO1XIYwidlU0NNs
	sP+lSodq1HJM0aWNbqU2neDQakR1lOkqS4FV24ij6q/zA3zN9OSOOCf9Lgt6Ntu2y4fb0Vxvcib
	qxhHiCp4RFCauLXfyRknTs9fYdTQFr7rM7Pf9fMbcerr1coPXMCcVMVVqMelT/1LgSxu0Kx97Pg
	hwPBZzF5RC1vBH0ork7/KzIMfS1Kt7eSM75kk1/E11vWGHI4035jOwkUlRyj1cZhlwTj0fvxlvu
	IxAa3h6BJrFtLNatpnNHR1gqIb7CVIhh+fBdfE2N2VFdEcjUn/QPklQZeE35q66uxCLkL8Kx2WB
	FLNQUp4AjBTqK84HvJ2GY++2jybhLitTaKQFbJcwTeKsG8ApYGtIWTaq4GGTBlXTiO2QH3ITm6h
	BT0YSyxis84GoS+4Oi7ev8OrLQ3xPujxKKL6KFog==
X-Google-Smtp-Source: AGHT+IGPYSkTJQTXRdeZJNO0Ptp1UF4C4ZvN+4Y+pwY9mfVj1KcuNobxA+hhEKXT47wj8D4Ny+QBYg==
X-Received: by 2002:a05:690e:1483:b0:644:60d9:8654 with SMTP id 956f58d0204a3-64716c69eccmr1598952d50.87.1767778157608;
        Wed, 07 Jan 2026 01:29:17 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80be64sm1865006d50.6.2026.01.07.01.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:29:16 -0800 (PST)
Message-ID: <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>
Date: Wed, 7 Jan 2026 17:28:36 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
To: Mike Rapoport <rppt@kernel.org>, alexs@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
 "open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
 "open list:LOONGARCH" <loongarch@lists.linux.dev>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
References: <20260107064642.15771-1-alexs@kernel.org>
 <aV4h5vQUNXn5cpMY@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <aV4h5vQUNXn5cpMY@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/7 17:05, Mike Rapoport wrote:
> On Wed, Jan 07, 2026 at 02:46:35PM +0800,alexs@kernel.org wrote:
>> From: Alex Shi<alexs@kernel.org>
>>
>> After struct ptdesc introduced, pgtable_t should used it instead of old
>> struct page pointer. The only thing in the way for this change is just
>> pgtable->lru in pgtable_trans_huge_deposit/withdraw.
>>
>> Let's convert them into ptdesc and use struct ptdesc* as pgtable_t.
>> Thanks testing support from kernel test robot<lkp@intel.com>
>>
>> Signed-off-by: Alex Shi<alexs@kernel.org>
>> ---
> ...
> 
>> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
>> index a17f01235c29..1a3484c2df4c 100644
>> --- a/arch/arm/include/asm/pgalloc.h
>> +++ b/arch/arm/include/asm/pgalloc.h
>> @@ -96,12 +96,12 @@ pte_alloc_one(struct mm_struct *mm)
>>   {
>>   	struct page *pte;
>>   
>> -	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
>> +	pte = ptdesc_page(__pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM));
> When ptdesc will be separated from struct page, ptdesc_page() would fail if the
> allocation failed. This line should be split into something like
> 
> 	struct ptdesc *ptdesc = __pte_alloc_one(...);
> 	if (!ptesc)
> 		return NULL;
> 	pte = ptdesc_page(ptdesc);
> 
> 

Right, I will fix this. and sent the 2nd version.
Thanks a lot!

>>   	if (!pte)
>>   		return NULL;
>>   	if (!PageHighMem(pte))
>>   		clean_pte_table(page_address(pte));
>> -	return pte;
>> +	return page_ptdesc(pte);
>>   }
>>   
>>   static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
> -- Sincerely yours, Mike.
> 

