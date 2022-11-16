Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E81C433FE
	for <openrisc@archiver.kernel.org>; Wed, 16 Nov 2022 08:02:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 007A224785;
	Wed, 16 Nov 2022 09:02:38 +0100 (CET)
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by mail.librecores.org (Postfix) with ESMTPS id 8E6362499F
 for <openrisc@lists.librecores.org>; Wed, 16 Nov 2022 09:02:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1668585756; x=1700121756;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aiQ1E4MA/V7AYoAnhMYGLoTHKrhMUZFLqWEuM1zwwcE=;
 b=qLNNm8hT4nyJSMSpi3eUDo+dizdOgqml6J1HAZSOsG79tYQjWOHwBJzg
 acl6oUr5Wl4wrXxq9enp2UphOL0IkeKL0bk9DtOyUZgOGPVNaY7E7jIyZ
 DnjE4cUWt99aIOhJsBX32hhwlfjcmjbwxKBCEyU0+LmR5jjsKOsl8oxGu
 YzcbgLA2yD5PYoXBswfCPFpmyONI9Nj9sCqHxLI2D8L6Tu8lHPKOy6NWH
 2RIfctoa8qeuet28h6rWKVvi1MoAIka3ZkxDkivnYU1K5jLKV0S56if1V
 vG87NF/jIfsDy1QexD779aJAAdX16Iwoj8Ev4GawlLGp37M8e7dpLkBHd g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; d="scan'208";a="320737356"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 16:02:24 +0800
IronPort-SDR: QOyO4GCL7nhx/hv79vaXlaVhHKZXHdM8UzPg8n/ydr83ZubzbS+sTV0bFXHbYp7dxiDEBZxf14
 pmlSwM4/wgs9CBNrRU1QXaFRe6nlewgSeW/SLD+u8WmwU1eL8Y5C+IPkc0WUQjNfgcBaFL1xsG
 aMEtm3IElj51jwmh+b17NHtk8isnuOM1XUAoiL7+kDgFp9R6QaKLIBCBIF8L/9amdgE/EvWJvM
 Lek7kunU1JFgQZgFbe0zf/VbraU8eR1hjQ6MJxgkO+L9q9nN8hTvcEHN50g7GEH+CVHS/STxfS
 8KI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 15 Nov 2022 23:21:20 -0800
IronPort-SDR: cPpkRvVkNY9mOMKy0c3qUDshlyDihmoc/4Ftliv4zOI7u7SJ4KtPm4/ne2ISrxGgicUsu8NGg5
 ErsebeVWlNm4Et3LL+qzAAGgpXuwQGwmwoMm8YBhzuHpdU4Yaad2ezGXsKQH8g+4FPodT+nzWS
 raLoNNwKdEwaBql/lX/VporjB4JtC6SxVDnonZb1psGqpCFh1ljXxP5szp5uN01AxGievOG040
 EPhOja3331Qa1aBeTGMU5TWVUQ1X3GE8ODsmDrobJBe40ZlxtN482Edi2Ecig86YIE6rXvxxc2
 jv0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Nov 2022 00:02:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBwWN08PFz1Rwrq
 for <openrisc@lists.librecores.org>; Wed, 16 Nov 2022 00:02:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1668585741; x=1671177742; bh=aiQ1E4MA/V7AYoAnhMYGLoTHKrhMUZFLqWE
 uM1zwwcE=; b=HA1Ry+cg6RJ2gjCP8QzPoYEqbM+un5RWNEqtxmceQW57Bclcbag
 NGVq1I/ljnUAG7e+dWbg6SHQpAYCbV7sOdCxgqFgZ4pzgoNsKHS4IH8zUw04Ehu5
 dOBiDPL4KmGViD3JeZAwkB6etQOKepL41kIde5Ba4pgzbuGnRM1pZxWBs7ausiGW
 xHuUG/WUR1me2OOtLMdfMVusiCeskJy/VucmD/2wmEsQcj4UuKvYmRVFE6j4LVqm
 2iq97BemLKEd79gUPRS2/gmHt/dXWiGkEr5tvvvKOvf7ul4Wt6jiIkw7aMRmg/5x
 PB1wyQR574lwPScueQHcrY1HZ3N0U57D1/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id DbC7cyzdBCKi for <openrisc@lists.librecores.org>;
 Wed, 16 Nov 2022 00:02:21 -0800 (PST)
Received: from [10.89.82.19] (c02drav6md6t.dhcp.fujisawa.hgst.com
 [10.89.82.19])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBwW94Qxqz1RvLy;
 Wed, 16 Nov 2022 00:02:13 -0800 (PST)
Message-ID: <b119e0b7-be10-46d8-886b-b5071b1b9562@opensource.wdc.com>
Date: Wed, 16 Nov 2022 17:02:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
References: <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
 <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
 <0e45a2f2-6dd5-5a43-c1a0-7520c1ed2675@opensource.wdc.com>
 <Y3SYA31zobR6/qbj@casper.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y3SYA31zobR6/qbj@casper.infradead.org>
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
 Alexander Shiyan <shc_work@mail.ru>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Arnd Bergmann <arnd@arndb.de>,
 Josh Triplett <josh@joshtriplett.org>, openrisc@lists.librecores.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>, Rustam Kovhaev <rkovhaev@gmail.com>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 2022/11/16 16:57, Matthew Wilcox wrote:
> On Tue, Nov 15, 2022 at 01:28:14PM +0900, Damien Le Moal wrote:
>> On 11/15/22 13:24, Damien Le Moal wrote:
>>> 6.1-rc5, SLOB:
>>>     - 623 free pages
>>>     - 629 free pages
>>>     - 629 free pages
>>> 6.1-rc5, SLUB:
>>>     - 448 free pages
>>>     - 448 free pages
>>>     - 429 free pages
>>> 6.1-rc5, SLUB + slub_max_order=0:
>>>     - Init error, shell prompt but no shell command working
>>>     - Init error, no shell prompt
>>>     - 508 free pages
>>>     - Init error, shell prompt but no shell command working
>>> 6.1-rc5, SLUB + patch:
>>>     - Init error, shell prompt but no shell command working
>>>     - 433 free pages
>>>     - 448 free pages
>>>     - 423 free pages
>>> 6.1-rc5, SLUB + slub_max_order=0 + patch:
>>>     - Init error, no shell prompt
>>>     - Init error, shell prompt, 499 free pages
>>>     - Init error, shell prompt but no shell command working
>>>     - Init error, no shell prompt
>>>
>>> No changes for SLOB results, expected.
>>>
>>> For default SLUB, I did get all clean boots this time and could run the
>>> cat command. But I do see shell fork failures if I keep running commands.
>>>
>>> For SLUB + slub_max_order=0, I only got one clean boot with 508 free
>>> pages. Remaining runs failed to give a shell prompt or allow running cat
>>> command. For the clean boot, I do see higher number of free pages.
>>>
>>> SLUB with the patch was nearly identical to SLUB without the patch.
>>>
>>> And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
>>> could run the cat command only once, giving 499 free pages, so better than
>>> regular SLUB. But it seems that the memory is more fragmented as
>>> allocations fail more often.
>>
>> Note about the last case (SLUB+patch+slub_max_order=0). Here are the
>> messages I got when the init shell process fork failed:
>>
>> [    1.217998] nommu: Allocation of length 491520 from process 1 (sh) failed
>> [    1.224098] active_anon:0 inactive_anon:0 isolated_anon:0
>> [    1.224098]  active_file:5 inactive_file:12 isolated_file:0
>> [    1.224098]  unevictable:0 dirty:0 writeback:0
>> [    1.224098]  slab_reclaimable:38 slab_unreclaimable:459
>> [    1.224098]  mapped:0 shmem:0 pagetables:0
>> [    1.224098]  sec_pagetables:0 bounce:0
>> [    1.224098]  kernel_misc_reclaimable:0
>> [    1.224098]  free:859 free_pcp:0 free_cma:0
>> [    1.260419] Node 0 active_anon:0kB inactive_anon:0kB active_file:20kB
>> inactive_file:48kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
>> mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB
>> kernel_stack:576kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
>> [    1.285147] DMA32 free:3436kB boost:0kB min:312kB low:388kB high:464kB
>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB
>> inactive_file:28kB unevictable:0kB writepending:0kB present:8192kB
>> managed:6240kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>> [    1.310654] lowmem_reserve[]: 0 0 0
>> [    1.314089] DMA32: 17*4kB (U) 10*8kB (U) 7*16kB (U) 6*32kB (U) 11*64kB
>> (U) 6*128kB (U) 6*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3460kB
>> [    1.326883] 33 total pagecache pages
>> [    1.330420] binfmt_flat: Unable to allocate RAM for process text/data,
>> errno -12
> 
> What you're seeing here is memory fragmentation.  There's more than 512kB
> of memory available, but nommu requires it to be contiguous, and it's
> not.  This is pretty bad, really.  We didn't even finish starting up
> and already we've managed to allocate at least one page from each of
> the 16 512kB chunks which existed.  Commit df48a5f7a3bb was supposed
> to improve matters by making exact allocations reassemble once they
> were freed.  Maybe the problem is entirely different.

I suspected something like this when seeing the reported "free:859" :)
What I can try next is booting without SD card and the bare minimum set of
drivers to see if the fragmentation is still there or not. Would that help ?
These one page allocations may be for device drivers so never freed, no ?

-- 
Damien Le Moal
Western Digital Research

