Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B92E370A;
	Tue,  5 Aug 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383301; cv=none; b=fXXRbkZVm6gLDtr2vUzGwGw2/uJ7DzjriOR2Zm69wd1iFWHKAIe73BXoxYfEb2cX2DqiXaycJ0I2ykRL01RWUdMJYrAXGhOz2MZeotQCqv4fUpgscD0CETdxbQEPakbeejc0Leeng55UxMKy7I3pWWB7az2SxTgsejfI05iZWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383301; c=relaxed/simple;
	bh=vrVX00n4NgychyfD3mLdp1tlITQ0TnqV6fDFIZEKQQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqWCrbgWeZ8zBZB0UhL8j2+DHe1iV7xx9oHOjxR+58BgV7LDK4oPvqoJWGW+cR3G7LQQGp1mYE3h83/LCVcihF8/U1dLmCKE7HmLpHq2+kLMgUJVUUkIXg2MaaAaUQSEdXx7K2gzdtEI2VsWEk0dlTGQSPyBBOlWAQrDEXkiYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV6XsWYD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV6XsWYD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2403ca0313aso42917965ad.0;
        Tue, 05 Aug 2025 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754383297; x=1754988097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1HC+HPZ0PIyj32+UCRv8XB54ETxx5jXRG1Xe0qQ0bg=;
        b=jV6XsWYD/Wu2utJv+PBDWQu5sv2HgRe/zfpnf5ZUSFO5EkPQSsvnO0AxSh0teI4gwX
         Spb5T3k8QhJith70SU8i9iIoXI0l2wpm+boIZR25sRnbGAFMxaUGV2SZYkMjYXKUiWh+
         Xi0z7sYYID8fX74swC5QgDNIy0UZ0MypLvlXCj9MB7MXCOeH4DoeYDXu2unQJnfnN22N
         LrvQ/tsaPZ/jhHwnlHqLMtNMboIicn5UrpZh3joR1ZNf/rdlqVVF5jDlUD4nWWE9eQwe
         KwQzDVC32dsqHTxiM4PaOwvfyf9N1pMlU+3SlEXixKo4pwkcnk8HNWZEIXNX0Mbbp+/P
         4Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383297; x=1754988097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1HC+HPZ0PIyj32+UCRv8XB54ETxx5jXRG1Xe0qQ0bg=;
        b=RhRL3Clmp2bGOJ86LShZ2nW5Ua7pVlrCp+md4JCoSMDgNEABBpD9+BuW/Wqwpz8G7z
         179I9ARdBXZFRhMORHq56T8lgLcPdNsuCtm07/bpmB7dqCiLw78GFineywcqRx8BwgCY
         pIRWX7LjRxqrGMPScuH4SAMqEHLYLGM1AubP3smqnvB3PEEdobWOzFqDW2TY/5rKAT3z
         6jq132GGnYGcRR4eQIznGQ/MJ2TWCGL4jOblL/SlnBbT1hH7UsNXLm6OPFczxZlHkpa6
         V2qbUdbB3tWNy4Vaiw51FcHbxJ1OYk9oS6PoqrhspQUrUvHdRCQl6i+/5YTdPQ5f4HhY
         IWJA==
X-Forwarded-Encrypted: i=1; AJvYcCXP1LXM2CICWPEInCo/IgrbxZWjgSM2qZ8TKHsXvzGYkEgZGFv9PF1ZN6Pt9UiL6QCb3E4o2S9NwXb07tYtsrE=@vger.kernel.org, AJvYcCXx5BuSOohwIiHipVAFRGTVv4pLNIlJeQjTAr3YokuDZvgeBGqxbDBAvNNg0UJW0uQck8Zpz/QtgqjYSsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dsubpbWjthw52Btm3FmdkaIrzkZhN1xNFLG5YAOly6f3HUT+
	LL4GcV3aTW71oVSzRGvjMuJhNXIXsbvLUTi54adZXaA92fme080R6DFl
X-Gm-Gg: ASbGncvWOHKq1ppf+DVRVFSHABzpUe5brf+kqrzwVGpP86B/tKBMZ7hJj2ltNAbwRaF
	MDMBtoyDZFaPKUHHZZIvTP5W6poWnpQAumWaJ/fFLzWPdWRHWRx6TJMJT6XATeJTGczZ45pj2CY
	Guk5NVP2pDIcS5EPKPrN8u8tGFrcwgC9MH1poNOn5YWuCnaxrnf9ar5kV5JKkCZvefxR3GPWrKE
	qA1cFQ7jTt9qrz0swprQCZEKoVZvEkDWiThdV1eJwqt/HY2c6hvN4UHlUuqj9Kb81V8ltgtnkSn
	BaDSoe8TDCSP/myJQcCkq4tf26g/NiMBIveyWrUm0Rc0D8KCPgIrNBo68xmlKyDVM/obuahES6m
	pWi1aAorxrd2FcNfZpjFoNSpT1Gw=
X-Google-Smtp-Source: AGHT+IFWyufrGlvyPfxj+kUY9mIupE900ilLVdLjMJwjECEy0UgNCbP//2momS0M4SeGVu+L7iicVQ==
X-Received: by 2002:a17:903:32c1:b0:234:b743:c7a4 with SMTP id d9443c01a7336-2424701ae4fmr196698665ad.38.1754383296700;
        Tue, 05 Aug 2025 01:41:36 -0700 (PDT)
Received: from nyaos.. ([141.11.79.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7d96sm126981995ad.18.2025.08.05.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:41:36 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: chenmiao <chenmiao.ku@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-openrisc@vger.kernel.org (open list:OPENRISC ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] openrisc: Add text patching API support
Date: Tue,  5 Aug 2025 08:40:57 +0000
Message-ID: <20250805084114.4125333-2-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250805084114.4125333-1-chenmiao.ku@gmail.com>
References: <20250805084114.4125333-1-chenmiao.ku@gmail.com>
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
index 000000000000..4c3d8a6a906a
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
+int patch_insn_write(void *addr, const void *insn);
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
index 000000000000..2b979a0bc584
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
+static int __patch_insn_write(void *addr, const void *insn)
+{
+	void *waddr = addr;
+	unsigned long flags = 0;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = copy_to_kernel_nofault(waddr, insn, OPENRISC_INSN_SIZE);
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
+int patch_insn_write(void *addr, const void *insn)
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

