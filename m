Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745B1C433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 01:40:17 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 75F0D247CB;
	Sun, 15 May 2022 03:40:16 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mail.librecores.org (Postfix) with ESMTPS id 2E56124909
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 03:40:15 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 w17-20020a17090a529100b001db302efed6so11112350pjh.4
 for <openrisc@lists.librecores.org>; Sat, 14 May 2022 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c+Kt0PArB3y+ijbSsfSsEw1SqbmDMmpC2y/OF67/b6Y=;
 b=ZFiVVPs+OoE2OHjiQwhQhNhC7syET1O/VDwbAFK9kRbQufA9FCzG3ohkNH6waAus/k
 PO4tfyRNBnCa9UyBf5o24NoU+4baTKRknUreS0ZpkgVIPyUMA2IB2Mk9cJtWsvhHkTDr
 qCjcClJ8TwYqbApuL7GdvlYZgJCpUYIJxpk1oT+S4zy7fPsbAjU7MI8daR7rC/2EQrPI
 TWwtswpeMyd/EgO/uyVrZcHkz7547I0zJ674j2tyBZpP8h5uJ8y7pZHr7lWGyqyLl4so
 jigpxyInPrmqTL8RdkxDvE0H6q/aJj5zd8OqKe4MQtRcHFoqjOPOKrnAldHNxuomtGSn
 edTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c+Kt0PArB3y+ijbSsfSsEw1SqbmDMmpC2y/OF67/b6Y=;
 b=62/+BHfAQkZxrverC/W3xvU5B64A66ElNhFS2J3+eb0pfvmZBXjMSzhMvhLzjdLzR6
 gS5Q8vbjJndh+tZGuAysSbX5r7NpnfuiueRjj3dJQTOYenX0K5g9oEtpwlPzU08tGBNs
 Y/i6n7tPMvgjf+tvOhjFBMqiDe/cd8d9LytrwIPZqjWbC+1pgkMbUrbeiPcDgzZbZL8E
 9w1CVdYfpcEj9hAk64DgAa8PVS5Pl5t0OxIcnyghJHfTfD+DwDv5mdRQjrFS27k2hRzd
 rsMiNwCbSLv576YZd2N1MOUPVV7C6+vgcN4EJe1PTjgLLnmWKPZ3r/5H3GQOrsKdgBSh
 fBkg==
X-Gm-Message-State: AOAM531QENFgc/QBIyfL4XIxUDHctU+yG4RkoVSGSbdPNPji/FVtsA3a
 3ipxOpPTk3Eaq1WGfDBAAM0=
X-Google-Smtp-Source: ABdhPJwKQsWhgPLsoHqQ65D459M3CmWantwYMmq+pxgzfB2i5y4wF4QDN43zGZM/JzEn3e2qhskB1w==
X-Received: by 2002:a17:90a:9bc6:b0:1d8:2d8e:1b97 with SMTP id
 b6-20020a17090a9bc600b001d82d8e1b97mr12242223pjw.45.1652578813760; 
 Sat, 14 May 2022 18:40:13 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 2-20020a17090a19c200b001d5c571f487sm3795440pjj.25.2022.05.14.18.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 May 2022 18:40:13 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PULL 2/4] hw/openrisc: support 4 serial ports in or1ksim
Date: Sun, 15 May 2022 10:39:46 +0900
Message-Id: <20220515013948.2993495-3-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515013948.2993495-1-shorne@gmail.com>
References: <20220515013948.2993495-1-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>, Jia Liu <proljc@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

The 8250 serial controller supports 4 serial ports, so wire them all up,
so that we can have more than one basic I/O channel.

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
[smh:Fixup indentation and lines over 80 chars]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/openrisc_sim.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 99b14940f4..6873124f74 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -71,6 +71,10 @@ enum {
     OR1KSIM_ETHOC_IRQ = 4,
 };
 
+enum {
+    OR1KSIM_UART_COUNT = 4
+};
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -239,11 +243,13 @@ static void openrisc_sim_ompic_init(Or1ksimState *state, hwaddr base,
 
 static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
                                      hwaddr size, int num_cpus,
-                                     OpenRISCCPU *cpus[], int irq_pin)
+                                     OpenRISCCPU *cpus[], int irq_pin,
+                                     int uart_idx)
 {
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
+    char alias[sizeof("uart0")];
     int i;
 
     if (num_cpus > 1) {
@@ -258,7 +264,8 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
+                   DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
     nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
@@ -271,7 +278,8 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
 
     /* The /chosen node is created during fdt creation. */
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/aliases", "uart0", nodename);
+    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
     g_free(nodename);
 }
 
@@ -414,9 +422,11 @@ static void openrisc_sim_init(MachineState *machine)
                                 smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
     }
 
-    openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base,
-                             or1ksim_memmap[OR1KSIM_UART].size, smp_cpus, cpus,
-                             OR1KSIM_UART_IRQ);
+    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
+        openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
+                                        or1ksim_memmap[OR1KSIM_UART].size * n,
+                                 or1ksim_memmap[OR1KSIM_UART].size,
+                                 smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
 
     load_addr = openrisc_load_kernel(ram_size, kernel_filename);
     if (load_addr > 0) {
-- 
2.31.1

