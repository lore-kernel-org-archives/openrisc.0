Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15E3314D0
	for <linux-openrisc@vger.kernel.org>; Sat, 23 May 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514617; cv=none; b=azZjpHrhpJwyHxpWzJnPdJKJ3R0SD5kWFnXwW4ZIFxrrBjPfMfJR61zFsP3NusslpNHT6/cj4uZvBKhAIz5++9xT5aNI3j5zRjOyBBbiGF3OBw2kcQL2uBmHZTzTSEqsXx858JUWbvpKNFsPjMCRGQu2SztYOL/d0KlqD1HV8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514617; c=relaxed/simple;
	bh=Ld1JJn+zGIIrv4OfEQcvAVuHm3e1kxZgfP5KYvnpil4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeiezDmczTOsU9hnYZnpbb/WcGGmnEgg8E5CdLKoX1B1XK8CrGUPCFgC4JWgy6NKT53HwOa86vp2zv/QCQ130/QayOwn+cQm+f4NFCgPGOkY29LstxEwOKZibBPaBE2I8AqZ8OgUoFzicBKcf3UO0InJvcb/5yvVgLBqaSSCDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQeeVL4Q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQeeVL4Q"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ea19f412aso1692679f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 22 May 2026 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779514615; x=1780119415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUwKR3yq6fKwgsxnrOqNBKyVRzqIoUnbsdF3bmKoKC4=;
        b=VQeeVL4QUyCLjLvwJHM1Yqzxhyzk5qt82EpvewGnJZENq4vOseqQLyuzzr1Vq17HRJ
         W2Qr/YFxC9ycyMYHMVD6YPD4AyIrQj12F/HHhg9k3hV+6x/7JtlzqxmuDbdWCnZapBmU
         pd9cwbOtTD4Z5fCR0wHOqHaaAKqjCYRjougNWfR65WBeDQ7+nyL65h6+0MkI8ZTNTqnO
         Sc1mYu/A4kIytUkJ55XLlLBsIeNvqtyyP4lXFNAyv2DJp4V0fU2eDpL0gFepv5zj9DF3
         Z+EGcJrWbVJlFMtoc9W57WlhU9aoDPfvBsinFUnMzOPcfFQE9Q8W3kd5aw4Atrd4r08i
         IYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779514615; x=1780119415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUwKR3yq6fKwgsxnrOqNBKyVRzqIoUnbsdF3bmKoKC4=;
        b=afLuZ0CKImRTE/qgO37ctSrRqkoWAuiXh5X1qKd+I12rXNNjhPzde7XOKtNi55IEF5
         Ydgpy/2O+gbbKcVOnEBOv1JQ4jFBjvFFDy1822w00ByTj4dd1IhrYEynnGnbjzNiuvJ6
         Eq6ScydOuthhliCbdRnvaFxi1IX9+N352i1ybylATQNigCZUt1FIH9n1Bmq2PF9dxuqF
         oIlGrCMSIt+YAv8tHDUtAk1CIVetdCXPfty22qmKWI26eTg477ZMBhWQG++1i1JdSKE6
         qzO2r12pTJ2oVzxXQ7HoIkTZvQX9n1zMGTpTfUFpfF14MVXAHyxIL77HE2j8Fl2p8KG7
         k5qg==
X-Gm-Message-State: AOJu0YweGWiUJ1o2/fwWs1Utki1m78Nc/qN3BxcVTYc2cEHQ++MPCHiT
	/f0silVQ89qsruawumMcydWnM4tdwdg9Fa17L3jEWLsnCLXnSOt24zQ3
X-Gm-Gg: Acq92OGLZVFya00c3Q4ioRxqq+kadLCTNJXccQlHs+51azljO0cG1KuEGgWQT/RTDYV
	vwNo9vE96ZtvJK31Pe/HHWYTPfI1dEDXsjenxMxUkenGHi/KiNKQio+jQOb8U4XglB/T4hJIxLh
	qx+Isd77bc3e6RW9nSg7Q7xYTAcG3zYmLnN/FDIaNwfwZAY3ja1JARpFRTLu6UMc5bSvFUgJDTV
	87JjYMiMRKheImQI/T5rWVpFo1FxcVvM450gRPibjO3OvTF4yn45InLRn8LGV4AakxWz3mY/Rn5
	7bctLg6xrJvFgw1C9tmTsnj8lfDmWa9x7EXg+A58Vno9kRypwuEEyR1u8W+gRYLKB/94UmDiukh
	c9DxG3tc7XKaw0Ma318uxTZ9Z+mtGqivXtPZ/vycj1yX6WCKyhYm85qrl0freXa5G9+nUzvds8K
	ZNITqGCbBTiXApgQrixxT8bjgo8MUahLScNFM1EJ4w2pboiXif8YlwlOIL9xui7hKASSP0dc+RU
	vPBsw==
X-Received: by 2002:a05:600c:6287:b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-49042ae285bmr93143975e9.31.1779514614442;
        Fri, 22 May 2026 22:36:54 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f6ffsm9336779f8f.1.2026.05.22.22.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:36:53 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	stable@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 2/3] openrisc: Add full instruction cache invalidate functions
Date: Sat, 23 May 2026 06:36:17 +0100
Message-ID: <20260523053624.630443-3-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523053624.630443-1-shorne@gmail.com>
References: <20260523053624.630443-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to invalidate all cache lines which we will use for
static_key patching.

On OpenRISC there is no instruction to invalidate an entire cache so we
loop and invalidate cache lines one by one.  This is not extremely
expensive on OpenRISC as we usually have only a few hundred cache lines.

I considered using the invalidate cache page or range functions.
However, tracking which ranges need invalidation would have been more
expensive than flushing all pages.

Cc: stable@vger.kernel.org
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/cacheflush.h |  4 ++++
 arch/openrisc/kernel/smp.c             | 21 +++++++++++++++++++++
 arch/openrisc/mm/cache.c               | 16 ++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
index cd8f971c0fec..7b8c043a831d 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -26,6 +26,7 @@ extern void local_icache_page_inv(struct page *page);
 extern void local_dcache_range_flush(unsigned long start, unsigned long end);
 extern void local_dcache_range_inv(unsigned long start, unsigned long end);
 extern void local_icache_range_inv(unsigned long start, unsigned long end);
+extern void local_icache_all_inv(void);
 
 /*
  * Data cache flushing always happen on the local cpu. Instruction cache
@@ -35,10 +36,13 @@ extern void local_icache_range_inv(unsigned long start, unsigned long end);
 #ifndef CONFIG_SMP
 #define dcache_page_flush(page)      local_dcache_page_flush(page)
 #define icache_page_inv(page)        local_icache_page_inv(page)
+#define icache_all_inv()             local_icache_all_inv()
 #else  /* CONFIG_SMP */
 #define dcache_page_flush(page)      local_dcache_page_flush(page)
 #define icache_page_inv(page)        smp_icache_page_inv(page)
+#define icache_all_inv()             smp_icache_all_inv()
 extern void smp_icache_page_inv(struct page *page);
+extern void smp_icache_all_inv(void);
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 040ca201b692..65599252f3d4 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -346,3 +346,24 @@ void smp_icache_page_inv(struct page *page)
 	on_each_cpu(ipi_icache_page_inv, page, 1);
 }
 EXPORT_SYMBOL(smp_icache_page_inv);
+
+static void ipi_icache_all_inv(void *arg)
+{
+	local_icache_all_inv();
+}
+
+void smp_icache_all_inv(void)
+{
+	if (num_online_cpus() < 2) {
+		local_icache_all_inv();
+		return;
+	}
+
+	/*
+	 * Ensure stores complete before we request remote icaches
+	 * to invalidate.
+	 */
+	mb();
+
+	on_each_cpu(ipi_icache_all_inv, NULL, 1);
+}
diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index f33df46dae4e..2667d90691b5 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -63,6 +63,22 @@ void local_icache_page_inv(struct page *page)
 }
 EXPORT_SYMBOL(local_icache_page_inv);
 
+void local_icache_all_inv(void)
+{
+	if (cpu_cache_is_present(SPR_UPR_ICP)) {
+		unsigned long iccfgr = mfspr(SPR_ICCFGR);
+		unsigned long sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
+		unsigned long block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
+		unsigned long paddr = 0;
+		unsigned long end = sets * block_size;
+
+		while (paddr < end) {
+			mtspr(SPR_ICBIR, paddr);
+			paddr += block_size;
+		}
+	}
+}
+
 void local_dcache_range_flush(unsigned long start, unsigned long end)
 {
 	cache_loop(start, end, SPR_DCBFR, SPR_UPR_DCP);
-- 
2.53.0

