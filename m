Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4729AAEA;
	Thu,  4 Sep 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980093; cv=none; b=hAvVO8WfNzWEOp/JeZpqbtZwgmUF5q+G/eentU2PJOjDRSeo5S8AUsdPvom3+ls4WVik9/DI0jq2Y6EYsvHtHfm0vpDNXMz83UL7xHoClPyz/j7L1Fu2X5ehWMA23c6ZZjMNyMhloW4yolgJEYOwewAMdq8zBQhhMTiTYO0fNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980093; c=relaxed/simple;
	bh=4ImLcomq9EQTR8O9rxQWRk5p25evmsL6lS0oArtOnTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQPUs2DEWFfHrQyRm23akqJ3Ekh6bGXCLlfGMZkQig1lXRDYlQDpHnaNFmO2dAddLN5JZgOMYWOKnw5Z26yLz8a5Qc8MQKvj9pj09BVZskn7VAKbLAXafALjxKncpmhAvQIDwDv02ae78bdTTIKcCXNGY4hkMAmlfjhLZu2Lcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpOvGX/s; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpOvGX/s"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722bcb989aso651786b3a.1;
        Thu, 04 Sep 2025 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980090; x=1757584890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N41B+ZHzPjNtp4wsALI7xhZWCUSTwRgGtFg4TpEdbnI=;
        b=XpOvGX/sxTfXy4Uz3CYb7pt2qfXHQiUByr0URHTQI56+9tn7O/Uq138Wjvh0QYypS7
         Rs0XGlDIlEo8qfJNUvsyhw+t9n20YZoqX/03gUV5FOMYHGr5KYe/wxmrqXsyORVVOyFs
         6kvmX5dX2EaJBwSr8Wi8sY5LEKldptAsQBvsE8ZTLaQZOsBgeORlsOalTUOpFhggCEbb
         YOR0PxxKiVse/WqqnuuFU7rFa734RQqSgbCrJ1li4JRxivTgnryIfS4Jt3HcN3ugOlQe
         lhc8QcrybbxfWHcpxtWmxFEYNO1JmhiH/CvwWZSm1BRfTrvv6ysWz3aW2qJBh75fSg5U
         sD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980090; x=1757584890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N41B+ZHzPjNtp4wsALI7xhZWCUSTwRgGtFg4TpEdbnI=;
        b=c/6i1yQKTZ3DpLP7e2XPXr/wjlrsSg8QLBi8K+GDxZaBVvtcGpIZpbDIoJCMxo3AYL
         lPofzKuRd8UJUktfQ5G71FApq6/r7E69fRcYvqcYZsOMogfe/heWqFUV9JfZd9ZzM4S+
         72bbuPTz5IdYTPDH/0SuTVfmqZSBc2Pj1Z3SR9Xuzy75xgUaEWtu4wQJKWliBUr/Al/H
         uhZ0iSnfED4jcbFm0t70z0ZGAeaIYLhXYB22lti99LZY5JZ6vFLjZPmw6+NI8sOd2xSx
         6q/6OYFP1EZgqMP4vnqTkL0OlagR/8txz15fOOx6mR0mqdM9PNxj002oaVY0aHiZncRd
         O3PA==
X-Forwarded-Encrypted: i=1; AJvYcCWoZSlHChWt5awRCrtjYsI4pA9RhriF04giW6bRSMwpuaz5R9M6IXn0n90eDbL1kyClFO44xnyxY+h+poPjzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhmlFxPTzp1y28prkwBA0qbl5gQiFsmE6HfvH+PWyZPwFEkxG
	y+RVchfvMy7l2R7tLPbZCNCeTf+9oYelr8O5rTFN8tpETdmMfkVjjA7HDE1jr0mM6kUm2CeK
X-Gm-Gg: ASbGncuviVcrS4JiwrAXGg2uD51bj7LtYecobQkscY937SXuzPizZWvw8KG9ImXHYDZ
	Ydm4ri2Ja7ChOlJOJ9RpGjccjL7ozvTJaOoAVO3i3uVjEKheIqY/Gn1AyzfAlz8xwXH3zSaNBUv
	voOosdQHFx9jZFRffwFaQEDWn71g9GeHpZk/AEWIHc09OR37P7gam0lW7wwy2JKNE27unzqfOlg
	WNJ7nHt+G6oL44lHgQU/IXiQSupYxbul3VJDx9LyYJSrjzWNwOJAW96rb2cTjSwpsNT1RNUtIJo
	7FqCI9ubp3QaRmDiaJAiHHO5EByMciSL+tYPJzoVsE7tRLkAcUyUZtjMHsJDoJZurFB3uq9J1Jh
	X/YMMgkaZfwnxkLdj0eUhV7jhPCE14A9oQY0D21XPdX3MNnuXqUNmMRqSMXddbA==
X-Google-Smtp-Source: AGHT+IEhsjFp1NibtjGx54wEWDNQHrHEVnvf81wB1ddDTJzWtfmVX0nktkLI4k1cniU2BMRD7U3MEA==
X-Received: by 2002:a05:6a20:78a1:b0:244:58:c155 with SMTP id adf61e73a8af0-2440058c43amr12075380637.15.1756980090114;
        Thu, 04 Sep 2025 03:01:30 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b747c2d66sm3510656a91.28.2025.09.04.03.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:01:29 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: chenmiao <chenmiao.ku@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v4 1/4] openrisc: Add text patching API support
Date: Thu,  4 Sep 2025 10:00:49 +0000
Message-ID: <20250904100109.688033-2-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904100109.688033-1-chenmiao.ku@gmail.com>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

Add text patching api's to use in subsequent jump_label implementation.  We use
a new fixmap FIX_TEXT_POKE0 entry to temporarily override MMU mappings to allow
read only text pages to be written to.

Previously, __set_fix was marked with __init as it was only used during the
EARLYCON stage. Now that TEXT_POKE mappings require post-init usage
(e.g., FIX_TEXT_POKE0), keeping __init would cause runtime bugs whenset_fixmap
accesses invalid memory. Thus, we remove the __init flag to ensure __set_fix
remains valid beyond initialization.

A new function patch_insn_write is exposed to allow single instruction patching.

Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>

---
Changes in V4:
  - Fixed incorrect macro definitions and malformed comments.

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
 arch/openrisc/kernel/patching.c           | 79 +++++++++++++++++++++++
 arch/openrisc/mm/init.c                   |  6 +-
 7 files changed, 111 insertions(+), 2 deletions(-)
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
index 000000000000..e28a9a9604fc
--- /dev/null
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#ifndef __ASM_OPENRISC_INSN_DEF_H
+#define __ASM_OPENRISC_INSN_DEF_H
+
+/* or1k instructions are always 32 bits. */
+#define	OPENRISC_INSN_SIZE		4
+
+#endif /* __ASM_OPENRISC_INSN_DEF_H */
diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/include/asm/text-patching.h
new file mode 100644
index 000000000000..d19098dac0cc
--- /dev/null
+++ b/arch/openrisc/include/asm/text-patching.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#ifndef _ASM_OPENRISC_PATCHING_H
+#define _ASM_OPENRISC_PATCHING_H
+
+#include <linux/types.h>
+
+int patch_insn_write(void *addr, u32 insn);
+
+#endif /* _ASM_OPENRISC_PATCHING_H */
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
index 000000000000..d186172beb33
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
+/*
+ * patch_insn_write - Write a single instruction to a specified memory location
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
index e4904ca6f0a0..9382d9a0ec78 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -226,7 +226,11 @@ static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 	return 0;
 }
 
-void __init __set_fixmap(enum fixed_addresses idx,
+/*
+ * __set_fix must now support both EARLYCON and TEXT_POKE mappings,
+ * which are used at different stages of kernel execution.
+ */
+void __set_fixmap(enum fixed_addresses idx,
 			 phys_addr_t phys, pgprot_t prot)
 {
 	unsigned long address = __fix_to_virt(idx);
-- 
2.45.2

