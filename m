Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E47C4332F
	for <openrisc@archiver.kernel.org>; Tue, 15 Nov 2022 04:24:29 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C75F92133D;
	Tue, 15 Nov 2022 05:24:28 +0100 (CET)
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 by mail.librecores.org (Postfix) with ESMTPS id 3B4602126D
 for <openrisc@lists.librecores.org>; Tue, 15 Nov 2022 05:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1668486267; x=1700022267;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zVm/lvO4dFPl37sNuh3RAVrx6/5Q12U80ZVEygDyPZU=;
 b=S1soPFraF50X78QEO1WUcrwOr3jeC+WKTpXOd/c+OMymFCgAoQElcDof
 z8AFO5MBI/DNcHMF5tAy1aY2ktN+hI5TQI5iPv2AN8nk7KiMcBsLY9E7G
 mPHI+bWs7apQwVMk4iC6VOfd1Lws0YZ2vn3FeHC4seG7cWTB0ui49ZvoQ
 Fd+NZspNKNOiBPZl89ElolxuX/uUjLL8qj4izZQ67KWPiyLrFAnrduvjA
 dFHTJWLjrQ8OlYSWhmyk/7y5erMkTZqvPHeDQ2GCd0pJLRY2fsp8yK/6s
 ZWQ6W/r/wFNNkXG5/y4txouiEvlx0Rag1AAeef6turgjeYwhdSPZKE5uo g==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; d="scan'208";a="216282791"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 12:24:25 +0800
IronPort-SDR: fUarDZ8y/8QlM87Wa7FI8+i6Wq2DnGyu/50aogXIEVDsXpWW+vc9XMgrCDjOl7t3+XH2CLBQzM
 z4a4DBXFFoJwQv62G8fSzZeW1AZPk0CaWRKbSsJnpACYMMvW+JzIM/m+Z5MS8JjK96ouy93YiS
 HtgjZAPfdF9sAKsporFGZFpB+KsNlBUnITeNSJDGjDl3lZacdDKPoB1RlBvIlKPvisW0GUeoYq
 Pk2ULFwDIAgBLuxOOdX4tEh8oXvsIJ7ybib/qjCgN2vBNwVkUVyShHkhoiLlyGLz5hsWqk9QEK
 isI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Nov 2022 19:37:38 -0800
IronPort-SDR: b3gxYRCCq7KXRIHdAzoCeC7wvvUuorAvPoWWwo4U1/IvN11j9QvuPZvtwZpwK+XgTDffAqnch3
 5mgDgTvLACuX+bNhw+bOpnmPqoza2BLq1B3UKcwSapzEHvIm8yvAtV7hOi7aL+XXEekmlNh+tf
 EnxmGUoNGxOCemzCPOp+2UI3TakGSzNn5kl2jh2YtBr+ugwrW/3P60pm8ORdSmBs8k6rNB3pGW
 K6q1KL+rpIPLK7RMXh5Gx8RCqXJqlgLddbcDzdfz40+A+fNbBME3K7xGVg0HfRGv6qrOcZWjry
 yOk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Nov 2022 20:24:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBCkJ0hv3z1Rwt8
 for <openrisc@lists.librecores.org>; Mon, 14 Nov 2022 20:24:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1668486262; x=1671078263; bh=zVm/lvO4dFPl37sNuh3RAVrx6/5Q12U80ZV
 EygDyPZU=; b=WqtvvpHWLPg/vKMnqGBIBIHx6gv4pwOCqonb9PyGNwKazfqh2pB
 edaCXfeCNz6KGzKHB5QMDFHKJY0LTc4cERE/GzyhKedFMy0IiRysV8WLrW/3Lj2Y
 gpJMpts4QLe63dZeKG6grn7gzwLBLZttKx62myqYVQBOFKEoTvETPyzTmLRF4CrR
 U5/XRhpO2XxW7saROrEXbgG7bHSh3EmAEoMaPuqA+m4lgnYCrTS8/lMklWDiN1jw
 61uZoCIFOrfn4KSMqY9rRJNSSsCBcutu/OqxDLeoZUCg3yjJeyZm+VNbm2ooOG6B
 +QRWdgs6mofV9iB39FQi79iTF55zLiPEl7g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id UGFkxFhx15by for <openrisc@lists.librecores.org>;
 Mon, 14 Nov 2022 20:24:22 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBCk63pwsz1RvLy;
 Mon, 14 Nov 2022 20:24:14 -0800 (PST)
Message-ID: <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
Date: Tue, 15 Nov 2022 13:24:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y3JU5cfyid1rBoOy@hyeyoo>
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

On 11/14/22 23:47, Hyeonggon Yoo wrote:
> On Mon, Nov 14, 2022 at 08:35:31PM +0900, Damien Le Moal wrote:
>> On 11/14/22 18:36, Vlastimil Babka wrote:
>>> On 11/14/22 06:48, Damien Le Moal wrote:
>>>> On 11/14/22 10:55, Damien Le Moal wrote:
>>>>> On 11/12/22 05:46, Conor Dooley wrote:
>>>>>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>>>>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>>>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>>>>>> two of them do not.
>>>>>>>>>
>>>>>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>>>>>> features), blocking API improvements (more on that below), and my
>>>>>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>>>>>> without resorting to spelling out the letters.
>>>>>>>>>
>>>>>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>>>>>> two to be removed, so I'd like to focus on it first.
>>>>>>>>>
>>>>>>>>> I believe SLOB can be removed because:
>>>>>>>>>
>>>>>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>>>>>> by putting all objects together, which has its CPU performance costs
>>>>>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>>>>>> SLOB impact is too much for those who tried. Googling for
>>>>>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>>>>>
>>>>>>>> I am all for removing SLOB.
>>>>>>>>
>>>>>>>> There are some devices with configs where SLOB is enabled by default.
>>>>>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>>>>>> included into this thread:
>>>>>>>>
>>>>>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>>>>>
>>>>>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>>>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>>>>>
>>>>>>>
>>>>>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>>>>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>>>>>> Only a subset has both SLOB and EXPERT:
>>>>>>>
>>>>>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>>>>>
>>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>>>>>
>>>>>> I suppose there's not really a concern with the virt defconfig, but I
>>>>>> did check the output of `make nommu_k210_defconfig" and despite not
>>>>>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>>>>>
>>>>>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>>>>>> boots etc, but I have no workloads or w/e to run on it.
>>>>>
>>>>> I sent a patch to change the k210 defconfig to using SLUB. However...
>>>
>>> Thanks!
>>>
>>>>> The current default config using SLOB gives about 630 free memory pages
>>>>> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
>>>>> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
>>>
>>> Thanks for the testing! How much RAM does the system have btw? I found 8MB
>>> somewhere, is that correct?
>>
>> Yep, 8MB, that's it.
>>
>>> So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
>>> difference [1]. But that was looking at Slab pages, not free pages. The
>>> extra overhead could be also in percpu allocations, code etc.
>>>
>>>>> This is with a buildroot kernel 5.19 build including a shell and sd-card
>>>>> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
>>>>> definitely see more errors with shell commands failing due to allocation
>>>>> failures for the shell process fork. So as far as the K210 is concerned,
>>>>> switching to SLUB is not ideal.
>>>>>
>>>>> I would not want to hold on kernel mm improvements because of this toy
>>>>> k210 though, so I am not going to prevent SLOB deprecation. I just wish
>>>>> SLUB itself used less memory :)
>>>>
>>>> Did further tests with kernel 6.0.1:
>>>> * SLOB: 630 free pages after boot, shell working (occasional shell fork
>>>> failure happen though)
>>>> * SLAB: getting memory allocation for order 7 failures on boot already
>>>> (init process). Shell barely working (high frequency of shell command fork
>>>> failures)
>>
>> I forgot to add here that the system was down to about 500 free pages
>> after boot (again from the shell with "cat /proc/vmstat").
>>
>>>> * SLUB: getting memory allocation for order 7 failures on boot. I do get a
>>>> shell prompt but cannot run any shell command that involves forking a new
>>>> process.
>>
>> For both slab and slub, I had cpu partial off, debug off and slab merge
>> on, as I suspected that would lead to less memory overhead.
>> I suspected memory fragmentation may be an issue but doing
>>
>> echo 3 > /proc/sys/vm/drop_caches
>>
>> before trying a shell command did not help much at all (it usually does on
>> that board with SLOB). Note that this is all with buildroot, so this echo
>> & redirect always works as it does not cause a shell fork.
>>
>>>>
>>>> So if we want to keep the k210 support functional with a shell, we need
>>>> slob. If we reduce that board support to only one application started as
>>>> the init process, then I guess anything is OK.
>>>
>>> In [1] it was possible to save some more memory with more tuning. Some of
>>> that required boot parameters and other code changes. In another reply [2] I
>>> considered adding something like SLUB_TINY to take care of all that, so
>>> looks like it would make sense to proceed with that.
>>
>> If you want me to test something, let me know.
> 
> Would you try this please?
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a24b71041b26..1c36c4b9aaa0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4367,9 +4367,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	 * The larger the object size is, the more slabs we want on the partial
>  	 * list to avoid pounding the page allocator excessively.
>  	 */
> -	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
> -	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
> -
> +	s->min_partial = 0;
>  	set_cpu_partial(s);
>  
>  #ifdef CONFIG_NUMA
> 
> 
> and booting with and without boot parameter slub_max_order=0?

Test notes: I used Linus 6.1-rc5 as the base. That is the only thing I
changed in buildroot default config for the sipeed maix bit card, booting
with SD card. The test is: booting and run "cat /proc/vmstat" and register
the nr_free_pages value. I repeated the boot + cat 3 to 4 times for each case.

Here are the results:

6.1-rc5, SLOB:
    - 623 free pages
    - 629 free pages
    - 629 free pages
6.1-rc5, SLUB:
    - 448 free pages
    - 448 free pages
    - 429 free pages
6.1-rc5, SLUB + slub_max_order=0:
    - Init error, shell prompt but no shell command working
    - Init error, no shell prompt
    - 508 free pages
    - Init error, shell prompt but no shell command working
6.1-rc5, SLUB + patch:
    - Init error, shell prompt but no shell command working
    - 433 free pages
    - 448 free pages
    - 423 free pages
6.1-rc5, SLUB + slub_max_order=0 + patch:
    - Init error, no shell prompt
    - Init error, shell prompt, 499 free pages
    - Init error, shell prompt but no shell command working
    - Init error, no shell prompt

No changes for SLOB results, expected.

For default SLUB, I did get all clean boots this time and could run the
cat command. But I do see shell fork failures if I keep running commands.

For SLUB + slub_max_order=0, I only got one clean boot with 508 free
pages. Remaining runs failed to give a shell prompt or allow running cat
command. For the clean boot, I do see higher number of free pages.

SLUB with the patch was nearly identical to SLUB without the patch.

And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
could run the cat command only once, giving 499 free pages, so better than
regular SLUB. But it seems that the memory is more fragmented as
allocations fail more often.

Hope this helps. Let me know if you want to test something else.

Cheers.

-- 
Damien Le Moal
Western Digital Research

