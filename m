Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BBC43334
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:28:57 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8E37724853;
	Sun,  3 Jul 2022 23:28:56 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mail.librecores.org (Postfix) with ESMTPS id 940C2247C4
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:28:54 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 cp18-20020a17090afb9200b001ef79e8484aso1691937pjb.1
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YlIyXL2dJYUsBzYu+/v+5PBfakGFPnGlml4Uo85UalI=;
 b=EUo/6ZSekJY6gqforpqcPPpmcVlwcXfDL+Qe3SvVIwVfTga21UPWG1l4msRkpqNEVZ
 N33D3eY5fNPjHUywNV3Je6HW9MF6OlzDTmm5G+sokoymuhmMBDjO3D27HJqeICI8nS/F
 arxFHrd/fsixzVbG/1fnp0OSEkSNsAQaQBetXeErT1PpRYfV3YRqbqjkATybSXNw4Lz3
 6MwpuKzCKQcjxGuQ5LXP1PM7myk1Z10fkPO6QwPG6KY+BPGfN3DFfmKRkVoPDHZuKd5e
 pCDU430Q4ZBYZVM4C5Pku9l6/VNCPmQ+uJ22lP8ueLMKSuzBzv2y57+c7manm8kU0O9y
 kf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YlIyXL2dJYUsBzYu+/v+5PBfakGFPnGlml4Uo85UalI=;
 b=fgAUuvEoKdWHKKxhgdKwv+TxOHwuqqMaaceDuexVLr9GJrJRbpX687iETX5QSClHmO
 e7lUfjECPc24EcABuE6yODxK4ByQb/36A5yW8QUZ52qIAcGfKJAxRiUV+YQnt1A1aUEb
 NAZzOcSHxb4MnT5vINYxeADbsCgIer3ED8JtuyM3Co4BzETZMXUazb0SOv6xlJsHcdSr
 V1sSg7LCpIckH53O/goKqhMhdqEF0Ete+jEiWLUf7fUYRWym6PCHFB+DH9Q1t3R5uV36
 6AxGg7dsfDp2RnDXiZgsV2qHLAmny6byzLFUGPXenJNRYi2JfyYo1E5r5KtNshXD+sOs
 MgIQ==
X-Gm-Message-State: AJIora8cbVi6DxbrZz0VGlx+HWvwhfjY87l583W/YtfTDkoZjcpBmMso
 1uYnMaKnr7RgRND8/bAPJJLM4W2ilW8=
X-Google-Smtp-Source: AGRyM1sD/yq/6+pPX/yRwDKQAxJK/ypniQTxi+KZuMeJ5WVTJOAe0y5noJPJb5Su0ye+XMhR9AnTpQ==
X-Received: by 2002:a17:90b:3b4e:b0:1ed:2236:34f3 with SMTP id
 ot14-20020a17090b3b4e00b001ed223634f3mr32074262pjb.6.1656883733147; 
 Sun, 03 Jul 2022 14:28:53 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 me3-20020a17090b17c300b001ec84b0f199sm14266337pjb.1.2022.07.03.14.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:28:52 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 03/11] goldfish_rtc: Add endianness property
Date: Mon,  4 Jul 2022 06:28:15 +0900
Message-Id: <20220703212823.10067-4-shorne@gmail.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>, Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Add an endianness property to allow configuring the RTC as either
native, little or big endian.

Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/rtc/goldfish_rtc.c         | 46 ++++++++++++++++++++++++++++-------
 include/hw/rtc/goldfish_rtc.h |  2 ++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 35e493be31..24f6587086 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -216,14 +216,34 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
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
+static const MemoryRegionOps goldfish_rtc_ops[3] = {
+    [DEVICE_NATIVE_ENDIAN] = {
+        .read = goldfish_rtc_read,
+        .write = goldfish_rtc_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4
+        }
+    },
+    [DEVICE_LITTLE_ENDIAN] = {
+        .read = goldfish_rtc_read,
+        .write = goldfish_rtc_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4
+        }
+    },
+    [DEVICE_BIG_ENDIAN] = {
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
@@ -265,7 +285,8 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     GoldfishRTCState *s = GOLDFISH_RTC(d);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(s),
+                          &goldfish_rtc_ops[s->endianness], s,
                           "goldfish_rtc", 0x24);
     sysbus_init_mmio(dev, &s->iomem);
 
@@ -274,10 +295,17 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
 }
 
+static Property goldfish_rtc_properties[] = {
+    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
+                      DEVICE_NATIVE_ENDIAN),
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
index 79ca7daf5d..8e1aeb85e3 100644
--- a/include/hw/rtc/goldfish_rtc.h
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -42,6 +42,8 @@ struct GoldfishRTCState {
     uint32_t irq_pending;
     uint32_t irq_enabled;
     uint32_t time_high;
+
+    uint8_t endianness;
 };
 
 #endif
-- 
2.36.1

