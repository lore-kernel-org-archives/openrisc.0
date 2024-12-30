Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43741A238C
	for <linux-openrisc@vger.kernel.org>; Mon, 30 Dec 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549734; cv=none; b=aXaQ1lXvrlCMAcJJhfDrK8mdJ2nEx2+wyrD+pRGWDtnA/90tny16bj5I/roadx4oAqghE7mzz8qmDlTJlztSqX0QoDkJ7uWi2SqgJdDk/KJQ+zHknCeMNcAlAhigfpQ+mkVs+hOqaogfqEO4JfuwHtrfKBKx9kPpefGV9JctmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549734; c=relaxed/simple;
	bh=eSQ1cqjI0k4SQFzb/dlIm3hCd3v5CZjZJpupq9IDdtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVz8f4hlFisofvOxpveemvcepTKsPPDQPRp7Y/IsSmnp0IJc3faAvVysy0VCNloQgGAk4BYaA7WkIGQAbu9PWDKv8nc4XceTR9GuRvDpgBW3Y+M9nFJvf4Oq2ViloPnZVgtq8Sre337EOFK42aPoe2pT6lWDatHZ54ucNha+WBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fkkQ/Cxs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fkkQ/Cxs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2162c0f6a39so123632275ad.0
        for <linux-openrisc@vger.kernel.org>; Mon, 30 Dec 2024 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549732; x=1736154532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=fkkQ/Cxs0W3KUmzY4uZ7gTo6taPzqts1z1s+LhKxsSEnR3BoLO5qnre0TuWPFqjdiI
         oZbHhtRswoYOz51aj23l6M1fZjo/I1mBXx+a7Iai15xRuXyvAHJQHi+jOiOb1Kt1iiWj
         b9yugJcKfuBfMcahL5WcGTkQ2AOO159KQg7pL88kbXV2DsKPGDYO3zoODj1R8Nz1+IVM
         3dgWvyPIq+WT9jjP6YepgFxz8nnK9nW1tA34qbI1rSfyWgLVXlRV8s7tdv2RlahIzFgG
         OZKrVMu0Gki7Vizl9XGtt8CU8qyhtBGzRgbciWyjzphP+sqVbQqRU3xSu4Lv4riW0t9C
         jXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549732; x=1736154532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=Zv22rZhd1gOk8pEXfw0YJxMLxDfU8V4sK8d3jIGm4wLPbuAcpN0eqpUmXUSdkJzuBM
         gacLio1M42u/1+SO35RYmeUW4kSBTRAblll+D7HPXRzUYQ82ZVpzpgjQ5/FJ9UgiKDqD
         bNL+r456jSKPLd1ZtTf03shvZYTM/u6owAvx3kfTKSDxeCeYUY9q2Voh67O8Wqpi3HEq
         x6szpy3rQfkllpVxaNBblVQXGLeZkc5vlmuOtK7AcyiLslxw7hVw/AyFuTUpxbqQfXVS
         AkN0u7VtRxGjKw5/FbYH71pq9N+KJRQT3VBdzCBKHj5kHQ0S4gfuV3ZnhHEbaIGDqWRR
         1deA==
X-Forwarded-Encrypted: i=1; AJvYcCWr6xi1hlNKURfI1AUy0OFLefYU9GfYhpVzuNL/7HzOBFA+isBX8YT9gVYczOFCXr4pX9Hpbyv7HusDtZpb5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuqwWMKDMR472jPbjKioqSjHR6AZq7IA50Rr7X15Ch3i6Kd5m
	k3laDWoJQV0vl2d2+5iWPZgr37ZgY33gfGjg0UZJFlTIIHyU9rjrvRU8eTfhjJA=
X-Gm-Gg: ASbGncs7fUG2YIK+aMSC1EFJ29MhDf139tA18m8DiBjSjlsM1djKrK6BNQ8j5qbnXup
	yfC8NZbWkqwT8ar11BvljTJOW6I62Pixlh1AWjxcmXs5CYDLHD/SsNaGRQgytEXRPl4vOnVQuz9
	QsBzCu5CB1NRy56Zo6IwOvQyl8UwENxCxuST9WlO5n9xCLZQsnm0UI7rslu5AcC/dzK+2fEPZMM
	7sa2UVAtQF+KZ09RNbMBZbvBI73sjbt+fvu5RW6Fr8z2Umukw+KUsPP5rHclJENgkeN2wts1Njl
	+flOAn5/FM/D3VPpOw/VBQ==
X-Google-Smtp-Source: AGHT+IEXAwBIqSClrkb4EYoc2OhmhpgilmCz/IsEh6Chc/FsWIzsRB3p/FpLbUSGkXAy0ZMKjVVExg==
X-Received: by 2002:a05:6a20:4320:b0:1e6:50a0:f982 with SMTP id adf61e73a8af0-1e650a0fa30mr7283235637.20.1735549732420;
        Mon, 30 Dec 2024 01:08:52 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:08:51 -0800 (PST)
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
Subject: [PATCH v4 01/15] Revert "mm: pgtable: make ptlock be freed by RCU"
Date: Mon, 30 Dec 2024 17:07:36 +0800
Message-Id: <b59adb960b2075822a6e57efc7a52e7eb7780068.1735549103.git.zhengqi.arch@bytedance.com>
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

This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 +--------
 mm/memory.c              | 22 ++++++----------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d61b9c7a3a7b0..c49bc7b764535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,7 +2925,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &(ptdesc->ptl->ptl);
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90ab8293d714a..6b27db7f94963 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
-#if ALLOC_SPLIT_PTLOCKS
-struct pt_lock {
-	spinlock_t ptl;
-	struct rcu_head rcu;
-};
-#endif
-
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -489,7 +482,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		struct pt_lock *ptl;
+		spinlock_t *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index b9b05c3f93f11..9423967b24180 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7034,34 +7034,24 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock;
+	spinlock_t *ptl;
 
-	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!pt_lock)
+	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!ptl)
 		return false;
-	ptdesc->ptl = pt_lock;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-static void ptlock_free_rcu(struct rcu_head *head)
-{
-	struct pt_lock *pt_lock;
-
-	pt_lock = container_of(head, struct pt_lock, rcu);
-	kmem_cache_free(page_ptl_cachep, pt_lock);
-}
-
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock = ptdesc->ptl;
-
-	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
 
-- 
2.20.1

