Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682DDC433FE
	for <openrisc@archiver.kernel.org>; Mon, 14 Nov 2022 05:48:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 5762F2133D;
	Mon, 14 Nov 2022 06:48:48 +0100 (CET)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 by mail.librecores.org (Postfix) with ESMTPS id 0B6FC2132A
 for <openrisc@lists.librecores.org>; Mon, 14 Nov 2022 06:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1668404926; x=1699940926;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=v1sR2mwFH9dmYdHzu0koJ50qxkQ0XF8GxeWMZxBQMlk=;
 b=jMkEt+pDZuBlUCxqTNc5T6qoTx19y4mjUX7BKPSUxHR9UyKyBWG6Apph
 QzL27V//Y7u8iGSesUnLJs036NGkdL31FFuE8lD4Er59WbejSieSMp58r
 oRq47uTE8eMr3IVj8gBMkV2Rr6/hl4ReArlBZoy2PWFUYXGSkr3w67DoX
 OyEmzt9UT7aT7tCaLFVK48JkguBIxyqlvk+YHdrRHiGFIi4s3WA33X8ya
 Q+G/uTjeMIoyfCFSP/f8q0mxm3ZFKxUzc6u19AfveCYP6DaMJ6paVxvxL
 t+Dy3DPA84Ni8Cd6/sHXiiqcTO/cPvmMZ7EYQc9NhcyRIji/1IA9OJJVY Q==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; d="scan'208";a="328292707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 13:48:39 +0800
IronPort-SDR: 0IMAAoOuptqKuCY1KoRCH4HRE9sXsyXIYKbiltTVtMG4R1VYVzemaP9vz5JRjSYgZKeV4scauN
 Bt8DTVt0x9OCwWVvTteZp8J4hoidhxUYdu+XafcQ7PWDs4KqLYnLyRlOX5P2Yq/eY4T3ymMNDK
 936EgyefsperOsDX1eL1EibWvxc9bPqz5HHBtF5cVA/zRb9hFvhhQdkOYwrLFryjj0l6PHhZhD
 ndnZQzomHkNlaOYWhVvEPkKPctI4ODQO/XdzZukLg352Wz/r+vpI2e2fA0O1wstT8cKZfdFtTR
 /ak=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2022 21:07:38 -0800
IronPort-SDR: VnzT/+Qg4hWZ78nOs8nbwEBwJ9a5bt2Rd1yjFED8LIY3I6UwDUbTMqCcW/y5jHSRi82tJxEcms
 VIYa9+mXirTVag++FHU2AVl+wgqXfhwgFOLsNA11FuXPkxltAc0MWQZuYWJwP4DKyAXVTIQDpq
 ZTx051zeu70Y4MBm2Nws2iGwlJLoa8So2NMD8ZoB5rG659TQ9C36IwIhoEy2PJHNvi0IdhCfX3
 STNa2M5ck6kBY8N0iMjtQ2QWhHgVi45Q91wpwmcQ96ja9gmHUCTk9b9sBrh5264X16wH5keJXW
 WWQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2022 21:48:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9ddz2XhTz1RvTr
 for <openrisc@lists.librecores.org>; Sun, 13 Nov 2022 21:48:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:references:to:from:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1668404917; x=1670996918; bh=v1sR2mwFH9dmYdHzu0koJ50qxkQ0XF8GxeW
 MZxBQMlk=; b=Jj+OgXCgQLjiUSHdOF9I6MrgaqryVIX7t3nKyq6ZmaxCJrCDf+D
 tGBRwgMUBBGTq4WU22kKDQ58BiVzcFr1xRFoFfI1n8Bxo5+TB1XvlNxdODgFNzfR
 jI637Q7j4BNG1aLfH2JTTKH2lh843Eo9/6TImWIKH46gMtBWsZjKCoxGm9Oozafp
 gcs1atYVDBJpU4XwoYUztHkasGYGgZWrc/JjNE7l3NWvxCnS7nVLlm25abnZU+4P
 jNICFUVM5vo+y+8k+C+JC5BZmVgZ8TARD4EmnhnyFopFQzr/VUu1urRgOa3vVo3h
 xfnBECv6draKEFEd/vChz733S2WF8QS+58w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id etKHmY3ZlURi for <openrisc@lists.librecores.org>;
 Sun, 13 Nov 2022 21:48:37 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9ddp5cqHz1RvLy;
 Sun, 13 Nov 2022 21:48:30 -0800 (PST)
Message-ID: <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
Date: Mon, 14 Nov 2022 14:48:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: Conor Dooley <conor@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
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

On 11/14/22 10:55, Damien Le Moal wrote:
> On 11/12/22 05:46, Conor Dooley wrote:
>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>> two of them do not.
>>>>>
>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>> features), blocking API improvements (more on that below), and my
>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>> without resorting to spelling out the letters.
>>>>>
>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>> two to be removed, so I'd like to focus on it first.
>>>>>
>>>>> I believe SLOB can be removed because:
>>>>>
>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>> by putting all objects together, which has its CPU performance costs
>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>> SLOB impact is too much for those who tried. Googling for
>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>
>>>> I am all for removing SLOB.
>>>>
>>>> There are some devices with configs where SLOB is enabled by default.
>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>> included into this thread:
>>>>
>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>
>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>
>>>
>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>> Only a subset has both SLOB and EXPERT:
>>>
>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>
>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>
>> I suppose there's not really a concern with the virt defconfig, but I
>> did check the output of `make nommu_k210_defconfig" and despite not
>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>
>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>> boots etc, but I have no workloads or w/e to run on it.
> 
> I sent a patch to change the k210 defconfig to using SLUB. However...
> 
> The current default config using SLOB gives about 630 free memory pages
> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
> 
> This is with a buildroot kernel 5.19 build including a shell and sd-card
> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
> definitely see more errors with shell commands failing due to allocation
> failures for the shell process fork. So as far as the K210 is concerned,
> switching to SLUB is not ideal.
> 
> I would not want to hold on kernel mm improvements because of this toy
> k210 though, so I am not going to prevent SLOB deprecation. I just wish
> SLUB itself used less memory :)

Did further tests with kernel 6.0.1:
* SLOB: 630 free pages after boot, shell working (occasional shell fork
failure happen though)
* SLAB: getting memory allocation for order 7 failures on boot already
(init process). Shell barely working (high frequency of shell command fork
failures)
* SLUB: getting memory allocation for order 7 failures on boot. I do get a
shell prompt but cannot run any shell command that involves forking a new
process.

So if we want to keep the k210 support functional with a shell, we need
slob. If we reduce that board support to only one application started as
the init process, then I guess anything is OK.

-- 
Damien Le Moal
Western Digital Research

