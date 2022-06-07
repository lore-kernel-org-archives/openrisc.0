Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8670DCCA47C
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 09:48:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 627DF24895;
	Tue,  7 Jun 2022 11:48:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id 23B6524758
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 11:48:21 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EB708611DE
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 09:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCACC3411E
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 09:48:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="YG0W0G2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1654595297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EXnEGOlOoorlOymfhfFprGYEDfkZN+Y3S5++2IMnflg=;
 b=YG0W0G2Ymjm0JWE6Mn9x/+C7adFx/a9GQWwi93cCcN4G3ilbAqwvOqTNOSsqy14PNnbnDs
 s4zbnN+X4HygJ8+RZW0UkObBdT1R9qzAAt4JGZWlfAdhBx4d5hpqXnwMP0sg5NJKv7pXnz
 DPbrWoxZADE8WZEQ/Oxw0VujGPHHGqw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4b8f785f
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
 for <openrisc@lists.librecores.org>;
 Tue, 7 Jun 2022 09:48:17 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id g201so2388943ybf.12
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 02:48:16 -0700 (PDT)
X-Gm-Message-State: AOAM5316sJiKYbZdNqu4uVsCilVkNNgPHcJwnKxpHB8GkGDV3HH6a/K2
 gJRtKSciehMI454v/XrytWxAmDFs3XBhry1TiR0=
X-Google-Smtp-Source: ABdhPJyDTNxIehXogC1xLFjIVfBlEKeEQ7GDh9XwX2Nm/yBzVZ7RIfuFIMK2CDmTGpPFzqVCmrfz2YvUgpRVDOBqp8M=
X-Received: by 2002:a25:8d92:0:b0:656:a73e:a7f with SMTP id
 o18-20020a258d92000000b00656a73e0a7fmr28007746ybl.382.1654595295799; Tue, 07
 Jun 2022 02:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec> <YpxnHaaizsNpOjx8@zx2c4.com>
In-Reply-To: <YpxnHaaizsNpOjx8@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 7 Jun 2022 11:48:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9r2qGQxh9TXZ+zyytJpqQL3uyV1+=9V32LVNXFaUud3ag@mail.gmail.com>
Message-ID: <CAHmME9r2qGQxh9TXZ+zyytJpqQL3uyV1+=9V32LVNXFaUud3ag@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

+ Arnd

On Sun, Jun 5, 2022 at 10:19 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi folks,
>
> On Sun, Jun 05, 2022 at 04:32:13PM +0900, Stafford Horne wrote:
> > Why can't m68k switch to little-endian in qemu and the kernel?  The m68k virt
> > platform is not that old, 1 year? Are there a lot of users that this would be a big
> > problem?
>
> I also share this perspective. AFAICT, m68k virt platform *just*
> shipped. Fix this stuff instead of creating more compatibility bloat for
> a platform with no new silicon. The risks of making life difficult for
> 15 minutes for all seven and a half users of that code that only now has
> become operational is vastly dwarfed by the good sense to just fix the
> mistake. Treat the endian thing as a *bug* rather than a sacred ABI.
> Bugs only become sacred if you let them sit for years and large numbers
> of people grow to rely on spacebar heating. Otherwise they're just bugs.
> This can be fixed.
>
> Jason
