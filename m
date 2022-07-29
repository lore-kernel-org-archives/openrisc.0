Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816A9C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:43:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 90D3024A78;
	Sat, 30 Jul 2022 01:42:59 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mail.librecores.org (Postfix) with ESMTPS id E69A324A8C
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:42:57 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 w63-20020a17090a6bc500b001f3160a6011so7857632pjj.5
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=5+JLebkxU3Nt5iFzyBnCsM4hlMEJKB5pGJPQnLyqRg4=;
 b=ff6JQ1jemBmJgIWkDUnBgIiwqyY1/kn2uPgsv+NECG6y65II/7NWPMtvQbr3QvkMA+
 b0jYR28KRCVpZaaSYn3F4g6iSAwr7MM/WJDENpthUak+T+OZBF6GMYAqP1/Wi6DLd+lN
 fz04SF+xH9dlKNBSNVDtJog4kreWduOfaEQ246+jTrFGHYCeDHvCb7x0EGXaptCVeGIj
 SrfoBw4DqNqBCiYNui98GqgghiYyItMlTqEMa36TKUcr6AfhGkF4WpYPTnPZDmyiDska
 JdxiwM7Ya7pfzdGGyEDqa2++D6Wb+6aSjuBd9Kh35Ijw0g0Fk4KjYmF9p3gqFxIWAvId
 TIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5+JLebkxU3Nt5iFzyBnCsM4hlMEJKB5pGJPQnLyqRg4=;
 b=Zasqtpcyh+wdsbeItNQQwQdjlBI7D4MdJya30Hj4a8sn4uDOT8Cv5WkKxb2bMfnDKZ
 A8YWn8tB1AMm04gBYWjF1tXEPZ1gD4eOUWgIQB83LkdswgwNBOhz+j3IC4ExOb6jtP7d
 gRuoArV79GlH9pnxKAhkLBzBZdSIBWzM+IZa6NdQvPpHOb/Ci1YcnRdtYGqBPh1IO4DA
 DBRKSj/7eNW8FO8OcSg1/11EE6LxCTWorrBRNSKFL26095GWZcgsLXuq3EkpovpBq1E8
 Dh7ylNHmEXbpaaEM3QTFdEQG8VtE98TpozeVATbHgOuwi4g6lySNEfYH+fIQKG7b1AKS
 szgA==
X-Gm-Message-State: ACgBeo0O8KmuvtAuNM5JujntlNVUPkeCZquiQrfk/R/vUqScPBP3q8vc
 70+Ykz1TuGgtDcAvj5lLgcAaNQ==
X-Google-Smtp-Source: AA6agR7AnE85m8BfD83SsuBxva1NjH+tm6xRaRJNywf1hS7fbx+qZJtHcfpGcEP2bpWd4dpgbp/GyA==
X-Received: by 2002:a17:902:d501:b0:16d:8fc5:36dc with SMTP id
 b1-20020a170902d50100b0016d8fc536dcmr6201193plg.160.1659138176523; 
 Fri, 29 Jul 2022 16:42:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1549:801:a427:660:88d4:8559?
 ([2602:ae:1549:801:a427:660:88d4:8559])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a17090311cd00b0016892555955sm4268707plh.179.2022.07.29.16.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jul 2022 16:42:55 -0700 (PDT)
Message-ID: <a12ba704-b29c-a521-c664-7838c058ebf5@linaro.org>
Date: Fri, 29 Jul 2022 16:42:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 08/11] target/openrisc: Enable MTTCG
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220729230117.3768312-1-shorne@gmail.com>
 <20220729230117.3768312-9-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220729230117.3768312-9-shorne@gmail.com>
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
> This patch enables multithread TCG for OpenRISC.  Since the or1k shared
> syncrhonized timer can be updated from each vCPU via helpers we use a
> mutex to synchronize updates.
> 
> Signed-off-by: Stafford Horne<shorne@gmail.com>
> ---
> Since v2:
>   - Removed cpu_openrisc_timer_has_advanced lock optimization, measuring revealed
>     it did not help much.
> 
>   configs/targets/or1k-softmmu.mak | 1 +
>   target/openrisc/cpu.h            | 2 ++
>   target/openrisc/sys_helper.c     | 7 ++++++-
>   3 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
