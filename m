Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A918BC2F
	for <linux-openrisc@vger.kernel.org>; Tue, 25 Feb 2025 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455241; cv=none; b=exGRCvZyp6W3zDu25NNzsk8nARsInxGXWjNfNjkHqys9c06N+QfoPQ9zjxNwoxYFFwUWl2+98dJ9SJLHPfeuxCgpClhk47b6kUUizKUQ6mT0CxOoUtUnkEC3T+tKD1xvK1/OHg/b/q7y+w8Bfssv71Zw6qow5qOUBAUULF4dg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455241; c=relaxed/simple;
	bh=007QVVVFe489JDQoxvXq6IPNtqGHUmY/RQmaczrx98Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSIvU5c0o7G55WxoK11yo+roUvhyg4h0BQoEX8R6oGCoucQzB47U1p+gS1dBJ8RdKsB7C75aL9pNgyUQhnlAzaCtM8Ef6XTAVp/gH4r3fq2XaxQV7+ReGRJMkENRcl8zjc8iS9yIitvqYgiokwszAi/MdNO4UCvlMx7uEDcfccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N62m9mDv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N62m9mDv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220dc3831e3so95477885ad.0
        for <linux-openrisc@vger.kernel.org>; Mon, 24 Feb 2025 19:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455238; x=1741060038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=;
        b=N62m9mDvTU0KT7/zOgSYI5Gj+Rt2Y3m3JKGSoFuLFr5cQorgKfTRV3LgEs7+XNq9Cl
         PX6qN90TgUX+eHKhfEK8YzIInYLCyIA2/pOt5HC5z8LmoAvu8jYNeJ/1n7Wy5AZ8lSPC
         EQ26Vg404rAFBoO2dNhd67BfEQKALCw9FTmPKOaabEw50R2u18jskTqSg7vpL45v2F+l
         oiu+1rGs13S30DbRSlEK5+05Ejsz0bg5QepFgIJfGolmaG/57Qn897DbgIanmZnB2ayr
         RQkux5Xr14cSTPhqWwo1Ne2TRXGddxosb9mt7RE5PwdXQh2DtuoP4h7G69I5OvjvxgsE
         vMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455238; x=1741060038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=;
        b=EfafVYD1l4UhleFI2LMLXn3H6U0z24EozAxFrMD1TIZmk50gLB91oAAc7BPI/NgKku
         lUztWKyvWuKA+HK/IUeSO8nhI7/uGy4UqGi9kzNMgg07EkjwmDK9OJf41Zl2xeBy46yd
         iiiSrSRTxc+hB0uqUfJM35amh6Hs/TjiNrJgTaAR1HQDDD4yE8uPp0Mzgkr4ZRJ9ENI9
         heeov4cHOnRGJoKGRZXbCg+sc/LqS5m7QbdvFGXvag5rxgNxYy2ax55KDOQ5lJ1agAia
         +BUyp8uwpYzvvQ9vCr1rCyFzX9XjJe8i+51Kc4A1CLBfgVM9wiRaMyoAUjQ1zRxpFVdS
         pkqg==
X-Forwarded-Encrypted: i=1; AJvYcCX4nvpZKfTSy0pmK028+PnPbtSjkpg3fMVO6GlaUQcAT7+F1wyCpYuvF7dilf9wHNF6j+IG7ODB2vrKwt+Hbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsHg3npwWdd6DRmiDfEAtqu6s2JALhT5eTgmNs0a8HSRTlOu8
	cjPrzyOJ+m/gya/EQgi8E8QwwKGhvdCl2m5NGaLrF+H8MDmjnMri1k9KOjkniG0=
X-Gm-Gg: ASbGncuVS2gcIYTXPQjDwgYxzoWfHid+eYtpsMzffznu4ekxRc0ysmNCp5sabH1JxfQ
	f7HeDSHY1PP3g8yskXA+/aFzaeqmiJAYRDodrMxnMu9AGtrGo+Bq9BYgjJtE+LT7Qkqbn1bu1mz
	S4Ue5/2Q0MCM/m+yOPV+tYZ5YZEwVj3QaubUDmbJfFBWRcPpiRrxiGTiTYHPf4KAyVpN3VXwDxo
	E+MELf0wsp9B68NYXO3XqwByL0F85JxKJ74T1pjFMI5tYuUsmAI3JihLGSWHPkXSMTiHdXKf8FH
	HXLcrYUeTdR8PZ0syKGVjm5xcU1n1JlGAVLuEwGaKiBf+QDP8sRf8OIr2DnvmAwkuQ==
X-Google-Smtp-Source: AGHT+IHDwvQZzbKv24vEjKNvLJNI+R1iJ4OqsIlmXN9p1d6u9OWq0+ZfVfD6gOTuv6xGQ3OntwSRRg==
X-Received: by 2002:a05:6a00:6f0e:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-73426c62969mr26062579b3a.5.1740455238550;
        Mon, 24 Feb 2025 19:47:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:47:18 -0800 (PST)
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
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 6/6] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Tue, 25 Feb 2025 11:45:56 +0800
Message-Id: <3df04c8494339073b71be4acb2d92e108ecd1b60.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tlb_remove_ptdesc()/tlb_remove_table() is specially designed for page
table pages, and now all architectures have been converted to use it to
remove page table pages. So let's remove tlb_remove_page_ptdesc(), it
currently has no users and should not be used for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 18bf499ef8801..dd292c6d3ce88 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -511,12 +511,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
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

