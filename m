Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60CDC77B78;
	Wed,  3 May 2023 07:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjECHg1 (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 03:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjECHgV (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 03:36:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6884237
        for <linux-openrisc@vger.kernel.org>; Wed,  3 May 2023 00:36:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3064099f9b6so320023f8f.1
        for <linux-openrisc@vger.kernel.org>; Wed, 03 May 2023 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683099375; x=1685691375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScsK2kBKzhIRL5m8hbykOcR58W42FCSty2YTazqIrTU=;
        b=mrChas5ZddmR55A+jH+8582PnaTQurBfesp9Ozt0coGE8ZC9/k7bWpqqZOOySNcN7n
         tk9ro4VetivzQtPPGd+uSYCqI1pWBlm5FD1mS8AhTmWWquKJ20uSiuBaYlurls23lywr
         07sqQJ6/5nfmH0e/19gyItJj9yQXDqy3yX07aYW7M4/GRWD5cp9+NFywEdWphIQ2dLUO
         NEi21LmAUtXqwHrwhjPgMrpCGOfsaVcexuOnvFWmYF2cRljy8Ds4SagslJ0RKG795BW9
         UmqqPwDKcLP8lvQmnfgpRT5BwUirspK3Jo73efA9oQ9huY/RDYTh+vvXt+Q+p0kTfBcn
         BHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099375; x=1685691375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScsK2kBKzhIRL5m8hbykOcR58W42FCSty2YTazqIrTU=;
        b=Efu6rygNML2dzNbKyWIweXJBGVE+wMgeBKls/gPSUhMdic/udsjed5ktSUnPreepc0
         8E9lK1Hr71+OuvqY5dnBofPQeeFFHT98uanpbsO9a1EgrVVUS5eZpMn54zZUDlMLFBDT
         T+m/j8SOfU9/52r1u4T/wd/6lRMtntAEMRdv4QQAYO8vgp7qTlKcG5RzuphioX+Ex0+2
         rXnUEpjcTpHZ5HkJkchgWOo3PfumaI9mBiZ4mLsbhtZk/hbDD974QZF9v4BdDo6GC3pz
         5nqf/zI4e+rFuCJ+ldPyQuyXdj+jhk4DKLI4eyTQh5Hsv7xs706h7jJR4nSqECOGNJzV
         O8sg==
X-Gm-Message-State: AC+VfDwdOKIZerktrmZEUGNUN7BskyzUOJuDBy58xcn9jRJPmXakaJRD
        SKtD961+fdtiMKDxEv9qMFAWFTAbWtmyakYlYOMBtQ==
X-Google-Smtp-Source: ACHHUZ5u7GLD6VdqLOghvaGpv9qM0P2SRCh2OBAHVHPe/7UrPPivhZHo/wTY1ZMoqqf+SKZccDIxDA==
X-Received: by 2002:a5d:5186:0:b0:306:2b5f:8d0a with SMTP id k6-20020a5d5186000000b003062b5f8d0amr7225595wrv.56.1683099375547;
        Wed, 03 May 2023 00:36:15 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:74db:8d00:c01d:9d74:b630:9087? ([2a02:c7c:74db:8d00:c01d:9d74:b630:9087])
        by smtp.gmail.com with ESMTPSA id e2-20020a056000120200b00306281cfa59sm9492602wrx.47.2023.05.03.00.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:36:15 -0700 (PDT)
Message-ID: <baea6704-7a22-6934-54f3-76ff4c0fc298@linaro.org>
Date:   Wed, 3 May 2023 08:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] target/openrisc: Set PC to cpu state on FPU exception
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>,
        QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-3-shorne@gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230502185731.3543420-3-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 5/2/23 19:57, Stafford Horne wrote:
> @@ -55,6 +56,9 @@ void HELPER(update_fpcsr)(CPUOpenRISCState *env)
>           if (tmp) {
>               env->fpcsr |= tmp;
>               if (env->fpcsr & FPCSR_FPEE) {
> +                CPUState *cs = env_cpu(env);
> +
> +                cpu_restore_state(cs, GETPC());
>                   helper_exception(env, EXCP_FPE);

Better to mirror do_range().

r~

