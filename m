Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECCCCA479
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:01:12 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9D3D623F5F;
	Mon,  4 Jul 2022 12:01:11 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mail.librecores.org (Postfix) with ESMTPS id 37F6820C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:01:10 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id z14so8552613pgh.0
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zGThNGFgy1kDwX4sF6+5bztcWO3GGECBQ+8sGjw3Bik=;
 b=qU9yJtmer1Dbt/693PeBQBkx54B7rSXarOBw+i+5KCB5u2xe79k5qGorHjxCTWYvAY
 HKFTqdLeBarUTnqnWgU8TP11lfyi4je/UO13AFBsfEG9uNxySdDi6/LXDJrFASTOsOaW
 /xmVAQJBAaV4FCi3ei28vxEAL75M4Gan+y7gmnuySGbZAKPa5RiBFbCvBVhRqB+W5Bc6
 sZ9mYXGTzNzirh/fmwHPshZC3dhAJBrDokm6/1DMMP1CdlCdJRO0CqWR60zYF15lDfOW
 m1eQDqhTlN5fLotjGB4ErREBLAAyGisNGxKqyH7nsUY8pQeS9WRixbLqgW02kKOMnZUL
 Urjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zGThNGFgy1kDwX4sF6+5bztcWO3GGECBQ+8sGjw3Bik=;
 b=e/bmF4zvX7y0BFsYpKa/GUAs/bsAd2VHTOUNKSjRefL4soqcozOJoz/iQOeI+Dyulz
 ItwZpIZosTX1tMTtuHIGC4VMUe5HTI2Fdy8KPB6pbyi4LX+10N7s3qUvuzPuAxabpyri
 fVPlfYsuRXiVYwmoWSnnXQEIVu4OFZT1J26UmFrg+TlasktuDn881SVSvmKHd4oGnzWv
 wrKQ7GRIE2Gn9mOIAkkNGOzgEYMG+k9Lesm2Z+055koz2SryjmIw7hxZu5YlPS1QFFRj
 LqDll7/fp3myEVxh0/SpQKtiF9W7VxLWM/RPOgjNzQQOprhGGiyVOOGDGvl9rbNy6bVI
 BUEA==
X-Gm-Message-State: AJIora+5NALUOX6QjeCVAtQ1eiAaran7NW25F7q9ZAmg6G0nVlKFn/Vo
 NEwcZ3GqAuaAibQMRCGzzV3ziNLPuWRctiZJ
X-Google-Smtp-Source: AGRyM1uQSqQ94CeMWecLpbEWase1lqnyHqjprU/+9XOaP8pMbTpW1hXEBLTGGuOPsFxSsHT7mYvOfA==
X-Received: by 2002:aa7:989a:0:b0:525:252f:3c51 with SMTP id
 r26-20020aa7989a000000b00525252f3c51mr35681703pfl.39.1656928868758; 
 Mon, 04 Jul 2022 03:01:08 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a17090301ce00b0016be82cc7b4sm1139633plh.8.2022.07.04.03.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:01:08 -0700 (PDT)
Message-ID: <e47a03fc-745c-5a6e-94d7-c90d4541326a@linaro.org>
Date: Mon, 4 Jul 2022 15:31:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 02/11] target/openrisc: Fix memory reading in debugger
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-3-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-3-shorne@gmail.com>
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
> In commit f0655423ca ("target/openrisc: Reorg tlb lookup") data and
> instruction TLB reads were combined.  This, broke debugger reads where
> we first tried to map using the data tlb then fall back to the
> instruction tlb.
> 
> This patch replicates this logic by first requesting a PAGE_READ
> protection mapping then falling back to PAGE_EXEC.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
