Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D720ADFF;
	Fri, 10 Jan 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504593; cv=none; b=NxS4j68mFPmty098df3y61I34vcHMWhLq6R0jKZyDpSOPoYL3Octc4iKBF75AA7Pdvi8MdiOqsHZuXoWAnGTklUCPita1KbfbCIpm52ESSSlbZ681qe2AoNSxd+ajWrhPw7AXYULjDl9/nKp2pLEVnzKoENWcLdWp3059fLoKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504593; c=relaxed/simple;
	bh=JTEB1ZD2j178tIeGqenW4cWlUfC4Yb5zBZXzmPf9Lzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOwXQfgJofiWioN2Pal+bZ/vE477jg0U9eQDOwAJIwEK2BizZVdr6BFC2s5Eb7CUnd8bnd/Bm+8oLq+IcLTaCYxI5FVFpAvblQjZCZdZPjRoPsClfqeXKeteetjAxsHYeeInXVxsjTr7f6TgP3t8Gx4Ydxn2PmbALuXeEr4PUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIeTLErk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIeTLErk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4368a293339so21789525e9.3;
        Fri, 10 Jan 2025 02:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736504589; x=1737109389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6mWPNiKwExHnTuZnNtU1VWzWZG0am7gL84eXSeAyTw=;
        b=YIeTLErkFIL+vSrtUVMomkja0IYk1DBv0OoEM0bNSKopk4ZJ0frwkfsopc8MOWPpZP
         TW+p3DCq5LSztyEXKglmo+k0t3FuZToIybNNyEe+tcbbGNC9u1YVmqIM2h5rh6r1/0wh
         vC2eg7VLgBZEkSL/gIPHNE/K6/FhRzydsP9/iQ+gqjc6TBH3AUW1eBtMrI03Wc5RuPgq
         k2aY1GZH56yDpyJhVCe9V7jXZIv8flETcbRBkmd+lt+cKKlgSo8QCX11K1AD7nM4I1Ik
         9WPsWbBSsXIHBiBspuCZWvBdKHd62kazfQCkY61HkxayOnfVWZ3jdi2ysBNhvlFmm18l
         g0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504589; x=1737109389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6mWPNiKwExHnTuZnNtU1VWzWZG0am7gL84eXSeAyTw=;
        b=E6YF9LhxF9puKnXddyaVuqdKCezyWNfWxteJvjnAlEeXQ/ZH3hv+l1FZUJ/FVS4Yjn
         vmPNWyWpdkxFA+bS6aZenrTrEUjdQwdZNU6aIX7rCPsH/eGpMu2WIzabHdLyQZlLrAX3
         tlvI48wqKwa3tsFZW4aRY78HFeRgvqegIGuWpithgpbjPv82DRsXsdGCAe0+nPo4x5BC
         vmAbmw8o2bXlQeNFvk/fJHYoJ+Y25gqClFhTlt0geunka6XZRuDQjK5CnPEkEZduRCcQ
         CsoyaGcPPBAGs9mJ6CLitMdwLkD4ehHsj+Z+sN1yHqhhupCqs0GLAFbY7YPZC3ln4T/L
         CQfQ==
X-Gm-Message-State: AOJu0Yxy+raFdDbov5kiw7rXq7ccnp/Lwr4bdM9KF5yZMuKYGZFeSWP2
	BASlRFigEaK4mml0BSu8L8Bdxds32tYLugtp8UEWfELNhd4qSV3ofkDdrTq4
X-Gm-Gg: ASbGncvZP97BuMn4qGN/dr8rt3Ho6sNasB2MF9JlwD1wVqawzl5MaRfVKvlRGG1WZLi
	I0J42UYp4LgZWDJjCgekuRn+cwFxDB6LZWKNhzlzJXV/VxQwNJ8L0RrEMbgZINNzwNtmwPkf9Z3
	qhhAgHwc30ff0oRiLxcZe2hdaafGbKta5WnaO8A+h7K8h+b8eFuLgIpxPl3XkiEu1ZSbYkSLU48
	vACkQfO4XbdL4X/f5jxbjkW/uKMazcm0BZRGBGxt+/guRM6BT6r0wX03+rFSFiRbLcm87/GnkEa
	o9dPZtMaMuSpmdAFYR8p
X-Google-Smtp-Source: AGHT+IF8WuJ26kRNb1exsK3w6UlDdYN54HAB1Ij48aG9rvFFp/Got3W63c6Bxww+P+IxKRzDvqnDFA==
X-Received: by 2002:a05:600c:4f09:b0:434:a5d1:9905 with SMTP id 5b1f17b1804b1-436e27070bcmr84328935e9.26.1736504588617;
        Fri, 10 Jan 2025 02:23:08 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm83187615e9.2.2025.01.10.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:07 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support
Date: Fri, 10 Jan 2025 10:22:43 +0000
Message-ID: <20250110102248.3295944-2-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250110102248.3295944-1-shorne@gmail.com>
References: <20250110102248.3295944-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Jeanson <mjeanson@efficios.com>

Support for HAVE_REGS_AND_STACK_ACCESS_API needed for restartable
sequences.

The implementation has been copied from riscv and tested with the
restartable sequences self tests.

Note, pt-regs members are 'long' on openrisc which require casts for the
api, someday we should try to update these to be 'unsigned long' as
that's what they really are.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
[stafford: Updated commit message]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig              |  1 +
 arch/openrisc/include/asm/ptrace.h | 73 ++++++++++++++++++++++-
 arch/openrisc/kernel/ptrace.c      | 96 ++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 3279ef457c57..f2be2a88c286 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -26,6 +26,7 @@ config OPENRISC
 	select HAVE_PCI
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
+	select HAVE_REGS_AND_STACK_ACCESS_API
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 1da3e66292e2..e5a282b67075 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -17,6 +17,7 @@
 
 #include <asm/spr_defs.h>
 #include <uapi/asm/ptrace.h>
+#include <linux/compiler.h>
 
 /*
  * Make kernel PTrace/register structures opaque to userspace... userspace can
@@ -42,6 +43,36 @@ struct pt_regs {
 			/* Named registers */
 			long  sr;	/* Stored in place of r0 */
 			long  sp;	/* r1 */
+			long  gpr2;
+			long  gpr3;
+			long  gpr4;
+			long  gpr5;
+			long  gpr6;
+			long  gpr7;
+			long  gpr8;
+			long  gpr9;
+			long  gpr10;
+			long  gpr11;
+			long  gpr12;
+			long  gpr13;
+			long  gpr14;
+			long  gpr15;
+			long  gpr16;
+			long  gpr17;
+			long  gpr18;
+			long  gpr19;
+			long  gpr20;
+			long  gpr21;
+			long  gpr22;
+			long  gpr23;
+			long  gpr24;
+			long  gpr25;
+			long  gpr26;
+			long  gpr27;
+			long  gpr28;
+			long  gpr29;
+			long  gpr30;
+			long  gpr31;
 		};
 		struct {
 			/* Old style */
@@ -66,16 +97,56 @@ struct pt_regs {
 /* TODO: Rename this to REDZONE because that's what it is */
 #define STACK_FRAME_OVERHEAD  128  /* size of minimum stack frame */
 
-#define instruction_pointer(regs)	((regs)->pc)
+#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_gpr11)
+
+/* Helpers for working with the instruction pointer */
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs->pc;
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	regs->pc = val;
+}
+
 #define user_mode(regs)			(((regs)->sr & SPR_SR_SM) == 0)
 #define user_stack_pointer(regs)	((unsigned long)(regs)->sp)
 #define profile_pc(regs)		instruction_pointer(regs)
 
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs->sp;
+}
+
 static inline long regs_return_value(struct pt_regs *regs)
 {
 	return regs->gpr[11];
 }
 
+extern int regs_query_register_offset(const char *name);
+extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+					       unsigned int n);
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	pt_regs from which register value is gotten
+ * @offset:	offset of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+					      unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 5091b18eab4c..8430570d0620 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -160,6 +160,102 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
  * in exit.c or in signal.c.
  */
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(sr),
+	REG_OFFSET_NAME(sp),
+	REG_OFFSET_NAME(gpr2),
+	REG_OFFSET_NAME(gpr3),
+	REG_OFFSET_NAME(gpr4),
+	REG_OFFSET_NAME(gpr5),
+	REG_OFFSET_NAME(gpr6),
+	REG_OFFSET_NAME(gpr7),
+	REG_OFFSET_NAME(gpr8),
+	REG_OFFSET_NAME(gpr9),
+	REG_OFFSET_NAME(gpr10),
+	REG_OFFSET_NAME(gpr11),
+	REG_OFFSET_NAME(gpr12),
+	REG_OFFSET_NAME(gpr13),
+	REG_OFFSET_NAME(gpr14),
+	REG_OFFSET_NAME(gpr15),
+	REG_OFFSET_NAME(gpr16),
+	REG_OFFSET_NAME(gpr17),
+	REG_OFFSET_NAME(gpr18),
+	REG_OFFSET_NAME(gpr19),
+	REG_OFFSET_NAME(gpr20),
+	REG_OFFSET_NAME(gpr21),
+	REG_OFFSET_NAME(gpr22),
+	REG_OFFSET_NAME(gpr23),
+	REG_OFFSET_NAME(gpr24),
+	REG_OFFSET_NAME(gpr25),
+	REG_OFFSET_NAME(gpr26),
+	REG_OFFSET_NAME(gpr27),
+	REG_OFFSET_NAME(gpr28),
+	REG_OFFSET_NAME(gpr29),
+	REG_OFFSET_NAME(gpr30),
+	REG_OFFSET_NAME(gpr31),
+	REG_OFFSET_NAME(pc),
+	REG_OFFSET_NAME(orig_gpr11),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return (addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
 
 /*
  * Called by kernel/ptrace.c when detaching..
-- 
2.47.0

