Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32240C6FA83
	for <openrisc@archiver.kernel.org>; Sat,  3 Sep 2022 16:23:56 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6EE6F24B1D;
	Sat,  3 Sep 2022 18:23:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id 3EC0A24B1E
 for <openrisc@lists.librecores.org>; Sat,  3 Sep 2022 18:23:54 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 046CB60A09;
 Sat,  3 Sep 2022 16:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973D6C433D7;
 Sat,  3 Sep 2022 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662222232;
 bh=KP0swQ0+kClqdN6HeWUaPcd4siKNWtxg+hX1oInsUFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MW5Ml0XVb8n9WtUPo4R8Hz1XeXEfIRU7wXu1TqWJx+L+2V65xknIh78V4JcHnRzzN
 G+WuNhhGSYt5fjNP5j28KCOfJJG2WJ25OixJIuJqB7p1ZHffDastM6SftSYAecdcnS
 0J3Vyk7KdRHeNiZTHd7PeNAESrRRoyJlj3UF5rZ5mMPQnXrpcxgU8sxoX7fViklSe+
 gmv5TRHOHGHJYni6v+DCI0ZCTQCn5UrnQUa0q6dTzjfaIvRRMmdbsMEeAiOcPvo0Vw
 fxi+uBeeC1vvy2fRaE+/1EbxRexGTtBMRSNX9K4rYgDoVtH0OE3Duyw0T1OWbZZZvK
 x5E5UZhz8GA7A==
From: guoren@kernel.org
To: oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
 monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
 davem@davemloft.net, arnd@arndb.de, shorne@gmail.com, guoren@kernel.org
Subject: [PATCH V2 2/3] openrisc: ptrace: Remove duplicate operation
Date: Sat,  3 Sep 2022 12:23:26 -0400
Message-Id: <20220903162328.1952477-3-guoren@kernel.org>
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
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index b971740fc2aa..cc53fa676706 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -132,7 +132,6 @@ void ptrace_disable(struct task_struct *child)
 	pr_debug("ptrace_disable(): TODO\n");
 
 	user_disable_single_step(child);
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
-- 
2.36.1

