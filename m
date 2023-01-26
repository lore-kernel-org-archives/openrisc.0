Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4CC636CB
	for <openrisc@archiver.kernel.org>; Sat, 28 Jan 2023 22:23:46 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DC7D7229C3;
	Sat, 28 Jan 2023 23:23:45 +0100 (CET)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mail.librecores.org (Postfix) with ESMTPS id 52499215C6
 for <openrisc@lists.librecores.org>; Sat, 28 Jan 2023 23:23:44 +0100 (CET)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-4a263c4ddbaso113749707b3.0
 for <openrisc@lists.librecores.org>; Sat, 28 Jan 2023 14:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTLUhLqiktW0lQYPPHgLpL0hyET/yRv7DDBqjk/47Fc=;
 b=c3Ijfg077fn02FMX561w8/SS1YugJEvtx6NLWHHHWCQCHTVhh04hkvjqX4835mDcKx
 M4HM0DxhVJvhQzZDewHPn72wRf809ow45wZ7v+OaUpoUpaNMYIXqalkX2DM3L0cMkD6O
 OJwQNtD6aiDuA6EYa585gd7jFErGGE4GPH7yvGZ6Vavk0Mzl6bD+YdeWjs2aCij3gGvL
 BzWLnZ8DOHgtMZNFaPgLqiMc/GOjjLfTu70LpGfzKTGyDiqVkwC036Moc3K0nG3UNlb7
 LzQ1dTrIZp63uQsmivMM1Yrs+0hSAkR02E7BviUztgYg9IO/jdoCYsgq3V1rctQpu0Ka
 Idfw==
X-Gm-Message-State: AO0yUKVc5CTgFBbhFOOvB7nPOa+eh/iFA77xTEqmhoBYoE5woU3zLRGE
 w8hKlpbpKkEK4h7Xtq77KPc1XYLpjHyQ0Q==
X-Google-Smtp-Source: AK7set8XfW+CzhukNGjUvJUd/Wvq2s/fvC+XbnoGFE5Q9olspwFFLpqfz515wOhpI31jF1U85Yai7g==
X-Received: by 2002:a05:622a:489:b0:3b8:118c:f0dd with SMTP id
 p9-20020a05622a048900b003b8118cf0ddmr861377qtx.1.1674721256329; 
 Thu, 26 Jan 2023 00:20:56 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169]) by smtp.gmail.com with ESMTPSA id
 b16-20020a05620a04f000b00704d8ad2e11sm550187qkh.42.2023.01.26.00.20.56
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jan 2023 00:20:56 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id h5so1102395ybj.8
 for <openrisc@lists.librecores.org>; Thu, 26 Jan 2023 00:20:56 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr2761883ybo.543.1674721245117; Thu, 26
 Jan 2023 00:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20230125190757.22555-1-rppt@kernel.org>
 <20230125190757.22555-2-rppt@kernel.org>
In-Reply-To: <20230125190757.22555-2-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jan 2023 09:20:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeuPgkWVjpZ=OM4ofnoYyv2nY1_FGo0JUZCFXYX=K2vw@mail.gmail.com>
Message-ID: <CAMuHMdUeuPgkWVjpZ=OM4ofnoYyv2nY1_FGo0JUZCFXYX=K2vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68k: use asm-generic/memory_model.h for both MMU and
 !MMU
To: Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>, Greg Ungerer <gerg@linux-m68k.org>,
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, linux-riscv@lists.infradead.org,
 Vineet Gupta <vgupta@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, linux--csky@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 loongarch@lists.linux.dev, Stafford Horne <shorne@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jan 25, 2023 at 8:08 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
>
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
