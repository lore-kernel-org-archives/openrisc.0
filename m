Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9226FC433FE
	for <openrisc@archiver.kernel.org>; Tue, 22 Nov 2022 17:16:10 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 5A5D824B1E;
	Tue, 22 Nov 2022 18:16:09 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by mail.librecores.org (Postfix) with ESMTPS id 2BF9824B21
 for <openrisc@lists.librecores.org>; Tue, 22 Nov 2022 18:16:08 +0100 (CET)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 412F65C01AC;
 Tue, 22 Nov 2022 12:16:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Tue, 22 Nov 2022 12:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm3; t=1669137367; x=1669223767; bh=AWib7uk/pX
 ojLTP6WLnsRKQNx+DKIkZTOrXloBCRaME=; b=lySZ7U8uKnWn00jTXtr9CAy5eX
 nv56f5UzD8Tk1XQ/zM5Lhx6iJpKUBacT8Jhv8GyD2PflS6Y7GxJQc0fIKYqg5Oes
 CFa1i/Ts0YaZ3w+29HTSOtSLJVf8UyxvgO7Elc+4A1sD1p/Xc15Cgj/ipv+7sC75
 6w/wVc+YoF9EFV6ZnauvYJWW3dZBEdWUU3Bunbq5pUvgvqvufeUJEzM47bRam58J
 c3BOM4tOLUQkAGfA/RhyWi1+/qHvJbvC8bLwEEGaDCDs9qV6wxZFKoq3UYhXxQKt
 Wh8d/wv3tWb9gfqRvidRS+ZMd1z1j9zWUlznP4LRf6uszZiJKJUYJDZHHY8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1669137367; x=1669223767; bh=AWib7uk/pXojLTP6WLnsRKQNx+DK
 IkZTOrXloBCRaME=; b=WsG7hmw+LKirM0tmH9Kzn5cWIv1cpT8+lNht2XAQJ9s3
 4ZLi37KXbwyfZUymR+BePagoJCdji1Vzcj0n80TQIde9wB6INMz6g6O95orGjmgQ
 D4kmajLzD+hdqXIR6sGDItFx17483bKqA/prajubW26vU7eE2HfQ48F4RU3AbTOn
 BflQWRTk2zMsv9br6one4vxpVJ+2Kq+zgKTclR29Zf4FJW/LONRJf+GU2SCd5pYG
 J4BngUHmANTkgBSU86Eb3htMc55hA4qxKx5rSTTKWS1MsK5pY95N8jw9lUbptr/n
 4Z8nSzdK1pAXa5mMpKlxS3WdFwiL2He3irWZfBm6bA==
X-ME-Sender: <xms:0wN9Y7qPWw2exYVs5wfHuy9rYZCZQuHgMhVEQFannzbjtddQn3BQ4g>
 <xme:0wN9Y1pqiwYlVCjjKrkgcm3wu_Akhjhp7R2xmRAGsKVts_mSuo6Fr9nHjS2-N14PA
 LmVoU5uRDXDxBzCiFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheelgdeilecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
 ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
 gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
 ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
 hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0wN9Y4N8QRmdxsSzxLfB-wzAErGuIyYmXrIV7YRp5MuOsZXSFqmatg>
 <xmx:0wN9Y-4hZz5AMF7CfedaolyttL0YesCLDNyMIosGKiGFB-DvxEr6EQ>
 <xmx:0wN9Y64KESJLM4L1wu3Xny3rpN-0y311CrDXA6fAwwRQHLgNIP87NQ>
 <xmx:1wN9Y2EvqHiCPXzlZoDK1Y6SAsHx1IrtLMuRFmYZSqKK8S6eDS_6EQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 30CBAB60086; Tue, 22 Nov 2022 12:16:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <501fbee3-cd3d-461c-9c79-0a5f2d1382b6@app.fastmail.com>
In-Reply-To: <ab663f18-429a-7d86-f128-6db73fc07b8a@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <bc2f3ca9-e49a-4ca1-8b63-cbc7773d23d5@app.fastmail.com>
 <ab663f18-429a-7d86-f128-6db73fc07b8a@suse.cz>
Date: Tue, 22 Nov 2022 18:15:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vlastimil Babka" <vbabka@suse.cz>, "Christoph Lameter" <cl@linux.com>,
 "David Rientjes" <rientjes@google.com>,
 "Joonsoo Kim" <iamjoonsoo.kim@lge.com>, "Pekka Enberg" <penberg@kernel.org>
Subject: Re: [PATCH 00/12] Introduce CONFIG_SLUB_TINY and deprecate SLOB
Content-Type: text/plain
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
 Tony Lindgren <tony@atomide.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-riscv@lists.infradead.org,
 Jonas Bonn <jonas@southpole.se>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>,
 Josh Triplett <josh@joshtriplett.org>, openrisc@lists.librecores.org,
 Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 patches@lists.linux.dev, Conor Dooley <conor@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Nov 22, 2022, at 17:59, Vlastimil Babka wrote:
> On 11/22/22 17:33, Arnd Bergmann wrote:
>> On Mon, Nov 21, 2022, at 18:11, Vlastimil Babka wrote:
>> I can imagine those machines wanting to use sysfs in general
>> but not for the slab caches, so having a separate knob to
>> configure out the sysfs stuff could be useful without having
>> to go all the way to SLUB_TINY.
>
> Right, but AFAIK that wouldn't save much except some text size and kobjects,
> so probably negligible for >32MB?

Makes sense, I assume you have a better idea of how much this
could save. I'm not at all worried about the .text size, but
my initial guess was that the metadata for sysfs would be
noticeable.

>> For the options that trade off performance against lower
>> fragmentation (MIN/MAX_PARTIAL, KMALLOC_RECLAIM, percpu
>> slabs), I wonder if it's possible to have a boot time
>> default based on the amount of RAM per CPU to have a better
>> tuned system on most cases, rather than having to go
>> to one extreme or the other at compile time.
>
> Possible for some of these things, but for others that brings us back to the
> question what are the actual observed issues. If it's low memory in absolute
> number of pages, these can help, but if it's fragmentation (and the kind if
> RAM sizes should have page grouping by mobility enabled), ditching e.g. the
> KMALLOC_RECLAIM could make it worse. Unfortunately some of these tradeoffs
> can be rather unpredictable.

Are there any obvious wins on memory uage? I would guess that it
would be safe to e.g. ditch percpu slabs when running with less
128MB per CPU, and the MIN/MAX_PARTIAL values could easily
be a function of the number of pages in total or per cpu,
whichever makes most sense. As a side-effect, those could also
grow slightly larger on huge systems by scaling them with
log2(totalpages).

     Arnd
