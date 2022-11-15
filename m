Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA10C4332F
	for <openrisc@archiver.kernel.org>; Tue, 15 Nov 2022 06:44:57 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 339EC2422B;
	Tue, 15 Nov 2022 07:44:56 +0100 (CET)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by mail.librecores.org (Postfix) with ESMTPS id 9E04B240AE
 for <openrisc@lists.librecores.org>; Tue, 15 Nov 2022 07:44:54 +0100 (CET)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xhao@linux.alibaba.com; NM=1; PH=DS; RN=31; SR=0;
 TI=SMTPD_---0VUsFbJs_1668494685; 
Received: from 30.240.98.93(mailfrom:xhao@linux.alibaba.com
 fp:SMTPD_---0VUsFbJs_1668494685) by smtp.aliyun-inc.com;
 Tue, 15 Nov 2022 14:44:48 +0800
Message-ID: <ffdf1eb1-c188-b161-0e70-cad6f64c6c46@linux.alibaba.com>
Date: Tue, 15 Nov 2022 14:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
To: Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 linux-doc@vger.kernel.org
References: <20221115031425.44640-1-yangyicong@huawei.com>
 <20221115031425.44640-2-yangyicong@huawei.com>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20221115031425.44640-2-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: wangkefeng.wang@huawei.com, darren@os.amperecomputing.com,
 peterz@infradead.org, yangyicong@hisilicon.com, punit.agrawal@bytedance.com,
 guojian@oppo.com, linux-riscv@lists.infradead.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net,
 Barry Song <21cnbao@gmail.com>, linux-mips@vger.kernel.org, arnd@arndb.de,
 realmz6@gmail.com, openrisc@lists.librecores.org, prime.zeng@hisilicon.com,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 huzhanyuan@oppo.com, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>


在 2022/11/15 上午11:14, Yicong Yang 写道:
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
> Reviewed-by: Barry Song <baohua@kernel.org>
> Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>
> ---
>   arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
>   mm/rmap.c                       |  9 +--------
>   2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index cda3118f3b27..8a497d902c16 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>   	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
>   }
>   
> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	bool should_defer = false;
> +
> +	/* If remote CPUs need to be flushed then defer batch the flush */
> +	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> +		should_defer = true;
> +	put_cpu();
> +
> +	return should_defer;
> +}
> +
>   static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>   {
>   	/*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2ec925e5fa6a..a9ab10bc0144 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -685,17 +685,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>    */
>   static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>   {
> -	bool should_defer = false;
> -
>   	if (!(flags & TTU_BATCH_FLUSH))
>   		return false;
>   
> -	/* If remote CPUs need to be flushed then defer batch the flush */
> -	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> -		should_defer = true;
> -	put_cpu();
> -
> -	return should_defer;
> +	return arch_tlbbatch_should_defer(mm);
>   }
>   
LGTM, thanks

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
>   /*
