Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C2C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:39:56 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2031524A80;
	Sat, 30 Jul 2022 01:39:56 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mail.librecores.org (Postfix) with ESMTPS id E8A8124A89
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:39:53 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id t2so5865013ply.2
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=eJSS3W0KkWa7/lfldHgscIn4YqzTGynq7Iwcq6a1bY4=;
 b=FzBt2c6zOFYmBR4pipFBip0q9zt3pi0PuXqq1BU3m9uv8qahoHSIsAhfKQ969qMv6d
 oj45YLAa0FNpxgofka1qRwnNYiiwLe3hD8YBXNBAaOuPvDbZbw/Gu+vGWPr+StoIyD74
 P8alsFHss1yC+QtRwPL26Vy9dRpl5rc8fr4azMAVJMu65a36zJUcsUyoVvQWhOp6esvh
 37AriQez0x8rNPe80OEstSbXAxm0YdHgNg6WO9/qhUBmosBsyWTh5Elxxg7Be+x+gTE+
 TruNUSiyPrmuM1nlSHxVBfu+FQGkCnSVxKjJYpu6Gk2Iohuzt61jesfvWc2l3FCRui7e
 VmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eJSS3W0KkWa7/lfldHgscIn4YqzTGynq7Iwcq6a1bY4=;
 b=oQf1Bshg+mKjDoYbc0gItEZs5Pd7uXjwYUzZoHitxSkgU05OQK012R2YWTB3r7Tqcg
 mOnzFESfFiB8VC+7ShCUfj5WGecTDmMpIejxOEDWBGtvq57kREevreriz/XN0OQEjwjh
 /t8KlizzE0vcePhXf5U3I5nz2SRrXdXxW3XpwoXptNrdwn/jY6He9jzdxiieDe1rNk/8
 dvKpM6aS8R5MLD2MMfFMH221QhEKBpwJVs8uLKsRsAmmqkzdyJapZIo+7g1QdqX/HBVJ
 w2gYDW+Mqzj/TxAj2O7UU8Zfcp1x0Dt9ndZ1Qc92csaBvpzjwYT+rtKr6rM9twduQ3Bf
 QmEA==
X-Gm-Message-State: ACgBeo1VtZOAqe0HrjbVYDwAAkCNson9WqSdMYbjQl1yomKhElDHpMFq
 ZDAEbCZrm18/QuPsuXwPlbQboA==
X-Google-Smtp-Source: AA6agR5nHalAT+HGu1I0mSvaoNE4cspxztpyF2NWiiDhymhiP8DhbUm4of3nUXJk+K5EyHd/B6kRcw==
X-Received: by 2002:a17:90a:ead3:b0:1f3:366d:5005 with SMTP id
 ev19-20020a17090aead300b001f3366d5005mr5549752pjb.1.1659137992414; 
 Fri, 29 Jul 2022 16:39:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1549:801:a427:660:88d4:8559?
 ([2602:ae:1549:801:a427:660:88d4:8559])
 by smtp.gmail.com with ESMTPSA id
 127-20020a620585000000b0052516db7123sm3448759pff.35.2022.07.29.16.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jul 2022 16:39:51 -0700 (PDT)
Message-ID: <edca0c3d-e7d5-6797-03cb-56fc7d955925@linaro.org>
Date: Fri, 29 Jul 2022 16:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/11] goldfish_rtc: Add big-endian property
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220729230117.3768312-1-shorne@gmail.com>
 <20220729230117.3768312-4-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220729230117.3768312-4-shorne@gmail.com>
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
 Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/29/22 16:01, Stafford Horne wrote:
> Add a new property "big-endian" to allow configuring the RTC as either
> little or big endian, the default is little endian.
> 
> Currently overriding the default to big endian is only used by the m68k
> virt platform.  New platforms should prefer to use little endian and not
> set this.
> 
> Cc: Laurent Vivier<lvivier@redhat.com>
> Reviewed-by: Anup Patel<anup@brainfault.org>
> Signed-off-by: Stafford Horne<shorne@gmail.com>
> ---
> Since v2:
>   - Added Reviewed-by
>   - Changed from enum property to boolean as suggested by Richard

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
