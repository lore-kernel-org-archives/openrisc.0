Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C3AC433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:32:14 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 351E021052;
	Mon,  4 Jul 2022 22:32:13 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mail.librecores.org (Postfix) with ESMTPS id CAD5B20C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 22:32:11 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 t5-20020a17090a6a0500b001ef965b262eso295484pjj.5
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DjTU9J6HqhDjpjoeL9b9wbJVoo8URmneKuFBJmASSj0=;
 b=aSDgEmXfKWr3xNRCMCFUc8cVLRjC3fUNNq8l+aBgPn2AMMsKh0moxz9i7Yq7FHcLBw
 mW2+bSbMEYRZ6Ga8FiVA90kPidGIlbqn4vsL38hFPX8xddLk7z9qD8nYYpoypeFdCnTQ
 hUDTPvjdy7IzIZtLtoYm6euWjLFoE5BCN0jZvQI6LouSOCpyIaHpStHKvSGbD0lt1oaB
 4iVepxhBbnNucD0CcjpRHZz4bICgwGFQfsDwCu3Ad9fuB2KWXU752RwRs15gcZSnYQrL
 hPYPnlPE15h98gMaxE7aajy+sjyJPwpg4rIfqk7ZDM7Zot12tUbZrJ63jAavhncoWarh
 aZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DjTU9J6HqhDjpjoeL9b9wbJVoo8URmneKuFBJmASSj0=;
 b=55jH/sddsi4oIB1w4XdS5U6PLSziolKpL1Bzp6pJM6kAbq/+xu7yw/4O44oMf60Gi8
 OcALCJvB1kwgbikMcF45RCiMHrO+ie2t9ZsR2jdQHhjNJ7GmwgsWgtq+W1NYpcB+ZRkq
 LywimNqo+Fkm0fQjYA+jGXykVDnC2INEiD+1bMYTlpYeGqwCkMdcqfUTHB6JK7zGbxrG
 nprd/FYqCE9KxQCpGTS/aYoGi0OfboIrYD7Y99MyIodO2c78gZ2Y0SSpQC36IIzRu3ak
 ZubhtstiamhOOkfRsAoIUUgKL/Q+D6D96fRLexbML+rMfJYIJClMmPk/YlHU18dyxHuW
 6/Ig==
X-Gm-Message-State: AJIora/E8d8JZhgZDdihm1CrKH0Fbsg46fLNUT3q2J4xNM2BdsTWRydN
 7eN10ng7OtoFBVlbxbeQ0Cc=
X-Google-Smtp-Source: AGRyM1tsbevw96MUkj3aiss/yM4T0WVvhMb0qNbx2MH7YgB/Jexlu0DOziE50CwfKSU3iZ/lgUwvMQ==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id
 l15-20020a17090a408f00b001e3023a2370mr37114242pjg.84.1656966730402; 
 Mon, 04 Jul 2022 13:32:10 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a6558cb000000b00408b89e4282sm20835943pgu.47.2022.07.04.13.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 13:32:10 -0700 (PDT)
Date: Tue, 5 Jul 2022 05:32:08 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 06/11] hw/openrisc: Initialize timer time at startupi
Message-ID: <YsNOSHPwAEunATgW@antec>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-7-shorne@gmail.com>
 <60e84190-a60f-0ed0-8755-61d5087fdf9a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e84190-a60f-0ed0-8755-61d5087fdf9a@linaro.org>
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

On Mon, Jul 04, 2022 at 03:33:26PM +0530, Richard Henderson wrote:
> On 7/4/22 02:58, Stafford Horne wrote:
> > The last_clk time was initialized at zero, this means when we calculate
> > the first delta we will calculate 0 vs current time which could cause
> > unnecessary hops.
> > 
> > Initialize last_clk to the qemu clock on initialization.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   hw/openrisc/cputimer.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
> > index 93268815d8..4dbba3a3d4 100644
> > --- a/hw/openrisc/cputimer.c
> > +++ b/hw/openrisc/cputimer.c
> > @@ -140,6 +140,7 @@ void cpu_openrisc_clock_init(OpenRISCCPU *cpu)
> >       if (or1k_timer == NULL) {
> >           or1k_timer = g_new0(OR1KTimerState, 1);
> > +        or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >           vmstate_register(NULL, 0, &vmstate_or1k_timer, or1k_timer);
> >       }
> >   }
> 
> Init doesn't seem right.  Should be in reset?

Good point, I think reset would be better.
