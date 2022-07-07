Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9255CCA47F
	for <openrisc@archiver.kernel.org>; Thu,  7 Jul 2022 14:46:56 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 88DC524928;
	Thu,  7 Jul 2022 16:46:55 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by mail.librecores.org (Postfix) with ESMTPS id DA63C2485E
 for <openrisc@lists.librecores.org>; Thu,  7 Jul 2022 16:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657205214; x=1688741214;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KZoOhYr8rZQDf+CrGeMco6Jgl7zOhXbo9W38e2RlFZY=;
 b=LrAbg95x+9zRoKX+49zGvlCv9aiDO1bDSUjH+c+rYiXQDww9I8sl3+kw
 EeE62ouCIQhvJRCCy0gF56A2fXArpi+TRa6+kJWvTtZCtEHMOwL5XW2Da
 SUYzBiEktqgc9ieoIqmali34STuFf17JntIro8C/bNNN67Z4WlLd+357P
 HKUkThtfp1B8AHuZvWNKr6dGO8Vf5ZMxbQpUdhDLNXEq/wdLPKsAu013u
 gWjgQorFgPT/ekQ20DVXAkuQn6bi7BwepDNIo8r0aLPuqdQhiEGX7/R1u
 z9ECtA7eXhwR6jGGyWugna4rWobias8qC82DK8bTFRF0YZeKudvyuBT8X g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285168356"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; d="scan'208";a="285168356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 07:46:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; d="scan'208";a="568544278"
Received: from nmajidi-mobl.amr.corp.intel.com (HELO [10.251.17.238])
 ([10.251.17.238])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 07:46:51 -0700
Message-ID: <8821beda-4d60-4d01-b5c8-1629a19c7f0d@intel.com>
Date: Thu, 7 Jul 2022 07:44:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
 <ef376131-bf5f-7e5b-ea1b-1e8f64a6d060@linux.alibaba.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ef376131-bf5f-7e5b-ea1b-1e8f64a6d060@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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

On 7/7/22 04:32, Baolin Wang wrote:
> On 7/6/2022 11:48 PM, Dave Hansen wrote:
>> On 7/6/22 01:59, Baolin Wang wrote:
>>> Now we will miss to account the PUD level pagetable and kernel PTE level
>>> pagetable, as well as missing to set the PG_table flags for these
>>> pagetable
>>> pages, which will get an inaccurate pagetable accounting, and miss
>>> PageTable() validation in some cases. So this patch set introduces new
>>> helpers to help to account PUD and kernel PTE pagetable pages.
>>
>> Could you explain the motivation for this series a bit more?  Is there a
>> real-world problem that this fixes?
> 
> Not fix real problem. The motivation is that making the pagetable
> accounting more accurate, which helps us to analyse the consumption of
> the pagetable pages in some cases, and maybe help to do some empty
> pagetable reclaiming in future.

This accounting isn't free.  It costs storage (and also parts of
cachelines) in each mm and CPU time to maintain it, plus maintainer
eyeballs to maintain.  PUD pages are also fundamentally (on x86 at
least) 0.0004% of the overhead of PTE and 0.2% of the overhead of PMD
pages unless someone is using gigantic hugetlbfs mappings.

Even with 1G gigantic pages, you would need a quarter of a million
(well, 262144 or 512*512) mappings of one 1G page to consume 1G of
memory on PUD pages.

That just doesn't seem like something anyone is likely to actually do in
practice.  That makes the benefits of the PUD portion of this series
rather unclear in the real world.

As for the kernel page tables, I'm not really aware of them causing any
problems.  We have a pretty good idea how much space they consume from
the DirectMap* entries in meminfo:

	DirectMap4k:     2262720 kB
	DirectMap2M:    40507392 kB
	DirectMap1G:    24117248 kB

as well as our page table debugging infrastructure.  I haven't found
myself dying for more specific info on them.

So, nothing in this series seems like a *BAD* idea, but I'm not sure in
the end it solves more problems than it creates.

