Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E29ECCA47F
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:19:59 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7FCC5235F1;
	Mon,  4 Jul 2022 22:19:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 66D3923F5F
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656930215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLXWdW1OqSM9FtEHEE9v5KYWqP90bIZD4fon+v0UH7I=;
 b=CWTetxPTSVfCkMfsz+uD2o3s4BOIfJYASqczP7VkSfztwr2Iuy1cLuWarD29ZbSPg7W041
 NsuVxg5/brQjrJCGQtmx1VTn8I0XE0IbmVkVbk6m1SPibQGJl1odpLuDc2dM7rtwLQiZtD
 TU5pZl2p8dmBW6ODahpSq5n4unGVBYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-xNmU-MhWMUKpxI37-QJ4-Q-1; Mon, 04 Jul 2022 06:23:26 -0400
X-MC-Unique: xNmU-MhWMUKpxI37-QJ4-Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 6-20020a1c0206000000b003a02cd754d1so3871695wmc.9
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bLXWdW1OqSM9FtEHEE9v5KYWqP90bIZD4fon+v0UH7I=;
 b=6johVr9bIlErxcy5oToMRKlSsKMC6TdRyptadJP4rnB0VUhCmnavn7leXsVH38bJQd
 Me3wOaxS7P7nJtFOazOFvHIX7ESG0DGisuHZhfgxpPGSnIR7B+AQvrZ/2W2c8oD+/VST
 6zJOA3wNBLMTpC0BxRP49UiwTJta/WXVw472C5rOTKPVsBUfKBvU86UZg/VppzV4cU1F
 m5UiDAM+vG7v0PRKetV7j/plfxEyBKDkarugVtF4nNvvqsTQeqnrPP6JqevaN6X0io9u
 EolWePy4fUebiLjAr2AmQV1Qw335d6WI3/FvBUMCF4ESfmVbi3HtXmoG/O/G/W6TAYEP
 3ZCQ==
X-Gm-Message-State: AJIora9Qlre+gzREXDspEVvLouHjI1p34HACvUAx1SvqiKwVG7ATYgSX
 QUyZkUvrgzbyy4yK4XTegxkIJh7GCOBMpZqG3B/fvlrhdp8K0BCA21Agjbf9LDnFFcFuQ2CqnbV
 9csWjNcvsFNMAegf5dyViNlkzLA==
X-Received: by 2002:a05:6000:88:b0:21d:691c:38d5 with SMTP id
 m8-20020a056000008800b0021d691c38d5mr5489805wrx.450.1656930205374; 
 Mon, 04 Jul 2022 03:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tiQHC2xWi45kuRNSklvjfKFrQfxf4qPsZDMEQrDR+54fyq9W9ri3OSLJOOSTKxDc49vznmuw==
X-Received: by 2002:a05:6000:88:b0:21d:691c:38d5 with SMTP id
 m8-20020a056000008800b0021d691c38d5mr5489790wrx.450.1656930205146; 
 Mon, 04 Jul 2022 03:23:25 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a1c7c01000000b003a02b135747sm18987283wmc.46.2022.07.04.03.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:23:24 -0700 (PDT)
Message-ID: <78ac87ee-e40b-8d18-3775-4417edb74fa3@redhat.com>
Date: Mon, 4 Jul 2022 12:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
To: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
 <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
 <b8d2595b-c86a-b1b8-8912-13fc9ba782d3@redhat.com>
 <31017a43-3ebb-0aa3-f6ce-d2df1b5dc177@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <31017a43-3ebb-0aa3-f6ce-d2df1b5dc177@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Jul 2022 22:19:56 +0200
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
Cc: "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>, Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 04/07/2022 12:21, Richard Henderson wrote:
> On 7/4/22 15:46, Laurent Vivier wrote:
>> On 04/07/2022 11:59, Richard Henderson wrote:
>>> On 7/4/22 02:58, Stafford Horne wrote:
>>>> -static const MemoryRegionOps goldfish_rtc_ops = {
>>>> -    .read = goldfish_rtc_read,
>>>> -    .write = goldfish_rtc_write,
>>>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>>>> -    .valid = {
>>>> -        .min_access_size = 4,
>>>> -        .max_access_size = 4
>>>> -    }
>>>> +static const MemoryRegionOps goldfish_rtc_ops[3] = {
>>>> +    [DEVICE_NATIVE_ENDIAN] = {
>>>> +        .read = goldfish_rtc_read,
>>>> +        .write = goldfish_rtc_write,
>>>> +        .endianness = DEVICE_NATIVE_ENDIAN,
>>>> +        .valid = {
>>>> +            .min_access_size = 4,
>>>> +            .max_access_size = 4
>>>> +        }
>>>> +    },
>>>> +    [DEVICE_LITTLE_ENDIAN] = {
>>>> +        .read = goldfish_rtc_read,
>>>> +        .write = goldfish_rtc_write,
>>>> +        .endianness = DEVICE_LITTLE_ENDIAN,
>>>> +        .valid = {
>>>> +            .min_access_size = 4,
>>>> +            .max_access_size = 4
>>>> +        }
>>>> +    },
>>>> +    [DEVICE_BIG_ENDIAN] = {
>>>> +        .read = goldfish_rtc_read,
>>>> +        .write = goldfish_rtc_write,
>>>> +        .endianness = DEVICE_BIG_ENDIAN,
>>>> +        .valid = {
>>>> +            .min_access_size = 4,
>>>> +            .max_access_size = 4
>>>> +        }
>>>> +    },
>>>>   };
>>>
>>> You don't need 3 copies, only big and little.
>>>
>>>> +static Property goldfish_rtc_properties[] = {
>>>> +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
>>>> +                      DEVICE_NATIVE_ENDIAN),
>>>> +    DEFINE_PROP_END_OF_LIST(),
>>>> +};
>>>
>>> ... and I think the clear desire for default is little-endian.  I would make the 
>>> property be bool, and add a comment that this is only for m68k compatibility, so don't 
>>> use it in new code.
>>
>> m68k doesn't really need this.
>>
>> kernel with the m68k virt machine and goldfish device supports "native" mode so I think 
>> it's not needed to add another layer of complexity for it.
> 
> "Another level"?  I'm talking about removing "native", and only having "big" and "little", 
> which is less complexity.

"Less complexity" is to keep only native. I'm not against the change, I'm just saying it's 
not needed by m68k.

Thanks,
Laurent

