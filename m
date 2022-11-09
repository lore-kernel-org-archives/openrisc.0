Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7476C43219
	for <openrisc@archiver.kernel.org>; Sun, 13 Nov 2022 06:49:24 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1883E23CCB;
	Sun, 13 Nov 2022 07:49:22 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mail.librecores.org (Postfix) with ESMTPS id 9FFF324A54
 for <openrisc@lists.librecores.org>; Wed,  9 Nov 2022 22:17:06 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id c2so18255169plz.11
 for <openrisc@lists.librecores.org>; Wed, 09 Nov 2022 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6o0JaodUdCinHCuijBKMPPDh4qNhM3W4CwZTMs5pShU=;
 b=b7JdsqL98tFczElrzx45zPQRQqT+FLWQdW7GQ21VMf1VWbVkWvdPT7fPQVW9/YYGhj
 fsJmZVTrJHZqpF5nrGm5JKasB3diwCu2Hs5yNW2C9n/rEZiCH7R7PnAEwZ/MGa/qzyIG
 zfiOnumXidobU0/zuy474imLQWsj+TNcT1BwOR4wCZrc7nj9wEle1ahDUDnwTkt6UQJ1
 bZGNJ9fqbFCNFUTDQDZYUF5tjtiVt+POwV9J5xnlurRxP4GFYN8l+xbrN6OKbV0N8j6j
 kPz632gUkLxrLhg+OI3WB7b7hny2T7RaIKSOWnHn8CvNieatf9SjrSo7u+FU7dyzH4Jo
 RWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6o0JaodUdCinHCuijBKMPPDh4qNhM3W4CwZTMs5pShU=;
 b=E3aJ4NrgGjc++luU9a94PipWr9HxoQW+xIYPaeO8OTdfcypAQtL3vSA0WyM5djc1Eq
 hy7II8kAOcaCrr0LlYuHOBcVrRVdN8ih9Qbr0IERvE7WfXGQWXikRqBeYeVZCohYv/jY
 /NJhu4ef0InwaxZLk55gJCeOqUkCIccwnOMKSgVzEnR93/pUGNvYL2E4PMYX4ADWzSim
 TbDYaY2KXp+SYl9OjY30wJNY4aXAmnQp0mYF6oVl4BMgJHDwJjSig/tHgbfdvGMyZSGF
 mQCbyqWNqW1rEhYQLOQewXOgLKpBuZZ1FhUh6KoZ0ofaTaJfq2CC1Edf9JT/u0dijH8R
 NA7Q==
X-Gm-Message-State: ACrzQf2ZmOOliEcyJcutM8uJZhBeUW4cWxeXAprFlBZ3H4MGTJxw8oAD
 mI1X72GdhZ26cfXdzhrQS8G944JUOGBdtF34Cbg=
X-Google-Smtp-Source: AMsMyM5vTjPHFhQ2vYKc1ap+Gnz9Xnoi5f6pFtOuhyEULsih6osIQH75MdocdJksgvBY7Bht8TwzxWn0ElldlUKBtUU=
X-Received: by 2002:a17:902:da82:b0:186:ee5a:47c7 with SMTP id
 j2-20020a170902da8200b00186ee5a47c7mr63072929plx.82.1668028625070; Wed, 09
 Nov 2022 13:17:05 -0800 (PST)
MIME-Version: 1.0
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <87187c52-ae48-130b-6479-ae1023915bc1@suse.cz>
 <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
In-Reply-To: <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Wed, 9 Nov 2022 22:16:53 +0100
Message-ID: <CAGfqbt50b9rFEjbFPCZoQnNyBN+CAgBf6bxwpbr4z=tL_A97MQ@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To: Vlastimil Babka <vbabka@suse.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
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
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Christoph Lameter <cl@linux.com>, linux-riscv@lists.infradead.org,
 Jonas Bonn <jonas@southpole.se>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>,
 David Rientjes <rientjes@google.com>,
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

On Wednesday, 9 November 2022 16:50:08 CET Aaro Koskinen wrote:
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
>
> There are OMAP1 boards with only 16 MB, but support for those boards
> will be removed. So from OMAP1 side, I don't think there is any real
> need for SLOB anymore.

Moreover, I always had issues with availability of socket buffers during USB
device setup when trying to use SLOB on Amstrad Delta based on OMAP1510,
the least powerful OMAP1.  Then, +1 for SLOB removal.

Thanks,
Janusz
