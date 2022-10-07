Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87171C4332F
	for <openrisc@archiver.kernel.org>; Sat,  8 Oct 2022 05:01:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 754E8248EF;
	Sat,  8 Oct 2022 07:01:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 5DA6C24B27
 for <openrisc@lists.librecores.org>; Fri,  7 Oct 2022 17:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665157556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMgaXogbXPhOabUcxt7UADYdICMU0udr545Ze04p+j4=;
 b=JLKCLgP01KrpZnpdQTyLB+vQBvObhVF+1bTIkpjtJsHK4AbD3/AJ25iW93ClmJ0iBWwN1O
 KycWJyaYmtoStwJY/dqAmPEHxb5G+M31gaUfcMzyTYM3nDc4AHl5yt6uUH+C7LslcXHg5Q
 Q3izfD3tb4+8q5tULBFCDtKV5aU9tAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-2ctj2GMKP7-q0SE9ILUxmw-1; Fri, 07 Oct 2022 11:45:53 -0400
X-MC-Unique: 2ctj2GMKP7-q0SE9ILUxmw-1
Received: by mail-wm1-f69.google.com with SMTP id
 o18-20020a05600c339200b003bf24961658so2845485wmp.6
 for <openrisc@lists.librecores.org>; Fri, 07 Oct 2022 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMgaXogbXPhOabUcxt7UADYdICMU0udr545Ze04p+j4=;
 b=oDsc5tDVsCGgQusG7UAGiOln35TMvqwtXRwzPiX45qwCakuJL735l0H/8VgI3bVEMw
 dMWtcMnHWqZy7A6OV6bhz+PCGlXckTQdsFh6Yar9oJ5RDnVJ1g6NYAUbenbzms8SNYkd
 Aja9mDqHH35PfK+a1dggN415jOU4Zy0JaHbBc3CLyXjAqlnZIAYETOCKa2yuTNqdFrW7
 SAhowVmwddnHhEYg21yAOJ/2U9O6lMPcXBHFao+Y8uWw5Pyf64ejIq7PBpTAuo1ZdWct
 ZuVEKEpIFbPqGAFRXwTpyEilYy32L91wyGUMYMEBry+cO4LNSKC8Vfpc0nhA7ti0ujtS
 z0Tg==
X-Gm-Message-State: ACrzQf1OoMJFtta6aRy9Xp9XP0rBh7pHBNYncwUDD+Wb5sPlCAqQ/6R/
 U7G2ah5fdWK3UfroKYoYuX7iF/tf1BxmpwaZizxXuNFiB5VRQJjbKDKyx+rWACwWSsO+wXfp9MA
 SMQKyDVcuzJKS+7zIPbpKP742RQ==
X-Received: by 2002:a05:600c:458d:b0:3c3:bf4e:5c60 with SMTP id
 r13-20020a05600c458d00b003c3bf4e5c60mr1331376wmo.189.1665157552449; 
 Fri, 07 Oct 2022 08:45:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53pm8pDMF8tAvcpsQYCd9DEpAeQROExvsQCCHMjVMrngwHmXq+ii3h5Ne2OaugbAyINh7v6Q==
X-Received: by 2002:a05:600c:458d:b0:3c3:bf4e:5c60 with SMTP id
 r13-20020a05600c458d00b003c3bf4e5c60mr1331352wmo.189.1665157552172; 
 Fri, 07 Oct 2022 08:45:52 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 08:45:51 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] trace: Add trace_ipi_send_{cpu, cpumask}
Date: Fri,  7 Oct 2022 16:45:29 +0100
Message-Id: <20221007154533.1878285-1-vschneid@redhat.com>
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

trace_ipi_raise is unsuitable for generically tracing IPI sources; add a
variant of it that takes a callsite and a CPU. Define a macro helper for
handling IPIs sent to multiple CPUs.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/trace/events/ipi.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index 0be71dad6ec0..fd2f2aeb36fe 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -35,6 +35,33 @@ TRACE_EVENT(ipi_raise,
 	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
 );
 
+TRACE_EVENT(ipi_send_cpu,
+
+	TP_PROTO(unsigned long callsite, unsigned int cpu),
+
+	TP_ARGS(callsite, cpu),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, callsite)
+		__field(unsigned int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->callsite = callsite;
+		__entry->cpu      = cpu;
+	),
+
+	TP_printk("callsite=%pS target_cpu=%d", (void *)__entry->callsite, __entry->cpu)
+);
+
+#define trace_ipi_send_cpumask(callsite, mask) do {		\
+	if (static_key_false(&__tracepoint_ipi_send_cpu.key)) { \
+		int cpu;					\
+		for_each_cpu(cpu, mask)				\
+			trace_ipi_send_cpu(callsite, cpu);	\
+	}							\
+} while (0)
+
 DECLARE_EVENT_CLASS(ipi_handler,
 
 	TP_PROTO(const char *reason),
-- 
2.31.1

