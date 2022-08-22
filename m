Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE193C38142
	for <openrisc@archiver.kernel.org>; Mon, 22 Aug 2022 08:23:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D456324A0D;
	Mon, 22 Aug 2022 10:23:37 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mail.librecores.org (Postfix) with ESMTPS id 6C20024911
 for <openrisc@lists.librecores.org>; Mon, 22 Aug 2022 10:23:34 +0200 (CEST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MB4zR4wk3z1N7Vq;
 Mon, 22 Aug 2022 16:20:03 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 16:23:30 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 2/4] mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
Date: Mon, 22 Aug 2022 16:21:18 +0800
Message-ID: <20220822082120.8347-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220822082120.8347-1-yangyicong@huawei.com>
References: <20220822082120.8347-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
Cc: wangkefeng.wang@huawei.com, darren@os.amperecomputing.com,
 peterz@infradead.org, yangyicong@hisilicon.com, guojian@oppo.com,
 linux-riscv@lists.infradead.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net,
 anshuman.khandual@arm.com, Barry Song <21cnbao@gmail.com>,
 linux-mips@vger.kernel.org, arnd@arndb.de, realmz6@gmail.com,
 openrisc@lists.librecores.org, prime.zeng@hisilicon.com,
 xhao@linux.alibaba.com, linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

The entire scheme of deferred TLB flush in reclaim path rests on the
fact that the cost to refill TLB entries is less than flushing out
individual entries by sending IPI to remote CPUs. But architecture
can have different ways to evaluate that. Hence apart from checking
TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
architecture specific.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[https://lore.kernel.org/linuxppc-dev/20171101101735.2318-2-khandual@linux.vnet.ibm.com/]
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
[Rebase and fix incorrect return value type]
---
 arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
 mm/rmap.c                       |  9 +--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..8a497d902c16 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
+static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+	bool should_defer = false;
+
+	/* If remote CPUs need to be flushed then defer batch the flush */
+	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
+		should_defer = true;
+	put_cpu();
+
+	return should_defer;
+}
+
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 {
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index edc06c52bc82..a17a004550c6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -687,17 +687,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
  */
 static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 {
-	bool should_defer = false;
-
 	if (!(flags & TTU_BATCH_FLUSH))
 		return false;
 
-	/* If remote CPUs need to be flushed then defer batch the flush */
-	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
-		should_defer = true;
-	put_cpu();
-
-	return should_defer;
+	return arch_tlbbatch_should_defer(mm);
 }
 
 /*
-- 
2.24.0

