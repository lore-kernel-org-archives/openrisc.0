Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D49B64A
	for <linux-openrisc@vger.kernel.org>; Tue, 25 Feb 2025 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455191; cv=none; b=HMYXkVkGIJ8UNGXt6bkoHNB0UY1eb+0T78w4nh7ml1KezvVQm9KWg9VXM8ejL35OJqTVrQvG4kR6rVwy2HMvPJulFkyWMfoymiOy3hyr0Lla7X2XsUZwwWVzZZTEUKrzLObD/mHDzw3nQ7CJuLqXmNO6i5FJkR0gY7NOnBwictM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455191; c=relaxed/simple;
	bh=+Ao5l71m8R2KBR4pKhSeuqtrK/FFUTZNCirhHcI/U+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdVmgwMxw47F0LU0UZLjWllPCsi+X2s3Bf0REKL/x2pMC4W3fzR0B3ZSX4syV5G5atEuJPBduK9zXkIThSUmcaxvM4apYaGKMpcaUmzCb1xFHL3UX9NoAw7Cli93mTb4jwh5MKYPjZXcIPkoLQJ0SpBVbdxIFd2jnuIwAfg19dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XqQAFeu9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XqQAFeu9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e989edb6so139802065ad.1
        for <linux-openrisc@vger.kernel.org>; Mon, 24 Feb 2025 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455189; x=1741059989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=XqQAFeu9+jAY7gKK2np4vO4g91b9uWMd/6TX7uoukDIaD/obEG/vESFDxfKesdbDoM
         DUhZSnz6YFmvEDmpJ/nWXcwRcGca7LDIIKRDNxDtW2hjagjoenxWRFn4/kcvQXf3ACwl
         zJDVmBz48yBwHLGQMaHqSbxVJmbCZbQdfveZIEfNlYxG/y799JFM4vRo7yeCq+nhdKP1
         Q+5kr2LA3g3RrNO2bmwI2bN4c50lMhba78Jbd+BDEVb4CwQBNN9S1j46EM/7O6ZtGOUC
         k7tXgspl9UxEDV8bfxvY+EQ3QwjNTMjGgtNLzJafFP4GWzb1jmwV2nUqgBedoxCyHI37
         fAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455189; x=1741059989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=nha2wzwi9oH3vYk4kJABxnZELCTlksO1lSvYcjSRUqYXpXGXwjawyHBLheQ/nd1nmm
         eM5tf8GtEasmM4XsCKvZfVPz/6fvvQPlOLRlj8uxU2lncziO36qX6q1U1aWMJ8EXUv8x
         st3yVrloRK5g9yZqYuUpMzyAAuxgXA0GofOFLCcAzIy2NkqXACswaQCZkj64o0xUOEOP
         Vq8MfJ1qQi7KZDMbryr2DypGswF/IboKDuaIG1F8g3aiTny5ttta2QIf+Jnt20XBeBWS
         cUMdhPkNeBpflQv5cfs90bjlXMjtL/h+V07ZBTFfu11XelWu4WLj7jVuubSScOvmKQ6U
         niig==
X-Forwarded-Encrypted: i=1; AJvYcCUCmvhnrzInXgWCOuqdKlvHMgN/pPw8szC7pntywbmOxu+G59NONCEDuFND3T/X31lKjKM25Ni1UFCbAdTXlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFS1ZSsHBpmQTVPM44s31KRkAue53zpgHwvK+aJS6DrkawMjYf
	4YkLv8VN36gU6CO8h2gZeQz191dJwRH+GYiZ6FkxaM5+iZz0AgLad689bwu2Nhw=
X-Gm-Gg: ASbGnctzkJ6BVFbJbhFtPnyOfvQGxuTmCr8gfl/9xoB0HYoZxh9EoG5M6o/QDVJBb1W
	NFhbxFi07Pfv4RpjejI3eHHkyxia6pdGkx78qcCnDV+a/G57eV/RmPZsucC3bsIyttfYVJfRxTE
	x8kBJNuDW8WZJjV7l1spsmYhXkqIO0nDEXE7sZO5dZfHPAjcxHNTd01IWHPYPAS/IR1DSY+FA9O
	Z/zOjHFu4oizor8JDA8iGl12JUDxmxWiLebpArV4O0Xudky2mK1d7Vw6MGKkQygGcDT0AmPZN2i
	eTrvR3/Mf65jP/8sZj8qDqA67zNJMtR9iJq8pcDdGAX/kX+d1cFqQDjlqPJ0mZedsQ==
X-Google-Smtp-Source: AGHT+IGBfXw23ytiI6FvQDqnu6HA+6X81xKlY5Cdi/AJkyrR2YGvsG8wye6vZ+K3tNu1qHLJYKOiEg==
X-Received: by 2002:a05:6a00:22c9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-734790de607mr3427312b3a.8.1740455188892;
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
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
Subject: [PATCH v2 1/6] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Tue, 25 Feb 2025 11:45:51 +0800
Message-Id: <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
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

Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
table parameter is actually struct ptdesc * instead of struct page *.

Since struct ptdesc still overlaps with struct page and has not been
separated from it, forcing the table parameter to struct page * will not
cause any problems at this time. But this is definitely incorrect and
needs to be fixed. So just like the generic __tlb_remove_table(), let
generic tlb_remove_table() use struct ptdesc by default when
CONFIG_MMU_GATHER_TABLE_FREE is disabled.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/tlb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b35b36fa7aabf..54f579750c8e5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -232,10 +232,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	struct page *page = (struct page *)table;
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(page_ptdesc(page));
-	tlb_remove_page(tlb, page);
+	pagetable_dtor(ptdesc);
+	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
-- 
2.20.1

