Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1318C433FE
	for <openrisc@archiver.kernel.org>; Wed,  2 Nov 2022 18:34:29 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A8E2E24C68;
	Wed,  2 Nov 2022 19:34:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 6F60124C42
 for <openrisc@lists.librecores.org>; Wed,  2 Nov 2022 19:34:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667414066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPxNJZ59dAj9Aw/rnn/vqSwo8b8sDM1O6Xi76OwhNZs=;
 b=Fe71/qi6ynieum+6CED0InQm406/v4yXSAzYo77+vPxSWtmHhgXkkS1zsoSVjZmE5xMuLQ
 jDaQRqrZq+bu9wzNN13KxiPVqc/DdQP6o+aNltlP+srcOMw12wtmHGJmB/lXu3GE0D6/Wv
 PaK3mSES+/gU9o2HPY4J6haSkcMA1Lc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-282-wq1lTWstPR-nZKjNmCq5AA-1; Wed, 02 Nov 2022 14:34:25 -0400
X-MC-Unique: wq1lTWstPR-nZKjNmCq5AA-1
Received: by mail-qv1-f72.google.com with SMTP id
 ln3-20020a0562145a8300b004b8c29a7d50so10462494qvb.15
 for <openrisc@lists.librecores.org>; Wed, 02 Nov 2022 11:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPxNJZ59dAj9Aw/rnn/vqSwo8b8sDM1O6Xi76OwhNZs=;
 b=WNwbkZwMhFLPhncEAZdAnV/kgdDqQlwbmgmd0M7PV8CwgzG50VatBCV931n4mtZykM
 3M3xZJjv40iY3V6QBAFrAEzT4BGgjSzuLMsopb26aF3gYBatOWaukF68pIUw2FgXikRx
 3wugQnBvfB5Nfqjr7SEHYUCvtNILqAPss1ln/CDAJyzIvoBxPVwG1IE5e4/fhi5RsWEU
 gwctQbxxz5ns8ftDcDfJ64gk5B8g8tquAdLuCfhDO1GiUvuVs3PaZOHuLfj5BF50RZ9t
 K5s2kJ9Y3u0Y+qzJkHK3A2pm2tGFXCVLcyn1VI5RYH/rI4/D2Uoi9uf99hcn8/aqeWeM
 7/7w==
X-Gm-Message-State: ACrzQf2kRop3FiRoEYbZyREMCF+UAxE7A1or0KeYVDXknrOYHK28NcSC
 sxQVA+66OPgafldU39VZMNocAM8QZEbeoNfUeOItzB9YXkDKLGq92A22srqPc0iL1WxA0lwspQL
 NCnT8ayKQL1XA1rFE8f8f43x7OQ==
X-Received: by 2002:a37:92c6:0:b0:6fa:28b2:1e2a with SMTP id
 u189-20020a3792c6000000b006fa28b21e2amr13574175qkd.9.1667414064976; 
 Wed, 02 Nov 2022 11:34:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4EXOUjNlIxUYR8PDvF9w7H8/QWuUsvimzUEYEqnOFqRnuqhuZtDCzI4Vu/740apEttSzlakQ==
X-Received: by 2002:a37:92c6:0:b0:6fa:28b2:1e2a with SMTP id
 u189-20020a3792c6000000b006fa28b21e2amr13574163qkd.9.1667414064758; 
 Wed, 02 Nov 2022 11:34:24 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
 by smtp.gmail.com with ESMTPSA id
 w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 11:34:23 -0700 (PDT)
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
Subject: [RFC PATCH v2 5/8] irq_work: Trace self-IPIs sent via
 arch_irq_work_raise()
Date: Wed,  2 Nov 2022 18:33:33 +0000
Message-Id: <20221102183336.3120536-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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

IPIs sent to remove CPUs via irq_work_queue_on() are now covered by
trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
self-IPIs.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/irq_work.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc43..aec38c294ce68 100644
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
@@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static inline void irq_work_raise(struct irq_work *work)
+{
+	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt())
+		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
+				       _RET_IP_,
+				       work->func);
+
+	arch_irq_work_raise();
+}
+
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
@@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 
 	/* If the work is "lazy", handle it from next tick if any */
 	if (!lazy_work || tick_nohz_tick_stopped())
-		arch_irq_work_raise();
+		irq_work_raise(work);
 }
 
 /* Enqueue the irq work @work on the current CPU */
-- 
2.31.1

