Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94246C00144
	for <openrisc@archiver.kernel.org>; Tue,  2 Aug 2022 02:03:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 609E7242D7;
	Tue,  2 Aug 2022 04:03:32 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mail.librecores.org (Postfix) with ESMTPS id 9E51B2017F
 for <openrisc@lists.librecores.org>; Tue,  2 Aug 2022 04:03:31 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 15-20020a17090a098f00b001f305b453feso17062162pjo.1
 for <openrisc@lists.librecores.org>; Mon, 01 Aug 2022 19:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S6QeTRZehyEeuAg/fZYmmGDgW/s70yIYqa35AH9HThM=;
 b=LZ/GPEiAxTFF3lZ4yiMhFNn3dWOaAQVRpHLwi8H+4mBoTm0Fq9phnVdfPxw9hdatH8
 0QHrhXusc9QBV7XfuQOtLwxQsh1AlMAE9JB592MU/sFih2GMKBiQKgyc4TNerCkR293u
 HN7wpkkYNBQMNLSQylWy4GcH5134Rlyc5ZPF6fSUImUFZ+ATJI2psN8UVDSKbNWAtdn/
 fk22EOmUYID11oi6YzG8XkZ8bMSykkLY0BmJKo0q1xixLo1SXnJ7koOSkfCA8UQHhkqR
 x9zkwSlO4RRCnEwsVeqHZbcCBTuXmHfr2CUnlXZL2yAu/0MrkiqJzHWbcO2ufDyFTEBs
 6TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S6QeTRZehyEeuAg/fZYmmGDgW/s70yIYqa35AH9HThM=;
 b=3jkTB/9Inoi4vLKeaBXlgudxyOsd3T0Dv5Wk1xK51ioh70I6r/niyXnOfy3KYEE+I1
 nnqQEvWCHkOl2n6a77MSFAl30MO1Imv7lidGICns3KxCVDwTUIIIYA9kD0SddnLEZKT/
 UfQ/H2X1FwXFJlaZl3bOlgNdMEd/6ttg201w2G81n3ccZch8mdPEAiu3XuqiyJ9VMPqD
 oyZkzF5xyhxhnl3lPpaBypU8Ll0/2D7ZCS0JPFLav2cNj70SP5e22o6d0Ujy4TXvzYGn
 J30yslcbsgrjZSQVStMa5HwI0/r52Wbdnv610mKUHrbJYZsKtPko0pDnaqGwdlbgzUyB
 aUrQ==
X-Gm-Message-State: ACgBeo3/e/hM9mbW5LoZ5CyQagnafnQZbHb66QK5P9YK74vnWob8GKJG
 CCSrB2/Wjub/1HqgumluCsA=
X-Google-Smtp-Source: AA6agR4hKXmC9zPng5blHURtDKm6nbt8DtLJgHqx23XODiB/Bcou5E7jPaXn99X48HMQ+5623oiEMg==
X-Received: by 2002:a17:90a:8a8d:b0:1f3:155:3324 with SMTP id
 x13-20020a17090a8a8d00b001f301553324mr21376254pjn.89.1659405809883; 
 Mon, 01 Aug 2022 19:03:29 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a170902e5c200b0016dbb5bbeebsm1931089plf.228.2022.08.01.19.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Aug 2022 19:03:29 -0700 (PDT)
Date: Tue, 2 Aug 2022 11:03:27 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 08/11] target/openrisc: Enable MTTCG
Message-ID: <YuiF7wkIB+pREEy7@antec>
References: <20220729230117.3768312-1-shorne@gmail.com>
 <20220729230117.3768312-9-shorne@gmail.com>
 <a12ba704-b29c-a521-c664-7838c058ebf5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12ba704-b29c-a521-c664-7838c058ebf5@linaro.org>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jul 29, 2022 at 04:42:54PM -0700, Richard Henderson wrote:
> On 7/29/22 16:01, Stafford Horne wrote:
> > This patch enables multithread TCG for OpenRISC.  Since the or1k shared
> > syncrhonized timer can be updated from each vCPU via helpers we use a
> > mutex to synchronize updates.
> > 
> > Signed-off-by: Stafford Horne<shorne@gmail.com>
> > ---
> > Since v2:
> >   - Removed cpu_openrisc_timer_has_advanced lock optimization, measuring revealed
> >     it did not help much.
> > 
> >   configs/targets/or1k-softmmu.mak | 1 +
> >   target/openrisc/cpu.h            | 2 ++
> >   target/openrisc/sys_helper.c     | 7 ++++++-
> >   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thank you,

I guess this whole series is a bit late for 7.1.0 now.

I will post the PR after 7.1.0 is released and target it for 7.2.0.

-Stafford
