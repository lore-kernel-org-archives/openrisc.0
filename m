Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD7C19F2B
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7AD7E24A79;
	Sat, 30 Jul 2022 01:06:30 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mail.librecores.org (Postfix) with ESMTPS id 3CDC024A7B
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:29 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id l193so4662660pge.9
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HXCBntOjGzm8ardshRhxv5iuyqDFWrlT1RdhJEN5akM=;
 b=jm9G1DAeu9TMKmi1nO9GRbQxTheemcGp0UMNI66bL8gsTudxEtALCru01SBxule4qT
 6LGA8aehx4PAnoH95P0lT0gKya7WMyUjAw58x1zFlEg2OTxl1u0Xf587dpwN2kEPvv8A
 f1F8xtBCKWfzRKx0TYbb1ZuDdVg1ZvQH2dVDaRLG4Ub8I9++XJiEEwJgjG8y8JZtG/Cm
 CDF4rPhKNDg9WuJCaZyXn+BoLrCrG7jCSf1X2yYig1ev4t+GKy0X39XsXf8pXSap59mu
 1pjD9Ijoa+OCe2zIn1H+wYNpq7Oys6olp+SgazhUBn5QLrIQrrRG1XWeF4naDyH1k6YH
 HGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HXCBntOjGzm8ardshRhxv5iuyqDFWrlT1RdhJEN5akM=;
 b=35vA6hNnW6/e+6cfr5sSTw2NqInaiZlUH6MT02aUA6XMIIueNwFY3fO0lqcSLOTjUb
 EJpTCICe7dLSRNSnArm2Qpb2ZQL8NgHFSBxDCTuwmFsic86wCcE10MObIBJbX+HGcP+Y
 0d/WnSSRZQhme33sfFJ3WqTcEZSaLGAFSoGtcaP9+OZ0KmjZIrfoTpUn6TWxn6Ggk3Y/
 AZ+/QT1oir5POtP2RZkoWINwFYCzkiGlx3N/eWH2WjLzGMWk+JMPHOkNQheK15KhSVcF
 wQtzNSy4GKrT6yX12iiYhPVUF3FZ/70BojpDEBGCRtsysDHTiwpGc0v77KHXAJwANmW6
 vXjg==
X-Gm-Message-State: AJIora/RwqaP9hT0ZZnpG62NYXsN5k/XlYi0O+4OnwfLzj+M2wX3JGIr
 H3nu63qoTV8iLSXldn18G0A=
X-Google-Smtp-Source: AGRyM1tPsZ8OBNfYftntOYscYnHcsScjRT0EW2bPuqVRfjYJMfSsCj8B1rRfoch4bfwWWKQkBFkTQQ==
X-Received: by 2002:a05:6a00:10ca:b0:4f7:5af4:47b6 with SMTP id
 d10-20020a056a0010ca00b004f75af447b6mr5677145pfu.6.1659135987758; 
 Fri, 29 Jul 2022 16:06:27 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 18-20020a621812000000b005251fff13dfsm3410715pfy.155.2022.07.29.16.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:27 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 06/11] hw/openrisc: Initialize timer time at startup
Date: Sat, 30 Jul 2022 08:01:12 +0900
Message-Id: <20220729230117.3768312-7-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729230117.3768312-1-shorne@gmail.com>
References: <20220729230117.3768312-1-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The last_clk time was initialized at zero, this means when we calculate
the first delta we will calculate 0 vs current time which could cause
unnecessary hops.

This patch moves timer initialization to the cpu reset.  There are two
resets registered here:

 1. Per cpu timer mask (ttmr) reset.
 2. Global cpu timer (last_clk and ttcr) reset, attached to the first
    cpu only.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - Moved timer init from init to reset suggested by Richard

 hw/openrisc/cputimer.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 93268815d8..10163b391b 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 
 #define TIMER_PERIOD 50 /* 50 ns period for 20 MHz timer */
 
@@ -122,6 +123,24 @@ static void openrisc_timer_cb(void *opaque)
     qemu_cpu_kick(CPU(cpu));
 }
 
+/* Reset the per CPU counter state. */
+static void openrisc_count_reset(void *opaque)
+{
+    OpenRISCCPU *cpu = opaque;
+
+    if (cpu->env.is_counting) {
+        cpu_openrisc_count_stop(cpu);
+    }
+    cpu->env.ttmr = 0x00000000;
+}
+
+/* Reset the global timer state. */
+static void openrisc_timer_reset(void *opaque)
+{
+    or1k_timer->ttcr = 0x00000000;
+    or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
 static const VMStateDescription vmstate_or1k_timer = {
     .name = "or1k_timer",
     .version_id = 1,
@@ -136,10 +155,11 @@ static const VMStateDescription vmstate_or1k_timer = {
 void cpu_openrisc_clock_init(OpenRISCCPU *cpu)
 {
     cpu->env.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &openrisc_timer_cb, cpu);
-    cpu->env.ttmr = 0x00000000;
 
+    qemu_register_reset(openrisc_count_reset, cpu);
     if (or1k_timer == NULL) {
         or1k_timer = g_new0(OR1KTimerState, 1);
+        qemu_register_reset(openrisc_timer_reset, cpu);
         vmstate_register(NULL, 0, &vmstate_or1k_timer, or1k_timer);
     }
 }
-- 
2.37.1

