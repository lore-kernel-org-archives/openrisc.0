Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AA2E370A;
	Tue,  5 Aug 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383313; cv=none; b=oCBEy3zIMJtY9Yn7PLKTcdCvsFFyNibH2OBnQJAxjBYLw+pQvsVnKo58FlQftDGZE4miXwU4JT3lUVoRXEqjMl3+J0qDA7xEv2ZtB6/QOAdzOyjJWUzz+z2ND1wYAGHcbxEt4wTD8xXyGaCnVlnMFGcu/0GVgG6/zj7igNp4HxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383313; c=relaxed/simple;
	bh=R1vvMMGbAwU4pKGfXNuxlMgPu5ebzN/tHzShrj64SV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDbsHtcVMdq/rZWxZheq3Lu9/Ew8RJMuIAwBO+ZVS+vhNL0VYymALqDw4RbmVRilmRk10mdl+C7ohazQwEss98PSIINuOoQiJT/q2nhHP/xV6hPZT6hKRcooz2c4lxhyIgTsu0Dr4jCv8EOoX4fL7JUmt8oarQWfyiaxp4U4/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLfrJjCQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLfrJjCQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso2549851b3a.1;
        Tue, 05 Aug 2025 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754383311; x=1754988111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRJJifz5CC8NQFb6tc5aBM8nA2YPhDrgucWKgxjTqVo=;
        b=aLfrJjCQ4bgldiU1UjdtJJeOxJ+YPkspA9DFgeLe3ih7kZUthr3cQgRTXTUT9Kv/CS
         8GrM/z+Kpf3F+QsznuOFN+VgbgLF8Wx8OPTVwRMUhdTug9T4oTfllZdR0l2CypqJYmEd
         yCqBhM87QADWx7H7H7RQSVLZq/ntmmGKatOBWTjgKsR0QUfIygQ10s7CzJtGnuQEnOCk
         wWVk/+hrBiRtAOBXF7llwjbQuH0pqeE/opltQ0pTFPP7EnuExh0fOh4hQ+1K3jFW6+QV
         D0k9vcT7ErdYz8br4HkfXICcEG6xeS3UXcZSPGmp4TtB68prJemD60RV8x77gl+Mpfel
         S0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383311; x=1754988111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRJJifz5CC8NQFb6tc5aBM8nA2YPhDrgucWKgxjTqVo=;
        b=a4v8P3jl0L+EynYEAiYTu0DJBvzfJXGdEBXZXFBVZBG9Y/V0WS0YqVP5Nal8zsaF8+
         /erc43ZFfkIzhYIUJqB+Y1K8mXgmJ2/PscU2bAdkrB8dBSO6EWfOILcY3i7vu836vOm4
         QNRTY+Y5NFDh8vxeXSluyQByxs2G2zy213mOf46SBZzY9/vOgepQqTcq24yRtl9mBYvq
         dbcD/6BKt4ybvI5Q07VbuwIXYVKXJc2TrqgCiV5xu22J77fO8NDUzog39wsCfsqn9lzZ
         B/99nzVJuz5P4vn8J2Z14gKCMILTwcuv//rrzCdiYrQT1fc/rU8dDeG2zFqys0yyiM3j
         aXBg==
X-Forwarded-Encrypted: i=1; AJvYcCV4FkAAuVmhWTq9DFmkORsggD4+jBODk7xwIdB9L7G/VSqFUOc6FkSDHTn5uc2WCazg0N9yEG9hUVk=@vger.kernel.org, AJvYcCWhJEwQh32vPmHoyEbbQfqUErF9LagBKATOq5nbtEK3VbMpbmJ8Ulk+lNQa7jKzbLZMJSaxdFJs7KKaeiWHRJE=@vger.kernel.org, AJvYcCXP8K47aS9GAUL3iWB8pdtRPGE18K/LL4vSuOl/2uFVMj7+3lyg2VbQ+paAWgpvrN2nNIpG84a5EsajACSE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvv7XwDRsnW/pt3gippRZkqUBoz3FeVmz+oggLxf5Z5ORu146n
	2JtWdvrgLQ58q3ZDxIZES6rDCdmWtaJGW/uysyp6PAVqTGIFCBuByzVO
X-Gm-Gg: ASbGnctGWdNm6Ix/YDVYqLTSC5MuwVLnZNtlju71EfdwZKUuR9HzN7yYMEj+VlQZ+bq
	8NQdNPUTWIKyPwdFi5EU6OUPL3weSwkmAVdrhJ5961wWhCu/pRCmO6O9WkCguO099rW4X3CY/4+
	tEpDEp6y4ysJF+p8YGvltZ45UHGzBbXw8QnyGx2BgN1iM6UX8j6HlTqaTnmwGN0lJOg77vK1dX3
	1WXGgqweHiZqPNX0BdfhtZf+FBz+0eB1zQjn8tBMHnlCIk576eKdwSSSBFLiN0+9qLDQFDvLoR0
	xgXsohTRvHxI5Za/1FOvruXJ++inEL7ftNWFqmgM6/BOb/PuuRE2K69yboL+lA5L50SpM9p9FMm
	BebF8HAtWi7qExDD8WF1Ye+FdF82zz4DypjaHhw==
X-Google-Smtp-Source: AGHT+IHRWWIpIfad1+0DN2xYUj8cS93fXfqPhfGlf9VrdzTRTOBEazMeYux9j17jEK/yELWoLIUKMg==
X-Received: by 2002:a17:902:f706:b0:234:9cdd:ffd5 with SMTP id d9443c01a7336-2424700f50emr183870875ad.25.1754383310767;
        Tue, 05 Aug 2025 01:41:50 -0700 (PDT)
Received: from nyaos.. ([141.11.79.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7d96sm126981995ad.18.2025.08.05.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:41:50 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: chenmiao <chenmiao.ku@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Johannes Berg <johannes@sipsolutions.net>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-openrisc@vger.kernel.org (open list:OPENRISC ARCHITECTURE)
Subject: [PATCH 2/2] openrisc: Add jump label support
Date: Tue,  5 Aug 2025 08:40:58 +0000
Message-ID: <20250805084114.4125333-3-chenmiao.ku@gmail.com>
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

Implemented the full functionality of jump_label, of course,
with text patching supported by just one API.

By the way, add new macro OPENRISC_INSN_NOP in insn-def.h to use.

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
index 000000000000..2cda900dd33e
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
+		patch_insn_write(addr, &insn);
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

