Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D5ECCA479
	for <openrisc@archiver.kernel.org>; Tue, 28 Jun 2022 08:31:03 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A1AF524810;
	Tue, 28 Jun 2022 10:31:02 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mail.librecores.org (Postfix) with ESMTPS id CB812240E1
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 10:31:01 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id i64so11342232pfc.8
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2TpQEUwBlGb88p4IGzi7coXlKXR6VM/Rxu7edgxZRdk=;
 b=aDHAR+gThE7DCHiMc4w+Xv3mkdu4rkVcgXPF4v+8X8PUvOGiD8/v36X1k4A6RW/uNs
 Wcs/s0KQGad+czgeUL1BFEdgFXjpzIGT9VHf1J3Btmuqn5TWE1SO9k3Ub1Cuj2wPXdjP
 oiHmgyW3Mo1xkPaGmn+cEOLw9ylL/C2D5qGfZNSwOS4wUGIXKAQsYoRB3mscXSt9hez0
 6DsC1Mnw75dCIc/sU+YFSvQTk+9Ik1HJc+8FpUxpk7njKXZhvdr8dGLt8h34iV3XUKkz
 zAJL1cMHV+FtKiGWoDgKggTNoEugbHIL95tfX/HdtkUF9FBTCUSyWxKu+o8Z230rCi/n
 5IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2TpQEUwBlGb88p4IGzi7coXlKXR6VM/Rxu7edgxZRdk=;
 b=Lqmj3Xg4sEXC+Gy3Fu93rzLiKRmO96QYekX+6yS2cx/LMwFDFZaxZqJHKUcEM9LDLF
 YXZxGE6tllRwBLbXegBYuM/CjDIaLxtXamtKK4F8FJ9R77oHVlC8VA8fiKDG8A3RzmJL
 iV5xlLvePBwXKUuqudI/9UrxGd9mTwR0te2Amt0+xiBIEv5u0VqyAj8A11Ts4l36k1r7
 QynzKTjNJLiO8inuI9/WMfUGegIpTru8OjjiF6JiW8fqLLixAJbRBHO1d3UuDmmK0IYt
 ebYkP5udOkHmTFBDFjyzyRt59pgWEjlA8AU1+JMlK59GX0JeKHDT/Od0v3SPiSY98XBh
 RFtQ==
X-Gm-Message-State: AJIora9pbPNPQxbihD5akP9LG9MWTJa40lq8qB0RAI0L1stmvZM/t13k
 WQ8O2kDEo9AJ3nMmkiDnCnQ=
X-Google-Smtp-Source: AGRyM1t7VQLkR1oO3Z/OyJLVwJsR2RoJKs4ViIJTiEBeq57yqGnKG7zKU0eZOc74hdIrVGHSNEbuIg==
X-Received: by 2002:a05:6a00:1489:b0:525:b83f:b32f with SMTP id
 v9-20020a056a00148900b00525b83fb32fmr3542633pfu.25.1656405059955; 
 Tue, 28 Jun 2022 01:30:59 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a170902e5c900b0016760c06b76sm250708plf.194.2022.06.28.01.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 01:30:59 -0700 (PDT)
Date: Tue, 28 Jun 2022 17:30:57 +0900
From: Stafford Horne <shorne@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip: or1k-pic: Undefine mask_ack for level triggered
 hardware
Message-ID: <Yrq8QaYRfcnRJcKP@antec>
References: <20220628012854.681220-1-shorne@gmail.com>
 <877d512o0a.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d512o0a.wl-maz@kernel.org>
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
Cc: Jonas Bonn <jonas@southpole.se>, Thomas Gleixner <tglx@linutronix.de>,
 Openrisc <openrisc@lists.librecores.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Jun 28, 2022 at 09:25:25AM +0100, Marc Zyngier wrote:
> On Tue, 28 Jun 2022 02:28:54 +0100,
> Stafford Horne <shorne@gmail.com> wrote:
> > 
> > The mask_ack operation clears the interrupt by writing to the PICSR
> > register.  This we don't want for level triggered interrupt because
> > it does not actually clear the interrupt on the source hardware.
> > 
> > This was causing issues in qemu with multi core setups where
> > interrupts would continue to fire even though they had been cleared in
> > PICSR.
> > 
> > Just remove the mask_ack operation.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Note,
> > 
> > I currently have this queued with openrisc fixes for 5.19-rcX.  If this is ok
> > with the IRQ maintainers I would like to have this merged via the OpenRISC
> > queue.
> > 
> >  drivers/irqchip/irq-or1k-pic.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
> > index 49b47e787644..f289ccd95291 100644
> > --- a/drivers/irqchip/irq-or1k-pic.c
> > +++ b/drivers/irqchip/irq-or1k-pic.c
> > @@ -66,7 +66,6 @@ static struct or1k_pic_dev or1k_pic_level = {
> >  		.name = "or1k-PIC-level",
> >  		.irq_unmask = or1k_pic_unmask,
> >  		.irq_mask = or1k_pic_mask,
> > -		.irq_mask_ack = or1k_pic_mask_ack,
> >  	},
> >  	.handle = handle_level_irq,
> >  	.flags = IRQ_LEVEL | IRQ_NOPROBE,
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Feel free to take this via your tree.

Thanks,

-Stafford
