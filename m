Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F5C6FA86
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:16 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C304424B2A;
	Sun,  4 Sep 2022 09:26:15 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mail.librecores.org (Postfix) with ESMTPS id DC07124B2C
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:14 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 n23-20020a7bc5d7000000b003a62f19b453so6084278wmk.3
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=uGKTuEEdNSahZZj2+c3bTExRFoC76JbBn9lXSOaT3d0=;
 b=jME8MX0/IBOU0FxbilgP+sBk4TUi6JpM/AZh5EAPWRTngwLhcFWtxY/rnbDBWqdfO+
 9pesfzLCsz0HLW/5fdKuauN/zM10IxXxMODMy2G03/e+1zWWNocpsX/jGpN9qQAEAUTU
 s0ESGhE9U5wnLzM7ue/3ymujS6W24QrSDD965JfHNKyk4iZ9gEEhHuVGVmoN5oTWeUPN
 UcpWHliFuEESCe6fO9+HpgkBqoXcgQrDBQXRcy9/84A8x1pl2csz9la0TD/ZSsw3GxJD
 uY84ykl6iQ/FcZc0emDyUGyc6VCeoaj6CTdNQzAsLhepFCmP4p4uXmxKt2/xS8+vFwg8
 LlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=uGKTuEEdNSahZZj2+c3bTExRFoC76JbBn9lXSOaT3d0=;
 b=G1t6eJ6qyfOTYcr7kAcm1j3v50l+1ePCsK83LVvX9klCMU25Jb1LolYHIGR72deWU1
 3g8ITjPQejwW+R3bDlSd3nK5czqPVrJjcLRfE0WHCFLq2cpzW7VOIm+wJ1RorEvzPb7h
 c5z7OOrCNSxS81UIz7KRLWaH0C+qKPSIn1ET8KH3Ci5X1eK7l2VanAqsyyjaSPchV6DS
 GFBqDbPr9C3SWcytUApU+P31+9RXpsVKRSXYx7IDYGCsRSwB6L7v8QaO/c4iuZvxWyBr
 W+a8+gNCi0kfypcTbTCMNaFY7SBwomHHg5zxzJfJ8/CwhVMLLxzDuKjJ1VaXwWmex3iw
 F2nw==
X-Gm-Message-State: ACgBeo0fDYghcbdqq4QMB1vWmzpI6l62gvjEZyvK/mGOP/AJOgE2x/sj
 Gv0aRA8+H83W61HjYVx4Jbc=
X-Google-Smtp-Source: AA6agR75SalOEdot1Wr9S0J2OvxHLNpyVPQ8rlbgDO8N/nzZllhDP3iph0pBxJIpOmqpkoYJMCmwGg==
X-Received: by 2002:a1c:3b55:0:b0:3a6:7b62:3901 with SMTP id
 i82-20020a1c3b55000000b003a67b623901mr7612818wma.113.1662276374522; 
 Sun, 04 Sep 2022 00:26:14 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 h4-20020a5d4304000000b002238ea5750csm6657713wrq.72.2022.09.04.00.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:14 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] goldfish_rtc: Add big-endian property
Date: Sun,  4 Sep 2022 08:25:59 +0100
Message-Id: <20220904072607.44275-4-shorne@gmail.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Anup Patel <anup@brainfault.org>,
 openrisc@lists.librecores.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Add a new property "big-endian" to allow configuring the RTC as either
little or big endian, the default is little endian.

Currently overriding the default to big endian is only used by the m68k
virt platform.  New platforms should prefer to use little endian and not
set this.

Cc: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/m68k/virt.c                |  1 +
 hw/rtc/goldfish_rtc.c         | 37 ++++++++++++++++++++++++++---------
 include/hw/rtc/goldfish_rtc.h |  2 ++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 3122c8ef2c..2f3ffc0de6 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -173,6 +173,7 @@ static void virt_init(MachineState *machine)
     io_base = VIRT_GF_RTC_MMIO_BASE;
     for (i = 0; i < VIRT_GF_RTC_NB; i++) {
         dev = qdev_new(TYPE_GOLDFISH_RTC);
+        qdev_prop_set_bit(dev, "big-endian", true);
         sysbus = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(sysbus, &error_fatal);
         sysbus_mmio_map(sysbus, 0, io_base);
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 35e493be31..19a56402a0 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -216,14 +216,25 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const MemoryRegionOps goldfish_rtc_ops = {
-    .read = goldfish_rtc_read,
-    .write = goldfish_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+static const MemoryRegionOps goldfish_rtc_ops[2] = {
+    [false] = {
+        .read = goldfish_rtc_read,
+        .write = goldfish_rtc_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4
+        }
+    },
+    [true] = {
+        .read = goldfish_rtc_read,
+        .write = goldfish_rtc_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4
+        }
+    },
 };
 
 static const VMStateDescription goldfish_rtc_vmstate = {
@@ -265,7 +276,8 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     GoldfishRTCState *s = GOLDFISH_RTC(d);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(s),
+                          &goldfish_rtc_ops[s->big_endian], s,
                           "goldfish_rtc", 0x24);
     sysbus_init_mmio(dev, &s->iomem);
 
@@ -274,10 +286,17 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
 }
 
+static Property goldfish_rtc_properties[] = {
+    DEFINE_PROP_BOOL("big-endian", GoldfishRTCState, big_endian,
+                      false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, goldfish_rtc_properties);
     dc->realize = goldfish_rtc_realize;
     dc->reset = goldfish_rtc_reset;
     dc->vmsd = &goldfish_rtc_vmstate;
diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
index 79ca7daf5d..162be33863 100644
--- a/include/hw/rtc/goldfish_rtc.h
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -42,6 +42,8 @@ struct GoldfishRTCState {
     uint32_t irq_pending;
     uint32_t irq_enabled;
     uint32_t time_high;
+
+    bool big_endian;
 };
 
 #endif
-- 
2.37.2

