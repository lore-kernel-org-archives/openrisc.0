Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1FC636CC
	for <openrisc@archiver.kernel.org>; Tue, 31 Jan 2023 15:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjAaPfq (ORCPT <rfc822;openrisc@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjAaPfp (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 31 Jan 2023 10:35:45 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A8C1702
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:35:43 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id v17so3736984qto.3
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fddtvfX1Ld1WxJzQuVDgrzhyaUhggAUXQ+BYc/QXvhA=;
        b=AWh5uy6IOZXZllZfB9GZbnnuwMD2xs8YzJdiRit8mG/A/rTOzMhA9847qmhwdRP4x0
         4XSeFRDf7YC2B4AffB0vdimva7zEw9uc94/B8IkzxDsd3wklKK0mSEtedjaFJXSQ4d1J
         TetDH4E24nyNwO6c5HuvNx0GEKMnbkreoCzRfu5+XO8IjpiwqrlCF2WWtYGsk+58W19+
         p9R0+U/aXO5seVmhiUhp0A+/9iYqRZyhtuC/2zBuw6rGmx+jwcNbbK5XvoYx/vVG/P2E
         xYT3rK59RAJ2sReUtOTw/wt8czZWcTPcLriBCa4cE0br3fNR+2p1gdvXbyGZsMnQa1OU
         nMsw==
X-Gm-Message-State: AO0yUKUSw9VH5SQHcXAcBocmtvdf9s5UCgBot07v37H8P5m+yVYbAdon
        V1Ho7xLgo5uc+f0bTBIfy6Z23YtjdvUThg==
X-Google-Smtp-Source: AK7set/s5iRT7t5NUGaRm0j/I/CIZXS3TX9CDbMvzrGtLIDSbe3ldvAhveSJ4Us2590WsbeJikBebA==
X-Received: by 2002:a05:622a:1a9b:b0:3b9:b558:4510 with SMTP id s27-20020a05622a1a9b00b003b9b5584510mr1818259qtc.38.1675179342647;
        Tue, 31 Jan 2023 07:35:42 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id i2-20020ac87642000000b003b6a17e1996sm9967719qtr.83.2023.01.31.07.35.42
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:35:42 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-510476ee20aso101042197b3.3
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:35:42 -0800 (PST)
X-Received: by 2002:a81:1216:0:b0:506:6b5d:523c with SMTP id
 22-20020a811216000000b005066b5d523cmr1892991yws.283.1675179341988; Tue, 31
 Jan 2023 07:35:41 -0800 (PST)
MIME-Version: 1.0
References: <Y9kyjEaTtPQ5sKeH@antec>
In-Reply-To: <Y9kyjEaTtPQ5sKeH@antec>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Jan 2023 16:35:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiV92J538Yq-yFi0b25u2GSEoR6XAW5t=kR2dR3dEXDg@mail.gmail.com>
Message-ID: <CAMuHMdXiV92J538Yq-yFi0b25u2GSEoR6XAW5t=kR2dR3dEXDg@mail.gmail.com>
Subject: Re: OpenRISC mailing list moves from librecores.org to vger.kernel.org
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-riscv@vger.kernel.org

Hi Stafford,

On Tue, Jan 31, 2023 at 4:25 PM Stafford Horne <shorne@gmail.com> wrote:
> After some recent issues in infrastructure the mailing lists at librecores.org
> have been shut down.  This was brought to my attention earlier this week and we
> have migrated all users over to to a new mailing list hosted on the
> vger.kernel.org infrastructure.

Thanks for taking care of this!

> Next steps:
>  - I have requested to get archiving setup on lore.kernel.org

Do you have a good archive of the old mailing list to populate lore,
or do you need help to fill in some gaps?

My local archive goes back to November 25th, 2013.
Oh, it was called linux@lists.openrisc.net those days ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
