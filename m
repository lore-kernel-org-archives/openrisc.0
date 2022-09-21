Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FBAC32771
	for <openrisc@archiver.kernel.org>; Wed, 21 Sep 2022 07:15:24 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4D6B024B16;
	Wed, 21 Sep 2022 09:15:23 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mail.librecores.org (Postfix) with ESMTPS id BD92224AAA
 for <openrisc@lists.librecores.org>; Wed, 21 Sep 2022 09:15:22 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id z13so7204587edb.13
 for <openrisc@lists.librecores.org>; Wed, 21 Sep 2022 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=z9jXMKTsbXt/GY48g/wdOYArfXNGBa3cbn0t4HSGf7c=;
 b=UiTMai2YO907oZTmL2uRRBUvQZje672mf6EbZ9LgXUMIQqDtJoEU89YEJ98C1iKFq6
 6aeo1LqTpUmEdFw2CaSaL28YZg63X9PaAExd1UpR0MksLPUasxQTMUS69mrLKvm0i5tk
 e+hFnF/9spxfT0XRQ4XHRAw+QOtJoML5Vz1O2F4ZVoDwC/N5QPHI623PCIhl5qf2Uzs6
 VtL7p6OurNamkmgIdL4rb5sRfKwpRieDiY2ZiC2WZG4mXXiBevFcf0mmEL8JqIYWdM6i
 PRQdgQ5j9YvBGXmjMfUP4G3iqVPZJBS27lF04is8Z5yupn+hVJQtVn2lVCtMTZdQPasZ
 8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=z9jXMKTsbXt/GY48g/wdOYArfXNGBa3cbn0t4HSGf7c=;
 b=48v/uGawJps8kA1o884/4ATOonD7jUVRACOIxwAe5z1yigdzPkzXS0mFW2gmAFSYY0
 8Jifnv8+/XEmaEfT3N3AB3QjFqBzv5Clc4ipoTs5NmDDiT+8BxLsm9jJ0Cykau3LUb1d
 g57WQVJCphssQ/Y5pkJ9wb5q1t2NIiTukzA/T7ZMCLH/1HEiPUUrf5WAbO4oFYzXPJQw
 Vd9L3wShSEjNpDf9ECZg2ihaDXjSW3woruVRlIsS//pzj8aGH7hNgEBH47sIQVmKDtri
 msCVjwTxvgPosqZquhDIOiqtQA9ScYYP4SoRRgRA4Ut/6vJ16TlodPFaa+XZEZMGP11v
 9Apw==
X-Gm-Message-State: ACrzQf2lyusHofJSNFiAWkk0CZONpHuDdRGyOgKKnN0l0JeKxyVmHqzn
 V/dGDEsVWlu12mpqz6TQ/QFDxa97k7+PzDi87tY=
X-Google-Smtp-Source: AMsMyM55Ybm0ogt2YynX5Ic5pid72Oh9X7U20E3TfVabrhaJXkQZyVhJOQK1a/CYV33WISOGkFZPMdCY+LA22ybkLZI=
X-Received: by 2002:a05:6402:1e8d:b0:441:58db:b6a2 with SMTP id
 f13-20020a0564021e8d00b0044158dbb6a2mr22952604edf.277.1663744522301; Wed, 21
 Sep 2022 00:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com>
 <20220822082120.8347-5-yangyicong@huawei.com>
 <888da5f3-104c-3929-c21e-c710922d6f1e@arm.com>
In-Reply-To: <888da5f3-104c-3929-c21e-c710922d6f1e@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Sep 2022 19:15:10 +1200
Message-ID: <CAGsJ_4wtkSfH2DTDg10qTbUkxD1QTNBD09nx_H+S6H_-tBPQBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
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

On Wed, Sep 21, 2022 at 6:53 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 8/22/22 13:51, Yicong Yang wrote:
> > +static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> > +                                     struct mm_struct *mm,
> > +                                     unsigned long uaddr)
> > +{
> > +     __flush_tlb_page_nosync(mm, uaddr);
> > +}
> > +
> > +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > +{
> > +     dsb(ish);
> > +}
>
> Just wondering if arch_tlbbatch_add_mm() could also detect continuous mapping
> TLB invalidation requests on a given mm and try to generate a range based TLB
> invalidation such as flush_tlb_range().
>
> struct arch_tlbflush_unmap_batch via task->tlb_ubc->arch can track continuous
> ranges while being queued up via arch_tlbbatch_add_mm(), any range formed can
> later be flushed in subsequent arch_tlbbatch_flush() ?
>
> OR
>
> It might not be worth the effort and complexity, in comparison to performance
> improvement, TLB range flush brings in ?

Probably it is not worth the complexity as perf annotate shows
"
Further perf annonate shows 95% cpu time of ptep_clear_flush
is actually used by the final dsb() to wait for the completion
of tlb flush."

so any further optimization before dsb(ish) might bring some improvement
but seems minor.

Thanks
Barry
