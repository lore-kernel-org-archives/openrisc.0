Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06CCCA480
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 08:59:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DA9A8240F3;
	Wed,  6 Jul 2022 10:59:36 +0200 (CEST)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by mail.librecores.org (Postfix) with ESMTPS id 7BEED248C7
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 10:59:34 +0200 (CEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=33; SR=0;
 TI=SMTPD_---0VIXd7j9_1657097961; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0VIXd7j9_1657097961) by smtp.aliyun-inc.com;
 Wed, 06 Jul 2022 16:59:22 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Subject: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
Date: Wed,  6 Jul 2022 16:59:14 +0800
Message-Id: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: x86@kernel.org, baolin.wang@linux.alibaba.com, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, guoren@kernel.org,
 linux-csky@vger.kernel.org, hpa@zytor.com, kernel@xen0n.name, will@kernel.org,
 tglx@linutronix.de, jonas@southpole.se, aneesh.kumar@linux.ibm.com,
 chenhuacai@kernel.org, willy@infradead.org, rppt@linux.ibm.com,
 mingo@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de, npiggin@gmail.com,
 loongarch@lists.linux.dev, openrisc@lists.librecores.org, bp@alien8.de,
 luto@kernel.org, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tsbogend@alpha.franken.de, linux-mips@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi,

Now we will miss to account the PUD level pagetable and kernel PTE level
pagetable, as well as missing to set the PG_table flags for these pagetable
pages, which will get an inaccurate pagetable accounting, and miss
PageTable() validation in some cases. So this patch set introduces new
helpers to help to account PUD and kernel PTE pagetable pages.

Note there are still some architectures specific pagetable allocation
that need to account the pagetable pages, which need more investigation
and cleanup in future.

Changes from RFC v3:
 - Rebased on 20220706 linux-next.
 - Introduce new pgtable_pud_page_ctor/dtor() and rename the helpers.
 - Change back to use inc_lruvec_page_state()/dec_lruvec_page_state().
 - Update some commit message.
link: https://lore.kernel.org/all/cover.1656586863.git.baolin.wang@linux.alibaba.com/

Changes from RFC v2:
 - Convert to use mod_lruvec_page_state() for non-order-0 case.
 - Rename the helpers.
 - Update some commit messages.
 - Remove unnecessary __GFP_HIGHMEM clear.
link: https://lore.kernel.org/all/cover.1655887440.git.baolin.wang@linux.alibaba.com/

Changes from RFC v1:
 - Update some commit message.
 - Add missing pgtable_clear_and_dec() on X86 arch.
 - Use __free_page() to free pagetable which can avoid duplicated virt_to_page().
link: https://lore.kernel.org/all/cover.1654271618.git.baolin.wang@linux.alibaba.com/

Baolin Wang (3):
  mm: Factor out the pagetable pages account into new helper function
  mm: Add PUD level pagetable account
  mm: Add kernel PTE level pagetable pages account

 arch/arm64/include/asm/tlb.h         |  5 ++++-
 arch/csky/include/asm/pgalloc.h      |  2 +-
 arch/loongarch/include/asm/pgalloc.h | 12 +++++++++---
 arch/microblaze/mm/pgtable.c         |  2 +-
 arch/mips/include/asm/pgalloc.h      | 12 +++++++++---
 arch/openrisc/mm/ioremap.c           |  2 +-
 arch/x86/mm/pgtable.c                |  7 +++++--
 include/asm-generic/pgalloc.h        | 26 ++++++++++++++++++++++----
 include/linux/mm.h                   | 34 ++++++++++++++++++++++++++--------
 9 files changed, 78 insertions(+), 24 deletions(-)

-- 
1.8.3.1

