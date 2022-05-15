Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09FC433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8530A24808;
	Sun, 15 May 2022 14:42:43 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mail.librecores.org (Postfix) with ESMTPS id 71F7E20D0C
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:42 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id x12so11688470pgj.7
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
 b=HnBtgyglcpAF47QDC7sGEQOlZ8dA2kdM7Qk0V0OskPV+UUv2/Fg0VNfgf/3BP67ae+
 EWEvu4jP9ZYPFJU1Jl+KsBypKmSHGBT2LbO3zFpUG3sUQMl8Pen4x3klqlH0lkpX7CIZ
 2QZhW569rFu2lUyA/d6tuBXR7dc3pNrTuLXxqpq+bh2xDns6v0/abZpuEnLnxw5ztYy2
 oOByW3u1YuNsxat9rJzzWc0WJwNW2mWI1UcpkqpR2sAZVCUjFYfXoTZLMY06brZlH7yO
 WpSultNnn/SOkiYM04ODjT6uK9n+oQJpB+TuedLmW3/ohjD8K4r8y0MZnQhm9l1WPvZW
 34MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
 b=VkuFrwwBrF8kTkBBeWpr1MSotn/GeRl0LX66pcRn0IIV64qOkIfhM9vo2ehI9GX3um
 BE94AL/L2d8/PtJkoFtwqt35iiXMV16W+HMUfgRBWAqLwXqXFLxdJUXhJISDouI9NgD7
 Y9G/dg/lbN5gyns/KvcJ+PTmxKtGA7TqfoJHUP+ucQ1bNNlCPSa7qER7qzNefPTuhg2E
 8k/hnpR0b9PSCJvz10nsgBAHcPHMmyjYzVFeBTTcnMOjlh6TVA3fCgdTwL2cXo1x+4Xg
 RDV4rIVCDz4s+vK1P7DqJfULhLTsAlm7hgL+kZlU0nbYk7t3ZpYbLH1AXlnElBfgWjk6
 Ra5A==
X-Gm-Message-State: AOAM532vBh1pgI+07rdhh//kU6c6uQz82wIm+uSg8ijMPSnbuIx8dDgt
 KnW7UyTm6H96/Fr8/WfAlHM=
X-Google-Smtp-Source: ABdhPJzqvncFRUIuRAfj62LKQruwUlpe0XsMKkrLRlM+M8DkM4ubr+ddMYmcks46kDiHJU3mIwGNFQ==
X-Received: by 2002:a63:491f:0:b0:3f2:6b20:fa10 with SMTP id
 w31-20020a63491f000000b003f26b20fa10mr1000385pga.531.1652618561911; 
 Sun, 15 May 2022 05:42:41 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a637b41000000b003dafe6e72ffsm4844337pgn.88.2022.05.15.05.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:41 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/13] openrisc/time: Fix symbol scope warnings
Date: Sun, 15 May 2022 21:41:55 +0900
Message-Id: <20220515124158.3167452-11-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

