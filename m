Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AFBC433F5
	for <openrisc@archiver.kernel.org>; Mon, 30 May 2022 08:00:11 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id EA13924130;
	Mon, 30 May 2022 10:00:09 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mail.librecores.org (Postfix) with ESMTPS id B575C24130
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 10:00:07 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id t6so13500812wra.4
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=edz7vExUgeNnspQJ9wO//4ZoMfycwC5hEf1RXQRWCxA=;
 b=gj/e81YaH0AKAORR2pmPNItlnEDV+ONCyf4YT9eP8dnYl/eq+Ecc8Tbd/PcT9Mzbhg
 vdw4IopQr6knHNITQDkhCSgS3OBrE+q0OjrfUAG9O2ooKmzYViy/mnkXU3o2+Ez2gMdf
 I9XCYBWwBl3zXQt95vFv42TNpOmj8pUIC8qdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edz7vExUgeNnspQJ9wO//4ZoMfycwC5hEf1RXQRWCxA=;
 b=YpH/e3QXu9//UZ6mq2F9yHBqkwt+GwhZgrRTz+JMFw48I9PtDF9tN9KmlGu+Nwu7XD
 cGJXeMCVcS6w0H78zwGzPMyDCDuAyJ0WdVmMboaGyWMmF7gS6BUDVeZ4Alqqh0nwaADN
 gFMDjoDQ8LRbGin1juXk2vxrgL8HcuGKm+Gzu1CiMKDju5TTTekdQQ4YHfG/+RrcNT8Z
 OFHDjOO/joXXxcz5run4QTG3wNrNZyL0Xr4sMB+pAO/hAbOftqR91D6qGxCGPfsz2BCw
 QC9tQsCGYAYsnMVlCIYeZQLO5c5JD1HEgo1ptvtmlMduPNti5VpzNvBqh22WEH445GcP
 j+Yg==
X-Gm-Message-State: AOAM533dBWeMhmRyLSlyFvjoLNTJ3SGshpU90i5sfhhMP0VCCk0BLOF+
 OkHruxsgmZwCx5MjM1LruZlD44Ok+07ubPjfE7w=
X-Google-Smtp-Source: ABdhPJzKqxmNy3Szzd9iJjTN69fcT+CG/DDGg/MCO89pvOVSguAgdUJADljCdRacL/FgI4YgoQCfmvhC8YVA41SDcL8=
X-Received: by 2002:adf:e18f:0:b0:20e:6352:211d with SMTP id
 az15-20020adfe18f000000b0020e6352211dmr44681134wrb.606.1653897607212; Mon, 30
 May 2022 01:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
 <YpFSzpl5fdq7O3pk@antec>
In-Reply-To: <YpFSzpl5fdq7O3pk@antec>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 May 2022 07:59:54 +0000
Message-ID: <CACPK8XeyXpYcfcBcqtSutoepM-vBF6_Ta5FAHVPND8CKnTMUOg@mail.gmail.com>
Subject: Re: Link failure with Debian toolchain
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
Cc: openrisc@lists.librecores.org, nicolas@debian.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, 27 May 2022 at 22:38, Stafford Horne <shorne@gmail.com> wrote:
>
> > I've used it to build a mork1x litex soc so I think it works in some
> > situations at least.
> >
> > I was trying to build your latest Linux kernel changes, applied on top
> > of v5.18, however the bug reproduces with plain v5.18.
> >
> > $ CROSS_COMPILE=or1k-elf- ARCH=openrisc make O=or1k or1klitex_defconfig
> > $ CROSS_COMPILE=or1k-elf- ARCH=openrisc make O=or1k -j8
>
> This looks good too. What is the meaning of O=or1k? I never have used that
> before.

O is the objdir, where the output is placed. It's handy for using the
one source tree to do multiple builds:

$ make help | grep O
   make O=dir [targets] Locate all output files in "dir", including .config
