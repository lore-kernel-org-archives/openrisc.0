Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D7FC43217
	for <openrisc@archiver.kernel.org>; Thu, 29 Sep 2022 15:07:57 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 01B42248E6;
	Thu, 29 Sep 2022 17:07:56 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mail.librecores.org (Postfix) with ESMTPS id 4E648248F9
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 17:07:54 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id k12so1007217qkj.8
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 08:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Rzp0lh/K2FX3N+ufpgYNPH83ze92e9mULF1gMbtZpQs=;
 b=B/Rg9vS5/4vy3pA8NIXg90JIZxv8Y0N+OVLG/Y6KQSZVojccM0oGqeFW+wB9mLaOXB
 xdSL+ZlT4WGLndUaN6FtDX1xtbEYRRfRRPMxgUyi+amrS8RSI4ep2ordcY+Ry23CaXOZ
 Kjy/qI0Q0BZ28XHMkZJZIooIayEEgQIQ80XOXbVWQZJ/GyE58EXauKZNpGwGWYHVXZYH
 1EtwkcP+P7dObkwVVCJFFtDTBP19FMNYilMRLz8Oq1MqXMmHEmkx7pO9XzQqjnlK8OGh
 /4OdmHAdw/LuNao78jjWsIbIxjSQ5H/jMMz0LBHOELlpPNWTFLgWyCym/bHx1DiO4thi
 1Ubw==
X-Gm-Message-State: ACrzQf0Gh1NS83T6Cznw9XxPCvOPa/CgyIguuU4QNmOwfZo676loRQZ9
 4UD04KDGYapQEFu4QJnIuo/3zE+G26P8Iw==
X-Google-Smtp-Source: AMsMyM6g7oihXBIqqYOmDVz37DfpjxZh3Zi3lABdYo3ill39Wf/fN6RakHo9HnftTpSSimVKXpDzIw==
X-Received: by 2002:a05:620a:c4f:b0:6cf:8135:e803 with SMTP id
 u15-20020a05620a0c4f00b006cf8135e803mr2539712qki.67.1664464072976; 
 Thu, 29 Sep 2022 08:07:52 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com.
 [209.85.219.182]) by smtp.gmail.com with ESMTPSA id
 w14-20020ac84d0e000000b0035cd6a4ba3csm5476781qtv.39.2022.09.29.08.07.52
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Sep 2022 08:07:52 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id e84so1862169ybb.13
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 08:07:52 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr3378572ybp.365.1664464072203; Thu, 29
 Sep 2022 08:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
 <YzWp+p+1V1UmCAb3@oscomms1> <YzWr+mmtLy2DRYEA@oscomms1>
In-Reply-To: <YzWr+mmtLy2DRYEA@oscomms1>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Sep 2022 17:07:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
Message-ID: <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
Subject: Re: [PATCH] openrisc: update config files
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
Cc: Jonas Bonn <jonas@southpole.se>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 openrisc@lists.librecores.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Stafford,

On Thu, Sep 29, 2022 at 4:30 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Sep 29, 2022 at 02:21:46PM +0000, Stafford Horne wrote:
> > On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> > > Clean up config files by:
> > >   - removing configs that were deleted in the past
> > >   - removing configs not in tree and without recently pending patches
> > >   - adding new configs that are replacements for old configs in the file

> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > Thanks for the patch this looks fine to me.  Usually I just generate this
> > defcnfigs using make savedefconfig.  If there is some better way which
> > doesn't generate the file with the # comment's I haven't found it.
> >
> > I will queue this.
>
> Actually..
>
> About the subject 'openrisc: update config files' and description.  Can you be
> more specific about what updates you are making for this patch?
>
> For example: remove comments from config files.

These are not comments, but options that default to y or m, and
are overriden to n by "commenting them out".

This syntax dates back to the days Kconfig was a collection of
shell scripts. Nowadays, switching to "CONFIG_<FOO>=n" would
perhaps make sense, as Kconfig already recognizes that syntax.

> > > --- a/arch/openrisc/configs/or1ksim_defconfig
> > > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > > @@ -19,9 +19,6 @@ CONFIG_NET=y
> > >  CONFIG_PACKET=y
> > >  CONFIG_UNIX=y
> > >  CONFIG_INET=y
> > > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > > -# CONFIG_INET_XFRM_MODE_BEET is not set
> > >  # CONFIG_INET_DIAG is not set
> > >  CONFIG_TCP_CONG_ADVANCED=y
> > >  # CONFIG_TCP_CONG_BIC is not set

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
