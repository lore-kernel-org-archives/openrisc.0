Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD0C19F2B
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:36 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CCFE624A5A;
	Sat, 30 Jul 2022 01:06:35 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mail.librecores.org (Postfix) with ESMTPS id 01A5424A7B
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:33 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id e132so5062361pgc.5
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2LHdwmKsbt7AaEVYQPi9ZpWVFkuaCwouj850ieoIXdQ=;
 b=CGRv/P1JHYI2ToBW5Dm/c7qo6Q0nu/ag+02wMJGky17bJ7WkUmcww+YZRvt7sP32Sm
 ZC4N2O0fxsYiLSCzV4AsiBcj6m+9y2rX7+sXPmAydgFy+ADmk5iYRFSLO+Ar3ylVtS8q
 SV7VMzLdqj5/Ddn8K/lmwjNBlt1QXvLzeknZX4c0Drw4vBmved63xIiQh945tU5d7u2O
 pd8/DBc90gaOsF939eR+hvFsrOp1qEmVLm0nrVOct3cSJFEJGBVS8dTJ3B5z3Ajae7P+
 7hkQnbQ46x7uc9Yq/sE58cmwF9Mj2WYX4ngseHlMkdjH7qlDJJ+9OfSwI5nmJLTUwHnG
 OiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2LHdwmKsbt7AaEVYQPi9ZpWVFkuaCwouj850ieoIXdQ=;
 b=2cSiQRMqeIBlvEXve+AoiGnlpRXR1pUCBe8mMe1PRNQcFLaZvlodjeq6AfxJe5wfde
 stdRu9j3+MKtsDT6EzaT2DBMbjnXFEQIA53UaDHh6igMFOy9VAI+TJd5ISea+poRuV2B
 pA1juh7Dyl4AFmlNL4IGTPC/l991g1vLFXqbMYRRMf0j1ZynldECwGnT4ta+lMRDBnf7
 jMHDv61IEW2OaeneqSFwwwdUnraLyktUzLRZIHoTdbnBUaAf/m17JxYCkKCyZyIw3dk2
 howAnqbwRIEr11nQCEecGorOp1Z8vQQN1tTBJNjtySbOhjWkxFqGB303VEs6Es2Ww8K8
 b2Mw==
X-Gm-Message-State: AJIora8Ix4D1M/D+uf/mg6ZvDNy2+aTDHJ7a7NQ/Ol4ft6f1X7o/C4Sp
 R4yEGGg6SaOkSRirzRknH6s=
X-Google-Smtp-Source: AGRyM1vVUiXw5u/fXN+3hwNmop5qQzVEVMO1EODHVyIJzcOY3rzJsORomJrDbyorS8KOnnFqxwDDhg==
X-Received: by 2002:a05:6a00:14d2:b0:52a:d2a1:5119 with SMTP id
 w18-20020a056a0014d200b0052ad2a15119mr5801199pfu.36.1659135992522; 
 Fri, 29 Jul 2022 16:06:32 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a1709026b4400b0016d3ee4533csm4138832plt.18.2022.07.29.16.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:32 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 08/11] target/openrisc: Enable MTTCG
Date: Sat, 30 Jul 2022 08:01:14 +0900
Message-Id: <20220729230117.3768312-9-shorne@gmail.com>
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

This patch enables multithread TCG for OpenRISC.  Since the or1k shared
syncrhonized timer can be updated from each vCPU via helpers we use a
mutex to synchronize updates.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - Removed cpu_openrisc_timer_has_advanced lock optimization, measuring revealed
   it did not help much.

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
2.37.1

