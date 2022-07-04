Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98252C433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:00:08 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 57AFF20C94;
	Mon,  4 Jul 2022 12:00:07 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mail.librecores.org (Postfix) with ESMTPS id 6103620857
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:00:05 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id d17so8495459pfq.9
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=jbXG5nHD9Kf5UQFUGz6qcmMIViCVERNKm9wbQIX+s2k=;
 b=KubAEpaZkKbp2BOGZOtfSGPN4e545N0AKaaeIMgHWwDpinxgD3/lA4dp2zfR2bnoY2
 SiNpR8zX0bjnXkXN3Wm573hZUXauXmZhmCKYNPWCry/KviXPrFVbDNSKENpiqX37ggJT
 LcQLtZqiq80y9LIDfPEKc2Lw1QLNP9+AOOiY7W89aadC39+J8KuKGlC1DpYRGielWSMj
 oTvOBnjgbjKdVnlMka/ouIlBx9qMwahmyV1cBcEPFUIShAfbE9iwIcz3Qdhx+C+PjaI0
 N0/AFGk2QPxWtK9dUjy+cBZuHlB3fH1RYEmaIGKNZKUcunNw4q/CbfD9sYOnMBxAPYW3
 r4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jbXG5nHD9Kf5UQFUGz6qcmMIViCVERNKm9wbQIX+s2k=;
 b=ZXYqH+kbiyv5TZe+6tTj/iyW2wsCMXoAnTiq9VytzpqEHFTT8Vwvp3vvx4CCU6wklD
 1p9Q673TEXsXiHl/iz28FuuYWxcrtll8sMptjs00zULtl1xBWA52Y6Cd2EzOmr7qdaef
 kzG2SAsOpy8cRdEotNT/ES6GBdZjvQDrsqTXqs8Yx0nQ3VQ4TyQFTS1LyziFxjXkTaeK
 BPJLnadCkHtjx+77cmPqjysWjKwBColNGoXfZQ2Zfn7IY/NoHaXMehNUyK5B7/Z9dfYt
 Yw8wWac81PGFdDM7FpKuMwhY05MN0GBe56Gb8Mhh96+ARhOf3Z7HrbcyPUMKs2b6KQNg
 BVNA==
X-Gm-Message-State: AJIora/L/PbEJQptiuPCjUzPe9DJUqy77pIi9M+y1qmf6NhVCK2PIpEO
 cSHlBYUqlJFMjtX19PhWLGdHJw==
X-Google-Smtp-Source: AGRyM1sVfPO5qausPlo/8gyT74P3aAO0AyUWnmKqS/KGuyhhJaiALtR+9fa+UqvHZYJrCnCCyChmlQ==
X-Received: by 2002:a05:6a00:1a91:b0:525:a57c:25f3 with SMTP id
 e17-20020a056a001a9100b00525a57c25f3mr35742143pfv.75.1656928803879; 
 Mon, 04 Jul 2022 03:00:03 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 w66-20020a627b45000000b005286697ec68sm1803043pfc.133.2022.07.04.03.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:00:03 -0700 (PDT)
Message-ID: <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
Date: Mon, 4 Jul 2022 15:29:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-4-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>, Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/4/22 02:58, Stafford Horne wrote:
> -static const MemoryRegionOps goldfish_rtc_ops = {
> -    .read = goldfish_rtc_read,
> -    .write = goldfish_rtc_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> -        .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +static const MemoryRegionOps goldfish_rtc_ops[3] = {
> +    [DEVICE_NATIVE_ENDIAN] = {
> +        .read = goldfish_rtc_read,
> +        .write = goldfish_rtc_write,
> +        .endianness = DEVICE_NATIVE_ENDIAN,
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4
> +        }
> +    },
> +    [DEVICE_LITTLE_ENDIAN] = {
> +        .read = goldfish_rtc_read,
> +        .write = goldfish_rtc_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4
> +        }
> +    },
> +    [DEVICE_BIG_ENDIAN] = {
> +        .read = goldfish_rtc_read,
> +        .write = goldfish_rtc_write,
> +        .endianness = DEVICE_BIG_ENDIAN,
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4
> +        }
> +    },
>   };

You don't need 3 copies, only big and little.

> +static Property goldfish_rtc_properties[] = {
> +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
> +                      DEVICE_NATIVE_ENDIAN),
> +    DEFINE_PROP_END_OF_LIST(),
> +};

... and I think the clear desire for default is little-endian.  I would make the property 
be bool, and add a comment that this is only for m68k compatibility, so don't use it in 
new code.


r~
