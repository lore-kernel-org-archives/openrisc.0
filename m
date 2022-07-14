Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B04AC433EF
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:51:59 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C7AD020D93;
	Thu, 14 Jul 2022 06:51:58 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by mail.librecores.org (Postfix) with ESMTPS id 6AEAE20D55
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:51:57 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id eq6so918628edb.6
 for <openrisc@lists.librecores.org>; Wed, 13 Jul 2022 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hW7IbWPmYdn2d1NNnyMMYZo7sUWhfXMc3EeZopJnd9s=;
 b=ixpskF3es1ZmyzgNugOOlVGXEXU01wH8x+O+9c0Hn53VnayTkfg7B02WDNC5tIrO7l
 iEwg3ca5x42mE2uIM8nqQUrXVwXLpT6ULvvEDEhDoQovcbWbHLnoAwOv78ubyxnHhjrc
 b+F58wCwdRfZkdz4PEAGwhDlQaXN17a/dAqjH7lRr9IZR6Oxl15yDJPqx5DZqhd1LDca
 m3K9L9Ce8HJHQ3yTYC00bD8m8HCeZVO9kN8Rn4LXDKPCB1TSqsZxNf0zJQAMyjXyiJ7g
 cpQu1lJzObpQ/9Off5+y4JJmm1YPuTUAuigqbDyhvyv4ipfIih1IQ2OiwKFqjfHfMEIL
 9Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hW7IbWPmYdn2d1NNnyMMYZo7sUWhfXMc3EeZopJnd9s=;
 b=2kmq0upCpTZipgOKBSHZ08xTWhXNPpKRiYpTd2gOK6Kup34IgNVWlhJpeL6NmNAuwp
 StDzenoExEywZD/JCryS4VZGRvNLl1oOTMKEQvt3BaX/25H7wYbSxeINMJ0rH8+Y12AP
 tZ55t9DklJsAlMftnuvTg034O/6hIYqWhgqfnUsDERyDpxfMgllplsXGiZaOKsXmMSpZ
 4FH/04W7mgxsCY/QKTRCTpk7KwagsqRiIYUwtF0HJD6aztEpgIYVmzVMlp6LedvgfE/6
 d7mqoXyEm6hkQ+2ud6QIc3hunQUkfKgd51goeaDJF2KwaH/KHX5gMacLQ8QlkVlh+XjN
 4HQg==
X-Gm-Message-State: AJIora9s4lQ+pyqxlJwguqPytROHNAgg0AtXjS87lNWGbfLLhxLmT8XO
 8SDgBVxst+zW+r5SjfzU7PKbdErI14LwsKkuoaA=
X-Google-Smtp-Source: AGRyM1sCekI8nbaSkEz0wXp62jC4NmfsPr1d7cEeKiuuhPUbnQAKxU8DeX6rgQmQqaqEEOVW9HUjdoQGawmviSj4Nuo=
X-Received: by 2002:aa7:db9a:0:b0:43a:76bf:5401 with SMTP id
 u26-20020aa7db9a000000b0043a76bf5401mr9638511edt.244.1657774317014; Wed, 13
 Jul 2022 21:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220711034615.482895-1-21cnbao@gmail.com>
 <24f5e25b-3946-b92a-975b-c34688005398@linux.alibaba.com>
In-Reply-To: <24f5e25b-3946-b92a-975b-c34688005398@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 14 Jul 2022 16:51:45 +1200
Message-ID: <CAGsJ_4zjnmQV6LT3yo--K-qD-92=hBmgfK121=n-Y0oEFX8RnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mm: arm64: bring up BATCHED_UNMAP_TLB_FLUSH
To: xhao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>, Linux-MM <linux-mm@kvack.org>,
 =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, linux-s390@vger.kernel.org,
 =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= <zhangshiming@oppo.com>,
 =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
 Jonathan Corbet <corbet@lwn.net>, x86 <x86@kernel.org>,
 linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 real mz <realmz6@gmail.com>, openrisc@lists.librecores.org,
 Darren Hart <darren@os.amperecomputing.com>,
 LAK <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, huzhanyuan@oppo.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jul 14, 2022 at 3:29 PM Xin Hao <xhao@linux.alibaba.com> wrote:
>
> Hi barry.
>
> I do some test on Kunpeng arm64 machine use Unixbench.
>
> The test  result as below.
>
> One core, we can see the performance improvement above +30%.

I am really pleased to see the 30%+ improvement on unixbench on single core.

> ./Run -c 1 -i 1 shell1
> w/o
> System Benchmarks Partial Index              BASELINE RESULT INDEX
> Shell Scripts (1 concurrent)                     42.4 5481.0 1292.7
> ========
> System Benchmarks Index Score (Partial Only)                         1292.7
>
> w/
> System Benchmarks Partial Index              BASELINE RESULT INDEX
> Shell Scripts (1 concurrent)                     42.4 6974.6 1645.0
> ========
> System Benchmarks Index Score (Partial Only)                         1645.0
>
>
> But with whole cores, there have little performance degradation above -5%

That is sad as we might get more concurrency between mprotect(), madvise(),
mremap(), zap_pte_range() and the deferred tlbi.

>
> ./Run -c 96 -i 1 shell1
> w/o
> Shell Scripts (1 concurrent)                  80765.5 lpm   (60.0 s, 1
> samples)
> System Benchmarks Partial Index              BASELINE RESULT INDEX
> Shell Scripts (1 concurrent)                     42.4 80765.5 19048.5
> ========
> System Benchmarks Index Score (Partial Only)                        19048.5
>
> w
> Shell Scripts (1 concurrent)                  76333.6 lpm   (60.0 s, 1
> samples)
> System Benchmarks Partial Index              BASELINE RESULT INDEX
> Shell Scripts (1 concurrent)                     42.4 76333.6 18003.2
> ========
> System Benchmarks Index Score (Partial Only)                        18003.2
>
> ----------------------------------------------------------------------------------------------
>
>
> After discuss with you, and do some changes in the patch.
>
> ndex a52381a680db..1ecba81f1277 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -727,7 +727,11 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
>          int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;
>
>          if (pending != flushed) {
> +#ifdef CONFIG_ARCH_HAS_MM_CPUMASK
>                  flush_tlb_mm(mm);
> +#else
> +               dsb(ish);
> +#endif
>

i was guessing the problem might be flush_tlb_batched_pending()
so i asked you to change this to verify my guess.

     /*
>                   * If the new TLB flushing is pending during flushing, leave
>                   * mm->tlb_flush_batched as is, to avoid losing flushing.
>
> there have a performance improvement with whole cores, above +30%

But I don't think it is a proper patch. There is no guarantee the cpu calling
flush_tlb_batched_pending is exactly the cpu sending the deferred
tlbi. so the solution is unsafe. But since this temporary code can bring the
30%+ performance improvement back for high concurrency, we have huge
potential to finally make it.

Unfortunately I don't have an arm64 server to debug on this. I only have
8 cores which are unlikely to reproduce regression which happens in
high concurrency with 96 parallel tasks.

So I'd ask if @yicong or someone else working on kunpeng or other
arm64 servers  is able to actually debug and figure out a proper
patch for this, then add the patch as 5/5 into this series?

>
> ./Run -c 96 -i 1 shell1
> 96 CPUs in system; running 96 parallel copies of tests
>
> Shell Scripts (1 concurrent)                 109229.0 lpm   (60.0 s, 1 samples)
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> Shell Scripts (1 concurrent)                     42.4     109229.0  25761.6
>                                                                     ========
> System Benchmarks Index Score (Partial Only)                        25761.6
>
>
> Tested-by: Xin Hao<xhao@linux.alibaba.com>

Thanks for your testing!

>
> Looking forward to your next version patch.
>
> On 7/11/22 11:46 AM, Barry Song wrote:
> > Though ARM64 has the hardware to do tlb shootdown, the hardware
> > broadcasting is not free.
> > A simplest micro benchmark shows even on snapdragon 888 with only
> > 8 cores, the overhead for ptep_clear_flush is huge even for paging
> > out one page mapped by only one process:
> > 5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
> >
> > While pages are mapped by multiple processes or HW has more CPUs,
> > the cost should become even higher due to the bad scalability of
> > tlb shootdown.
> >
> > The same benchmark can result in 16.99% CPU consumption on ARM64
> > server with around 100 cores according to Yicong's test on patch
> > 4/4.
> >
> > This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
> > 1. only send tlbi instructions in the first stage -
> >       arch_tlbbatch_add_mm()
> > 2. wait for the completion of tlbi by dsb while doing tlbbatch
> >       sync in arch_tlbbatch_flush()
> > My testing on snapdragon shows the overhead of ptep_clear_flush
> > is removed by the patchset. The micro benchmark becomes 5% faster
> > even for one page mapped by single process on snapdragon 888.
> >
> >
> > -v2:
> > 1. Collected Yicong's test result on kunpeng920 ARM64 server;
> > 2. Removed the redundant vma parameter in arch_tlbbatch_add_mm()
> >     according to the comments of Peter Zijlstra and Dave Hansen
> > 3. Added ARCH_HAS_MM_CPUMASK rather than checking if mm_cpumask
> >     is empty according to the comments of Nadav Amit
> >
> > Thanks, Yicong, Peter, Dave and Nadav for your testing or reviewing
> > , and comments.
> >
> > -v1:
> > https://lore.kernel.org/lkml/20220707125242.425242-1-21cnbao@gmail.com/
> >
> > Barry Song (4):
> >    Revert "Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't
> >      apply to ARM64"
> >    mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
> >    mm: rmap: Extend tlbbatch APIs to fit new platforms
> >    arm64: support batched/deferred tlb shootdown during page reclamation
> >
> >   Documentation/features/arch-support.txt       |  1 -
> >   .../features/vm/TLB/arch-support.txt          |  2 +-
> >   arch/arm/Kconfig                              |  1 +
> >   arch/arm64/Kconfig                            |  1 +
> >   arch/arm64/include/asm/tlbbatch.h             | 12 ++++++++++
> >   arch/arm64/include/asm/tlbflush.h             | 23 +++++++++++++++++--
> >   arch/loongarch/Kconfig                        |  1 +
> >   arch/mips/Kconfig                             |  1 +
> >   arch/openrisc/Kconfig                         |  1 +
> >   arch/powerpc/Kconfig                          |  1 +
> >   arch/riscv/Kconfig                            |  1 +
> >   arch/s390/Kconfig                             |  1 +
> >   arch/um/Kconfig                               |  1 +
> >   arch/x86/Kconfig                              |  1 +
> >   arch/x86/include/asm/tlbflush.h               |  3 ++-
> >   mm/Kconfig                                    |  3 +++
> >   mm/rmap.c                                     | 14 +++++++----
> >   17 files changed, 59 insertions(+), 9 deletions(-)
> >   create mode 100644 arch/arm64/include/asm/tlbbatch.h
> >
> --
> Best Regards!
> Xin Hao
>

Thanks
Barry
