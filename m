Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9EEC43219
	for <openrisc@archiver.kernel.org>; Sat,  8 Oct 2022 05:01:10 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A096B248E6;
	Sat,  8 Oct 2022 07:01:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 8D80824B2C
 for <openrisc@lists.librecores.org>; Fri,  7 Oct 2022 17:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665157572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8NlfJJNnBH1Hg+bNlEeNOaLSp643edXbrFkYOuHdj0=;
 b=Q5Wuzts8P2zjR2zDG3CTNYsVoV45LIFhIftsET9WVpF+odRSBxlkZzVBp8eykyFYQ4k8Hf
 EBK/2eRV83JPvjDrT/5N8NkRdD6LlyLC4qUERl70IrdfhfYIResenak4NQseXtLegOiWmQ
 vQkrWBFPbru4NVYua3bFreAC0BLhAL4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-tA9oYxNhOiWoF1rnbtSggQ-1; Fri, 07 Oct 2022 11:46:09 -0400
X-MC-Unique: tA9oYxNhOiWoF1rnbtSggQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 h17-20020adfaa91000000b0022e9f2245c8so686467wrc.19
 for <openrisc@lists.librecores.org>; Fri, 07 Oct 2022 08:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8NlfJJNnBH1Hg+bNlEeNOaLSp643edXbrFkYOuHdj0=;
 b=4WXvdamCPme5PMJjeOtHx6gnFEiUT25WsLMeUNi/gWuyqnUMJQ54rvUmrsG+xi7ce8
 bRu5Rz0XEg4tf3QPtoYy9aKQOAih7S6pKKMwZNPAbaVuGSwWicWb4/YWI1sCj3pspFf4
 li0VsHvaI9GlkSeQE0l7VyPT/Dk2o/oXn8W/UyT0OPnP1uBr+jlxGWKbSbqdCTxu6hzT
 5+bNzgMeUIwpzEV5n9zrQtUzUNpt+LYql+dVNxDj56PgM6KqX9lgSa3SivFkY/epCK2l
 JTgXM3rVJgJu/atIRWiQmlEXr3S5W/5NWoJdJRYJewSwIPa2LZa2ksbTnEOlCBotfgjA
 gHSw==
X-Gm-Message-State: ACrzQf36r8YDmHYI+WPaFebKLArgYQSqcOAY42pZmq8OOeqFje5wsZ8Z
 W3u0uh4jeJ2/LanAUJIDp2uTciaDdS3EqCsehj62hsBT3nlygG8GpygrIYOWykZPssM5sDP3A7k
 tXUPKvg7PcRoKDkYzY+qa8iNQTg==
X-Received: by 2002:a5d:64cd:0:b0:22e:2fc1:9511 with SMTP id
 f13-20020a5d64cd000000b0022e2fc19511mr3566252wri.415.1665157568142; 
 Fri, 07 Oct 2022 08:46:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4t9ram8oou3fr6TpdC1R8We+758fvnnqCUt2NCTCIakvPHOGi5POwCK/ARZj0LE9PFnGcXMg==
X-Received: by 2002:a5d:64cd:0:b0:22e:2fc1:9511 with SMTP id
 f13-20020a5d64cd000000b0022e2fc19511mr3566217wri.415.1665157567961; 
 Fri, 07 Oct 2022 08:46:07 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 08:46:06 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, x86@kernel.org
Subject: [RFC PATCH 4/5] irq_work: Trace calls to arch_irq_work_raise()
Date: Fri,  7 Oct 2022 16:45:32 +0100
Message-Id: <20221007154533.1878285-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221007154145.1877054-1-vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 08 Oct 2022 07:01:05 +0200
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Adding a tracepoint to send_call_function_single_ipi() covers
irq_work_queue_on() when the CPU isn't the local one - add a tracepoint to
irq_work_raise() to cover the other cases.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/irq_work.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..5a550b681878 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -22,6 +22,8 @@
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
+#include <trace/events/ipi.h>
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
@@ -74,6 +76,14 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static inline void irq_work_raise(void)
+{
+	if (arch_irq_work_has_interrupt())
+		trace_ipi_send_cpu(_RET_IP_, smp_processor_id());
+
+	arch_irq_work_raise();
+}
+
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
@@ -99,7 +109,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 
 	/* If the work is "lazy", handle it from next tick if any */
 	if (!lazy_work || tick_nohz_tick_stopped())
-		arch_irq_work_raise();
+		irq_work_raise();
 }
 
 /* Enqueue the irq work @work on the current CPU */
-- 
2.31.1

