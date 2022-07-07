Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7ABC43334
	for <openrisc@archiver.kernel.org>; Thu,  7 Jul 2022 11:32:53 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 96A1D246C7;
	Thu,  7 Jul 2022 13:32:52 +0200 (CEST)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by mail.librecores.org (Postfix) with ESMTPS id D673B2133D
 for <openrisc@lists.librecores.org>; Thu,  7 Jul 2022 13:32:50 +0200 (CEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=33; SR=0;
 TI=SMTPD_---0VIdIQWG_1657193558; 
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0VIdIQWG_1657193558) by smtp.aliyun-inc.com;
 Thu, 07 Jul 2022 19:32:40 +0800
Message-ID: <ef376131-bf5f-7e5b-ea1b-1e8f64a6d060@linux.alibaba.com>
Date: Thu, 7 Jul 2022 19:32:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
To: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
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
 linux-csky@vger.kernel.org, hpa@zytor.com, kernel@xen0n.name, will@kernel.org,
 tglx@linutronix.de, jonas@southpole.se, aneesh.kumar@linux.ibm.com,
 chenhuacai@kernel.org, willy@infradead.org, rppt@linux.ibm.com,
 mingo@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de, npiggin@gmail.com,
 openrisc@lists.librecores.org, bp@alien8.de, luto@kernel.org,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tsbogend@alpha.franken.de, linux-mips@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>



On 7/6/2022 11:48 PM, Dave Hansen wrote:
> On 7/6/22 01:59, Baolin Wang wrote:
>> Now we will miss to account the PUD level pagetable and kernel PTE level
>> pagetable, as well as missing to set the PG_table flags for these pagetable
>> pages, which will get an inaccurate pagetable accounting, and miss
>> PageTable() validation in some cases. So this patch set introduces new
>> helpers to help to account PUD and kernel PTE pagetable pages.
> 
> Could you explain the motivation for this series a bit more?  Is there a
> real-world problem that this fixes?

Not fix real problem. The motivation is that making the pagetable 
accounting more accurate, which helps us to analyse the consumption of 
the pagetable pages in some cases, and maybe help to do some empty 
pagetable reclaiming in future.
