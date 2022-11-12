Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D619DC4321E
	for <openrisc@archiver.kernel.org>; Sun, 13 Nov 2022 06:49:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7E53E242D7;
	Sun, 13 Nov 2022 07:49:22 +0100 (CET)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 by mail.librecores.org (Postfix) with ESMTPS id 833BA24A8B
 for <openrisc@lists.librecores.org>; Sat, 12 Nov 2022 02:41:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1668217263; x=1699753263;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kWfbDk7epBE8N+lvIUYGuQa6NGCEfO5LUkxzV91Rv/U=;
 b=ScenQSV78QS+6txiKaxGh4XErU+/O/uSAljdjCMujR6WqCO9TAj14uIt
 /9fdJJDn7Bq7ieqfsz4qhvRV6LXDZc6KEQy20NCbVJbVeglLm32rrDlcJ
 4jMsfkYce3Ol66UAx/2eDRsIiM1WOx7vG/gAxL1WFWyL2HSdkZlkDdQ5q
 iR+E1pnX9BdLHrspQvpduJDTVHr2UNMt+KH2qo0Ei7vmzvohpp/TEx8vy
 8NTrsliEUSjlNM9WRd6vXA6CQ3Cm1+evDFRFX1Hv8Z6zHn8uuP4NBUa6a
 XZKoQ+yFqq3NMQBtz678a9WktS37Jarn3Ou//lhZdHgWVgArqjx+EU37p w==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; d="scan'208";a="328192718"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:41:00 +0800
IronPort-SDR: GFEElUd7qdUQaayJWbbY8Er7c5eOvDuH1I686OTplRVlvvb7Od7iKzZrTvoWgf3+meUWPJfEcA
 ioiR0YvATA9BHFT4s81pq1wzVm0IkrwOaRRgeorKTMSePNeof8+cS3GCrV2y4lYZvbhg6CRtyB
 cNXZn9I61UQjcXZExrIkeaXqvLOxWDWUyPfemRr4UVW7bnl1FuQboL9A2uec7ngJP3Bm6CtxmL
 EPW2R/egBgYYnqPjEyzuQWwPHIVVEtyN92U5X37bTbEmTItJjew4NfPB+cvD0/GeIXJ8vNb6Wz
 LhA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2022 17:00:03 -0800
IronPort-SDR: zpAqLLajU1h5k4o1F41pHbhWQPpnctxdEXahBdpChEQWRFpx0tSONkDqobXZ5y2tshqrlpy6L7
 MzjFpGfBRfGsEHIQi+3zzqOEmNG2X7PlzE4KBS/sfBTUNkw0Il9j5viPGZyhWIOUvmTC4wUIWj
 2KbOZxC+W5z7c2WVtuq9XbLX0IkqUVp5sRv5MpL3lS5E6Zw3LL8G7N+fk34zg3PtIbwt+wXAha
 tDx5LzO9gByYXJlZSm03ifTzcsMw2QoVbwp4dvaWqlr3+Mui/TplQ8lC/XfW97+cZqKYooenNo
 5Fs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2022 17:41:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8JFB0fM5z1RvTp
 for <openrisc@lists.librecores.org>; Fri, 11 Nov 2022 17:41:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1668217261; x=1670809262; bh=kWfbDk7epBE8N+lvIUYGuQa6NGCEfO5LUkx
 zV91Rv/U=; b=UQIAcuLVHOH6JEfl/g8NJY78ljIwYrrH6wsBu4bkUGfe+zI8mz2
 Jlte5n/1umT2AVQsjYYtZl+wwGT+FDMPxiMihAL2p/lW0BAwTQ4AwZbTbLPNHHDw
 iuUatn7w2e+/RbkY3t+UosoQYQXG9x2GoyLu1/MUqdo8p6ZzjCHEbTKDQhy65Syw
 /FcFmEuEisiN/HmLx3ts7jPYqGeHzbK4tkuLmonCh773jup8svd676IXPlvOrPH4
 k1zZf53ppjHwPytGLwP296R0gN54Bd6wU27hNGZlSWm8fxlKmI5cdqQENOL55iAI
 SfErkXQhirO0jYy5aOcLiroGTmWjPX7+4BA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id MsRVnNRYkUcj for <openrisc@lists.librecores.org>;
 Fri, 11 Nov 2022 17:41:01 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8JF265dcz1RvLy;
 Fri, 11 Nov 2022 17:40:54 -0800 (PST)
Message-ID: <e4076fcb-9736-937d-634b-5b8fb342723e@opensource.wdc.com>
Date: Sat, 12 Nov 2022 10:40:53 +0900
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

I will try with SLUB over the weekend.

-- 
Damien Le Moal
Western Digital Research

