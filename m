Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DE4C43334
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 14:36:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6D33420CC0;
	Sun,  5 Jun 2022 16:36:43 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mail.librecores.org (Postfix) with ESMTPS id 9A9F5247EA
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 16:36:41 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id g186so2104077pgc.1
 for <openrisc@lists.librecores.org>; Sun, 05 Jun 2022 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9YfmyU4P7skjDpkQBG1bmYhw6LZzt95v+mXiawPiugA=;
 b=J7XwWRx5c0MskeD79xML8QF+nXwda7BrZ9Tnd/38ey4ZwVAOhQQEhgAYuQjAbVH8+m
 f/mNnv0TK54JnfZO9/ofDQJP+GAfqOtN8pd4LWMT/Fl0mu7VVy6fgPdO4SZ18cVWpp6B
 SCfXBM7al1a8L6DbcctXsgmQNjQ8iIN9Fwamk35WDvLV68siA1gkGzQPXfKhLb3kYXyP
 PqjH/CTG7TV5/6LWR9PMc3LVDe4rdKkS+YYgguj4opEZoqMsYXkfbAzaQ4kJP75T0hFP
 ti76+cJRuJO4yOV/GK8s6rmASvPuSWsgr3tC1VaPqFap0a6OYeyrDUnDydMcUd45Qp6U
 xAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9YfmyU4P7skjDpkQBG1bmYhw6LZzt95v+mXiawPiugA=;
 b=P4hMPjKLI3kzxzaMu6LIO+KDfpVh3iOmZF37WAqM0rwAx7GQt5Jo0sWuI4X0IRqZC9
 R7/zotLjcpPKQPsV9RgoGDv+q3HfPIOUjZTa5tZAHfygzO0bxpCnpzpr+0sprDt97ofY
 KkVr29reZ0Fysv+sOl0VolYeN6EueqSKls8CGzL52ocZJDT2n/2V2ZxTI9RazynfArPd
 MfsKyLpsynPMY37iK6Uis4KIVfth+7I+qJmj67njG/TjwyqXcSAGYwfIR2fW77Tx4tZV
 l4r4ExQlFOwu/P4nmeROcHochomXRUb5cdSi517G2b9fcmwjkcacQMU42Km9ivkDo5nV
 scfA==
X-Gm-Message-State: AOAM5309fcQvvvhxN2FEgOO2AE0VhmzS5YszhKx0mH5PJlJIUO7jxTy6
 rUQ4ThGc0lJfJ4o20o/G9IOKjg==
X-Google-Smtp-Source: ABdhPJylo+3fzR7JM/UFfjcZ+yqmV2KJzvj1JerzyrgBTZTKsmyxj4ZkfewzBIMo3/rb3B7vy1a2PA==
X-Received: by 2002:a63:131b:0:b0:3fc:c051:5a04 with SMTP id
 i27-20020a63131b000000b003fcc0515a04mr17154238pgl.568.1654439800132; 
 Sun, 05 Jun 2022 07:36:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1547:e101:7b92:21dc:74b5:76dd?
 ([2602:ae:1547:e101:7b92:21dc:74b5:76dd])
 by smtp.gmail.com with ESMTPSA id
 g196-20020a6252cd000000b0051b9e224623sm9343173pfb.141.2022.06.05.07.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jun 2022 07:36:39 -0700 (PDT)
Message-ID: <ac25d80d-d8e6-9120-1609-395d666f0af8@linaro.org>
Date: Sun, 5 Jun 2022 07:36:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/3] target/openrisc: Add basic support for semihosting
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-2-shorne@gmail.com>
 <0a1051aa-f2f5-02de-693c-2c8b5e002998@linaro.org> <Ypv/cBqa5CUeXoaj@antec>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Ypv/cBqa5CUeXoaj@antec>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 6/4/22 17:57, Stafford Horne wrote:
> I am kind of leaning towards dropping the semi-hosting patches and only moving
> forward with the virt patches.  The reason being that 1. we would not need to
> expand the architecture spec to support the qemu virt platform, and we would
> need to document the NOP's formally, and 2. OpenRISC doesn't really support the
> full "semihosting" facilities for file open/close/write etc.

I agree that "virt" would to more for openrisc devel than these nops.

> Also, if we have virt I can't imagine anyone using the semihosting much.

IMO, semihosting is most valuable for writing regression tests and not much more.  (You 
have no control over the exit status of qemu with normal shutdown, as compared with 
semihosting exit.)


r~
