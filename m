Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029AEC7EE29;
	Wed,  3 May 2023 09:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjECJls (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjECJlr (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 05:41:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244AE44A4
        for <linux-openrisc@vger.kernel.org>; Wed,  3 May 2023 02:41:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3062d764455so2339586f8f.3
        for <linux-openrisc@vger.kernel.org>; Wed, 03 May 2023 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683106904; x=1685698904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LD8VPjBC6l2J6jT7ZzyVMmo6WvrSa+0PI6lS90rhdYE=;
        b=mmZLrRZsEhjObtZgFAmX85ub/0rYacAXOVU5pEUxAb5mFxsgljOg8ZmoalAI/y8l9+
         huLuksxLAMOCvDLCDg8QHbPWoZ9nU5biVXAxTkn3VzMvDfaiCexEvt263LC5zC6hcblB
         0Eo/JmunGc0Pt8iQbXG2Gp+/OKvWAC7qF9P/sRTelafA1JuBxzHy8ymjNSRNyjapg0Uw
         3xVqfm0UAyZWOKcXQ0lfsHJvnSUDS7mzEcW/Q2bJRgwuH2g2X6x3qUiAvyN2eZ4Y9VhA
         gnYXdyRAQXfxX+GG/z1yVXkQl31T5YnGm1x0db+nE00P5kFMpFot2NsnxGL4IycTTgbK
         X8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683106904; x=1685698904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD8VPjBC6l2J6jT7ZzyVMmo6WvrSa+0PI6lS90rhdYE=;
        b=RLvBLaXwJWJW6HIPiCgLYjJq0F6GLCqMRCRS2UcJhscp18n0L9LRuVcokJ6m9HkyE/
         rlIcfseCXjgPaN6C67aHfu0cX/rarctYdojTTTdW/6AJu/wi0VmDCBc2ooUqlIGdtC6S
         rBJF1U1CbMpgqbuJ0BRopHGHQWIL/iLRxAKNl8T/HOAMk/mr2phXTwlnkDI3mnDUfS18
         hdGHTuSNcA+OPokEzh2duB1MyUthRis5Hd7oRSQJxfUzdfRBWlFoN/xExGVLsylQm9Bf
         b0h5xfHVCsWgvUDVsRi4MorWvSqS1r7Lj7qWRFp0ilX31TShiuzzWpDRBFQ1XZdG+MWd
         MKkA==
X-Gm-Message-State: AC+VfDxcImRPTFtMqv9v/bP5JBxeTkVtwXJbRe9/Sy2XXqx0rJnZI3Ob
        vKKhA6rk7/3mIrD15atqT6Xh9C4Kk46SAMT4892J1Q==
X-Google-Smtp-Source: ACHHUZ7tydu1EZtUtlbkH1J+u7bN4Cl+E1yysEQ5GyDJYhaZifMQVEhTvWLhYCl3Pzey8Xs/SLl6sQ==
X-Received: by 2002:adf:f686:0:b0:306:370e:6b13 with SMTP id v6-20020adff686000000b00306370e6b13mr2929447wrp.13.1683106904518;
        Wed, 03 May 2023 02:41:44 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:74db:8d00:c01d:9d74:b630:9087? ([2a02:c7c:74db:8d00:c01d:9d74:b630:9087])
        by smtp.gmail.com with ESMTPSA id a6-20020adffac6000000b00306415ac69asm1398319wrs.15.2023.05.03.02.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 02:41:44 -0700 (PDT)
Message-ID: <e3fabb1d-7bf6-f251-9649-5a813b409200@linaro.org>
Date:   Wed, 3 May 2023 10:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] target/openrisc: Setup FPU for detecting tininess
 before rounding
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>
Cc:     QEMU Development <qemu-devel@nongnu.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-4-shorne@gmail.com>
 <933ff5d8-3875-34ac-9bc4-ed06f74efad7@linaro.org> <ZFIl6db3isktCOk8@antec>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZFIl6db3isktCOk8@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 5/3/23 10:14, Stafford Horne wrote:
>>> +    set_default_nan_mode(1, &cpu->env.fp_status);
>>> +    set_float_detect_tininess(float_tininess_before_rounding,
>>> +                              &cpu->env.fp_status);
>>
>> You don't mention the nan change in the commit message.
> 
> Right, and I am not sure I need it.  Let me remove it and run tests again.  I
> was just adding it as a few other architectures did who set
> float_tininess_before_rounding.

What that does is *not* propagate NaN payloads from (some) input to the output.  This is 
certainly true of RISC-V, which specifies this in their architecture manual.  OpenRISC 
does not specify any NaN behaviour at all.

It's not a bad choice, really, and it almost certainly simplifies the design of the FPU, 
as you can do NaN propagation and silencing in one step.


r~
