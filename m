Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C62C3A5A7
	for <openrisc@archiver.kernel.org>; Thu,  8 Dec 2022 08:55:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9833A24B86;
	Thu,  8 Dec 2022 09:55:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 5F4792491C
 for <openrisc@lists.librecores.org>; Thu,  8 Dec 2022 09:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670489755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZzQND0XXn/ac1VVVRiwKzVF2wPIGejtH8QPoB1hHfA=;
 b=QPFkG++A/8JL5La+pALQpMxgOwAt4ktwVCkc0B7GKmSOmsQdJwO6bUe02qtZHfivaxVdc3
 G9Wjgdcy6CTAaGzTr8Cckc2sdx+1EbdNMrC++y5ZAPBbYS5RMOrBZy9yOPYliW8bDkf1S/
 1Ay3qqX5PGov4onlFtRbv5LxaYRg05Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-YS_Fq9MkMBqfgBEJQwZoKg-1; Thu, 08 Dec 2022 03:55:54 -0500
X-MC-Unique: YS_Fq9MkMBqfgBEJQwZoKg-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg25-20020a05600c3c9900b003cf3ed7e27bso509473wmb.4
 for <openrisc@lists.librecores.org>; Thu, 08 Dec 2022 00:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZzQND0XXn/ac1VVVRiwKzVF2wPIGejtH8QPoB1hHfA=;
 b=VdBrSB5gMqyy9SY/jKkvUHHxNPo6oYmnVScjsv1z/2D5qgQpl7bvy79rthusnyFhtE
 jrmE3oFZj3QX56XdP61z3G683stYkaYkqxZyBVtBaRzACuANwqXmHZn2rH9S/BrAPiVM
 hYFOKNb6YXuzuRceJyMQwvXBjLgYefC4vY0HU3YPduinZY7cK0tOp2ZClR5o7ljXNb6S
 EZBk0h3Bblg0RHII4zAHAI0M45AheinFj/ShLhlBb139ZTD6n/w1XGlHZaF3J8H99R7Q
 M+nHOypHhl6f8DV0yg+vtsndwOFamCgNGxgWKfl3cxq0hhuA50i0GOli+ZRs9VjRuMg2
 rmyQ==
X-Gm-Message-State: ANoB5plzLcuV0J0pj1gBfZG7j/FOMOLqccPCyJuzI8Wk/WJU18A1zrvk
 nFB6GJ8EfDZAnjOTXSYiaNjVUjizG0uVKbiI8g5AniJdtAW3huf/AG+3Qed/oJWY0yge5XOIAvf
 F7DL4jxQJPHVTlM2aflqbl0mmJw==
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id
 h13-20020a5d504d000000b00242246c2f89mr22919592wrt.108.1670489752974; 
 Thu, 08 Dec 2022 00:55:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf668NfxbMXQWSDBD6iCzqqUG4mJSCJROvTfbJs0ERpg3lPeZTVH/8wev7o0MHbpIs1xArxqSg==
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id
 h13-20020a5d504d000000b00242246c2f89mr22919565wrt.108.1670489752626; 
 Thu, 08 Dec 2022 00:55:52 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 o29-20020adfa11d000000b0024278304ef6sm6288982wro.13.2022.12.08.00.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 00:55:52 -0800 (PST)
Message-ID: <c904aa67-1add-119c-162f-e35d8243a11a@redhat.com>
Date: Thu, 8 Dec 2022 09:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable RFC 17/26] powerpc/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
From: David Hildenbrand <david@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221206144730.163732-1-david@redhat.com>
 <20221206144730.163732-18-david@redhat.com>
 <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
 <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Organization: Red Hat
In-Reply-To: <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
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

On 08.12.22 09:52, David Hildenbrand wrote:
> On 07.12.22 14:55, Christophe Leroy wrote:
>>
>>
>> Le 06/12/2022 à 15:47, David Hildenbrand a écrit :
>>> We already implemented support for 64bit book3s in commit bff9beaa2e80
>>> ("powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s")
>>>
>>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also in 32bit by reusing yet
>>> unused LSB 2 / MSB 29. There seems to be no real reason why that bit cannot
>>> be used, and reusing it avoids having to steal one bit from the swap
>>> offset.
>>>
>>> While at it, mask the type in __swp_entry().
>>>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>     arch/powerpc/include/asm/book3s/32/pgtable.h | 38 +++++++++++++++++---
>>>     1 file changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> index 75823f39e042..8107835b38c1 100644
>>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> @@ -42,6 +42,9 @@
>>>     #define _PMD_PRESENT_MASK (PAGE_MASK)
>>>     #define _PMD_BAD	(~PAGE_MASK)
>>>     
>>> +/* We borrow the _PAGE_USER bit to store the exclusive marker in swap PTEs. */
>>> +#define _PAGE_SWP_EXCLUSIVE	_PAGE_USER
>>> +
>>>     /* And here we include common definitions */
>>>     
>>>     #define _PAGE_KERNEL_RO		0
>>> @@ -363,17 +366,42 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>>>     #define pmd_page(pmd)		pfn_to_page(pmd_pfn(pmd))
>>>     
>>>     /*
>>> - * Encode and decode a swap entry.
>>> - * Note that the bits we use in a PTE for representing a swap entry
>>> - * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
>>> - *   -- paulus
>>> + * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
>>> + * are !pte_none() && !pte_present().
>>> + *
>>> + * Format of swap PTEs (32bit PTEs):
>>> + *
>>> + *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>>> + *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>> + *   E H P <- type --> <----------------- offset ------------------>
>>
>> That's in reversed order. _PAGE_HASHPTE is bit 30 and should be on the
>> right hand side. Etc ...
> 
> Ugh, messed it up while converting back and forth between LSB 0 and MSB 0.
> 
> /*
>    * Format of swap PTEs (32bit PTEs):
>    *
>    *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>    *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>    *   <----------------- offset ------------------> <- type --> E H P
> 
> 

Still wrong, the type is only 5 bits:

+ * Format of swap PTEs (32bit PTEs):
+ *
+ *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
+ *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ *   <----------------- offset --------------------> < type -> E H P
+ *


-- 
Thanks,

David / dhildenb

