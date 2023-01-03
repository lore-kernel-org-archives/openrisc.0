Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1B2C46467
	for <openrisc@archiver.kernel.org>; Tue,  3 Jan 2023 08:15:46 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 00BC9249CB;
	Tue,  3 Jan 2023 09:15:45 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id E8CFE24B36
 for <openrisc@lists.librecores.org>; Tue,  3 Jan 2023 09:15:43 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 38B6DB80E56;
 Tue,  3 Jan 2023 08:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705D7C433D2;
 Tue,  3 Jan 2023 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1672733741;
 bh=UYd+ZTk/Gn7QR2e7V6t0nk5APStpg6d2YkQqdhWRn8A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nEN0MWBoi9hvAqjTr34ZpvjonKyMSYceeCwDaPYxx6V9qbJ7II/u4AdHxgOb7Yp9J
 6+4bRp17FjMKzuRwdXB0GwwWPcnjUyQhtHWctJNHtr1sR7BZs0c1CebCHDhUdYH1ac
 KSfMRLSN3ZbUfGbtRs2+uqceDx2t4usj4TjlyvUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.10 28/63] openrisc: add support for TIF_NOTIFY_SIGNAL
Date: Tue,  3 Jan 2023 09:13:58 +0100
Message-Id: <20230103081310.271246944@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103081308.548338576@linuxfoundation.org>
References: <20230103081308.548338576@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, openrisc@lists.librecores.org,
 patches@lists.linux.dev
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit e181c0aa2e532af2b17128fbde699f8578cc0562 ]

Wire up TIF_NOTIFY_SIGNAL handling for openrisc.

Cc: openrisc@lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/openrisc/include/asm/thread_info.h |    2 ++
 arch/openrisc/kernel/signal.c           |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -98,6 +98,7 @@ register struct thread_info *current_thr
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user
 					 * mode
 					 */
+#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_SYSCALL_TRACEPOINT  8       /* for ftrace syscall instrumentation */
 #define TIF_RESTORE_SIGMASK     9
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling						 * TIF_NEED_RESCHED
@@ -109,6 +110,7 @@ register struct thread_info *current_thr
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
+#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -299,7 +299,7 @@ do_work_pending(struct pt_regs *regs, un
 			if (unlikely(!user_mode(regs)))
 				return 0;
 			local_irq_enable();
-			if (thread_flags & _TIF_SIGPENDING) {
+			if (thread_flags & (_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)) {
 				int restart = do_signal(regs, syscall);
 				if (unlikely(restart)) {
 					/*


