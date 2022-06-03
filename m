Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22657C43334
	for <openrisc@archiver.kernel.org>; Fri,  3 Jun 2022 07:05:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C2A46242FA;
	Fri,  3 Jun 2022 09:05:24 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by mail.librecores.org (Postfix) with ESMTPS id 75D85248C7
 for <openrisc@lists.librecores.org>; Fri,  3 Jun 2022 09:05:23 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id el14so5058489qvb.7
 for <openrisc@lists.librecores.org>; Fri, 03 Jun 2022 00:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sQNOc3aOgp6Rqa9AhVwP0GaUA1O2AOCXJw4YAMIOsV0=;
 b=4P4L4Ud40q2jWezBaYsCuEzWXbmbKmlrVl/qDNB5hEHC5vGKjoUCLhowxbJ6/hC1tq
 2/fErHU4m3Zd2tnPrRHpcdYF9xM0cd4hW0bVSILBqAiRoLpvgjX4hunJjhgX8K+uns1R
 4yDLjNdKyolk5/kPB2eUk44Te1vJCFoyOemwrjtXR2KFLGoYFXi1WoJvgcwr+NnxVPRn
 bLJzhMHy6cK87hXHcfUyYWwiTaaolQ3h+yRvyVRTpyKUgjrTe8v5hdmTuHp7ngNi8HZK
 Z5kWLpOUnKMjtpcXn/qCbU6gW5/FRSgwfLVM8e2GjGhfQdCAaWID7TfMWC+Aa2IGmiQo
 +STA==
X-Gm-Message-State: AOAM531ltvjuzmMGNcbUjpOSZIjaDbCnuJ8MklbantCWeUc6tiK8RtCL
 1lzhcJJ+U52xmtYaCucibHKECbfz7wEsig==
X-Google-Smtp-Source: ABdhPJzLnKFky4NC37WNnfgEaR9aSOcAEFYj3FCHnSboyHpr+V3ZLtxpjzCU3Z4KoBXtfXxRr8Pv2w==
X-Received: by 2002:ad4:4ae9:0:b0:467:de78:dfb3 with SMTP id
 cp9-20020ad44ae9000000b00467de78dfb3mr1078269qvb.77.1654239922226; 
 Fri, 03 Jun 2022 00:05:22 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com.
 [209.85.219.175]) by smtp.gmail.com with ESMTPSA id
 v7-20020ac873c7000000b002f93be3ccfdsm149934qtp.18.2022.06.03.00.05.21
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jun 2022 00:05:21 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id r82so12195578ybc.13
 for <openrisc@lists.librecores.org>; Fri, 03 Jun 2022 00:05:21 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr9710397ybu.604.1654239921003; Fri, 03
 Jun 2022 00:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
In-Reply-To: <YpkWllpTFzb2HHY5@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jun 2022 09:05:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
Message-ID: <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Stafford Horne <shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Stafford,

On Thu, Jun 2, 2022 at 9:59 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Jun 02, 2022 at 09:08:52PM +0200, Geert Uytterhoeven wrote:
> > On Thu, Jun 2, 2022 at 1:42 PM Joel Stanley <joel@jms.id.au> wrote:
> > > On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > > > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > > > platform allows for a convenient CI platform for toolchain, software
> > > > ports and the OpenRISC linux kernel port.
> > > >
> > > > Much of this has been sourced from the m68k and riscv virt platforms.
> >
> > > I enabled the options:
> > >
> > > CONFIG_RTC_CLASS=y
> > > # CONFIG_RTC_SYSTOHC is not set
> > > # CONFIG_RTC_NVMEM is not set
> > > CONFIG_RTC_DRV_GOLDFISH=y
> > >
> > > But it didn't work. It seems the goldfish rtc model doesn't handle a
> > > big endian guest running on my little endian host.
> > >
> > > Doing this fixes it:
> > >
> > > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .endianness = DEVICE_HOST_ENDIAN,
> > >
> > > [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> > > [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> > > 2022-06-02T11:16:04 UTC (1654168564)
> > >
> > > But literally no other model in the tree does this, so I suspect it's
> > > not the right fix.
> >
> > Goldfish devices are supposed to be little endian.
> > Unfortunately m68k got this wrong, cfr.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e2ac4a3327479f7e2744cdd88a5c823f2057bad
> > Please don't duplicate this bad behavior for new architectures
>
> Thanks for the pointer, I just wired in the goldfish RTC because I wanted to
> play with it.  I was not attached to it. I can either remove it our find another
> RTC.

Sorry for being too unclear: the mistake was not to use the Goldfish
RTC, but to make its register accesses big-endian.
Using Goldfish devices as little-endian devices should be fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
