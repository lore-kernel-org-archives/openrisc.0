Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68480ECAAD4
	for <openrisc@archiver.kernel.org>; Sat,  3 Sep 2022 16:23:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 56E4A24B19;
	Sat,  3 Sep 2022 18:23:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 7E77A24B19
 for <openrisc@lists.librecores.org>; Sat,  3 Sep 2022 18:23:49 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 31E17B80B01;
 Sat,  3 Sep 2022 16:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD98C4347C;
 Sat,  3 Sep 2022 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662222227;
 bh=thj4lp5B0J2/kj7Zi1BMTTtT9fAnJMteMKwuLQ0ArOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L1+aqePh3YUl08I/8fm3yNxtjuAlMmF22bx5ehpr9WT67qVfD+H89UCSkcQb/aLVB
 2NgCQIILKBmcne0lsXQ4IjY3kiwJxrtWEcVDUccBIwJj+xp2BBbv39/+Grkh4ufLkt
 K91rg+/bdppmXjHBKL8/+fsOwTwEh6RA27omRUzQiTPDRz8Ke7YGMSqk5VWbmO8V0g
 cuN032j9tv98WDWH8CRTakVr3d5ZHL/aAuIuVJy9h6CrYmFwF6TJSlC05IZMYI+l9p
 sn7aIfOyaWt05CVB+QByWImFn4GjzoARn6PGsB37TcCAMXurxtZTf+xyhaxTSjNZpx
 M7BmVLEk5oE7g==
From: guoren@kernel.org
To: oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
 monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
 davem@davemloft.net, arnd@arndb.de, shorne@gmail.com, guoren@kernel.org
Subject: [PATCH V2 1/3] riscv: ptrace: Remove duplicate operation
Date: Sat,  3 Sep 2022 12:23:25 -0400
Message-Id: <20220903162328.1952477-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220903162328.1952477-1-guoren@kernel.org>
References: <20220903162328.1952477-1-guoren@kernel.org>
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
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
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

