Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115EC433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:26:02 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 851CC24853;
	Mon,  4 Jul 2022 12:26:01 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mail.librecores.org (Postfix) with ESMTPS id AA48220FF5
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:26:00 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 i8-20020a17090a4b8800b001ef8a65bfbdso1586254pjh.1
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=RjydZm+EhzT5qv2NHeJyCOJOQYnCchnfrhWyvuQ49lk=;
 b=CbdJlkE2e/DeFnumG3EftUFXgS/iSWx2XpS/iWPKA6AZaC2Hll3Gxhxb3Ale1fAi0/
 9+ulOAIdzjYcHLD9iyFGI7vXwrWbAgy5aK/VCnr4tBgLvVdvonV552QIvsWEU3mFiP8W
 u+iynU0RKU7HFYjPx+knwwkpMDGRM3+aIuZLHfC1hlBk82ksqkSffR7qoyCpApWBMC+Z
 E4pK/Bs5VkfuEpNt0d0NgOkyXHEc2VdNBNb+ynaKJtE7A+H5VKYTr2LTGhDUsDAAIBqa
 y7fcijZg5ItzwHNzzKwKiYkLr0JADw0aztocqHYMSUaJrZISmYODpsA+KmGPQMOGv2Zx
 66yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RjydZm+EhzT5qv2NHeJyCOJOQYnCchnfrhWyvuQ49lk=;
 b=VSiuRCaGhP6qNbu35xTVaB7QZRAR1eDmXHIP2l8Pw0VAVlMHU6XCrd6b3BbuBj5RO8
 qq2955bAona9iQXxTL/QvfD3c8vux9UjK9RDC1KMho5UFFTovTRtbUhPMBkqv75bPz34
 hRfGDmGCx1aUYmHU5lhWYL2g3yGMleKePbXA68wOxCJmHcnqQ/Lrm/uwAyxUqPOal+zl
 9wCmo3vMZuxbHVCXtx5Kfh50dGtdkGmh71QwuWQFskah8uTcGi31pwAkgUsa9HkoUf1R
 ZUjXYXruw9o28nREkrvz+pMn3JiP9j6qYbHNA6Z4SCJwUeEGpT08FBjHCIufLOWWQWwI
 ccMQ==
X-Gm-Message-State: AJIora91Y5JkyNCD1HbpNf7ABGqlz0K7obd8D9FR43mqc5A5UQPAdmSV
 GKTsVsNB0krcg3fgncskt3D0ug==
X-Google-Smtp-Source: AGRyM1vHlITKiE0ELKBPerd8N/WUvQcpuoA98RAtFUvSJMRRp1ht4meIyoMlxQqAJ+UD4F7/S5ue/Q==
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d4b with SMTP id
 q18-20020a17090311d200b001678a0f8d4bmr35549317plh.78.1656930359288; 
 Mon, 04 Jul 2022 03:25:59 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 i72-20020a62874b000000b0051b9d15fc18sm20668046pfe.156.2022.07.04.03.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:25:58 -0700 (PDT)
Message-ID: <1687d5c8-b1f9-a51e-5280-f8da99500e6b@linaro.org>
Date: Mon, 4 Jul 2022 15:55:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 11/11] docs/system: openrisc: Add OpenRISC documentation
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-12-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-12-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/4/22 02:58, Stafford Horne wrote:
> Signed-off-by: Stafford Horne<shorne@gmail.com>
> ---
>   docs/system/openrisc/cpu-features.rst | 15 ++++++
>   docs/system/openrisc/emulation.rst    | 17 +++++++
>   docs/system/openrisc/or1k-sim.rst     | 43 ++++++++++++++++
>   docs/system/openrisc/virt.rst         | 50 +++++++++++++++++++
>   docs/system/target-openrisc.rst       | 72 +++++++++++++++++++++++++++
>   docs/system/targets.rst               |  1 +
>   6 files changed, 198 insertions(+)
>   create mode 100644 docs/system/openrisc/cpu-features.rst
>   create mode 100644 docs/system/openrisc/emulation.rst
>   create mode 100644 docs/system/openrisc/or1k-sim.rst
>   create mode 100644 docs/system/openrisc/virt.rst
>   create mode 100644 docs/system/target-openrisc.rst

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
