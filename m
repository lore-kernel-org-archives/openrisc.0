Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9314387B
	for <linux-openrisc@vger.kernel.org>; Mon, 30 Dec 2024 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735528337; cv=none; b=LgNXIfEhnWQ+5SANR+JkdN+5HJVBbiuNb9fRosirO9VlFcwy68xhV74vPdiO210X0edEVNFIjH3jVqc+2LOuRoJ8/B8LDif10smOtsA4xaM3APEw299UFZHQGEWdbKEMaG4NM+XG+KpWughYw8GDZwxSRypce3ctLKBmK1QcE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735528337; c=relaxed/simple;
	bh=RByHVD3bvwf9OBgmvjYl7zmyuddvG3+m7GzmELh8Ojk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsCwKjsXLpGGkDYJ5gq8uLy4xJBoxzFTeN7NPwAioKmxD+QZUtzN1Y6s8GmMVlXV4JLQrUjJoABv8SgSbbTuFnTRKjAh8KtivgTKZwxNJYmRiY+Aw/MxB3iwmUhw7zsif05MLHyGrORRd4nrm9VaNyULb89Bfr9iVE6SMvePiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U4TKcd5D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U4TKcd5D"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166f1e589cso136672265ad.3
        for <linux-openrisc@vger.kernel.org>; Sun, 29 Dec 2024 19:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735528335; x=1736133135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00MV44O/wLuPQ/RpQp8S/rpHXiOskq9DnLB00pReqmw=;
        b=U4TKcd5D4yLghx2l4BTUej/I4g4Z33Z5EuOg4tqgR1jpnnlPEVnqdX27VklOCdJMzj
         VZOfTwRmpJpqPi2m4SQzuJdbXiHWuvKAigs0JOvPTR6wkY9L7u/t/zIoZO0s8AjE8VtS
         2w7VNScCKvWQoQOa2cMwoDCdd6PpS3fw9sgx5WOBebldyJ9PZyFhF/9oGjf23X3wufGz
         /8QxukHxfuamu8NP0HHvE/qQoFJfPM5DZGjRXAzmsJWZzDqGRubur3XHHzqmQrPPdktj
         FPk97rpDrbb1LkLj+b2zZKuczfGTh5ngsdYU1MFuNTe13Mf/JBkMCsTv8QN52rmjXrVU
         MyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735528335; x=1736133135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00MV44O/wLuPQ/RpQp8S/rpHXiOskq9DnLB00pReqmw=;
        b=ZSrENMpPfZwyiZSHsTUkHCcu4sZJj01O7uCjts8FhTeQVcALtOLkhGJ+NBE9UkVUQg
         4hTfow6c3vowL3ZPV2q6FaYQF9YnRlbt9AaACi22fO9RJSBW1rggjpOnNVnD8SraQJFW
         t7xrPrbU6yFQc2uh35UzxsZjvqMAm6S1Z8mPwS0whGrMXW6ul1vPG8PVSBE6TJOyKOYX
         HuyLvqaJBsyicfAovECptO/Pkol7DJAQ1xyHPJY+KS1hMdvDrut1Sl6vNrrTeXRxUSxS
         9zCk8ft+rnJLqzXm596NH4bOOUSsWpHMnbNMZBUBJiziNFC6egkAl/RQLMakziMZpjKQ
         dfWA==
X-Forwarded-Encrypted: i=1; AJvYcCU1wmd/FZ4X9pObhzmhNufiQ0ux/pnXxdE5SHbF/WaL+5R61tRxoDB8CAhbC+DGWy9ENIjJSrIgvYOu0Nmlaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBHb98beZ+hA/fXxIRkNPF0vPQgeeM7N+Hhp+WXukRTjhAbff
	AkS8R8aDv2rq024byp6PkHfb/DcIPcUyVSwr7ISqoIjRRfz2OlOvB3mO5Q7ksWk=
X-Gm-Gg: ASbGnctExoFafl+NVu/PLxnTdLygOtLmslzo5rYZzLXdHgF5d25BhGUktQUXoFZGDkq
	0ROY4aGwwInyMl9fWAd+YmiAxqTjUKvH6w5aA+qW8VHBay+4jXy4JeZNw1qvJ24M3rUY749VUCq
	4jFr+CSoqV1PefLy3H/mLUQbUPxqYkJf17UU1CxUeSI+tiUdHaTpmwzdcCFW56zx5WGhJieeJvK
	yAWITOSmcDGllYLWs4Ga37txnEzfDEYwQAkydQF6e50yB+3v/LtV22dHFKJDymttOKjyp7Uw2rg
	iGZU6A==
X-Google-Smtp-Source: AGHT+IHVtuGTDJKnXgo1JS5AtVrvj0I/cg1dyieo6seko5BYBtWvsXqnYPIAVAFKhaTndzKmWg8VgQ==
X-Received: by 2002:a05:6a20:9185:b0:1e5:7db5:d6e7 with SMTP id adf61e73a8af0-1e5e083f019mr66304616637.46.1735528334820;
        Sun, 29 Dec 2024 19:12:14 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb45sm18191842b3a.88.2024.12.29.19.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 19:12:14 -0800 (PST)
Message-ID: <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
Date: Mon, 30 Dec 2024 11:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
 kevin.brodsky@arm.com, peterz@infradead.org
Cc: agordeev@linux.ibm.com, tglx@linutronix.de, david@redhat.com,
 jannh@google.com, hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z2_EPmOTUHhcBegW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mike,

On 2024/12/28 17:26, Mike Rapoport wrote:
> On Mon, Dec 23, 2024 at 05:41:01PM +0800, Qi Zheng wrote:
>> Here we are explicitly dealing with struct page, and the following logic
>> semms strange:
>>
>> tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
>>
>> tlb_remove_page_ptdesc
>> --> tlb_remove_page(tlb, ptdesc_page(pt));
>>
>> So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
>> directly.
> 
> Please don't. The ptdesc wrappers are there as a part of reducing the size
> of struct page project [1].
> 
> For now struct ptdesc overlaps struct page, but the goal is to have them
> separate and always operate on struct ptdesc when working with page tables.

OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
intermediate products of the project.

Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
[PATCH v3 17/17] from the mm-unstable branch?

For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
can help do this in his patch series. ;)

Thanks,
Qi

> 
> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs
>   

