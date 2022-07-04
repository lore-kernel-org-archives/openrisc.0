Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57776C43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:21:48 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 77E9F23F5F;
	Mon,  4 Jul 2022 12:21:47 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mail.librecores.org (Postfix) with ESMTPS id 18C7520FF5
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:21:46 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 y14-20020a17090a644e00b001ef775f7118so4834560pjm.2
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qWt2Ihirl3CxcG3bKkGlZNvIO1JqH2Inu/DXQlUA0EE=;
 b=h9KHFVX/3i2xfuWWnx4AuGSI+esBHP2tnDnGfQtwS15qAdtBT4wtjqL6ocT9EDMniV
 2r7gWy/iKy3a/NdDaM2GQCgb2whhs4rvK2Jf3IauCsNDo/wYah3HrZ/S5JZyKVXq1Xe8
 7Ayi/zHo/d3MFADS+PgFXbQ44nKsl0FTk+/46ePXi+m/ul6/0BmixLH+ndgrtEmWkBAm
 k76vQ8dd/jt0RTW+E92cZQKDShtNsfSFF+LqcqYOeHu++bygV0AHVFg+gqrJTUC/iLLQ
 rBESoru5KmAKRiKsf7JVXPMUaESmi8xKbMt0cAjzDQIrkvwMlhFQTYyoGTV77ZDkO3Qs
 HGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qWt2Ihirl3CxcG3bKkGlZNvIO1JqH2Inu/DXQlUA0EE=;
 b=d8+dMmncxHJjmwNsI6d/4P1KkzDwM1PwKCTpx/e35E3hdP6DTDxt8AgUboaB1xH7pQ
 rDLgRH1N7skTWiowR6jgSPyFH4baa+W9Q4XCp90fcW83LE4ip0F3gthFlLhEHyjXfckl
 j7v21fSkMgdt1LxJZ5zxdluCpq7+vKkwSCv8OqYWFnx+8V5EXzEP0bEN3BoFG+eJdZme
 1cGruwN9vTa1dZNwnmEQXDwWcf8bXKF3YTUgQcbr0vwX0qVfrQ6Vbf2Of9rMXW/6NmpS
 iSBHpc8hEbTdYd9qzZIJJBVbC9TTtfUzi3RxPJr4d9L3bUnGp7e855ARivvXfHXoZ2Zz
 Q1Pg==
X-Gm-Message-State: AJIora8uEvcD/xYtdL6x/2eI/WFO6m/XFhWRi7VeHCnxlD8i9e132sy2
 bjBye3nCtDO23qxfDH7o27qW+w==
X-Google-Smtp-Source: AGRyM1svFrMArifgbgXqkdXWin0iYwIWPbkz0xHjOwjnpLUa1u5yFpxjBV+QUpUWTQwmFdJm1C0zgA==
X-Received: by 2002:a17:902:e494:b0:16b:dd0e:e11e with SMTP id
 i20-20020a170902e49400b0016bdd0ee11emr7671595ple.7.1656930104756; 
 Mon, 04 Jul 2022 03:21:44 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a1709027e4300b0016bb24f5d19sm8513100pln.209.2022.07.04.03.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:21:44 -0700 (PDT)
Message-ID: <31017a43-3ebb-0aa3-f6ce-d2df1b5dc177@linaro.org>
Date: Mon, 4 Jul 2022 15:51:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, Stafford Horne <shorne@gmail.com>,
 QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
 <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
 <b8d2595b-c86a-b1b8-8912-13fc9ba782d3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b8d2595b-c86a-b1b8-8912-13fc9ba782d3@redhat.com>
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
Cc: "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>, Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/4/22 15:46, Laurent Vivier wrote:
> On 04/07/2022 11:59, Richard Henderson wrote:
>> On 7/4/22 02:58, Stafford Horne wrote:
>>> -static const MemoryRegionOps goldfish_rtc_ops = {
>>> -    .read = goldfish_rtc_read,
>>> -    .write = goldfish_rtc_write,
>>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>>> -    .valid = {
>>> -        .min_access_size = 4,
>>> -        .max_access_size = 4
>>> -    }
>>> +static const MemoryRegionOps goldfish_rtc_ops[3] = {
>>> +    [DEVICE_NATIVE_ENDIAN] = {
>>> +        .read = goldfish_rtc_read,
>>> +        .write = goldfish_rtc_write,
>>> +        .endianness = DEVICE_NATIVE_ENDIAN,
>>> +        .valid = {
>>> +            .min_access_size = 4,
>>> +            .max_access_size = 4
>>> +        }
>>> +    },
>>> +    [DEVICE_LITTLE_ENDIAN] = {
>>> +        .read = goldfish_rtc_read,
>>> +        .write = goldfish_rtc_write,
>>> +        .endianness = DEVICE_LITTLE_ENDIAN,
>>> +        .valid = {
>>> +            .min_access_size = 4,
>>> +            .max_access_size = 4
>>> +        }
>>> +    },
>>> +    [DEVICE_BIG_ENDIAN] = {
>>> +        .read = goldfish_rtc_read,
>>> +        .write = goldfish_rtc_write,
>>> +        .endianness = DEVICE_BIG_ENDIAN,
>>> +        .valid = {
>>> +            .min_access_size = 4,
>>> +            .max_access_size = 4
>>> +        }
>>> +    },
>>>   };
>>
>> You don't need 3 copies, only big and little.
>>
>>> +static Property goldfish_rtc_properties[] = {
>>> +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
>>> +                      DEVICE_NATIVE_ENDIAN),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>
>> ... and I think the clear desire for default is little-endian.  I would make the 
>> property be bool, and add a comment that this is only for m68k compatibility, so don't 
>> use it in new code.
> 
> m68k doesn't really need this.
> 
> kernel with the m68k virt machine and goldfish device supports "native" mode so I think 
> it's not needed to add another layer of complexity for it.

"Another level"?  I'm talking about removing "native", and only having "big" and "little", 
which is less complexity.


r~
