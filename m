Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941FC433EF
	for <openrisc@archiver.kernel.org>; Mon, 30 May 2022 08:27:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 46EC224801;
	Mon, 30 May 2022 10:27:30 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mail.librecores.org (Postfix) with ESMTPS id B8B5A24819
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 10:27:29 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id k19so5405531wrd.8
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K9CAp5MlLxHryi1kpgDpIuPDfXt0cBHnONU1p4g0oV0=;
 b=ejgurUImsFfTPEBUvG4XwUZ7iRBsYeB1YxrfmrVZpkKb4+ioYyEVzu/1Mrf1WP2Ghz
 mZmQrEnMXUaSVJrz0n94LuxJDX+fLUchmnZJhedv+faTnncFB17+UvNUrXdCC4AsjNoa
 x1i26yeEl0V2rNVvD8DOaQKVDIs1PUjFukMj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K9CAp5MlLxHryi1kpgDpIuPDfXt0cBHnONU1p4g0oV0=;
 b=q+gk0jXFtjhk8+/XHY9/QHTL0/gU46IRZy5uP9suNJ1WhWuccOkxXoCZbjyDawQK6m
 DXA2MnQGYK6YGT6EyrGWN17qjWrDB6yyb2efuQQrMG7Vhq2tAIdqKL5u51LUY8i5b6yV
 CP28w7n/JYjzdQc8n8Ohgvy8tgVMhYIqOTLq/L8n0yAQCC1eCSGUrzVYs3Dr/Gxs4P62
 FEBM+W5SlTJT1pqbRzS3niCs8b7xvcaQ14NsdC1z0Grh4cgo6DcXX29Rf8jkNLkcvpKG
 73slSFL0QJOIU1Xe3DW1/ttXB3J1pVU39te20Q40iKBE3CEmuLLzngkJyThrjUX90qz/
 JzEw==
X-Gm-Message-State: AOAM530r3iMsRf5ZLomAo8U7+kBfSOS2AEJAOTgRPEKWa5I9eSerlFW7
 kMNxq4/VPPIz2UsQsTpUPqsXFVH/xu+44OSIJZYq1R5bp7Q=
X-Google-Smtp-Source: ABdhPJzkqa3x9YTKDMKIOJXB28L8NtRMrKp5PfrcRXP+SlRSj7/U0C94MZgCEelDCvHpBxBSQojCB3dliKga8/1t6pk=
X-Received: by 2002:a5d:428f:0:b0:210:30cd:3753 with SMTP id
 k15-20020a5d428f000000b0021030cd3753mr4408725wrq.549.1653899249271; Mon, 30
 May 2022 01:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
 <YpFSzpl5fdq7O3pk@antec> <YpHwhlF0Dhf58da7@pegase>
In-Reply-To: <YpHwhlF0Dhf58da7@pegase>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 May 2022 08:27:16 +0000
Message-ID: <CACPK8Xf5F+LJiYrCX50Muq9Eh2SUQNwMAP-LE6zudSE119Hhgw@mail.gmail.com>
Subject: Re: Link failure with Debian toolchain
To: Nicolas Boulenguez <nicolas@debian.org>
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
Cc: openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Sat, 28 May 2022 at 09:50, Nicolas Boulenguez <nicolas@debian.org> wrote:
>
> > This seems to mean that the builtins for 64-bit ops are not being found. So
> > something is wrong with libgcc symbols.  Maybe something strange with the
> > multilib args used when building the toolchain.
> > I'll have a look at it. It would be nice if I can used this toolchain for my CI.
>
> In case it helps, the options passed to ./configure are visible here:
> https://salsa.debian.org/debian/gcc-or1k-elf/-/blob/master/debian/rules#L45

Thanks for the link. I did a local build of gcc 12 and binutils 2.38
with the same arguments as the Debian build and I was able to
successfully build the kernel.

Taking a closer look, it's not the configure line but another step. In
the gcc rules we have:

$(gnu_type)-strip --remove-section=.comment --remove-section=.note \
 debian/gcc-*/usr/lib/gcc/*/*/lib*.a

Stripping libgcc.a breaks it. I could reproduce by running:

  or1k-elf-strip lib/gcc/or1k-elf/12/libgcc.a

If I then reinstated the original libgcc.a the build succeeded again.
I suggest we drop that line from the Debian package.

Cheers,

Joel
