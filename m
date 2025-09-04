Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA82F8BDC;
	Thu,  4 Sep 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980117; cv=none; b=Xy6HG//ZetAmPeln1zRdoLwMOOqzSnt5dLkmsszs1Ich25bXlvAFzGil8UAzVlkIL7c7YnjnW1AfeD3rq7JzIdatKmCaqPqhKw2x5Daol0kp9ulju3A/LjEAfBfLXroFpImyC4i0cIDCpXn4iecw4q8r26heiYncEi80UKthG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980117; c=relaxed/simple;
	bh=NI2gdVs45WVB1gFpA+90fTTDAN7mr3Doc1EeTEzIFSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsPijDAbu441Bxaxp/7yniNGVfT2Eyuv7ci4qzWTHmmmz5OyyidlMVh6/faG5LCrGmy4tFyMCmRE6TAVaGwMV6fbqGjjdiqPCmloOToHFU0MHA2h1Cj+xs91ejo5Ww+K2z3fdqSKn0nECUNczXBJWgncmwFCm82OnzEP/VMRMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB86vZ35; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB86vZ35"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32326793a85so577295a91.1;
        Thu, 04 Sep 2025 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980114; x=1757584914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ux6xZQMdjwKk/vRBn6PyB6Gtcuu2vGEScUhbUr4eb0=;
        b=kB86vZ35y4Fe2clJkgnjRWOLM5lKzfXQsdOrTBi0zzR/4FYCqO+xr7bwj4k8XNI302
         JNAKlpSYVem+XPiAe+irrGWgwg2rNk/Xw2Csn4FxuQtQh5zxMD9gbCXca7PDWQ1JXQ93
         sJwQlnYLHajdHffzD2mAsDhWUTzYkNF6MfTL6KqH9Ud6vx2U3uj/Yxz8G561Q/E92WFj
         IRzhv+iz2papt5tkuXTLOXCM4EUgDV2pzJjCGrW1WbjKrVIYAh3yzNFosbEnZgInqM7g
         mX/rARZcWBW8NWUFsvKI+MmBLiNraxwgCDnHBIlVXfdfrXIcrGWRQ8hGBR5jPe/DE3gO
         0sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980114; x=1757584914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ux6xZQMdjwKk/vRBn6PyB6Gtcuu2vGEScUhbUr4eb0=;
        b=Pws9nVzRyDP7quCFhhzfL+wi03l/3KGP4dP/rqbOngwTIqxQ23WE3nZrltGcoqIZBq
         Mp7FkudEcQ6cl7112qsBc5yX3pc7+H4/Np28Qbdl9qTBzYTC4SZacg8wa/OvbVM+aitb
         ygaJcE+T/zWGH1hBH7EyGGWuOsxvEY7pfD06zYlV5rmnTbu0V+96VETBg5/bDCIuPP5l
         hUXkRkQmz3ZZ/QizpjJUsWSZerHTWdpGE1gunf8uusixaWiG0TOv0JBfVximDR9RfwlI
         Qy5sR6BtrOd0H9bbg10UAc3FzfKZoAFRJ8I3yGszEwOYOr5R1YphCvx6ke8VoRrXScmM
         DfhA==
X-Forwarded-Encrypted: i=1; AJvYcCWC/vWolXLWGCltZAmaRX+zjGn/X1v/9NxLCj5TSaWh1plZFhC9MefRBkrju0Ez7DTCeO9/Gj8KPO/gBpOjbQw=@vger.kernel.org, AJvYcCXp47d0FMOOY91yhjMo2G49TYKVOj5Eb/ATX6VAnmWcJPQSzX4Dhw1E4AZ6p1buEpcdueRcvRcaA8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRqbM+Bnb58pDK3gJAbxCshxMapbpFjjbnPn8b+7jSy+Y49WR
	RxEbmUS6mq5+qDaXkh1HwwVOJrlBDZiNMxdDHOM7SGM9nNxFczY0wGB4RepoQ8FrANQzaS9i
X-Gm-Gg: ASbGncuHx3mIoZbk1O1kGC5+QdYkmVn5oeUQZ6bUYctLmn+j7nwIsCeUQmqJjxegxIW
	Zzf2hYIMXZvB4C/lKJJrAr1LL5/9zmcyFasj/E12rom882qj9SFC4jS/eOUObycLaCpTt7rShh+
	IM7kTobbjf99CfviAy7CjMlY/yD7ZI1XD3W4QntIw9Tq+1eePkbv+9k6xx2yQo1rI80V+myghDa
	XPl+pdHPUGFKEzfc4f/fngAPHWxlnXLV+daIt89SuLm8wDfsU+Q/e/eYOG4wmNo7XWEhUuCIgAf
	vEaqDYosOouwDR4yl0ZkMlltZ3ymuO1RK8cC4WQfT0pifxgJOpQ98HdP2u0uazty3LolamFtdLZ
	WsGiXVIEhkkPhdbfeI+75oJo/GcbpOaZcaYPX5S67MPB94yw616TzRRf7cUXSejfAv9ZjEnqv
X-Google-Smtp-Source: AGHT+IHLHyRU6l7Pn1nPlsndiEWAG9LdZv5Q0RUp1kZVGxs0uOrPf5/nJArGnEEw7dCPnZkk6gA/qw==
X-Received: by 2002:a17:90b:3d8e:b0:327:e98b:6981 with SMTP id 98e67ed59e1d1-328156e566cmr22489264a91.36.1756980113417;
        Thu, 04 Sep 2025 03:01:53 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b747c2d66sm3510656a91.28.2025.09.04.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:01:52 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: chenmiao <chenmiao.ku@gmail.com>,
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
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 4/4] openrisc: Add jump label support
Date: Thu,  4 Sep 2025 10:00:52 +0000
Message-ID: <20250904100109.688033-5-chenmiao.ku@gmail.com>
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

Supported a complete jump_label implementation based on the ARM64 and
RV64 version and add the CONFIG_JUMP_LABEL=y to the defconfig.

Testing was conducted using a dedicated test module (jump-label-test,
provided in the link below) with the following environment: Below is
a brief usage and test report of this module. For detailed steps,
please refer to the README in the provided link.

Link: https://github.com/ChenMiaoi/GSoC-2025-Final-Report/tree/main/tests/jump-label-test

Test Environment:
  - Hardware: QEMU emulated OR1K
  - Kernel Version: 6.17.0-rc3-dirty
  - Configs: CONFIG_MODULES=y,CONFIG_MODULE_UNLOAD=y
  - Toolchain: or1k-none-linux-musl-gcc 15.1.0

Test Procedure:
  1. Build and install modules (make modules_install)
  2. Build the jump-label-test module
  3. Boot kernel in QEMU
  4. Transfer jump_label_test.ko via NFS
  5. Load module and observe results

Test Results:
$ insmod jump_label_test.ko
[   32.590000] Jump label performance test module loaded
[   35.250000] Normal branch time: 1241327150 ns (124 ns per iteration)
[   35.250000] Jump label (false) time: 706422700 ns (70 ns per iteration)
[   35.250000] Jump label (true) time: 708913450 ns (70 ns per iteration)
$ rmmod jump_label_test.ko
[   72.210000] Jump label test module unloaded

The results show approximately 43% improvement in branch performance
when using jump labels compared to traditional branches.

Link: https://lore.kernel.org/openrisc/aK3O6kOMqgDb6zZj@antec/T/#u
Signed-off-by: chenmiao <chenmiao.ku@gmail.com>

---
Changes in V4:
  - Add appropriate comments.
  - Added testing for jump_label

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
 arch/openrisc/configs/or1ksim_defconfig       |  1 +
 arch/openrisc/configs/virt_defconfig          |  1 +
 arch/openrisc/include/asm/insn-def.h          |  3 +
 arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++++
 arch/openrisc/kernel/Makefile                 |  1 +
 arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 9 files changed, 135 insertions(+), 1 deletion(-)
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
index 58e27d8fdb4e..769705ac24d5 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -10,6 +10,7 @@ CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
 CONFIG_SLUB_TINY=y
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index 8a581e932766..a93a3e1e4f87 100644
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
index e28a9a9604fc..1e0c028a5b95 100644
--- a/arch/openrisc/include/asm/insn-def.h
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -9,4 +9,7 @@
 /* or1k instructions are always 32 bits. */
 #define	OPENRISC_INSN_SIZE		4
 
+/* or1k nop instruction code */
+#define OPENRISC_INSN_NOP     0x15000000U
+
 #endif /* __ASM_OPENRISC_INSN_DEF_H */
diff --git a/arch/openrisc/include/asm/jump_label.h b/arch/openrisc/include/asm/jump_label.h
new file mode 100644
index 000000000000..3ec0f4e19f9c
--- /dev/null
+++ b/arch/openrisc/include/asm/jump_label.h
@@ -0,0 +1,72 @@
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
+/**
+ * JUMP_TABLE_ENTRY - Create a jump table entry
+ * @key: Jump key identifier (typically a symbol address)
+ * @label: Target label address
+ *
+ * This macro creates a jump table entry in the dedicated kernel section (__jump_table).
+ * Each entry contains the following information:
+ * 		Offset from current instruction to jump instruction (1b - .)
+ * 		Offset from current instruction to target label (label - .)
+ * 		Offset from current instruction to key identifier (key - .)
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

