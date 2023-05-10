Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41498C77B7C;
	Wed, 10 May 2023 16:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEJQQ0 (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 12:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjEJQQY (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 12:16:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB007AB2
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 09:16:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so7073327f8f.2
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683735382; x=1686327382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV2LlSTIePrM9T1rLXUyHlRwTx6iL3gqL+UXUshyu58=;
        b=Wxng4XNEtBixXslk6Dx/V9uKx8ldQLIJskHaK+NxyA+NciBp5PUOZJiv3eH2fz6xRf
         s6M8GOOWs6neNIqe8m2qXufLixh++8aQBgttPhMiroClgSW+ZlPBKTM0xllDIUUdvEH1
         AuhNiXq014pq7CmEM/bt117JHNtcNbZrAHYyJFVuJ5KoY77SWRRE2qp0Rg6XERSXuM+K
         wpesll4unqfhzO8gsk98su4LZV+a15V02v74vF9oyLn+M1OgBOuyWkLydPABJZLwANKy
         T1FXxeTwlO3q9ZKqk5+IzLtgGE8R/TG7e7kmkQsJsjaNI5dfWbxdiP4mXQboa92uZ3y0
         bMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735382; x=1686327382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV2LlSTIePrM9T1rLXUyHlRwTx6iL3gqL+UXUshyu58=;
        b=SF6e/j6m5/h9owEGKSE+9CtwO/AWwfRsYH8/GMCy/jbB4px5TX4Et48sscVmg6xwmu
         EYmt/1ugV9Mad9j6V7JW5IgSUgZtnRpy/5c3XlhuVujSML96Iy0NoQfq0V8/u0yeNmO9
         hzHaegB6NGlwRZ/oRjI1PIdgEcoeuJLjIim9uZd5ZjJ4UzDXLkAT9Zi0ko5Bst2KyF5v
         wSoGquZ0K2VSJJfgmWG6abwOrTx0DsLu4y4+TBwFR+unXaOTWdbkB4Br6V9xKtPS+MZm
         /AfHWxw8j0VfwCOh9MJr5A9827wSWhk0ckRJadALC9/f5p8RIYkYDsQumQWjklW01lxV
         bOPg==
X-Gm-Message-State: AC+VfDyu9aP/vNu8LC4XglNHu6eov9zG64IkyFMud75Ejjk6t1vMChz9
        +j/+05mr0YQD5xo2ViwB3USmPA==
X-Google-Smtp-Source: ACHHUZ5aJ7s+WqMmQ3/vsxw7MIlPjDvb/ChIq5O+8QjJiARdyC2W6fXeHbtc9STYIwYlG4cEDMCSeg==
X-Received: by 2002:a05:6000:548:b0:306:4162:ebbe with SMTP id b8-20020a056000054800b003064162ebbemr12976944wrf.49.1683735382284;
        Wed, 10 May 2023 09:16:22 -0700 (PDT)
Received: from [192.168.1.177] ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b003063a92bbf5sm17904907wrv.70.2023.05.10.09.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:16:22 -0700 (PDT)
Message-ID: <390d7ef2-1240-55a3-4b13-ab8796921b7a@linaro.org>
Date:   Wed, 10 May 2023 17:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] target/openrisc: Setup FPU for detecting tininess
 before rounding
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>,
        QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230510153228.264954-1-shorne@gmail.com>
 <20230510153228.264954-4-shorne@gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230510153228.264954-4-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 5/10/23 16:32, Stafford Horne wrote:
> OpenRISC defines tininess to be detected before rounding.  Setup qemu to
> obey this.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v1:
>   - Remove setting default NaN behavior.  I discussed with the FPU developers and
>     they mentioned the OpenRISC hardware should be IEEE compliant when handling
>     and forwarding NaN payloads, and they don't want try change this.

There is no such thing as IEEE compliant for NaN payloads.
All of that is implementation defined.
All OpenRISC needs to do is document its intentions (and then double-check that 
fpu/softfloat-specialize.c.inc does what is documented).


Anyway, back to this patch,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

:-)


r~
