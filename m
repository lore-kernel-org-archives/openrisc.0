Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC730596A;
	Fri,  5 Sep 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095997; cv=none; b=P8dumbUBk7e7DFoa0j7olb7SSCi2StaLaBVB//x1ParVT2myy3O8w6MhAWa5hIaQx81S6MA9lvFGff+6zTn8knZswDhPw3jzK/CqGcHscR5gvDME44p98TTY8ClIzPJBPDQ96y+dM+EmOaCKA3gxSqEiCxSh30/zEtwHREiLhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095997; c=relaxed/simple;
	bh=Yr/J+qaDlsCVS94vuTBNZXm1SYKQjaVLzSBf9pUseMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwTtGrZPEs/hCgjRpY/rqbOJ3OL9sz5OGhe/2L9JXp2QWj8ffP7Vu9PoZQnXMoumcqOtn+KMpfw7x1PkHIVvb36eVgzmNIsEtzSxmcNK4fSr0itbSXp0DxFh3ayT3yrctCXzhuZKceqAhGPbgRk7oBlTvuluUIc53ExsYvlNBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChauEhEM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChauEhEM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772679eb358so2299516b3a.1;
        Fri, 05 Sep 2025 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095995; x=1757700795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiYDLW76pXeUMoZG1bXqAl7ssyBBogngJxWwHsYUPP8=;
        b=ChauEhEMeS5WYrDT2G8BDkwfYCShZZY9ndekCMByReexCNFV2eUZfEFnANsSpyTQIf
         70zatT+2BEp5FnovKWV23Zq6o3Z/LlL1Y4yBDonun9jZpn3J1DU1Pl7FK271AVhFlSkY
         f3OaAoAP8MldBj7gLsLKV2A4IWNJuz/t6QPFD5t5/un+E9nT1q/X1FQe/6IcTFlnXwI/
         yCW8xW0Ev0ISvPPkAmVYoGETucruLLKfFExTpShl6J/ob3D0yDvW9ihVP/JNOb0buiNp
         hVg0AOVdJWZQ31mw729FestYUAYqE6x62oG8bIY2xi93QZqwj3NYv3QQjgH1JGglKI+Q
         12EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095995; x=1757700795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiYDLW76pXeUMoZG1bXqAl7ssyBBogngJxWwHsYUPP8=;
        b=hLwrlpcMn2O5zLVVmChCkZ84OrHYfOzZK3RenW7EfWxdug1yRj2V/SLort9VUKywRB
         RcNo/06Dbwi7smfFi91Iv5Y233BV7hOOElsVFENWrVZsl5A2NXeD9aCC4Sm8LFu1V0/V
         mOyhyY8LejQfuC8aG/bEJV/nImdKrbSgLntSTYJrYfRZb6dUu0LnYQiIn4nt2P+crGV7
         ocqeE4SX21tvRJtoJJ+lSWKB7z1UYGH8I7wh7JvWXB6xbzzJinrYs83F2FJtfywxZ0ys
         i8uPjLuwhaxBfR6LByvnlGhwYehRMucIGdg67SOMsVWAjTZFO2SOwK0p3GSjZq9rWxVq
         M1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXIG2/FMIrWdBDF0+buBk4IMD+LlKHKlpCrvW3weagCuVjl7UEOjvEYgUwwn/F4sarK+wmevPj0s3y1oV/5mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoFCZzZ7ksByoTyc5NaDE/jTSMJawqjcVhyhZreB4y6jE5lT6
	TkLQroSxcU2w9ofjxYTWfdmscSINDaQo5J+APjjDIoXQ32f9aSuRVsAbDAAgaN4Lvys0Yw==
X-Gm-Gg: ASbGncuhL5JmbDgdU7ZeIa+gi+hsqIT/NuGdz1kJHMHVebLzwl+ua34NkubWu5sZzAR
	Hfn/5884JK11H1bSCRWXeZTc+g6oPHFTFw9mrE4UIqRztRnmLNulUgh5V/tuY9/m7zB/lNIaBeJ
	UhhJvwtKhTxSqtqod89iNvMzdzg+e2sfTflsY/psx8L+a7VEnlVUbuZ7pb29yfl3EvSotcXC/Mb
	YaFmXIWJaOmR59kvIV92HXqxMEieyH/DfJvVM93L3e+srKOcu92HyXrHVx1yfkJnNVaqOXwJQpz
	qCqkhiRU/tHRe9WFxXzZ9HSJWWZEsaHfLnJox55Msg/gqOCDR5pwyo0o8wuN0URKCNuU1EZrJlp
	/9+hWjUAk7XJfCFKGzkaUEhR9CED/rnpnAsrPe7Y8d4QkPm9ZVbQ=
X-Google-Smtp-Source: AGHT+IEIeZIGnRJWJnG99EgpDeTaag1eIl7aHCBVOEmJ3981bTtHYFFbD+QQp0Lg6ZrVmD2yI28VpA==
X-Received: by 2002:a05:6a20:9188:b0:246:273:1c56 with SMTP id adf61e73a8af0-24602731f5amr18596331637.28.1757095994930;
        Fri, 05 Sep 2025 11:13:14 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm19940233a12.36.2025.09.05.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:13:14 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v5 4/4] openrisc: Add jump label support
Date: Fri,  5 Sep 2025 18:12:58 +0000
Message-ID: <20250905181258.9430-5-chenmiao.ku@gmail.com>
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

Supported a complete jump_label implementation based on the ARM64 and
RV64 version and add the CONFIG_JUMP_LABEL=y to the defconfig.

Testing was conducted using a dedicated test module jump-label-test,
provided in the link below. For detailed steps, please refer to the
README also at the provided link.

Link: https://github.com/ChenMiaoi/GSoC-2025-Final-Report/tree/main/tests/jump-label-test

Test Environment:
  - Hardware: QEMU emulated OR1K
  - Kernel Version: 6.17.0-rc3-dirty
  - Configs: CONFIG_MODULES=y,CONFIG_MODULE_UNLOAD=y
  - Toolchain: or1k-none-linux-musl-gcc 15.1.0

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

Link: https://lore.kernel.org/openrisc/aLsZ9S3X0OpKy1RM@antec/T/#u
Signed-off-by: chenmiao <chenmiao.ku@gmail.com>

---
Changes in V5:
  - Removed some unnecessary curly braces and streamlined parts of the code.

Changes in V4:
  - Add appropriate comments.

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
 arch/openrisc/kernel/jump_label.c             | 51 +++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 9 files changed, 134 insertions(+), 1 deletion(-)
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
index 000000000000..ab7137c23b46
--- /dev/null
+++ b/arch/openrisc/kernel/jump_label.c
@@ -0,0 +1,51 @@
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
+		WARN_ON_ONCE(offset < -134217728 || offset > 134217724);
+
+		/* 26bit imm mask */
+		offset = (offset >> 2) & 0x03ffffff;
+
+		insn = offset;
+	} else {
+		insn = OPENRISC_INSN_NOP;
+	}
+
+	if (early_boot_irqs_disabled)
+		copy_to_kernel_nofault(addr, &insn, sizeof(insn));
+	else
+		patch_insn_write(addr, insn);
+
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

