Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9621C43217
	for <openrisc@archiver.kernel.org>; Sat,  8 Oct 2022 05:01:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 173D02486D;
	Sat,  8 Oct 2022 07:01:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id B3AEB24ADE
 for <openrisc@lists.librecores.org>; Fri,  7 Oct 2022 17:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665157567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4Pqcbma7I8CmezCzayfM2Dc1cTkJUS9uBKY5V7UMK0=;
 b=RL2Pcpvp8Jbj4A3E6xi3otXpv47pIDqKG7YHs7kpniz2qhwUOw5d/bXpoNiG8gM7x8fZ4y
 WIHQ1qvsDDYr0/5ZEDysVG85w+98zkmHvGrhph8Si9DBKAA0kiyqcEYo6qqpyn4Jy0NYC/
 pNIydvy0/DjLQWS8f1XnCVSPMp4DUHY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-nTAMJiq8MwiLflqih0WP9Q-1; Fri, 07 Oct 2022 11:46:04 -0400
X-MC-Unique: nTAMJiq8MwiLflqih0WP9Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 v125-20020a1cac83000000b003bd44dc5242so4526278wme.7
 for <openrisc@lists.librecores.org>; Fri, 07 Oct 2022 08:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4Pqcbma7I8CmezCzayfM2Dc1cTkJUS9uBKY5V7UMK0=;
 b=QsExMtj6O4ayusBxz1GDVAENf34x/oMKWto4EhOUVXwrBd8AN/NDXaO3FHWspzebKj
 FOiounUOx+YQblnYFTZWD+NFv+B0N+adg5alPPRW7ZNY95SxwcTdhUouUcn76LaRzXG7
 e0qYjZfD1ifvX5/P8KlxKH0KJs0LUVHyyhqGRhdZCKLtQuH/1jBirwLImBzU/cIfPLX9
 hQai5sNGfo+X2BZC7g6ftfcswEjBzGo2eY/WG+Bg30+i0iYZs0JSs5SrmwTRLnCmVqXY
 aJc/6zcEcJArHo7C5qVbtg3UffbFRG5Ihp8n6XLdiE2bmPfYhZbPPKKn9QOj8dTYwtXT
 /n7w==
X-Gm-Message-State: ACrzQf3VvQdx+oE7reC56GD9zlOZLYg8vyX0vy2+f+VRhhI/IOOXPDcN
 8Vrfi46+xxo1TaaznUE4NMig71iuKAiVahWKTlT7PNzRUqfAUUHn2SPVKAQ3EV4FEKNCJuAImCL
 PbMyI6MatRHUjajZ4S3wQ6Oc9tw==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id
 w12-20020a05600c474c00b003b4cbca5677mr3615504wmo.76.1665157563635; 
 Fri, 07 Oct 2022 08:46:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5BU2FP8ts0HH9McA8hGqt4EcEkhUio8tUw5hjcE8rRRaWGVB+HCzlKu55T50nu8VVd2MVS1w==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id
 w12-20020a05600c474c00b003b4cbca5677mr3615475wmo.76.1665157563388; 
 Fri, 07 Oct 2022 08:46:03 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 08:46:01 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] smp: Add a multi-CPU variant to
 send_call_function_single_ipi()
Date: Fri,  7 Oct 2022 16:45:31 +0100
Message-Id: <20221007154533.1878285-3-vschneid@redhat.com>
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

This simply wraps around the arch function and prepends it with a
tracepoint, bringing parity with send_call_function_single_ipi().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7a7a22d69972..387735180aed 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -160,6 +160,12 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+static inline void send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	trace_ipi_send_cpumask(_RET_IP_, mask);
+	arch_send_call_function_ipi_mask(mask);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
@@ -970,7 +976,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (nr_cpus == 1)
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
-- 
2.31.1

