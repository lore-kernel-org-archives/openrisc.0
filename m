Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873525A334;
	Thu, 14 Aug 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142076; cv=none; b=elvkCLaqBBvRp7HklC0p9CR/19em8cJyXiQJp11Hsjoetnrkix3FVO5c4uiNl1qxdUeadvnme3x6nhsFw+G89A+gAAWuU6Eoqzs5XoJxOun8V58mdU0+jTWdP4uDpW5hF6U5OimzY6+DLSgJb02HSlz6psapxDoMVcBZ9TClgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142076; c=relaxed/simple;
	bh=kykKGfIHcuwt47+6LgW+9CplGFJGHW6DCFpYD4TgPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puFDd3/DIA1JA+UVDhOUluYF9A+GGFcrVQ/QM6xzR8Nhdrpvud+AqiA7VzcCsVwA+qiHiony3W7fTir85hD0ogHf2NXpMnO55TVd2RWRnSTN6z20ZR4HLl//7xE/iv/8Rx1UUjmwhK1N769iu8bIyoZpbQs8f2spam/0fu5YDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McVLsnHG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McVLsnHG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so500056b3a.3;
        Wed, 13 Aug 2025 20:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755142074; x=1755746874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJyUJQGnwLdteNMwm5dTN2/3BR3DTUlHzhKHSmLgMZc=;
        b=McVLsnHGJ3UZFxda8X/An/eAL8ODH5mi24EXyBvftWDuJ/4eCjPWrSBWuCVXfhc706
         R9la0jpuq51ws0rn5rsoZ6pmyuH4HplGu4GK+quDmMTIqpB/LBce5bzNIaz+gC7oAZQ3
         hnWSYoVyHZWohB1+3ETQz5mptD6X84bwSHfN2tOowzQqBgn0Yua8+bCQMziZqqjEmzwZ
         DRLBJ1Q8hzctQrgPEzA3CCEIL3Z6AueKWzgdFvboOFWVjWIUdRNPRtcSHo2cekETqe+K
         Fz7TBQ9UMAuHDe0hvoHQHMNdtjJrxoNZ+V7N5ncFgpcg4duCltljOgzkiRPP9B39nKAC
         GIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142074; x=1755746874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJyUJQGnwLdteNMwm5dTN2/3BR3DTUlHzhKHSmLgMZc=;
        b=lS83lJV+MUGXKEGAPMHUFjDhDqoS/51C6u8qVLjcCh+IGxpiVMs8W4VIcMNTLgcyWl
         sVkzyVcLrUYvhz0fvZGKMPhsPi7kNH5Me4eYtzHwyawZs8QtXIx9vJIWVYf1IkjRkZn4
         F3aFiubnrYGh1TaLQiMUtOp/sxUES/hVH/mDb5fNjA4/xgOVhU4iAYH2fNuLq5nnoW4r
         FBDL8acOeCdKzCBpmLBIlMduYD7CLS8xHt9+/r1r0JCPkBayKNCMmkS/oLINfjS4oDXg
         swsEp1gA4MWoJ7YMm+OhnGU9gGyFnhBjIHv4k7Qj17KBND3SN56x2ujBTT6MJFaEZW2N
         +/vw==
X-Forwarded-Encrypted: i=1; AJvYcCV+gKRSwGbX6rI9+hKO+26eWIsbdXiAh4wvziMeUnNFY5za1LYjbPFk76Kp+sRN1tUXEC6QDFWkAu2TJXpgAnQ=@vger.kernel.org, AJvYcCV4wzO4YWaUCxBTmyJbr2M2i5nklCBhmqjOQKn5QIbPuToTMFnU2hd59T8VwztjjvE1BjFqLvffHLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/yJp7Eh4m3RAoX5mdWQ6nZT9NuEva/j1qTDKQmQhX9nWFbgJ
	Jax13GBHORcw5wwavYf0I61gdrsEnYEAd+MCb2yoLTyyjBKnUyJo3Dmz
X-Gm-Gg: ASbGncte+/WOlaN3iBVLssbZUYjMYbaPAfQrc7rU/f0jJ38clnHGg57zuFKsl28JSZB
	pzTSSw84CHHZYwT4C64ZJ+GyOjGBnjvwtcGSb6dT5kgRCaW6moyzuFdYqA9fg5X7QKxVy2rDk6I
	/6k0ncxS8oZnmvrRP2pqkiInxc2xS7px7y6emLtbmIx+jQZBPUKJAiWxElL47jE7IZ5rmONEdsM
	/LBRN4KEGCeGecQVv/bZgQ5/VBlTBZBwaNp4l1xE3ifQMbanasHmIDb+ZqT0lkPAA72bVz42XsG
	uZQBKo+3NTrtCJwOiYKIZHYR1jFYzozrce3zVBpFqDWAo636SJAvX3jQ58+sxhUOhF4bAzGBI/E
	PyZS1uzytU0wgbcyY9Q==
X-Google-Smtp-Source: AGHT+IFvRKA4umLDJYe2dlnUd3qZBZ9OcV78OfWMoQ3YorCC1zPH2Ck8dYtL6XjSb9rNFTw+t6Ypew==
X-Received: by 2002:a17:902:ce0f:b0:240:72e9:87bb with SMTP id d9443c01a7336-244586c3844mr22740325ad.42.1755142073836;
        Wed, 13 Aug 2025 20:27:53 -0700 (PDT)
Received: from nyaos.. ([45.12.134.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331167ff6sm276009a91.27.2025.08.13.20.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:27:53 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 2/2] openrisc: Add jump label support
Date: Thu, 14 Aug 2025 03:27:02 +0000
Message-ID: <20250814032717.785395-3-chenmiao.ku@gmail.com>
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

Implemented the full functionality of jump_label, of course,
with text patching supported by just one API.

Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>

---
Changes in V3:
  - Ensure the two defconfig using the make savedefconfig.
  - modify the __ASSEMBLY__ to __ASSEMBLER__, modify the
    __ASM_JUMP_LABEL_H to __ASM_OPENRISC_JUMP_LABEL_H and remove
    invalid comment.

Changes in V2:
  - using the patch_insn_write(void *addr, u32 insn) not the
    const void *insn.
  - add new macro OPENRISC_INSN_NOP in insn-def.h to use.

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/openrisc/Kconfig                         |  2 +
 arch/openrisc/configs/or1ksim_defconfig       | 19 ++----
 arch/openrisc/configs/virt_defconfig          |  2 +-
 arch/openrisc/include/asm/insn-def.h          |  3 +
 arch/openrisc/include/asm/jump_label.h        | 68 +++++++++++++++++++
 arch/openrisc/kernel/Makefile                 |  1 +
 arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 9 files changed, 137 insertions(+), 14 deletions(-)
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
index c1b69166c500..a93a3e1e4f87 100644
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
@@ -55,7 +56,6 @@ CONFIG_DRM=y
 # CONFIG_DRM_FBDEV_EMULATION is not set
 CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
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
index 000000000000..28dd6c78f8ce
--- /dev/null
+++ b/arch/openrisc/include/asm/jump_label.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Chen Miao
+ *
+ * Based on arch/arm/include/asm/jump_label.h
+ */
+#ifndef __ASM_OPENRISC_JUMP_LABEL_H
+#define __ASM_OPENRISC_JUMP_LABEL_H
+
+#ifndef __ASSEMBLER__
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
+#endif /* __ASSEMBLER__ */
+#endif /* __ASM_OPENRISC_JUMP_LABEL_H */
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
index 000000000000..071dacad885c
--- /dev/null
+++ b/arch/openrisc/kernel/jump_label.c
@@ -0,0 +1,52 @@
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

