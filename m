Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5111E9B07
	for <linux-openrisc@vger.kernel.org>; Mon,  3 Mar 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986799; cv=none; b=rl7XYLuF4rs8uCwaP1opv3hN+v4zoTMwhGx9Cg/2A6WfAHr0BeGN3PRBN/CK9K8x+KU6mZH2tm5ELs8FDndw4pa6vZ56p5G9+XhgnL3m54xDfvcH2N4hxVZIufH9/66WN6buH0fC+v7t2iCCoP3FIkr7tfozs80OgOGeEd4rgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986799; c=relaxed/simple;
	bh=RuA+uroo3JnnqiveXvV7x6EK7oz5OdDodupXgS0+g8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgoDAkg/CjCEgfbMsWTOc5JlYGL37E+mU6BrOMfTFUhDElMIUeDuafVV97Xo9rb3ZtxWaRjqIKFzJ3G3WxCGhWsWdEOIp83U+m680ewMSCpVk5ea/Ji0vZSlDJQ5O6/Bzg7TcJgIKRVIYeSHb/IXo/+duBHunT5XyRz3dqlvWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JmwuNN+e; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JmwuNN+e"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso5800427a91.3
        for <linux-openrisc@vger.kernel.org>; Sun, 02 Mar 2025 23:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740986797; x=1741591597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKqMp2ldkM6onLRqmB7AQD5dXslJ0Fc9YwwNhjL6y0w=;
        b=JmwuNN+ei4ESiRC117RSoEZYWcwIzSKPybdb1RieM/Q//jBOfXCPZdcFaUip1h8PWm
         D0csP5OjzE0Hg6o5I5Vx1uF4NcjF+X41xIpW1+B9ORQkiVeOiXh/DNNaQtZbbjqdMW3n
         OL2vqZuivwSwxl+yNPUV4doAF8YoicRaMzpq9s5OfAQGqcRBdcyanRCAtNkfUL2efrtx
         0z7OT2vlQlN9SBAbZ85HohjXJ4xOnz+sOGeGalNRn1Cg9DrAlopeGD6Lry6+XT9ZzY2A
         OBdoprxaj5BsxDOiYh3oOazDNqR9n4KGpowKXGCghF36kjTRlE4iCkAMix7DNpeE+YsC
         sGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986797; x=1741591597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKqMp2ldkM6onLRqmB7AQD5dXslJ0Fc9YwwNhjL6y0w=;
        b=oRML9mQVW0BftzRpiiW2qXiiJ/zQqzy+9T6I/Fw0mENDF20UKZVK3nMpvDslUGiwGT
         f+EbRrPyZHv70VuWTjOfBrIi3DN89Zppc7ZI7M4y//Ozw4pr8/WvNgfAGX4cTGHe/K9o
         XmMdLYnNWzdHlmqcIH/x0CbxHb2veVArvhmv51/SlwO5Ecf40eQhqXO7vdtJlP6wMT1s
         4tNpkUKKlUfQx5wpg+iTRuD3F6mdhb0+Iu2ANtfCwvR+s4Yv8RlDR0M8sNt7K1lJQYoq
         RMrj7n4u3YmmWNCew0i+wZ2HC8A4/Dx2ywwlnzC5Gf10np49y7Z+e51tXnlaKTzKhKvN
         6pQg==
X-Forwarded-Encrypted: i=1; AJvYcCX9+e4ewXkuysqGVkJKqTtLKQXHepko53fS9RrVaGk3ktIbkb/Autw2Ds0VZjdVHwjSbf/FZXCPlV9dNb6blg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycQrhXtfPNmBhkKzsy8TSYtVf3Iad03gsxXPocptzQZsXUnv64
	FucAUHEUnCE4CH3TlpvKrxGlGof5gzB26e5nqvupa+aHz4BR/Zow7x1AiOPM8jI=
X-Gm-Gg: ASbGncvY/AuseDkPJo4ap+v/bfnDATI/IAV+6g7NNuSU42OuFDiXY9R5cm3sLP2BXMn
	leCdsCjviSwDr54nc76zzLlSrZvEjovwxChijdnUDriXQZ62BO5P3b/1dPoETg1pRrZZVeIkmfm
	F6Z2pMYf9QCKXeJ5VRVMsIzUN5JurjU7QcLzyrZgyqICuw8SMnBhpsN3i/qFhXzuGM+TfRu4K8y
	16B4+86Ci1na2VEXcdnuejqNM1kuRwLWrEYE5fR/oq7oSUmcE9sSt8wd6IQ9o5TcXR5/Du5Wx6U
	pv9DYO6LxUDEFeN4OTxq/2AN98Dysuo3q/sLYLpzbxFJgcd7K+VT9en5ikcosPXhhyfadxl8hBc
	+8LeHmg==
X-Google-Smtp-Source: AGHT+IHY/mguPL5YJZdh+hkpdyJ3sc0BaAvd1rDPiW9eR/qaACJ5BQlxWj/zL9j3Gfy9PeYzz+4/5A==
X-Received: by 2002:a17:90a:f948:b0:2fe:d766:ad87 with SMTP id 98e67ed59e1d1-2fed766af9cmr12568619a91.7.1740986796693;
        Sun, 02 Mar 2025 23:26:36 -0800 (PST)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea676c06asm8211638a91.16.2025.03.02.23.26.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Mar 2025 23:26:35 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/6 update] mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
Date: Mon,  3 Mar 2025 15:26:03 +0800
Message-ID: <20250303072603.45423-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
References: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
tlb_remove_page()). This is the same as the implementation of
tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
convert these architectures to use tlb_remove_ptdesc().

The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
or tlb_remove_table() for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
---
Changes in v2 update:
 - remove the do { ... } while construct. (Geert Uytterhoeven)
 - collect the Reviewed-by and Acked-by.

 arch/csky/include/asm/pgalloc.h      |  7 ++-----
 arch/hexagon/include/asm/pgalloc.h   |  7 ++-----
 arch/loongarch/include/asm/pgalloc.h |  7 ++-----
 arch/m68k/include/asm/sun3_pgalloc.h |  7 ++-----
 arch/mips/include/asm/pgalloc.h      |  7 ++-----
 arch/nios2/include/asm/pgalloc.h     |  7 ++-----
 arch/openrisc/include/asm/pgalloc.h  |  7 ++-----
 arch/sh/include/asm/pgalloc.h        |  7 ++-----
 arch/um/include/asm/pgalloc.h        | 21 ++++++---------------
 9 files changed, 22 insertions(+), 55 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf8400c28b5a3..11055c5749686 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -61,11 +61,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return ret;
 }
 
-#define __pte_free_tlb(tlb, pte, address)		\
-do {							\
-	pagetable_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 extern void pagetable_init(void);
 extern void mmu_init(unsigned long min_pfn, unsigned long max_pfn);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 1ee5f5f157ca7..937a11ef4c33c 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor((page_ptdesc(pte)));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..73629c1b8328e 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -55,11 +55,8 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#define __pte_free_tlb(tlb, pte, address)			\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 80afc3a187249..1e21c758b774e 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -17,11 +17,8 @@
 
 extern const char bad_pmd_string[];
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 26c7a6ede983c..bbca420c96d3c 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -48,11 +48,8 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern void pgd_init(void *addr);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, address)			\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..db122b093a8be 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)					\
-	do {								\
-		pagetable_dtor(page_ptdesc(pte));			\
-		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-	} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 3372f4e6ab4b5..3f110931d8f6e 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -64,10 +64,7 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..6fe7123d38fa9 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -32,10 +32,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif /* __ASM_SH_PGALLOC_H */
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..826ec44b58cdb 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,27 +25,18 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb, pte, address)			\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
-#define __pmd_free_tlb(tlb, pmd, address)			\
-do {								\
-	pagetable_dtor(virt_to_ptdesc(pmd));			\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
-} while (0)
+#define __pmd_free_tlb(tlb, pmd, address)	\
+	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
-#define __pud_free_tlb(tlb, pud, address)			\
-do {								\
-	pagetable_dtor(virt_to_ptdesc(pud));		\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
-} while (0)
+#define __pud_free_tlb(tlb, pud, address)	\
+	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud))
 
 #endif
 #endif
-- 
2.20.1

