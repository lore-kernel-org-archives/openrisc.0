Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B1C6FA86
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:20 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 5A48624B28;
	Sun,  4 Sep 2022 09:26:19 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mail.librecores.org (Postfix) with ESMTPS id 410D1248EF
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:18 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 ay39-20020a05600c1e2700b003a5503a80cfso4051440wmb.2
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=0FTDZ6g8QqQ2hyeBebMAc1epUTGYlrXgHLi8o6Y8evU=;
 b=ACCRbBV2KKKjfydEg6LUcCU0es7lB8dYhBWxXEGOlXiRykGYTZ/6esdDO34qyMIzCo
 utGzyWVMt9x2H9GOC/f8VoSAxpeyhn1slcsg98ScOj5czeBkGx71CSYWKOZyZHCis4rQ
 Lv0L5mxd/+vebVqnv5YyIL6O5sSgdOKFNpuizZkMShS7n6lS2Etz2ZrDXwFM8fkftVZy
 OzGFtocsDd7/Tnedu/QsPsjwNu8ZBHCG528tp9P1+/1ie2M9zY1IMmYBbMUrMvngOYtd
 qTmAxaf/ZO4+e4YFwpsO+NCqevu2F2mgsyOE7GaVHNKbyc52hu3E3mFNsNHe9+8+xB8M
 Hdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=0FTDZ6g8QqQ2hyeBebMAc1epUTGYlrXgHLi8o6Y8evU=;
 b=vJQQwjarGGzQGzgfvk78YSv87N1YNjo++ndG1LewrppweISZAN0uQfcT5fbLBO4W9K
 DTPZYVDlhcgOcltinnnpNE/XtYcVtKTXk1QHd8n9tlFCI0GEaw5rVGNAfKcPdbOFsJ8O
 +aC5+HdxQLQIhWI1E80T5MTX4aSuy9Uhzs1UoFcwKjXmSvkyUaNChC2ZyIuEfde3A6ck
 vkX4bU20hUAzcbRz7B3B3wrEYho8OuMRQZ9yjv7yoCc5/E9tHv6b9g/uSZRRiZ59itFS
 UiAArKyuf966eWqmIGbDZKebns5usi65MFH6URl1Cun2yHwFBYLEZ2Thh3v6m5fYb00z
 W2Iw==
X-Gm-Message-State: ACgBeo1nXyFkaVhTfngj0T+8y5APcvNHTbtPdKr0ndIjDeVrwROOKXGf
 KQbkquuomSVfe0qWf42/ZPc=
X-Google-Smtp-Source: AA6agR4/odvqz8fgpEcUbXKX2KPBkvGhyhxoNF+wKO8Jku9wSHkT7Y+oP7ro357mEQP+Q5nXWlszMQ==
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id
 c14-20020a05600c0ace00b003a5b495854dmr7535789wmr.86.1662276377948; 
 Sun, 04 Sep 2022 00:26:17 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 x13-20020a1c7c0d000000b003a5ca627333sm12968576wmc.8.2022.09.04.00.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:17 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] hw/openrisc: Initialize timer time at startup
Date: Sun,  4 Sep 2022 08:26:02 +0100
Message-Id: <20220904072607.44275-7-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904072607.44275-1-shorne@gmail.com>
References: <20220904072607.44275-1-shorne@gmail.com>
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
Cc: openrisc@lists.librecores.org,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
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
2.37.2

