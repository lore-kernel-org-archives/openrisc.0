Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A81AB537
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319793; cv=none; b=TRQ49A9e11WlEVdSYwuoVkpNGqAThFWDVRpXtqgra3nsOg1t7T0H5vj89ASOJNw2UJFKevFL7g3KZoU4jxhQ6xb5ZyDK9OzSISrp7a2fLk2t9ZqpnLzv2pAS9mYzPpLe0He52zLCraNNzYvhz/IE97WCFdQcXfUnZQJxdaIoRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319793; c=relaxed/simple;
	bh=gLSOIPe2CJRryLc4wKd5NXWeTP0qwE2dyCNWoD9rNdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2lWLi+BY/fJP7OfhfOG8xGahFLBqeQHQjlY7wTjfDgZrgHgMWV3vMGSvfTqlHjo7GUFHDvL//RxoNKr3EVpQhJvX2cUvxEwICGd4SBoAO0W5hYqd2DK+342lQsA2Jw6hpyiVUVZEK99xWickpjT43Q8Z629lgqw6Mji4crHt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fjmyU5E+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fjmyU5E+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216281bc30fso26002345ad.0
        for <linux-openrisc@vger.kernel.org>; Tue, 07 Jan 2025 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319789; x=1736924589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=;
        b=fjmyU5E+PXf+rWBKTpVHtvNs1Cc0dO18yyBsSeg6r2HkJz9BE7pTxjEk/UjToMPRZI
         EW2QfAFzHOdCqL5nqH44h4l8dQskrG/pgAL4YxJNses1fDFkOPSdUhA61DQmGv8gZvhM
         hkVx98kN8Km21S/raHDRFCJaTDbDvvC34zl310L6YSxSG82q77U+F2YU/xv43pfBQnE3
         cRCfNxk6tGARAE5EUyPU3AOVUpMpl/fmX0lZj2nI5AUGw/NzMm3U2DPrYSnHt0zkuPBK
         OtTtIT7N2I8505Q47TMzLvz4S2zr0kJ3gFhwDdWxcHilP9gbpZVExYAnwz3UKP0YddIc
         eZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319789; x=1736924589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=;
        b=WFBDVv7+dQNXdrnHypXw7ivFkGanSigF1Rvq5/wRNt2vbFG8nISrlP2O1Pgw2Ntor3
         TiJYSMydLfAYjFHvzdQ+kmXAre4LcNlkjDHimAbBVjL6+ek2/6GYyIFvb0hAfyWIzF5j
         7X6klltzmgEjpEEFoBhrKVPTw2E1Er5SKEy9qymmKoeWOgC/borR5OiXa4/F0fsYPiGE
         0MfDz38a1puV7mKfKUxd2m+Gar9A+vFN75vUer/SWglYnlIUposwQwGPMkShppy9uO2K
         5Sc0T1o9aU7vXdsW+xfkTJrbQcoK/4+Dh6ynYAy+UJqF/5qj5PBkD+TnM/HE5sNUy9b+
         T7TA==
X-Forwarded-Encrypted: i=1; AJvYcCXfnpWJh72F877ESyhpjB9pKgfmcr9l2bszFVF5V+u62r396rhGKAjK+lpfetyM95cG6CVJVSTwhRxbTFDB/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSLZEC/NOQre+Bg1wZpi3pz5rjkyJeqOcdtWj1ylVBJj7ndXm
	61pdtIgz9YRCnvKbc1mduaPiLL5iK2PrZ3ia2Y4xw76OyVE+Ojz5NDJvfUIiUgM=
X-Gm-Gg: ASbGncuTMxQinSea5U+M3HH3Bd4YCeSwmdqYr8grt7cnV/l2J3q9CUgaEqFuPW1/Lgk
	iel11cTnOh2AyBLtzP/7L1+nDpxHJUW0FuW/qVpyXIR+xqlXL2IHc538HKp2qQPzu/tqGHRsCTZ
	lgTiSk/Dg9aqFgNJlOl77cKdHnafofxpgC596JWxcICVCZp9MNMyyx+0/x5Ko+8KDWFZdgZizC+
	nC4pq+aFtPUA9eP1DY/7MrwvN4Lxa1nIzSQ4W2hPXPDfAYIwf9i+frtWEWqgy0Va5g0DL/040PN
	j1USM46It9JmFGb2SLikZ/Djxac=
X-Google-Smtp-Source: AGHT+IGLH2wnugoAqXpKOjRMOcNm05e1d3DjACkQOqMsLyNNJS4LCZNqibWg6/9XtyaXTuj3byMh6A==
X-Received: by 2002:a17:902:e74f:b0:216:7cde:523 with SMTP id d9443c01a7336-21a83f6710dmr31869555ad.32.1736319789694;
        Tue, 07 Jan 2025 23:03:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:09 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
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
Subject: [PATCH v5 15/17] mm: pgtable: completely move pagetable_dtor() to generic tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:31 +0800
Message-Id: <0c733ac867b287ec08190676496d1decebf49da2.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the generic tlb_remove_table(), it is implemented in the following two
forms:

1) CONFIG_MMU_GATHER_TABLE_FREE is enabled

tlb_remove_table
--> generic __tlb_remove_table()

2) CONFIG_MMU_GATHER_TABLE_FREE is disabled

tlb_remove_table
--> tlb_remove_page

For case 1), the pagetable_dtor() has already been moved to generic
__tlb_remove_table().

For case 2), now only arm will call tlb_remove_table()/tlb_remove_ptdesc()
when CONFIG_MMU_GATHER_TABLE_FREE is disabled. Let's move pagetable_dtor()
completely to generic tlb_remove_table(), so that the architectures can
follow more easily.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/include/asm/tlb.h |  4 ----
 include/asm-generic/tlb.h  | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8eebdb598631..ea4fbe7b17f6f 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -34,10 +34,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-#ifndef CONFIG_MMU_GATHER_TABLE_FREE
-	pagetable_dtor(ptdesc);
-#endif
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 69de47c7ef3c5..53ae7748f555b 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -220,14 +220,20 @@ static inline void __tlb_remove_table(void *table)
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
+#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
 
+static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
 /*
  * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
  * page directories and we can use the normal page batching to free them.
  */
-#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
+static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	struct page *page = (struct page *)table;
 
+	pagetable_dtor(page_ptdesc(page));
+	tlb_remove_page(tlb, page);
+}
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-- 
2.20.1

