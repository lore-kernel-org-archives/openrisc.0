Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E7C7EE22;
	Wed, 10 May 2023 16:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjEJQNi (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 12:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEJQNh (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 12:13:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA57AB9
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 09:13:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3078aa0b152so3303154f8f.3
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683735214; x=1686327214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owoFlcBXqkHmvvDOCRfpFBLy1FHR8tbL+nE+RuqqEXs=;
        b=rJ4XhAIyITkBJfmW61tdGm0H+XzGRCbmao0vNue83rp7fHUcYtONIn0i6VMYmz595d
         mX/GpSesvYSv3N7AQELDoIampzTKeQufofZNwCUba1jeIlQcwq0jtl3aoGnU9mcrGhD4
         OCFrOD9CdrYnP8lZgpCq3tFkzNUQf4IjANVxph3MUbmH+UrdF+bHvWaxMTznXwyZuBrx
         rX4FMY4BuT69S0qZpuGLtxfWO7rsQMwtzYgs2FP/TE4MX8L2qKP0nfndPmERpKb8MVut
         YmmbObG99C3WzBXPvRgVUbyOKBT4gRhtotb0uEOTanvA+U5joE2CIUQLLpVedj5Tr9GD
         oDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735214; x=1686327214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owoFlcBXqkHmvvDOCRfpFBLy1FHR8tbL+nE+RuqqEXs=;
        b=bqMv9MXZnfSsrLO+pFrQLwWweCjNhPvdbpDvOklaig0pBwpE+g2po36w6EKk1XgxJ0
         qrWg4SfvJ/dZmE1TRVgC8xOa8DO2Caw8sBjAWcmy9Ai/FqjSZxT6muoYOWZJTVZCKa4d
         hKNy99fN0jQExVTvsfz9Pz0zRKS4uQgIXVVfrVnZq7aIywjLnTlA4aIA/duqT2MIq2vP
         gd3qjsYRniQ0/8guML/em+NNTvPWzU9Hch/UOdE3Py3yjuy0cfVw09/rzT9+nfYZL5Ty
         9CknEYrQMuTF4fPNelOR2/VE1dn+Fqg+dJdCmhGrNBDwtZb136kymDEzqpkytNbIgA+h
         DL6A==
X-Gm-Message-State: AC+VfDxVZy0QCLkolFIXp+gFPx5++vBnNxqFZ4xgMtRbkHkg6Qs1Zpno
        J2ag3VSyvR4JhfbckZLNww7FiafLFqhAx6lUsEbGKg==
X-Google-Smtp-Source: ACHHUZ7svkWwxUnYEyp3hQGN1v9KKSnqgrDs4RDgl+SspxKvcQBv/xH5WbC3gb+rc7oFw8ZClTaJAw==
X-Received: by 2002:a05:6000:b:b0:306:2fac:377 with SMTP id h11-20020a056000000b00b003062fac0377mr11621807wrx.8.1683735214159;
        Wed, 10 May 2023 09:13:34 -0700 (PDT)
Received: from [192.168.1.177] ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id q18-20020a056000137200b003063176ef09sm17982018wrz.6.2023.05.10.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:13:33 -0700 (PDT)
Message-ID: <02b1e71e-8578-6f4a-5b57-9cfbebff4842@linaro.org>
Date:   Wed, 10 May 2023 17:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] target/openrisc: Set PC to cpu state on FPU
 exception
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>,
        QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230510153228.264954-1-shorne@gmail.com>
 <20230510153228.264954-3-shorne@gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230510153228.264954-3-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On 5/10/23 16:32, Stafford Horne wrote:
> Store the PC to ensure the correct value can be read in the exception
> handler.
> 
> Signed-off-by: Stafford Horne<shorne@gmail.com>
> ---
> Since v1:
>   - Use function do_fpe (similar to do_range) to raise exception.
> 
>   target/openrisc/fpu_helper.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
