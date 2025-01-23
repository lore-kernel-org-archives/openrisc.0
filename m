Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042220F98E
	for <linux-openrisc@vger.kernel.org>; Thu, 23 Jan 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638912; cv=none; b=LNkf4HKC9e2tS/crGFOjtg/7zXWg6qtwrMmWgGVGvtH2OBGLNFjxXdQWRHfk6yDitMb+LveUGJxC2FpPKZWoPCguvYELnsfxMuxpEao0/t5C5cmLWJxzx/lLlkEQcISWghatyXNEEXdBYlA6gtA1RVX99IPLxmW85vteajJtEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638912; c=relaxed/simple;
	bh=FefxEocj4IoJjXKARUpJHCYOj+T2Zg9VgaSRz05BYQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYdvpaHgI6vIi0mSri35W3V6Nyq99x7Dm5Zs8O38qwnqkuPxWlczlPh1Af9yeKCkgAcGbVIW4i2fWjlR0hPyi27l/mXWyDY09dMQ+VmTM9NkwNCQs5l54ld2SWqp18KFA+sUIgbXh7K1CMgAZkEZm4B69n0/KQz0dzB0e3sYLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PebiQot1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PebiQot1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so16873275ad.0
        for <linux-openrisc@vger.kernel.org>; Thu, 23 Jan 2025 05:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638908; x=1738243708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=PebiQot1rb6XbHbzslfJsKpQcKPxtVRWfvW44wiTQeZcn+FPb2jW/MNDRjdLx6k8br
         3442zb+LePJbf/eefreQDFW5bpNEpafOYF7xTQDkFXzsr+9Bbcpie1mckFpTKNXbUxAr
         Icdp3NKqYa9Vu8Wy47GHD4CXfEBFbujZ9DFs8y3+Ee7kHhTyn5o/FFBAmrU4zOwkWyZc
         UZMf6AHZ7e+UDvM9vymXCA7cWG/T++ephvUmyUCJnhiL5wmVftKMsdQMTigMvTqGAuvF
         KJdGHNU6mSbcLgett1i/pz5tgCxaiRDhYCZ2Zoc3DkRyqRYo7Vzi3ggEu7/h0YFGZxgr
         qcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638908; x=1738243708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=lUvE3YKuKQyKBFWzs3X6UKvJJTl3zCq4e2wlMxwSDrGMYIt05ldgGFVdRJ74WG6QsJ
         4brAV98ymiNnFJS6dAKfrlRgudnbvFWZfHXnuLNKJeJ1Tdz26z93NWjj1gO/1k2Rd2MU
         Axb1/zrTIp/GK18gzsA1ah0c+UJceFmMYNxPGirkhwf5pQPu2Apv/YnUSU6cU0xm6F8N
         UJhU2quxkIw52ZJehxgOhMWYYgRzGvBx29Bq3JYK2q44zSz9YjWZT2V2aMW2f12FBhgm
         r3xcaGTNEJCZf/OJDUWd+6GSV06rybx0wtT+O5q9CVtxEp0vuXXP2nIlPMyo0/+slZsG
         csuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVevCi9F2PwsE2rx0Y7SIW6LvHYf9LiEf2DJ9aJPkqx738+doKMG15Rp/JvHKTphxoYG+WB79LJPqyC8EW+2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RDyg3twgUm3Jhm3Bp1+Sd+5zn64aTpOCj8EFQ5obhT0hkWBF
	yNOZZuh1uAXsRixTfl+y5USG9h3xR6O6plv5OAui06qHd9Cg42DDDdTJIt/6mLM=
X-Gm-Gg: ASbGnct5ATzjXGJfB76LNe7VLbPA+gHzRNZY1mikj2R98avKflmcKWAAy1mSOvn+fTG
	eOxurejkvn/R8TejbkztbuizYBGRJnmiXu9M0rMGQ2X45AxkSFU9V/LqW8Px7VE2pOkhPMFb8Ur
	9pi3vVKLdkgQHfg1pba4yTvJaxewzfKOr6JIngV+z7N7TddnoIYSXraq34AngqZmcn8nviqc9D9
	yeSbSfh58A90Dmvwgmg57eVcEAJl6JspKlQ+VMgIzxtfbY+agKCFlSBqVvXuytIHDeMG/rYpqR7
	XrCb4aVE47ZM0w8xtMuH0mbTfQSeixnjn0mMzRHbfke0
X-Google-Smtp-Source: AGHT+IGvH4jPt9gEk2i8wJlEQCGHtq7Z8F/nhrt9cHdxqXKECEeUfNk2qVC/Ig+lLuwaqRjslO9WHQ==
X-Received: by 2002:a17:902:da8d:b0:216:386e:dd8 with SMTP id d9443c01a7336-21c3540cd05mr367659545ad.17.1737638908563;
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
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
Subject: [PATCH 1/5] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Thu, 23 Jan 2025 21:26:14 +0800
Message-Id: <e2a1b07eda16eb84bdc51f6227fec02f2c0a54f7.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
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
index e402aef79c93e..10cdbe0e7adfe 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -228,10 +228,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
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

