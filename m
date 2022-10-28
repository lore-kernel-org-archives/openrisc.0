Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66B3C4332F
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:19:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9F3CB20AC2;
	Sun,  6 Nov 2022 22:19:34 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mail.librecores.org (Postfix) with ESMTPS id 67F1324B33
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 16:46:10 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id d13so3545837qko.5
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Eap9vgCOo567XBoaqrJtjJTPOneofbaWXwjzfOt/ko=;
 b=U9faWpM7anfFBwf3lzGgjWdNMgzIZ5MaBAebT8n2v2OUJY1IMy0pME/pjQqGG+QCfK
 7bZUQVJbFh+CxKQQwQ9R5DDx2LWJYCh9bHvuVmZHPmCZPkMxsq4v3oJXCIxrEtU2wyRC
 xULShKwG4KVA/V/y2mm6RzTgzuuWv442t/NvFxc8iUofWRjpiTJmB9Up3DOffi9xJubj
 RR/im5wg2HXy+AthCzdp6tuonbTc2TjHap3B8Gg0F07kxqFgPa43HIxP9DkvUH0elOgY
 5p7rsu2JPPbc+4Yasp+tik93X6+d2C8f2E2ZaK63ox8JmrIPJbDeHqmIGgxLkGGsIsze
 bCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Eap9vgCOo567XBoaqrJtjJTPOneofbaWXwjzfOt/ko=;
 b=1Bz8/4ykva0aQLRKHaEuMqjaXpvjF4HW58V5P+rr2XtFPg1wDPJAUS8vMWhTwMvOfP
 Troii7k7QoM2h7eWend7oXiGqOggkzyAbHQVsSVO7m+lEbJiIeSa9BI+1muTKDIwKVOE
 hxkrgSSORGxS+nBZis8BDEuJPgunGZ2H6PWp97i0bHI6LkpAKl+/ywiTI+wEnPJhVSVD
 u5XrFxqshDn11cT03jQJYkaube4o2CVAvUn9Ihsq/wfc2/ERpK8+xMDSmZnVQzDM59tf
 jEURwr4G3xFM+k3uiaIrm1pbgOhIJmuUSdkFGuR8zVyJ212KbBi0oSSz2ZTvOo8srHZz
 Ok1g==
X-Gm-Message-State: ACrzQf1+aOfBLvW/g/hcWHprKp9YyPLgslL8QGR9+gkumj1bWRmduC4m
 L7yECBwr6wWSUznANi9FoXY=
X-Google-Smtp-Source: AMsMyM57AgHD6SgkTqjWVZle9kdelFZLgih4OaFJ7oUhyOHHF+SxLTt1A5EyJr2xvmD6EBJZRyNRIw==
X-Received: by 2002:ae9:ebce:0:b0:6f9:ff07:7295 with SMTP id
 b197-20020ae9ebce000000b006f9ff077295mr5459491qkg.655.1666968369100; 
 Fri, 28 Oct 2022 07:46:09 -0700 (PDT)
Received: from localhost ([2601:589:4102:5fd2:5b94:d8b:99bf:707a])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a05620a448300b006bbc09af9f5sm3032932qkp.101.2022.10.28.07.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Oct 2022 07:46:08 -0700 (PDT)
Date: Fri, 28 Oct 2022 07:46:08 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y1vrMMtRwb0Lekl0@yury-laptop>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028074828.b66uuqqfbrnjdtab@kamzik>
X-Mailman-Approved-At: Sun, 06 Nov 2022 22:19:32 +0100
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
Cc: Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Oct 28, 2022 at 09:48:28AM +0200, Andrew Jones wrote:
> Hi x86 maintainers,
> 
> I realize 78e5a3399421 has now been reverted, so this fix is no longer
> urgent. I don't believe it's wrong, though, so if it's still of interest,
> then please consider this a friendly ping.
> 
> Thanks,
> drew

Hi Andrew,

I'll take it in bitmap-for-next this weekend.

Thanks,
Yury
