Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27828C6FA83
	for <openrisc@archiver.kernel.org>; Wed, 28 Sep 2022 00:24:04 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A5A7C24A61;
	Wed, 28 Sep 2022 02:24:03 +0200 (CEST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by mail.librecores.org (Postfix) with ESMTPS id 8E5EA249CA
 for <openrisc@lists.librecores.org>; Wed, 28 Sep 2022 02:24:02 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id lh5so23915810ejb.10
 for <openrisc@lists.librecores.org>; Tue, 27 Sep 2022 17:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=yrRvoMA2qzsQLaNGkBWV3qKU0u6GXYvGhupTkuY6VEY=;
 b=N4SqAspV6MMkhBYCFIyWw1zoLE0Rd7s2OcFI1DceVn/pHLgQQpIGuPVe/Y5xz2rq7u
 4AwEph2NeuV3pICsTTUzwRekddH0yOeND7JGqULNGiEUieyWRG6v6tDzpLe64Ks46WYl
 +E7aPSySmJM5rrRbU/QTtIuWWnrypBa5Nee0vTcASR26Pbtt3a1rnWEXJiAhZ0LuaF3z
 G0Kpy5TJl/IDsRofANqT6QeQSyO+rxKfvYX1lEVX/uIl1opJ/g6T4wX2v3xFu9sWUBhf
 nxjbUpm/gkJf8RF8BM1xVL9NUSyaLL/yweBBM9Jtss7d1JdDL1D0xSUAW2CB9lb+daDC
 gCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=yrRvoMA2qzsQLaNGkBWV3qKU0u6GXYvGhupTkuY6VEY=;
 b=IaiMv4tJg7HEtNIn9Djy0j/L80vV5Ei0B7dLQt1xKICetBVWtIq1PSuQo4grONDbN5
 x9O1cHou5IopG5qa5eHftC21LB5xOcDxanJStFwXwMuhdLP9ICgGz+KogAMMAJISEPiU
 QPE/WCQAXa9GDIVsjhB3AWxX59fshD7b53CYq8bJ4JtPwmZLyQiEKjzadJYS4pfaaMtW
 rEGMlVys10X5/oQE1SGQd+Cf5rv3FhU/oy8wruQkRAVBD2ytSW+6dKakdlRP/VOcvimF
 60/tF91u07A32aPVvcqgAYoXn3oPsQVYTmgE4OALJjOfHnLgeaNFVMgJa0FR7Z+tDmkK
 18LA==
X-Gm-Message-State: ACrzQf3Pt/r51qtG7l+Vf8eofWC5Cwk/+aQ4zBd3/S+uT3Gcwr0oJLO2
 +cgcKoY2bkzKkGeA9ILT7oPaSUkbevEwjpEV6A0=
X-Google-Smtp-Source: AMsMyM7eMgPelqF9CjnEbxsTqqXy6pmBZpLW9pueVjK2kG6gmJQBXY3G4jO1eBrNDVmQMCspWLB2ar5LjeuRSz4OCpA=
X-Received: by 2002:a17:907:7eaa:b0:782:3d2b:20b0 with SMTP id
 qb42-20020a1709077eaa00b007823d2b20b0mr25078507ejc.746.1664324641882; Tue, 27
 Sep 2022 17:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
 <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
In-Reply-To: <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Sep 2022 13:23:50 +1300
Message-ID: <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To: Yicong Yang <yangyicong@huawei.com>
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
Cc: wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com, realmz6@gmail.com,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 yangyicong@hisilicon.com, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 guojian@oppo.com, linux-riscv@lists.infradead.org, will@kernel.org,
 linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 corbet@lwn.net, x86@kernel.org, Mel Gorman <mgorman@suse.de>,
 linux-mips@vger.kernel.org, arnd@arndb.de,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Barry Song <v-songbaohua@oppo.com>, openrisc@lists.librecores.org,
 darren@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 xhao@linux.alibaba.com, linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>
> On 2022/9/27 14:16, Anshuman Khandual wrote:
> > [...]
> >
> > On 9/21/22 14:13, Yicong Yang wrote:
> >> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >> +{
> >> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
> >> +    if (num_online_cpus() <= 4)
> >
> > It would be great to have some more inputs from others, whether 4 (which should
> > to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> > is optimal for an wide range of arm64 platforms.
> >

I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
with 5,6,7
cores.
I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
this patch.

so it seems safe to have
if (num_online_cpus()  < 8)

>
> Do you prefer this macro to be static or make it configurable through kconfig then
> different platforms can make choice based on their own situations? It maybe hard to
> test on all the arm64 platforms.

Maybe we can have this default enabled on machines with 8 and more cpus and
provide a tlbflush_batched = on or off to allow users enable or
disable it according
to their hardware and products. Similar example: rodata=on or off.

Hi Anshuman, Will,  Catalin, Andrew,
what do you think about this approach?

BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/

I do believe we need it based on the expensive cost of tlb shootdown in arm64
even by hardware broadcast.

>
> Thanks.
>
> >> +            return false;> +
> >> +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
> >> +    if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
> >> +            return false;
> >> +#endif
> >> +
> >> +    return true;
> >> +}
> >> +
> >
> > [...]
> >
> > .
> >

Thanks
Barry
