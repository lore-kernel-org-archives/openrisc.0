Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B3C38A02
	for <openrisc@archiver.kernel.org>; Mon, 31 Oct 2022 08:06:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 838B5214F6;
	Mon, 31 Oct 2022 09:06:08 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by mail.librecores.org (Postfix) with ESMTPS id 5D5A924BE7
 for <openrisc@lists.librecores.org>; Mon, 31 Oct 2022 09:06:06 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id 13so27431834ejn.3
 for <openrisc@lists.librecores.org>; Mon, 31 Oct 2022 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=poxA0LEev9jPrhZnkwyY7vsWe/HDoG5TgR6taboptUU=;
 b=LYy0CICIyprTOFQXJbmxldQgszdggru36ppt8BlYlS/6Fadz4lG7+PvpBInXK3sEwl
 9c19coxXN6zfPF621QDiLFySz9+w3De89yPYhIqd1pl1g1LL2OTgeS0IT7F60LNAXCBj
 TF4jCAkyzHckAHw+4NbUXCJlkXC8jqinNwGBAo650tUVkm4qOCdpQOyA6+CxyIo6oVJI
 KHTpD5kEOyKveHPx/t7FAd8yS3EE8MPg+seA2KF22Fmhl2l8FspTrr8RgWX++cf2eZMF
 xm3SjqbAjsK1sVWszFcL2x0alWobxfqRnsQgl+JbUXYc2ZUSVa7+sfBfsb+bIQSHYlqq
 KjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poxA0LEev9jPrhZnkwyY7vsWe/HDoG5TgR6taboptUU=;
 b=dgKokV4MLvENfgEvE8AZkA48oF4fQb49+PSIQME+Tm0F3FTNrd6pyvCalxbI0Jyj5O
 /EOK+LFpuALRyGndY1Wxe9KLLszi3pBO6X0RZ21M4li4AfYZ5sLwOGJc6kYlXs5mkh+Y
 3XfHKIwtBnh5c0NAlrSxVWaF0zH471UodjXp5Qsngbpv7kAVZ7VqT1ObAZD9CtXCB7uX
 oAZJqARZDLnS/VSHDk9QMyAZPn79ORrm3vTN7+Ht8BJUpJyox6YKZLlxHisSPdMZBvVD
 DEhdpQg/5lch064Qago8PJEVkTyXJ4y/5DM+mRNtdlN1Nng9fULMiapeugT0zaQQDsrf
 sV5A==
X-Gm-Message-State: ACrzQf1YrQW5bhSEJN1MY0zlD2+LyvGCshuPyJsEdutLpe7Xd+B9hQMS
 434HRhjTLtQt1euY8ZXKv3kGrA==
X-Google-Smtp-Source: AMsMyM5muTvUIOECduCaxj0EnA1GyAIhvxzQvG2kLFyGrfnTCKJuYOT5siPGSm+xWiTGjY/PqNGVtg==
X-Received: by 2002:a17:907:80b:b0:77a:86a1:db52 with SMTP id
 wv11-20020a170907080b00b0077a86a1db52mr11721653ejb.294.1667203565981; 
 Mon, 31 Oct 2022 01:06:05 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 kz4-20020a17090777c400b0077b523d309asm2663665ejc.185.2022.10.31.01.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 01:06:05 -0700 (PDT)
Date: Mon, 31 Oct 2022 09:06:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221031080604.6xei6c4e3ckhsvmy@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop> <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1v+Ed6mRN9gisJS@zn.tnic>
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
 Yury Norov <yury.norov@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 openrisc@lists.librecores.org, Ingo Molnar <mingo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Oct 28, 2022 at 06:06:41PM +0200, Borislav Petkov wrote:
> On Fri, Oct 28, 2022 at 10:13:28AM -0500, Yury Norov wrote:
> > Because it's related to bitmap API usage and has been revealed after
> > some work in bitmaps.
> 
> So first of all, that "fix" needs to explain what exactly it is fixing.
> Not "it fixes this and that warning" but why the input arg to
> cpumask_next() cannot be nr_cpu_ids because... yadda yadda...

Hi Boris,

I didn't realize you were still looking for improvements to the commit
message for this patch. I could add something like,

 The valid cpumask range is [0, nr_cpu_ids) and cpumask_next() always
 returns a CPU ID greater than its input, which results in its input
 range being [-1, nr_cpu_ids - 1). Ensure showing CPU info avoids
 triggering error conditions in cpumask_next() by stopping its loop
 over CPUs when its input would be invalid.

Thanks,
drew

> 
> > And because nobody else cares.
> 
> Why do you assume that?
> 
> > If you're willing to move it yourself please go ahead.
> 
> If it fixes a real issue, we are taking it. And pls note that x86
> patches go through the tip tree.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
