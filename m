Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422A38DDB;
	Wed,  6 Aug 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445959; cv=none; b=qVDPuUZ5jDKHk+DQ/OrKukpEC4epTcg+IiOWiS14H0WdBvtBhnCLHpiNxN7JHyteLvIUcF2e74OUMc3qEK/c37UkHpvG353XkPLHSVMLDpTCvV+rsV1bztZGhKQeJQdMGivikRiGONHoXidvTLRTZTG0aN6RaRRqFbTNlCzm6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445959; c=relaxed/simple;
	bh=HAPs1p2nc/MGWPCjIv9t61jU/ZEJAhSTY19kgzTA820=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3ORa4UmkmzIqqQpOgYdsdA30o74T+rTsgUr0D1Z/lJWBl4pQhs2d0Qup1twzJ3kHC4V99oC9GTvMVHzlHLfTMr8xwplbhYMEQsasg59m9I0Uq/ZcTVVUFx69517NbMtgSCA6HyNEL/i5Jr90kb40MD6c6HVo0B+p/bIQi54LgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLwE+gcI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLwE+gcI"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so5635067b3a.3;
        Tue, 05 Aug 2025 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754445956; x=1755050756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEjPM7lPagmZtZOuGxi0lhrxw65ELHrHI5/yqAy8H2o=;
        b=XLwE+gcIcFYafCb44uuA3TziMd4llqxRZFV0FctPTjsb5lQMlIBYVGOItyatKzm3s2
         e3qjPjPep3KXolea1qcrBKBb+JOVlyDEeV03RALCiNGobqw120RhuIa9tkG5oNKxPsd9
         gS1V9SrsVccwR+rHYDdVLVYG9P953Qu2WGgvJfXa3YCtg0PFxchx8/4MVc5DF1AdP4xC
         UxlP9oIEhPjDGJz0l+X0enJBSVyzZE6tGGRPriMzh9HW1ag9MCFWNu41gBN6iFcrDTTN
         tgCmuAHtvFuaSfR8mTIdX8/LT2eMYn3nI+54wXmbGm0l6/G8g8PR6Xc2I/wMED5vmlyV
         2RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445956; x=1755050756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEjPM7lPagmZtZOuGxi0lhrxw65ELHrHI5/yqAy8H2o=;
        b=byWs0F/nrfqkaoib39uIL2wUVdEyXcweLWBVqbIxKwoXefOEMdbUGHXJMrFOOC0SRp
         BuCDQeayE6bkhlzIU9LXc7MsuZQ0hcqw8BCW+kw0W9AgAaXuajx5JKi2Mfv4RNJm9G+A
         LkTpjI4Y9z+6bfphza0K2Bn7MIvM+mRGUgF/aGP7VqQu8ZNJsWloGzMz8ygOkEt7Y9mw
         E1J8G6k/FIAq/7JgiQ5aoWABjkL7Zs5naxqB+B8zwXoklhpAy2rbfPGrdpaOsaBpVTyi
         QZWJBtKXaziR39/cb2JopUMzsBqqeSGu+H/hhwzs645n/1ot8gvVX/5uvh2PR4dihgJf
         w3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7NyXOoEx0ko/PvRnb4c1ViVszD2vs82EP300foxGBfspCdd+RPPAnWIQInn7easSwyv0GnJ5mleE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfyhGdT2LjrpevRrq1P0KDHwiyM95+pcScver2nSMkq2Jt47I
	qwXVay+I0a9fUU2CJ7RozMogA8IJXdRrax7DEhOUEPhOVjYT78Jrqmaiq7edkC+i2wvds7nu
X-Gm-Gg: ASbGncu+kz32rRtaCE0WTYNvzhETnNGApkKgAtqIfWfCApl36UGuX1hLzLHWX2eEu3i
	hXUVJqqDeWp2cmCx182mRdoDTl61QdWWt29IFUn1ZhgKTZgZnHTlwEDoLNKC30mV+kWPc8R6yZn
	QLVuTE/sG3vVUpxJ1ntOtUXeu6yU6PzuWExFofuQBhK1MDQ7LZfGTOFLzzNLTZXbbrrN2zMRAPW
	c4cATvswbuCiNoQGYR4/FqDcbET4XvjaQ93WnuItI/fRmXfx6ntMu+vskRDp6cxNRj4u290QTkx
	ewhG5dxEmHTpbkf8veoJpRWlBbuzbUVD0OGALQTIxoF2KNwdHcKp9r+bbGYJ6ZN3iDk63TZ7iNo
	vMsRnn4lOAFyIOOPl
X-Google-Smtp-Source: AGHT+IFKIRpH3S1hBtxnefv8MiQ72xy1NoafsDp/ZhEtbqLnYtpNIwD/JdfPv6tWRKBJpdyg5YvQww==
X-Received: by 2002:a05:6a00:2d11:b0:76b:f13e:f598 with SMTP id d2e1a72fcca58-76c2af629d7mr1324973b3a.8.1754445956089;
        Tue, 05 Aug 2025 19:05:56 -0700 (PDT)
Received: from nyaos.. ([141.11.79.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf531sm14068499b3a.92.2025.08.05.19.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:05:54 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] openrisc: Add jump label support
Date: Wed,  6 Aug 2025 02:05:04 +0000
Message-ID: <20250806020520.570988-3-chenmiao.ku@gmail.com>
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

Implemented the full functionality of jump_label, of course,
with text patching supported by just one API.

By the way, add new macro OPENRISC_INSN_NOP in insn-def.h to use.

- V2: using the patch_insn_write(void *addr, u32 insn) not the
const void *insn.

Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/openrisc/Kconfig                         |  2 +
 arch/openrisc/configs/or1ksim_defconfig       | 19 ++----
 arch/openrisc/configs/virt_defconfig          |  1 +
 arch/openrisc/include/asm/insn-def.h          |  3 +
 arch/openrisc/include/asm/jump_label.h        | 68 +++++++++++++++++++
 arch/openrisc/kernel/Makefile                 |  1 +
 arch/openrisc/kernel/jump_label.c             | 53 +++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 9 files changed, 138 insertions(+), 13 deletions(-)
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/kernel/jump_label.c

diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index ccada815569f..683de7c15058 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -17,7 +17,7 @@
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index b38fee299bc4..9156635dd264 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -24,6 +24,8 @@ config OPENRISC
 	select GENERIC_PCI_IOMAP
 	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
+	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_PCI
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 59fe33cefba2..769705ac24d5 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -3,26 +3,23 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
 # CONFIG_TIMERFD is not set
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLUB=y
-CONFIG_SLUB_TINY=y
-CONFIG_MODULES=y
-# CONFIG_BLOCK is not set
+# CONFIG_KALLSYMS is not set
 CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+# CONFIG_BLOCK is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -35,7 +32,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
-CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_ETHOC=y
 CONFIG_MICREL_PHY=y
@@ -53,4 +49,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index c1b69166c500..4a80c5794877 100644
--- a/arch/openrisc/configs/virt_defconfig
+++ b/arch/openrisc/configs/virt_defconfig
@@ -12,6 +12,7 @@ CONFIG_NR_CPUS=8
 CONFIG_SMP=y
 CONFIG_HZ_100=y
 # CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
+CONFIG_JUMP_LABEL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
index dc8d16db1579..2ccdbb37c27c 100644
--- a/arch/openrisc/include/asm/insn-def.h
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -9,4 +9,7 @@
 /* or1k instructions are always 32 bits. */
 #define	OPENRISC_INSN_SIZE		4
 
+/* or1k nop instruction code */
+#define OPENRISC_INSN_NOP     0x15000000U
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/openrisc/include/asm/jump_label.h b/arch/openrisc/include/asm/jump_label.h
new file mode 100644
index 000000000000..03afca9c3a1f
--- /dev/null
+++ b/arch/openrisc/include/asm/jump_label.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Chen Miao
+ *
+ * Based on arch/arm/include/asm/jump_label.h
+ */
+#ifndef __ASM_JUMP_LABEL_H
+#define __ASM_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <asm/insn-def.h>
+
+#define HAVE_JUMP_LABEL_BATCH
+
+#define JUMP_LABEL_NOP_SIZE OPENRISC_INSN_SIZE
+
+/*
+ * should aligned 4
+ * for jump_label relative
+ * entry.code   = nop.addr - . -> return false
+ * entry.target = l_yes - .    -> return true
+ * entry.key	= key - .
+ */
+#define JUMP_TABLE_ENTRY(key, label)			\
+	".pushsection	__jump_table, \"aw\"	\n\t"	\
+	".align 	4 			\n\t"	\
+	".long 		1b - ., " label " - .	\n\t"	\
+	".long 		" key " - . 		\n\t"	\
+	".popsection				\n\t"
+
+#define ARCH_STATIC_BRANCH_ASM(key, label)		\
+	".align		4			\n\t"	\
+	"1: l.nop				\n\t"	\
+	"    l.nop				\n\t"	\
+	JUMP_TABLE_ENTRY(key, label)
+
+static __always_inline bool arch_static_branch(struct static_key *const key,
+					       const bool branch)
+{
+	asm goto (ARCH_STATIC_BRANCH_ASM("%0", "%l[l_yes]")
+		  ::"i"(&((char *)key)[branch])::l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)		\
+	".align		4			\n\t"	\
+	"1: l.j	" label "			\n\t"	\
+	"    l.nop				\n\t"	\
+	JUMP_TABLE_ENTRY(key, label)
+
+static __always_inline bool
+arch_static_branch_jump(struct static_key *const key, const bool branch)
+{
+	asm goto (ARCH_STATIC_BRANCH_JUMP_ASM("%0", "%l[l_yes]")
+		  ::"i"(&((char *)key)[branch])::l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_JUMP_LABEL_H */
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index f0957ce16d6b..19e0eb94f2eb 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -9,6 +9,7 @@ obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
 	   sys_call_table.o unwinder.o cacheinfo.o
 
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
new file mode 100644
index 000000000000..ce259ba30258
--- /dev/null
+++ b/arch/openrisc/kernel/jump_label.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Chen Miao
+ *
+ * Based on arch/arm/kernel/jump_label.c
+ */
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
+#include <asm/bug.h>
+#include <asm/cacheflush.h>
+#include <asm/text-patching.h>
+
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
+{
+	void *addr = (void *)jump_entry_code(entry);
+	u32 insn;
+
+	if (type == JUMP_LABEL_JMP) {
+		long offset;
+
+		offset = jump_entry_target(entry) - jump_entry_code(entry);
+		/*
+		 * The actual maximum range of the l.j instruction's offset is -134,217,728
+		 * ~ 134,217,724 (sign 26-bit imm).
+		 * For the original jump range, we need to right-shift N by 2 to obtain the
+		 * instruction's offset.
+		 */
+		if (unlikely(offset < -134217728 || offset > 134217724)) {
+			WARN_ON_ONCE(true);
+		}
+		/* 26bit imm mask */
+		offset = (offset >> 2) & 0x03ffffff;
+
+		insn = offset;
+	} else {
+		insn = OPENRISC_INSN_NOP;
+	}
+
+	if (early_boot_irqs_disabled) {
+		copy_to_kernel_nofault(addr, &insn, sizeof(insn));
+	} else {
+		patch_insn_write(addr, insn);
+	}
+	return true;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	// flush
+	kick_all_cpus_sync();
+}
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index a9fb9cc6779e..000a9cc10e6f 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -249,6 +249,8 @@ void __init setup_arch(char **cmdline_p)
 		initrd_below_start_ok = 1;
 	}
 #endif
+	/* perform jump_table sorting before paging_init locks down read only memory */
+	jump_label_init();
 
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
-- 
2.45.2

