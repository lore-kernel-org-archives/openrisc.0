Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D5C6FA82
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3694424B3D;
	Sun,  4 Sep 2022 09:26:23 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mail.librecores.org (Postfix) with ESMTPS id CCD07248EF
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:21 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id f15so2725469wrw.3
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=EldJkEoNWNKZAj6IpvRwW2ZX0M3V6N6F5zvDJDJ3mZY=;
 b=PdLyKLzb6yg9uR8kKG0lYQ/IP9CsySxu4NqgeGLrW9xViJQxdWqKF4dQf2K7XJUT0S
 AYSnkRW6GPUeWAYW+Tti9Z/IC6RYiHl3iFovZE6sDkbrJKyyBWLxKj+Az5gjilaG/c6l
 WV8bOMB7FrzMHv/bc6A5QtRn+G/XTSeo4dbChWVIHqU7V8uEICy9WcOkvy9qO7MaWqUG
 Yets3kAXIDShuxDnktsd59KOxeWBdlgqOjv3Q+e0RKPlpP7DMwum7p3ef4uXlc3XIlQr
 SxDIuqu3qKokftb4Xv6jLxkE88peM0ehHSsTdm+67geNzS+UyNa61kN4Cqt1h87EeWaD
 NwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=EldJkEoNWNKZAj6IpvRwW2ZX0M3V6N6F5zvDJDJ3mZY=;
 b=B+tA89/sACRlYUqO0R1BBhZs+lmpbnMUpIVSJGIRkAPlifb6Mcr/hp0vBblGlthGNP
 0EnscEf2X3moQ0lgiCvwNTiP2+L4wXKt4DdLLQn6BFL0p1qAfMM4ZLNccRCiC0uIXa0h
 fAEpiqfznsVXMWT4sPZF/BNHBnVVvUo/7o+ks4dIURVUE0gRq1hokNgSAysfeuq8Ek5q
 /4Fq15hSX9OIOOFM0gDQFXTqgwUmY6c2pHGw3i1WeBoPUPao8ntQ1/F8alSOWUMTQVp3
 8d9Hl92jWnMWHZw7bMqkV8RYqrSFvbOzXgmZnI1DU1C8pCpccKTfVuMl2lgxeBCxQP1U
 kP0w==
X-Gm-Message-State: ACgBeo3qOSH8adRzinlHhRkwsLVhxiL/e4ydCNnckNDSaF7N1HZETJaA
 dL1zXbxItCrdKSnKVQMGbGJ60hNTANo=
X-Google-Smtp-Source: AA6agR7EC4yeXNSw3pKolUGD1oWZpkkEG3mSODFWoPr1LpNL1iuCRX1eaFF07ZyyOk/GcZKg7Ljdhg==
X-Received: by 2002:a5d:5047:0:b0:226:eb0a:d2d5 with SMTP id
 h7-20020a5d5047000000b00226eb0ad2d5mr11567968wrt.558.1662276381441; 
 Sun, 04 Sep 2022 00:26:21 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 r9-20020adff709000000b0022862fd933asm2016809wrp.96.2022.09.04.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:21 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] target/openrisc: Interrupt handling fixes
Date: Sun,  4 Sep 2022 08:26:05 +0100
Message-Id: <20220904072607.44275-10-shorne@gmail.com>
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

When running SMP systems we sometimes were seeing lockups where
IPI interrupts were being raised by never handled.

This looks to be caused by 2 issues in the openrisc interrupt handling
logic.

 1. After clearing an interrupt the openrisc_cpu_set_irq handler will
    always clear PICSR.  This is not correct as masked interrupts
    should still be visible in PICSR.
 2. After setting PICMR (mask register) and exposed interrupts should
    cause an interrupt to be raised.  This was not being done so add it.

This patch fixes both issues.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c        | 1 -
 target/openrisc/sys_helper.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 41d1b2a24a..cb9f35f408 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -98,7 +98,6 @@ static void openrisc_cpu_set_irq(void *opaque, int irq, int level)
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        cpu->env.picsr = 0;
     }
 }
 #endif
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index da88ad9e77..09b3c97d7c 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -139,6 +139,13 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         break;
     case TO_SPR(9, 0):  /* PICMR */
         env->picmr = rb;
+        qemu_mutex_lock_iothread();
+        if (env->picsr & env->picmr) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+        qemu_mutex_unlock_iothread();
         break;
     case TO_SPR(9, 2):  /* PICSR */
         env->picsr &= ~rb;
-- 
2.37.2

