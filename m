Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39AC636CC;
	Sun, 19 Feb 2023 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjBSU7d (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sun, 19 Feb 2023 15:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjBSU7c (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sun, 19 Feb 2023 15:59:32 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F1B1026F
        for <linux-openrisc@vger.kernel.org>; Sun, 19 Feb 2023 12:59:31 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id ol3so1809213qvb.11
        for <linux-openrisc@vger.kernel.org>; Sun, 19 Feb 2023 12:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nv2E16pMcoUxzhoXvgvxvaFPkJHj37DmYSV1MH/HKNk=;
        b=XnobGuXAhhv6SRaNQMAmY2O4kgS27nxEg7ZJdkAVtk1n+Bh0b4cB9tbir7FQ03NL4w
         fNxjgP+5BIha/iUsKo3KFJLDIhMlmH/rFvL82DOARsLz2JiJSaSiWnz2vwQeiAtv2G5O
         puJhEnBRXyQWz4qEgghBgpPSe35/cxKe+/UZv3FGAFCJKr9LEYgsS2VBnbqH59wrvuu7
         krhV/qc8Wr4xAM+1JkBSUQxIUUhvm+4BXIbCgXu2ot2sP6eNgGh4z66sDoMTcwPH4OmR
         0xZmuGTb7fAX4AuvutTNc/xaca6O8Gpx87olK0OeRpvE1xvyfbpcSVI9k2HNRSB2Sg3q
         85BA==
X-Gm-Message-State: AO0yUKXeALNRKmov3oDbBRCaZfHi0BzQvJhKfthpLEgSXpbBHHsurdHF
        kmhs8PBFndT08ndOOffNRpG7KKN0lrXsjg==
X-Google-Smtp-Source: AK7set9Qv5tF7DLv80b2mnQh95t3S7+OaCZJu5C8KEmVf5YiY/lF/UM6j2nUzOllrSLbemESNYvvUQ==
X-Received: by 2002:a05:6214:519b:b0:56e:fdff:29f9 with SMTP id kl27-20020a056214519b00b0056efdff29f9mr1030005qvb.18.1676840369825;
        Sun, 19 Feb 2023 12:59:29 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id a189-20020a37b1c6000000b0073bb4312842sm4736113qkf.128.2023.02.19.12.59.29
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 12:59:29 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id g63so1055832ybg.13
        for <linux-openrisc@vger.kernel.org>; Sun, 19 Feb 2023 12:59:29 -0800 (PST)
X-Received: by 2002:a05:6902:2d0:b0:920:2b79:84b4 with SMTP id
 w16-20020a05690202d000b009202b7984b4mr510370ybh.386.1676840369114; Sun, 19
 Feb 2023 12:59:29 -0800 (PST)
MIME-Version: 1.0
References: <Y9kyjEaTtPQ5sKeH@antec> <CAMuHMdXiV92J538Yq-yFi0b25u2GSEoR6XAW5t=kR2dR3dEXDg@mail.gmail.com>
 <Y9k2zjTd246QCDVO@antec> <CAMuHMdX87=6dt=P-U5Hsu2CBPYCtFyOcoK96GHAvr0JUuVahxg@mail.gmail.com>
In-Reply-To: <CAMuHMdX87=6dt=P-U5Hsu2CBPYCtFyOcoK96GHAvr0JUuVahxg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 19 Feb 2023 21:59:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGJYZcOR-Ld+gitf_ZVtqnh6jzDzM8YHkxcrK4mnQWow@mail.gmail.com>
Message-ID: <CAMuHMdXGJYZcOR-Ld+gitf_ZVtqnh6jzDzM8YHkxcrK4mnQWow@mail.gmail.com>
Subject: Re: OpenRISC mailing list moves from librecores.org to vger.kernel.org
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Hi all,

On Tue, Jan 31, 2023 at 4:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Jan 31, 2023 at 4:42 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Tue, Jan 31, 2023 at 04:35:30PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, Jan 31, 2023 at 4:25 PM Stafford Horne <shorne@gmail.com> wrote:
> > > > After some recent issues in infrastructure the mailing lists at librecores.org
> > > > have been shut down.  This was brought to my attention earlier this week and we
> > > > have migrated all users over to to a new mailing list hosted on the
> > > > vger.kernel.org infrastructure.
> > >
> > > Thanks for taking care of this!
> > >
> > > > Next steps:
> > > >  - I have requested to get archiving setup on lore.kernel.org
> >
> > We do have most/all of the librecores.org history archived to lore already[1].
> >
> > [1] https://lore.kernel.org/openrisc/
>
> Oh, I had missed the old list was already archived...
> Probably you want to have everything merged into a single archive.
>
> > > Do you have a good archive of the old mailing list to populate lore,
> > > or do you need help to fill in some gaps?
> > >
> > > My local archive goes back to November 25th, 2013.
> > > Oh, it was called linux@lists.openrisc.net those days ;-)
> >
> > I don't have that old history and would love to have it up on lore if possible.
> > Let me CC you on my other mail to see what we can do.
>
> OK, I know what to do.  Been there, done that before ;-)
> It may take a while, though...

I have just sent my archives for
  - openrisc.lists.librecores.org (openrisc@lists.librecores.org)
    2016-03..2023-02 (5167 msgids)
  - openrisc.lists.openrisc.net (openrisc@lists.openrisc.net /
openrisc@openrisc.net)
    2013-10..2015-11 (524 msgids)
  - linux.lists.openrisc.net (linux@lists.openrisc.net / linux@openrisc.net)
    2011-05..2018-05 (542 msgids)
  - openrisc.lists.opencores.org (openrisc@lists.opencores.org)
    2013-10..2016-05 (603 msgids)
to Konstantin.

If you you have older archives, or want to fill in the possible gaps,
you can follow the procedure[1] starting from my
openrisc-combined-known-ids.txt.xz[2], and share the new emails with
Konstantin.

[1] https://korg.docs.kernel.org/lore.html#merging-multiple-archives-into-one
[2] https://drive.google.com/file/d/1unHvdCkqJW4lKJPzKM6MOCvTvcKujW-I/view?usp=sharing

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
