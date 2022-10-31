Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A15C4321E
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:15:26 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B5B4E23CCB;
	Sun,  6 Nov 2022 22:15:24 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mail.librecores.org (Postfix) with ESMTPS id 68F4024A84
 for <openrisc@lists.librecores.org>; Mon, 31 Oct 2022 19:36:53 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id o4so17210440wrq.6
 for <openrisc@lists.librecores.org>; Mon, 31 Oct 2022 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sNqF1x5hFExPPQ1p8H8ZfUJkMN/LytiJFdG0FgSo0Yc=;
 b=Mki3cqNyLb6i/7bDr8xmcRoAI7MKB8Ubep7MvVdCAwvVAv/rvYzaNntbYk7evNSPOx
 iZSZj+1kqC7UTT9hY3p9QxXxVMZ7rRgmk+9DY9r7FhExeFFt1VDbTR9aAf2X+JrZ0tNY
 Tr/US88lDzmERESqdII2j74Xqtc13Nxr3puP6+gFIxszTZcUEQgT950jsRCvi08bhiKR
 jD8ZqkKvxW/CqsLaBVsSxX0va4onlR2A9GDsiypQf+pm99b/Y+UG3WiItOZJ+Li8JVOO
 +Y1i4xOLivYeF+DP4zPejP0GtpVAQoKKHaj+oeUXTWFGo9wGo7aYYFoFnonbrsyfX2Yj
 K6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNqF1x5hFExPPQ1p8H8ZfUJkMN/LytiJFdG0FgSo0Yc=;
 b=J4NEl7nt6x/1kt6k0h9c5gM1gFxNBl9gTloG7elXn2lKuk5v8a/pk9LPzZu9EYAXWz
 F/FzLdZP4/UlQCxQuq/8KDR4xLgcA6cUFJzD8aNj/8F76X/NoXkMmC6y75TSq+cS4Lwi
 +EMGoHPq1yzQ69t7qeiaLkRToDoOTOMx1OC1skXQlaMNGlYWDi+FoPvfWpG3VIEwNK9g
 sONzHyBZSA0xdWjPi4Ho9gUeUHyN1s4SbBkgLh9wE3FDv0cFW+CONCogS0CeDuUL9zEV
 qMuwCUgNFCd28QsCE01uaNJ7F5Fvqqr4qF7X1EtK1VsSk0msEvPIilWUDXhHTNqSoJiz
 0T1Q==
X-Gm-Message-State: ACrzQf31ZOflA7zA3BLCpvyo2je+sarb/k1pY3U3g3MwffYT3c/CKt+t
 0KBSWDM+wKZ55yyH/UuMExf7Fg==
X-Google-Smtp-Source: AMsMyM6L4c0mU3rV7kcQN/uxBci0PgFY6LkbseXn4PqZrB/kcujXoiDFpfGo/UsDapmtxjnBCDkTjg==
X-Received: by 2002:a5d:584e:0:b0:236:6f0f:9d8 with SMTP id
 i14-20020a5d584e000000b002366f0f09d8mr9048660wrf.701.1667241412938; 
 Mon, 31 Oct 2022 11:36:52 -0700 (PDT)
Received: from localhost ([95.148.15.66]) by smtp.gmail.com with ESMTPSA id
 b20-20020a05600c151400b003b3307fb98fsm7781722wmg.24.2022.10.31.11.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 11:36:52 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: Barry Song <21cnbao@gmail.com>
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
 <87bkpw5bzm.fsf@stealth>
 <CAGsJ_4xj2fKLOEHYC46P8ZhUPX8rw=yTNv3Zs=CPxLON6Xxvqw@mail.gmail.com>
Date: Mon, 31 Oct 2022 18:36:51 +0000
In-Reply-To: <CAGsJ_4xj2fKLOEHYC46P8ZhUPX8rw=yTNv3Zs=CPxLON6Xxvqw@mail.gmail.com>
 (Barry Song's message of "Sat, 29 Oct 2022 10:40:11 +1300")
Message-ID: <87zgdb4z7g.fsf@stealth>
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

Barry Song <21cnbao@gmail.com> writes:

> On Sat, Oct 29, 2022 at 2:11 AM Punit Agrawal
> <punit.agrawal@bytedance.com> wrote:
>>
>> Yicong Yang <yangyicong@huawei.com> writes:
>>
>> > On 2022/10/27 22:19, Punit Agrawal wrote:
>> >>
>> >> [ Apologies for chiming in late in the conversation ]
>> >>
>> >> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> >>
>> >>> On 9/28/22 05:53, Barry Song wrote:
>> >>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>> >>>>>
>> >>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>> >>>>>> [...]
>> >>>>>>
>> >>>>>> On 9/21/22 14:13, Yicong Yang wrote:
>> >>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>> >>>>>>> +{
>> >>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>> >>>>>>> +    if (num_online_cpus() <= 4)
>> >>>>>>
>> >>>>>> It would be great to have some more inputs from others, whether 4 (which should
>> >>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>> >>>>>> is optimal for an wide range of arm64 platforms.
>> >>>>>>
>> >>>>
>> >>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>> >>>> with 5,6,7
>> >>>> cores.
>> >>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>> >>>> this patch.
>> >>>>
>> >>>> so it seems safe to have
>> >>>> if (num_online_cpus()  < 8)
>> >>>>
>> >>>>>
>> >>>>> Do you prefer this macro to be static or make it configurable through kconfig then
>> >>>>> different platforms can make choice based on their own situations? It maybe hard to
>> >>>>> test on all the arm64 platforms.
>> >>>>
>> >>>> Maybe we can have this default enabled on machines with 8 and more cpus and
>> >>>> provide a tlbflush_batched = on or off to allow users enable or
>> >>>> disable it according
>> >>>> to their hardware and products. Similar example: rodata=on or off.
>> >>>
>> >>> No, sounds bit excessive. Kernel command line options should not be added
>> >>> for every possible run time switch options.
>> >>>
>> >>>>
>> >>>> Hi Anshuman, Will,  Catalin, Andrew,
>> >>>> what do you think about this approach?
>> >>>>
>> >>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>> >>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>> >>>>
>> >>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>> >>>> even by hardware broadcast.
>> >>>
>> >>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
>> >>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
>> >>
>> >> When running the test program in the commit in a VM, I saw benefits from
>> >> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
>> >> ptep_clear_flush() went from ~1% in the unpatched version to not showing
>> >> up.
>> >>
>> >
>> > Maybe you're booting VM on a server with more than 32 cores and Barry tested
>> > on his 4 CPUs embedded platform. I guess a 4 CPU VM is not fully equivalent to
>> > a 4 CPU real machine as the tbli and dsb in the VM may influence the host
>> > as well.
>>
>> Yeah, I also wondered about this.
>>
>> I was able to test on a 6-core RK3399 based system - there the
>> ptep_clear_flush() was only 0.10% of the overall execution time. The
>> hardware seems to do a pretty good job of keeping the TLB flushing
>> overhead low.

I found a problem with my measurements (missing volatile). Correcting
that increased the overhead somewhat - more below.

> RK3399 has Dual-core ARM Cortex-A72 MPCore processor and
> Quad-core ARM Cortex-A53 MPCore processor. you are probably
> going to see different overhead of ptep_clear_flush() when you
> bind the micro-benchmark on different cores.

Indeed - binding the code on the A53 shows half the overhead from
ptep_clear_flush() compared to the A72.

On the A53 -

    $ perf report --stdio -i perf.vanilla.a53.data | grep ptep_clear_flush
         0.63%  pageout  [kernel.kallsyms]  [k] ptep_clear_flush

On the A72

    $ perf report --stdio -i perf.vanilla.a72.data | grep ptep_clear_flush
         1.34%  pageout  [kernel.kallsyms]      [k] ptep_clear_flush


[...]

