Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D628E3F
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Jun 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109558; cv=none; b=MfOdo0UiIvyIBRJpnUKC5Hqs3JmJKfaM5o/vG/b11HCBdW3N1mGexLV4Ldvevy7FVbulIxkCcr/XN8EVvus9ca6R1RObSsYZGdx1XlMZwa6Oe4TH6CatZPvb28mIXYEXLByjkfaSAVzyJfAL1A3WQtLuQK+G+ugu5X0tnjMZzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109558; c=relaxed/simple;
	bh=z2ayjJ0mQBVlcuddv2EsRljL5k9ruhgeCyZFOwfJwG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llWea6j39yLM9TufMNe9C2/kff1uhsBOQin2Qer43mk9pwYcGsiS4BGgRiJGjqhbUKvuLsKJxOlOVN4K/8vrVJ9bDx8V4kKhIqDw1TjWRVJDiZ9MRGg7NiUW/tmxMFTI+qeivAAz8+BjkCZyT55GyMii4LTjCfpQkUh8jkjaLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAfZkgwJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAfZkgwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749109554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O6H1ftBO6CEKGJOKs9g86ajvG5fS+ZjCtKrVQh3o6Cw=;
	b=DAfZkgwJcPav1ZPPKcFWiqMQusZACozHyH2qv9ZEyQj5CJXVzU1JQahkUXGPgYQ1b1acNj
	uvL/pG2ZqXlA3WhmEG8U/MexjxwbPBaiHvb5J3Ts+LgQBpuKfQFG5RolEx/EhcVFhfALT1
	h37N/j9TcQ0TsQf55ag8OJgjLK861d4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-KC3Fka-nMfSTTUsuiHfsRw-1; Thu, 05 Jun 2025 03:45:53 -0400
X-MC-Unique: KC3Fka-nMfSTTUsuiHfsRw-1
X-Mimecast-MFC-AGG-ID: KC3Fka-nMfSTTUsuiHfsRw_1749109550
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so3686405e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 05 Jun 2025 00:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749109550; x=1749714350;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6H1ftBO6CEKGJOKs9g86ajvG5fS+ZjCtKrVQh3o6Cw=;
        b=D18PqfB9CY/L6fafibIF3Mad4l/lDSkSwUcpTGu3c03WpSYEnIJUE3CEWGc48pPhv0
         L8/vL44EUhzUHIT0w9P0nQokDd0rY5AfTx3Awz25/Ty840XA7TM479eT27WKBk3yGxUI
         i40ZEyrk79W6bi4uLRe+ft4DiGlSTpgg80BtvXzpr3njFMhOdFHOp+eAFr03+LuwlgfI
         DelwWygu/VqqFr6QqC5mSnUiZ94xq5T4/4hZma7ykm1iJYisLqPkQbtJwhdPMwSGhLdZ
         FUQSWThxJo6Aowr62Z8S/bj5+3WQmuTo+5Qmj4kk7CEkvtQJDnm4VFDDobguOQOaByjh
         QRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtpvjAMTy+Hqw6HRYbokWYWxAbCFyGG5dINJDtGExOgE5VB397uPeHaZe/BVl6yyhwYNFXdMHPEExZriQkOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VET5lJ4elob9QzNNCgGzpZxr3TDTSfZyakby5nAIqzJpBiom
	iLL2u5dhdHNEPBEzXzLLF5hnffhr5WLr8m95dUvBNYNqdLB5/ShWfq9V+aAL33SlPfG0daFhK4N
	+rduIGigokbIUc5tCINf/C7yY+JtyNjQwcfOHKj79thJtWQq3EaRX+4H5EnOVV4OeD7gTS7hw1Y
	lh
X-Gm-Gg: ASbGnctrsg6F9wtCjQ8Xp/ikkTxBq/iZ9OSEUu30HUb2Upka0+fkyStB4oL2dxz61Dg
	G7rKQX+XI+Zrkt9nn4bmiHjl0Ckz/DYtpuKoIHI/lkWLdnAuotpkdyvf5HFMkv6HQ/Y8U4bn5yQ
	XSm2Iwn78d7QAuW3MnQ9B1MDJPsUGvP71+atWYgofRCoVd6riRVppNE1GvJgJ5u+YKRgxEGIr8m
	X74msb804AjM+LRmWzyxLbrBzhk3nKnKUfdyvcsWFvYjLTQuwpHmj9ABlRdBZL6h8ja1s8QwMZx
	Wd+mPP/xIvNKNPFKfiZZW7+M/nrdTSpSkiyJa5T/GovFZa289HYyFIOEVp9rXbY9/V7dYKV4zJx
	ekWSdRK0tn0g078olZ7x/tErCbRjnSLFD0RQC
X-Received: by 2002:a05:600c:4e01:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-451f0a64f08mr56930865e9.4.1749109550289;
        Thu, 05 Jun 2025 00:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHROMgPjj+pP0emg4VKEoyCSGEnHYlNibukVyaEg4rn+/3yPGA5yK/itaMc1AE1G562Zflv1g==
X-Received: by 2002:a05:600c:4e01:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-451f0a64f08mr56930315e9.4.1749109549833;
        Thu, 05 Jun 2025 00:45:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2? (p200300d82f27ec004f4d0d38ba979aa2.dip0.t-ipconnect.de. [2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb208ad0sm9163115e9.24.2025.06.05.00.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 00:45:49 -0700 (PDT)
Message-ID: <590641e8-35f0-43e5-985a-3912c126b4aa@redhat.com>
Date: Thu, 5 Jun 2025 09:45:47 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <baohua@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dQ9Dth0gKhWV_DHVtFBZahgMc6dC5N3Su5qPvisU2ug_1749109550
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.25 16:19, Lorenzo Stoakes wrote:
> The walk_page_range_novma() function is rather confusing - it supports two
> modes, one used often, the other used only for debugging.
> 
> The first mode is the common case of traversal of kernel page tables, which
> is what nearly all callers use this for.
> 
> Secondly it provides an unusual debugging interface that allows for the
> traversal of page tables in a userland range of memory even for that memory
> which is not described by a VMA.
> 
> It is far from certain that such page tables should even exist, but perhaps
> this is precisely why it is useful as a debugging mechanism.
> 
> As a result, this is utilised by ptdump only. Historically, things were
> reversed - ptdump was the only user, and other parts of the kernel evolved
> to use the kernel page table walking here.
> 
> Since we have some complicated and confusing locking rules for the novma
> case, it makes sense to separate the two usages into their own functions.
> 
> Doing this also provide self-documentation as to the intent of the caller -
> are they doing something rather unusual or are they simply doing a standard
> kernel page table walk?
> 
> We therefore establish two separate functions - walk_page_range_debug() for
> this single usage, and walk_kernel_page_table_range() for general kernel
> page table walking.
> 
> We additionally make walk_page_range_debug() internal to mm.
> 
> Note that ptdump uses the precise same function for kernel walking as a
> convenience, so we permit this but make it very explicit by having
> walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---


[...]

>   bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index e478777c86e1..057a125c3bc0 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -584,9 +584,28 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>   	return walk_page_range_mm(mm, start, end, ops, private);
>   }
> 
> +static int __walk_page_range_novma(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		pgd_t *pgd, void *private)
> +{
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.mm		= mm,
> +		.pgd		= pgd,
> +		.private	= private,
> +		.no_vma		= true
> +	};
> +
> +	if (start >= end || !walk.mm)
> +		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;

I'm wondering if that could be moved into walk_pgd_range().

> +
> +	return walk_pgd_range(start, end, &walk);
> +}
> +

I would inline that into both functions and finally get rid of that 
"novma" ... beauty of a function.

Well, we still have the "no_vma" parameter, but that's a different thing.

E.g.,, there is no need to check for walk.mm in the 
walk_kernel_page_table_range() case.

-- 
Cheers,

David / dhildenb

