Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256CC433EF
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:29:04 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 78FCA24863;
	Sun,  3 Jul 2022 23:29:03 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mail.librecores.org (Postfix) with ESMTPS id C54C724844
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:29:01 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id 145so7250496pga.12
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NYRJ6dFmaqbGhA+/u64I15FtwTO+theWct4FGuCTZQI=;
 b=Yn3sSs6JsQ/S16E1FcrvWmzviW6WYFWuoarDxN5g+fpHYKq1M3wJO2P1SR+OK1W0pp
 /AxoGWS+r6T8DRtjacjaPO79+D7h9h+vawnLE7PRBZcGPUC3/wdBJyCK4TQ05YAG4/tA
 THk7qfXuK6YZA/BdMMA7xOUVQBfzewytkc/BOKrCxrLBIHUjaaSTkvOcsRcxKTeH1T1U
 4Ho0jF7VLOjF/n24pLJzZ2YM5hWnJ0YQgt68fszmAKhPM/ayXBFV4dmaecP9G29hqn5j
 wIqnxrm8Id5UXUgvL8wv24nr07pFMlH51k9gsoe3O+yPArZJtj99NxjcV3O1r7mksb69
 n1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NYRJ6dFmaqbGhA+/u64I15FtwTO+theWct4FGuCTZQI=;
 b=1A16YOnjnTuBAj5E035msZl9rObzYDBrwE6O1CSPcrR0AzwYmlyU8+1IDez/fZ7T6g
 FfUAC07ixKnUcaAnEEHx1zgQdnpLU50OxvP77e0k+ZUbCJcwRm91G2sd3EVGFWdhvGye
 hq+grqIdRo7CDe9EDtPEohODqJTv2wxR2zWF+59XpEcWUIx4/BgOqTPP0gfOpa9Xtj3o
 e5w6ikb4551iOGlI5OiszUEZzKeHLQv4mLAuaB9zVu/jT/zH/AUQb8H9N1tivAsaGYnV
 Ot4bJ6bG7L0hD07vSZtlQsicJs/7APxSaiYs4uDkcWO/5qmZ8oXW79qqYJM2yEpoZa0R
 w5jw==
X-Gm-Message-State: AJIora/oDNwImfHaV/bR0NLxP9nGGyE57QFbdEsFe6q0+j1Gb4e0lnyB
 5WMsGj7zT2DB2hkq964Nd2A=
X-Google-Smtp-Source: AGRyM1vJceqSQgnXEWN0syEFDuChFifPV1ZOKz12qLoEt0ZeE1QAQkcnSjW3RxLY5ePFhd8WIgRCrg==
X-Received: by 2002:a63:1259:0:b0:411:f92b:8e6c with SMTP id
 25-20020a631259000000b00411f92b8e6cmr10172919pgs.108.1656883740350; 
 Sun, 03 Jul 2022 14:29:00 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a631106000000b004114aad90ebsm12309214pgl.49.2022.07.03.14.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:29:00 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 06/11] hw/openrisc: Initialize timer time at startup
Date: Mon,  4 Jul 2022 06:28:18 +0900
Message-Id: <20220703212823.10067-7-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220703212823.10067-1-shorne@gmail.com>
References: <20220703212823.10067-1-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The last_clk time was initialized at zero, this means when we calculate
the first delta we will calculate 0 vs current time which could cause
unnecessary hops.

Initialize last_clk to the qemu clock on initialization.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/cputimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 93268815d8..4dbba3a3d4 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -140,6 +140,7 @@ void cpu_openrisc_clock_init(OpenRISCCPU *cpu)
 
     if (or1k_timer == NULL) {
         or1k_timer = g_new0(OR1KTimerState, 1);
+        or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         vmstate_register(NULL, 0, &vmstate_or1k_timer, or1k_timer);
     }
 }
-- 
2.36.1

