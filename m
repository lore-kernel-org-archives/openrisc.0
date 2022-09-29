Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2753EC433FE
	for <openrisc@archiver.kernel.org>; Thu, 29 Sep 2022 16:27:11 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D01F92491F;
	Thu, 29 Sep 2022 18:27:10 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mail.librecores.org (Postfix) with ESMTPS id E43172491E
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 18:27:09 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 u16-20020a05600c211000b003b5152ebf09so3538273wml.5
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=icV6cxvXLdy/u1P61WPyBZFENlozm8iS3OoyNfd2f5Q=;
 b=Lqili1lHrpn0yuYSaYBPZxkVMnlBUFLeI2TVXfPPNP8+mAlJOLfQ5y6B2JArvg6zAf
 BrBgP5YflGzmsZ4Im+u5YXxPC5njXfyUnYblj/z7eRcveVKot+tjr4IWqGEFmb3mjKIi
 PbQtxa6iPVUlYXtZkzWlKUyUUYWDHgTQ5hrMagrEAgYsnjDRoiSct9ajfXr1wnbdHgwN
 sSs9cF+Xxv6widRyjBMBlHGUk0QhbE3uGr1UKQEW+KVZNOlImKX28x82tubE1YAFLrd1
 vduscc6FbrQZ1q1El5KSptqIGMhAj9aYJju/iJD4EO9TV8/UsNyxPAV2EL6MyV40x0ra
 4uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=icV6cxvXLdy/u1P61WPyBZFENlozm8iS3OoyNfd2f5Q=;
 b=dgkN0/TH83tBBM7ZG6rx/gArPmiaCHA0y+gB280v2QgvuE4hAHTb5o58r5vWl9jBst
 cXCrwq9mkUknHA4jlSr1Be2D4yhnQPxWVXBnQ5PtbKGGvKNbDpzG6ouNQfjcUQ+WeKfK
 lYlbXQFxkJyxNpZI5LsH72QaAFRbEEDPTCoBI0ORTXkMpsXr3TUj7pyKtWuABavGWwQi
 OFRaCDAvkqVlLt4xZWWpseW4xyTMQrbkNjYKRg1b9Qts9RnsF5TfDfkJR9NHXV9Y7kIx
 UWyKp0oqHJiryJCnwRkwoTvtnXLhRCoAFMbxtOqQlRueYSA/LvAK4p/3N/+i+0MQhM72
 TyDA==
X-Gm-Message-State: ACrzQf1QpeEoXqtUJnywF0veIRiMj7TkqKU4k6yIAVD6ze4cS2oFLzAF
 CQTOwHcgPzmE46RjtFCJwGs=
X-Google-Smtp-Source: AMsMyM7WsNBU8dNmdrnrV6FryYuT3bRv7UJ5WDgSBEi2W+cfzeMgqEXo5xk+WrXjvI9JpkAwxAEiKQ==
X-Received: by 2002:a05:600c:4f46:b0:3b4:fed8:331e with SMTP id
 m6-20020a05600c4f4600b003b4fed8331emr11585833wmq.198.1664468829288; 
 Thu, 29 Sep 2022 09:27:09 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 d22-20020a05600c34d600b003b49ab8ff53sm4987940wmq.8.2022.09.29.09.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 09:27:07 -0700 (PDT)
Date: Thu, 29 Sep 2022 16:27:06 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] openrisc: update config files
Message-ID: <YzXHWteIFh2kUOXY@oscomms1>
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
 <YzWp+p+1V1UmCAb3@oscomms1> <YzWr+mmtLy2DRYEA@oscomms1>
 <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 openrisc@lists.librecores.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Geert,

On Thu, Sep 29, 2022 at 05:07:40PM +0200, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Thu, Sep 29, 2022 at 4:30 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Thu, Sep 29, 2022 at 02:21:46PM +0000, Stafford Horne wrote:
> > > On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> > > > Clean up config files by:
> > > >   - removing configs that were deleted in the past
> > > >   - removing configs not in tree and without recently pending patches
> > > >   - adding new configs that are replacements for old configs in the file
> 
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >
> > > Thanks for the patch this looks fine to me.  Usually I just generate this
> > > defcnfigs using make savedefconfig.  If there is some better way which
> > > doesn't generate the file with the # comment's I haven't found it.
> > >
> > > I will queue this.
> >
> > Actually..
> >
> > About the subject 'openrisc: update config files' and description.  Can you be
> > more specific about what updates you are making for this patch?
> >
> > For example: remove comments from config files.
> 
> These are not comments, but options that default to y or m, and
> are overriden to n by "commenting them out".
> 
> This syntax dates back to the days Kconfig was a collection of
> shell scripts. Nowadays, switching to "CONFIG_<FOO>=n" would
> perhaps make sense, as Kconfig already recognizes that syntax.

Right, I remember the *comment's* do actually are material to the config files.
In this patch not everything is removed, just old non-existent configs.

I sill prefer having a more descriptive subject.

-Stafford

> > > > --- a/arch/openrisc/configs/or1ksim_defconfig
> > > > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > > > @@ -19,9 +19,6 @@ CONFIG_NET=y
> > > >  CONFIG_PACKET=y
> > > >  CONFIG_UNIX=y
> > > >  CONFIG_INET=y
> > > > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > > > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > > > -# CONFIG_INET_XFRM_MODE_BEET is not set
> > > >  # CONFIG_INET_DIAG is not set
> > > >  CONFIG_TCP_CONG_ADVANCED=y
> > > >  # CONFIG_TCP_CONG_BIC is not set
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
