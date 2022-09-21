Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79712C6FA8B
	for <openrisc@archiver.kernel.org>; Wed, 21 Sep 2022 08:54:48 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8427924B16;
	Wed, 21 Sep 2022 10:54:47 +0200 (CEST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by mail.librecores.org (Postfix) with ESMTPS id E59EA24A84
 for <openrisc@lists.librecores.org>; Wed, 21 Sep 2022 10:54:46 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id a26so12062565ejc.4
 for <openrisc@lists.librecores.org>; Wed, 21 Sep 2022 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=sc4HrH+dawwbyFY4jxaPYFax97q7PbwtRdCVIa2eWag=;
 b=nvXLTwTum0Zu+Nzwkb/Va5KR7MpZoNKJUWh0AvWe8HdVcr1Grhklhdo1BZW8sba5fw
 BGnTPKQw9TWdIn1AwbWmhqYPWj/FVYt+uu55rzvSXj7gyQEl6nisi0K/8PiKq+G1vate
 OwUz5f2/PwR248iBS39pCnt+cZvqAUi3xnXwI/CPS+xFuJqBAs2z3QcTEXopA/PS8206
 LsKWiJynHncuR2MFh2DVSwmUKzCR6RXBe0hFSksOj2krERKhpYbj6OOLJgFNJt7NSBQ6
 hVqA13u7w8pzq63oY/Yhzl8fszOLZBKNoD8poD5JuUBZFek7tviVQ4tIq4kb5M10FNKT
 s1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=sc4HrH+dawwbyFY4jxaPYFax97q7PbwtRdCVIa2eWag=;
 b=H/ZVxnfdMNPsKI7d7DFZqaBODmJNF243qnBuRu5caod5MBPgNdxILGXtp1h6msgf0Y
 cPo9j0wyi7B2Gp7D33rSCpDz/wF/YAx1VpMr208DyTIO81yiF10t3mHCNq1Dov4ALqrR
 KIjh10oOm6fqLMny6Zv7Und42JXCv5zTTqt9wSPaFC3SNnbFlP66DrwfB0K30osc+ZrD
 LqMGH+HQQ5Asix7M82e+zHPuDJAOlLD0JNHNKkJAiFSSowe++tVguAcgQlFfG3cou6Wx
 5DeOxBHO2vbvDz20SAPYfH0WQZTBZxvOgGarSNcqoWGv+7vfkUnmcYgxNliP9B4XavYV
 bfvQ==
X-Gm-Message-State: ACrzQf2/mtJlwGLZ2H3TRwkW2siELuId9NAmB31m5PxCPtRa3U1szFrk
 4yM+JflIkyUF5s2ePAuso1wFZ1diprbsqqF5y38=
X-Google-Smtp-Source: AMsMyM5mpmqn+gfhEkasy6u301zqGqQeURhHcxEGpcBIv8VPgxV44BVkZMurDLR6PBxFMgmK/214xxyLA2GRvdonQRQ=
X-Received: by 2002:a17:907:c13:b0:781:d3c2:5015 with SMTP id
 ga19-20020a1709070c1300b00781d3c25015mr4799862ejc.457.1663750486484; Wed, 21
 Sep 2022 01:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-2-yangyicong@huawei.com>
In-Reply-To: <20220921084302.43631-2-yangyicong@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Sep 2022 20:54:35 +1200
Message-ID: <CAGsJ_4ydO=CegfrAF=jYmhOffXd7zKaFp_YxhdMgnoNGA8mBQQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
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
Cc: wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com,
 anshuman.khandual@arm.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, yangyicong@hisilicon.com, linux-mm@kvack.org,
 guojian@oppo.com, linux-riscv@lists.infradead.org, will@kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net, x86@kernel.org,
 linux-mips@vger.kernel.org, arnd@arndb.de, realmz6@gmail.com,
 openrisc@lists.librecores.org, darren@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, xhao@linux.alibaba.com,
 linux-kernel@vger.kernel.org, huzhanyuan@oppo.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Sep 21, 2022 at 8:45 PM Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> The entire scheme of deferred TLB flush in reclaim path rests on the
> fact that the cost to refill TLB entries is less than flushing out
> individual entries by sending IPI to remote CPUs. But architecture
> can have different ways to evaluate that. Hence apart from checking
> TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
> architecture specific.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> [https://lore.kernel.org/linuxppc-dev/20171101101735.2318-2-khandual@linux.vnet.ibm.com/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> [Rebase and fix incorrect return value type]
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

>  arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
>  mm/rmap.c                       |  9 +--------
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index cda3118f3b27..8a497d902c16 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>         flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
>  }
>
> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +       bool should_defer = false;
> +
> +       /* If remote CPUs need to be flushed then defer batch the flush */
> +       if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> +               should_defer = true;
> +       put_cpu();
> +
> +       return should_defer;
> +}
> +
>  static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>  {
>         /*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 93d5a6f793d2..cd8cf5cb0b01 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -690,17 +690,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>   */
>  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>  {
> -       bool should_defer = false;
> -
>         if (!(flags & TTU_BATCH_FLUSH))
>                 return false;
>
> -       /* If remote CPUs need to be flushed then defer batch the flush */
> -       if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> -               should_defer = true;
> -       put_cpu();
> -
> -       return should_defer;
> +       return arch_tlbbatch_should_defer(mm);
>  }
>
>  /*
> --
> 2.24.0
>
