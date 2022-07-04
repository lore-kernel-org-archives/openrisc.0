Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08AFC43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:31:28 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D6B1121052;
	Mon,  4 Jul 2022 22:31:27 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mail.librecores.org (Postfix) with ESMTPS id 7642220857
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 22:31:25 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id r6so5450310pfq.6
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I0Vrv35SHNbsdWU5EFENuhNKiLs+3jg18ckVfM4vxw8=;
 b=IEJZ4b0d//BWjIk2az3SAlEl7bZgnyVR02Z3RmVrTRTOX71k8JyP2p7LC/8+8ZmtKf
 fLgBRixs30kSEEXPrGnMkdd6fTouzU9239TsTA/lYgNGJ+KluKO4yvH94zM8zxejhDVu
 tqIddFNxKqW7YNePjgHP59BevOFWq2BQWoDCOoYXRO/Xqhz7HHJ5j6e9Su3QP+PVnAt0
 aIqpq+zQ2FPzzSwExXg3IimpVwCs+6oFxPoKaK5RQFEZg/8Drblp2OiJf714sRNVsXDf
 LqB354jBzOocY/7plRDr+/fpb5VUr6LWdsGRuBsGq+UhIVehZvZNymg4fLgi+ah+2Z4i
 h2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I0Vrv35SHNbsdWU5EFENuhNKiLs+3jg18ckVfM4vxw8=;
 b=LtBbo/cU5mbFYr/5FuJW47r2fmii/kNnrxzO+ieDHbGkhqzaLzAJinVpyU4U5dZBf3
 TtUFVG5Nh3g1GWsjoWsgYUhp/XKyq57Lu4Zj9uBST7OVNgUBoo8hh1LnSz5sjRvbk5X7
 ERe8WF3Q3l6NtgYatUaXUXNJpgM3V5tOszkVRFD6YO6wqDWD1OE3oSTPD20ZoHjNXjJ6
 4xUJphHnaxi4ZYFhD6DMLOYqx5Y+tLhSB1x4zVezTmvQ5xhQ+PzkQEnv5KoMiMj6UhMy
 x29smQqY5zCSWO0dr3TwTYfoZP92X1Kshg8WIVWwQRvPAKHR7h4VCnGOQjbsH0wTMEuj
 gvnA==
X-Gm-Message-State: AJIora+digUVZcwiDPXkbYPHQSbENPQRCwYaUJxLwcgdjw08wIBwSaeG
 GGy3Nj4y4VKTIKH8Kr5iFVI=
X-Google-Smtp-Source: AGRyM1sweiJ0sqC+ddiirnPppX6YP3vh++xZQ6dtCoxdg0wOpL7TGtR6tMs+rKFakbntTjT2Q16Wwg==
X-Received: by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP id
 y8-20020a056a00190800b005255dadcb1cmr38054515pfi.47.1656966683999; 
 Mon, 04 Jul 2022 13:31:23 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 w187-20020a6362c4000000b0040dad0ac789sm18934889pgb.88.2022.07.04.13.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 13:31:23 -0700 (PDT)
Date: Tue, 5 Jul 2022 05:31:21 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 08/11] target/openrisc: Enable MTTCG
Message-ID: <YsNOGeXkHytGEUkW@antec>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-9-shorne@gmail.com>
 <13726190-bef1-a987-3158-0f60cac69d1f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13726190-bef1-a987-3158-0f60cac69d1f@linaro.org>
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

On Mon, Jul 04, 2022 at 03:37:04PM +0530, Richard Henderson wrote:
> On 7/4/22 02:58, Stafford Horne wrote:
> >       case TO_SPR(10, 1): /* TTCR */
> > -        cpu_openrisc_count_update(cpu);
> > +        if (cpu_openrisc_timer_has_advanced(cpu)) {
> > +            qemu_mutex_lock_iothread();
> > +            cpu_openrisc_count_update(cpu);
> > +            qemu_mutex_unlock_iothread();
> > +        }
> 
> Lock around the whole if, I think.  Otherwise looks good.

Well, actually the cpu_openrisc_timer_has_advanced read is done once outside the
lock as an optimization to avoid taking the lock when it is not needed. i.e. if
we have 4 cores that all try to update the clock at the same time in theory only
one will have to take the lock and update the shared timer.

But I do see that could be flawed as after it takes the lock the timer could
have been updated by then.  Ill move it inside and see if there is any
perfromance hit / increase in the sync-profile.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
