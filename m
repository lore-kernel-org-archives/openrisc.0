Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E1FC433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:07:12 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C059F23F5F;
	Mon,  4 Jul 2022 12:07:11 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mail.librecores.org (Postfix) with ESMTPS id 7693920C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:07:10 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id w24so8878983pjg.5
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=0LLDximVoXso95yqO79Lpec54t/OYLgNimh7zgdksdc=;
 b=NQNyBv5tK3cd7+l6mbR9u7FEtAHZM4ncLL1pm+Ehn256hbBTlyEyIzl+pw1gT8OKKQ
 lylXbrSJgdpUv+cmR1yYSpzA5tV0EvgFutQ8ybH3rierH3TvBDm8GzqY7KsjHN+KViQX
 juqmTVwmR+AeAHSLCqM03FcP9FRZqlFgQouXHIF7jxS+fwjC+rzZGJlhNkQ3nNHC8Diq
 OG5ZjWEwSZrLCg7NSewS3frbyNS7LjyUmMXFCqtLahKgHWrNunKz77YJryYgNZlRlnLC
 J2YmuRqD0tBpO22Sp0FB5X3Hruo75P/OVu8TYP3RqOckqLsJuktZt9GVHEdZETISyLqU
 MDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0LLDximVoXso95yqO79Lpec54t/OYLgNimh7zgdksdc=;
 b=bdIrKQburWBvDGvjkZqvw7wsY5xPKfUt56PGWe0mCG/owpXa8+2s94I3ZnccGvyaek
 6VctSLCOSw+fEsk7o0aA2bjk0W7PYgzK8aNmkcYBb8nBTFcpqAXRogyk0Ph6Mt349mKR
 q/PIKN2whQn5EuXv0sPOPiwshBQE3Ee93OFBuHmx6GrNHU010WXH5rbSndD71+RdGqGa
 n7ImE0CX+O0em30GZsm0FZGImOxbXjAcjOYHgz/XM+77KkOqJ2FW2bXLqikX2aNgM4/7
 STS1a8VSBROJRNTj1OxpSQa4k0aOwLeMDa/oWg2WKoN2qAxdUKQmYgdSVdVOV9Z7Udb9
 pwmw==
X-Gm-Message-State: AJIora9XgNt/FEOXOY1i/dad/m69M//Ugav46IRSyITRKRQUq9Vv3qI+
 gIu0yybKyM7yAjziuVeahjLTCQ==
X-Google-Smtp-Source: AGRyM1sB0m59WyBKOSj/jtWCy7BJuJrJmytp9amAISwUlwbWpcCLc5zvzb6a8x6apWz6lCwgzj8NGQ==
X-Received: by 2002:a17:90b:1bc4:b0:1ed:361b:702c with SMTP id
 oa4-20020a17090b1bc400b001ed361b702cmr33187976pjb.136.1656929229074; 
 Mon, 04 Jul 2022 03:07:09 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a17090a318700b001ef78b9d0d7sm4289880pjb.30.2022.07.04.03.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:07:08 -0700 (PDT)
Message-ID: <13726190-bef1-a987-3158-0f60cac69d1f@linaro.org>
Date: Mon, 4 Jul 2022 15:37:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 08/11] target/openrisc: Enable MTTCG
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-9-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-9-shorne@gmail.com>
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
>       case TO_SPR(10, 1): /* TTCR */
> -        cpu_openrisc_count_update(cpu);
> +        if (cpu_openrisc_timer_has_advanced(cpu)) {
> +            qemu_mutex_lock_iothread();
> +            cpu_openrisc_count_update(cpu);
> +            qemu_mutex_unlock_iothread();
> +        }

Lock around the whole if, I think.  Otherwise looks good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
