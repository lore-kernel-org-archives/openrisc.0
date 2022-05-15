Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D6DC433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 23:50:08 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D6290248FC;
	Mon, 16 May 2022 01:50:07 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mail.librecores.org (Postfix) with ESMTPS id BA0A924910
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 01:50:05 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id k16so5823499pff.5
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NGFo2ruGeuIS0xCiaiAwaCSdYI+I5oeZTVL+Ez+rSZI=;
 b=UazO7mpf+4YkywLffaZmTGPYLLNhJERO3WTnIMbKOn5P6IVQ9bLkyZkxB9w+ICWhMS
 kGEOc+4GZ7Sk2pQAcDpUMMAiGVeO1BGGXNsSnVOC3pZW9BK8zi/fZHFtzCLgMpv15eZQ
 2mqxJETYnafgn4XRD+vSoK8uxAhPzeooKQPxTkfN/jhaFLcmg4p/000X0QJDqqUrkurK
 0VdPnfdmfAMz4PuRm75/4uEVysM7IJ5D8qv4IhnV7rugfXIbbVVgXkhlevAS7/8wKb7k
 wwUZxbaH60h27R0af3N4A0VNmc0nwwwFsUObx7M6ngjkf/enyMvnVaJPu+JrpM4wPL9s
 Zq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NGFo2ruGeuIS0xCiaiAwaCSdYI+I5oeZTVL+Ez+rSZI=;
 b=yJ3HV/vkbXrM+/b5rW4XU9dnSsEwFuKS42iU5g0miqWn0lgAV5Z5m9IFpcsGRLXWd9
 D/XVm/OgJOy/eQqtpCiY0oXLOGfIIYBsPWqM0BbAuMxHkVW1H8rCXcbL89TD9OKL3Ekr
 bjb/SoZeYQuPMT7w/wfO15LUIV2AsRET2NNxjeCoAwakiLseBEyCySbMfsSpptMwem5B
 VFEA0asJOU8h2HLAGQ0mdYbHoF/djI9DLbCEuuUHGnqOEj9Zjk1ehtYwAS3bVKEj7WfN
 IJp8Sol25kK0NeL4nwXn+7wss1LRs6R6x2aAx/o7NfWrrW1My8VnjSDA7QdCMn50zdxI
 eOdw==
X-Gm-Message-State: AOAM533OepuhJnPPvuOd++UUvMgi2kT0EKaVMUIlqkpvuxxgAwHNihQu
 pn849lfzkFB4VqC/VldhNNQ=
X-Google-Smtp-Source: ABdhPJwEqAe98nmmWD34JvRK7x454hdiPsE/0AYB4cZBhKfxapMzgN39zZpxxMvS6FjkL1pkbLzXXg==
X-Received: by 2002:a63:181c:0:b0:3da:fe5d:90f3 with SMTP id
 y28-20020a63181c000000b003dafe5d90f3mr13139940pgl.350.1652658604223; 
 Sun, 15 May 2022 16:50:04 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 io17-20020a17090312d100b0015f4b7a012bsm5568978plb.251.2022.05.15.16.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 16:50:03 -0700 (PDT)
Date: Mon, 16 May 2022 08:50:02 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 0/4] OpenRISC fixes for QEMU 2022-05-15
Message-ID: <YoGRqvZp/nb0RyZt@antec>
References: <20220515013948.2993495-1-shorne@gmail.com>
 <41d45d1e-8f2e-9201-fca4-f2f9c68af5b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d45d1e-8f2e-9201-fca4-f2f9c68af5b1@linaro.org>
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

On Sun, May 15, 2022 at 04:12:50PM -0700, Richard Henderson wrote:
> On 5/14/22 18:39, Stafford Horne wrote:
> > The following changes since commit 2e3408b3cc7de4e87a9adafc8c19bfce3abec947:
> > 
> >    Merge tag 'misc-pull-request' of gitlab.com:marcandre.lureau/qemu into staging (2022-05-03 09:13:17 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://github.com/stffrdhrn/qemu.git tags/or1k-pull-request-20220515
> > 
> > for you to fetch changes up to e8f0ab0cd674241cbab7231ce05ac1bfa0b4f5ed:
> > 
> >    target/openrisc: Do not reset delay slot flag on early tb exit (2022-05-15 10:33:01 +0900)
> > 
> > ----------------------------------------------------------------
> > OpenRISC Fixes for 7.0
> > 
> >   - A few or1ksim fixes and enhancements
> >   - A fix for OpenRISC tcg backend around delay slot handling
> 
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/7.1 as appropriate.
> 
> The gpg key I have for you is expired.  Have you refreshed the expiration
> date and pushed the new copy somewhere?

Hello Richard,

I updated my PGP key (C3B31C2D5E6627E4) last year or so to extend the expiry
day.  It should be uploaded to pgp.mit.edu, but for some reason that server is
not responding to searches for me right now.

I have also just uploaded it to keyserver.ubuntu.com if that helps.

 - https://keyserver.ubuntu.com/pks/lookup?search=stafford+horne&fingerprint=on&op=index

    sec  rsa4096/C3B31C2D5E6627E4
	 created: 2016-09-14  expires: never       usage: SC

If you still have any issue I can try to work it out.

-Stafford
