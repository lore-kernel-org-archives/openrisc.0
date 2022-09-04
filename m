Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0693ECAAD3
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0FF1624B3E;
	Sun,  4 Sep 2022 09:26:23 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mail.librecores.org (Postfix) with ESMTPS id C0D7824B40
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:20 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 h204-20020a1c21d5000000b003a5b467c3abso6076240wmh.5
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=GIDTjvgN2dQLUduv7RxatH83G3BsgCWMQ2FcB7REqfs=;
 b=htw0ZOd24uJ5W5NFVRyCZo0Nl92Hi7Pr7kqraSBtofGxF1jrvpoxfMIrjqR7+QIeoT
 DD/6QI4uO7MYOPrpLwF1MTGoN4eK8I5OZ95uGJ+wZ3aI7ywNkE7P170eY2P/PdPOL6VT
 NpF3jMGSky1T92UUkLyCqddBo/VVl9sNH/i4M3gPyja8wUBqHfksrd9eKeSzhTuCpsVo
 cttZ8eaAp+exnIqZMjPSv3o+jLuCg+OlPNiYJT2Z4iMLgMS+ndvO0UiLFy5jwtlse5/1
 S/jcY8sGimPmK4habS52zXHRStOohFB/OCSym7AfSbFwENN109wcf1SpCFCrI89zeICH
 q1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=GIDTjvgN2dQLUduv7RxatH83G3BsgCWMQ2FcB7REqfs=;
 b=vzl9SqOfd6xRrj4/zIvvQfljI6MtSRm3/GPCnMx+O0KwJ248C5toj7Dil4QCTk7b0X
 U7N5swm2grWFZFNZizt4RxQ9tZw680SQt4DGt+fdbpBn6xk96PVuL/r6vuk4YSqcX0PU
 WQKocnX9zzmW1lAa3n9qaq+yhsHbAgUyQ5XWbHaKtP27RKtwyBF67xgUKryuQIn+Hxpg
 jSAT6FQgYx1ZLR/PF4vgKUrPq5XRznNva1E68Ra8QkqPsoWHEnXkLRX4GUBsklapaBK3
 uHWML79bIk2LnI5CDViXbLFH/VJe3Fx/7rvbcW8POPkIU8ZJkFk95oc6b8cW814SOAw0
 Qplw==
X-Gm-Message-State: ACgBeo2D3yvsrza4ydEglSfgSJcBMLWiNdw9kxHkw5+USTzjUN2JUcvI
 +zIO62640eGuPqfqS2NM5Tg=
X-Google-Smtp-Source: AA6agR4Oa3xeyJEHOCD3c8Lq//cSYVzt02gN8ohKXDfVu0/d9ZBPa13FJaFQ8NL26HS17npkIfTR2w==
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id
 c22-20020a7bc016000000b003a5fff262f4mr7882891wmb.104.1662276380333; 
 Sun, 04 Sep 2022 00:26:20 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 d16-20020adfe850000000b0022526db2363sm5695580wrn.30.2022.09.04.00.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:19 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] target/openrisc: Enable MTTCG
Date: Sun,  4 Sep 2022 08:26:04 +0100
Message-Id: <20220904072607.44275-9-shorne@gmail.com>
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

This patch enables multithread TCG for OpenRISC.  Since the or1k shared
syncrhonized timer can be updated from each vCPU via helpers we use a
mutex to synchronize updates.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 configs/targets/or1k-softmmu.mak | 1 +
 target/openrisc/cpu.h            | 2 ++
 target/openrisc/sys_helper.c     | 7 ++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 263e970870..432f855a30 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=openrisc
+TARGET_SUPPORTS_MTTCG=y
 TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b9584f10d4..1d5efa5ca2 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -25,6 +25,8 @@
 #include "hw/core/cpu.h"
 #include "qom/object.h"
 
+#define TCG_GUEST_DEFAULT_MO (0)
+
 #define TYPE_OPENRISC_CPU "or1k-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(OpenRISCCPU, OpenRISCCPUClass, OPENRISC_CPU)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 48674231e7..da88ad9e77 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -145,6 +145,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         break;
     case TO_SPR(10, 0): /* TTMR */
         {
+            qemu_mutex_lock_iothread();
             if ((env->ttmr & TTMR_M) ^ (rb & TTMR_M)) {
                 switch (rb & TTMR_M) {
                 case TIMER_NONE:
@@ -168,14 +169,16 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
                 env->ttmr = rb & ~TTMR_IP;
                 cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
             }
-
             cpu_openrisc_timer_update(cpu);
+            qemu_mutex_unlock_iothread();
         }
         break;
 
     case TO_SPR(10, 1): /* TTCR */
+        qemu_mutex_lock_iothread();
         cpu_openrisc_count_set(cpu, rb);
         cpu_openrisc_timer_update(cpu);
+        qemu_mutex_unlock_iothread();
         break;
 #endif
 
@@ -303,7 +306,9 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         return env->ttmr;
 
     case TO_SPR(10, 1): /* TTCR */
+        qemu_mutex_lock_iothread();
         cpu_openrisc_count_update(cpu);
+        qemu_mutex_unlock_iothread();
         return cpu_openrisc_count_get(cpu);
 #endif
 
-- 
2.37.2

