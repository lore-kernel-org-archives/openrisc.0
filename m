Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EDC433F5
	for <openrisc@archiver.kernel.org>; Sat,  8 Oct 2022 05:01:07 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 88E31240FC;
	Sat,  8 Oct 2022 07:01:06 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mail.librecores.org (Postfix) with ESMTPS id 0D3D524A7F
 for <openrisc@lists.librecores.org>; Thu,  6 Oct 2022 20:33:09 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id m3so4014183eda.12
 for <openrisc@lists.librecores.org>; Thu, 06 Oct 2022 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKHVp+kV4VpD52SNKA1S+0iOsNTU9D0543PwIuQ8jUo=;
 b=I+GlNf3N+ahgpw5OsfAzC6OUVa8C1R0tcpGZKpUjwKayiaCgYSCjGAF3EOkXazM96U
 XHx/oJGgFGGh1LF1LUXtxbTh/3U/mfcr+ONOaAEp/yYTldYTqsXXCeMPicqkreanRJ6V
 r+hL+TByS4F4LsXXw/Mr0978znx/MAhrI8CT/df8uHfsJES2bA1pXv09GbO6/kAevtnv
 b1rIp4LPPUvZTo33YUqD13oaEF1YXtN7aaWFXx9T8OArzFEWNyxlBXP/GnzRFhUs4ylq
 oNzA2fzNhXGXO5zqJDw1XDGPn88Yki9L6wSyjQJ0vA+0pU1NPA/f2ZN0lcuchBIQRS8x
 W0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKHVp+kV4VpD52SNKA1S+0iOsNTU9D0543PwIuQ8jUo=;
 b=tB6lTsW1MU2I2jpLOZQNtQDCZCE9cIRdT2yzZ433TIOE62+p0IXGNkeNutWnDLpn1n
 UB9TFCwcdJyVi6JmNZRGvsTNKGrpiMOn7U6pztMZjl1jHCo+6VQ6dIf9PPNi51WWBAYe
 9i+VwdFsX/Yrqb9CNj57Saqnf+ZsTB+UCwLOSo8QP7J//FfBmPMN3fD7WR5T/OezB2E6
 tOYyBgixxePX7a38POiowmwM/mXoTzh8C2ufNpDf3XEnnoUSyUYnMO0vKRIjKvPtdHAF
 rhKHp8Gcu4+dufyvi434fMXJ9v+DJL/hxVBEDxclAhLMKVnfDLi/0oGIvbQaY3R6aXfL
 zI/A==
X-Gm-Message-State: ACrzQf1Nrvl+R4JeM8dFN15Dksv6l/qlG59Mi63O8zBdSnCzg36sthCV
 p2vktQp9ivw+5dz7PlVQts1Qfw==
X-Google-Smtp-Source: AMsMyM6ZOd6I+kgFxWj6J7CK0eQjyO0Os/Dk+XSt92UdXNHmavd8jc8XD5X7hAEtKJt/vlv9P61U6A==
X-Received: by 2002:a05:6402:3221:b0:459:61c3:eea0 with SMTP id
 g33-20020a056402322100b0045961c3eea0mr1088310eda.225.1665081188349; 
 Thu, 06 Oct 2022 11:33:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:96ba:f291:aa3b:107e])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a17090623e900b0078a543e9301sm19701ejg.200.2022.10.06.11.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Oct 2022 11:33:07 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached
Date: Thu,  6 Oct 2022 20:33:01 +0200
Message-Id: <20221006183301.1891131-1-jannh@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 08 Oct 2022 07:01:05 +0200
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
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Since commit 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page
walker"), walk_page_range() on kernel ranges won't work anymore,
walk_page_range_novma() must be used instead.

Note: I don't have an openrisc development setup, so this is completely
untested.

Fixes: 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker=
")
Signed-off-by: Jann Horn <jannh@google.com>
---
Normally I would CC stable on a patch like this, but openrisc is mostly an
in-development thing, so fixing stable kernels doesn't matter much, I assum=
e?

 arch/openrisc/kernel/dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index a82b2caaa560d..b3edbb33b621d 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -74,10 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
-	mmap_read_lock(&init_mm);
-	error =3D walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
-			NULL);
-	mmap_read_unlock(&init_mm);
+	mmap_write_lock(&init_mm);
+	error =3D walk_page_range_novma(&init_mm, va, va + size,
+			&set_nocache_walk_ops, NULL, NULL);
+	mmap_write_unlock(&init_mm);
=20
 	if (error)
 		return ERR_PTR(error);
@@ -88,11 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t siz=
e)
 {
 	unsigned long va =3D (unsigned long)cpu_addr;
=20
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
=20
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,

base-commit: 7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf
--=20
2.38.0.rc1.362.ged0d419d3c-goog

