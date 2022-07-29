Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47734C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:42:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6B7FC24A89;
	Sat, 30 Jul 2022 01:42:21 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mail.librecores.org (Postfix) with ESMTPS id 6832024A89
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:42:19 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id 206so1611209pgb.0
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xjzot4uwjDESIz5XRcXeTU29yqN0JOKhmJUmpKq7gME=;
 b=a3Of1csiYDobmHvcnpICJhIAZDy76gYB2w2yTe4jqcoy7BePrmFhYPphLEz0VF9iEx
 cQ8Z7pFDICUXbwyzx9URJEZ51qjIxRBb9gKUUW8aH2CzOaUmfInI97KOYDN7gUB8oEVC
 bY4BlJ4OXBQhz3s6TJylN1ECKkGE3X2GYeNNuWaqvc6DaCVxfAzFyd1HUrbzYUicrqA+
 0q8VSk1SkD3ojm+hjs3bE63nAwAr81sPDaYohNeT/cg0pbruB64V4wTfpKthFYMy2dj9
 pRLqfjuwKlcDKuwE9KY4HRFrgn3dfCLksoBAZlHvXsFDAliiV9kbbR5DsyPw6r4P5Olv
 PfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xjzot4uwjDESIz5XRcXeTU29yqN0JOKhmJUmpKq7gME=;
 b=SAVel5qmshb4vyHlqoRQtnxyUH6jSQKtKlDoeIEJmm+hHyFFfG7rScm6uotKhSQIGa
 zeauySSPDuwJ4mD9ClnvpnDeFbw2oYT7pmeur5/neg1OgELGDFWuNq0Th6YiPmB58zlR
 XrTeN2v3e1rF3dCkYw3vcSz1P6OoIiVq0z44VhlPkiMNlN4KS68qVFkK4LTAHVTfDFng
 MeJbn/PI/M6FwbP/V6mF6U0h/cmzSp1Ls04ewFnHsd3UVTtcUOtDEvLHs8ek32ebGrM2
 Pg9w/RUOUEKREkLrI5bHtCnhHy3UvfIpovCmQbFyqEmgknxbyWoYGCvbz9f+npOsX/Sd
 Elvw==
X-Gm-Message-State: AJIora+rajyd7WUs2IkvJSHq2OXF0i65HfTWGjTSLMLeKB6XrbaDLs6R
 cxrSMCw44+4F1oRqH+TBvitr5A==
X-Google-Smtp-Source: AGRyM1sQYcX7Qb40DOYz7uSq3DYnNL2uRTPzEEo3fYSLtFMNoYs7mtW92tVDux+8b3+e5c+f6g0MjA==
X-Received: by 2002:a65:6a0e:0:b0:41b:51b1:5be1 with SMTP id
 m14-20020a656a0e000000b0041b51b15be1mr4768564pgu.574.1659138137819; 
 Fri, 29 Jul 2022 16:42:17 -0700 (PDT)
Received: from ?IPV6:2602:ae:1549:801:a427:660:88d4:8559?
 ([2602:ae:1549:801:a427:660:88d4:8559])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a170902ce8100b0016191b843e2sm4227639plg.235.2022.07.29.16.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jul 2022 16:42:17 -0700 (PDT)
Message-ID: <d52bd8ac-0a83-d965-9373-038e755342a2@linaro.org>
Date: Fri, 29 Jul 2022 16:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/11] hw/openrisc: Initialize timer time at startup
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220729230117.3768312-1-shorne@gmail.com>
 <20220729230117.3768312-7-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220729230117.3768312-7-shorne@gmail.com>
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

On 7/29/22 16:01, Stafford Horne wrote:
> The last_clk time was initialized at zero, this means when we calculate
> the first delta we will calculate 0 vs current time which could cause
> unnecessary hops.
> 
> This patch moves timer initialization to the cpu reset.  There are two
> resets registered here:
> 
>   1. Per cpu timer mask (ttmr) reset.
>   2. Global cpu timer (last_clk and ttcr) reset, attached to the first
>      cpu only.
> 
> Signed-off-by: Stafford Horne<shorne@gmail.com>
> ---
> Since v2:
>   - Moved timer init from init to reset suggested by Richard
> 
>   hw/openrisc/cputimer.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
