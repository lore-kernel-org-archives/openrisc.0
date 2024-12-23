Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE011957E9
	for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947036; cv=none; b=J/IklUqBUvyZqWF/spV976SVblk5RZXIo+zcHnASM9T2gz7/bn3n1riUqph8kL6lLld2I/8MWOmu6t8y/RRXlXptSMZLGrdBKB+K2qD8CAZJJSbqyIUME3Xtt8F54aMhEGnE1NKsW4l0f5xES4hhe2PquqyMMUA02nyi5Fjkcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947036; c=relaxed/simple;
	bh=iGGseqx9Ut5ViSPAG0PhwW+aGehMNfQFpL91q5ypQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/zZjaApqZZzQ6wGyzwy6Jv1TTob185uUFwq/TGE06pB+90FC0sX5yNf1VvV3eO7g3mTjIe1M/Q73+N7vktKYDXnau70rwk/Pxgo8vebWGNEbice3Qq+UesQEh/PC2qDSAGeTMy3R/Q5TmBK1QWeoPj1/CoNRr+/wYNBdjKcy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YwCBKelk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YwCBKelk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4801205b3a.1
        for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947034; x=1735551834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=YwCBKelkhVnAI1YmArkuwZsKg+bbBtWoqB+ScUthCYx9q6p47hH0hsKMEKzrhMV2YP
         tqizLfTBPZRUzZfJaq0LM6WdhXkz3PTS6U00s8HNvZNiWLjp2cuJMt4RaaMGtOiROY6z
         k0NfEb9AUwZFiZGpgrgLi/5/rP2VMIQ57a4B2hJGzmOx6OxHwiCYa5ledkCFLLrOUykO
         17gA31qAMa2PMLVXIhhg7H9eC3wt+XgPEjk6XKbjjAksWCZYm1AjWUFW959qNloZHSzA
         KUReK9etAoforD3CWYNgDGqIR+Q3smDqJ8R2Clw/e50YcV9P9ZV+78KuEvmYj39ncUFr
         SeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947034; x=1735551834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=h/P0BtcvSJIJEDiYBLM70oxZvadeQdY7Difh7cNURZmLfgFwp6vXJ0bDuPzh9o0icd
         EcjwzZPcK1jAWnnoUM6sCwZGm1L7nyUZyIt3LkBLDSUO+gCM61vyHvxOHCBvLWSxu2Jl
         +zh0QJCyZapeNkqdxAINPJ9FjvCCfj4axN3P1yM4ZElU1DiJlEOh5DXizvrGAEGZa7kp
         0KcjLzr0ZCZ/YbNMOXxS4pbFMH8SC3RmO7b3lNz0J883ZSHfQWCkVitvPWJPNzq4GYEG
         8hu0vTZaAiYuws/Ljbq1NgzJx23UJtTFFnuVKpCgFS4bmS21z5EvH1qTU4zsF7y9QgPe
         p6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIwegBHN1JGQbeM9dATCuQ97v7ip42YiRIA3UzfjPMrmX0ckGr/ZqlEj+AQTsl9YJlbY0Yoey/V9ndjl7N7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMomFR5DT5YBkWysrDUt8fgQhbzzfHF5H/G+WXrqNjCXBkiUP
	UoYjK2BJG700ID1Ykey1PxEYVb0eKBCpw3yQkBRdNfscUcZC3JGsAb2aEpWRmv0=
X-Gm-Gg: ASbGncv54ICjcrN9vgC40QCyErggqoQgsBV09RJz0zTmrm/ICBlMgmyvijPezLi/0Li
	iGN5742MSUuYANr3q8J6m+81pgGKsgCwfqpXwXS83JEvLyP7qz+64M8J18TSUBL/VXmIDhwpcIc
	Sepemx7KO0vStASFyqf6DxSSVUoXAN/JZd9Z53yv2H0R4vp9Y6K8jgtW4ORXPwel9RFrZUc9xZg
	rAoSTXMDsmuePxInvWsU1u0RFhniqRzGhrtJYrXXruTbKE89e7mFiWFikvJ4vBMj2gHpAfAS0g6
	YGIGBz/+y5U878rEfjlhbw==
X-Google-Smtp-Source: AGHT+IGO0+mWINscMdGqF/L7XDe6Dv/dfGXrIYILRYMXJn04aY3ZCG1rf5V2YGuLlSic6wG5VWjqsA==
X-Received: by 2002:a05:6a00:4090:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72abdeb85b1mr18289604b3a.21.1734947034102;
        Mon, 23 Dec 2024 01:43:54 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:53 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 04/17] mm: pgtable: add statistics for P4D level page table
Date: Mon, 23 Dec 2024 17:40:50 +0800
Message-Id: <2fa644e37ab917292f5c342e40fa805aa91afbbd.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/riscv/include/asm/pgalloc.h |  6 +++++-
 arch/x86/mm/pgtable.c            |  3 +++
 include/asm-generic/pgalloc.h    |  2 ++
 include/linux/mm.h               | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 551d614d3369c..3466fbe2e508d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 59131629ac9cc..bb482eeca0c3e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -230,6 +230,7 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_p4d_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -247,6 +248,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49bc7b764535..5d82f42ddd5cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3175,6 +3175,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1

