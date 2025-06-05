Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B611F4176
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Jun 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104021; cv=none; b=CxGmw60p04k+5ADlEC7MB7wiGz6vj8ga7IKj6owVBcI04MrKVOvyQUtvNwdPcM0lnGxcij2QWes/91qAUYbssuXZe2g0oYyk+QBu9nKACTEO/UPjGrTkyYDk2s5/UXNqhxyKAFXxHN417QbySJ4xtp//AZR+83QjgFUoGRMJneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104021; c=relaxed/simple;
	bh=bzeFKix16H6AR7c25plvNC6hswXve1/a+mJcJ3UZEJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfCS11aU4wy+yGBw5juDTKT9DmXdexCFcAzvww3X2PL8bDPS3XXVKXZwWrJ02CUkoM/jUeqGH6DFeul8cJBxerVFUrYd/CaxpF1hcTijBSlEKy+vbJ509W3xn73ehDmoxStRWZeUphlztcX4QNSnzbveNIMRlQHPPrF8gSpPmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CIoOCAC8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CIoOCAC8"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c41acd479so359300a12.2
        for <linux-openrisc@vger.kernel.org>; Wed, 04 Jun 2025 23:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749104018; x=1749708818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn7NBr5TJWjNI8T2dY/UzcUhiHMyl/nutXcvd+GUfmM=;
        b=CIoOCAC8wmjUu4OZ+lBQjPvVvAkEzMQCrgFCGVqgNKeGBx6/TXj3up4uSwtPmhDuPq
         znjDJ4hnE4QvrQpSM7OF5IeluCGmGAB6EY0YzrB+CwjLtiangIxKlDcA5tA1Baux4w0S
         KrdT05YZ+zSRu2H0McNQGgRSv+/CaWBhPVN832WeCEWp7HruB8+Cn0fLoz5GF23Kkk6I
         gBvg/sKRv8xrVcuy2CHNPOt3IsHaEx6S1pzGSowJTDI014qn+phU4/Ib5x/Kz0PWs09x
         oFbar11H+EWLzg1e0R50GQg7CxNmkbEEGtmEf7lPR/Q5M89+0PqwszmuaYUypOoTBP5C
         8tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749104018; x=1749708818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hn7NBr5TJWjNI8T2dY/UzcUhiHMyl/nutXcvd+GUfmM=;
        b=RJmS+ERdrYlU28VEojcCtiJsOo4b2xOeJdt9BTDmSB1Ah3oswvoUIyXqNctNmat7lU
         LX32b5VnG4lGoHUkyVFCJqvwK5sIAMKviLTqUv4I4v8IVRn2jIqqiIEpsdDMtg9Vj+Og
         PgHjvI90oEZq7Qu2b3nlNvCNy61WnpJVridgqmJ8U6afuWlnNUxFIk6VbM50v4ZLWf4X
         8MXp08Zn1381kM2D7WlUHfGTRU0aIRX8tkMYdUgEbu3/afZ4GqkXPNTDS7jZS0Uit8Du
         T7qDWqEMQVn7vvdpln7ijHHcTDtq1C8Y5zEFJZxUheFoYzIwAOMnnL6A6O5s9+O6Y0uB
         o/pg==
X-Forwarded-Encrypted: i=1; AJvYcCU5nzLmgWat5rblUIGqgJqwJgdB32SHfje9Ml0Yrm7GZ1gGJSNFuAghFEsY2xSc816/vyp73Tatca1O79QuDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLypgXqEmoHp4C8fJgTAKslsThfrzPFV1c2BIdESUao0hsCkRS
	j4a98N4GYg1IeD5VqaUjHUUhG8I8FMzf81+mvrTGk6k83hMf9SDW+KCBvP7j8G5Ih3A=
X-Gm-Gg: ASbGncuQFjTG5EjET0aPR+T6EsZ7jqxdQZwqrc4E+mMbyyF5k3G4vD/ZQmBFJpD8AIW
	WKtDmYojzUlxdZD9+EJKf58X5DP2JaNCW9gHHgUA/CMNk352InZ0e6reYPkhCwnOEdmFu44IcAo
	7RoCFMTOgadxAlU0TVOfTx9q6YbDYH1U8/vdDIZqjWsgzGzh4GeeEUsJQGcgfyj53v/E+bLY3MN
	6+v+WnLGeB+F9ZcCHQA21WycJr0t5AFdcdCgiTXYw2ZOXXVr4wUAYnGuvu0fEq+jeOKxpuXgyh7
	A6Q/9qNkMtMaybrCB2f806rs2V5V9pi0b25Rf42xq6YReydOyg9l2of1CnF0uTT0GXMfi8b8kXk
	=
X-Google-Smtp-Source: AGHT+IHDy86FEw+vzJcbrf39p87S4pydRZ7lyu+1r5y5V92k7PKGXeaSlNE+WkPTO7jTgdMiiqKipg==
X-Received: by 2002:a17:90b:5290:b0:311:9c9a:58c5 with SMTP id 98e67ed59e1d1-3130cd146e2mr10841635a91.12.1749104018411;
        Wed, 04 Jun 2025 23:13:38 -0700 (PDT)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313319020e0sm477078a91.12.2025.06.04.23.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 23:13:37 -0700 (PDT)
Message-ID: <1fd82421-90ad-4952-8fc0-77859f861570@bytedance.com>
Date: Thu, 5 Jun 2025 14:13:27 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/25 10:19 PM, Lorenzo Stoakes wrote:
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
> v2:
> * Renamed walk_page_range_novma() to walk_page_range_debug() as per David.
> * Moved walk_page_range_debug() definition to mm/internal.h as per Mike.
> * Renamed walk_page_range_kernel() to walk_kernel_page_table_range() as
>    per David.
> 
> v1 resend:
> * Actually cc'd lists...
> * Fixed mistake in walk_page_range_novma() not handling kernel mappings and
>    update commit message to referene.
> * Added Mike's off-list Acked-by.
> * Fixed up comments as per Mike.
> * Add some historic flavour to the commit message as per Mike.
> https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle.com/
> 
> v1:
> (accidentally sent off-list due to error in scripting)
> 
>   arch/loongarch/mm/pageattr.c |  2 +-
>   arch/openrisc/kernel/dma.c   |  4 +-
>   arch/riscv/mm/pageattr.c     |  8 +--
>   include/linux/pagewalk.h     |  7 ++-
>   mm/hugetlb_vmemmap.c         |  2 +-
>   mm/internal.h                |  4 ++
>   mm/pagewalk.c                | 98 ++++++++++++++++++++++++------------
>   mm/ptdump.c                  |  3 +-
>   8 files changed, 82 insertions(+), 46 deletions(-)
> 

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks.


