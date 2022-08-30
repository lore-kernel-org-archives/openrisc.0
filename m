Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F406ECAAD1
	for <openrisc@archiver.kernel.org>; Tue, 30 Aug 2022 06:53:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2B8A1248E8;
	Tue, 30 Aug 2022 08:53:42 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mail.librecores.org (Postfix) with ESMTPS id AEDEE248D7
 for <openrisc@lists.librecores.org>; Tue, 30 Aug 2022 08:53:40 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 72D58CE12B2;
 Tue, 30 Aug 2022 06:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C028C433B5;
 Tue, 30 Aug 2022 06:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661842416;
 bh=ezCJz3zzII/UaKvcXNSbmcajv11zXu7NIaCF1ULUtp0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r3amRcUQDjcf2J5Fgpm3U2izv3yA9NBy7nxMxatvsZT6tZWH3Rv9dQGtrjH3iNkPE
 g6KyXSsfC/QLHSFUlf3IUv5+Vfh0AVJGPh5B8XP/13LvC1JxSH2AEqY4TAjFgDMhOt
 AS0BwAQwYQJwQ8z8KNiqh3xod+STWMH9o+hwivFoZq7RQCb10x+P565pwYgOgJl59G
 gjJI+WEJLyooY/K9536qNkXfUBIbivFBJ+BTi3q5eadkie5Q/E0dtzMU5gpdgyy2Z/
 CftmJ3I3bk4yFCtql/IygZNvGqnuuCDfY9wzgM1PhTXU0Cx8xMIXsaEyLjA9FHpb8w
 WEGB8pxdmmp3Q==
From: guoren@kernel.org
To: oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
 monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
 davem@davemloft.net, arnd@arndb.de, shorne@gmail.com, guoren@kernel.org
Subject: [PATCH 1/3] riscv: ptrace: Remove duplicate operation
Date: Tue, 30 Aug 2022 02:53:14 -0400
Message-Id: <20220830065316.3924938-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830065316.3924938-1-guoren@kernel.org>
References: <20220830065316.3924938-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Guo Ren <guoren@linux.alibaba.com>

The TIF_SYSCALL_TRACE is controlled by a common code, see
kernel/ptrace.c and include/linux/thread.h.

clear_task_syscall_work(child, SYSCALL_TRACE);

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2ae8280ae475..44f4b1ca315d 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -212,7 +212,6 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 
 void ptrace_disable(struct task_struct *child)
 {
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 long arch_ptrace(struct task_struct *child, long request,
-- 
2.36.1

