Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7002BC46467
	for <openrisc@archiver.kernel.org>; Tue,  3 Jan 2023 07:39:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 03D3924992;
	Tue,  3 Jan 2023 08:38:59 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id E4B0C248C9
 for <openrisc@lists.librecores.org>; Tue,  3 Jan 2023 08:38:56 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 50408B80E13;
 Tue,  3 Jan 2023 07:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB87DC433F0;
 Tue,  3 Jan 2023 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1672731535;
 bh=OIAuLBFh3tQray9pX2s4rXk9edPs0djBJtbs4qG7cXY=;
 h=Subject:To:Cc:From:Date:From;
 b=yZB896xMic8EPapniSfZrAi94pMr95mVU5UV8/NvBKEi16t+5ckcfkFa2aQED5urR
 prsI+1PSufVepL5DuJpcZyy4F72fZxzEK0RoC9H+BmT4/Oycr0TyypVlPDX0r+Tvu5
 QI7lpQzEbSx5XoyDO/JWPjD0orq8DMvEq+GxHHWk=
Subject: Patch "openrisc: add support for TIF_NOTIFY_SIGNAL" has been added to
 the 5.10-stable tree
To: axboe@kernel.dk, gregkh@linuxfoundation.org, openrisc@lists.librecores.org,
 shorne@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Jan 2023 08:36:30 +0100
Message-ID: <1672731390163127@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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
Cc: stable-commits@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>


This is a note to let you know that I've just added the patch titled

    openrisc: add support for TIF_NOTIFY_SIGNAL

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     openrisc-add-support-for-tif_notify_signal.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 64cef01754a4419e13f0f5f14ec4a9e181bffbe8 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 9 Oct 2020 15:24:46 -0600
Subject: openrisc: add support for TIF_NOTIFY_SIGNAL

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


Patches currently in stable-queue which might be from axboe@kernel.dk are

queue-5.10/x86-process-setup-io_threads-more-like-normal-user-space-threads.patch
queue-5.10/powerpc-add-support-for-tif_notify_signal.patch
queue-5.10/eventfd-provide-a-eventfd_signal_mask-helper.patch
queue-5.10/fs-provide-locked-helper-variant-of-close_fd_get_file.patch
queue-5.10/relay-fix-type-mismatch-when-allocating-memory-in-re.patch
queue-5.10/eventfd-change-int-to-__u64-in-eventfd_signal-ifndef.patch
queue-5.10/io_uring-pass-in-epoll_uring_wake-for-eventfd-signaling-and-wakeups.patch
queue-5.10/blk-mq-fix-possible-memleak-when-register-hctx-faile.patch
queue-5.10/fix-handling-of-nd-depth-on-lookup_cached-failures-in-try_to_unlazy.patch
queue-5.10/net-provide-__sys_shutdown_sock-that-takes-a-socket.patch
queue-5.10/task_work-unconditionally-run-task_work-from-get_signal.patch
queue-5.10/openrisc-add-support-for-tif_notify_signal.patch
queue-5.10/signal-add-task_sigpending-helper.patch
queue-5.10/net-remove-cmsg-restriction-from-io_uring-based-send-recvmsg-calls.patch
queue-5.10/alpha-add-support-for-tif_notify_signal.patch
queue-5.10/nios32-add-support-for-tif_notify_signal.patch
queue-5.10/ia64-don-t-call-handle_signal-unless-there-s-actually-a-signal-queued.patch
queue-5.10/task_work-remove-legacy-twa_signal-path.patch
queue-5.10/revert-proc-don-t-allow-async-path-resolution-of-proc-self-components.patch
queue-5.10/m68k-add-support-for-tif_notify_signal.patch
queue-5.10/s390-add-support-for-tif_notify_signal.patch
queue-5.10/um-add-support-for-tif_notify_signal.patch
queue-5.10/tools-headers-uapi-sync-openat2.h-with-the-kernel-sources.patch
queue-5.10/kernel-provide-create_io_thread-helper.patch
queue-5.10/iov_iter-add-helper-to-save-iov_iter-state.patch
queue-5.10/arc-unbork-5.11-bootup-fix-snafu-in-_tif_notify_signal-handling.patch
queue-5.10/arch-ensure-parisc-powerpc-handle-pf_io_worker-in-copy_thread.patch
queue-5.10/csky-add-support-for-tif_notify_signal.patch
queue-5.10/arm-add-support-for-tif_notify_signal.patch
queue-5.10/kernel-stop-masking-signals-in-create_io_thread.patch
queue-5.10/fs-expose-lookup_cached-through-openat2-resolve_cached.patch
queue-5.10/task_work-add-helper-for-more-targeted-task_work-canceling.patch
queue-5.10/nds32-add-support-for-tif_notify_signal.patch
queue-5.10/signal-kill-jobctl_task_work.patch
queue-5.10/hexagon-add-support-for-tif_notify_signal.patch
queue-5.10/sh-add-support-for-tif_notify_signal.patch
queue-5.10/riscv-add-support-for-tif_notify_signal.patch
queue-5.10/h8300-add-support-for-tif_notify_signal.patch
queue-5.10/io_uring-import-5.15-stable-io_uring.patch
queue-5.10/sparc-add-support-for-tif_notify_signal.patch
queue-5.10/blktrace-fix-output-non-blktrace-event-when-blk_clas.patch
queue-5.10/eventpoll-add-epoll_uring_wake-poll-wakeup-flag.patch
queue-5.10/parisc-add-support-for-tif_notify_signal.patch
queue-5.10/entry-add-support-for-tif_notify_signal.patch
queue-5.10/x86-wire-up-tif_notify_signal.patch
queue-5.10/task_work-use-tif_notify_signal-if-available.patch
queue-5.10/drbd-fix-an-invalid-memory-access-caused-by-incorrec.patch
queue-5.10/kernel-don-t-call-do_exit-for-pf_io_worker-threads.patch
queue-5.10/kernel-allow-fork-with-tif_notify_signal-pending.patch
queue-5.10/pata_ipx4xx_cf-fix-unsigned-comparison-with-less-tha.patch
queue-5.10/mips-add-support-for-tif_notify_signal.patch
queue-5.10/xtensa-add-support-for-tif_notify_signal.patch
queue-5.10/c6x-add-support-for-tif_notify_signal.patch
queue-5.10/microblaze-add-support-for-tif_notify_signal.patch
queue-5.10/net-add-accept-helper-not-installing-fd.patch
queue-5.10/ia64-add-support-for-tif_notify_signal.patch
queue-5.10/arm64-add-support-for-tif_notify_signal.patch
queue-5.10/arc-add-support-for-tif_notify_signal.patch
queue-5.10/revert-proc-don-t-allow-async-path-resolution-of-proc-thread-self-components.patch
queue-5.10/fs-make-do_renameat2-take-struct-filename.patch
queue-5.10/kernel-remove-checking-for-tif_notify_signal.patch
queue-5.10/arch-setup-pf_io_worker-threads-like-pf_kthread.patch
queue-5.10/nvme-pci-fix-mempool-alloc-size.patch
queue-5.10/fs-add-support-for-lookup_cached.patch
