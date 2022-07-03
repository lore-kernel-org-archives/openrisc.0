Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C960C43334
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:29:10 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7B1892489C;
	Sun,  3 Jul 2022 23:29:09 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mail.librecores.org (Postfix) with ESMTPS id 48CB324853
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:29:08 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so3222828pjf.2
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UGaGgVs7SDUPOEFRyCBkmJZ47VH/vWWzJK8XgOjQE9k=;
 b=ctTqboY1Xf6oVC3++neuaQUBMRjtQLIByHe2xH0tqQ1FYZHrUnmNjtJ735BhtMYqtY
 Ix0zUQ7nZUc9yLDIUezELW42tqZucAgTYr6ReKHpJRZwGDJJUWqcA2um9edmcvIwFixf
 lCQozyIvH17Z0jJqv2iIyECWbcbhBOi54m/dY7Oeu1c14UL7tbIEAk69KVvx2+ZACd5x
 jHO5l77I0Tmj5yQ/ShQ+x9IoiBkWNO54kZnYSPFco8iiTXVwW2jLO18oMZoTQMirNcsL
 MqumlN/5RNHu4kgN7FLkv9dtBoB+T2BZ0Ze6d+t4gEImElq6z4vAxzj+7P0SU7Yad4Pt
 9YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UGaGgVs7SDUPOEFRyCBkmJZ47VH/vWWzJK8XgOjQE9k=;
 b=OYvJDHgp4P+rJnpsCi+Lz0v/cX5LP1LwqiuH3QdZIkI3Z0uvJlYdGNq1J8TcdCNyG8
 CGtkkCVH9/spM+PtzFNG5/i0vvWRvd1y5KhTMu8XfW/A31dipWhkAUaMCetMNMEvAmIY
 nHKO3QejXYgIKMJtlfK3MtzxVo8JscygY/j4qfqyolGwUC0+syEtFvMdfkTDVWpcfXiD
 PqlKvlFFMqu3SSs1npoLT43mLhTZzrs4GP8yjuklmoLz6w7ju8UeBVkpI/K2BGBpG8kQ
 gtqdVKPQNJWvXr7jwFNi7qEjuxWc6MU0rMCoCmqUmFtXgza8nOwJAsNgn0i4kCLPcTbr
 bDCg==
X-Gm-Message-State: AJIora/nHl5uJS9eHAngHH0vzKklGTZc0Kmn/IaJWRT1qQZVT5leWoMy
 HF2XYuFY7Ji/8rEAJBVe9W0Ms/sCNmI=
X-Google-Smtp-Source: AGRyM1uWwxP6+pJEjL03lCTGaAyQfxiR4HCd+D9DjMGtguEA5eN1a8oWQU/Qlr1EqfUoT+PWa2Y7BQ==
X-Received: by 2002:a17:90b:4c0a:b0:1ec:d3b2:ed22 with SMTP id
 na10-20020a17090b4c0a00b001ecd3b2ed22mr31426586pjb.2.1656883746947; 
 Sun, 03 Jul 2022 14:29:06 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 63-20020a620542000000b0051be7ecd733sm20009136pff.16.2022.07.03.14.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:29:06 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 09/11] target/openrisc: Interrupt handling fixes
Date: Mon,  4 Jul 2022 06:28:21 +0900
Message-Id: <20220703212823.10067-10-shorne@gmail.com>
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
index 7c0d3d6187..5336110b5e 100644
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
2.36.1

