Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBDC433EF
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:56:02 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id BF5312497A;
	Tue, 17 May 2022 02:56:01 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mail.librecores.org (Postfix) with ESMTPS id 3F4FF24981
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:56:00 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id i1so16000082plg.7
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
 b=H5MdmlFKJmCnyxJIjM/qpwTxPaW0iw9pGgyPhqb86vIvFdIh9MsqnbGRdbo3jl3DD1
 NZN0aiW77lj3kr3NKdkj4BPOdHAU/UPyX/6yZIrzwOxS54MnqkBsCqlB9WP06jWpjRKH
 m72bcJwu6Ybfqm+nkmSy/X7omkA497/BL3qqkBDNks8sOGs5dx4iXkYFEcNLrjByTLJo
 QLuP6rY2ypxJZSFaiaqB4i7xxnDSVXrNwXFBd++H697yAHCrtvVNnax0Mo0KofZm06co
 4k7PzeBN94R4jk21clzsMW07xHsrjYvmkSSiFrwl5uSuGe6TzUsJPulniHg1JJ9LPoQ3
 YyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
 b=odfrUhXCLsYuCjn3CC+glD69eKwrsQoXyt/DXXGfah8fubfPWxg+bIj2jIFJGGTTq6
 jP9habmYay+BQvyZke/7r+qePXppwHQZ8oWM3btc3cYCyP0C9nCr70WSPlMDrhxXNcOz
 MonVToMUAMP6Uf1YfmVUjTB+h6nai6sdgbBC7kqOdPyEXIq+A2EjkUMg0gutMg5DYwMY
 AcLGMY/8+xnahwMXAgLwZvXVfY+CbdI5aacRpfzKH0a7zv0ALMLK2fXqdSEB15WsNfiS
 yS2RGXbmwMYkp69X7Y/xEWxkuLQT6aDbBH4h21DhbKU7uBkmuRF89W+ZlhlmtSJPgxHU
 VPkg==
X-Gm-Message-State: AOAM532vmY1h2/FMdomzvWS9s3n+b9xGY2Sw056a/4MtbKKxen8MQmRw
 C6H7OHb9Y6z3AW8KsxY8ocs=
X-Google-Smtp-Source: ABdhPJyuJHialPFzmk9jCitdBmrkLR09Y4G9IMW9rKIhLzuMTvlJo4x/V3N31o577AIjRUWU+WBkgg==
X-Received: by 2002:a17:902:db07:b0:15e:b669:42a2 with SMTP id
 m7-20020a170902db0700b0015eb66942a2mr19595241plx.80.1652748958849; 
 Mon, 16 May 2022 17:55:58 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a170903020200b0015e8d4eb29asm7582806plh.228.2022.05.16.17.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:58 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/13] openrisc/time: Fix symbol scope warnings
Date: Tue, 17 May 2022 09:55:07 +0900
Message-Id: <20220517005510.3500105-11-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Randy Dunlap <rdunlap@infradead.org>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Spare reported the following warnings:
    arch/openrisc/kernel/time.c:64:1: warning: symbol 'clockevent_openrisc_timer' was not declared. Should it be static?
    arch/openrisc/kernel/time.c:66:6: warning: symbol 'openrisc_clockevent_init' was not declared. Should it be static?

This patch fixes by:

 - Add static declaration to clockevent_openrisc_timer as it's used only in
   this file.
 - Add include for asm/time.h for openrisc_clockevent_init declaration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index 6d18989d63d0..8e26c1af5441 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -23,6 +23,7 @@
 #include <linux/of_clk.h>
 
 #include <asm/cpuinfo.h>
+#include <asm/time.h>
 
 /* Test the timer ticks to count, used in sync routine */
 inline void openrisc_timer_set(unsigned long count)
@@ -61,7 +62,7 @@ static int openrisc_timer_set_next_event(unsigned long delta,
  * timers) we cannot enable the PERIODIC feature.  The tick timer can run using
  * one-shot events, so no problem.
  */
-DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
+static DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
 
 void openrisc_clockevent_init(void)
 {
-- 
2.31.1

