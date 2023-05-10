Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D9C77B7C;
	Wed, 10 May 2023 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEJQNJ (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjEJQNI (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 12:13:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA547D80
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 09:13:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so33570065e9.3
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683735185; x=1686327185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htY5EZ6WTIVHCyo4mZ/rIeQxNsCvxiyS24rSgTevj10=;
        b=OdzYjbhZ+r5jsHEnlV8Fel9HibQduvgMcbALQoiNiCWEQeLfvk2ubtojN8m8ZyOfYs
         KOjP4+39yicPnN2lAJUn5ZQM+PLmhtwr5SWLW3SHz6/BKxVsE7gsqSyQA76uPs7Dvg2K
         E9vKsBJqwvKv8pHF73VEYZXgRbJ40eYyDooY1Ko3vADSiXahQPU0qsVdJWKZYcv8+m+u
         mP7PbA46PUm8JM/A+6TjQYB7VtWgeJn/4AEMoe4FRGzUaLtBmVtqFFTaDGyabBQPbFdN
         PBBYGhWZBa0W0MPnltdMcFZk8WCAvD6G3F6p1q8jOu+SgMqcfGYwqlB8Z7J44ZkoTZPn
         UNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735185; x=1686327185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htY5EZ6WTIVHCyo4mZ/rIeQxNsCvxiyS24rSgTevj10=;
        b=UC2hqR+0ABIGkbQJyX++ph5l9DDcNdbuQIDEvMv+1YeRhyVwSHgTnXmt5gxUhriofj
         JyQ+M+OU5H7DrSXFCWwC9Fd1YSXzRTttf22xYZFB0w13/Gzhoy44ANNd1vK95mAhg1Ze
         uBPP9C+Vt2iVWMxXCKs1LL/vbC2p72+X0hL0wauOlrYX9z8hoD3Ge3xdkVLL71R9qxAN
         lFQQ96eSvXi4aZn6XPMqfCImB0jIhm8DGocAK6nPffkMjNBYGtS6T5SozboImxjy5nsT
         8Gx2JhfDmnn1LkrRMbbkapZfQ97K6o0OxMXeHAlLkpuTDOO1hoSJPla5sgv2A77cwQXT
         Zbfw==
X-Gm-Message-State: AC+VfDzmWLWmqdm5y9HN96LV8hRB0mjpKrWDdFZhyAZs0Fi4bgIPOWk3
        uGI+9ZplmHwJGONAM/DH84KKIuPquYT7umEf8p6W3Q==
X-Google-Smtp-Source: ACHHUZ7lCeT6Skxe8WMdnfAAVZLb4yJVogkBPkDtk/3C2Iskj0fesXXCj6I0QvbgKHC4MSY4zyZIhg==
X-Received: by 2002:a05:600c:218:b0:3f4:28fd:83e0 with SMTP id 24-20020a05600c021800b003f428fd83e0mr6082501wmi.31.1683735185676;
        Wed, 10 May 2023 09:13:05 -0700 (PDT)
Received: from [192.168.1.177] ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f423cc11e4sm10651481wmj.16.2023.05.10.09.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:13:05 -0700 (PDT)
Message-ID: <c7e792c1-8229-8b6c-8e6a-1eda14d77c03@linaro.org>
Date:   Wed, 10 May 2023 17:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] target/openrisc: Allow fpcsr access in user mode
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>,
        QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230510153228.264954-1-shorne@gmail.com>
 <20230510153228.264954-2-shorne@gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230510153228.264954-2-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 5/10/23 16:32, Stafford Horne wrote:
>   void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>   {
> -#ifndef CONFIG_USER_ONLY
>       OpenRISCCPU *cpu = env_archcpu(env);
> +#ifndef CONFIG_USER_ONLY
>       CPUState *cs = env_cpu(env);

Pulled cpu out if ifdef here...

> @@ -204,10 +220,22 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>       OpenRISCCPU *cpu = env_archcpu(env);
>       CPUState *cs = env_cpu(env);
>       int idx;
> +#else
> +    OpenRISCCPU *cpu = env_archcpu(env);
>   #endif

But replicated it here.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
