Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045638;
	b=x7nfbUk3gR0im/Xv5t66n54kw4nJVof0Yyd4pWBr288PJXtL7067W5zZ7Q9FRFOzhp5r
	 uqKndHIB99Ffons7C2HasDH0tQAPdMjz1nweFBYrGYQlDFNHVmfmYcMFUqXgkawjGio++
	 Nden2KKXZQENQ5wYHNkW5rc7lEdGeLqIVGLxmHS/RMpgavfRJM+MT+8ygYEhYqdJLrWgS
	 pcPx5qQFgIIEoNGXWCr+BEm4T5FP+6S8r9qoBkIrTTpzSq+ic1dsT6GYZKmjxkKaWjoAm
	 Dzi0i+RFsMCxQT2b5tiEwQF8iA2jqU7xFH5zt/WWjESH6APQb9yPyWOSB1T8BMOEACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q8AEEwHTufrmryJTMsqhvzKZ6h2afKOYiH2xqSkBe5Y=;
	b=nQ0Qq9DtOM5kxjLZ5ROzDeyrCruRzXbVlQr1xF+PfNBBY1Zpd65u3wYY5m1YGJBctMhD
	 h46j8vpAyhtFqHoCzKv/5bHKXBUK73rJk5/UFmxLMTs5pBHW8czHZOT/MKlcq6VIxVSI5
	 wzst9fSiTkqFHdnuo647WwDSrgLRSFEWukYDqE6f6V81BaU1TWY5r3k4fQY+iX8uXrkkY
	 1avU1IRuiQ/RyhSMY4RYb7jK5v7d5laIasPFp+o3yqc+l0Pnl9D6ZX7zeDdh7DFEahlK6
	 12QRwFEWfjm4bxMOwsZUvjKjlnwQZRK7r0zcBPCWRK3WwBSdngZoKy+4tPEHLe+s+rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M9nqX60h;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7A606A31B
	for <linux-openrisc@vger.kernel.org>; Mon, 26 Oct 2026 20:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB7A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M9nqX60h
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59622so2743185c88.0
        for <linux-openrisc@vger.kernel.org>; Mon, 26 Oct 2026 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793045637; x=1793650437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8AEEwHTufrmryJTMsqhvzKZ6h2afKOYiH2xqSkBe5Y=;
        b=M9nqX60h6UASgVEfTP+vJ5fHXK4iggnxl8c+u1lnR7uefcFeJ9KYTdmZUHOA+9XpEV
         zuExPp84uVmsvMkYlwaW6vXWn2EXnLyo23Kdodrg2at8RCg+CM+/bqdWeL56Fv4vSDjX
         y4dS3Q/Z21K+V9pib0nUKUKjVrNAoh0m7jvzl3PTovN/UNAcECvVP5nwkXS57ij6Ba4K
         3Fliq0BP2LJn3uEbDvkMOzWQARHYPgRC+U8Ki3S8WIMsMzrVbKYvso6pxzBEGH/YJqV0
         y8RjJ+CsSZ7hVFZk+h8/1mgqkvQ+awGQAsJcPicNKqUYu85zXAkO3sB8O42VlAm9an7L
         UqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793045637; x=1793650437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q8AEEwHTufrmryJTMsqhvzKZ6h2afKOYiH2xqSkBe5Y=;
        b=X8FysJIb8bEcMk12nLDlHvxecFASEb6OWfOvXHYKp7EgHBJotuzNbEObx+9uxXVWzo
         NsGZ61t2Zn6uaREpVYjdZO2xIpcSQ+caQFPa+U2ZzlnW0tE/3SiU+DjJcH5IrN2dI2aj
         ZlQhanw8M4BQiOTBXbAvx6/LtI3niG1oyy+HxmCrqbmUEd9XtTU+VolAUyh2FfWXbvIe
         Bw4ndI4Yd1Ze8jRfhaBp4DFod9STIpBEXcbjoF27m95Kqq0Yn79z9g7rg7GY+qbXp4eL
         LKMW579l8HXTpnjbArY847ZIJIcLjer1+gthS3oXdvn63xs+CWYw+rxyQWFE/9RowFqL
         q4Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxSUjczPE1gBvNlL2vSxazsT9pDeCEMIiw3PKYt3TrctSJp+eoR9euLPEKqVGtEOYgIvpyIwZU4BrIFUeWxHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKDwn5lArk8RYIOxb6PJO1LobKMyG+1SOxrVVvnpAkkuF/kV1wB
	so1/TlGq/2hMnQkS5JvZM2+Kl8BerL0RFwD+EZg0GW8q+VgVfyyeZwnS
X-Gm-Gg: AYBFou3yvYNEV4JaV9aa2zH3O3OX5vyMaU52H6aH8cR9Pg0dtxmewTWA0jxz+X/Iz4Q
	Ujp/TWRpwBWrQkYhBdol8yOfXcmEych2BviLYaa+AhuLKeGyDXArzVE8XDySPfGQLT5oMb8KzK3
	OAkIO5PKp6uCZGimxLaUJBbanasiCFq2cEoAjOr7pcSm7mvooAnKULZDD7f3xI97afg7q2bfCwR
	Av51uQklHltcl3pSz49awM4w4iHyZ+G9Seu9++09EZQnwbMolTkdMqEjIZZvYa43WQyDXoFeDHq
	WssgMZ2LptntpDHonzF7WEnmRjwrznaqBh72fkPShGfZDdjhk8lNFvUWsoo9QjxFHRIKY7Ym4y9
	jIa0SKKk0xhGy3pQZ7vAjVy2Mej8ueNHjBHTKxWmSbkrk319jMD9Z3tZ6yj0n+kltnsKMtQBsaZ
	iew2wIdjpbx7S7qTyl10yXCtxLrfXxu+dezmlo8i69z+39JVUslx30P4xZDg6ZJuHyYaq6GEwOq
	2JYo2xqBySMatuPCk5B/zVuwknjfMl+IVKZDZcBUxfrQqeSeeInE7PqR+gjTHw=
X-Received: by 2002:a05:7022:1702:b0:14e:d0ba:7569 with SMTP id a92af1059eb24-199290fe34cmr9680108c88.6.1793045636848;
        Mon, 26 Oct 2026 13:13:56 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:61b8:f26f:bd5b:b550:7a07])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm31730486c88.6.2026.10.26.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:13:56 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: pjw@kernel.org,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v3 4/4] openrisc: Add Kretprobes
Date: Tue, 27 Oct 2026 01:42:40 +0530
Message-ID: <20261026201240.107462-5-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Kretprobes support for OpenRISC. Kretprobes allow a probe to be
fired when a function returns. They are built on top of the generic
rethook framework and also require the KProbe mechanism introduced
in the previous commit. This work is primarily based on similar work
done for RISC-V.

Kretprobes work by inserting a KProbe at a function's entry point.
When the function begins to execute, the KProbe is fired and its
pre-handler replaces the function's return address with that of the
rethook trampoline. The trampoline in turn calls the kretprobe handler.
Control is returned to the original caller following this.

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
Changes v2 -> v3:
- arch/openrisc/kernel/rethook_trampoline.S:
  (save_all_base_regs): Save SR and SP registers
  (restore_all_base_regs): Restore SR register

Changes v1 -> v2: New commit

 arch/openrisc/Kconfig                     |   2 +
 arch/openrisc/kernel/Makefile             |   1 +
 arch/openrisc/kernel/rethook.c            |  32 +++++++
 arch/openrisc/kernel/rethook.h            |   8 ++
 arch/openrisc/kernel/rethook_trampoline.S | 111 ++++++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 arch/openrisc/kernel/rethook.c
 create mode 100644 arch/openrisc/kernel/rethook.h
 create mode 100644 arch/openrisc/kernel/rethook_trampoline.S

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index d240533b424b..82365eb8f574 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -28,6 +28,8 @@ config OPENRISC
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_PCI
 	select HAVE_KPROBES
+	select HAVE_KRETPROBES
+	select HAVE_RETHOOK
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 0c1cade09e0c..e36537cea319 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_OR_KPROBES_KUNIT)	+= tests/
 obj-y	+= patching.o
 
diff --git a/arch/openrisc/kernel/rethook.c b/arch/openrisc/kernel/rethook.c
new file mode 100644
index 000000000000..50ef6715d044
--- /dev/null
+++ b/arch/openrisc/kernel/rethook.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Generic return hook for OpenRISC. Depends on KProbes.
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * OpenRISC implementation:
+ * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+#include "rethook.h"
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, regs->gpr2);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback)
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	/* Store original return address and frame pointer */
+	rhn->ret_addr = regs->gpr9;
+	rhn->frame = regs->gpr2;
+
+	/* Set return address to trampoline */
+	regs->gpr9 = (unsigned long)arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare)
diff --git a/arch/openrisc/kernel/rethook.h b/arch/openrisc/kernel/rethook.h
new file mode 100644
index 000000000000..332306a5c380
--- /dev/null
+++ b/arch/openrisc/kernel/rethook.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __OPENRISC_RETHOOK_H
+#define __OPENRISC_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/kernel/rethook_trampoline.S
new file mode 100644
index 000000000000..5e8fd5a65222
--- /dev/null
+++ b/arch/openrisc/kernel/rethook_trampoline.S
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ptrace.h>
+
+	.text
+
+	.macro save_all_base_regs
+	l.sw	PT_GPR2(r1),r2
+	l.sw	PT_GPR3(r1),r3
+	l.sw	PT_GPR4(r1),r4
+	l.sw	PT_GPR5(r1),r5
+	l.sw	PT_GPR6(r1),r6
+	l.sw	PT_GPR7(r1),r7
+	l.sw	PT_GPR8(r1),r8
+	l.sw	PT_GPR9(r1),r9
+	l.sw	PT_GPR10(r1),r10
+	l.sw	PT_GPR11(r1),r11
+	l.sw	PT_GPR12(r1),r12
+	l.sw	PT_GPR13(r1),r13
+	l.sw	PT_GPR14(r1),r14
+	l.sw	PT_GPR15(r1),r15
+	l.sw	PT_GPR16(r1),r16
+	l.sw	PT_GPR17(r1),r17
+	l.sw	PT_GPR18(r1),r18
+	l.sw	PT_GPR19(r1),r19
+	l.sw	PT_GPR20(r1),r20
+	l.sw	PT_GPR21(r1),r21
+	l.sw	PT_GPR22(r1),r22
+	l.sw	PT_GPR23(r1),r23
+	l.sw	PT_GPR24(r1),r24
+	l.sw	PT_GPR25(r1),r25
+	l.sw	PT_GPR26(r1),r26
+	l.sw	PT_GPR27(r1),r27
+	l.sw	PT_GPR28(r1),r28
+	l.sw	PT_GPR29(r1),r29
+	l.sw	PT_GPR30(r1),r30
+	l.sw	PT_GPR31(r1),r31
+	/* Save SR in pt_regs */
+	l.mfspr	r13,r0,SPR_SR
+	l.sw	PT_SR(r1),r13
+	/* Save SP in pt_regs as it was prior to setting up this frame */
+	l.addi	r13,r1,PT_SIZE
+	l.sw	PT_SP(r1),r13
+	.endm
+
+	.macro restore_all_base_regs
+	/* Restore SR from pt_regs */
+	l.lwz	r13,PT_SR(r1)
+	l.mtspr	r0,r13,SPR_SR
+	/*
+	 * r1 doesn't need to be explicitly restored from pt_regs. When
+	 * arch_rethook_trampoline_callback finishes, it restores SP to
+	 * what it was before its frame was set up.
+	 */
+	l.lwz	r2,PT_GPR2(r1)
+	l.lwz	r3,PT_GPR3(r1)
+	l.lwz	r4,PT_GPR4(r1)
+	l.lwz	r5,PT_GPR5(r1)
+	l.lwz	r6,PT_GPR6(r1)
+	l.lwz	r7,PT_GPR7(r1)
+	l.lwz	r8,PT_GPR8(r1)
+	/* Return address in r9 is stale, so don't restore it */
+	l.lwz	r10,PT_GPR10(r1)
+	l.lwz	r11,PT_GPR11(r1)
+	l.lwz	r12,PT_GPR12(r1)
+	l.lwz	r13,PT_GPR13(r1)
+	l.lwz	r14,PT_GPR14(r1)
+	l.lwz	r15,PT_GPR15(r1)
+	l.lwz	r16,PT_GPR16(r1)
+	l.lwz	r17,PT_GPR17(r1)
+	l.lwz	r18,PT_GPR18(r1)
+	l.lwz	r19,PT_GPR19(r1)
+	l.lwz	r20,PT_GPR20(r1)
+	l.lwz	r21,PT_GPR21(r1)
+	l.lwz	r22,PT_GPR22(r1)
+	l.lwz	r23,PT_GPR23(r1)
+	l.lwz	r24,PT_GPR24(r1)
+	l.lwz	r25,PT_GPR25(r1)
+	l.lwz	r26,PT_GPR26(r1)
+	l.lwz	r27,PT_GPR27(r1)
+	l.lwz	r28,PT_GPR28(r1)
+	l.lwz	r29,PT_GPR29(r1)
+	l.lwz	r30,PT_GPR30(r1)
+	l.lwz	r31,PT_GPR31(r1)
+	.endm
+
+SYM_CODE_START(arch_rethook_trampoline)
+	/* Allocate enough space on stack for pt_regs */
+	l.addi	r1,r1,-PT_SIZE
+	save_all_base_regs
+
+	l.addi	r3,r1,0	/* pt_regs */
+	l.jal	arch_rethook_trampoline_callback
+	l.nop
+
+	/* use the result as the return-address */
+	l.addi	r9,r11,0
+
+	restore_all_base_regs
+	l.addi	r1,r1,PT_SIZE
+
+	l.jr	r9
+	l.nop
+SYM_CODE_END(arch_rethook_trampoline)
-- 
2.55.0

