Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127F223321
	for <linux-openrisc@vger.kernel.org>; Thu, 12 Jun 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732349; cv=none; b=IArcXorXI38QJxGXgJ3eqx8LMP5ztSWSn2q6pWZ0yyLLsHFzpmWwbDNCn49FdRG0SPbQLX2tJgAw4vKDXk4pzXGHROfpegU7FMkA5AiDXFF98hG/QscCyCmiHifHZozH1XSmaOQydamG1aF7AG8awu6IIoXUr5xb02ZN2neXWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732349; c=relaxed/simple;
	bh=HoLHGzQC+LhOVvQLSwKR9GEa2zUH1xYcB1f994eH/jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ert9i+EYhF8DUNkPzLPcRhna/7WPb/duw3jtn8gRINIlq9F3mGz04i1B07OobPPUbQzWPX9RbLmoqssW0Q7VkUaiDrPGJ6TEKBn4D71WHJNMizVSB9kyppEXUDv7a7PAohXg2PCw3tEpo13tovQRrVTXXyvrOHxBtJ8ZqGOBkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAjVpe0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAjVpe0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749732346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h1Uj5bKVq17uQh522HM2lfY2Qa1Wofw7MCwyR4moTpc=;
	b=MAjVpe0i6gugETntChxu+dY+czlg5B9EryL09StnSh6qxd2R3XK5+r2p7ZbZ4kELFEIVhw
	r0iRWIyoICCn0OsD4crGe+/EL2p3LId/sbNLdF08ehLRp2OASze8oLsqijXmOIkHS/iShP
	CzSk7GQvrtwEGzD3v+3H3zL130+sbM0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-exHDQpykNzuO2ST0qb-QSQ-1; Thu, 12 Jun 2025 08:45:46 -0400
X-MC-Unique: exHDQpykNzuO2ST0qb-QSQ-1
X-Mimecast-MFC-AGG-ID: exHDQpykNzuO2ST0qb-QSQ_1749732344
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-441c122fa56so4659725e9.2
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Jun 2025 05:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749732344; x=1750337144;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1Uj5bKVq17uQh522HM2lfY2Qa1Wofw7MCwyR4moTpc=;
        b=swqE4wp15knWM9f5QEK7p7aTFQjM0BEEEYIvWn+onEwMw8MP7XzECvtzq79fhSwS2M
         qfJHyQ+eKnrg+eK/GQH5veBTVHn4t62iZmp7QThEiAANFoGPxokb0hM8RCpUQSz2XX8f
         tUnZRx/o6FZMxRKnSLITATHZkASb5UBeXtVOH0kXs8r5qDfqAiacYRP6LgEA/ttv5H8D
         arMLCCku3eI5eQknTADbXXHNajjO/R6kTSR3g6A7pZMBbksV7gLrr11+lCCfonHuyroy
         IaAS2eCCJbmk6mIB3/xWcnVzD76rdDy1JvCJZtibiSKI5fN5ZetpKUPiHTZL7xN0KAQB
         V7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3mwWW30zDGhG61ul9P6dkv49vFxNhzE+Lxj1zc35j1saJEO+YiIlg7RCmmqqcCG5VCuyy5E6v6bZ3sPmXDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPbBw8a4MPOVmxadBvckRHOcBX5csMwhEl5D6h8VK8PAF6tPw
	APIDHVHW1OgDj11fYxG6Bpvd/M4N/jpCF8pE90aw6Av9HINMkByIhuic6GOM8znCiAM2nn48mWK
	1awVCPnuGHSLYiCmw5292g87XuDBA174YnkQFmVdIlcqLZzk95PQxC5w327ofeNYMPmWL
X-Gm-Gg: ASbGnct0sDecFnT0cgri+aH0/ZSdoF03zLDzbx2opvT+2ik+rl6AizXv1nmty/vVzV1
	VyFkdiLdXt+1S3FXhCaFGt7bOLhslU6QtglntEWvr14oNthFk+o9FbqWoyIEqcvGycvJs2ck7fw
	LxF/ki4TXte57HhgAfgY0NAu/oFsNfyaEs31h8gFkUQDCad8yF9bX8gMzPJgW4pccHlRmIf/Dvg
	LeUm+KklEA4WOZp+IoseQCrlFxzWAbKH9NwuWyVCgIjXROj3fAFKhPr1a8Us5bpUVt8Cirk1YPC
	VXu3bckdJu1lnv8RAlfKsRXkBC7h1Om2ON0YAftuAn1g4vppxMBL8/hxSmWG3zgwAeMkDTj39B1
	tcN+hmU9Uhyg4PTJi6lwYvovK7Iox2MO+V/PvwsiZ4+SKuc72MQ==
X-Received: by 2002:a05:600c:1d9b:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-453248cafd1mr57469455e9.28.1749732344321;
        Thu, 12 Jun 2025 05:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBhS3dap152ENPi3Y9aJXIykXlE/iZmdZzWOxrglxpuZ/Lv9Y9TZqjfdhHI97NDjzdY36Yxw==
X-Received: by 2002:a05:600c:1d9b:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-453248cafd1mr57469025e9.28.1749732343893;
        Thu, 12 Jun 2025 05:45:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea07e3sm19940355e9.9.2025.06.12.05.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 05:45:43 -0700 (PDT)
Message-ID: <95b46a68-3461-4555-a168-df82d53efcf3@redhat.com>
Date: Thu, 12 Jun 2025 14:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/pagewalk: split walk_page_range_novma() into
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
References: <20250605135104.90720-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250605135104.90720-1-lorenzo.stoakes@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 88skeApcrisREAAqFcpSXwCCimR0DCgCWtntDx_tCXM_1749732344
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.25 15:51, Lorenzo Stoakes wrote:
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
> The walk_page_range_debug() function is currently used to traverse both
> userland and kernel mappings, so we maintain this and in the case of kernel
> mappings being traversed, we have walk_page_range_debug() invoke
> walk_kernel_page_table_range() internally.
> 
> We additionally make walk_page_range_debug() internal to mm.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

