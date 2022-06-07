Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A8C433EF
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 08:11:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id AC4C824917;
	Tue,  7 Jun 2022 10:11:42 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mail.librecores.org (Postfix) with ESMTPS id CF2C8248CD
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 10:11:41 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id c8so12103892qtj.1
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 01:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5TaZXDFKPJPQTETxizne4x3aNQX/zLoDcHqFVDNWpcY=;
 b=PjahtZAlYFyCIphVRZT3aN/aU2zbI5D4ZmQZtd7TF00QX4T9HaqOR7S+7JoylgELbG
 Vke6SJ/OA0yELxKeHWx49SaCiOD/oe7RW6BCehd5dUnrUKG8ecdwOE9ZEpGUT6LFURlw
 EwNaj32I6DeyxQ+FsakFMRW6X8UtDSqCN6uKIwFw0y1I7OuUF+Bf1LGwYroXihrUPD7L
 vBMr+nfFphJS3CbvXhUvYFyCvMLAcNIzi2vrg0HL3fSZSq37kthH/GlL3wA5u1IYrqWS
 ThVz0w42HWgKnRJ+6fwGvDjK0DJTlCHp4uVT9XIQ8VIfcAYkN86dm/1698hqwK3QB3bz
 DTmA==
X-Gm-Message-State: AOAM533Ywpv2trUOpWkJ6bMET/1FMiCCIhVzgpURLufqCpGUQJ0UG0mp
 X4aPFqIyLR4vGZYoIAyoR8ko3UXw8xtDiA==
X-Google-Smtp-Source: ABdhPJx0UlOnjz8q9KJcJZ0cRy4rLvWI5u0m6TB+TD4BB/pb2g1wFMylbpZjxsgNEYZdjXwfg+B/6A==
X-Received: by 2002:a05:622a:13cc:b0:304:ef03:43e3 with SMTP id
 p12-20020a05622a13cc00b00304ef0343e3mr5523809qtk.629.1654589500532; 
 Tue, 07 Jun 2022 01:11:40 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169]) by smtp.gmail.com with ESMTPSA id
 r14-20020a05620a03ce00b006a6d3a6d597sm1591890qkm.71.2022.06.07.01.11.39
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jun 2022 01:11:40 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id l204so29836265ybf.10
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 01:11:39 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr28956365ybb.202.1654589499323; Tue, 07
 Jun 2022 01:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
In-Reply-To: <Ypxb/VDfYLFg3n2s@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Jun 2022 10:11:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
Message-ID: <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
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
 Openrisc <openrisc@lists.librecores.org>, Arnd Bergmann <arnd@arndb.de>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

CC arnd

On Sun, Jun 5, 2022 at 9:32 AM Stafford Horne <shorne@gmail.com> wrote:
> On Sun, Jun 05, 2022 at 10:58:14AM +0900, Stafford Horne wrote:
> > On Fri, Jun 03, 2022 at 09:05:09AM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Jun 2, 2022 at 9:59 PM Stafford Horne <shorne@gmail.com> wrote:
> > > > On Thu, Jun 02, 2022 at 09:08:52PM +0200, Geert Uytterhoeven wrote:
> > > > > On Thu, Jun 2, 2022 at 1:42 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > > > On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > > > > > > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > > > > > > platform allows for a convenient CI platform for toolchain, software
> > > > > > > ports and the OpenRISC linux kernel port.
> > > > > > >
> > > > > > > Much of this has been sourced from the m68k and riscv virt platforms.
> > > > >
> > > > > > I enabled the options:
> > > > > >
> > > > > > CONFIG_RTC_CLASS=y
> > > > > > # CONFIG_RTC_SYSTOHC is not set
> > > > > > # CONFIG_RTC_NVMEM is not set
> > > > > > CONFIG_RTC_DRV_GOLDFISH=y
> > > > > >
> > > > > > But it didn't work. It seems the goldfish rtc model doesn't handle a
> > > > > > big endian guest running on my little endian host.
> > > > > >
> > > > > > Doing this fixes it:
> > > > > >
> > > > > > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > > > > > +    .endianness = DEVICE_HOST_ENDIAN,
> > > > > >
> > > > > > [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> > > > > > [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> > > > > > 2022-06-02T11:16:04 UTC (1654168564)
> > > > > >
> > > > > > But literally no other model in the tree does this, so I suspect it's
> > > > > > not the right fix.
> > > > >
> > > > > Goldfish devices are supposed to be little endian.
> > > > > Unfortunately m68k got this wrong, cfr.
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e2ac4a3327479f7e2744cdd88a5c823f2057bad
> > > > > Please don't duplicate this bad behavior for new architectures
> > > >
> > > > Thanks for the pointer, I just wired in the goldfish RTC because I wanted to
> > > > play with it.  I was not attached to it. I can either remove it our find another
> > > > RTC.
> > >
> > > Sorry for being too unclear: the mistake was not to use the Goldfish
> > > RTC, but to make its register accesses big-endian.
> > > Using Goldfish devices as little-endian devices should be fine.
> >
> > OK, then I would think this patch would be needed on Goldfish.  I tested this
> > out and it seems to work:
>
> Sorry, it seems maybe I mis-understood this again.  In Arnd's mail [1] he, at
> the end, mentions.
>
>     It might be a good idea to revisit the qemu implementation and make
>     sure that the extra byteswap is only inserted on m68k and not on
>     other targets, but hopefully there are no new targets based on goldfish
>     anymore and we don't need to care.
>
> So, it seems that in addition to my patch we would need something in m68k to
> switch it back to 'native' (big) endian?
>
> Looking at the m68k kernel/qemu interface I see:
>
> Pre 5.19:
>    (data) <-- kernel(readl / little) <-- m68k qemu (native / big) - RTC/PIC
>    (data) <-- kernel(__raw_readl / big) <-- m68k qemu (native / big) - TTY
>
> 5.19:
>    (data) <-- kernel(gf_ioread32 / big) <-- m68k qemu (native / big) - all
>
> The new fixes to add gf_ioread32/gf_iowrite32 fix this for goldfish and m68k.
> This wouldn't have been an issue for little-endian platforms where readl/writel
> were originally used.
>
> Why can't m68k switch to little-endian in qemu and the kernel?  The m68k virt
> platform is not that old, 1 year? Are there a lot of users that this would be a big
> problem?
>
> [1] https://lore.kernel.org/lkml/CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com/
>
> -Stafford
>
> > Patch:
> >
> > diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> > index 35e493be31..f1dc5af297 100644
> > --- a/hw/rtc/goldfish_rtc.c
> > +++ b/hw/rtc/goldfish_rtc.c
> > @@ -219,7 +219,7 @@ static int goldfish_rtc_post_load(void *opaque, int
> > version_id)
> >  static const MemoryRegionOps goldfish_rtc_ops = {
> >      .read = goldfish_rtc_read,
> >      .write = goldfish_rtc_write,
> > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> >      .valid = {
> >          .min_access_size = 4,
> >          .max_access_size = 4
> >
> > Boot Log:
> >
> >     io scheduler mq-deadline registered
> >     io scheduler kyber registered
> >     Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >     90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
> >     printk: console [ttyS0] enabled
> >     loop: module loaded
> >     virtio_blk virtio1: [vda] 32768 512-byte logical blocks (16.8 MB/16.0 MiB)
> >     Freeing initrd memory: 1696K
> >    *goldfish_rtc 96005000.rtc: registered as rtc0
> >    *goldfish_rtc 96005000.rtc: setting system clock to 2022-06-05T01:49:57 UTC (1654393797)
> >     NET: Registered PF_PACKET protocol family
> >     random: fast init done
> >
> > -Stafford
