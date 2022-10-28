Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09710C433FE
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:15:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id AEDC9211B0;
	Sun,  6 Nov 2022 22:15:23 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mail.librecores.org (Postfix) with ESMTPS id 051C820ADE
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 15:11:45 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id o4so6542381wrq.6
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Aj7lCoa9R32lr+KR5EAOPwdoRP9ej39sPKRFvXXmKo=;
 b=EFIo+tctRNuBHWwWw1xOq1kEixfm3foZR690FRJu3AM3x8PYD0ZDLFys0bq0GHDw0q
 D+MTVPyEG1mTG0ZgdOgJq8+gjfvXKbovWD8hGjcbI7wWrksCjPBNiTntRvERjSr3G2+k
 Lu7JNnRQmZ6+8v+2wFsOY4k1EMCtFfmzGGyaZDJW+zI6dotPwQ2SHNssHmq5yH6XrLvw
 xSqtVUxuIWlv47NuYTEMe31KwKyXtoj47d/WfUsTDmeHSsavPPN1aNy232z2FiDj7IE2
 kdVuMjIFXr8rqIXxZZe02eKvfiUGYKO5h8nAQjogNLBpf+5ZCJOnzUUb++YTPAQ3vG+E
 aVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Aj7lCoa9R32lr+KR5EAOPwdoRP9ej39sPKRFvXXmKo=;
 b=j4Z1HHBAYMt1g46ryxG4rT3gnSz/igPUL9GZt/4gtdat+pqjlyWn2QJliq+bNZP3E8
 w92F9TKkCs8RHD3o5EDHELPOT9WqFiNPoklAzFm2VOetLWxKCNTPPXVa18Et5R2a6uwk
 oh5qpxElPqEMT3uc9eBwGqGikjymSsW84AbbbS4N6vMjiswBgZbyFLJIp2USB0i2f7yr
 arfucGDvVNZ600+ZaRV5AlVdV0avexpQxtl4ES9hvZIxo94YjBi6dH0JoBHdBJO5ltMj
 5FI96F4tAQ9rgJklRup2gveXlsMv1v2z2O7dJm61oBhc+vljAnVMenC8ogWrkMayHoaC
 7/dg==
X-Gm-Message-State: ACrzQf1DrMelmHFTNQ/8bpZkNVkfGWkYrYvOgMOK4YI1zzp5Nm2CzBZm
 y6Xhwicn/7yK3uJvTLo5p4hjMw==
X-Google-Smtp-Source: AMsMyM6YDLGx8tddVpugpJgNDAZlKMyecbRnjlokKyPGo/AAsO2SU74UqqxLLYtDEOG4bOxEAgjUZA==
X-Received: by 2002:adf:df83:0:b0:236:6d5d:ff8b with SMTP id
 z3-20020adfdf83000000b002366d5dff8bmr18336437wrl.315.1666962704559; 
 Fri, 28 Oct 2022 06:11:44 -0700 (PDT)
Received: from localhost ([95.148.15.66]) by smtp.gmail.com with ESMTPSA id
 k21-20020a05600c1c9500b003bfaba19a8fsm4641180wms.35.2022.10.28.06.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Oct 2022 06:11:43 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: Yicong Yang <yangyicong@huawei.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
 <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
 <87o7tx5oyx.fsf@stealth>
 <bc44cf85-aee9-03ca-9911-dbd904a43cc8@huawei.com>
Date: Fri, 28 Oct 2022 14:11:41 +0100
In-Reply-To: <bc44cf85-aee9-03ca-9911-dbd904a43cc8@huawei.com> (Yicong Yang's
 message of "Fri, 28 Oct 2022 09:20:08 +0800")
Message-ID: <87bkpw5bzm.fsf@stealth>
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
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-doc@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, yangyicong@hisilicon.com,
 linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, guojian@oppo.com,
 linux-riscv@lists.infradead.org, will@kernel.org, linux-s390@vger.kernel.org,
 zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net, x86@kernel.org,
 Barry Song <21cnbao@gmail.com>, Mel Gorman <mgorman@suse.de>,
 linux-mips@vger.kernel.org, arnd@arndb.de, realmz6@gmail.com,
 Barry Song <v-songbaohua@oppo.com>, openrisc@lists.librecores.org,
 darren@os.amperecomputing.com, Punit Agrawal <punit.agrawal@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, xhao@linux.alibaba.com,
 linux-kernel@vger.kernel.org, huzhanyuan@oppo.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Yicong Yang <yangyicong@huawei.com> writes:

> On 2022/10/27 22:19, Punit Agrawal wrote:
>> 
>> [ Apologies for chiming in late in the conversation ]
>> 
>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> 
>>> On 9/28/22 05:53, Barry Song wrote:
>>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>>
>>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>>>>>> [...]
>>>>>>
>>>>>> On 9/21/22 14:13, Yicong Yang wrote:
>>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>>>> +{
>>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>>>>>>> +    if (num_online_cpus() <= 4)
>>>>>>
>>>>>> It would be great to have some more inputs from others, whether 4 (which should
>>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>>>>>> is optimal for an wide range of arm64 platforms.
>>>>>>
>>>>
>>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>>>> with 5,6,7
>>>> cores.
>>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>>>> this patch.
>>>>
>>>> so it seems safe to have
>>>> if (num_online_cpus()  < 8)
>>>>
>>>>>
>>>>> Do you prefer this macro to be static or make it configurable through kconfig then
>>>>> different platforms can make choice based on their own situations? It maybe hard to
>>>>> test on all the arm64 platforms.
>>>>
>>>> Maybe we can have this default enabled on machines with 8 and more cpus and
>>>> provide a tlbflush_batched = on or off to allow users enable or
>>>> disable it according
>>>> to their hardware and products. Similar example: rodata=on or off.
>>>
>>> No, sounds bit excessive. Kernel command line options should not be added
>>> for every possible run time switch options.
>>>
>>>>
>>>> Hi Anshuman, Will,  Catalin, Andrew,
>>>> what do you think about this approach?
>>>>
>>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>>>>
>>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>>>> even by hardware broadcast.
>>>
>>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
>>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
>> 
>> When running the test program in the commit in a VM, I saw benefits from
>> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
>> ptep_clear_flush() went from ~1% in the unpatched version to not showing
>> up.
>> 
>
> Maybe you're booting VM on a server with more than 32 cores and Barry tested
> on his 4 CPUs embedded platform. I guess a 4 CPU VM is not fully equivalent to
> a 4 CPU real machine as the tbli and dsb in the VM may influence the host
> as well.

Yeah, I also wondered about this.

I was able to test on a 6-core RK3399 based system - there the
ptep_clear_flush() was only 0.10% of the overall execution time. The
hardware seems to do a pretty good job of keeping the TLB flushing
overhead low.

[...]

