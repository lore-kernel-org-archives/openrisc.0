Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCECC433EF
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 15:40:28 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 47776248DB;
	Thu,  2 Jun 2022 17:40:27 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mail.librecores.org (Postfix) with ESMTPS id 7C6D424130
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 17:40:26 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 nn3-20020a17090b38c300b001e0e091cf03so6121809pjb.1
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=6XNMpTK0letqpMMwzZOBcXwTmtfSv9vjOp5ITB1VrzE=;
 b=R1ii5BvznDHkc4QVzfowORoSybcmN4jYSKRRpBBG/bE56NgECoqTGS1gwunjmnuVxC
 AWlMsKvyBFMTQfYSRTnEuUmx1YV0cVvJWjaPi60rTB92dnzxOYoroxW/IeqpEwXr1Yl5
 CzdvOjzhbNB2sjRn43LxCEFLK6PVbOuGKFtJOd1THLh77dZPk8T+tsRiLHzAUzne4/PO
 TjuHxyLReUmkSFxFyYBS8j9cdIGs7kRrDwZSY3sfi1gBABhjOUY6t/YQbwhsGeq/8pvK
 /W2gkG0SG0yeL2sA+jM9sL49KGMb9gixia8DukRBCO+RuNx4DNZtuk4ijrSLPiWI1bsM
 QnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6XNMpTK0letqpMMwzZOBcXwTmtfSv9vjOp5ITB1VrzE=;
 b=hB32UxMkkqestXLcBlvLu0UCLGHOzp37Z32TJNl720QBH+5Q/VPz6jz/UGSUgnwKlb
 d4+j0JYxlqUldygjbGKHr6Wz7bsTyauRvepl4ARrmx6ffTjdQEwdM2OjCYv3pYjEYz56
 iNut5bdiCkVJX9DbSvwvr+OqoGIgXCWc2RQqdEeSWXwosGMl6nNZnkPYpnJop4frMmjE
 H5pcHKiFuH+YjxwxVLJaeCzRtyEXA/BqV6rrJu98YshJv38kZ3R1lbWb04C6kTtcjiai
 bXG0wXxPNnT5+hTbO0vpLBGpwGEvGxUYm+PVsU0vjn1gKvtHI6H+kRlWfnQjvLinHYPf
 iNow==
X-Gm-Message-State: AOAM53345j/61yVOgp1ANU3vcDmjSQHqR25qoY9BSMzClIEuHPqY6d7i
 ipIprmE2ldZZtr4Px1ZJldIW3w==
X-Google-Smtp-Source: ABdhPJycvZkA9FGD8pHm5/48Iei1mdnUBy+IC70oduE9bIfKpC1qTfQSV5GzlahDF6IylP0twLT3Eg==
X-Received: by 2002:a17:902:7c0c:b0:161:ef0f:9da8 with SMTP id
 x12-20020a1709027c0c00b00161ef0f9da8mr5438128pll.147.1654184425067; 
 Thu, 02 Jun 2022 08:40:25 -0700 (PDT)
Received: from ?IPV6:2607:fb90:80cd:3d17:bb90:8dda:8cb2:7569?
 ([2607:fb90:80cd:3d17:bb90:8dda:8cb2:7569])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001641a68f1c7sm3683453plg.273.2022.06.02.08.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 08:40:24 -0700 (PDT)
Message-ID: <82fdb645-bda1-5335-c6ad-168e23fe8ccf@linaro.org>
Date: Thu, 2 Jun 2022 08:40:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 2/3] hw/openrisc: Split re-usable boot time apis out
 to boot.c
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-3-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220527172731.1742837-3-shorne@gmail.com>
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
 Openrisc <openrisc@lists.librecores.org>, Jia Liu <proljc@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 5/27/22 10:27, Stafford Horne wrote:
> These will be shared with the virt platform.
> 
> Signed-off-by: Stafford Horne<shorne@gmail.com>
> ---
>   hw/openrisc/boot.c         | 127 +++++++++++++++++++++++++++++++++++++
>   hw/openrisc/meson.build    |   1 +
>   hw/openrisc/openrisc_sim.c | 106 ++-----------------------------
>   include/hw/openrisc/boot.h |  34 ++++++++++
>   4 files changed, 168 insertions(+), 100 deletions(-)
>   create mode 100644 hw/openrisc/boot.c
>   create mode 100644 include/hw/openrisc/boot.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
