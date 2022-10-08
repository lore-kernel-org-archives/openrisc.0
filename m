Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DC9C433FE
	for <openrisc@archiver.kernel.org>; Sat,  8 Oct 2022 05:24:30 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 27D8A2496F;
	Sat,  8 Oct 2022 07:24:29 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mail.librecores.org (Postfix) with ESMTPS id D3ABF24929
 for <openrisc@lists.librecores.org>; Sat,  8 Oct 2022 07:24:28 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id a3so9951921wrt.0
 for <openrisc@lists.librecores.org>; Fri, 07 Oct 2022 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/wiztzuOtCEU0Qby3b+Cjeapd1qrW2PKoKDkQzm29WU=;
 b=RcbW3GVtlnHb05sjjXDPAtbaHE2bUV0gUQ+qdGkL/3DfBMSyhZq02EpY/OU65jQXYC
 CfDvhaG/pDkAwsXPEkoAesBN3CapZZU0HssG60cEL33syEEoRHG+U+QpQdsfr8EF4fA9
 ecbP4bA7ievotCrf+0pL6izpuFBav/HIcinVZ0imW9SkFHoMQD+pyLWFsEXWfmoUBRUW
 D8dtLZRaCWU/YH1ipiZkCNy1U/snEqyGvk3i2A8652v/JmUDF3Usg7ze6UmKlZsDIvs3
 b3V3xQg9KDwiQvLPdZgrXsHx5Eyj8PrDFbBy+3Bv72trEpYH+G6VBGu88T6fmR83kCpz
 iY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wiztzuOtCEU0Qby3b+Cjeapd1qrW2PKoKDkQzm29WU=;
 b=tf3b6bl5dkki59LpXm9ojGAFj+Rk6B00hQm6c1f7HQ2LFErdu9vSXz9YIDSQQ0L/KW
 gr01x5IWw5C2YKZ5rmASmcioVTW8xHvfkPZU/GnnCQblfShJ98uCQsr2AiO+I8hg4fQK
 0SRBpVRJdYjVjIbkdIfCeGo/h3y+Gyzm+6f+y7FE6TpLI+h2eYbnUPs4SqX3lZXCZwVL
 CvFUKK9p+WxuU8kh6uiNnmOYCWR6VXQrIuyE8KFaxyZ9eqUQddd6+mQWcOZBEHIU15Ob
 hGoyD3/nwiul4UgvBC0Iq04pVFVkATCX2MJxkjp29s1sib3XgwQFy+G4Cpmn0A46vN1Z
 zkhA==
X-Gm-Message-State: ACrzQf121ZRFXT4IBg12NAf1mM7Phrp6zYGtJY9DOqCzk3rAo5pbUpOD
 fVWW3Lmn0S+hURevfVq2PpnyHIpO82g=
X-Google-Smtp-Source: AMsMyM6+sI0N/LOg+PomLfgsupYRT76OkFfck2VOI4p2vwVvqWetsIPnWTbBQEKKEHdKqU36eDO10Q==
X-Received: by 2002:a5d:6c6f:0:b0:22e:3fdf:4b27 with SMTP id
 r15-20020a5d6c6f000000b0022e3fdf4b27mr5224179wrz.150.1665206668299; 
 Fri, 07 Oct 2022 22:24:28 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 iv14-20020a05600c548e00b003b4c40378casm10513537wmb.39.2022.10.07.22.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 22:24:27 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached
Date: Sat,  8 Oct 2022 06:24:21 +0100
Message-Id: <20221008052422.29695-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, Jann Horn <jannh@google.com>,
 Steven Price <steven.price@arm.com>, openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Jann Horn <jannh@google.com>

Since commit 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page
walker"), walk_page_range() on kernel ranges won't work anymore,
walk_page_range_novma() must be used instead.

Note: I don't have an openrisc development setup, so this is completely
untested.

Fixes: 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Repost to include LKML.
 - Added my SOB
 - I tested this by booking this on the qemu virt platform and it works fine.

 arch/openrisc/kernel/dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index a82b2caaa560..b3edbb33b621 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -74,10 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
-	mmap_read_lock(&init_mm);
-	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
-			NULL);
-	mmap_read_unlock(&init_mm);
+	mmap_write_lock(&init_mm);
+	error = walk_page_range_novma(&init_mm, va, va + size,
+			&set_nocache_walk_ops, NULL, NULL);
+	mmap_write_unlock(&init_mm);
 
 	if (error)
 		return ERR_PTR(error);
@@ -88,11 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
 	unsigned long va = (unsigned long)cpu_addr;
 
-	mmap_read_lock(&init_mm);
+	mmap_write_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
-	WARN_ON(walk_page_range(&init_mm, va, va + size,
-			&clear_nocache_walk_ops, NULL));
-	mmap_read_unlock(&init_mm);
+	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
+			&clear_nocache_walk_ops, NULL, NULL));
+	mmap_write_unlock(&init_mm);
 }
 
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
-- 
2.37.2

