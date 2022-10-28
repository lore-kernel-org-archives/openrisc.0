Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CBDC43217
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:15:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 36CF321156;
	Sun,  6 Nov 2022 22:15:24 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mail.librecores.org (Postfix) with ESMTPS id 960AB24A5D
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 15:12:51 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id j15so6564541wrq.3
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o3XkdRF1alR2hBxhKv7+KC2xEVL/mNE1pCUslh91CNk=;
 b=czSDanOWkaznNFvfzkhI+RldJ79y0lOKTXLazE2INVObzdIpuA02fnxmTp4HXTRQTi
 IvuTylcXIq/Sg1jCgh9FzcPYK6wCnCgisN2SPpD2hY2iM3U6UJQJMLePIaRYzRfU+2Wh
 y9qb6oEWb7kSxsaXWIlY4Dkr2UM2TLk7qXYPH5mBMLvwd3vtyLYpmiqZDG3Zxj0+CARd
 L8/aJqqA6LprQ5Pk4/015K7SAUBuZTJBf3EKbWQG93N7hmK53CJDPw0U9whLdkPu5vWz
 3ELADVGMWSrtaYcGW48cTX8dbadiAO+awqSfgOoWpeoUTHQ8/pHHrLwFT/4AdLUkI1S8
 O7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3XkdRF1alR2hBxhKv7+KC2xEVL/mNE1pCUslh91CNk=;
 b=vaQKDw3duEugd7/eYlMAnzcHWSOBbuCMdSJchmAm8tbzsFoOwo4gnW1ENIIxXbk7bj
 DnJpTXh6ay7r/RaRgvmnVKbWLQt7mEnmvBNm7TDc1keJ3Q4WjVo0f+puohZTUJZn5zFq
 yq/4C/JOqv4QKL/XIovA1pRdt81plkN7lNKX0AwmdOlgwQI8XU7J5qlXDAqnd9GFbmle
 Beu0DZYPrX6dlDSKtQqyJ0yaoX9yZ23VhUtKO2J2OGZlScuy7fFj7OGOvGQNZGV0h8XU
 mXkyZjsKgD9u1FRCj+ZmUFqKSH+nODPzXDwqsE56+ueQyStbLte5EUQXVT3d8sfgBmb2
 d6XQ==
X-Gm-Message-State: ACrzQf3IC7qGmuCeiDkrit8jeR0JZH6ZV1zROvAmSE7UkFU203UoxDUa
 HQtwF9TTiHD5m2sZ9cmGFQfM9w==
X-Google-Smtp-Source: AMsMyM6F7+GscrQBfN0kqw1I2NMyhLF2BzgPRHQOCPO+qKjjp7P6MaY7wew3G5OT+7MX9xpYkZlRUQ==
X-Received: by 2002:a05:6000:18c7:b0:22e:5503:9c46 with SMTP id
 w7-20020a05600018c700b0022e55039c46mr33561930wrq.668.1666962771104; 
 Fri, 28 Oct 2022 06:12:51 -0700 (PDT)
Received: from localhost ([95.148.15.66]) by smtp.gmail.com with ESMTPSA id
 n17-20020a05600c501100b003b4fdbb6319sm5926108wmr.21.2022.10.28.06.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Oct 2022 06:12:50 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
 <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
 <87o7tx5oyx.fsf@stealth>
 <CAGsJ_4zrGfPYAXGW0g3Z-GF4vT7GD0xDjZn1dv-qruztEQTghg@mail.gmail.com>
 <8a3ade4c-1714-5ffd-ed57-02ab0509725b@arm.com>
Date: Fri, 28 Oct 2022 14:12:49 +0100
In-Reply-To: <8a3ade4c-1714-5ffd-ed57-02ab0509725b@arm.com> (Anshuman
 Khandual's message of "Fri, 28 Oct 2022 07:44:29 +0530")
Message-ID: <877d0k5bxq.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 06 Nov 2022 22:15:22 +0100
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
Cc: wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 yangyicong@hisilicon.com, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 guojian@oppo.com, linux-riscv@lists.infradead.org, will@kernel.org,
 linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 corbet@lwn.net, x86@kernel.org, Barry Song <21cnbao@gmail.com>,
 Mel Gorman <mgorman@suse.de>, linux-mips@vger.kernel.org, arnd@arndb.de,
 realmz6@gmail.com, Barry Song <v-songbaohua@oppo.com>,
 openrisc@lists.librecores.org, darren@os.amperecomputing.com,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, xhao@linux.alibaba.com,
 linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
 Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 10/28/22 03:25, Barry Song wrote:
>> On Fri, Oct 28, 2022 at 3:19 AM Punit Agrawal
>> <punit.agrawal@bytedance.com> wrote:
>>>
>>> [ Apologies for chiming in late in the conversation ]
>>>
>>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>>>
>>>> On 9/28/22 05:53, Barry Song wrote:
>>>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>> On 9/21/22 14:13, Yicong Yang wrote:
>>>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>>>>> +{
>>>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>>>>>>>> +    if (num_online_cpus() <= 4)
>>>>>>> It would be great to have some more inputs from others, whether 4 (which should
>>>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>>>>>>> is optimal for an wide range of arm64 platforms.
>>>>>>>
>>>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>>>>> with 5,6,7
>>>>> cores.
>>>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>>>>> this patch.
>>>>>
>>>>> so it seems safe to have
>>>>> if (num_online_cpus()  < 8)
>>>>>
>>>>>> Do you prefer this macro to be static or make it configurable through kconfig then
>>>>>> different platforms can make choice based on their own situations? It maybe hard to
>>>>>> test on all the arm64 platforms.
>>>>> Maybe we can have this default enabled on machines with 8 and more cpus and
>>>>> provide a tlbflush_batched = on or off to allow users enable or
>>>>> disable it according
>>>>> to their hardware and products. Similar example: rodata=on or off.
>>>> No, sounds bit excessive. Kernel command line options should not be added
>>>> for every possible run time switch options.
>>>>
>>>>> Hi Anshuman, Will,  Catalin, Andrew,
>>>>> what do you think about this approach?
>>>>>
>>>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>>>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>>>>>
>>>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>>>>> even by hardware broadcast.
>>>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
>>>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
>>> When running the test program in the commit in a VM, I saw benefits from
>>> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
>>> ptep_clear_flush() went from ~1% in the unpatched version to not showing
>>> up.
>>>
>>> Yicong mentioned that he didn't see any benefit for <= 4 CPUs but is
>>> there any overhead? I am wondering what are the downsides of enabling
>>> the config by default.
>> As we are deferring tlb flush, but sometimes while we are modifying the vma
>> which are deferred, we need to do a sync by flush_tlb_batched_pending() in
>> mprotect() , madvise() to make sure they can see the flushed result. if nobody
>> is doing mprotect(), madvise() etc in the deferred period, the overhead is zero.
>
> Right, it is difficult to justify this overhead for smaller systems,
> which for sure would not benefit from this batched TLB framework.

Thank you for the pointers to the overhead.

Having looked at this more closely, I also see that
flush_tlb_batched_pending() discards the entire mm vs just flushing the
page being unmapped (as is done with ptep_clear_flush()).
