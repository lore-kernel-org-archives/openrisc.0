Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16310C433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:03:36 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 12B1620C94;
	Mon,  4 Jul 2022 12:03:35 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mail.librecores.org (Postfix) with ESMTPS id C681C20C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:03:32 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 g16-20020a17090a7d1000b001ea9f820449so13151236pjl.5
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=AX1m8BxtDebrNxtLs9fzgUfdcPXVgb185UY/be8nG2c=;
 b=XhwwDH/J/DgsSqsjLaW27bzLIFowCdUDLnBDx+rdTdfrd/Cg59DEdxaJHCT3CZY/ep
 5vGDTJ0369QCDMlCMirbXit8LatmLYm/0iR/vvMFse80dikkIbfpmQ4rzDdvE8Gp8OO/
 Y7YmHsWR/6R3xD93h4cHKqRC79hNDt/mKdX6wcZpjTGRYzc1kSHWqibnHuq+KvUqCJKw
 PURXF/97vh4hc9Um3El3DrCkRTQYdVX4Rrk8D1cPAh2ikLJ13X6DWfDYHOG9NRFi4wlD
 bTT/LpSMQaxln+EmN/vdj26oW7b6EJ2vAbrXscivT7iMOSpSmQDxWLeyKwfJzEYI+RIJ
 4pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=AX1m8BxtDebrNxtLs9fzgUfdcPXVgb185UY/be8nG2c=;
 b=i22Ja5Ew9phcJzhIzuVwcZLMW7l1+nd7P+BaDPp029/SJKv7rEfhpeaa1zpXDt6wVW
 DjmbuGMTMtuFuHWniD25cv9HXGxjh8q0hu+zU5TM53QLW1o226WVLlP0B9dlC9Nh2L0a
 4tcuEa0CIfJaUgscWgmmFLPgf5VZpaSQoO6rvGdBH5uU7aXNX69MYl/S1oNWZe2Y9qzJ
 /Z71aAm7fnDxOQhWMCBv0NfTdA+ctDfMhj02Pud+v5irWEWN/+PYkq6YnUv3a5EretGp
 QYPMAQAUZZj72IBvSSjg3oOjNDEGWTxEUUYfTPUCzfUslWOS7u22JV8GUHsPW14XHxc9
 RIpw==
X-Gm-Message-State: AJIora/zNiZtITVe5vWqqeW6oD42zPe9FJ2uVU73883Vn/pNjX21KSol
 ubP+By0hLP1VJYs5ClLB5xAZoA==
X-Google-Smtp-Source: AGRyM1vxc8Am+1QtcezUpuVXAwyGp0gbnEqqw65gTgq9vHPLfFPbwvBcZdA0h6PitEHf/z2HvT5WNA==
X-Received: by 2002:a17:902:70cb:b0:16b:c750:fb5a with SMTP id
 l11-20020a17090270cb00b0016bc750fb5amr14406267plt.117.1656929011357; 
 Mon, 04 Jul 2022 03:03:31 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a170902a50b00b001620eb3a2d6sm20631531plq.203.2022.07.04.03.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:03:30 -0700 (PDT)
Message-ID: <60e84190-a60f-0ed0-8755-61d5087fdf9a@linaro.org>
Date: Mon, 4 Jul 2022 15:33:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 06/11] hw/openrisc: Initialize timer time at startup
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-7-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-7-shorne@gmail.com>
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
> The last_clk time was initialized at zero, this means when we calculate
> the first delta we will calculate 0 vs current time which could cause
> unnecessary hops.
> 
> Initialize last_clk to the qemu clock on initialization.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   hw/openrisc/cputimer.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
> index 93268815d8..4dbba3a3d4 100644
> --- a/hw/openrisc/cputimer.c
> +++ b/hw/openrisc/cputimer.c
> @@ -140,6 +140,7 @@ void cpu_openrisc_clock_init(OpenRISCCPU *cpu)
>   
>       if (or1k_timer == NULL) {
>           or1k_timer = g_new0(OR1KTimerState, 1);
> +        or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>           vmstate_register(NULL, 0, &vmstate_or1k_timer, or1k_timer);
>       }
>   }

Init doesn't seem right.  Should be in reset?


r~
