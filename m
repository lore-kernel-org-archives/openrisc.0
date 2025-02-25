Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8A1F5EA
	for <linux-openrisc@vger.kernel.org>; Tue, 25 Feb 2025 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455181; cv=none; b=FUvxfgYHh186vXDuSfnFEkQah8FTLamQ/mx/yekI80QykNTmrckgoKOXjtlU8yUvSdYRaZuZWfDOdoJG/x+xQasNR6mI0UKAOLRNqakk+1YAB+dFEUj2M+LDu714ynnmSlMfW/ojS2Kcx2oMzUDUrVbtcH62FaLx+vK3B+wbU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455181; c=relaxed/simple;
	bh=Xarqt6bJuNP7uDohIoZXfOCmOa/TOsimsTJDUmQhEAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QOw0oOM7gaL6QQNGs4ieOwX4NgzjrQB3rMP7VLvyYQM65HoL1FeWf+5G/7gPQCknfGT4bJK0n2MWWqYbbB7mH30R/sQa0RFxkUFszVh25ckQBnKoibdD9C22kwOwkClAqfBruaexvTJ5ZNrWsHxgvOaFmOnUEcHTiv1TRcbPgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gdYlHQw6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gdYlHQw6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-221057b6ac4so98032305ad.2
        for <linux-openrisc@vger.kernel.org>; Mon, 24 Feb 2025 19:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455179; x=1741059979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=;
        b=gdYlHQw6UMjvN66luBcJmpWC6mmBua2s+rF8MRPWFK89E4pqFtOL2sKZqJrZVhYeoi
         h0Az2B5W1RBkBDeXejxczzYtLaSHKgpaSe5nUZHyxE0sWPvVQ7egJNVQDD1ys4IP3awN
         qLM6wTWZZd+dWGjMGYn1T6VnY11ntvSuzT5g+i2JYvUa/QhroLjt1YE7cACEwy43Tlpv
         jo0AVkh3/z21TprOUpO6VJXxdZ5N+k1uTSGjpctRfwQfY+oc+T1qk2RWReDM4epWndH4
         L/VBJ1fD2gDNNbcNJZPmjF1uMUrsJieVg2ui5gAb/yK4rfTB3LlvdY6TbmJofmZ5KAbk
         G/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455179; x=1741059979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28rhiB/GEX2aHidRfZsL1f1ynE4sxX3e1xrVD+t+cg0=;
        b=mkLaF5YG4ZNSDf1zn2WsQ+kXQM2OOqnjPQ7yQHoXPKUMj5WdVQXosDi7UglzECaLxm
         8fiVkTrlN8r90YIUS2YxeEO6FUAEoyd98TUtuVmbQK2ZuR1+O/qfyBDhowejftB4hYxa
         ST4LepkSNGf6fx/xnCCoeqX0X3NXyzqh2obnjHKoux/2DO296wiw3BgwUnOEgjLBy4VW
         ScXSnsqFX4FflkVk4MxRj70B2alK1OZiaMONun2yVLHx8GGyxCPJGMr/YfblnaUC3b4j
         A8B4i/GNT7CLGH2m6/eQfEnfjw0EH+N9DOK42FiD8+UsjmWtljEr+RC+oXWpKfptV4L4
         Fjcw==
X-Forwarded-Encrypted: i=1; AJvYcCWUFqR85oMisGugN7vueVClnhm8wnXIcwpz2kpna2PqWnNWRreYi3kgSnrAV9Ga82q3pLqHKHJLItfuaFUrZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrnt0sGOEpQR9+4KamdVJl6dvnsjrmvJXT3DTM6JhEVKujykUR
	QmEYYrAf0DSv9/vpHF9QBmP/lxqceG9jvzI5SS5zoyRNz02GDXtuGXR2U2BKnZk=
X-Gm-Gg: ASbGnctO2IpYCHou5KqGNoorg7ylb+HTeOTqI3Vceu79JdBTn5V/u92pORin4Z9rpuI
	Ln5cdHA1DgbaLt/a5o/FBt2hm5F4qv73Ytptwl7f/GO6wsj974sSn+dM/RnCeV7LTNFCRx6IGgH
	hLUZZ1DU+zP4NBXl1Pv5+zzyGMrOXYfWva2IZd3Miq14LzYK566xwuTrn/hbD5PzY2GGKXLKZaM
	1iKJI3QmWbvIdyaO4hucKJzlDKLbIZtWL5KB2ZgzbdFS6g/X7rfrqMuanNCVzyn2+5M+6/2Zg/Z
	8KstACsajr7bpzxsO92GWjFTJMvg+gQvTQjY3LlmHYISmB6AyeiftKrlksdKLGhWag==
X-Google-Smtp-Source: AGHT+IGCQV+aaAngRw7XrsDoRTV1d2A5MeKYpMO11TDMI4tHHu1SHT60kqvv/nxGByOS3x+4jf7H6Q==
X-Received: by 2002:a17:902:e744:b0:21f:89e5:2715 with SMTP id d9443c01a7336-221a0edd8cbmr248196785ad.19.1740455178926;
        Mon, 24 Feb 2025 19:46:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:18 -0800 (PST)
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
Subject: [PATCH v2 0/6] remove tlb_remove_page_ptdesc()
Date: Tue, 25 Feb 2025 11:45:50 +0800
Message-Id: <cover.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - add [PATCH v2 2/6] (Peter Zijlstra)
 - remove [PATCH 4/5] and add [PATCH v2 5/6]
 - rebase onto the next-20250224

Hi all,

As suggested by Peter Zijlstra below [1], this series aims to remove
tlb_remove_page_ptdesc().

: Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
: there should not be a page-table anywhere near here *ever*.
:
: Yes, some architectures use tlb_remove_page() for page-tables too, but
: that is more or less an implementation detail that can be fixed.

After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
to remove the page table pages. In the future, once all architectures using
tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
may be possible to use only tlb_remove_ptdesc().

This series is based on next-20250224.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/linux-mm/20250103111457.GC22934@noisy.programming.kicks-ass.net/

Qi Zheng (6):
  mm: pgtable: make generic tlb_remove_table() use struct ptdesc
  mm: pgtable: change pt parameter of tlb_remove_ptdesc() to struct
    ptdesc *
  mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
  riscv: pgtable: unconditionally use tlb_remove_ptdesc()
  x86: pgtable: convert to use tlb_remove_ptdesc()
  mm: pgtable: remove tlb_remove_page_ptdesc()

 arch/csky/include/asm/pgalloc.h      |  3 +--
 arch/hexagon/include/asm/pgalloc.h   |  3 +--
 arch/loongarch/include/asm/pgalloc.h |  3 +--
 arch/m68k/include/asm/sun3_pgalloc.h |  3 +--
 arch/mips/include/asm/pgalloc.h      |  3 +--
 arch/nios2/include/asm/pgalloc.h     |  9 ++++-----
 arch/openrisc/include/asm/pgalloc.h  |  3 +--
 arch/riscv/include/asm/pgalloc.h     | 26 ++++----------------------
 arch/sh/include/asm/pgalloc.h        |  3 +--
 arch/um/include/asm/pgalloc.h        |  9 +++------
 arch/x86/mm/pgtable.c                |  8 ++++----
 include/asm-generic/tlb.h            | 14 ++++----------
 12 files changed, 26 insertions(+), 61 deletions(-)

-- 
2.20.1

