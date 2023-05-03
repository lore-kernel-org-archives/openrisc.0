Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD357C77B75;
	Wed,  3 May 2023 07:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjECHhh (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 03:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECHhg (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 03:37:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292272736
        for <linux-openrisc@vger.kernel.org>; Wed,  3 May 2023 00:37:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3063afa2372so1258481f8f.0
        for <linux-openrisc@vger.kernel.org>; Wed, 03 May 2023 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683099453; x=1685691453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRlW4216UHL7uR8RKL4sYuSk8/TSpELhMvc/f5vAgeU=;
        b=a5islW5/83V/kF9W5Ozv0QpYID5xRDMCaKlbQHcfHYQxWvfoKDWjoFAP/iLNPN1SK7
         rGZDMAwOsVqeukAQVjRkx93/W3mJl5FwabbSQix7V7ox+dWqPptbtAhAPGIQvQzIPd3F
         luE6gRnYmIok4xgr2j9pcknzy6SKriyG2sqDOlPpz13QOK8wcWPWwyD/1gx1IpzjCPTc
         61O7ov4xcCeOFYFSoj+pL7PP3gbO4eg1rMssymC66dEcWlO1rfS8VSnK3bPj1aUmlg6o
         Ic/2Io2LaRHvMMetA7eac9hZJOmOPYy8SKgeelzCFhjI6Y7kMlMArjsZtxX0xKsHSsqx
         UzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099453; x=1685691453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRlW4216UHL7uR8RKL4sYuSk8/TSpELhMvc/f5vAgeU=;
        b=k1E1uTsib1QqSyxHqpzzEVy6dI0LFXDQZbQb8axQqFyEq4/CoI1ylIWX1K3fYnBjQc
         rwPpPPts0Rb0XMKO1O3v18s/vCe8bAb0pGf9KqZ/DzC4XdqCJSsZWB7PUd6JxX20xDgt
         bh1wuLQ/JCeXJv0Umgda16clmReXIvXzCQMQxURg/X7VnykjhkLyweQ+eX3NoGF39dil
         MmiULkOwPhDIk2G693+6XFgnqkH5HkFw2NXdrqt3+LMkFHIUgLcE/gNywBdnFju1B5H3
         dPUOMHwVLoC+6pOwiU0yVJHJZAJfIBHRZFaFoVLu/MwCarotK9BgtzCID7czKSyzvo8H
         A6lA==
X-Gm-Message-State: AC+VfDxLWz1/vb8KcFxfStrJ6JPZWKl5J/CSK65oay7nyovKPkLwWqPX
        H4e25TBcIFesV0kOjqk5usb7gQ==
X-Google-Smtp-Source: ACHHUZ7hyVpfQi2r9tySjbRZYBFtMSE64H3bZdr51zYsddWoo49BVUkzBELasHhMM3oQgPyM6xrKSA==
X-Received: by 2002:adf:fe8d:0:b0:2ff:6906:7169 with SMTP id l13-20020adffe8d000000b002ff69067169mr13100613wrr.68.1683099453565;
        Wed, 03 May 2023 00:37:33 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:74db:8d00:c01d:9d74:b630:9087? ([2a02:c7c:74db:8d00:c01d:9d74:b630:9087])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0030627f58325sm9623830wrx.25.2023.05.03.00.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:37:33 -0700 (PDT)
Message-ID: <933ff5d8-3875-34ac-9bc4-ed06f74efad7@linaro.org>
Date:   Wed, 3 May 2023 08:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] target/openrisc: Setup FPU for detecting tininess
 before rounding
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>,
        QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-4-shorne@gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230502185731.3543420-4-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 5/2/23 19:57, Stafford Horne wrote:
> OpenRISC defines tininess to be detected before rounding.  Setup qemu to
> obey this.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   target/openrisc/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index 0ce4f796fa..cdbff26fb5 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -22,6 +22,7 @@
>   #include "qemu/qemu-print.h"
>   #include "cpu.h"
>   #include "exec/exec-all.h"
> +#include "fpu/softfloat-helpers.h"
>   #include "tcg/tcg.h"
>   
>   static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
> @@ -90,6 +91,10 @@ static void openrisc_cpu_reset_hold(Object *obj)
>       s->exception_index = -1;
>       cpu_set_fpcsr(&cpu->env, 0);
>   
> +    set_default_nan_mode(1, &cpu->env.fp_status);
> +    set_float_detect_tininess(float_tininess_before_rounding,
> +                              &cpu->env.fp_status);

You don't mention the nan change in the commit message.


r~
