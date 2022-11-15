Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805BFC433FE
	for <openrisc@archiver.kernel.org>; Tue, 15 Nov 2022 04:28:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 419562126D;
	Tue, 15 Nov 2022 05:28:32 +0100 (CET)
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by mail.librecores.org (Postfix) with ESMTPS id E414E214F6
 for <openrisc@lists.librecores.org>; Tue, 15 Nov 2022 05:28:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1668486509; x=1700022509;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=IlgyKi8wGWHux7YMaFUP7S/2i9Ze/98VZ3oQw75PGWk=;
 b=IleupWzdpAmv1x7CaGnzrm9w60f8JH3bZjvLH4y/39xBhEPgiuBS3GH/
 3SsxUI2kxuUJI2+0bxao4YO5o1oaF+ZPrNyBJ0Gaw9E7Y4fN3kkEDRujD
 ttN6AXqe/lEFzkSyHvj2IG24buBTAbx17F2YROlPQV1f4YhAz/X53nS1+
 5ODUuqSa7qZYl2NtiurHFxwaj9KUwmsPJlxX7koFZmWLQWxafNTnyHZah
 ueD4+Rns7k5kzvki2wiYzZS+2xQle4VWuiqHkXqUSmtXcFSJ8luvb5/iT
 OYV7fwYZiE9iDst2ua5laAh7VnVAbH7r+7eDtJNfeYALn5OAiSmbrD5R0 Q==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; d="scan'208";a="320623311"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 12:28:27 +0800
IronPort-SDR: Z7DJ6d38L1EJUrlBfKY31BWgZxhcZ1kHbguDhC9vVi9hK0dCBkcckpR4MuA0VAnK4Jbdsqb9hH
 l5Cv40yWb4Fi7lv7y2mBd0VkYpd09CmYgW5lnDw7OAauDxvBC3jegYK/TJXQDlgP6vvC5/7D5E
 XHIw2s8qq9rp/pvuwCchYppqyPy6jhFjcHz0FmxDqllkWDBJ8u86eObuO1fGL75a2Uw5+qnzo0
 n0tLG6+YhJNtR/qZsB7LItL/XSDQkPlbHVmFm//6HzneoRSMQX+TZ2drEZmYdL7m9uRPT8NsYs
 474=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Nov 2022 19:47:25 -0800
IronPort-SDR: q0P1uINBjT7PHHPCDx/7r1zxV8FRan1jvXkLGa46s3OYoB0w52LRJk0gNCO29QOJd0blPruzeR
 JwGp1MXrfESBfcYxe4weziy7csEl1xbKtthf4wYMUACBup347CdmVVub6o/43CbJKhw/wg3CBg
 xvdj+RzcRNlwYtNc+URiTK20fiGKw9H3kLl8Rni5QdxBOcsBPVJ8UEcArksdR/u7bYgZRsr+lG
 whlqkPkS5vXfznd0rpm+xN+RmEqGxl5kogGORI1rYwzdIW3bMPqWSw2Yx4g4q94f62URUAld2H
 x/g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Nov 2022 20:28:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBCpz2sklz1RvTr
 for <openrisc@lists.librecores.org>; Mon, 14 Nov 2022 20:28:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:references:to:from:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1668486504; x=1671078505; bh=IlgyKi8wGWHux7YMaFUP7S/2i9Ze/98VZ3o
 Qw75PGWk=; b=D/JT9wSnD5Nkd+nnxT7k6ZECxkWFF8cDBpexMYvsBhzNrpcYj/F
 ZHOBSJmKvV4Lwjb+JEr3oQX+Ey3lZ3HQiUCwBcoQCZVtlK6gaDb7mAac9mNaj8ua
 xSQfrgQm6ey4J9I8Ic6zQOa09rncwX+8ev5ZATfb2x0laagZfasAIyKgTZWcceNu
 FwqYLOjt1/srCYZdxRo7NtzAcKblm2MXMM0150ngig6NqwSHRkP3rdAC1DUpKcFn
 eXXstzMc01fgrJn6Di1oKzritA7l4tf8Bv8aQfxegL3bE+1o5ckhdsXRTY9/z63B
 OWwpK1Lm/sAdA9mKhatyO6CAJZrGqwlZ5yg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id FsbfAs21RzNc for <openrisc@lists.librecores.org>;
 Mon, 14 Nov 2022 20:28:24 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBCpm2J9Bz1RvLy;
 Mon, 14 Nov 2022 20:28:16 -0800 (PST)
Message-ID: <0e45a2f2-6dd5-5a43-c1a0-7520c1ed2675@opensource.wdc.com>
Date: Tue, 15 Nov 2022 13:28:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
 <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
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
 Christoph Lameter <cl@linux.com>, linux-riscv@lists.infradead.org,
 Jonas Bonn <jonas@southpole.se>, Alexander Shiyan <shc_work@mail.ru>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>,
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

On 11/15/22 13:24, Damien Le Moal wrote:
> On 11/14/22 23:47, Hyeonggon Yoo wrote:
>> On Mon, Nov 14, 2022 at 08:35:31PM +0900, Damien Le Moal wrote:
>>> On 11/14/22 18:36, Vlastimil Babka wrote:
>>>> On 11/14/22 06:48, Damien Le Moal wrote:
>>>>> On 11/14/22 10:55, Damien Le Moal wrote:
>>>>>> On 11/12/22 05:46, Conor Dooley wrote:
>>>>>>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>>>>>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>>>>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>>>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>>>>>>> two of them do not.
>>>>>>>>>>
>>>>>>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>>>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>>>>>>> features), blocking API improvements (more on that below), and my
>>>>>>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>>>>>>> without resorting to spelling out the letters.
>>>>>>>>>>
>>>>>>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>>>>>>> two to be removed, so I'd like to focus on it first.
>>>>>>>>>>
>>>>>>>>>> I believe SLOB can be removed because:
>>>>>>>>>>
>>>>>>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>>>>>>> by putting all objects together, which has its CPU performance costs
>>>>>>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>>>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>>>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>>>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>>>>>>> SLOB impact is too much for those who tried. Googling for
>>>>>>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>>>>>>
>>>>>>>>> I am all for removing SLOB.
>>>>>>>>>
>>>>>>>>> There are some devices with configs where SLOB is enabled by default.
>>>>>>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>>>>>>> included into this thread:
>>>>>>>>>
>>>>>>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>>>>>>
>>>>>>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>>>>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>>>>>>
>>>>>>>>
>>>>>>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>>>>>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>>>>>>> Only a subset has both SLOB and EXPERT:
>>>>>>>>
>>>>>>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>>>>>>
>>>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>>>>>>
>>>>>>> I suppose there's not really a concern with the virt defconfig, but I
>>>>>>> did check the output of `make nommu_k210_defconfig" and despite not
>>>>>>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>>>>>>
>>>>>>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>>>>>>> boots etc, but I have no workloads or w/e to run on it.
>>>>>>
>>>>>> I sent a patch to change the k210 defconfig to using SLUB. However...
>>>>
>>>> Thanks!
>>>>
>>>>>> The current default config using SLOB gives about 630 free memory pages
>>>>>> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
>>>>>> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
>>>>
>>>> Thanks for the testing! How much RAM does the system have btw? I found 8MB
>>>> somewhere, is that correct?
>>>
>>> Yep, 8MB, that's it.
>>>
>>>> So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
>>>> difference [1]. But that was looking at Slab pages, not free pages. The
>>>> extra overhead could be also in percpu allocations, code etc.
>>>>
>>>>>> This is with a buildroot kernel 5.19 build including a shell and sd-card
>>>>>> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
>>>>>> definitely see more errors with shell commands failing due to allocation
>>>>>> failures for the shell process fork. So as far as the K210 is concerned,
>>>>>> switching to SLUB is not ideal.
>>>>>>
>>>>>> I would not want to hold on kernel mm improvements because of this toy
>>>>>> k210 though, so I am not going to prevent SLOB deprecation. I just wish
>>>>>> SLUB itself used less memory :)
>>>>>
>>>>> Did further tests with kernel 6.0.1:
>>>>> * SLOB: 630 free pages after boot, shell working (occasional shell fork
>>>>> failure happen though)
>>>>> * SLAB: getting memory allocation for order 7 failures on boot already
>>>>> (init process). Shell barely working (high frequency of shell command fork
>>>>> failures)
>>>
>>> I forgot to add here that the system was down to about 500 free pages
>>> after boot (again from the shell with "cat /proc/vmstat").
>>>
>>>>> * SLUB: getting memory allocation for order 7 failures on boot. I do get a
>>>>> shell prompt but cannot run any shell command that involves forking a new
>>>>> process.
>>>
>>> For both slab and slub, I had cpu partial off, debug off and slab merge
>>> on, as I suspected that would lead to less memory overhead.
>>> I suspected memory fragmentation may be an issue but doing
>>>
>>> echo 3 > /proc/sys/vm/drop_caches
>>>
>>> before trying a shell command did not help much at all (it usually does on
>>> that board with SLOB). Note that this is all with buildroot, so this echo
>>> & redirect always works as it does not cause a shell fork.
>>>
>>>>>
>>>>> So if we want to keep the k210 support functional with a shell, we need
>>>>> slob. If we reduce that board support to only one application started as
>>>>> the init process, then I guess anything is OK.
>>>>
>>>> In [1] it was possible to save some more memory with more tuning. Some of
>>>> that required boot parameters and other code changes. In another reply [2] I
>>>> considered adding something like SLUB_TINY to take care of all that, so
>>>> looks like it would make sense to proceed with that.
>>>
>>> If you want me to test something, let me know.
>>
>> Would you try this please?
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index a24b71041b26..1c36c4b9aaa0 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4367,9 +4367,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>  	 * The larger the object size is, the more slabs we want on the partial
>>  	 * list to avoid pounding the page allocator excessively.
>>  	 */
>> -	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
>> -	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
>> -
>> +	s->min_partial = 0;
>>  	set_cpu_partial(s);
>>  
>>  #ifdef CONFIG_NUMA
>>
>>
>> and booting with and without boot parameter slub_max_order=0?
> 
> Test notes: I used Linus 6.1-rc5 as the base. That is the only thing I
> changed in buildroot default config for the sipeed maix bit card, booting
> with SD card. The test is: booting and run "cat /proc/vmstat" and register
> the nr_free_pages value. I repeated the boot + cat 3 to 4 times for each case.
> 
> Here are the results:
> 
> 6.1-rc5, SLOB:
>     - 623 free pages
>     - 629 free pages
>     - 629 free pages
> 6.1-rc5, SLUB:
>     - 448 free pages
>     - 448 free pages
>     - 429 free pages
> 6.1-rc5, SLUB + slub_max_order=0:
>     - Init error, shell prompt but no shell command working
>     - Init error, no shell prompt
>     - 508 free pages
>     - Init error, shell prompt but no shell command working
> 6.1-rc5, SLUB + patch:
>     - Init error, shell prompt but no shell command working
>     - 433 free pages
>     - 448 free pages
>     - 423 free pages
> 6.1-rc5, SLUB + slub_max_order=0 + patch:
>     - Init error, no shell prompt
>     - Init error, shell prompt, 499 free pages
>     - Init error, shell prompt but no shell command working
>     - Init error, no shell prompt
> 
> No changes for SLOB results, expected.
> 
> For default SLUB, I did get all clean boots this time and could run the
> cat command. But I do see shell fork failures if I keep running commands.
> 
> For SLUB + slub_max_order=0, I only got one clean boot with 508 free
> pages. Remaining runs failed to give a shell prompt or allow running cat
> command. For the clean boot, I do see higher number of free pages.
> 
> SLUB with the patch was nearly identical to SLUB without the patch.
> 
> And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
> could run the cat command only once, giving 499 free pages, so better than
> regular SLUB. But it seems that the memory is more fragmented as
> allocations fail more often.

Note about the last case (SLUB+patch+slub_max_order=0). Here are the
messages I got when the init shell process fork failed:

[    1.217998] nommu: Allocation of length 491520 from process 1 (sh) failed
[    1.224098] active_anon:0 inactive_anon:0 isolated_anon:0
[    1.224098]  active_file:5 inactive_file:12 isolated_file:0
[    1.224098]  unevictable:0 dirty:0 writeback:0
[    1.224098]  slab_reclaimable:38 slab_unreclaimable:459
[    1.224098]  mapped:0 shmem:0 pagetables:0
[    1.224098]  sec_pagetables:0 bounce:0
[    1.224098]  kernel_misc_reclaimable:0
[    1.224098]  free:859 free_pcp:0 free_cma:0
[    1.260419] Node 0 active_anon:0kB inactive_anon:0kB active_file:20kB
inactive_file:48kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB
kernel_stack:576kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
[    1.285147] DMA32 free:3436kB boost:0kB min:312kB low:388kB high:464kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:28kB unevictable:0kB writepending:0kB present:8192kB
managed:6240kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    1.310654] lowmem_reserve[]: 0 0 0
[    1.314089] DMA32: 17*4kB (U) 10*8kB (U) 7*16kB (U) 6*32kB (U) 11*64kB
(U) 6*128kB (U) 6*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3460kB
[    1.326883] 33 total pagecache pages
[    1.330420] binfmt_flat: Unable to allocate RAM for process text/data,
errno -12
[    1.337858] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b


-- 
Damien Le Moal
Western Digital Research

