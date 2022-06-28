Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0840C433EF
	for <openrisc@archiver.kernel.org>; Tue, 28 Jun 2022 20:45:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6FB09249B0;
	Tue, 28 Jun 2022 22:45:05 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mail.librecores.org (Postfix) with ESMTPS id 0B31024830
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 22:45:03 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id go6so13745100pjb.0
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=klHwOIrGUdoErqjay96x3dFn9GkD+dj20qf/FYcK12c=;
 b=X1i5WzweIaOt4XY1kmRXEbKZUdnuCT+fLaExkoVCRnE3JAsx/bTF0pDmO2QTDtm8Fw
 A5+awOokJJ59Cmj/cp0AOFgthP2Uyl5ZBd90AcTwerYAX+tnuYJZi+5iW2WVqxVUHUKu
 9lYxUaOFtveWIpTFFupPy07e0u15Jhpf+6A22ZzQ3VWy4iTaXdFxbTLLBMOkY7VfEVcl
 uNdwGBa6P0p6k31C9gp0jqSHZ2SsTHspthrB5+WmguUodkpRMeaplWfelsjlypPqdVY5
 UEPfPh3kE6PLyKNtF3hcx75UlE1306/bY+L+2+zCgDFOPp8OvQveDB7cvYRLWGRXD6s7
 +Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=klHwOIrGUdoErqjay96x3dFn9GkD+dj20qf/FYcK12c=;
 b=UaFR/unICmeW9rAHOKJ+4feSglm0jnKFeCkzxk9xcy9ihE18zmP6cAszk71UZBaPRr
 5HfXHlAizhJcQJzQQeO7lDQSooMdzDGkP9PNbEkwpeTwXvKPArC4VtxGLlI+iHhz+AJE
 Yf98oyOS/N+rt60aPnRuRo6DGM4wy0VkAobsttBhs1A2E7lfGOVKdIb52cjMFfm4mBwS
 TFuUpvnt7N89aHWWyq9SYyvBSkcKj5VOkM/fKM09XUDYBfzIXtcnby4lv390TK1/WEw/
 JYELX/dYIVJae+mRQ4pFqZGezkIfm0T33OQYd7dL14MF5iiWQle54gk4ao/JhMxpK6kD
 McpA==
X-Gm-Message-State: AJIora9KEzde1yM+YwEdFS4RK9DUyuEb0+exrHMW8eF/gstE8Dh0oEWF
 QIqiK9oVLJJzLAPiU4FE/6E=
X-Google-Smtp-Source: AGRyM1thlfN+vY8bV/1O836jKS536CGQUOb+TlJKrsUHmr0aLtbqVvyJN8rXzGMMSYz/3jZsbw1VXw==
X-Received: by 2002:a17:902:ac90:b0:16a:1c0d:b586 with SMTP id
 h16-20020a170902ac9000b0016a1c0db586mr6790829plr.155.1656449101406; 
 Tue, 28 Jun 2022 13:45:01 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 8-20020aa79208000000b0050dc76281e0sm5578951pfo.186.2022.06.28.13.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 13:45:01 -0700 (PDT)
Date: Wed, 29 Jun 2022 05:44:59 +0900
From: Stafford Horne <shorne@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] wireguard: selftests: support OpenRISC
Message-ID: <YrtoS7ZUnKUg8Soz@antec>
References: <20220628000210.763674-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628000210.763674-1-Jason@zx2c4.com>
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
Cc: openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Jun 28, 2022 at 02:02:10AM +0200, Jason A. Donenfeld wrote:
> Stafford and I have been using this to shake out OpenRISC bugs, and it's
> been a great help, so it's time OpenRISC support for the WireGuard test
> suite is made into a proper commit. The QEMU changes necessary for this
> to work should also be around the corner now, and they seem some what
> stationary in their interface too.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Hello,

I am not sure what happened to my reply on this yesterday, but I did have this
queued for 5.19 fixes.  However, as we just discussed there are still some soft
lockup issues that cause 'rcu: INFO: rcu_preempt detected stalls' noise.

I will hold off sending this upstream for now.

Example isssues:
 - https://א.cc/x3Vt402T
 - https://xn--4db.cc/bKiNzmFE

-Stafford
