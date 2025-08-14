Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3D1A9F9E;
	Thu, 14 Aug 2025 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142062; cv=none; b=IdxJZLOf+1XRs6aLgC2ExNnG6qen6X9KwJhJOwcfY9UrTPN+a2KNuWKxLEIEzwC7u2LJPnPaH8qLQe7CtPoP3aVzRRe0JTQxEBNAsJ6qcxS7f8jA9ylcoe53qw34bwGOuyu+nqWN/nWCuM3rD4038ZtoPGQe6PnUOs0xHfuCbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142062; c=relaxed/simple;
	bh=4paha/HlT7sl6TkAQyu3pluDW/iXskSC/4ZDKp2WyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/UqiY6/LkkXsNkfQnjzbie8BGUKra+HVM0hWWTPu5x5wWlL2O20s+ebzqCnia+QMYP/G0rO5X0NGSuxr+InX76Sjx9l1Ywye1cG3uOWHCLbEBtA5AYsuIqTPeMratIzuuK4dvULeXQqQUmEV0w0T3qd0JqsC95Q3oyow/JI9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSI4wzHJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSI4wzHJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326789e06so440053a91.1;
        Wed, 13 Aug 2025 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755142060; x=1755746860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WrqE+v5L4PZm59cqGTJ6nmR9SkmSoYFPmnwdRNwHng=;
        b=CSI4wzHJ2SIh5xyFVUKiOydMIaVGFtvUS2E+CEKpMkKRHUtgFa+fNYvuCtc28c/uaN
         ZHvTNDsCi0hgqBvHI89klUjjCdporvzl/137jNcIw/S2WHBX6v52igzlAIC8Q9ZL9d8k
         +ui0upedODm3kf6MeESXFl6A2tFpURxSW/BXhfiKUGocCjDlBfIinGghUbVVfGzOZGQS
         lsTmbQNx+7MDzP+rV7/p6b3iW/MiZovE20Msm36O0C8qJQg32xcipniCYPGoSohU7MgO
         R4S8QyqheYtvhjMyzYD4yy3PcTdzWn75Di5EXgjIVZCah9YX5M+Kg+PehzPHdGaBEB0V
         /YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142060; x=1755746860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WrqE+v5L4PZm59cqGTJ6nmR9SkmSoYFPmnwdRNwHng=;
        b=j1e2y6NWPscOpkPBP2EGN6/FRSY88wDHrJETRma8lMcVJaZlbxtR1V9JJ1uDemYMpP
         5uAKpnGWBqXeetFKnJfZRERdmknIED8uwx6/ILkp7FB0lEwG6fP+jPVvMXLWz2URedTY
         gis4IYXIrJLPIiEzla+KOmnou3cVhjpfmMUm9nRq5AL25zOik77JyDBL86YxObjZkiLb
         D+HWfI4czdlWSC3XBX9ls70ziInYfG7gTRjA2Y7E62ZNhtwlpLYh+3tUPtlXvRidqBrE
         NeNAmRlxaRG8d4dbxWHAqW3wCedVusr543fI2LaGxsefLHzeRlYIsRTq43uBcnY+WKqo
         1cEw==
X-Forwarded-Encrypted: i=1; AJvYcCXEtlx4MMNijOyWZNXkEiUukKMnpmSsbuT7E2lo7erQX59vsgetOMaiEvEkPrmmhuSLBj0jh9HXeUJZ4TQJ2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+unGlvWmeQ5LMy1hZ/eFXw2hEQzPlTdd65m4giUY70MbKRJO
	RwTcCCc4LHmSx+/7Y16A0J8iLOGXNdKdDRUm6EpNKiV5EMh4u+J5HvcsmvIr9X8Q+GCbHRJG
X-Gm-Gg: ASbGncuwSBlOzwcARu0y0jYvcOCDUuoDUyqGPZtY8mEGw8Z7zTjJUIYeT5fmIx+32+C
	qQBcgtzQ1K6BU2smk3wJYTVFywPw2N3ndBCW3hdcEZ81XZumZIkLnei9U0Ljcm1LcPRN5MKxO3P
	I2o0M33Lsl9yvD0yE24CS3JWjBL1bqXbspHhdXDqGFiztTyMcMYqwE6S5wyJyvlzboz0qQvI11M
	8ZB4iRjo+slrVIRXHtnriqQxlPHceQec+E4oIPAoP+3F7uPDGFVfOvxZAH3mEbqfr4fxDE1/ZDu
	CR7etbTTZIuDBVtA6IIp444/JT4HC3LPiI6VwhrZRK7WDepUFKBWYVdrq3eBfcganIpqmw6wgHi
	dg0g4LxhwToQ6XSjRmw==
X-Google-Smtp-Source: AGHT+IEMcQEosrugs3FGOX1KUS9BiWtJ6aWaXFFkL8rUt34cDPgPvEakDh8KYD30WvMMDgy4eOy8og==
X-Received: by 2002:a17:90b:17cd:b0:321:7528:ab43 with SMTP id 98e67ed59e1d1-3232b3d19d9mr1507662a91.24.1755142059692;
        Wed, 13 Aug 2025 20:27:39 -0700 (PDT)
Received: from nyaos.. ([45.12.134.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331167ff6sm276009a91.27.2025.08.13.20.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:27:39 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 1/2] openrisc: Add text patching API support
Date: Thu, 14 Aug 2025 03:27:01 +0000
Message-ID: <20250814032717.785395-2-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250814032717.785395-1-chenmiao.ku@gmail.com>
References: <20250814032717.785395-1-chenmiao.ku@gmail.com>
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

Among these changes, we implement patch_map and support the
patch_insn_write API for single instruction writing.

Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>

---
Changes in V3:
  - Removed the unimplemented and unsupported is_exit_text, added
    comments for the set_fixmap modification explaining why __init was
    removed, and added new comments for patch_insn_write.

Changes in V2:
  - We modify the patch_insn_write(void *addr, const void *insn) API to
    patch_insn_write(void *addr, u32 insn), derectly support a single u32
    instruction write to map memory.
  - Create a new file named insn-def.h to define the or1k insn macro
    size and more define in the future.

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/openrisc/include/asm/Kbuild          |  1 -
 arch/openrisc/include/asm/fixmap.h        |  1 +
 arch/openrisc/include/asm/insn-def.h      | 12 ++++
 arch/openrisc/include/asm/text-patching.h | 13 ++++
 arch/openrisc/kernel/Makefile             |  1 +
 arch/openrisc/kernel/patching.c           | 78 +++++++++++++++++++++++
 arch/openrisc/mm/init.c                   | 10 ++-
 7 files changed, 114 insertions(+), 2 deletions(-)
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
index 000000000000..73ae449c6c4e
--- /dev/null
+++ b/arch/openrisc/kernel/patching.c
@@ -0,0 +1,78 @@
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
+static __always_inline void *patch_map(void *addr, int fixmap)
+{
+	uintptr_t uaddr = (uintptr_t) addr;
+	phys_addr_t phys;
+
+	if (core_kernel_text(uaddr)) {
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
+/* patch_insn_write - Write a single instruction to a specified memory location
+ * This API provides a single-instruction patching, primarily used for runtime
+ * code modification.
+ * By the way, the insn size must be 4 bytes.
+ */
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
index e4904ca6f0a0..ac256c3d9c7a 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -226,7 +226,15 @@ static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 	return 0;
 }
 
-void __init __set_fixmap(enum fixed_addresses idx,
+/* Removing __init is necessary. Before supporting FIX_TEXT_POKE0,
+ *  __init here indicates that it is valid during the initialization phase
+ * and is used for FIX_EARLYCON_MEM_BASE. However, attempting to support
+ * FIX_TEXT_POKE0 would introduce a bug. FIX_TEXT_POKE0 is used after the
+ * initialization phase, so __init would cause the function to become invalid.
+ * At that point, using set_fixmap would lead to accessing dirty data,
+ * which is invalid.
+ */
+void __set_fixmap(enum fixed_addresses idx,
 			 phys_addr_t phys, pgprot_t prot)
 {
 	unsigned long address = __fix_to_virt(idx);
-- 
2.45.2

