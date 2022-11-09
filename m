Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D288C433FE
	for <openrisc@archiver.kernel.org>; Wed,  9 Nov 2022 17:45:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 5018524A55;
	Wed,  9 Nov 2022 18:45:42 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 0B0AD24A52
 for <openrisc@lists.librecores.org>; Wed,  9 Nov 2022 18:45:41 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 16072B81F4B;
 Wed,  9 Nov 2022 17:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B079DC433C1;
 Wed,  9 Nov 2022 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668015938;
 bh=i7sn7z8xD6SHJEq5dmKr3bGFRNb5IIYU4SUzL9diu3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ARGpruzLN9OuV1JYvbeHm52w2t6ttIgcwOERaZqjZsnd7VJWeUE/iSfoj625HTPs9
 LjIQy4r4/9BKNBA6nWXBmpYOA6SsvVWKXtma/QrTzMUEYdJHxRYVSM9ZzUmQDzL5gE
 yDkr6hT/XY5diiSADUVNUIFYs+FYy1RrzAoBCPu9+EF7pWX009Q1jSYcQpTH5/jXIz
 UvI5GVfMJsao2fdud1mdLsEBszy13PadoZxvIu7tt2f03u7RvYE5qrnsmDSaX9P9Yh
 hM2ic17YHSLgzomL7XWQE7iOvMfjj1ER/bTY5pZSY9MusLUUoQPuUHwDBgI3X4tiuz
 SLCO2K4jannvg==
Date: Wed, 9 Nov 2022 19:45:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y2vnLyprF79EQHNz@kernel.org>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <87187c52-ae48-130b-6479-ae1023915bc1@suse.cz>
 <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
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

On Wed, Nov 09, 2022 at 05:50:08PM +0200, Aaro Koskinen wrote:
> Hi,
> 
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

Looks like the same happened with arch/arm/configs/pxa_defconfig. XCEP
board had SLOB in its defconfig and when common pxa_defconfig was created
it apparently used it.
Looks like the board has 64M of RAM, so dropping CONFIG_SLOB=y from
arch/arm/configs/pxa_defconfig and arch/arm/configs/xcep_defconfig seems
very reasonable.

-- 
Sincerely yours,
Mike.
