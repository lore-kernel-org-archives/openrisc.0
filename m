Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D6C43334
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 19:09:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 685C0240E1;
	Thu,  2 Jun 2022 21:09:08 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by mail.librecores.org (Postfix) with ESMTPS id 61292248EA
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 21:09:06 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id b11so4191824qvv.4
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 12:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ZmjXLx9Ca/qAgnUddYQ/pRb2D8l9flWG2KTwUVSp3E=;
 b=6zDYEOlpXhXtkHne+XX1DfiDpHPNjnYTH4yjsmOj1iMxwR/WSvoXg2y7eE33qx9XdO
 73iClUJIGBiz9aAs1REkXnUsuTjR9rRZp33lDVX1E7HxTD3ut43SozgRotVFbhKp6dt6
 aeGb66VFECP4Hg3npnUevXP5AGT6Gp1ggtUzlvYeNSNFdWcTSzEqGX21jjf6T5UhJJIg
 JLFO6Xdmwo3H3EGX2uKSk8kC9ld4NvnOhOjV6DSnhazd0QpdqmYHenaamFusMkr3KGOq
 hZqarPqi35eP3zXlvTEidMU86MlRTGzrt2hcVHpvGwLeNgVB1ke66ukUSEHVYNsY4aFm
 Cw1w==
X-Gm-Message-State: AOAM532McItGaEBf5zPBvOmYhcGewqLciph5X/sqDg37oiSIPUTiFnoZ
 2PBaPDD+1VxcYqDQ9HORpRxSl8ejhEmK/A==
X-Google-Smtp-Source: ABdhPJygRYd06l1TkOsqiSzuSFCEmT7rtxEOBxv65TEwPeTmQmVOCtr5eWnj8J7EmD23S+D0zsilRw==
X-Received: by 2002:a05:6214:626:b0:462:43b4:8491 with SMTP id
 a6-20020a056214062600b0046243b48491mr45911884qvx.110.1654196944675; 
 Thu, 02 Jun 2022 12:09:04 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com.
 [209.85.128.181]) by smtp.gmail.com with ESMTPSA id
 a28-20020a05620a103c00b006a5d5d68e02sm3808891qkk.5.2022.06.02.12.09.04
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 12:09:04 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-30c1c9b9b6cso61037267b3.13
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 12:09:04 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr7250879ywa.47.1654196943929; Thu, 02
 Jun 2022 12:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
In-Reply-To: <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Jun 2022 21:08:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
Message-ID: <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
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
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Joel,

On Thu, Jun 2, 2022 at 1:42 PM Joel Stanley <joel@jms.id.au> wrote:
> On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > platform allows for a convenient CI platform for toolchain, software
> > ports and the OpenRISC linux kernel port.
> >
> > Much of this has been sourced from the m68k and riscv virt platforms.

> I enabled the options:
>
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_NVMEM is not set
> CONFIG_RTC_DRV_GOLDFISH=y
>
> But it didn't work. It seems the goldfish rtc model doesn't handle a
> big endian guest running on my little endian host.
>
> Doing this fixes it:
>
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_HOST_ENDIAN,
>
> [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> 2022-06-02T11:16:04 UTC (1654168564)
>
> But literally no other model in the tree does this, so I suspect it's
> not the right fix.

Goldfish devices are supposed to be little endian.
Unfortunately m68k got this wrong, cfr.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e2ac4a3327479f7e2744cdd88a5c823f2057bad
Please don't duplicate this bad behavior for new architectures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
