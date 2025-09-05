Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA631C58C;
	Fri,  5 Sep 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095989; cv=none; b=J112sKkO0tYvokF9kmExg7gNzB5z8vfWcz43GvYhbJVP8rb+1WD8X/Sb8DHNAaIsZQ4hE/5DDZ27sM8/soZ5XFkYbXlxNpB02OWFl6sF3tTvj/In7Q5Cigz5WwmKoQ67RyQbksoSuIth26X+/mJOGuHoFS3ePH8nzZypmchP2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095989; c=relaxed/simple;
	bh=4ImLcomq9EQTR8O9rxQWRk5p25evmsL6lS0oArtOnTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLHAFIu3nZ184uJUpGWyzxyE758tDBq9NQ1UXeAfqESS0VjJGKS05EVmJFUw3wSepxLHsBQDZJzYydFhbGEZPJ2tCQeQZctCuNoi0HUuO5bxqUSBj7gt9TYzysTqkMukxNIoCwd5KpZCO3pZ5msI7VNjCVYRVFe/22JE1k41DsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZfF3jt7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZfF3jt7"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c53892a56so2132321a12.2;
        Fri, 05 Sep 2025 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095987; x=1757700787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N41B+ZHzPjNtp4wsALI7xhZWCUSTwRgGtFg4TpEdbnI=;
        b=fZfF3jt73JDm1I0/oKNSBhOLVvxosLlB2rshgK13aoi1/zkBXXEYdtioO/mEjaVn6w
         VCJg1koBrWGoPXIsJIlDYoWMRKO+7JVA5SF/ISskmrmFLMHkz2xxfCbEqfoedQ5o/116
         I35I8uN+0y5RORAFUnr1z8QQEAWDrI18doG2ksBcrznnU8Yj+91LAF3Lx8y3lVKmXQ/C
         HS1Yg0J1ekZntNu+qNCwgZGETHt2vxMcD2DuZ2OPoNFq0MktA7zsa96wH952rGkVtuw+
         xnLlaaawD2Dm9Oi8sC9QFVvPpnRvPzrN8c/oGN/DBD0o5anGJ0/Wv41jyd6U1bx42d2Z
         WDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095987; x=1757700787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N41B+ZHzPjNtp4wsALI7xhZWCUSTwRgGtFg4TpEdbnI=;
        b=UKThoX9G896MFxTDO5a/BqnmkVEAzlqqPoh8+QNc2M33pFArEpEhPbNrnAAszI576V
         LjYwqaC4WMrT++T8052hLiRbUSoYc+pl+UPbYnOyvXj2F5bG9pDN6VrCMRzWIzLZRbzk
         YOKHgBAPBL2IKmCu3xE/ytZMvLq8yN4RagNSZJRxfkHLHzxs/XTUJNMkx864f1WO6+KF
         0lOokGPaaaTg3OjISToCBODvWIUMj/3cxQ0Leii1II8n1hXlKZGAa7o5fupl8HemZoYm
         eFkJfmXDhmIJN32AM4dCMBWYxEMxDn5YHwpjcfQF2GF8Rx9JynvlTeUiv9taFnStk1DH
         AwbA==
X-Forwarded-Encrypted: i=1; AJvYcCUCtST/NSM8R7+6e0+zw/Jn5C+6775Cqh1Tw/LQHHI2GzVTbm/BpjCzgT2ZeW9h8kdtQR/iz+SDHjW9XuHhZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/Rr7EygaawIMDmzSI5hsbV3p0rgx37a48MYdJm6fLyBUbBIh
	xRojWY9f6HHQB+DFnYStnLiMaV27EpbOwH7FgXNF4dhNn2osNpJHGQbckHfI7GKOOUXbwA==
X-Gm-Gg: ASbGncvSf7r1PzqSoviiJZm7hOV0C9910RL1RxV9TV/9xIsA8CIgiYr//LxegtfOpXm
	k7df5L2pgMzHUqb7fTczttPI/DpK6vZOfKGa7aL68O2y7Ja1CJjewLJyU+oVq/oTKbflh1Y4yHi
	SMkbhGmkPF82rtwluFq0DXOKwElEO3yj5+dJDiO80EQP8Eg5/Y5DjKgaPz6oQU+kwvm2SRCAQ9F
	sumyz2qVhFAqORZymb8yMIoKQTGQK5rT5JU5q4DWfgeiu33aR7UVmG85TqYS4+yhdoD9nzA6pcw
	MCx5/Oaor1Fm+XoCJ3iYneXiZ70j7xRREzSROdrHIgAvv69geR2XUh26/+kr+eDwAfhhbqCjZ+L
	2z1ZxYuO7M/9j+4+M5mKVoqcdMG6uZ7T/tVY+Z02gbp2En9kL/zM=
X-Google-Smtp-Source: AGHT+IF9npf1CB+lOkaVXFyCB9vkR+16n2lu+aTwKJOIzwYYeQyZZbqej7IhOvQHhi1I6bXuJftVFQ==
X-Received: by 2002:a17:90b:5190:b0:321:6e1a:1b70 with SMTP id 98e67ed59e1d1-3281531fb79mr30691302a91.0.1757095987195;
        Fri, 05 Sep 2025 11:13:07 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm19940233a12.36.2025.09.05.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:13:06 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v5 1/4] openrisc: Add text patching API support
Date: Fri,  5 Sep 2025 18:12:55 +0000
Message-ID: <20250905181258.9430-2-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250905181258.9430-1-chenmiao.ku@gmail.com>
References: <20250905181258.9430-1-chenmiao.ku@gmail.com>
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

