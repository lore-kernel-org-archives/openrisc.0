Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C51A0BEE
	for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947178; cv=none; b=iWM8jW7LKKrUYBim82E6a7aQusejAnlVZcXWFloQJKSmmQ3CtFzQsUrCs/VlXXw24y7QJwrNk7Qq1YbH9kQrcFJyJ0qou1pKDtNAJ5wCdIe944Q9PsKDUi92WPSGM5U2Pp9AjF1FbVSO/S/qBD9bZj6K3vU1NgBQilhPmAKpKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947178; c=relaxed/simple;
	bh=+1lVb/czrpvckRjrC7+7Dr3aDdUG0igbcjvcBWUZaCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCM4GtRPhrQkCzjxfdVjLSbatTB5WokiNqoMxnigvrdTjdjTbMQbiFvK/xkoLuC/nHxNByc5MoMvT2crLLWcIehhSJpm0XKt9KDbhvFYFtjD5hxu4Wlwc0QuL5WiRYqjr1jkkTUsJTgKdswUaCddtmzVnEu7YPXyQfPLr4qU62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ctL5Gvt7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ctL5Gvt7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so3378738b3a.3
        for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 01:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947175; x=1735551975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FItpERzyh1wDMphf2PSqriZlspFkmpQlPhA2jGTCtDU=;
        b=ctL5Gvt7c1MAZ+Ws/Ol9tNIhNb07UBi5cSHM9VMaPSwT2TMmsbAQULtWbKbLLEYBtf
         bK8x7LOSJF5+RYFL01S/X0L6mT/kMPTWj6RI8nYyYWRApUHGRnus06B3tWYZ2YAU/8qa
         dz8aYBfdct6rEMNe8EZxsFGnEaXYpJAN8DpucdeYBDtF9yNGwx0wLzrDbUS/mVHRTZEY
         Ik3FzUDC0PqmhfAubos9gNaGSs4rUfKT7gpa8aP0Ub6n90GtMTWt5Q7B10qh/aWqbmTl
         DrqJpE2mn5xaAolMU5SnkTE28Foi1hi/TCCeEg/r+icTnYkqnNrKqhOol2ZW7vL3bZa1
         nbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947175; x=1735551975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FItpERzyh1wDMphf2PSqriZlspFkmpQlPhA2jGTCtDU=;
        b=t6aLNOIAG419TZWpCDG/WW9fvZAO7etsOBLZSepWn0o+j1dODvoqlf3YHSXTbD3QbL
         ronfV6rqeH9DKv5Iyl2TecQQoARacVnmuV1rnGysvEY/bUVznQXoYpGlkxxa3C+LZpaW
         n7TBmV8AccOCAwaAnaUSjtQU+sRHIH4fBsrAbnxOnPi5+1ezk1VvS1MfaF+9kCxhcleu
         6VOrEbcT+hQjlt1RsVQvCth14AAoI1vZ2uUQfaYaEKcXzvFMN6FSKnElquvBd8S0aDqp
         lHNfPskcwuGo9wCpsr8tvsW8FmXWpTbgllr/srd7glfdZukIrj3FKu7lCWs+vjQO1Kgv
         NJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcK5VWsbkqxEcCa2auj57B1P2jTKE8780qzWfu50L9naea0F7wNnYPDjZ1NkEKKyezOQ6DhdcGaoWlexrSUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Fpb2d0iwraptkVnoGKTpKOYMapouHLyOgA2mwjtRfTK3gPz6
	EloZ6R7genLUpImQrqcp/gMJE79CwZgF8BPB22gEPnWHKhog3acsKBn/bo8QmDE=
X-Gm-Gg: ASbGncuWsCfczs3mU7IrCsgO0VPupkzhHgWsIQrs7gLANUsyS7exjKx7UfVXCrptgbx
	1u67I02QzuDJl12pjRnUiPCLJLAtLARJHCh5uadh/h/CvwBzUEY/1xXCGJXvW8R8kQ0ffHV98BX
	9QC51bEoumG8ML1DZU81F/IlP1rXX8bhdbPPilOzd/7h8hzn8aCZPufmXP5MBBecz9jQycO6XKQ
	QuigsH2UNQQKpG/DU6DaG3PubIy8IhRnYO7AeCcrLL2z3HN+XczZ4pDMq4uogG28DANzjavI/yc
	i8R+qvPiabVQtEnL56skgw==
X-Google-Smtp-Source: AGHT+IF9RJvbCaq38Te31r1RKGqLS5POHI3EPqaSbNpVA67C9keEJqX0jQ2rnqy+EikMhfv/vLwTVQ==
X-Received: by 2002:a05:6a20:12d2:b0:1e0:c0fa:e088 with SMTP id adf61e73a8af0-1e5e059b19cmr20289317637.18.1734947175103;
        Mon, 23 Dec 2024 01:46:15 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:46:14 -0800 (PST)
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
Subject: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Mon, 23 Dec 2024 17:41:01 +0800
Message-Id: <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
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

Here we are explicitly dealing with struct page, and the following logic
semms strange:

tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));

tlb_remove_page_ptdesc
--> tlb_remove_page(tlb, ptdesc_page(pt));

So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/include/asm/pgalloc.h      | 2 +-
 arch/hexagon/include/asm/pgalloc.h   | 2 +-
 arch/loongarch/include/asm/pgalloc.h | 2 +-
 arch/m68k/include/asm/sun3_pgalloc.h | 2 +-
 arch/mips/include/asm/pgalloc.h      | 2 +-
 arch/nios2/include/asm/pgalloc.h     | 2 +-
 arch/openrisc/include/asm/pgalloc.h  | 2 +-
 arch/riscv/include/asm/pgalloc.h     | 2 +-
 arch/sh/include/asm/pgalloc.h        | 2 +-
 arch/um/include/asm/pgalloc.h        | 8 ++++----
 include/asm-generic/tlb.h            | 6 ------
 11 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index f1ce5b7b28f22..936a43a49e704 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -64,7 +64,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
 	pagetable_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
+	tlb_remove_page(tlb, (pte));			\
 } while (0)
 
 extern void pagetable_init(void);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 40e42a0e71673..8b1550498f1bf 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -90,7 +90,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor((page_ptdesc(pte)));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #endif
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..5a4f22aeb6189 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -58,7 +58,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 2b626cb3ad0ae..63d9f95f5e3dd 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -20,7 +20,7 @@ extern const char bad_pmd_string[];
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 36d9805033c4b..bbee21345154b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -57,7 +57,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..641cec8fb2a22 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -31,7 +31,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 #define __pte_free_tlb(tlb, pte, addr)					\
 	do {								\
 		pagetable_dtor(page_ptdesc(pte));			\
-		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+		tlb_remove_page((tlb), (pte));				\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 596e2355824e3..e9b9bc53ece0b 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -69,7 +69,7 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #endif
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index c8907b8317115..ab4f9b2cf9e11 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -29,7 +29,7 @@ static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 		tlb_remove_ptdesc(tlb, pt);
 	} else {
 		pagetable_dtor(pt);
-		tlb_remove_page_ptdesc(tlb, pt);
+		tlb_remove_page(tlb, ptdesc_page((struct ptdesc *)pt));
 	}
 }
 
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..43812b2363efd 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -35,7 +35,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..98190c318a8e9 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -28,7 +28,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -36,15 +36,15 @@ do {								\
 #define __pmd_free_tlb(tlb, pmd, address)			\
 do {								\
 	pagetable_dtor(virt_to_ptdesc(pmd));			\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+	tlb_remove_page((tlb), virt_to_page(pmd));		\
 } while (0)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
 #define __pud_free_tlb(tlb, pud, address)			\
 do {								\
-	pagetable_dtor(virt_to_ptdesc(pud));		\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
+	pagetable_dtor(virt_to_ptdesc(pud));			\
+	tlb_remove_page((tlb), virt_to_page(pud));		\
 } while (0)
 
 #endif
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 69de47c7ef3c5..8d6cfe5058543 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -504,12 +504,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 	tlb_remove_table(tlb, pt);
 }
 
-/* Like tlb_remove_ptdesc, but for page-like page directories. */
-static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
-{
-	tlb_remove_page(tlb, ptdesc_page(pt));
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-- 
2.20.1

