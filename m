Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D942ECAAA1
	for <openrisc@archiver.kernel.org>; Thu, 27 Oct 2022 22:08:15 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 312C124B3B;
	Fri, 28 Oct 2022 00:08:14 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by mail.librecores.org (Postfix) with ESMTPS id 17B4720857
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 00:08:13 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id v27so5253575eda.1
 for <openrisc@lists.librecores.org>; Thu, 27 Oct 2022 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r9RELUveKiUS67KqsZJxwv+GhPKYSZmmNpqGyp3KeL0=;
 b=JfXFlJ4wCnFvi9jr1lx+vzRzL6wNpHsAjP9ImZnD7o4RBGnGK2q+Hkr1AfP8BCQ9Em
 ClHUmPJP2mw+Jv3BwJXHu6/WlG1YnKxhdbpWzIIvAY5/f9Vxpo+eZyR9J2P450gcz8d1
 ZC0/nutQ/zH7Y66UzyXySNTXBIJautFH3rHTDUUKyL6h8tPUGGZe1HOupswJUrG2WXWh
 +9GBIBs7lmr8PJ9X8My5e7ss2akjSuXDKad86M5NIahpuIZGpF+4dt+j5j1ukAM1P/2k
 hXW1Ih6c/LqiyAWoQITdGwfnPwsd65hnISqhXdmzfZ1XLNvFKrTDl6KQGSY4zv9DIe2f
 JDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r9RELUveKiUS67KqsZJxwv+GhPKYSZmmNpqGyp3KeL0=;
 b=5IoopU5aBQgkQhTjSWwxpGa8FH0mhwMd45afzOSFfmmJ2GUGcfDDwCpbZwuWhclKco
 HsOBxoIinL2IlHZaj9Sv+MFH2xPxHAoD/iepik+xGLjQ2LkvzJjLzcqYoXRBIcDN6kdz
 mhCQlhJDEhXE5e/Q7EJ7hWNqheYABWk8edYqfyAKrx8BK3lHG3Yn5LEVT41STIhovTyH
 bu5geAloIZg1s/RQRP5PNSwvpdyibhjumaUp7bnY7uuwcLo4Z7cwlsR6UT2lvfK9Nizn
 3GgGfKq9PX8mZkk92lVpaQXh8q6DSa4nnwbXNJmxupX2HV1/WzokLmMI8xTg235pMDTN
 6cQA==
X-Gm-Message-State: ACrzQf1arcCZ01GtprjCjx3gC+J6TtG5WBCW4mHZk/kjP+U3idZFMTy0
 Z/DpDlsVg6GAllWbPQ2vdjLh7KCuv+FlRWNEI9c=
X-Google-Smtp-Source: AMsMyM7WF/u9jCTtkVgKvkXWMMsUAzTmGbv2jIoDElJSEwL95CQMTNB+W2XiN6KO+oglta/8KUl11BElPtkjS3OhWbc=
X-Received: by 2002:aa7:d80a:0:b0:462:2c1c:8716 with SMTP id
 v10-20020aa7d80a000000b004622c1c8716mr13941343edq.185.1666908492601; Thu, 27
 Oct 2022 15:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
 <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
In-Reply-To: <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 28 Oct 2022 11:07:58 +1300
Message-ID: <CAGsJ_4x0KhEjm5a9jhtS+YK1AT49u3sHnp2rHZVSuTGZp4nKzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To: Anshuman Khandual <anshuman.khandual@arm.com>
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
Cc: wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 yangyicong@hisilicon.com, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 guojian@oppo.com, linux-riscv@lists.infradead.org, will@kernel.org,
 linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 corbet@lwn.net, x86@kernel.org, Mel Gorman <mgorman@suse.de>,
 linux-mips@vger.kernel.org, arnd@arndb.de, realmz6@gmail.com,
 Barry Song <v-songbaohua@oppo.com>, openrisc@lists.librecores.org,
 darren@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 xhao@linux.alibaba.com, linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
 Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Oct 27, 2022 at 11:42 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 9/28/22 05:53, Barry Song wrote:
> > On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
> >>
> >> On 2022/9/27 14:16, Anshuman Khandual wrote:
> >>> [...]
> >>>
> >>> On 9/21/22 14:13, Yicong Yang wrote:
> >>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >>>> +{
> >>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
> >>>> +    if (num_online_cpus() <= 4)
> >>>
> >>> It would be great to have some more inputs from others, whether 4 (which should
> >>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> >>> is optimal for an wide range of arm64 platforms.
> >>>
> >
> > I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
> > with 5,6,7
> > cores.
> > I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
> > this patch.
> >
> > so it seems safe to have
> > if (num_online_cpus()  < 8)
> >
> >>
> >> Do you prefer this macro to be static or make it configurable through kconfig then
> >> different platforms can make choice based on their own situations? It maybe hard to
> >> test on all the arm64 platforms.
> >
> > Maybe we can have this default enabled on machines with 8 and more cpus and
> > provide a tlbflush_batched = on or off to allow users enable or
> > disable it according
> > to their hardware and products. Similar example: rodata=on or off.
>
> No, sounds bit excessive. Kernel command line options should not be added
> for every possible run time switch options.
>
> >
> > Hi Anshuman, Will,  Catalin, Andrew,
> > what do you think about this approach?
> >
> > BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
> > https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
> >
> > I do believe we need it based on the expensive cost of tlb shootdown in arm64
> > even by hardware broadcast.
>
> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?

Sounds good to me. It is a good start to bring up tlb batched flush in
ARM64. Later on, we
might want to see it in both memory reclamation and migration.

Thanks
Barry
