Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE77ECAAD5
	for <openrisc@archiver.kernel.org>; Mon,  5 Sep 2022 06:23:29 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D754D20857;
	Mon,  5 Sep 2022 08:23:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id 084F62485F
 for <openrisc@lists.librecores.org>; Sun, 21 Aug 2022 16:58:19 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B222860ED9
 for <openrisc@lists.librecores.org>; Sun, 21 Aug 2022 14:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1C3C433D6
 for <openrisc@lists.librecores.org>; Sun, 21 Aug 2022 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661093897;
 bh=GzHlPdU+t+7DtU8s+ZQkqJLPYJa2D5QllpBgFvrmGaw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=f/InbUJweAfp1LwZGHesZqt6a4G8zsWb4eQ8hwBY+fB8ZNzuv2+o+WZHLNeTfA4WO
 tP4Obzfca17jnLVlGgFOFqxNd6GFR4jnIKswxHiVPRByKR0FyyfEjvUWSnMKafFXQ4
 QOr40w20RSDAD9EvrDPFMMrXNqdtlQCXpnGEoCR3w5CIY8AdxOD/JFzlCAcvspGNEm
 DVW630OZ50JWDkTiPs1UE7dtpdaCNgkS+cAO/JlCROhsav5Fnx6kPk1iKt/dCeUOfS
 RZB0YxyQZs+ZabqVHYJ21sh7i3kcM3kQyE6cLB3Q80qen46LSIsGqGB9qTe2iH9WI3
 DNgxHvxgpF3Bw==
Received: by mail-pf1-f170.google.com with SMTP id x15so7287995pfp.4
 for <openrisc@lists.librecores.org>; Sun, 21 Aug 2022 07:58:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo3oxKJHt4Gn29XRK6fEirQvmfC17BZiMxCq931KrL5P3YwcEcCo
 LA7vbNDLWWV83aNXuoSndMrUWRimmtCyn8AqbGU=
X-Google-Smtp-Source: AA6agR5Jfm9mVjshWjpFq8OKc54hNg+6T+J3SLoca3TFw2LF4khEc2uAuPslbwwXSbPSAHiGS5rHKpQKorBBpPqiG2g=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr6025080vsu.43.1661093886384; Sun, 21
 Aug 2022 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
 <YwIc7qbCWpIVKR2j@arm.com>
In-Reply-To: <YwIc7qbCWpIVKR2j@arm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 21 Aug 2022 22:57:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qffsU0Tmb7_b0iQh7x3Bks2vVrmmvL+0Z0CVaVggsYg@mail.gmail.com>
Message-ID: <CAAhV-H4qffsU0Tmb7_b0iQh7x3Bks2vVrmmvL+0Z0CVaVggsYg@mail.gmail.com>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 05 Sep 2022 08:23:27 +0200
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linux-sh list <linux-sh@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 linux-csky@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
 Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-xtensa@linux-xtensa.org, Vasily Gorbik <gor@linux.ibm.com>,
 Chris Zankel <chris@zankel.net>, linux-um <linux-um@lists.infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-alpha@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, openrisc@lists.librecores.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, loongarch@lists.linux.dev,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>, Borislav Petkov <bp@alien8.de>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

For LoongArch parts:

Acked-by: Huacai Chen <chenhuacai@kernel.org>

On Sun, Aug 21, 2022 at 7:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 19, 2022 at 09:44:06AM +0800, Kefeng Wang wrote:
> > Only x86 has own release_thread(), introduce a new weak
> > release_thread() function to clean empty definitions in
> > other ARCHs.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> [...]
> >  arch/arm64/include/asm/processor.h      | 3 ---
> >  arch/arm64/kernel/process.c             | 4 ----
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
