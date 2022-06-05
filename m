Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63445C43334
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 07:32:21 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D5B9C2017F;
	Sun,  5 Jun 2022 09:32:19 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mail.librecores.org (Postfix) with ESMTPS id 601962017F
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 09:32:17 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 d12-20020a17090abf8c00b001e2eb431ce4so10261431pjs.1
 for <openrisc@lists.librecores.org>; Sun, 05 Jun 2022 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dtcwJt3hwNtes5OTnKGrNdQuyoqAMe1EVZ+I3mFSpVU=;
 b=FuuHhbcZhPEqWHyZtXk6Tp8BQmbyg92qIgm8mTsjR9Z8aBzPk3odhCmrYKoAal8C5a
 cD/LslQVD25Qg5scfckyzpI/Vmc9kYfVWWiSStmOHx77F85zs0n45b2MwItbqh/5NDoo
 GREViDNC9yahJdd+3P8kShYXbjD+kNUjI+x/LnszLIlRgdqPRCfiOjyv6KvBXv5srRe0
 KE+t9g/E5IZcSYsKAInDHTLdX5f5X/bkf3hX8fyNr+k8XmWx4JyPv9tqX1ylLOaaCREb
 uVApmYZ41sCUAahikrtUEPsgi2URJxcJKPlWqnNAdIAXnAG7ifT5p7X1llz0FqO/TRmE
 gZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dtcwJt3hwNtes5OTnKGrNdQuyoqAMe1EVZ+I3mFSpVU=;
 b=5H4IP73CtXTpSSDwddOZskArtKIzTkOYfHP8+/ZdPvM2cZStNywLel74ernVlDVMno
 6JTh8MrQYYjV1ZXmrRIr7LOforqyCDkeseXFltuoh4p2u45ipWrMvdWFHCTWvCZ1PgnY
 LSzzXHnuxnbCFgxqZiX+LsNA2XIze0ixL5hCsvepOog3s1wJF96Gpf/EBj/zWyn7oN2l
 8gX1OVhG3C4Soloen3Wn5UBe0HQbzSG/O0k8+y//Rn4cuS2+nnUBLTQKLlGl+9Ikv8rk
 YOOS2cYVClVaPn/uSqSeKgCDcyCKNvHH/hY7qxm2Go6ofu1BcBgOFKDKaZ6gCGTxmb/Z
 xuiA==
X-Gm-Message-State: AOAM531HnudZpQVAfETFYU+q+PTeFlZ8jG6fwudwb+rsv0GA+/DrXied
 vgeDzpySDlUBdU1Qk4JiWqo=
X-Google-Smtp-Source: ABdhPJyKyEYp7OHLScxNfZtt1ref9DRAwEh+W1F0nsfflhgy7i6W0Fgaw/tYqFbS/BiZZM8OUpXz3w==
X-Received: by 2002:a17:903:1c2:b0:163:ef7b:e10f with SMTP id
 e2-20020a17090301c200b00163ef7be10fmr18158661plh.158.1654414335537; 
 Sun, 05 Jun 2022 00:32:15 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 68-20020a621947000000b00519303c55acsm8395997pfz.1.2022.06.05.00.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jun 2022 00:32:14 -0700 (PDT)
Date: Sun, 5 Jun 2022 16:32:13 +0900
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <Ypxb/VDfYLFg3n2s@antec>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpwNtowUTxRbh2Uq@antec>
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

On Sun, Jun 05, 2022 at 10:58:14AM +0900, Stafford Horne wrote:
> On Fri, Jun 03, 2022 at 09:05:09AM +0200, Geert Uytterhoeven wrote:
> > Hi Stafford,
> > 
> > On Thu, Jun 2, 2022 at 9:59 PM Stafford Horne <shorne@gmail.com> wrote:
> > > On Thu, Jun 02, 2022 at 09:08:52PM +0200, Geert Uytterhoeven wrote:
> > > > On Thu, Jun 2, 2022 at 1:42 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > > On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > > > > > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > > > > > platform allows for a convenient CI platform for toolchain, software
> > > > > > ports and the OpenRISC linux kernel port.
> > > > > >
> > > > > > Much of this has been sourced from the m68k and riscv virt platforms.
> > > >
> > > > > I enabled the options:
> > > > >
> > > > > CONFIG_RTC_CLASS=y
> > > > > # CONFIG_RTC_SYSTOHC is not set
> > > > > # CONFIG_RTC_NVMEM is not set
> > > > > CONFIG_RTC_DRV_GOLDFISH=y
> > > > >
> > > > > But it didn't work. It seems the goldfish rtc model doesn't handle a
> > > > > big endian guest running on my little endian host.
> > > > >
> > > > > Doing this fixes it:
> > > > >
> > > > > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > > > > +    .endianness = DEVICE_HOST_ENDIAN,
> > > > >
> > > > > [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> > > > > [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> > > > > 2022-06-02T11:16:04 UTC (1654168564)
> > > > >
> > > > > But literally no other model in the tree does this, so I suspect it's
> > > > > not the right fix.
> > > >
> > > > Goldfish devices are supposed to be little endian.
> > > > Unfortunately m68k got this wrong, cfr.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e2ac4a3327479f7e2744cdd88a5c823f2057bad
> > > > Please don't duplicate this bad behavior for new architectures
> > >
> > > Thanks for the pointer, I just wired in the goldfish RTC because I wanted to
> > > play with it.  I was not attached to it. I can either remove it our find another
> > > RTC.
> > 
> > Sorry for being too unclear: the mistake was not to use the Goldfish
> > RTC, but to make its register accesses big-endian.
> > Using Goldfish devices as little-endian devices should be fine.
> 
> OK, then I would think this patch would be needed on Goldfish.  I tested this
> out and it seems to work:

Sorry, it seems maybe I mis-understood this again.  In Arnd's mail [1] he, at
the end, mentions.

    It might be a good idea to revisit the qemu implementation and make
    sure that the extra byteswap is only inserted on m68k and not on
    other targets, but hopefully there are no new targets based on goldfish
    anymore and we don't need to care.

So, it seems that in addition to my patch we would need something in m68k to
switch it back to 'native' (big) endian?

Looking at the m68k kernel/qemu interface I see:

Pre 5.19:
   (data) <-- kernel(readl / little) <-- m68k qemu (native / big) - RTC/PIC
   (data) <-- kernel(__raw_readl / big) <-- m68k qemu (native / big) - TTY

5.19:
   (data) <-- kernel(gf_ioread32 / big) <-- m68k qemu (native / big) - all

The new fixes to add gf_ioread32/gf_iowrite32 fix this for goldfish and m68k.
This wouldn't have been an issue for little-endian platforms where readl/writel
were originally used.

Why can't m68k switch to little-endian in qemu and the kernel?  The m68k virt
platform is not that old, 1 year? Are there a lot of users that this would be a big
problem?

[1] https://lore.kernel.org/lkml/CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com/

-Stafford

> Patch:
> 
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 35e493be31..f1dc5af297 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -219,7 +219,7 @@ static int goldfish_rtc_post_load(void *opaque, int
> version_id)
>  static const MemoryRegionOps goldfish_rtc_ops = {
>      .read = goldfish_rtc_read,
>      .write = goldfish_rtc_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4
> 
> Boot Log:
> 
>     io scheduler mq-deadline registered
>     io scheduler kyber registered
>     Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>     90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
>     printk: console [ttyS0] enabled
>     loop: module loaded
>     virtio_blk virtio1: [vda] 32768 512-byte logical blocks (16.8 MB/16.0 MiB)
>     Freeing initrd memory: 1696K
>    *goldfish_rtc 96005000.rtc: registered as rtc0
>    *goldfish_rtc 96005000.rtc: setting system clock to 2022-06-05T01:49:57 UTC (1654393797)
>     NET: Registered PF_PACKET protocol family
>     random: fast init done
> 
> -Stafford
