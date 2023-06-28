Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC50EB64DC;
	Wed, 28 Jun 2023 08:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjF1IAo (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 28 Jun 2023 04:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232214AbjF1H55 (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 28 Jun 2023 03:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SH32jNlN6Jqg7DPKFWcTzn8QudVshhtxY6DizRJx1h4=;
        b=bghMily1ZUr18Du8X6lc/12R62hBJFLVlvFqOtalzA6DhArtCs1ZmJdodpIvfSUyT6MDIE
        YglButbvEZ8O182fXbTCqOB+dCJOizeNd2KnDn9kGAUprMwjlUNQ+swzLDtdaqH4fZIFZX
        qYhiVHbp/5H7dTEnoDo2y739QW8b7YI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-bl5QZLWxNdKbwB3kHij_fA-1; Wed, 28 Jun 2023 03:41:22 -0400
X-MC-Unique: bl5QZLWxNdKbwB3kHij_fA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d44so3295864e87.3
        for <linux-openrisc@vger.kernel.org>; Wed, 28 Jun 2023 00:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938081; x=1690530081;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SH32jNlN6Jqg7DPKFWcTzn8QudVshhtxY6DizRJx1h4=;
        b=Wy/zypguPyboelY2gmAmepacSQMn+h/3sw2aWG/V9VfRNijXqlKclqQ8reEUgo6/yS
         pejIvIjNXEaPSzwk8L1sn1v90OcOoFprUgg1J08b351l8aYkunVxHT2TO1IuNlq0NhEo
         VCeBngV1v80TPrpb8u8PZg1tYzCXe7fB4pawJYd/nHHBu+BLExMhLsSo/Y9XnE7bJ/oB
         yvINyhPa4UkbZbfk1IkqdHAnv23F/16AlGYYpF8RDfDbd8crdfxb9k8ApuYAbD4p/hz7
         vAp95ksUaqYw+l0o2sY3cl6vwIbyPLJwEDtosQfnxyS4M3HI6F4rBicJbghZgAlroeRV
         RLIA==
X-Gm-Message-State: AC+VfDy2Z9rgz29+dEWHxLpL6M2BcQJeMmkZMZBmz67XXUCEGDjoCAjt
        l5j5oeQMhBqt6kJQkk2fBm2joW9s4MrAxIbuTM6qghDsuqvcW9p9T4QL24mC89pPUA8lk0Leou+
        gnY5Ac8/Q5wzn4V9y6N8FemHH/NDO7qpa2lA=
X-Received: by 2002:a05:6512:10cb:b0:4fb:9341:9921 with SMTP id k11-20020a05651210cb00b004fb93419921mr540037lfg.52.1687938081184;
        Wed, 28 Jun 2023 00:41:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/LL8Q6ptsPVewMKWY4urM5AzIoWSMnfr2lL0PypvevicnXRpVgfkYzOOBDpLnug9qgwbQPw==
X-Received: by 2002:a05:6512:10cb:b0:4fb:9341:9921 with SMTP id k11-20020a05651210cb00b004fb93419921mr540021lfg.52.1687938080672;
        Wed, 28 Jun 2023 00:41:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ef00:fa40:f6df:a68d:a0e4? (p200300cbc715ef00fa40f6dfa68da0e4.dip0.t-ipconnect.de. [2003:cb:c715:ef00:fa40:f6df:a68d:a0e4])
        by smtp.gmail.com with ESMTPSA id hn10-20020a05600ca38a00b003fba586100fsm3970092wmb.6.2023.06.28.00.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 00:41:20 -0700 (PDT)
Message-ID: <26282cb8-b6b0-f3a0-e82d-b4fec45c5f72@redhat.com>
Date:   Wed, 28 Jun 2023 09:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Hugh Dickins <hughd@google.com>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <e8992eee-4140-427e-bacb-9449f346318@google.com>
 <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
 <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
In-Reply-To: <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 27.06.23 22:13, Hugh Dickins wrote:
> On Tue, 27 Jun 2023, David Hildenbrand wrote:
>> On 27.06.23 06:44, Hugh Dickins wrote:
>>> On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
>>>
>>>> The MM subsystem is trying to shrink struct page. This patchset
>>>> introduces a memory descriptor for page table tracking - struct ptdesc.
>>> ...
>>>>    39 files changed, 686 insertions(+), 455 deletions(-)
>>>
>>> I don't see the point of this patchset: to me it is just obfuscation of
>>> the present-day tight relationship between page table and struct page.
>>>
>>> Matthew already explained:
>>>
>>>> The intent is to get ptdescs to be dynamically allocated at some point
>>>> in the ~2-3 years out future when we have finished the folio project ...
>>>
>>> So in a kindly mood, I'd say that this patchset is ahead of its time.
>>> But I can certainly adapt to it, if everyone else sees some point to it.
>>
>> I share your thoughts, that code churn which will help eventually in the far,
>> far future (not wanting to sound too pessimistic, but it's not going to be
>> there tomorrow ;) ).
>>
>> However, if it's just the same as the other conversions we already did (e.g.,
>> struct slab), then I guess there is no reason to stop now -- the obfuscation
>> already happened.
>>
>> ... or is there a difference regarding this conversion and the previous ones?
> 
> I was aware of the struct slab thing, didn't see much point there myself
> either; but it was welcomed by Vlastimil, and barely affected outside of
> slab allocators, so I had no reason to object.
> 
> You think that if a little unnecessary churn (a *lot* of churn if you
> include folios, which did save some repeated calls to compound_head())
> has already occurred, that's a good precedent for allowing more and more?

Well, if you phrase it like that ... no, I'm not in favor of unnecessary 
churn at all. Yes, folios were/are a lot of churn (IMHO not unnecessary, 
though).

I'm not a friend of these "overlays"; it all only really makes sense to 
me once we actually allocate the descriptors dynamically. Maybe some of 
the existing/ongoing conversions were different (that's why I was asking 
for the difference, as you said the "struct slab" thing was well received).

If they are primarily only unnecessary churn for now (and unclear 
when/how it will become useful), I share your opinion.

-- 
Cheers,

David / dhildenb

