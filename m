Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4554FC433EF
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:29:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4EA3324854;
	Sun,  3 Jul 2022 23:29:08 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mail.librecores.org (Postfix) with ESMTPS id 1908E247C4
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:29:06 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 o31-20020a17090a0a2200b001ef7bd037bbso2426354pjo.0
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/MXXLV0LZy1uJbbvG08ZlNwuwtS15Y0l66bFqVyGakc=;
 b=f9tO0eeVwQC+n50B1O9h5A3Q805au/rhO85CZBsJMAW9/y3kKM1ucr1XKT+rjoE/i9
 niYCOFv3UKNusApMrbyXo/GbQQZrVVpFZnDNlm595B7lMydviyk57ojZKPKKjs9g7G9/
 jNeJwtBFkXPxRIZDDNQNqXfmLSmUJsrB8qdkOT9QoEqVyXCi4pMCO5FTADTCOmmCQfot
 XT1R6ELEF4VjG3UG2ai5dwZDdpGb8u3PmphmnMnrm4TqeV415c6vo8fMIp5O3G8Y+/PK
 AsD1m0KRTyajqN2X3/HvZkcq/p69GY8h1kP1xaCslzb6P3OAR5ShIfSM7VnkvRHxmkIy
 OunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/MXXLV0LZy1uJbbvG08ZlNwuwtS15Y0l66bFqVyGakc=;
 b=ysd89wSfv5ckag10JoEyYZlUxNCTmv6ealV1RiMNcJPASR5rt8Cx7OR2O0DoPvNMud
 vDP9xgCb/J8FbblCZoh06hegzQP+WVgzRPicez2J77CxEYig8tMhChFBo4IOsvYyE3IH
 bUjJ8okNqDraT4JqcSKYrYjDxZJTs2Z7t4I6kaucFXU8grybrGwi4SJ5EGZHq+bTHPEd
 Me44SLeXhA6dbHKbYC9AZh8s/yN0lmQGt6ht4adqxfWaY2nrnm+iicSO+OWbvaUWDXaU
 C5PLAR+Z7jNhHaCn9YMbrwBgaqvFE/UXWGLa1rcroQxEuM8qIROvPUq//1nG8s8OnHh4
 oNuA==
X-Gm-Message-State: AJIora8wVCmimS7tDsplTrTS+w4o+356T1luXjzAwD8lhGknAJ59rylM
 g6hZfsy7fMkJrgqkICGxsYkp7mz8CqU=
X-Google-Smtp-Source: AGRyM1soSKfk0pyXM4TITOlMDRo1+PWVK4Hcot5w1kezisVD/61i2wNsXF3wp35V8t+H8q/wVO2D6g==
X-Received: by 2002:a17:902:8345:b0:167:879c:abe8 with SMTP id
 z5-20020a170902834500b00167879cabe8mr31507013pln.7.1656883744682; 
 Sun, 03 Jul 2022 14:29:04 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 iw4-20020a170903044400b0016be5ed14d5sm65243plb.40.2022.07.03.14.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:29:04 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 08/11] target/openrisc: Enable MTTCG
Date: Mon,  4 Jul 2022 06:28:20 +0900
Message-Id: <20220703212823.10067-9-shorne@gmail.com>
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

This patch enables multithread TCG for OpenRISC.  Since the or1k shared
syncrhonized timer can be updated from each vCPU via helpers we use a
mutex to synchronize updates.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 configs/targets/or1k-softmmu.mak |  1 +
 hw/openrisc/cputimer.c           | 17 +++++++++++++++++
 target/openrisc/cpu.h            |  3 +++
 target/openrisc/sys_helper.c     | 11 +++++++++--
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 263e970870..432f855a30 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=openrisc
+TARGET_SUPPORTS_MTTCG=y
 TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 4dbba3a3d4..2298eff8b9 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -43,6 +43,23 @@ uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu)
     return or1k_timer->ttcr;
 }
 
+/*
+ * Check to see if calling cpu_openrisc_count_update will
+ * actually advance the time.
+ *
+ * Used in hot spots to avoid taking expensive locks.
+ */
+bool cpu_openrisc_timer_has_advanced(OpenRISCCPU *cpu)
+{
+    uint64_t now;
+
+    if (!cpu->env.is_counting) {
+        return false;
+    }
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    return (now - or1k_timer->last_clk) >= TIMER_PERIOD;
+}
+
 /* Add elapsed ticks to ttcr */
 void cpu_openrisc_count_update(OpenRISCCPU *cpu)
 {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b9584f10d4..5354d681f5 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -25,6 +25,8 @@
 #include "hw/core/cpu.h"
 #include "qom/object.h"
 
+#define TCG_GUEST_DEFAULT_MO (0)
+
 #define TYPE_OPENRISC_CPU "or1k-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(OpenRISCCPU, OpenRISCCPUClass, OPENRISC_CPU)
@@ -333,6 +335,7 @@ void cpu_openrisc_pic_init(OpenRISCCPU *cpu);
 
 /* hw/openrisc_timer.c */
 void cpu_openrisc_clock_init(OpenRISCCPU *cpu);
+bool cpu_openrisc_timer_has_advanced(OpenRISCCPU *cpu);
 uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu);
 void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val);
 void cpu_openrisc_count_update(OpenRISCCPU *cpu);
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 48674231e7..7c0d3d6187 100644
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
 
@@ -303,7 +306,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         return env->ttmr;
 
     case TO_SPR(10, 1): /* TTCR */
-        cpu_openrisc_count_update(cpu);
+        if (cpu_openrisc_timer_has_advanced(cpu)) {
+            qemu_mutex_lock_iothread();
+            cpu_openrisc_count_update(cpu);
+            qemu_mutex_unlock_iothread();
+        }
         return cpu_openrisc_count_get(cpu);
 #endif
 
-- 
2.36.1

