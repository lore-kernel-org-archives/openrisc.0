Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A8C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:20 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 78B3D24A61;
	Sat, 30 Jul 2022 01:06:19 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mail.librecores.org (Postfix) with ESMTPS id C2781249AF
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:17 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id g12so5831719pfb.3
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A6p7vLycGg8ZjMa3Vs1wsed64HXbSkOmTpGs5WCIBWs=;
 b=UkxlUXn0w1sar0OlfCPxBAS/QIQpKXZ7RW13D9FqwklepqNDDj+HdkYyu2ODyjTQdm
 GhWbsvdW5vLT5FatMJgt+ZwqCo/ow59Hk61tHvaVx8IUdl3nrTHre/rS+Cb1zI5akePc
 xk3HGna5iWSLt66s/zxZ/rKyvKYkYD0xosrhwkBt0K4TpZDv5NORdeu3o4WsMnN51P1h
 ubocUfBn7TjkzcFIYQpeoFNhzfMts9R/4Cgp9WzDsQXRmcqoDP0MBTUIjrpqhLPXpRSy
 8ig44OpgyTdIG6oMBhhA6GXMru1f8NrkB2kSRUAVoEZgZ0RzkNA32YdD/MCEdckNBkZL
 4pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A6p7vLycGg8ZjMa3Vs1wsed64HXbSkOmTpGs5WCIBWs=;
 b=1SdeQ4z1lujZuY0Xgl2+KZVoYrlxnAYlGWgoz8tiii49m9LcLE1zuLfCxwGjZwALOc
 5bpBhvBFHV0ey3nnLdvl6XptSk0RUYqraEcPMdIrjecEqo+flcRe90k66KjbWoVyU7zE
 Qj1LfM4wDGw+gKNC/tovKe3OsMcpDS8ziMSzsP6sVY877vdxqcJTo2jGwAhu0onTY3Ti
 UHRJq5Acdb2jcqo93zolQO6d3sDpPx99JewN0BBbHLApnDICb1RRT7nHdeDZiKvOh9qw
 UywOaLRnhr06ca9yEdYo+mLX7+dhcoMUKN6wrccGUtGdEdnMkfIVfr/Ptu431Lyk627f
 b5rQ==
X-Gm-Message-State: AJIora9nQD8kAY9FZYUiELvwZ3RVePoOp7mL+JFAz64Cvp/fwoE+AmA7
 yQdoEfMHcyJbsxC+TccGxbKl4khMFigQKQ==
X-Google-Smtp-Source: AGRyM1t9ECx5CHFsfuRuOpvYZOSoYwBil0p81NSkvMENeJ72DzD67+jWffw0dxTE1uwpOEi8EH8nFw==
X-Received: by 2002:a63:6e82:0:b0:41a:1817:15d9 with SMTP id
 j124-20020a636e82000000b0041a181715d9mr4675950pgc.577.1659135975995; 
 Fri, 29 Jul 2022 16:06:15 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a170902714500b0016c574aa0fdsm4211566plm.76.2022.07.29.16.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:15 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 01/11] hw/openrisc: Split re-usable boot time apis out to
 boot.c
Date: Sat, 30 Jul 2022 08:01:07 +0900
Message-Id: <20220729230117.3768312-2-shorne@gmail.com>
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
 Richard Henderson <richard.henderson@linaro.org>, Jia Liu <proljc@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

These will be shared with the virt platform.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - No changes

 hw/openrisc/boot.c         | 117 +++++++++++++++++++++++++++++++++++++
 hw/openrisc/meson.build    |   1 +
 hw/openrisc/openrisc_sim.c | 106 ++-------------------------------
 include/hw/openrisc/boot.h |  34 +++++++++++
 4 files changed, 158 insertions(+), 100 deletions(-)
 create mode 100644 hw/openrisc/boot.c
 create mode 100644 include/hw/openrisc/boot.h

diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
new file mode 100644
index 0000000000..ca773b385e
--- /dev/null
+++ b/hw/openrisc/boot.c
@@ -0,0 +1,117 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU OpenRISC boot helpers.
+ *
+ * (c) 2022 Stafford Horne <shorne@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/cpu-defs.h"
+#include "elf.h"
+#include "hw/loader.h"
+#include "hw/openrisc/boot.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/qtest.h"
+
+#include <libfdt.h>
+
+#define KERNEL_LOAD_ADDR 0x100
+
+hwaddr openrisc_load_kernel(ram_addr_t ram_size,
+                            const char *kernel_filename,
+                            uint32_t *bootstrap_pc)
+{
+    long kernel_size;
+    uint64_t elf_entry;
+    uint64_t high_addr;
+    hwaddr entry;
+
+    if (kernel_filename && !qtest_enabled()) {
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
+                               &elf_entry, NULL, &high_addr, NULL, 1,
+                               EM_OPENRISC, 1, 0);
+        entry = elf_entry;
+        if (kernel_size < 0) {
+            kernel_size = load_uimage(kernel_filename,
+                                      &entry, NULL, NULL, NULL, NULL);
+            high_addr = entry + kernel_size;
+        }
+        if (kernel_size < 0) {
+            kernel_size = load_image_targphys(kernel_filename,
+                                              KERNEL_LOAD_ADDR,
+                                              ram_size - KERNEL_LOAD_ADDR);
+            high_addr = KERNEL_LOAD_ADDR + kernel_size;
+        }
+
+        if (entry <= 0) {
+            entry = KERNEL_LOAD_ADDR;
+        }
+
+        if (kernel_size < 0) {
+            error_report("couldn't load the kernel '%s'", kernel_filename);
+            exit(1);
+        }
+        *bootstrap_pc = entry;
+
+        return high_addr;
+    }
+    return 0;
+}
+
+hwaddr openrisc_load_initrd(void *fdt, const char *filename,
+                            hwaddr load_start, uint64_t mem_size)
+{
+    int size;
+    hwaddr start;
+
+    /* We put the initrd right after the kernel; page aligned. */
+    start = TARGET_PAGE_ALIGN(load_start);
+
+    size = load_ramdisk(filename, start, mem_size - start);
+    if (size < 0) {
+        size = load_image_targphys(filename, start, mem_size - start);
+        if (size < 0) {
+            error_report("could not load ramdisk '%s'", filename);
+            exit(1);
+        }
+    }
+
+    if (fdt) {
+        qemu_fdt_setprop_cell(fdt, "/chosen",
+                              "linux,initrd-start", start);
+        qemu_fdt_setprop_cell(fdt, "/chosen",
+                              "linux,initrd-end", start + size);
+    }
+
+    return start + size;
+}
+
+uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
+                           uint64_t mem_size)
+{
+    uint32_t fdt_addr;
+    int ret;
+    int fdtsize = fdt_totalsize(fdt);
+
+    if (fdtsize <= 0) {
+        error_report("invalid device-tree");
+        exit(1);
+    }
+
+    /* We put fdt right after the kernel and/or initrd. */
+    fdt_addr = TARGET_PAGE_ALIGN(load_start);
+
+    ret = fdt_pack(fdt);
+    /* Should only fail if we've built a corrupted tree */
+    g_assert(ret == 0);
+    /* copy in the device tree */
+    qemu_fdt_dumpdtb(fdt, fdtsize);
+
+    rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
+                          &address_space_memory);
+
+    return fdt_addr;
+}
+
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
index ec48172c9d..ab563820c5 100644
--- a/hw/openrisc/meson.build
+++ b/hw/openrisc/meson.build
@@ -1,5 +1,6 @@
 openrisc_ss = ss.source_set()
 openrisc_ss.add(files('cputimer.c'))
+openrisc_ss.add(files('boot.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: [files('openrisc_sim.c'), fdt])
 
 hw_arch += {'openrisc': openrisc_ss}
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 35adce17ac..35da123aef 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -24,10 +24,9 @@
 #include "cpu.h"
 #include "hw/irq.h"
 #include "hw/boards.h"
-#include "elf.h"
 #include "hw/char/serial.h"
 #include "net/net.h"
-#include "hw/loader.h"
+#include "hw/openrisc/boot.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "sysemu/device_tree.h"
@@ -283,101 +282,6 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     g_free(nodename);
 }
 
-static hwaddr openrisc_load_kernel(ram_addr_t ram_size,
-                                   const char *kernel_filename)
-{
-    long kernel_size;
-    uint64_t elf_entry;
-    uint64_t high_addr;
-    hwaddr entry;
-
-    if (kernel_filename && !qtest_enabled()) {
-        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
-                               &elf_entry, NULL, &high_addr, NULL, 1,
-                               EM_OPENRISC, 1, 0);
-        entry = elf_entry;
-        if (kernel_size < 0) {
-            kernel_size = load_uimage(kernel_filename,
-                                      &entry, NULL, NULL, NULL, NULL);
-            high_addr = entry + kernel_size;
-        }
-        if (kernel_size < 0) {
-            kernel_size = load_image_targphys(kernel_filename,
-                                              KERNEL_LOAD_ADDR,
-                                              ram_size - KERNEL_LOAD_ADDR);
-            high_addr = KERNEL_LOAD_ADDR + kernel_size;
-        }
-
-        if (entry <= 0) {
-            entry = KERNEL_LOAD_ADDR;
-        }
-
-        if (kernel_size < 0) {
-            error_report("couldn't load the kernel '%s'", kernel_filename);
-            exit(1);
-        }
-        boot_info.bootstrap_pc = entry;
-
-        return high_addr;
-    }
-    return 0;
-}
-
-static hwaddr openrisc_load_initrd(Or1ksimState *state, const char *filename,
-                                   hwaddr load_start, uint64_t mem_size)
-{
-    void *fdt = state->fdt;
-    int size;
-    hwaddr start;
-
-    /* We put the initrd right after the kernel; page aligned. */
-    start = TARGET_PAGE_ALIGN(load_start);
-
-    size = load_ramdisk(filename, start, mem_size - start);
-    if (size < 0) {
-        size = load_image_targphys(filename, start, mem_size - start);
-        if (size < 0) {
-            error_report("could not load ramdisk '%s'", filename);
-            exit(1);
-        }
-    }
-
-    qemu_fdt_setprop_cell(fdt, "/chosen",
-                          "linux,initrd-start", start);
-    qemu_fdt_setprop_cell(fdt, "/chosen",
-                          "linux,initrd-end", start + size);
-
-    return start + size;
-}
-
-static uint32_t openrisc_load_fdt(Or1ksimState *state, hwaddr load_start,
-                                  uint64_t mem_size)
-{
-    void *fdt = state->fdt;
-    uint32_t fdt_addr;
-    int ret;
-    int fdtsize = fdt_totalsize(fdt);
-
-    if (fdtsize <= 0) {
-        error_report("invalid device-tree");
-        exit(1);
-    }
-
-    /* We put fdt right after the kernel and/or initrd. */
-    fdt_addr = TARGET_PAGE_ALIGN(load_start);
-
-    ret = fdt_pack(fdt);
-    /* Should only fail if we've built a corrupted tree */
-    g_assert(ret == 0);
-    /* copy in the device tree */
-    qemu_fdt_dumpdtb(fdt, fdtsize);
-
-    rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
-                          &address_space_memory);
-
-    return fdt_addr;
-}
-
 static void openrisc_sim_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
@@ -428,13 +332,15 @@ static void openrisc_sim_init(MachineState *machine)
                                  or1ksim_memmap[OR1KSIM_UART].size,
                                  smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
 
-    load_addr = openrisc_load_kernel(ram_size, kernel_filename);
+    load_addr = openrisc_load_kernel(ram_size, kernel_filename,
+                                     &boot_info.bootstrap_pc);
     if (load_addr > 0) {
         if (machine->initrd_filename) {
-            load_addr = openrisc_load_initrd(state, machine->initrd_filename,
+            load_addr = openrisc_load_initrd(state->fdt,
+                                             machine->initrd_filename,
                                              load_addr, machine->ram_size);
         }
-        boot_info.fdt_addr = openrisc_load_fdt(state, load_addr,
+        boot_info.fdt_addr = openrisc_load_fdt(state->fdt, load_addr,
                                                machine->ram_size);
     }
 }
diff --git a/include/hw/openrisc/boot.h b/include/hw/openrisc/boot.h
new file mode 100644
index 0000000000..25a313d63a
--- /dev/null
+++ b/include/hw/openrisc/boot.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU OpenRISC boot helpers.
+ *
+ * Copyright (c) 2022 Stafford Horne <shorne@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef OPENRISC_BOOT_H
+#define OPENRISC_BOOT_H
+
+#include "exec/cpu-defs.h"
+
+hwaddr openrisc_load_kernel(ram_addr_t ram_size,
+                            const char *kernel_filename,
+                            uint32_t *bootstrap_pc);
+
+hwaddr openrisc_load_initrd(void *fdt, const char *filename,
+                            hwaddr load_start, uint64_t mem_size);
+
+uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
+                           uint64_t mem_size);
+
+#endif /* OPENRISC_BOOT_H */
-- 
2.37.1

