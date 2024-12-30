Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC01A38E1
	for <linux-openrisc@vger.kernel.org>; Mon, 30 Dec 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549836; cv=none; b=Y3u0Nk2XiA/6ZohAhWl4BRqS4MyhxLWUzRoLefWrvYFri023zp25jnv1g8pLyjYdGkEU8Sy259e6eSIlmg3uZ1snBcgCg7ARI4Lkl+CFVtRNeSXU7FgNlh+ULdLFKuPlYzqri6WFmzrZZKScez0X6HOafXJhAG+/2GYvyxkBCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549836; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDHtZ2Q2Yvy7d2nVXxcZr+kXQgwV7o/GytFPPXGhl+FH0tD2Zxde2c7jDAclOL0mLLdRLMqSAtX/87BTLpfKuFCpzrowSy2EYGOd+2kjb+G6WNHdkZtwk5zNVfDhAJNCYxFS8PxlxjP/aBq0SO947prg/6lWd5zW23612JYavfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SMYXNOOE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SMYXNOOE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2165cb60719so116242065ad.0
        for <linux-openrisc@vger.kernel.org>; Mon, 30 Dec 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549832; x=1736154632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=SMYXNOOERJ1ARyKG8MiDTgatbG+eULYxRlgQScb+bpKUq3Zq2boEUN08L5OOeHUkaY
         XEEVRHousYEFM98XYCW7AIpbW3FQjJ6fD5YBJBBBmw+oa+jjQGlMz9L4pxpTjhtDHOc+
         mzKJziqgTQCMgBTHzj2YA8F1aWpYo9nvXIarhYF86JwCQeoxb+lUkw+oa2X6RSW4W/Ky
         6WVpzuT/Z/O5vWT2bjKx46iOw4QX9zLIN7W2nm16mDkfWzkeDn+RflIkDsdGtntb1nSB
         sRfvEio/iYoSPfgmK0uOUW6TRrFBXYwATq/kmJaAjmKmADifjbYyxMmfkSU2CA+OWdvc
         +c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549833; x=1736154633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=wIu57whXo+x8/izUzPhY2kb9nlp+2IdxZFnpSnstkZyWGnFUAmufaIi6miLw/Vc+DU
         5+irDLkKSWcFyS3RjCnLkRx2ZWF5bHC+WIXcQ66i6Lu7aNtvUikHVGalgBeumPJ7N5Rg
         bCvdiAbG4Zbk3ua+2TQ+FInBoftQz84nq1oixTxmLd5hlH0DWuiCSkJJTw2ieq1AUsTX
         VV0jEbVsd40jNFNRebk8dELgN1W0OXrmDAXCuV+YuDLUIkaInB58O477a67g36DTv3wW
         K2iAzJTZjsfyOlkWArtEiWmG/36eHrIw9lVXalUjS3TZziefa4edK0p7+CqjUsudMvWM
         NKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW4hiedbDFWpk0FsDKztCgfalmNlC88QDOpoLjfwY/xZa9MPic0gcd+rfrPdNeoWbs3JesoGsS9zIABKoBBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7wOxRxGH2HgYdXwlbO91u/kDizWjEkt3XywYqWMQ2PzhYRpB
	1AWq6gEyxG7e2qQb636wj7rp0RYU+smCP/pffHg/aSEG6V6PF43FBZsz9hbU4u0=
X-Gm-Gg: ASbGncsrE2RrrmYX5VtRo6V/lEDsx888vuRmqnkJqAKs9yjDSi43OkOkukbHHyHuMtQ
	zr8Yco8eAyJPzwzNCsLPbslJn42qV13K37cuKn0zz734YSNBgWT4UI/nD2yMh4GvyZj0w1vnhyI
	hy4LaufO7YrdHGq+jg8E8ZlITv2Svd+oBi1a0WRZuItsStXFEcOzD4eea26ud/rxzWNZdPysvIO
	aQY175RaC8EyNkN1ycas71J7Rcu9iPOtVoRu5DD4WDCvXEQXdVt2e25AMz4fRBjy0eeLbYqCUnV
	vqunJ+MDvnihg2XDjtI/Cg==
X-Google-Smtp-Source: AGHT+IGwnjGmNRtsc6wvIZAIM8FV7PRxiURIME1KaVRQ0EplG8wu3sXxm46oGULh37KJjV0x+YOVDQ==
X-Received: by 2002:a05:6a00:2181:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72abdebb85dmr42631070b3a.22.1735549832564;
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 09/15] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:44 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1

