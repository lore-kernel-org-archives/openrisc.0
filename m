Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0209AC43334
	for <openrisc@archiver.kernel.org>; Sun, 10 Jul 2022 11:20:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id BE94824807;
	Sun, 10 Jul 2022 13:20:12 +0200 (CEST)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by mail.librecores.org (Postfix) with ESMTPS id 983FC213CC
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 13:20:10 +0200 (CEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=33; SR=0;
 TI=SMTPD_---0VIrBUyv_1657451992; 
Received: from 30.39.247.23(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0VIrBUyv_1657451992) by smtp.aliyun-inc.com;
 Sun, 10 Jul 2022 19:19:54 +0800
Message-ID: <7628e9a7-8e2d-dcfb-09e5-27de36da5af7@linux.alibaba.com>
Date: Sun, 10 Jul 2022 19:19:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
To: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
 <ef376131-bf5f-7e5b-ea1b-1e8f64a6d060@linux.alibaba.com>
 <8821beda-4d60-4d01-b5c8-1629a19c7f0d@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8821beda-4d60-4d01-b5c8-1629a19c7f0d@intel.com>
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
Cc: x86@kernel.org, loongarch@lists.linux.dev, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, guoren@kernel.org,
 linux-csky@vger.kernel.org, hpa@zytor.com, kernel@xen0n.name, will@kernel.org,
 tglx@linutronix.de, jonas@southpole.se, aneesh.kumar@linux.ibm.com,
 chenhuacai@kernel.org, willy@infradead.org, rppt@linux.ibm.com,
 mingo@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de, npiggin@gmail.com,
 openrisc@lists.librecores.org, bp@alien8.de, luto@kernel.org,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tsbogend@alpha.franken.de, linux-mips@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>



On 7/7/2022 10:44 PM, Dave Hansen wrote:
> On 7/7/22 04:32, Baolin Wang wrote:
>> On 7/6/2022 11:48 PM, Dave Hansen wrote:
>>> On 7/6/22 01:59, Baolin Wang wrote:
>>>> Now we will miss to account the PUD level pagetable and kernel PTE level
>>>> pagetable, as well as missing to set the PG_table flags for these
>>>> pagetable
>>>> pages, which will get an inaccurate pagetable accounting, and miss
>>>> PageTable() validation in some cases. So this patch set introduces new
>>>> helpers to help to account PUD and kernel PTE pagetable pages.
>>>
>>> Could you explain the motivation for this series a bit more?  Is there a
>>> real-world problem that this fixes?
>>
>> Not fix real problem. The motivation is that making the pagetable
>> accounting more accurate, which helps us to analyse the consumption of
>> the pagetable pages in some cases, and maybe help to do some empty
>> pagetable reclaiming in future.
> 
> This accounting isn't free.  It costs storage (and also parts of
> cachelines) in each mm and CPU time to maintain it, plus maintainer
> eyeballs to maintain.  PUD pages are also fundamentally (on x86 at
> least) 0.0004% of the overhead of PTE and 0.2% of the overhead of PMD
> pages unless someone is using gigantic hugetlbfs mappings.

Yes, agree. However I think the performence influence of this patch is 
small from some testing I did (like mysql, no obvious performance 
influence). Moreover the pagetable accounting gap is about 1% from below 
testing data.

Without this patchset, the pagetable consumption is about 110M with 
mysql testing.
              flags      page-count       MB  symbolic-flags 
          long-symbolic-flags
0x0000000004000000           28232      110 
__________________________g__________________      pgtable

With this patchset, and the consumption is about 111M.
              flags      page-count       MB  symbolic-flags 
          long-symbolic-flags
0x0000000004000000           28459      111 
__________________________g__________________      pgtable


> Even with 1G gigantic pages, you would need a quarter of a million
> (well, 262144 or 512*512) mappings of one 1G page to consume 1G of
> memory on PUD pages.
> 
> That just doesn't seem like something anyone is likely to actually do in
> practice.  That makes the benefits of the PUD portion of this series
> rather unclear in the real world.
> 
> As for the kernel page tables, I'm not really aware of them causing any
> problems.  We have a pretty good idea how much space they consume from
> the DirectMap* entries in meminfo:
> 
> 	DirectMap4k:     2262720 kB
> 	DirectMap2M:    40507392 kB
> 	DirectMap1G:    24117248 kB

However these statistics are arch-specific information, which only 
available on x86, s390 and powerpc.

> as well as our page table debugging infrastructure.  I haven't found
> myself dying for more specific info on them.
> 
> So, nothing in this series seems like a *BAD* idea, but I'm not sure in
> the end it solves more problems than it creates.

Thanks for your input.
