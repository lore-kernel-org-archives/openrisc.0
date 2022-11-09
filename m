Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93DBC4332F
	for <openrisc@archiver.kernel.org>; Wed,  9 Nov 2022 16:45:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6E67424A4E;
	Wed,  9 Nov 2022 17:45:57 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by mail.librecores.org (Postfix) with ESMTPS id 1696D24A21
 for <openrisc@lists.librecores.org>; Wed,  9 Nov 2022 17:45:56 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id h10so12650956qvq.7
 for <openrisc@lists.librecores.org>; Wed, 09 Nov 2022 08:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ews1zWN1f/PR7HGzfMn+lenNKSw7QezbzurfTC9dGEg=;
 b=LI53FxeTZMZPqjYtakHcjl9SX2h0oaZuH0iBec/Q4tqgOGfVZfOmQs6MzGyjSv/7rK
 1X/mlM52y9uzaJ660SDWAplM1h0bIP0wNh7sixVH3Sl6frBDC/cVANhRZ3muPNGjEYjF
 m/vDjFmDQQeFT06VN9JISqP33MA+5/6iWn7sFM/C06dAB3khAb2eL4Kvu2L2NOK6mMxS
 iz3IdXH46pweEbEXHJPHbzVImpFOnx829KTQcU4V9ak2yDiB2+cfnaQnVxTvbeOPo0ky
 QbNa3y/nJtAYrXDZ0uazJT8XA7if/t/Z3GVWLDH34t5sfGgUgkxK7d8QZeurAwcI6+2B
 ahwg==
X-Gm-Message-State: ACrzQf3yTwKcVsFhuHRMnCYRaxIHDO55qvmETrBZ3dLhTJrt9ttHeLat
 6OOv+gpN0DaYv3f3QhUbSXD9FFHxCrCdUQ==
X-Google-Smtp-Source: AMsMyM6w9rPziZ8naKSdA2Q95koYkdgRljHh3gTR7n1mbBhaCU76rBYyB9RNF6ZfAS60AnRylkJ3TA==
X-Received: by 2002:ad4:5f4c:0:b0:4b8:ec94:68e with SMTP id
 p12-20020ad45f4c000000b004b8ec94068emr54709562qvg.38.1668012354709; 
 Wed, 09 Nov 2022 08:45:54 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com.
 [209.85.128.174]) by smtp.gmail.com with ESMTPSA id
 bm7-20020a05620a198700b006ce1bfbd603sm11298831qkb.124.2022.11.09.08.45.54
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Nov 2022 08:45:54 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-3691e040abaso167261437b3.9
 for <openrisc@lists.librecores.org>; Wed, 09 Nov 2022 08:45:54 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr40745720ybs.380.1668012343710; Wed, 09
 Nov 2022 08:45:43 -0800 (PST)
MIME-Version: 1.0
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <87187c52-ae48-130b-6479-ae1023915bc1@suse.cz>
 <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
In-Reply-To: <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Nov 2022 17:45:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXY7z+BXjM1KNVF9AKw0n28Fe-8TDbRC=WKXZf09h6G+w@mail.gmail.com>
Message-ID: <CAMuHMdXY7z+BXjM1KNVF9AKw0n28Fe-8TDbRC=WKXZf09h6G+w@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To: Aaro Koskinen <aaro.koskinen@iki.fi>
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
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Christoph Lameter <cl@linux.com>, linux-riscv@lists.infradead.org,
 Jonas Bonn <jonas@southpole.se>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Arnd Bergmann <arnd@arndb.de>,
 Josh Triplett <josh@joshtriplett.org>, openrisc@lists.librecores.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Shiyan <shc_work@mail.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rustam Kovhaev <rkovhaev@gmail.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Nov 9, 2022 at 4:53 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Wed, Nov 09, 2022 at 10:00:25AM +0100, Vlastimil Babka wrote:
> > > On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >> I believe SLOB can be removed because:
> > >>
> > >> - AFAIK nobody really uses it? It strives for minimal memory footprint
> > >> by putting all objects together, which has its CPU performance costs
> > >> (locking, lack of percpu caching, searching for free space...). I'm not
> > >> aware of any "tiny linux" deployment that opts for this. For example,
> > >> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> > >> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> > >> SLOB impact is too much for those who tried. Googling for
> > >> "CONFIG_SLOB=y" yielded nothing useful.
> > >
> > > I am all for removing SLOB.
> > >
> > > There are some devices with configs where SLOB is enabled by default.
> > > Perhaps, the owners/maintainers of those devices/configs should be
> > > included into this thread:
>
> [...]
>
> > > arch/arm/configs/omap1_defconfig:CONFIG_SLOB=y
>
> I have been using SLUB on my OMAP1 boards with 32 MB RAM, because of
> better debugging features and the memory footprint difference doesn't
> really matter for my use cases. Looking at history why SLOB was added
> there, it seems it came from 6cfce27c14aa ("omap1: Add omap1_defconfig")
> when separate boards configs were merged, and SX1 board happened to have
> SLOB in there. This board is nowadays only used in QEMU anyway.
>
> There are OMAP1 boards with only 16 MB, but support for those boards
> will be removed. So from OMAP1 side, I don't think there is any real
> need for SLOB anymore.

Interestingly, the m68k defconfigs use either SLAB, or the default (SLUB).
So the poor old m68k machines (many of which have less than 32 MiB)
seem to do fine without SLOB...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
