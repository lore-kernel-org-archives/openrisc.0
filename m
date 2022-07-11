Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52194C43334
	for <openrisc@archiver.kernel.org>; Mon, 11 Jul 2022 13:35:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 18A9A246C7;
	Mon, 11 Jul 2022 15:35:12 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mail.librecores.org (Postfix) with ESMTPS id 8D1B120E30
 for <openrisc@lists.librecores.org>; Mon, 11 Jul 2022 15:35:10 +0200 (CEST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhPvr4LMyzkWtj;
 Mon, 11 Jul 2022 21:32:56 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 21:35:05 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 21:35:04 +0800
Message-ID: <13b283fe-10f7-376f-9b8e-856e4d1e0ede@huawei.com>
Date: Mon, 11 Jul 2022 21:35:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/4] mm: rmap: Allow platforms without mm_cpumask to
 defer TLB flush
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, <akpm@linux-foundation.org>,
 <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
 <x86@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <linux-doc@vger.kernel.org>
References: <20220711034615.482895-1-21cnbao@gmail.com>
 <20220711034615.482895-3-21cnbao@gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220711034615.482895-3-21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
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
Cc: linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 arnd@arndb.de, corbet@lwn.net, realmz6@gmail.com, linux-kernel@vger.kernel.org,
 yangyicong@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
 openrisc@lists.librecores.org, darren@os.amperecomputing.com,
 huzhanyuan@oppo.com, guojian@oppo.com, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Barry，

On 2022/7/11 11:46, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
>
> Platforms like ARM64 have hareware TLB shootdown broadcast. They
> don't maintain mm_cpumask but just send tlbi and related sync
> instructions for TLB flush. task's mm_cpumask is normally empty
> in this case. We also allow deferred TLB flush on this kind of
> platforms.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>>
> ---
...
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 169e64192e48..7bf54f57ca01 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -951,6 +951,9 @@ config ARCH_HAS_CURRENT_STACK_POINTER
>   	  register alias named "current_stack_pointer", this config can be
>   	  selected.
>   
> +config ARCH_HAS_MM_CPUMASK
> +	bool
> +
>   config ARCH_HAS_VM_GET_PAGE_PROT
>   	bool
>   
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5bcb334cd6f2..13d4f9a1d4f1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -692,6 +692,10 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>   	if (!(flags & TTU_BATCH_FLUSH))
>   		return false;
>   
> +#ifndef CONFIG_ARCH_HAS_MM_CPUMASK
> +	return true;
> +#endif
> +

Here is another option to enable arch's tlbbatch defer

[1] 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20171101101735.2318-2-khandual@linux.vnet.ibm.com/

>   	/* If remote CPUs need to be flushed then defer batch the flush */
>   	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
>   		should_defer = true;
