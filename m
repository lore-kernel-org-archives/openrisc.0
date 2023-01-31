Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC7C636CC
	for <openrisc@archiver.kernel.org>; Tue, 31 Jan 2023 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjAaPvn (ORCPT <rfc822;openrisc@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjAaPvk (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 31 Jan 2023 10:51:40 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116514615E
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:51:38 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h24so13684037qta.12
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzA3kavndDgO9oy+nAB/cRpRajU7N1Wi9r3l3zJtBQo=;
        b=Nn4RJCZBhwIFnd2Bj1xM6XpZfVapcoGj8sp+m+4NKZQlCgjl8VGQEd6jqBil9JrrDQ
         /88y1342xN0W2kwIiMXX2Nge6snX6kHimJws1O2zGqNbcLd/cTsh1DWVUP7AKHVFstss
         QCDjiGBTFDsFF1LUAXInhYS8bSOU25BnWDy0juPMB7aGvEKZFmD4IU9sT4ioiPUSJfWB
         oklnlT1rI9UYvTMoKA34y3RnZa9DvLyXQwdzT4tOB+yhgPUTMOAomJT8+suwgWtsDDOb
         Yq92mxlC2n4LXKoMDaFmmD6br12LbwQyDZrpzoSejwD9/SAAeFUA+u0YK8Xgq0oIysZX
         ue7A==
X-Gm-Message-State: AO0yUKVp5863Qyq9blmaSJgyLyVsVSHG9cVs2K8RlDioCv94AkSIlZSM
        IVe8BklrBXlSiqXguCtReq/q0rGQSjVMMg==
X-Google-Smtp-Source: AK7set8+/MeH/CsXknDe2V/6nLcvfG0/ndpMXQJW5BY1ju0ni+/p9qzWJc9AhboQ5sWH45AeUP3t8g==
X-Received: by 2002:ac8:594d:0:b0:3b8:6763:c261 with SMTP id 13-20020ac8594d000000b003b86763c261mr15475054qtz.12.1675180296999;
        Tue, 31 Jan 2023 07:51:36 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id c17-20020ac81111000000b003b7e8c04d2esm9971156qtj.64.2023.01.31.07.51.36
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:51:36 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id x4so18640107ybp.1
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:51:36 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr4813200ybo.380.1675180296456; Tue, 31
 Jan 2023 07:51:36 -0800 (PST)
MIME-Version: 1.0
References: <Y9kyjEaTtPQ5sKeH@antec> <CAMuHMdXiV92J538Yq-yFi0b25u2GSEoR6XAW5t=kR2dR3dEXDg@mail.gmail.com>
 <Y9k2zjTd246QCDVO@antec>
In-Reply-To: <Y9k2zjTd246QCDVO@antec>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Jan 2023 16:51:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX87=6dt=P-U5Hsu2CBPYCtFyOcoK96GHAvr0JUuVahxg@mail.gmail.com>
Message-ID: <CAMuHMdX87=6dt=P-U5Hsu2CBPYCtFyOcoK96GHAvr0JUuVahxg@mail.gmail.com>
Subject: Re: OpenRISC mailing list moves from librecores.org to vger.kernel.org
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-riscv@vger.kernel.org

Hi Stafford,

On Tue, Jan 31, 2023 at 4:42 PM Stafford Horne <shorne@gmail.com> wrote:
> On Tue, Jan 31, 2023 at 04:35:30PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Jan 31, 2023 at 4:25 PM Stafford Horne <shorne@gmail.com> wrote:
> > > After some recent issues in infrastructure the mailing lists at librecores.org
> > > have been shut down.  This was brought to my attention earlier this week and we
> > > have migrated all users over to to a new mailing list hosted on the
> > > vger.kernel.org infrastructure.
> >
> > Thanks for taking care of this!
> >
> > > Next steps:
> > >  - I have requested to get archiving setup on lore.kernel.org
>
> We do have most/all of the librecores.org history archived to lore already[1].
>
> [1] https://lore.kernel.org/openrisc/

Oh, I had missed the old list was already archived...
Probably you want to have everything merged into a single archive.

> > Do you have a good archive of the old mailing list to populate lore,
> > or do you need help to fill in some gaps?
> >
> > My local archive goes back to November 25th, 2013.
> > Oh, it was called linux@lists.openrisc.net those days ;-)
>
> I don't have that old history and would love to have it up on lore if possible.
> Let me CC you on my other mail to see what we can do.

OK, I know what to do.  Been there, done that before ;-)
It may take a while, though...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
