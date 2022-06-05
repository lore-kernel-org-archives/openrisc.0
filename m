Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB94C43334
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 01:58:21 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2CC2E2492F;
	Sun,  5 Jun 2022 03:58:20 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mail.librecores.org (Postfix) with ESMTPS id 9258B248FD
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 03:58:18 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id 187so10058446pfu.9
 for <openrisc@lists.librecores.org>; Sat, 04 Jun 2022 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FH7hgVFGKN1ueArYEdTBjcnxNno+hsrovt2TJHN6hd0=;
 b=G0lqqX2IsH32MAQCUdcPSDhj1/u/MI2nPmeuN5WOj4X/RhGtIgOr2k4Dcl8vih0475
 yuMyc/gbJUi63zCDHG8j3GgsXUlpiYBRUoJjYuBSVA5CHRAgMdb+wdal6P9/7/yvK3d/
 6PKGASjgEiIB+8yC9HGYMwZW8ckPFg2zHPHX9rhwP0xwBqZQcFqCdiihP8oP2OGyfqP5
 xg/0LhS9AAPQrQ5ZF746ejsdUJOUNhCqvvjkKlXvUCr88VGOx/v1FYVEfLYr/a9fTJgw
 dlCTYGxyVL/DLkYLH2mvZD6Vk1mWgyGLYEKj3ks2Y1M284LYsQV5lcWa1CSr7JdbCNWW
 0gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FH7hgVFGKN1ueArYEdTBjcnxNno+hsrovt2TJHN6hd0=;
 b=R4vhVYtjB2ewolodHPXMBnkIAgzRV6VO0VZw8GHmFpouFkckmOJVdnnW9PDKPA9rAR
 jPFnyHFY3VsfOfSq5TYb+0+O9V72moBBb6rm+qri2wjiUaUczyW7KQGR81U4L76nJ9Tu
 SSdFBPUDcfKlGR9zqk1XqO6TgF3xgwz0dKbCOD+Ry2yDQ0aU/sC+8c1tfHLrDCXM4L9k
 pYGjwH/Rt62THMecMsexl4JUmLcszHvDTgn6+wbaLJj8drFdNnoqAqn4A0c8c96GlkdK
 ceO9xbFiCG0EgTnAqaOMApC73n7+O4G5pVZhBQTARzTf/7eEaUuh46obS6v5kePMld4u
 uuPg==
X-Gm-Message-State: AOAM533305DUKs1BDNWBUWeJf3/Dvxyi2yoOe2OEsz8MmxmyUJ3Hbcdh
 SRMbTrerc122N38H+nocfz/nK5LQGQs=
X-Google-Smtp-Source: ABdhPJwCcdMFlABqCFWWAa53DQNUv52jnefGm+EgZEADisGj8Li1ABFaPnaJbAYLu6TJ66DwazXS0g==
X-Received: by 2002:a63:e905:0:b0:3fa:ec8c:9013 with SMTP id
 i5-20020a63e905000000b003faec8c9013mr14923577pgh.599.1654394296856; 
 Sat, 04 Jun 2022 18:58:16 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 q68-20020a632a47000000b003fcc510d789sm6671095pgq.29.2022.06.04.18.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jun 2022 18:58:15 -0700 (PDT)
Date: Sun, 5 Jun 2022 10:58:14 +0900
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <YpwNtowUTxRbh2Uq@antec>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
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

On Fri, Jun 03, 2022 at 09:05:09AM +0200, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Thu, Jun 2, 2022 at 9:59 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Thu, Jun 02, 2022 at 09:08:52PM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Jun 2, 2022 at 1:42 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > > > > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > > > > platform allows for a convenient CI platform for toolchain, software
> > > > > ports and the OpenRISC linux kernel port.
> > > > >
> > > > > Much of this has been sourced from the m68k and riscv virt platforms.
> > >
> > > > I enabled the options:
> > > >
> > > > CONFIG_RTC_CLASS=y
> > > > # CONFIG_RTC_SYSTOHC is not set
> > > > # CONFIG_RTC_NVMEM is not set
> > > > CONFIG_RTC_DRV_GOLDFISH=y
> > > >
> > > > But it didn't work. It seems the goldfish rtc model doesn't handle a
> > > > big endian guest running on my little endian host.
> > > >
> > > > Doing this fixes it:
> > > >
> > > > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > > > +    .endianness = DEVICE_HOST_ENDIAN,
> > > >
> > > > [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> > > > [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> > > > 2022-06-02T11:16:04 UTC (1654168564)
> > > >
> > > > But literally no other model in the tree does this, so I suspect it's
> > > > not the right fix.
> > >
> > > Goldfish devices are supposed to be little endian.
> > > Unfortunately m68k got this wrong, cfr.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e2ac4a3327479f7e2744cdd88a5c823f2057bad
> > > Please don't duplicate this bad behavior for new architectures
> >
> > Thanks for the pointer, I just wired in the goldfish RTC because I wanted to
> > play with it.  I was not attached to it. I can either remove it our find another
> > RTC.
> 
> Sorry for being too unclear: the mistake was not to use the Goldfish
> RTC, but to make its register accesses big-endian.
> Using Goldfish devices as little-endian devices should be fine.

OK, then I would think this patch would be needed on Goldfish.  I tested this
out and it seems to work:

Patch:

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 35e493be31..f1dc5af297 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -219,7 +219,7 @@ static int goldfish_rtc_post_load(void *opaque, int
version_id)
 static const MemoryRegionOps goldfish_rtc_ops = {
     .read = goldfish_rtc_read,
     .write = goldfish_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4

Boot Log:

    io scheduler mq-deadline registered
    io scheduler kyber registered
    Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
    90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
    printk: console [ttyS0] enabled
    loop: module loaded
    virtio_blk virtio1: [vda] 32768 512-byte logical blocks (16.8 MB/16.0 MiB)
    Freeing initrd memory: 1696K
   *goldfish_rtc 96005000.rtc: registered as rtc0
   *goldfish_rtc 96005000.rtc: setting system clock to 2022-06-05T01:49:57 UTC (1654393797)
    NET: Registered PF_PACKET protocol family
    random: fast init done

-Stafford
