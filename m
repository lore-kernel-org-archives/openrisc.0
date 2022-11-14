Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94630C43217
	for <openrisc@archiver.kernel.org>; Mon, 14 Nov 2022 01:55:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2DEBF248E6;
	Mon, 14 Nov 2022 02:55:22 +0100 (CET)
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 by mail.librecores.org (Postfix) with ESMTPS id B6AE220AC2
 for <openrisc@lists.librecores.org>; Mon, 14 Nov 2022 02:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1668390920; x=1699926920;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nyOFTXz3d9X6eMOZsmuYqPSZyAOtJSgUq3fJ16zqsqM=;
 b=Zkcz5ZOO/rrx2GvoM8GlIpt8fBBrIsg/iFT+Ao5sV4TB+17DFVNeTKDU
 bljRPDiApg2d5Qx9/Yjgn7IrjoHApC/fuT8fO4LDPy15n0TibTC3D3+cV
 1BQdoxyTtZKmK9UgMEswvyFBmLGahCDc8tlwcGDatR4Xn7oLMZ7M7DY/a
 TP4Hifst7nAKDHTKcGwIqGdN89tGrrBirotvg32/AtOsJ3f1DqbJbWguA
 qmRPuy7rJUNx7Geihej7S5irVW61dCp4kkH2NWsTb2mjxBf9Xs2mFLHok
 V3Hj3rzCiD7voSXGZD6/4LutOHdsqnl/7FpY3PBDGknn3vCyaBVj+DcMp g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; d="scan'208";a="216180207"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 09:55:18 +0800
IronPort-SDR: S10GL533gEMtxFMBAIZXB7p5Q9lVFC76AoG4kPqR9Mq3pObTwamiQ0WU2+mkpzFTXnNFFwGquA
 +3hwhkBXzq6KihKFz/g/bA4dRfGdemELAMfJGUKH5Ax1bSmCJpwncf6HsuqULwycNn2P6oUTYJ
 RhgXzC/k3bQKtDV/iNNqLrGFxZM6ootmdMuwnwgAVePBrWN3tnD1YmP9/cS+U+0n/qtCDKSE+j
 r8t79Yj9qqrqXQ91x9Hx6npfDZKSird9MNjtsnRC2cId5y2KZP9MzskQSMc+igWz+Gs4ZLCmiG
 qJE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2022 17:08:33 -0800
IronPort-SDR: OslEYv3KyuaG7Yo0PUlQX5gdNqqFevP3keL+IP7MHkXnjhuy8casf0cvfR/UUDoEVRUInwdE8J
 n4ZJh4hZLz0fWW2r8AEqy1sroxKYdu7qMB/LyJYkBa2TM8O9eyYL9DwH6l3dhkB5jUBEGdwUIq
 nQjpAb07imcktAovTzNUQsFJnHcK+CSMwoo8Nv9/W5njJX1f+GW7mqgMK6v5Ae3X+UbPhBj97q
 5YlrSpIZFpm/zvJTOHc0bWRuhIyNxGIvGYchA3TsZQDwe9dT10Dql9Vm343TEzsYPkdY9y0C0u
 3sY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2022 17:55:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9XSk1sr8z1RwtC
 for <openrisc@lists.librecores.org>; Sun, 13 Nov 2022 17:55:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1668390916; x=1670982917; bh=nyOFTXz3d9X6eMOZsmuYqPSZyAOtJSgUq3f
 J16zqsqM=; b=B7FIG24k/AkrbPRlxTTp+YAyPl2DtgOB49NBmCF1uJe1rzavO/J
 NnzQvOw5y6jZvpQDwbtMGe43anknJxLtaNq6ye3vNETqunaV7aPGbWlB5yTcJneZ
 dep7KJ5wOdey9UA9pJO55QieVSkTNlBVhNgkyYu31fgMtYTbglkkIlf7pD0mZS9U
 TV2BXR5pUYz63ZjDo3FL0DtWJD6Q7xWT2ajGfhM6MNxiQ4WATwU3nDj6s5pOHaUi
 EtT3fitwsRCuczjPghjRbOWkaSka9UnIqihDhmL1YAsBAgEnAIKojathaHJVhQgy
 vt64Jcr8YksY1GcywsWLEhEhXqIrpmbW4JA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id v4YiWLt-w173 for <openrisc@lists.librecores.org>;
 Sun, 13 Nov 2022 17:55:16 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9XSY61WPz1RvLy;
 Sun, 13 Nov 2022 17:55:09 -0800 (PST)
Message-ID: <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
Date: Mon, 14 Nov 2022 10:55:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y260tkNHc2vFITJ3@spud>
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

On 11/12/22 05:46, Conor Dooley wrote:
> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>> Hi,
>>>>
>>>> as we all know, we currently have three slab allocators. As we discussed
>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>> two of them do not.
>>>>
>>>> The unsurprising reasons include code maintenance burden, other features
>>>> compatible with only a subset of allocators (or more effort spent on the
>>>> features), blocking API improvements (more on that below), and my
>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>> without resorting to spelling out the letters.
>>>>
>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>> two to be removed, so I'd like to focus on it first.
>>>>
>>>> I believe SLOB can be removed because:
>>>>
>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>> by putting all objects together, which has its CPU performance costs
>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>> SLOB impact is too much for those who tried. Googling for
>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>
>>> I am all for removing SLOB.
>>>
>>> There are some devices with configs where SLOB is enabled by default.
>>> Perhaps, the owners/maintainers of those devices/configs should be
>>> included into this thread:
>>>
>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
> 
>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> 
>>
>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>> running make defconfig ends up with SLUB anyway, unless I miss something.
>> Only a subset has both SLOB and EXPERT:
>>
>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
> 
>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
> 
> I suppose there's not really a concern with the virt defconfig, but I
> did check the output of `make nommu_k210_defconfig" and despite not
> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
> 
> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
> boots etc, but I have no workloads or w/e to run on it.

I sent a patch to change the k210 defconfig to using SLUB. However...

The current default config using SLOB gives about 630 free memory pages
after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).

This is with a buildroot kernel 5.19 build including a shell and sd-card
boot. With SLUB, I get clean boots and a shell prompt as expected. But I
definitely see more errors with shell commands failing due to allocation
failures for the shell process fork. So as far as the K210 is concerned,
switching to SLUB is not ideal.

I would not want to hold on kernel mm improvements because of this toy
k210 though, so I am not going to prevent SLOB deprecation. I just wish
SLUB itself used less memory :)


-- 
Damien Le Moal
Western Digital Research

