Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEECCA480
	for <openrisc@archiver.kernel.org>; Thu,  7 Jul 2022 11:45:34 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id AD97A21247;
	Thu,  7 Jul 2022 13:45:33 +0200 (CEST)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by mail.librecores.org (Postfix) with ESMTPS id 98A0421247
 for <openrisc@lists.librecores.org>; Thu,  7 Jul 2022 13:45:31 +0200 (CEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=32; SR=0;
 TI=SMTPD_---0VIcuH0b_1657194323; 
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0VIcuH0b_1657194323) by smtp.aliyun-inc.com;
 Thu, 07 Jul 2022 19:45:25 +0800
Message-ID: <12227412-1d79-4ff6-b4e6-0d438dac7359@linux.alibaba.com>
Date: Thu, 7 Jul 2022 19:45:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] mm: Add kernel PTE level pagetable pages account
To: Matthew Wilcox <willy@infradead.org>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
 <YsWuC9+b3JaEAr0Q@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YsWuC9+b3JaEAr0Q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: x86@kernel.org, loongarch@lists.linux.dev, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, guoren@kernel.org,
 hpa@zytor.com, kernel@xen0n.name, will@kernel.org, jonas@southpole.se,
 aneesh.kumar@linux.ibm.com, chenhuacai@kernel.org, linux-csky@vger.kernel.org,
 rppt@linux.ibm.com, mingo@redhat.com, linux-arch@vger.kernel.org,
 arnd@arndb.de, npiggin@gmail.com, openrisc@lists.librecores.org, bp@alien8.de,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
 akpm@linux-foundation.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>



On 7/6/2022 11:45 PM, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 04:59:17PM +0800, Baolin Wang wrote:
>> Now the kernel PTE level ptes are always protected by mm->page_table_lock
>> instead of split pagetable lock, so the kernel PTE level pagetable pages
>> are not accounted. Especially the vmalloc()/vmap() can consume lots of
>> kernel pagetable, so to get an accurate pagetable accounting, calling new
>> helpers page_{set,clear}_pgtable() when allocating or freeing a kernel
>> PTE level pagetable page.
>>
>> Meanwhile converting architectures to use corresponding generic PTE pagetable
>> allocation and freeing functions.
>>
>> Note this patch only adds accounting to the page tables allocated after boot.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> What does this Reported-by: even mean?  the kernel test robot told you
> that the page tables weren't being accounted?

I fixed an issue reported by this robot. OK, I can remove the tag.

> I don't understand why we want to start accounting kernel page tables.
> an we have a *discussion* about that with a sensible thread name instead
> of just trying to sneak it in as patch 3/3?

I think I have replied to you in below link [1]. The reason is we should 
keep consistent with PMD or PUD pagetable allocation.

[1] 
https://lore.kernel.org/all/68a5286b-7ff3-2c4e-1ab2-305e7860a2f3@linux.alibaba.com/
