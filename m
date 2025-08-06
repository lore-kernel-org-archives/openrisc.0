Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FA38DDB;
	Wed,  6 Aug 2025 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445945; cv=none; b=F9iUJQorx7P8KB15t2E3K35z9NyNfFY0Mgzs+TssqOIM3RbfNwc31VSqb8VjnKdaMEoGnSfzoU6FN+LICrTrrQNomUE08TxxufoBk2KFlA5nQUy9qh+IXX57LJFTnWVJNxnuDXXORkvGIuZgJCH1wBw8RYf5amUFaAXvUOp+z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445945; c=relaxed/simple;
	bh=fEtv+udDfu1mrp8T1XAIA0eXwXVYGSLX3DcWER5fqPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2rqj00HuJiBzqgSiNuc+wPtJy6voR3idslGAo2wpsIxTSGh3Rp16zvK9T1pgQT53BFicimpbSCRqgPfj80FtzeQKISpF/tozjI8gtt3i75mDOCPPo/ANq3qF3sj/hGWZLwJR49+5I3pAfi6f1OkXEy2CynE6KJaPgNHLJ/pqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsKW0pcz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsKW0pcz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso5258961b3a.1;
        Tue, 05 Aug 2025 19:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754445943; x=1755050743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoNYurfMf+c5AXh8kF9SI7k55AvvGq8wpLFgk5OQ7i0=;
        b=BsKW0pczpYtUAJhIro13ZuEsC5136WSHJ9z3Wac16knaeJ9JxIrLtaN9sP9aWbaFTF
         7rVbji61IkjhR1etUXFgHRQbYdnvSOFjro37wKIpP5YMeH9bnY5iadsFV0yTQUDo4aNT
         uj+011K5dZDVsTGBT05k1rlnDx4FAbs6d2HYjVEOi4C0oCk1AYzyQCMPqQeuPmMXS5Yw
         Dz1BiNMBIbISOA+/hONj+2pJu1JC3/aTW7JC4twQWp9l8xB1dGIfgj5FK+d9lwR9TEWj
         AM6s8VfWuwNAYAzrO2JdAz5JoA+NV3JXzeXX8sa9aNDIV7P9r3gtGIAqX4rIf5/6ez/U
         W78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445943; x=1755050743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoNYurfMf+c5AXh8kF9SI7k55AvvGq8wpLFgk5OQ7i0=;
        b=uDxl6SjIa0k4QCLCb77hoo8AhZwe7BZWFUPFWuHEp/y3RzVLE9k1JFXTErRWb5NSly
         8id8GMNrq/Z0x3b/5KgY5GEdcITy1kyPVcc/E08s2Ofy4lTLG+2hctexgd5lbxfXVdlb
         CrnneLBnwhSCSio+9+YJ3tpTdb4uDJzqKyZel/HtGtRgQCeOgTEfN1om4MyqsXJDbusR
         OUYyGjU7amjxf5jcsmGSdB/SzEXqpfZ7PQ2kzttki2myn4yYZJxo23Cm6dWw+rNlsFWB
         yXT9ClB0zedV75CciioyTJ3v8qwM2vLbO0eivr0rnnDXiLM3obM++ruW49gL2/CZYf6C
         7JNw==
X-Gm-Message-State: AOJu0YzDjvyMiQq5ZvUB6ogrFLq5Sp97I3VPZls38SPxRPg69jpfKCtX
	WGq1tlVo6r97D9gW8N9ToGnBhtCISYnY7niSYMF+ufJtSWsqmKayHQfWmqmphR+i7xQ4JjUb
X-Gm-Gg: ASbGncsiOIq0+daSCzQBUg5UoitFAgx4/McWL9hZSXAXbspWJH5juWZdTNB7ckAai/7
	YjcUEw8N4+z9NgEZTSXe1bVkN9sHS/0IN5LhBdRVyJejH/kTPSV3JjSgybH7H5mveDzu+VLfNpI
	lftddx1wq+gkon7UYo9S5JiLBYUq0D3a3zHqELAuyA3hLOYHx39IxcD3Jfy65YgbN+HOMxcnPHp
	Jqi1UkHkAqQG9ek7FXysC5UC95yr7lF9zFCf0wvvrtTQGDhvPzvZ+OW1sjILKoQhz1yShlSRArg
	AAxYR4q5IezW5uV20YGWOJEn/QLWSwztTraEa9oBchKhocvcF3TdC87HjLzm4c71wQaOmyRj9+v
	4BmDNfJUpsxUG0JYaAdsxGVxdlvc=
X-Google-Smtp-Source: AGHT+IHBbQiiK54OQv1wx0ex5vSYUUgE5jCznmtUipkVriPtNdr+IrQfAKFRDor/N1QhIedKu3Vq3A==
X-Received: by 2002:a05:6a00:929d:b0:748:e38d:fecc with SMTP id d2e1a72fcca58-76c2a9374e7mr1207347b3a.22.1754445942732;
        Tue, 05 Aug 2025 19:05:42 -0700 (PDT)
Received: from nyaos.. ([141.11.79.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf531sm14068499b3a.92.2025.08.05.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:05:41 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] openrisc: Add text patching API support
Date: Wed,  6 Aug 2025 02:05:03 +0000
Message-ID: <20250806020520.570988-2-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250806020520.570988-1-chenmiao.ku@gmail.com>
References: <20250806020520.570988-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

We need a text patching mechanism to ensure that in the subsequent
implementation of jump_label, the code can be modified to the correct
location. Therefore, FIX_TEXT_POKE0 has been added as a mapping area.

And, I create a new file named insn-def.h to define the or1k insn macro
size and more define in the future.

Among these changes, we implement patch_map and support the
patch_insn_write API for single instruction writing.

- V2: We modify the patch_insn_write(void *addr, const void *insn) API to
patch_insn_write(void *addr, u32 insn), derectly support a single u32
instruction write to map memory.

Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/openrisc/include/asm/Kbuild          |  1 -
 arch/openrisc/include/asm/fixmap.h        |  1 +
 arch/openrisc/include/asm/insn-def.h      | 12 ++++
 arch/openrisc/include/asm/text-patching.h | 13 ++++
 arch/openrisc/kernel/Makefile             |  1 +
 arch/openrisc/kernel/patching.c           | 79 +++++++++++++++++++++++
 arch/openrisc/mm/init.c                   |  2 +-
 7 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/patching.c

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 2b1a6b00cdac..cef49d60d74c 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -9,4 +9,3 @@ generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
-generic-y += text-patching.h
diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
index aaa6a26a3e92..74000215064d 100644
--- a/arch/openrisc/include/asm/fixmap.h
+++ b/arch/openrisc/include/asm/fixmap.h
@@ -28,6 +28,7 @@
 
 enum fixed_addresses {
 	FIX_EARLYCON_MEM_BASE,
+	FIX_TEXT_POKE0,
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
new file mode 100644
index 000000000000..dc8d16db1579
--- /dev/null
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#ifndef __ASM_INSN_DEF_H
+#define __ASM_INSN_DEF_H
+
+/* or1k instructions are always 32 bits. */
+#define	OPENRISC_INSN_SIZE		4
+
+#endif /* __ASM_INSN_DEF_H */
diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/include/asm/text-patching.h
new file mode 100644
index 000000000000..bffe828288c3
--- /dev/null
+++ b/arch/openrisc/include/asm/text-patching.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#ifndef _ASM_PATCHING_H_
+#define _ASM_PATCHING_H_
+
+#include <linux/types.h>
+
+int patch_insn_write(void *addr, u32 insn);
+
+#endif /* _ASM_PATCHING_H_ */
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 58e6a1b525b7..f0957ce16d6b 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
+obj-y	+= patching.o
 
 clean:
diff --git a/arch/openrisc/kernel/patching.c b/arch/openrisc/kernel/patching.c
new file mode 100644
index 000000000000..c9a30f0d1193
--- /dev/null
+++ b/arch/openrisc/kernel/patching.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 SiFive
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+
+#include <asm/insn-def.h>
+#include <asm/cacheflush.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/text-patching.h>
+#include <asm/sections.h>
+
+static DEFINE_RAW_SPINLOCK(patch_lock);
+
+static inline bool is_exit_text(uintptr_t addr)
+{
+	/* Now Have NO Mechanism to do */
+	return true;
+}
+
+static __always_inline void *patch_map(void *addr, int fixmap)
+{
+	uintptr_t uaddr = (uintptr_t) addr;
+	phys_addr_t phys;
+
+	if (core_kernel_text(uaddr) || is_exit_text(uaddr)) {
+		phys = __pa_symbol(addr);
+	} else {
+		struct page *page = vmalloc_to_page(addr);
+		BUG_ON(!page);
+		phys = page_to_phys(page) + offset_in_page(addr);
+	}
+
+	return (void *)set_fixmap_offset(fixmap, phys);
+}
+
+static void patch_unmap(int fixmap)
+{
+	clear_fixmap(fixmap);
+}
+
+static int __patch_insn_write(void *addr, u32 insn)
+{
+	void *waddr = addr;
+	unsigned long flags = 0;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = copy_to_kernel_nofault(waddr, &insn, OPENRISC_INSN_SIZE);
+	local_icache_range_inv((unsigned long)waddr,
+			       (unsigned long)waddr + OPENRISC_INSN_SIZE);
+
+	patch_unmap(FIX_TEXT_POKE0);
+
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
+int patch_insn_write(void *addr, u32 insn)
+{
+	u32 *tp = addr;
+	int ret;
+
+	if ((uintptr_t) tp & 0x3)
+		return -EINVAL;
+
+	ret = __patch_insn_write(tp, insn);
+
+	return ret;
+}
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index e4904ca6f0a0..b5925710f954 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -226,7 +226,7 @@ static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 	return 0;
 }
 
-void __init __set_fixmap(enum fixed_addresses idx,
+void __set_fixmap(enum fixed_addresses idx,
 			 phys_addr_t phys, pgprot_t prot)
 {
 	unsigned long address = __fix_to_virt(idx);
-- 
2.45.2

