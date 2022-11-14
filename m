Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC58C433FE
	for <openrisc@archiver.kernel.org>; Mon, 14 Nov 2022 09:36:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 83E01248BE;
	Mon, 14 Nov 2022 10:36:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by mail.librecores.org (Postfix) with ESMTPS id 828C924A5E
 for <openrisc@lists.librecores.org>; Mon, 14 Nov 2022 10:36:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4C8B1FD1A;
 Mon, 14 Nov 2022 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668418592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxio+L3toNBvT64+SrT/qG6YJWkxujdIoa+zw3ra2HE=;
 b=rUv4cK3r28iPxAXNTemloUCMBc1LWAWzB66EqovWKhktShRlNDRUj+DL3IJGIlHy6IzVMh
 XuR5DqSM3dTIeIr6+3CHy9o8sFXjnva/k24qNf5xxLAdRQma2bDEWfpA2qQHBF11F+O050
 qCgg0RxqRjyK6EfK9vQQiAjzpMgLRwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668418592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxio+L3toNBvT64+SrT/qG6YJWkxujdIoa+zw3ra2HE=;
 b=aRsLPWVxhCqoMHN85C0MDaQHfYLH7GSJ2L9qgj1QVi0IgP5+EZp8ju3j8jNBpgWO0EouCD
 U7j1OEnj0XZsA/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2144C13A92;
 Mon, 14 Nov 2022 09:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AWPtBiAMcmOsQgAAMHmgww
 (envelope-from <vbabka@suse.cz>); Mon, 14 Nov 2022 09:36:32 +0000
Message-ID: <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
Date: Mon, 14 Nov 2022 10:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Conor Dooley <conor@kernel.org>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
 Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
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

On 11/14/22 06:48, Damien Le Moal wrote:
> On 11/14/22 10:55, Damien Le Moal wrote:
>> On 11/12/22 05:46, Conor Dooley wrote:
>>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>>> two of them do not.
>>>>>>
>>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>>> features), blocking API improvements (more on that below), and my
>>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>>> without resorting to spelling out the letters.
>>>>>>
>>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>>> two to be removed, so I'd like to focus on it first.
>>>>>>
>>>>>> I believe SLOB can be removed because:
>>>>>>
>>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>>> by putting all objects together, which has its CPU performance costs
>>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>>> SLOB impact is too much for those who tried. Googling for
>>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>>
>>>>> I am all for removing SLOB.
>>>>>
>>>>> There are some devices with configs where SLOB is enabled by default.
>>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>>> included into this thread:
>>>>>
>>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>>
>>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>>
>>>>
>>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>>> Only a subset has both SLOB and EXPERT:
>>>>
>>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>>
>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>>
>>> I suppose there's not really a concern with the virt defconfig, but I
>>> did check the output of `make nommu_k210_defconfig" and despite not
>>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>>
>>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>>> boots etc, but I have no workloads or w/e to run on it.
>> 
>> I sent a patch to change the k210 defconfig to using SLUB. However...

Thanks!

>> The current default config using SLOB gives about 630 free memory pages
>> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
>> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).

Thanks for the testing! How much RAM does the system have btw? I found 8MB
somewhere, is that correct?
So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
difference [1]. But that was looking at Slab pages, not free pages. The
extra overhead could be also in percpu allocations, code etc.

>> This is with a buildroot kernel 5.19 build including a shell and sd-card
>> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
>> definitely see more errors with shell commands failing due to allocation
>> failures for the shell process fork. So as far as the K210 is concerned,
>> switching to SLUB is not ideal.
>> 
>> I would not want to hold on kernel mm improvements because of this toy
>> k210 though, so I am not going to prevent SLOB deprecation. I just wish
>> SLUB itself used less memory :)
> 
> Did further tests with kernel 6.0.1:
> * SLOB: 630 free pages after boot, shell working (occasional shell fork
> failure happen though)
> * SLAB: getting memory allocation for order 7 failures on boot already
> (init process). Shell barely working (high frequency of shell command fork
> failures)
> * SLUB: getting memory allocation for order 7 failures on boot. I do get a
> shell prompt but cannot run any shell command that involves forking a new
> process.
> 
> So if we want to keep the k210 support functional with a shell, we need
> slob. If we reduce that board support to only one application started as
> the init process, then I guess anything is OK.

In [1] it was possible to save some more memory with more tuning. Some of
that required boot parameters and other code changes. In another reply [2] I
considered adding something like SLUB_TINY to take care of all that, so
looks like it would make sense to proceed with that.

[1]
https://lore.kernel.org/all/Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal/
[2] https://lore.kernel.org/all/eebc9dc8-6a45-c099-61da-230d06cb3157@suse.cz/
