Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D444CCA485
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 08:59:34 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8C9AD240F3;
	Wed,  6 Jul 2022 10:59:33 +0200 (CEST)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by mail.librecores.org (Postfix) with ESMTPS id 241A42133D
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 10:59:31 +0200 (CEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=33; SR=0;
 TI=SMTPD_---0VIXnCQL_1657097963; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0VIXnCQL_1657097963) by smtp.aliyun-inc.com;
 Wed, 06 Jul 2022 16:59:24 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Subject: [PATCH 1/3] mm: Factor out the pagetable pages account into new
 helper function
Date: Wed,  6 Jul 2022 16:59:15 +0800
Message-Id: <a131bd98f7fd0c5b904b05496d53caaa2c62cde5.1657096412.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
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

Factor out the pagetable pages account and pagetable setting into new
helper functions to avoid duplicated code. Meanwhile these helper
functions also will be used to account pagetable pages which do not
need split pagetable lock.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mm.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d084ce5..7894bc5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2352,20 +2352,30 @@ static inline void pgtable_init(void)
 	pgtable_cache_init();
 }
 
+static inline void page_set_pgtable(struct page *page)
+{
+	__SetPageTable(page);
+	inc_lruvec_page_state(page, NR_PAGETABLE);
+}
+
+static inline void page_clear_pgtable(struct page *page)
+{
+	__ClearPageTable(page);
+	dec_lruvec_page_state(page, NR_PAGETABLE);
+}
+
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	page_set_pgtable(page);
 	return true;
 }
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	page_clear_pgtable(page);
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2451,16 +2461,14 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
 	if (!pmd_ptlock_init(page))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	page_set_pgtable(page);
 	return true;
 }
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	page_clear_pgtable(page);
 }
 
 /*
-- 
1.8.3.1

