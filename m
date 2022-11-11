Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E97C4167B
	for <openrisc@archiver.kernel.org>; Sun, 13 Nov 2022 06:49:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4797F24243;
	Sun, 13 Nov 2022 07:49:22 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id BAC1D24A1E
 for <openrisc@lists.librecores.org>; Fri, 11 Nov 2022 21:46:58 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D0608B8260C;
 Fri, 11 Nov 2022 20:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16855C433D6;
 Fri, 11 Nov 2022 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668199616;
 bh=+aijmCyFee7qWFeNljZb8zYD5+XuzsnyGaxX9FEYxpk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UnwFL8wuWkoZyhSHDqs67j/LsmCKgpcpww1g7jCaWZ36JihNBOGBStyV6m2p2YLp+
 m2905fbVL3d+YYvg5Yw6+fM2rewxOIR0BXA5PJNQb7wbR7rut9I32ZzXzgtbxINfcn
 ywzelh60+IhLjCHgH9LQeBHlGFBz+Su/dtPQQ7KQ5eWGcMuTG6UyLYdWb1u1/m+WfT
 AWnvj4oYpVtx2Yi88aEsVMDJHNkhw4lVBU9k1Di7od31GKlIx8ow4kj7mjLq5dO6Vi
 ujvifadc6imBUFXqg2RbvXS48bE0aDe4bgAMQCOKMiv9+sqVG6Zl0x5Xv7jiRhT7w9
 B9u+Kk/K+VpHw==
Date: Fri, 11 Nov 2022 20:46:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y260tkNHc2vFITJ3@spud>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz>
X-Mailman-Approved-At: Sun, 13 Nov 2022 07:49:20 +0100
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
 Paul Cercueil <paul@crapouillou.net>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Conor.Dooley@microchip.com,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christoph Lameter <cl@linux.com>,
 linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Arnd Bergmann <arnd@arndb.de>,
 Josh Triplett <josh@joshtriplett.org>, openrisc@lists.librecores.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Alexander Shiyan <shc_work@mail.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rustam Kovhaev <rkovhaev@gmail.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
> On 11/8/22 22:44, Pasha Tatashin wrote:
> > On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> Hi,
> >>
> >> as we all know, we currently have three slab allocators. As we discussed
> >> at LPC [1], it is my hope that one of these allocators has a future, and
> >> two of them do not.
> >>
> >> The unsurprising reasons include code maintenance burden, other features
> >> compatible with only a subset of allocators (or more effort spent on the
> >> features), blocking API improvements (more on that below), and my
> >> inability to pronounce SLAB and SLUB in a properly distinguishable way,
> >> without resorting to spelling out the letters.
> >>
> >> I think (but may be proven wrong) that SLOB is the easier target of the
> >> two to be removed, so I'd like to focus on it first.
> >>
> >> I believe SLOB can be removed because:
> >>
> >> - AFAIK nobody really uses it? It strives for minimal memory footprint
> >> by putting all objects together, which has its CPU performance costs
> >> (locking, lack of percpu caching, searching for free space...). I'm not
> >> aware of any "tiny linux" deployment that opts for this. For example,
> >> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> >> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> >> SLOB impact is too much for those who tried. Googling for
> >> "CONFIG_SLOB=y" yielded nothing useful.
> > 
> > I am all for removing SLOB.
> > 
> > There are some devices with configs where SLOB is enabled by default.
> > Perhaps, the owners/maintainers of those devices/configs should be
> > included into this thread:
> > 
> > tatashin@soleen:~/x/linux$ git grep SLOB=y

> > arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
> > arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
> > arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y

> 
> Turns out that since SLOB depends on EXPERT, many of those lack it so
> running make defconfig ends up with SLUB anyway, unless I miss something.
> Only a subset has both SLOB and EXPERT:
> 
> > git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`

> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y

I suppose there's not really a concern with the virt defconfig, but I
did check the output of `make nommu_k210_defconfig" and despite not
having expert it seems to end up CONFIG_SLOB=y in the generated .config.

I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
boots etc, but I have no workloads or w/e to run on it.

