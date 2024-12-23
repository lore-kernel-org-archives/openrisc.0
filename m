Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A61946B9
	for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947049; cv=none; b=DQ3kSIjfNr98TRjXksXZHYf69VcYT9cUNdmw/Bmim8NBroOCqJDjZP7sAdtUTgQe9Rs8BwYQdK087fr/FLdswC89EH+ycZsipnRsjmkC1VzZiip/I4yy+Cjq4SzHnSjF7fTPLo4t4SfsEzCt92W8VXSZ1E5N1QffdRnhLXbt/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947049; c=relaxed/simple;
	bh=jiyynG1cSpqMCUPKcTsBXQhnImP0khzMQlCaAfJaSPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIqTojqz1ppkSnE2Ol4TjAu4+kYF4g23u3Jq+UPACMrMZuQgW+rnYBqiONpszgQHXZYhhWNQXWQCspqh2fwOR0YCvjDLrYB+14CDFl/73KPvgG/NTyKx69ldpuKoERMv4MBmjUgH41Jf8HO/qJtR/WxEwX1ByZBHqhvpgrAc5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=l2fu92Xr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="l2fu92Xr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728ec840a8aso4529944b3a.0
        for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947047; x=1735551847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=l2fu92XrLbHe5vKbq8TlynuLMNL/slbV8aqe9gAKoq6PUKk4R39Tw71RcoiemwvA3V
         ccpUwy71aYHNzaXMwEyBiinbk6QGTT59LJKntkwb+/uPWqaJy+Hae4Ol43D/77ZJ15Zt
         PzNYD45G+KI181VY0KP4MnbbCpy5kYt9eoOEIUnuLBiL4+4vA0/6NsmBXMXBOhy5lp/G
         3FjcSgNIWb2upkwDqTTw7pJreMiz/lnQNM88ydOkaHa8GR7xfcYYyO+i7lRUwx4MQnsY
         5UH3m7mQUpS0PHy73O361BxTO+zBJGOWgU7CgCjhLMEdQn7IPTdAFOh7k+Ka67BkUf85
         eLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947047; x=1735551847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=JKQy2Vrck75bGno11U7a8lWjTxT4KUN8Tr6jQiZclfE61B+0UapBnrG8PIpLcIwCby
         QZVAMfus65B2aupLciX5yj0avaL1B6YhCbdrU0vwvNjwiiwqlqfAAwu4vm7e5k7DZOAY
         K/vdWY+12mIUmRjUeyfoA9tz/JqS8mYas29tUpmneInfdAOIwNHU+ltbAgIVb02zneel
         RhARWutSKICjayzvNk3dB2BlqHpTA3SsEqt52kibz3XEwfBOt6Owf9QLpwmdbHjptxBh
         C43OXPOlsakXApXUEG5J3lX+u1COlKmQfa8i8ug9sRIGDKVwJ9nlhZuOQaF7C20HDgJI
         0E/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNVTHF0NznYf2NfeUi8Vw54M6EFOdTXg0TIy4DYW/65hx7swMbhaud6cezHaZCdj+K9x1/QKF7aJK+pgVQ9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0T2zsChBXHqXsm/BaFXgVtGEVbcNMe4AqkkeLmS9LHh6gIun
	O4vnF1nZCpQUC+NuJaYD8+GNp+lqffXxxYXPROHW3RTxuvmub0pKy41X/O5H+no=
X-Gm-Gg: ASbGncv6FY9MfFKntuV3ctk15W0obFCJXqHaenhmD5K/zgCHqCHXaz/DS0B/DDiE+01
	fkeRbH5VXinah65vlAWdJuPnr9j6asd56NIs8Z7RRJUqG5sSNZlbidcbOlAw41r8ijNR8IB39e4
	uzp5apgj/NkVv6rbS+vM3Ba3BSRVnXRkR4sKrn71GOAhJ46RzgboynfaDOljIH2tpwzwZY6Jadh
	Znv4ZA4fE76XMkoUtn4MZGwl2x+1ZLYNVh+zPtQqXvvY7I4sV7yWDILzU0em+hYViqX+uNfszm8
	6KOCogEfsY4Ry2WBDpY4wQ==
X-Google-Smtp-Source: AGHT+IEE3DAo82DBKWUM6FD2Qxwd8GTGkBziQ/dfcNtaRbY+efEiB7FXaTM2aY8g2l19VVq60zkLag==
X-Received: by 2002:a05:6a20:7f82:b0:1e0:d575:8d4f with SMTP id adf61e73a8af0-1e5e081c5acmr19810935637.37.1734947046731;
        Mon, 23 Dec 2024 01:44:06 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:06 -0800 (PST)
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
Subject: [PATCH v3 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Mon, 23 Dec 2024 17:40:51 +0800
Message-Id: <7c12112047ac230809aacd0379259414b9b0d3a3.1734945104.git.zhengqi.arch@bytedance.com>
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

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1

