Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE55AC43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:19:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6B47E211D5;
	Mon,  4 Jul 2022 22:19:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id DC6DA20C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656929812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5yELtTdELIv7VIGZgeMH4CiGHZUar6RzmTrSw9j30Y=;
 b=F8lolbEygS747+C631c2gyHPqeuB5ARxTIii02Gpo/Z7fZlT4vVpqdVE1ezRgy8//O8SV8
 9kZ0fQ5R6mNSkflYVUnzrqrUhEsdfhHlTbrGOsZ5hJhrzOoQfaasYdbWp/PYV+mJYnco94
 wZlrqTSTzSOpf59n5I0dL2oDMO4ZflE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-u1CAhm-KMLugSd8jdMdGAA-1; Mon, 04 Jul 2022 06:16:51 -0400
X-MC-Unique: u1CAhm-KMLugSd8jdMdGAA-1
Received: by mail-qt1-f200.google.com with SMTP id
 bc7-20020a05622a1cc700b0031e7e46e660so480664qtb.10
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Y5yELtTdELIv7VIGZgeMH4CiGHZUar6RzmTrSw9j30Y=;
 b=67vNYc4TTc9VoG5CUq5pN54ZkdGv3j8OOATBx4uRwGMsa4/dtdkuI5HVeHdCUIJXmZ
 jfRzAaMVpDfg/J9etjM+xTQMeh2mwhAuYjtDeVjGubWGfVDdcat8DDx8+Sztz0FWyKJq
 1A0tb9utN5wdwqKWkd+uw/SDl4/C60L++NsUbnz1nLYtaIY5hiMiiWNWZMgEL/n/sOW4
 JgMb/xDkrNXhOlt4PWpQ+7nj24IQsUsmsd4LsSpUdLJcnHJV2RNMYrSXDZnX1/iOk27I
 MEKBIl/F8/h5M890BQ3jMecJOBJMzwyaVrRA/1cuJlEUCPxYTTEI6vsCGSo9AuYgViUo
 t38w==
X-Gm-Message-State: AJIora/hgLzHR0AuMFo+yJSZ7R2VY39QCZy5ZYW6pDHUAZSAhTtgtcRs
 zJhXZvI5AXSYM6Vdz4oQzxzJZT/EnsiCzU+vy9yb7++pCx2CKMK/+Y0tg4JSRyDl4gr3ihvtO1o
 ErkN9wfm/gt7CVwC0XX/rkJw5gw==
X-Received: by 2002:ad4:5aed:0:b0:472:7778:ff87 with SMTP id
 c13-20020ad45aed000000b004727778ff87mr26430718qvh.28.1656929811121; 
 Mon, 04 Jul 2022 03:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vjlUq1XlEkFFJxbANJNMJkD14jL7MU+k/cunLgR262M2/UAJwOwaKcp4jQ6IoO80vX//GXBA==
X-Received: by 2002:ad4:5aed:0:b0:472:7778:ff87 with SMTP id
 c13-20020ad45aed000000b004727778ff87mr26430705qvh.28.1656929810811; 
 Mon, 04 Jul 2022 03:16:50 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a05620a44cb00b006a37eb728cfsm19463960qkp.1.2022.07.04.03.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:16:50 -0700 (PDT)
Message-ID: <b8d2595b-c86a-b1b8-8912-13fc9ba782d3@redhat.com>
Date: Mon, 4 Jul 2022 12:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
To: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
 <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
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

On 04/07/2022 11:59, Richard Henderson wrote:
> On 7/4/22 02:58, Stafford Horne wrote:
>> -static const MemoryRegionOps goldfish_rtc_ops = {
>> -    .read = goldfish_rtc_read,
>> -    .write = goldfish_rtc_write,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> -    .valid = {
>> -        .min_access_size = 4,
>> -        .max_access_size = 4
>> -    }
>> +static const MemoryRegionOps goldfish_rtc_ops[3] = {
>> +    [DEVICE_NATIVE_ENDIAN] = {
>> +        .read = goldfish_rtc_read,
>> +        .write = goldfish_rtc_write,
>> +        .endianness = DEVICE_NATIVE_ENDIAN,
>> +        .valid = {
>> +            .min_access_size = 4,
>> +            .max_access_size = 4
>> +        }
>> +    },
>> +    [DEVICE_LITTLE_ENDIAN] = {
>> +        .read = goldfish_rtc_read,
>> +        .write = goldfish_rtc_write,
>> +        .endianness = DEVICE_LITTLE_ENDIAN,
>> +        .valid = {
>> +            .min_access_size = 4,
>> +            .max_access_size = 4
>> +        }
>> +    },
>> +    [DEVICE_BIG_ENDIAN] = {
>> +        .read = goldfish_rtc_read,
>> +        .write = goldfish_rtc_write,
>> +        .endianness = DEVICE_BIG_ENDIAN,
>> +        .valid = {
>> +            .min_access_size = 4,
>> +            .max_access_size = 4
>> +        }
>> +    },
>>   };
> 
> You don't need 3 copies, only big and little.
> 
>> +static Property goldfish_rtc_properties[] = {
>> +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
>> +                      DEVICE_NATIVE_ENDIAN),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
> 
> ... and I think the clear desire for default is little-endian.  I would make the property 
> be bool, and add a comment that this is only for m68k compatibility, so don't use it in 
> new code.

m68k doesn't really need this.

kernel with the m68k virt machine and goldfish device supports "native" mode so I think 
it's not needed to add another layer of complexity for it.

Thanks,
Laurent

