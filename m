Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E48ECAAA1
	for <openrisc@archiver.kernel.org>; Fri,  9 Sep 2022 05:25:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1623024AD4;
	Fri,  9 Sep 2022 07:25:58 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by mail.librecores.org (Postfix) with ESMTPS id B349024A1E
 for <openrisc@lists.librecores.org>; Fri,  9 Sep 2022 07:25:57 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id 29so895932edv.2
 for <openrisc@lists.librecores.org>; Thu, 08 Sep 2022 22:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=cKunQQ0ZtQ4nnTnNWhEV+IwjuR7Legc2WXx2uSMRff4=;
 b=K5NPQOoD2unggSwwL1R9l1FwEM796OlvgFahRNG76jAXm6Fu9iMvOVLWbCimG2ht+T
 LKzy9J/hTCSyCTF/rQrr0bpa2Y9KKyCMWf9MijKRMruE755hBY69pl/f+hD4IS5d+FuO
 k6tS+UWr5kPeids83zMaAoi0kUvkkRYTHPE+EYrET3hBQFXhbJaUNxbinszB5XrleIQg
 PYyk2MrpBbW1FZa9yhZtC0pyxBX+8cbWZRwzJ4JPWiH+uHyU7vTEeQ06A4uCtTqD1bo/
 go0f0JeVm/zjkhF7LI/kCMxxI68r3aApEKLi7PFVol74wzV96P9w1ZZoRLSK0sh81p0I
 a4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=cKunQQ0ZtQ4nnTnNWhEV+IwjuR7Legc2WXx2uSMRff4=;
 b=ibJCdmf3aXoEnEZukVy0tPxB18oodHhjO4QVFvYc6kN4fIOhybrETs0VA+MwTrn6OL
 WDudCgsioUeW5RMlq4lYlNALUJ8DN5BbZhvu+1JfG63XiJvY9/c0liX+c5Qz/dFypuo9
 NAFgr9D//4jbgixk368B0Tvev2TmD58kYHvjpAapW0KUcn0T0UaRVgzjFM6YeZX88y5V
 w2+BrfrYuBFwE8/KYqnrreQJB6dmlg062gAgujIriAX4H4fK6Fri5VYiiFU0EXvOJt50
 FbUi7PPkpN7XItN/yIvsv9BUPkPsIeqPhs4UWmzJGv5TCc64n/016GmCREN9GVxBHwfM
 iZow==
X-Gm-Message-State: ACgBeo0BaaJC2QgSD12llVH0FND1ba87zYIx/8ZLJkQDdLtJ4u1sEgLt
 MOCzdcS1chU4euCgVtfH/31DmUO8VEZL0maWmXc=
X-Google-Smtp-Source: AA6agR7i5YbyJh5uFUq/HewUo3qsQmRLHmO66JkCO6+jFdtZyHpagVWgUZsTDLOc6vdsVMb1Fp03UDprdSw68rIMZbM=
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id
 r7-20020aa7cb87000000b0043be6506036mr10106507edt.350.1662701157430; Thu, 08
 Sep 2022 22:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com>
 <20220822082120.8347-4-yangyicong@huawei.com>
 <b621dbb6-a98f-003e-3578-fc8b0f512d4a@arm.com>
In-Reply-To: <b621dbb6-a98f-003e-3578-fc8b0f512d4a@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 Sep 2022 17:25:46 +1200
Message-ID: <CAGsJ_4wW3FM5WLxYnGnwOn-rnc-3Jz_0Oq89GPqx6Rn6Od0U6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: rmap: Extend tlbbatch APIs to fit new platforms
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
 Dave Hansen <dave.hansen@linux.intel.com>, yangyicong@hisilicon.com,
 linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 "H. Peter Anvin" <hpa@zytor.com>, guojian@oppo.com,
 linux-riscv@lists.infradead.org, will@kernel.org, linux-s390@vger.kernel.org,
 zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 linux-mips@vger.kernel.org, arnd@arndb.de, realmz6@gmail.com,
 Barry Song <v-songbaohua@oppo.com>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, darren@os.amperecomputing.com,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 xhao@linux.alibaba.com, linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
 Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Sep 9, 2022 at 4:51 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 8/22/22 13:51, Yicong Yang wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Add uaddr to tlbbatch APIs so that platforms like ARM64 are
>
> I guess 'uaddr' refers to a virtual address from the process address
> space itself ? Please be more specific.
>
> > able to apply this on their specific hardware features. For
> > ARM64, this could be sending tlbi into hardware queues for
> > the page with this particular uaddr.
>
> This subject line and commit message here are misleading. The patch
> adds an address argument to arch callback arch_tlbbatch_add_mm() as
> arm64 platform could use that to perform the TLB flush batching ?
>
> This patch can be folded into the next one, so that the requirement
> for an additional argument 'uaddr' in the arch callback will be self
> evident. OR if this is going to be a preparatory patch, then it must
> explain how 'uaddr' argument is helpful on platforms like arm64 while
> performing TLB flush batching. But TBH, just folding it to next patch
> explains the context better.

The intention was to keep each change small, while still functionally
independent,
so that it was easier to be reviewed.

but yes, i agree in this particular case, if we fold this one to the
last one, we are
actually able to make the modification self-evident while the new patch seems
still small.

>
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Nadav Amit <namit@vmware.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Tested-by: Xin Hao <xhao@linux.alibaba.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  arch/x86/include/asm/tlbflush.h |  3 ++-
> >  mm/rmap.c                       | 10 ++++++----
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> > index 8a497d902c16..5bd78ae55cd4 100644
> > --- a/arch/x86/include/asm/tlbflush.h
> > +++ b/arch/x86/include/asm/tlbflush.h
> > @@ -264,7 +264,8 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
> >  }
> >
> >  static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> > -                                     struct mm_struct *mm)
> > +                                     struct mm_struct *mm,
> > +                                     unsigned long uaddr)
> >  {
> >       inc_mm_tlb_gen(mm);
> >       cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a17a004550c6..7187a72b63b1 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -642,12 +642,13 @@ void try_to_unmap_flush_dirty(void)
> >  #define TLB_FLUSH_BATCH_PENDING_LARGE                        \
> >       (TLB_FLUSH_BATCH_PENDING_MASK / 2)
> >
> > -static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
> > +static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable,
> > +                                   unsigned long uaddr)
> >  {
> >       struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
> >       int batch, nbatch;
> >
> > -     arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
> > +     arch_tlbbatch_add_mm(&tlb_ubc->arch, mm, uaddr);
> >       tlb_ubc->flush_required = true;
> >
> >       /*
> > @@ -725,7 +726,8 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
> >       }
> >  }
> >  #else
> > -static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
> > +static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable,
> > +                                   unsigned long uaddr)
> >  {
> >  }
> >
> > @@ -1587,7 +1589,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >                                */
> >                               pteval = ptep_get_and_clear(mm, address, pvmw.pte);
> >
> > -                             set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> > +                             set_tlb_ubc_flush_pending(mm, pte_dirty(pteval), address);
> >                       } else {
> >                               pteval = ptep_clear_flush(vma, address, pvmw.pte);
> >                       }

Thanks
Barry
