Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CC1CEADF
	for <linux-openrisc@vger.kernel.org>; Fri,  3 Jan 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895612; cv=none; b=Ez+lNw0d08rqqZsCNBtNVOlWqeTvkMLsVM6XAync1Gy5ULjt8jpQGfEw2DZ/ErIJcv42cz+Pp6e5kxY1i544ng4Nt6Pj7Ms0YP2rRLrSxQ2slaswvmHaE8hAf89M4Tt21uf3eaTWwMAaweFEQQ1KzSXShwcVHT2U74UBmITpulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895612; c=relaxed/simple;
	bh=GHknZM2y1McHJr/gbv5QJmiAc61n3bReUa9py7W6NFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKu3bD+H61xfg5ayZvASv2H230DfRa9bKo1erHk1HdLkmatFPI+6FDaQ5Qqz9twoePKksdDCASHYJzCK/5GiGl+okTZsdeoKp+3G+J6tGPoe2Wp+9M1X4ioY49Dv7/Qw3uhS2labSwGjCCFc2Y0x5H4OKXiFnYsLbKsSD7/TebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ce8o+Zp8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ce8o+Zp8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216401de828so156645955ad.3
        for <linux-openrisc@vger.kernel.org>; Fri, 03 Jan 2025 01:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735895609; x=1736500409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvjXC1OjFutvGYgxD2wHa2wTk86a/9lW5eStlVFSRNE=;
        b=ce8o+Zp8pxKuI1FbBGFAT6GAsvM4CQft5BJ0HrejMSrIUnBsMr6DhuLxWMiV+Hg9vA
         WGVSFJ+P7NUFgT2YzxhPxFX1ccmZVRsB9R+9KwxLU9PN94eBs4PAj2Btq1Wn9ONRi+hQ
         pa47ObuFr+fK2CZn28ToMBqh1pULJ203YIm75HngaWwgtQ/B4GHvvMWsG9+4cXg6Vzmw
         7mFJJaNn7VcznL9EPSdk3/N9QecMFHJggB69x4hWZlHAsw1hgFZ98uLbEUkll7JjqZ4T
         VIQAEmOvEDepXMKVMO7F+nFlZT9/eKUd7TVP/bXp5p5bEdXySMEHnbisbZhrlD49yCh2
         sLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735895609; x=1736500409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvjXC1OjFutvGYgxD2wHa2wTk86a/9lW5eStlVFSRNE=;
        b=l3Klr+YMdGh+dBvhdnbzMEvLsimM13Mga6L4140CgEHCuU6HGtfxzpuL0Tx7nOyZf3
         ac5Dyp8YqRms3aUd0J/TI2t1cnz1g1uwsuL9t4rlMqoeptW3FQI1++4mpDvEXenULqr9
         wfh6acSvcUtwLkQhbeNM6AoklijqrUl4WmMEKANQhr/ZCBK/jfdIW1habLXl3/IthDo1
         u7G/aHHAgDM2k6qild6WVScEUYAaQRTO+ay8Lv4jENzi8E0EX7ksrkHcYOBksrioT/yR
         xV4iAK3aBGXcruK2ywCg/bYnwM5IeAu4RQupBZqCRlZWC+d9CI69yGvndkpC5Hq9TxvJ
         gxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFxFDI4ol2fFGAAXEq2QwWObKpUQbkSY9cnSENmggmvVc0XgGCIQki0hGF5lLPG6ViR9tJNMtX6H5n8uOeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmElUN6bUTtjSUvQUkTmqonb+xP6QkYMWArTkRwHGtyE75ou+d
	CEk1Tx4oTSObFrKoglAO/1m/LqhX8hoTgWNPOBtrWD58bLukjYN8JlitBk6OkPg=
X-Gm-Gg: ASbGncuJi0OmbjFwwLrs1eMKmNjLA4rDZucdYLWcoofF/gOq0ICvXi++0wWC/4bP0dj
	TUgzejda+F0H0Ffc9n3dkA14Sf4xC9k8jtKdxkH9HwZBrkJoZ578NE/soRmCIBIc2nYHcRDPWEJ
	J+imqFDBq3p8eyGLmsf2w60IQDwcOpKJxWEBAvPB5uVfBr50zNQoBDwJEKK2bJmE7w3vjKKkki9
	Di1OLeREALDHDnlkq71xpE1kMwsgP1yZKr46R8vE+3P482F1U9F/7738OGMeHFEEsSvl/cim+/o
	pz0umQ==
X-Google-Smtp-Source: AGHT+IEXJPN8gGhA2HYYDOMJlHA0eNtjpiDq/sKLXwKwTWFhE1ZE5FTpP/Am20/VMhak6uDuJsOrhQ==
X-Received: by 2002:a17:903:11d2:b0:215:a60d:bcc9 with SMTP id d9443c01a7336-219e6e89536mr708942765ad.2.1735895609241;
        Fri, 03 Jan 2025 01:13:29 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde19sm241412365ad.167.2025.01.03.01.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:13:27 -0800 (PST)
Message-ID: <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
Date: Fri, 3 Jan 2025 17:13:12 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
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
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/1/3 16:02, Kevin Brodsky wrote:
> On 03/01/2025 04:48, Qi Zheng wrote:
>> Hi Kevin,
>>
>> On 2025/1/3 00:53, Kevin Brodsky wrote:
>>> On 30/12/2024 10:07, Qi Zheng wrote:
>>>>    static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb,
>>>> void *pt)
>>>>    {
>>>> -    if (riscv_use_sbi_for_rfence())
>>>> +    if (riscv_use_sbi_for_rfence()) {
>>>>            tlb_remove_ptdesc(tlb, pt);
>>>> -    else
>>>> +    } else {
>>>> +        pagetable_dtor(pt);
>>>>            tlb_remove_page_ptdesc(tlb, pt);
>>>
>>> I find the imbalance pretty confusing: pagetable_dtor() is called
>>> explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
>>> Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
>>> Could we not call pagetable_dtor() from __tlb_batch_free_encoded_pages()
>>> to ensure that the dtor is always called just before freeing, and remove
>>
>> In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
>> and call pagetable_dtor() to dtor the page table pages.
>> But __tlb_batch_free_encoded_pages() is also used to free normal pages
>> (not page table pages), so I don't want to add overhead there.
> 
> Interesting, can a tlb batch refer to pages than are not PTPs then?

Yes, you can see the caller of __tlb_remove_folio_pages() or 
tlb_remove_page_size().

> 
>>
>> But now I think maybe we can do this in tlb_remove_page_ptdesc(), like
>> this:
>>
>> diff --git a/arch/csky/include/asm/pgalloc.h
>> b/arch/csky/include/asm/pgalloc.h
>> index f1ce5b7b28f22..e45c7e91dcbf9 100644
>> --- a/arch/csky/include/asm/pgalloc.h
>> +++ b/arch/csky/include/asm/pgalloc.h
>> @@ -63,7 +63,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>>
>>   #define __pte_free_tlb(tlb, pte, address)              \
>>   do {                                                   \
>> -       pagetable_dtor(page_ptdesc(pte));               \
>>          tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
>>   } while (0)
>>
>> [...]
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index a96d4b440f3da..a59205863f431 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -506,6 +506,7 @@ static inline void tlb_remove_ptdesc(struct
>> mmu_gather *tlb, void *pt)
>>   /* Like tlb_remove_ptdesc, but for page-like page directories. */
>>   static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb,
>> struct ptdesc *pt)
>>   {
>> +       pagetable_dtor(pt);
>>          tlb_remove_page(tlb, ptdesc_page(pt));
>>   }
> 
> I think this is an interesting idea, it does make arch code easier to
> follow. OTOH it would have been more natural to me to call
> pagetable_dtor() from tlb_remove_page(). I can however see that this
> doesn't work, because tlb_remove_table() is defined as tlb_remove_page()
> if CONFIG_MMU_GATHER_HAVE_TABLE_FREE isn't selected. Which brings me
> back to my earlier question: in that case, aren't we missing a call to
> pagetable_dtor() when using tlb_remove_table() (or tlb_remove_ptdesc())?

Thank you for pointing this out!

Now, there are the following architectures selected 
CONFIG_MMU_GATHER_RCU_TABLE_FREE:

1. arm: select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
2. arm64: select MMU_GATHER_RCU_TABLE_FREE
3. powerpc: select MMU_GATHER_RCU_TABLE_FREE
4. riscv: select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
5. s390: select MMU_GATHER_RCU_TABLE_FREE
6. sparc: select MMU_GATHER_RCU_TABLE_FREE if SMP
7. x86: select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT

If CONFIG_MMU_GATHER_TABLE_FREE is selected, an architecture is expected
to provide __tlb_remove_table(). This patch series modifies the
__tlb_remove_table() in arm, arm64, riscv, s390 and x86. Among them,
arm64 and s390 unconditionally select MMU_GATHER_RCU_TABLE_FREE, so we
only need to double-check arm, riscv and x86.

For x86, it was called tlb_remove_page() in the non-PARAVIRT case, and I
added pagetable_dtor() for it explicitly (see patch #11), so this should
be no problem.

For riscv, it will only call tlb_remove_ptdesc() in the case of
SMP && MMU, so this should be no problem.

For arm, the call to pagetable_dtor() is indeed missed in the
non-MMU_GATHER_RCU_TABLE_FREE case. This needs to be fixed. But we
can't fix this by adding pagetable_dtor() to tlb_remove_table(),
because some architectures call tlb_remove_table() but don't support
page table statistics, like sparc.

So a more direct fix might be:

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index a59205863f431..0a131444a18ca 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -500,6 +500,9 @@ static inline void tlb_remove_page(struct mmu_gather 
*tlb, struct page *page)

  static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
  {
+#ifndef CONFIG_MMU_GATHER_TABLE_FREE
+       pagetable_dtor(pt);
+#endif
         tlb_remove_table(tlb, pt);
  }

Or fix it directly in arm? Like the following:

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ea4fbe7b17f6f..cf5d0ca021440 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -43,6 +43,9 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, 
unsigned long addr)
         __tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
  #endif

+#ifndef CONFIG_MMU_GATHER_TABLE_FREE
+       pagetable_dtor(ptdesc);
+#endif
         tlb_remove_ptdesc(tlb, ptdesc);
  }

Thanks,
Qi

> 
> - Kevin
