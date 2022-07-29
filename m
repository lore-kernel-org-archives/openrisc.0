Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C73C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 110A824A7C;
	Sat, 30 Jul 2022 01:06:39 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mail.librecores.org (Postfix) with ESMTPS id B108624A7B
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:36 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id b9so5804392pfp.10
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TlVFILlYi0pdD31MJQKEWmRWeQlW2WXHnVn9NT9MijI=;
 b=Rw5d5PDARjD8Y4K/aF0raM2kiFzKD6LizbPe8HQ87YdHnfZ1J4GaI0cYXI3wsSpWFf
 nq5xVUMZQb9exaKYTdm7BPQm8KwbD5fc5xY4pkKWS/feUsY5O+bYUBkoh3KlzKCV97fr
 6gCCzPsv/O8sQlr35YPcD3Kxogi2loqqWZnQfNNgy6ZnMWeFIj/cYKe76AQim+trElDZ
 ubNzwNzWPdeGupuy3VdIskfhWkUcAw3iqfADLVq2in9cG2xYKRtglVRAaeEjgyTYU1BR
 MRd6u6TVazFuTNvdiKBVRcYRqiST4Y1aBjE25+wS6IhyQBw8AF75y2KXpO3gWEWZ5BAi
 P+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TlVFILlYi0pdD31MJQKEWmRWeQlW2WXHnVn9NT9MijI=;
 b=ATv8nAIV8rpu5fabcpU3CYIUTDMLzUaxXu8P0hgfnY6Ht+IgyIuvfb57qLqt2oE3mz
 WPXa76XbGKAK2dM78FdrszGsrtj2Z2wv9yKaiCC6gnBm4+ufm2f0jrpoBwE7wkXExoLU
 7gvcbRFRDiiQVtV9se7PiMud7YoTxXE3V9s3ppJz9316eiMRddzFHMxLviC/rRYFRZ70
 Gl0V8rfm8eBpCqP94vqn5d2digCEX8G1fVtYQYkNZ0StOfHNUBaWW67ciWWJt3AeyIzg
 5YFPhZz8u6znku6fy+yp+nyuCkdEkWLTI2Wtm7t4C+fFMCJX8E6ZH0NMfI8QNObrPgZP
 2NoQ==
X-Gm-Message-State: ACgBeo2KlSjX70G8cc5n4m/GLepEnPvVvvvK6SOrfbwSw+CrcKa/stvR
 oWWcZ9rc/j0wcdUwzlgs6Y0xKLxgPI7R1Q==
X-Google-Smtp-Source: AA6agR57g/r2FRojc1uHJGjaNttIjV8/+q9a0izc4ATW+DrCgi9fFfkvHaigIk9M4mF/9Z1g9eJWzQ==
X-Received: by 2002:a62:ed0f:0:b0:52c:e8c2:b29e with SMTP id
 u15-20020a62ed0f000000b0052ce8c2b29emr2536029pfh.42.1659135995209; 
 Fri, 29 Jul 2022 16:06:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 x185-20020a6263c2000000b00528c066678csm3419977pfb.72.2022.07.29.16.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:34 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 09/11] target/openrisc: Interrupt handling fixes
Date: Sat, 30 Jul 2022 08:01:15 +0900
Message-Id: <20220729230117.3768312-10-shorne@gmail.com>
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
Since v2:
 - Added Reviewed-by

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
2.37.1

