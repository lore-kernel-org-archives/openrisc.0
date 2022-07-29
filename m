Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0576C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:24 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 04D12249AF;
	Sat, 30 Jul 2022 01:06:24 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mail.librecores.org (Postfix) with ESMTPS id 77A7E249AF
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:22 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 w17-20020a17090a8a1100b001f326c73df6so4934458pjn.3
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yjU1zPUMAqicguRm1cR77GzJDaEy6d171FJDhkxwV1U=;
 b=KGwzI2ujPh0vwHY/g3EJxKly6e1Oq+erVA5njmecppvTTV9ZTAYqGVXUUlmjd2LgXn
 QTQelyJrwtMfq++oi6heGlfDfXGOjw2KoM2RynGtYgXjJVJfUaAbCyvMuiJqgXH/brSI
 j1xSYV8LGhKngXG9t4kUUacZvreAHQoBeWNcsjP3DpDf8lxMy4O/WwlQ+54ibTqejiMC
 Wc21KObTLL3vT8g4PkqOT0FysuRK4q8CaN21jp6hqL3CcW5o7HmFZbWRuR9OOVmBwIBO
 s5vYZt7cXMo35YGS0YbUtugJPEJShfSLPFdd09AtxVnu453M1npMWl22WcwIxcfMeiLA
 SXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yjU1zPUMAqicguRm1cR77GzJDaEy6d171FJDhkxwV1U=;
 b=RUE9gJnsr1RTpE/aYJTLNEIZT5QqRI335vproZuDhJZrvwCS7zs7+0c4wgTqgWGGid
 /svceQpRZXRf40doG/pxj+saLA2cX1gW/PQuqYE5QsXTRUDGF4JxkZn1tRyolHFPVQz5
 kvmDYifpWFkXkUKlB44ylYiMpaX7QPfR14O2cizLIdkloYK2GLo0DreEngic2xN739e9
 /6jxak0Wz/bfmWA27IS8aVE8lGGEmStHV9NCMdlcLabvcpQfDMaulDaBmhzrRKTFOO+o
 oyjj23MBVJEn34pQGeibrJwjNIvk2NIuX5cnlsco4N3dGfLmi3+8iipmkwxbn8vDCqFY
 g0bg==
X-Gm-Message-State: ACgBeo27ytPcNSjZvQ6vDC3lb94lRKNGJwBU1oF0v+V7CWomahKiXYI9
 /XB00gTA8N488pqufqDzynM=
X-Google-Smtp-Source: AA6agR4MNdOUyonuyAyNPJjEyXClu7+UvOblUn6RgAqnbI9MsW8Z5sswvIf361fTV7KQMmFGmgaJug==
X-Received: by 2002:a17:902:8602:b0:16c:dfae:9afb with SMTP id
 f2-20020a170902860200b0016cdfae9afbmr6039490plo.35.1659135980879; 
 Fri, 29 Jul 2022 16:06:20 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a170903120500b0016d62ba5665sm4264716plh.254.2022.07.29.16.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:20 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 03/11] goldfish_rtc: Add big-endian property
Date: Sat, 30 Jul 2022 08:01:09 +0900
Message-Id: <20220729230117.3768312-4-shorne@gmail.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Add a new property "big-endian" to allow configuring the RTC as either
little or big endian, the default is little endian.

Currently overriding the default to big endian is only used by the m68k
virt platform.  New platforms should prefer to use little endian and not
set this.

Cc: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - Added Reviewed-by
 - Changed from enum property to boolean as suggested by Richard

 hw/m68k/virt.c                |  1 +
 hw/rtc/goldfish_rtc.c         | 37 ++++++++++++++++++++++++++---------
 include/hw/rtc/goldfish_rtc.h |  2 ++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 0aa383fa6b..c7a6c766e3 100644
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
2.37.1

