Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5F199921
	for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947088; cv=none; b=YV1wfw/JGrGSvd77amEYdsECvE39gCwREAu8xywvIX8TNUsmLJOb5aKXp5Ki7/GC88c8leuDLkkFUruwEojCBJXV/v+A6fniqfJ0CkdJWzX6ZJjG61ZXwoBOFad0mTLb/pHF3vt3+CvG54xKD1uT5ds5dHND6cX9AsQ50/2R984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947088; c=relaxed/simple;
	bh=H/x1u07M3HXF9oVd+o3reuerQgd2pca8MMjlY49GFUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIZ5W54iIzOb9ktLFnwrmJQub7NrTJi++dAAMjiAUZKs9zfOw7AGtHOWjOKloWPOL2epqYzPTBmwFmOPEtYW9lEDVTJz5WQ1ixQraUtixztFtCZZDL/BjOQRoPczNy+YA8VGuJIttIx/LXCCVFSbe8bbMDrZJkXIHPQ5N6KskXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WQBEl3A+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WQBEl3A+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72909c459c4so3085608b3a.1
        for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947085; x=1735551885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=WQBEl3A+mEOA3b5ceCxp8meUWkNWxaDq19onO6zzpsw8B6C1H7Mv2ClbIVM+aXCijy
         8OdVyNWPGfWsgQBZ3xX19CbOpxwNzVFXM1mZmPUCeJtUtlONy5pB0Tis1opn9oEk6a1r
         LyGcy0HD41FxpYv1jLY82v3cmHLPWej9P9aUI++2iOOLA3zpR5pzBf8t6XlrD3ay3qCO
         VxtSuWlhTz+SqOOdzMiIR046vfUShNoCt9H7Bgxdtps5fHUvcbGkXoY+LflF8sk2gvio
         6UhUH25G6Fb4mB2mTaOMD+F5eDM8prZVqjQ7uojLmx6dIG/mjzSEck4qD3ZQWVKIBaOz
         jt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947085; x=1735551885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=bdWNUMXuXHzSIAWc1FZCzYeNrmy9cjVxW9ChTrmFywHQcjdDiGOVSdNxWI0ht+37LP
         FhGk1yXUxV5NSjzWCepsbg6OpVms8WcTps02pTr2rtHh7cxvhU50ksMllgU4CGyTbrpB
         WqfyBBV+tw9pidLk+vq5TFRgzAAlLJXhz7INl7zrcy8LBLQaqPQCLMupKs9ewSQl9iF6
         lBECOv4fXizsJVvKJEh9hR45Wwopx3w/8lzmHujy05zRNrf7wfHKWEccw4n6ZeNlpcLm
         s1Bi29Wis12ycUlQW9Ml8XT/H2kfI/IR61Aesh2V9g0RRcqq+7jBQsmlhYZ92X2iAf0c
         ++1g==
X-Forwarded-Encrypted: i=1; AJvYcCXsPfFR+0v6SFZugmqsiFXrIgVk95BftDq0XRd0WyPKsi6Xa4qH61OV/PXFzJyysVSaUuQgljjNNBvLvEtSLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGVRRQEgznmElmaxFF1HQ5cM3EXUV0ImEL5OfT0GDeUCVxGCa
	QB2Uk9Tys5tiS0vPPvNbRxxm4stwwgFK402YSB4gR/ArWdbIi3b3pZwZVhoW78Y=
X-Gm-Gg: ASbGncvHPP6idfL7CQRdkjPzDC19eR4OTIc1ApmPmwRNMNxxdOumYaJUDqZ5j86yifK
	gKWLqoeZFIiOvqCVevVTfqknQe0rzcJWHXadyDCDWsj/gYZBdMgOpz5CfqLZ7r8HY0F21yuGM0B
	0cEocn3mCX2lzvWOcColrCfjLxKHunA0fT/kK8MuyUSfmclXhlTc3dFg+QSANpiMMs+C4S8d3NV
	Gs669LlwH1c/wUYRfbE+iEqmA4IAQd3QGD55xlmf3TFku+0D5uuRhWIm9oQKhk1UvTsVFsc3rXF
	XBvl6O5EaSN6KrED24hftQ==
X-Google-Smtp-Source: AGHT+IEwnxNRxjpY566VNLJW6lRIrSoOOApqv/9DKS3yUbVNE+/391+nOnqyFIwO+T3gR5XgQach6A==
X-Received: by 2002:a05:6a00:330b:b0:728:e382:5f14 with SMTP id d2e1a72fcca58-72abdd7bae3mr14443469b3a.9.1734947085429;
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
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
Subject: [PATCH v3 08/17] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:54 +0800
Message-Id: <955162bfbbcd9fbb3b074e1fe2aef4f64b61d6f9.1734945104.git.zhengqi.arch@bytedance.com>
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
 arch/arm/include/asm/tlb.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..264ab635e807a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,8 +43,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -61,7 +61,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1

