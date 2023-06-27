Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D722EB64D9;
	Tue, 27 Jun 2023 07:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjF0HPW (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 27 Jun 2023 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjF0HPV (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 27 Jun 2023 03:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E71BE7
        for <linux-openrisc@vger.kernel.org>; Tue, 27 Jun 2023 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687850074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1scKhPxxz/YxysE64BuheSdyQmgV4XhiinPf6icWX8=;
        b=Dn/UUUaYUbwjIQ68CDVKfTpiqL3HVvDYjn8rQZkyUA8eNqQO6LCQ/4zOQJK7dJVYbVVVyr
        UN/cVIcuku792pRTFsNpUKEBqx+imPELoNIZypUwSqq3rjs7/KceX7XOvthKDTekoc2Rph
        bI4CMZbD419KTcuqOOYsw1OhLXkM9S8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-eTOQwlc4Oi2xlwjh_5fe8A-1; Tue, 27 Jun 2023 03:14:33 -0400
X-MC-Unique: eTOQwlc4Oi2xlwjh_5fe8A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so17679245e9.3
        for <linux-openrisc@vger.kernel.org>; Tue, 27 Jun 2023 00:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687850072; x=1690442072;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1scKhPxxz/YxysE64BuheSdyQmgV4XhiinPf6icWX8=;
        b=EUsOazRHjGDsfAgzz7Nwl5Hjk5pvAQYcbBZat/fPRY1brDb9eZMqatW7EvbXqJCbBu
         xQN4v/4r+o7V+v5aqxbfE3GDY9xNSv0E27NRvaItUjraQxMFwfSzpOvwgiVOj9JiCdcl
         0YDIz/dRkyaSelei4EvXdeC7Ww6V21O+qSTRahjVjkD7ElGULA0GI7fMrJ/BRdsl3yUG
         g24tGD/DZ0nQAgUPwrmDLGIsRTIwd50YZ2cwaBdnMEbizIRYERG2xO94RaVWdremYp5V
         fHGj0Mnw7pp/mjFNGPDxDnxJmr9bFH2V1Hao6k1SaaycwwOKVM1EiACTnXxTBqHJpCO5
         vOKw==
X-Gm-Message-State: AC+VfDxnYrVxTjKm4ghpwfb/VHDjfERRG4wG4GmhaEvGfGWlASPIwHF9
        lVhz5dVvu/Qp/per5IsjzTU+yH5FB3+74pOxtiWPR55/7QwoVg8kgh2pRo3l1JtfvCPcKbTpEQK
        RzCcP6TGZDNrrcRgNXs3Mday98CE=
X-Received: by 2002:a05:600c:3655:b0:3fa:9d0f:f1e1 with SMTP id y21-20020a05600c365500b003fa9d0ff1e1mr2936784wmq.35.1687850072226;
        Tue, 27 Jun 2023 00:14:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HIpOGvancvhac5jw2GR0kOhKc72MxDndtCuN9HZ1pSF+uaoBl/D52ddajPiSHV9uK1Eb9sw==
X-Received: by 2002:a05:600c:3655:b0:3fa:9d0f:f1e1 with SMTP id y21-20020a05600c365500b003fa9d0ff1e1mr2936755wmq.35.1687850071891;
        Tue, 27 Jun 2023 00:14:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f96d10eafbsm9778433wmg.12.2023.06.27.00.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:14:31 -0700 (PDT)
Message-ID: <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
Date:   Tue, 27 Jun 2023 09:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
To:     Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e8992eee-4140-427e-bacb-9449f346318@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 27.06.23 06:44, Hugh Dickins wrote:
> On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> 
>> The MM subsystem is trying to shrink struct page. This patchset
>> introduces a memory descriptor for page table tracking - struct ptdesc.
> ...
>>   39 files changed, 686 insertions(+), 455 deletions(-)
> 
> I don't see the point of this patchset: to me it is just obfuscation of
> the present-day tight relationship between page table and struct page.
> 
> Matthew already explained:
> 
>> The intent is to get ptdescs to be dynamically allocated at some point
>> in the ~2-3 years out future when we have finished the folio project ...
> 
> So in a kindly mood, I'd say that this patchset is ahead of its time.
> But I can certainly adapt to it, if everyone else sees some point to it.

I share your thoughts, that code churn which will help eventually in the 
far, far future (not wanting to sound too pessimistic, but it's not 
going to be there tomorrow ;) ).

However, if it's just the same as the other conversions we already did 
(e.g., struct slab), then I guess there is no reason to stop now -- the 
obfuscation already happened.

... or is there a difference regarding this conversion and the previous 
ones?

-- 
Cheers,

David / dhildenb

