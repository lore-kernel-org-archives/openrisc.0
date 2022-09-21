Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966EBECAAD8
	for <openrisc@archiver.kernel.org>; Wed, 21 Sep 2022 08:45:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3656624B2B;
	Wed, 21 Sep 2022 10:45:36 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mail.librecores.org (Postfix) with ESMTPS id 986DC24AAA
 for <openrisc@lists.librecores.org>; Wed, 21 Sep 2022 10:45:34 +0200 (CEST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXX4T0cFqzHpq5;
 Wed, 21 Sep 2022 16:43:21 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:45:30 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 0/2] mm: arm64: bring up BATCHED_UNMAP_TLB_FLUSH
Date: Wed, 21 Sep 2022 16:43:00 +0800
Message-ID: <20220921084302.43631-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
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
Cc: linux-s390@vger.kernel.org, wangkefeng.wang@huawei.com,
 zhangshiming@oppo.com, lipeifeng@oppo.com, prime.zeng@hisilicon.com,
 arnd@arndb.de, corbet@lwn.net, peterz@infradead.org, realmz6@gmail.com,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 yangyicong@hisilicon.com, openrisc@lists.librecores.org,
 xhao@linux.alibaba.com, darren@os.amperecomputing.com, huzhanyuan@oppo.com,
 guojian@oppo.com, linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, anshuman.khandual@arm.com
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Yicong Yang <yangyicong@hisilicon.com>

Though ARM64 has the hardware to do tlb shootdown, the hardware
broadcasting is not free.
A simplest micro benchmark shows even on snapdragon 888 with only
8 cores, the overhead for ptep_clear_flush is huge even for paging
out one page mapped by only one process:
5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush

While pages are mapped by multiple processes or HW has more CPUs,
the cost should become even higher due to the bad scalability of
tlb shootdown.

The same benchmark can result in 16.99% CPU consumption on ARM64
server with around 100 cores according to Yicong's test on patch
4/4.

This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
1. only send tlbi instructions in the first stage -
	arch_tlbbatch_add_mm()
2. wait for the completion of tlbi by dsb while doing tlbbatch
	sync in arch_tlbbatch_flush()
Testing on snapdragon shows the overhead of ptep_clear_flush
is removed by the patchset. The micro benchmark becomes 5% faster
even for one page mapped by single process on snapdragon 888.

-v4:
1. Add tags from Kefeng and Anshuman, Thanks.
2. Limit the TLB batch/defer on systems with >4 CPUs, per Anshuman
3. Merge previous Patch 1,2-3 into one, per Anshuman
Link: https://lore.kernel.org/linux-mm/20220822082120.8347-1-yangyicong@huawei.com/

-v3:
1. Declare arch's tlbbatch defer support by arch_tlbbatch_should_defer() instead
   of ARCH_HAS_MM_CPUMASK, per Barry and Kefeng
2. Add Tested-by from Xin Hao
Link: https://lore.kernel.org/linux-mm/20220711034615.482895-1-21cnbao@gmail.com/

-v2:
1. Collected Yicong's test result on kunpeng920 ARM64 server;
2. Removed the redundant vma parameter in arch_tlbbatch_add_mm()
   according to the comments of Peter Zijlstra and Dave Hansen
3. Added ARCH_HAS_MM_CPUMASK rather than checking if mm_cpumask
   is empty according to the comments of Nadav Amit

Thanks, Peter, Dave and Nadav for your testing or reviewing
, and comments.

-v1:
https://lore.kernel.org/lkml/20220707125242.425242-1-21cnbao@gmail.com/


Anshuman Khandual (1):
  mm/tlbbatch: Introduce arch_tlbbatch_should_defer()

Barry Song (1):
  arm64: support batched/deferred tlb shootdown during page reclamation

 .../features/vm/TLB/arch-support.txt          |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/tlbbatch.h             | 12 ++++++
 arch/arm64/include/asm/tlbflush.h             | 37 ++++++++++++++++++-
 arch/x86/include/asm/tlbflush.h               | 15 +++++++-
 mm/rmap.c                                     | 19 ++++------
 6 files changed, 70 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/tlbbatch.h

-- 
2.24.0

