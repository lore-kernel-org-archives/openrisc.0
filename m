Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137D25A645;
	Tue,  9 Sep 2025 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387579; cv=none; b=iX7DiMC2UAXmbFtV56t1pOG7/SChYhw9yFFbVuXcU1Nr9vT8DIeKUes7q5mynV6jSpMIml20y8wQJlBLbu6lchjod/yuChCXjO8rc2fU2KkKleTjYuaaOG678seCFSew4RBquedbXH7+t3UYoc87srS/MTX6dbpZyZSQWazV8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387579; c=relaxed/simple;
	bh=CurPdoWNDepeCLZSFHWBNAWnJKW3VNY3kWe+KMfJx4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkq/KRZAvUaS3s1uzSeaav7+Tj/myHDCt6bzlaMM7bh01HX96Os863rM9zGAXXty10L4DKF7FjRwk2w5DC5YEL8Rom6Xt2bv8TgCouEa4iJmqa5b9TBX92RHsx5kz9dZhDuHwm/PpfQJYYe+7Ge31naqZpvFjNOeNBUu+9M1y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZkJgk/s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZkJgk/s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cb39fbd90so43262625ad.3;
        Mon, 08 Sep 2025 20:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757387577; x=1757992377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozJmTecCZaQaVpHG3vtWBfEpvgoJz+sihTYv5zJXl0c=;
        b=bZkJgk/sRKVis3gLgpRXl4MyM8E7AgpernSw/RytTotK11LCsCF4i97yg48jp3cUM9
         2o/QgNfBea33xkf+wEB0keqy+UVsLl9Xwl5NWghZmhVGr3yYIS5+BnghgiEqbwKqkJQ1
         FeKX5J+JIa66abdFC0UZR+BcHDa7/W8Es279/UN/OfCsyrGUWmLTleeTZhoD5dyqFYpl
         2Jm2l/5aQdgDFjdbUy2iV7LVrXc8XxQkdQMaQeBAp4DlT5Uqj6c3ldkgIT/84cxVFiBZ
         po9c5xEG13oc7ncHsqZP1e5FcA3OAjsCkMJNh3O/XRmuoY5ECXxZgSMCrlWwMAXuMwsJ
         o+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757387577; x=1757992377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozJmTecCZaQaVpHG3vtWBfEpvgoJz+sihTYv5zJXl0c=;
        b=IiatkGbDiS82oHL6pv5Ox7EV7dtNGvG4aI0x4pvCHJtK5wVGZ1CftoH05ZWlIjY03O
         VSEM8CmTFdWwhmOKg66bw5OhHW9SbcCWOEjJNeV2bb3Ls3WeflaSWWzt3JqJpLjsHO1T
         nSQJC1zzDwTg1r4vJ/xsrVGdNfWOKQ7YBvT3hwgQFfe3vubF5zKsy23LosOlFw6Yi0JS
         9ZZPnj7FxDcrdON7QrOmhnzuvHFViMYDjoFD4PpHDmaKaRWUtyQ7tj33SONGn2fNmKmJ
         RK19xk+DFsZltye1VJoQDfZ3+P+1WfyRWlIgBT4G137euQR4eD2gbtgCeBGM4y3pspfk
         72LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8rTZ9zNZxUTwHl92p4UFDUQF4O8taJs7UQIkK1jXLLDX9rwccQSnTpvxgFKWxsd07riCVvcyoE/eumywAuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuaxtZ1cAXDebEaPf9KE5sdxIPydqMQ22fPiHZFCWjs24hdcnG
	SIyl+/ejLtj+zn0nL5gUeCzckTp9BAQAr1j21u9w+uo0c+edHlapauG6r+1E8oiaPNhy9Q==
X-Gm-Gg: ASbGncv9xjt3bG6zeFMK2LuIqjLSxhPvm16u/cCj96WSVWCbLs5txetbY5EWZu1o8o0
	jjCr3JSn47CAFFpTgFR+FoPTQBee/shWHOPPk1wVAH7YtdFSYsntZQJYj3ASIgHSysYXeMrM/w6
	2/ECwhsOywlmOOS8ziMJnI3vbMmCDimeHLUY9xsExzm/vZbOmuho1FnYVWIDadu1FZUAU2q1IeO
	Ve8QP7Serq8uLc16X3E3vL3IrUgK7755Sh7jRnNDA/99nEU4YSfKq5DesBbU2VX4yr2lrPUOLjN
	a8J9ms1VUPiaVnXqw6yImS0TbAtuPMI/ufijVmOHXTfUizIhXd4giO+bYtDhnBd4P3jLNMcXmWU
	ZSUybYgaz/cg4idlO8XAeJwnvPvcjKGKGfkZrsgQ=
X-Google-Smtp-Source: AGHT+IGeZORxj2TuzssvraEhzbXNcBD2iJdBD9DzMPy020ZixZWGl1UBAyFIC/nQ9V+MAdCEn08cbg==
X-Received: by 2002:a17:902:d4c5:b0:251:a3b3:1580 with SMTP id d9443c01a7336-251a3b32022mr146712775ad.6.1757387576624;
        Mon, 08 Sep 2025 20:12:56 -0700 (PDT)
Received: from nyaos.. ([38.207.136.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24df9e881casm100456855ad.62.2025.09.08.20.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:12:56 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Cc: chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH 1/1] openrisc: Add the basic static ftrace support
Date: Tue,  9 Sep 2025 03:12:48 +0000
Message-ID: <20250909031248.591433-2-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250909031248.591433-1-chenmiao.ku@gmail.com>
References: <20250909031248.591433-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

This patch contains basic ftrace support for OR1K platform.
Specifically, function tracer (HAVE_FUNCTION_TRACER), function graph
tracer (HAVE_FUNCTION_GRAPH_TRACER), and a frame pointer test
(HAVE_FUNCTION_GRAPH_FP_TEST) are implemented following the
instructions in Documentation/trace/ftrace-design.txt.

Note that the functions in both ftrace.c and setup.c should not be
hooked with the compiler's -pg option: to prevent infinite self-
referencing for the former, and to ignore early setup stuff for the
latter.

Currently, dynamic ftrace has not been implemented yet. Directly
porting the existing dynamic ftrace would require significant effort.
If we want to minimally support dynamic ftrace, some APIs have changed,
making it temporarily unsuccessful to port.

By enabling the built-in kselftest option and some necessary configs,
you can refer to the detailed steps provided in the link below for testing.

Link: https://github.com/ChenMiaoi/GSoC-2025-Final-Report/tree/main/tests/ftrace-test

Test Environment:
- Hardware: QEMU emulated OR1K
- Kernel Version: 6.17.0-rc3-dirty
- Configs: CONFIG_FTRACE=y,CONFIG_FUNCTION_TRACER=y,
  CONFIG_RING_BUFFER_BENCHMARK=y,CONFIG_FTRACE_SELFTEST=y,
  CONFIG_FTRACE_STARTUP_TEST=y,CONFIG_EVENT_TRACE_STARTUP_TEST=y,
  CONFIG_EVENT_TRACE_TEST_SYSCALLS=y,CONFIG_TIMER_TRACER=y,
  CONFIG_OSNOISE_TRACER=y,CONFIG_TRACER_MAX_TRACE=y,
  CONFIG_TRACE_EVENT_INJECT=y
- Toolchain: or1k-none-linux-musl-gcc 15.1.0

Test Result:
cat trace
tracer: function
entries-in-buffer/entries-written: 72039/30671200   #P:1

                          _-----=> irqs-off/BH-disabled
                         / _----=> need-resched
                        | / _---=> hardirq/softirq
                        || / _--=> preempt-depth
                        ||| / _-=> migrate-disable
                        |||| /     delay
     TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTIO
        | |         |   |||||     |         |
     bash-142     [000] .....   290.910000: ksys_read <-sys_read
     bash-142     [000] .....   290.910000: fdget_pos <-ksys_read
     bash-142     [000] .....   290.910000: vfs_read <-ksys_read
     bash-142     [000] .....   290.910000: sys_pselect6 <-_syscall_return
     bash-142     [000] .....   290.910000: get_timespec64 <-sys_pselect6
     bash-142     [000] .....   290.910000: poll_select_set_timeout <-sys_pselect6
     bash-142     [000] .....   290.910000: set_user_sigmask <-sys_pselect6
     bash-142     [000] .....   290.910000: core_sys_select <-sys_pselect6

This change combines techniques from:
- commit 819e50e25d0c ("arm64: Add ftrace support")
- commit 10626c32e382 ("riscv/ftrace: Add basic support")

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/openrisc/Kconfig                   |   1 +
 arch/openrisc/configs/or1ksim_defconfig |   2 +-
 arch/openrisc/configs/virt_defconfig    |   1 +
 arch/openrisc/include/asm/ftrace.h      |  29 ++++
 arch/openrisc/kernel/Makefile           |   7 +
 arch/openrisc/kernel/entry-ftrace.S     | 185 ++++++++++++++++++++++++
 arch/openrisc/kernel/ftrace.c           |  35 +++++
 7 files changed, 259 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/ftrace.h
 create mode 100644 arch/openrisc/kernel/entry-ftrace.S
 create mode 100644 arch/openrisc/kernel/ftrace.c

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9156635dd264..a274e95a84cb 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -26,6 +26,7 @@ config OPENRISC
 	select GENERIC_CPU_DEVICES
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
+	select HAVE_FUNCTION_TRACER
 	select HAVE_PCI
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 769705ac24d5..12a2e31e6363 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -7,7 +7,6 @@ CONFIG_EXPERT=y
 # CONFIG_TIMERFD is not set
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
-# CONFIG_KALLSYMS is not set
 CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
 CONFIG_JUMP_LABEL=y
@@ -49,3 +48,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_STACK_TRACER=y
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index a93a3e1e4f87..08cfcdd60033 100644
--- a/arch/openrisc/configs/virt_defconfig
+++ b/arch/openrisc/configs/virt_defconfig
@@ -106,3 +106,4 @@ CONFIG_UNICODE=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_FTRACE=y
+CONFIG_STACK_TRACER=y
diff --git a/arch/openrisc/include/asm/ftrace.h b/arch/openrisc/include/asm/ftrace.h
new file mode 100644
index 000000000000..d7691a351ee7
--- /dev/null
+++ b/arch/openrisc/include/asm/ftrace.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017 Andes Technology Corporation
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#include "linux/export.h"
+#include <asm/insn-def.h>
+
+#ifndef __ASM_OPENRISC_FTRACE_H
+#define __ASM_OPENRISC_FTRACE_H
+
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_FRAME_POINTER)
+#define HAVE_FUNCTION_GRAPH_FP_TEST
+#endif
+
+#define MCOUNT_ADDR ((unsigned long)_mcount)
+#define MCOUNT_INSN_SIZE OPENRISC_INSN_SIZE
+
+#ifndef __ASSEMBLER__
+extern void _mcount(void);
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer);
+#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
+
+#endif /* __ASSEMBLER__ */
+
+#endif /* __ASM_OPENRISC_FTRACE_H */
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 19e0eb94f2eb..9a4ef72380ed 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -3,12 +3,19 @@
 # Makefile for the linux kernel.
 #
 
+ifdef CONFIG_FTRACE
+CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_setup.o = -pg
+endif
+
 always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
 obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
 	   sys_call_table.o unwinder.o cacheinfo.o
 
+obj-$(CONFIG_FUNCTION_TRACER) += entry-ftrace.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/openrisc/kernel/entry-ftrace.S b/arch/openrisc/kernel/entry-ftrace.S
new file mode 100644
index 000000000000..27acbbfe40f6
--- /dev/null
+++ b/arch/openrisc/kernel/entry-ftrace.S
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017 Andes Technology Corporation
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/cfi_types.h>
+#include <asm/ftrace.h>
+
+	.text
+
+	.macro SAVE_ABI_STATE
+	l.addi	r1, r1, -8         /* Allocate 8 bytes stack space */
+	l.sw		0(r1), r2          /* Save frame pointer (r2) */
+	l.sw		4(r1), r9          /* Save return address (r9) */
+	l.addi	r2, r1, 8          /* Set new frame pointer */
+	.endm
+
+	.macro SAVE_RET_ABI_STATE
+	l.addi	r1, r1, -16
+	l.sw		0(r1), r2
+	l.sw		4(r1), r9
+	l.sw		8(r1), r11         /* Save function return value (r11) */
+	l.sw		12(r1), r3
+	l.addi	r2, r1, 16
+	.endm
+
+	.macro RESTORE_ABI_STATE
+	l.lwz		r9, 4(r1)          /* Restore return address (r9) */
+	l.lwz		r2, 0(r1)          /* Restore frame pointer (r2) */
+	l.addi	r1, r1, 8          /* Free stack space */
+	.endm
+
+	.macro RESTORE_RET_ABI_STATE
+	l.lwz		r3, 12(r1)
+	l.lwz		r11, 8(r1)         /* Restore function return value (r11) */
+	l.lwz		r9, 4(r1)
+	l.lwz		r2, 0(r1)
+	l.addi	r1, r1, 16
+	.endm
+
+	.macro LOAD_FUNCTION reg func
+	l.movhi	\reg, hi(\func)
+	l.ori		\reg, \reg, lo(\func)
+	l.lwz		\reg, 0(\reg)
+	.endm
+
+/*
+ * void ftrace_stub(void)
+ * {
+ *    return;
+ * }
+ */
+SYM_TYPED_FUNC_START(ftrace_stub)
+	l.jr	r9
+	 l.nop
+SYM_FUNC_END(ftrace_stub)
+
+#if CONFIG_FUNCTION_GRAPH_TRACER
+SYM_TYPED_FUNC_START(return_to_handler)
+	/*
+	 * void return_to_handler(void)
+	 * {
+	 *    save all state needed by the API
+	 *    void (*original_return_point)(void) = ftrace_return_to_handler();
+	 *    restore all state needed by the ABI
+	 *
+	 *    original_return_point();
+	 * }
+	 */
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	l.or		r27, r2, r2
+#endif
+	SAVE_RET_ABI_STATE
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	l.or		r3, r27, r27
+#endif
+
+	LOAD_FUNCTION r17 ftrace_return_to_handler
+	l.jalr	r17
+	 l.nop
+
+	l.or		r19, r0, r11
+
+	RESTORE_RET_ABI_STATE
+
+	l.jalr	r19
+	 l.nop
+SYM_FUNC_END(return_to_handler)
+#endif
+
+SYM_TYPED_FUNC_START(_mcount)
+	/*
+	 * void mcount(void)
+	 * {
+	 *    if (ftrace_trace_function != ftrace_stub)
+	 *        goto do_trace;
+	 *    return;
+	 */
+	LOAD_FUNCTION r15, ftrace_stub
+
+#if CONFIG_FUNCTION_GRAPH_TRACER
+	/*
+	 *    extern void (*ftrace_graph_return)(...);
+	 *    extern void (*ftrace_graph_entry)(...);
+	 *    if (ftrace_graph_return != ftrace_stub ||
+	 *        ftrace_graph_entry != ftrace_graph_entry_stub)
+	 *        ftrace_graph_caller();
+	 */
+	LOAD_FUNCTION r17, ftrace_graph_return
+	l.sfne	r17, r15
+	l.bf		do_ftrace_graph_caller
+	 l.nop
+
+	LOAD_FUNCTION r19, ftrace_graph_entry
+	LOAD_FUNCTION r21, ftrace_graph_entry_stub
+	l.sfne	r21, r19
+	l.bf		do_ftrace_graph_caller
+	 l.nop
+#endif
+
+	LOAD_FUNCTION r29, ftrace_trace_function
+	l.sfne	r29, r15
+	l.bf		do_trace
+	 l.nop
+
+	l.jr		r9
+	 l.nop
+
+#if CONFIG_FUNCTION_GRAPH_TRACER
+	/*
+	 * void ftrace_graph_caller(void)
+	 * {
+	 *    save all state needed by the ABI
+	 *    unsigned long *frompc = &...;
+	 *    unsigned long selfpc = <return address> - MCOUNT_INSN_SIZE;
+	 *    passing frame pointer up is optional -- see below
+	 *    prepare_ftrace_return(frompc, selfpc, frame_pointer);
+	 *    restore all state needed by the ABI
+	 * }
+	 */
+do_ftrace_graph_caller:
+	l.addi	r3, r2, -4
+	l.or		r4, r1, r1
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	l.lwz		r5, -8(r2)
+#endif
+	SAVE_ABI_STATE
+
+	/*
+	 * DO NOT USE LOAD_FUNCTION r23 prepare_ftrace_return instead of bare asm
+	 * because the prepare_ftrace_return's address already store in the r23,
+	 * if use l.lwz r23, 0(r23), it will load the first insn of r23.
+	 */
+	l.movhi	r23, hi(prepare_ftrace_return)
+	l.ori		r23, r23, lo(prepare_ftrace_return)
+	l.jalr	r23
+	 l.nop
+
+	RESTORE_ABI_STATE
+
+	l.jr		r9
+	 l.nop
+#endif
+
+	/*
+	 * do_trace:
+	 *    save all need ABI state
+	 *    ftrace_trace_function(ra_to_caller, ra_to_caller_of_caller);
+	 *    restore ABI state
+	 */
+do_trace:
+	l.lwz		r4, -4(r2)
+	l.or		r3, r9, r9
+
+	SAVE_ABI_STATE
+	l.jalr	r29
+	 l.nop
+	RESTORE_ABI_STATE
+
+	l.jr		r9
+	 l.nop
+SYM_FUNC_END(_mcount)
+EXPORT_SYMBOL(_mcount)
diff --git a/arch/openrisc/kernel/ftrace.c b/arch/openrisc/kernel/ftrace.c
new file mode 100644
index 000000000000..2b92bd580230
--- /dev/null
+++ b/arch/openrisc/kernel/ftrace.c
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ * Copyright (C) 2017 Andes Technology Corporation
+ * Copyright (C) 2025 Chen Miao
+ */
+
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/*
+ * Most of this function is copied from arm64. However, the main porting work
+ * referred to RISC-V.
+ */
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	return;
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	/*
+	 * We don't suffer access faults, so no extra fault-recovery assembly
+	 * is needed here.
+	 */
+	old = *parent;
+
+	if (!function_graph_enter(old, self_addr, frame_pointer, parent))
+		*parent = return_hooker;
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.45.2

