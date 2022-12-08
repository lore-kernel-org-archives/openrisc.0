Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CE8C4332F
	for <openrisc@archiver.kernel.org>; Thu,  8 Dec 2022 08:53:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 30B2D248E6;
	Thu,  8 Dec 2022 09:53:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 12C0C2491C
 for <openrisc@lists.librecores.org>; Thu,  8 Dec 2022 09:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670489583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtVANh0eBS7cuUnAJkHyLAHfwCxkRrG12+slAtG+/Kc=;
 b=IClx/LisKfBtIcHpzbH6x3AbgwRGFfJPSDbfUuYc9Rawl3Sn/QKS0wkD9UxMwGAgyZuMPh
 NE9xXhV4RLHbZa2jGwtMoqXRnqnptkOxiTnzi7S9fVJewwxHTKd4lLuRRhaBYI09eJnb1I
 s6GRxkGsMHT9eREEMsyAksXk92Vlmbw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-P91uWqC9Os-dyeD9aRVsVw-1; Thu, 08 Dec 2022 03:53:01 -0500
X-MC-Unique: P91uWqC9Os-dyeD9aRVsVw-1
Received: by mail-wm1-f70.google.com with SMTP id
 u9-20020a05600c00c900b003cfb12839d6so350710wmm.5
 for <openrisc@lists.librecores.org>; Thu, 08 Dec 2022 00:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WtVANh0eBS7cuUnAJkHyLAHfwCxkRrG12+slAtG+/Kc=;
 b=09Y9Kl9fmjTogSfh8kcnom3GNJFVs8y5x9UbztYmmEp7ckp5Wlc3Ufu60onO0pCI6R
 REqP5lSFRmXXCNf9MXG9zI3DjanBNiZZ5AaP9E7vMM21cGdOlRVEf3XH9WKBAsmlF/iU
 11xyFTFQG1Wzo/VruZt+Ae9Y20yTbBE6c6ADnn7NOfNScL/2rSNXY9yYEjAMBlQLqlLD
 USCmBNO/Xb6iHiE4lq+/F1Ln/+e+XQAurrm4uGiwHYXRuSA0szPqZ6A0doVmBDai8yYZ
 BbYKWxIMhry8V/UXLgxpebXRayJD71jaZ3iwbGO2rW+DgO1y/7o64ichmxR2xiuweJq+
 A4Kg==
X-Gm-Message-State: ANoB5pk2l2k29dcdXGRcJEm0Er6C+rWS3mqvnkGVGIJl6EL9iAq/jWVq
 AHJHZQd6s9/NgiQDTM0MSiZn8xDGJ2NZ+17ubHaY88iWzIiaGr2jYoV8fXH4iy30aYaVhIAsIVl
 CqNMvIez3gfhhGvAHzOWZF4vdzA==
X-Received: by 2002:a7b:c3d3:0:b0:3d1:cec6:75a8 with SMTP id
 t19-20020a7bc3d3000000b003d1cec675a8mr10610868wmj.206.1670489580101; 
 Thu, 08 Dec 2022 00:53:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43lyCBCnse73L4nmQgwKX2lVPb0zDtRkTV00eD7UM2rHA9mTsLvJ7fK1IaCMRkleIpPTdzzg==
X-Received: by 2002:a7b:c3d3:0:b0:3d1:cec6:75a8 with SMTP id
 t19-20020a7bc3d3000000b003d1cec675a8mr10610851wmj.206.1670489579743; 
 Thu, 08 Dec 2022 00:52:59 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a05600c350100b003a2f2bb72d5sm5810986wmq.45.2022.12.08.00.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 00:52:59 -0800 (PST)
Message-ID: <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Date: Thu, 8 Dec 2022 09:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221206144730.163732-1-david@redhat.com>
 <20221206144730.163732-18-david@redhat.com>
 <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable RFC 17/26] powerpc/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
In-Reply-To: <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Hugh Dickins <hughd@google.com>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 07.12.22 14:55, Christophe Leroy wrote:
> 
> 
> Le 06/12/2022 à 15:47, David Hildenbrand a écrit :
>> We already implemented support for 64bit book3s in commit bff9beaa2e80
>> ("powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s")
>>
>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also in 32bit by reusing yet
>> unused LSB 2 / MSB 29. There seems to be no real reason why that bit cannot
>> be used, and reusing it avoids having to steal one bit from the swap
>> offset.
>>
>> While at it, mask the type in __swp_entry().
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    arch/powerpc/include/asm/book3s/32/pgtable.h | 38 +++++++++++++++++---
>>    1 file changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> index 75823f39e042..8107835b38c1 100644
>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> @@ -42,6 +42,9 @@
>>    #define _PMD_PRESENT_MASK (PAGE_MASK)
>>    #define _PMD_BAD	(~PAGE_MASK)
>>    
>> +/* We borrow the _PAGE_USER bit to store the exclusive marker in swap PTEs. */
>> +#define _PAGE_SWP_EXCLUSIVE	_PAGE_USER
>> +
>>    /* And here we include common definitions */
>>    
>>    #define _PAGE_KERNEL_RO		0
>> @@ -363,17 +366,42 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>>    #define pmd_page(pmd)		pfn_to_page(pmd_pfn(pmd))
>>    
>>    /*
>> - * Encode and decode a swap entry.
>> - * Note that the bits we use in a PTE for representing a swap entry
>> - * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
>> - *   -- paulus
>> + * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
>> + * are !pte_none() && !pte_present().
>> + *
>> + * Format of swap PTEs (32bit PTEs):
>> + *
>> + *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>> + *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>> + *   E H P <- type --> <----------------- offset ------------------>
> 
> That's in reversed order. _PAGE_HASHPTE is bit 30 and should be on the
> right hand side. Etc ...

Ugh, messed it up while converting back and forth between LSB 0 and MSB 0.

/*
  * Format of swap PTEs (32bit PTEs):
  *
  *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
  *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
  *   <----------------- offset ------------------> <- type --> E H P


Now the patch description ("unused LSB 2 / MSB 29") makes sense.

Thanks!

Any feedback if the bit could be problematic?

-- 
Thanks,

David / dhildenb

