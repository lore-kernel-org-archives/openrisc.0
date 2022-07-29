Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17518C19F2B
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:27 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2AE99242D7;
	Sat, 30 Jul 2022 01:06:26 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mail.librecores.org (Postfix) with ESMTPS id B944124A62
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:24 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id v18so5791102plo.8
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7eRWEOO4OsWJrqTDgs7m1wYUwTTU+91A1WtKoqmKyUc=;
 b=bU9C850R5WZfbPlEZRAX7IgsgKkev4cOe2SlfaydI1OI9m4McCcoLCzcD0OHUknrpD
 bHxBoCm7r62imks2ob78eODz8NZZvsvx/C3H/z/YIax2S22r9masPAlTfLvJYZ00qFzY
 mv7lY/zD79PG7/jReiVsXvR21jvn8MUso4bOxpDHI5oIaIQzw5Su7dcBlFSYZK0GRlcs
 rpJHAcNrwqGoiyG2y8ueqoylcoJnLVwFMr/xOhrsTXuXjcGMRrszKMJc3EPc6w4dQVon
 UJOxWTEFK9HmQ/6Jb/TqLGdSz/MJ0R5hbUjbb6DWoLq+ELFfGhjHCMmUC28KtHWp5unn
 0vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7eRWEOO4OsWJrqTDgs7m1wYUwTTU+91A1WtKoqmKyUc=;
 b=riVnHIC6vLbLbhlesEKNZnm0Qm6xABi5ryGCgnbLF3BBvRbR1Y5tnG5Lsrcw3O0cID
 0e9R4JhdS6GgAxTnpIvQQ1fmTgZJjNMriK5cu6/cJV2q23AneVttowqgfbxzy9qgxeRO
 2iNwIICzHbDg9oCtyWsr4aVXtxDtNL1jqhI5Vou2HtnZyRb9fbQenIO47epBfFbxT8e1
 9z9d5MF/6U2bR/ghCMP4pO6a2k/EHLpArU/H/79Sbid6UW5usj1a7lTseB/IfvVDJShD
 3jNwYWDFLDx+c9EN1+HgwfuDgDsjJWAyNwEZTNfPi1lJ7xWJOesPSQpem5KV8qZkVMX5
 Q/GQ==
X-Gm-Message-State: ACgBeo1OG6E06SqdVXRobHruDRbXqVH9FRwAUQFMCF/nUpDmGwEZP4py
 b8Q78pBIVFGlAgxW4SZZVAKLAElGtkMjVA==
X-Google-Smtp-Source: AA6agR4HZWODw2eq2AreGAi0Q3O7wSrUkFp6ExPiK2rgurpUTUOkrEUE7g+sXG9/1HWjP8fSL8zFoA==
X-Received: by 2002:a17:902:e849:b0:16e:81c6:2cb7 with SMTP id
 t9-20020a170902e84900b0016e81c62cb7mr3132638plg.110.1659135983166; 
 Fri, 29 Jul 2022 16:06:23 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a170902e54500b0016c0593876csm4192630plf.157.2022.07.29.16.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:22 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 04/11] hw/openrisc: Add the OpenRISC virtual machine
Date: Sat, 30 Jul 2022 08:01:10 +0900
Message-Id: <20220729230117.3768312-5-shorne@gmail.com>
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

This patch adds the OpenRISC virtual machine 'virt' for OpenRISC.  This
platform allows for a convenient CI platform for toolchain, software
ports and the OpenRISC linux kernel port.

Much of this has been sourced from the m68k and riscv virt platforms.

The platform provides:
 - OpenRISC SMP with up to 4 cpus
 - A virtio bus with up to 8 devices
 - Standard ns16550a serial
 - Goldfish RTC
 - SiFive TEST device for poweroff and reboot
 - Generated Device Tree to automatically configure the guest kernel

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - No changes

 configs/devices/or1k-softmmu/default.mak |   1 +
 hw/openrisc/Kconfig                      |   9 +
 hw/openrisc/meson.build                  |   1 +
 hw/openrisc/virt.c                       | 417 +++++++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 hw/openrisc/virt.c

diff --git a/configs/devices/or1k-softmmu/default.mak b/configs/devices/or1k-softmmu/default.mak
index 168101c39a..89c39e3123 100644
--- a/configs/devices/or1k-softmmu/default.mak
+++ b/configs/devices/or1k-softmmu/default.mak
@@ -3,3 +3,4 @@
 # Boards:
 #
 CONFIG_OR1K_SIM=y
+CONFIG_OR1K_VIRT=y
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 8f284f3ba0..202134668e 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -4,3 +4,12 @@ config OR1K_SIM
     select OPENCORES_ETH
     select OMPIC
     select SPLIT_IRQ
+
+config OR1K_VIRT
+    bool
+    imply VIRTIO_VGA
+    imply TEST_DEVICES
+    select GOLDFISH_RTC
+    select SERIAL
+    select SIFIVE_TEST
+    select VIRTIO_MMIO
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
index ab563820c5..2dbc6365bb 100644
--- a/hw/openrisc/meson.build
+++ b/hw/openrisc/meson.build
@@ -2,5 +2,6 @@ openrisc_ss = ss.source_set()
 openrisc_ss.add(files('cputimer.c'))
 openrisc_ss.add(files('boot.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: [files('openrisc_sim.c'), fdt])
+openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: [files('virt.c'), fdt])
 
 hw_arch += {'openrisc': openrisc_ss}
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
new file mode 100644
index 0000000000..54f2732a6b
--- /dev/null
+++ b/hw/openrisc/virt.c
@@ -0,0 +1,417 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * OpenRISC QEMU virtual machine.
+ *
+ * (c) 2022 Stafford Horne <shorne@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "hw/irq.h"
+#include "hw/boards.h"
+#include "hw/char/serial.h"
+#include "hw/core/split-irq.h"
+#include "hw/openrisc/boot.h"
+#include "hw/misc/sifive_test.h"
+#include "hw/qdev-properties.h"
+#include "hw/rtc/goldfish_rtc.h"
+#include "hw/sysbus.h"
+#include "hw/virtio/virtio-mmio.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "sysemu/reset.h"
+
+#include <libfdt.h>
+
+#define VIRT_CPUS_MAX 4
+#define VIRT_CLK_MHZ 20000000
+
+#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define VIRT_MACHINE(obj) \
+    OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)
+
+typedef struct OR1KVirtState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    void *fdt;
+    int fdt_size;
+
+} OR1KVirtState;
+
+enum {
+    VIRT_DRAM,
+    VIRT_TEST,
+    VIRT_RTC,
+    VIRT_VIRTIO,
+    VIRT_UART,
+    VIRT_OMPIC,
+};
+
+enum {
+    VIRT_OMPIC_IRQ = 1,
+    VIRT_UART_IRQ = 2,
+    VIRT_RTC_IRQ = 3,
+    VIRT_VIRTIO_IRQ = 4, /* to 12 */
+    VIRTIO_COUNT = 8,
+};
+
+static const struct MemmapEntry {
+    hwaddr base;
+    hwaddr size;
+} virt_memmap[] = {
+    [VIRT_DRAM] =      { 0x00000000,          0 },
+    [VIRT_UART] =      { 0x90000000,      0x100 },
+    [VIRT_TEST] =      { 0x96000000,        0x8 },
+    [VIRT_RTC] =       { 0x96005000,     0x1000 },
+    [VIRT_VIRTIO] =    { 0x97000000,     0x1000 },
+    [VIRT_OMPIC] =     { 0x98000000, VIRT_CPUS_MAX * 8 },
+};
+
+static struct openrisc_boot_info {
+    uint32_t bootstrap_pc;
+    uint32_t fdt_addr;
+} boot_info;
+
+static void main_cpu_reset(void *opaque)
+{
+    OpenRISCCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+
+    cpu_reset(CPU(cpu));
+
+    cpu_set_pc(cs, boot_info.bootstrap_pc);
+    cpu_set_gpr(&cpu->env, 3, boot_info.fdt_addr);
+}
+
+static qemu_irq get_cpu_irq(OpenRISCCPU *cpus[], int cpunum, int irq_pin)
+{
+    return qdev_get_gpio_in_named(DEVICE(cpus[cpunum]), "IRQ", irq_pin);
+}
+
+static qemu_irq get_per_cpu_irq(OpenRISCCPU *cpus[], int num_cpus, int irq_pin)
+{
+    int i;
+
+    if (num_cpus > 1) {
+        DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
+        qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
+        qdev_realize_and_unref(splitter, NULL, &error_fatal);
+        for (i = 0; i < num_cpus; i++) {
+            qdev_connect_gpio_out(splitter, i, get_cpu_irq(cpus, i, irq_pin));
+        }
+        return qdev_get_gpio_in(splitter, 0);
+    } else {
+        return get_cpu_irq(cpus, 0, irq_pin);
+    }
+}
+
+static void openrisc_create_fdt(OR1KVirtState *state,
+                                const struct MemmapEntry *memmap,
+                                int num_cpus, uint64_t mem_size,
+                                const char *cmdline)
+{
+    void *fdt;
+    int cpu;
+    char *nodename;
+    int pic_ph;
+
+    fdt = state->fdt = create_device_tree(&state->fdt_size);
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "opencores,or1ksim");
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x1);
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x1);
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x1);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x1);
+
+    nodename = g_strdup_printf("/memory@%" HWADDR_PRIx,
+                               memmap[VIRT_DRAM].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+                           memmap[VIRT_DRAM].base, mem_size);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+    g_free(nodename);
+
+    qemu_fdt_add_subnode(fdt, "/cpus");
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+
+    for (cpu = 0; cpu < num_cpus; cpu++) {
+        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                                "opencores,or1200-rtlsvn481");
+        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
+        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+                              VIRT_CLK_MHZ);
+        g_free(nodename);
+    }
+
+    nodename = (char *)"/pic";
+    qemu_fdt_add_subnode(fdt, nodename);
+    pic_ph = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "opencores,or1k-pic-level");
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", pic_ph);
+
+    qemu_fdt_setprop_cell(fdt, "/", "interrupt-parent", pic_ph);
+
+    qemu_fdt_add_subnode(fdt, "/chosen");
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
+
+    /* Create aliases node for use by devices. */
+    qemu_fdt_add_subnode(fdt, "/aliases");
+}
+
+static void openrisc_virt_ompic_init(OR1KVirtState *state, hwaddr base,
+                                    hwaddr size, int num_cpus,
+                                    OpenRISCCPU *cpus[], int irq_pin)
+{
+    void *fdt = state->fdt;
+    DeviceState *dev;
+    SysBusDevice *s;
+    char *nodename;
+    int i;
+
+    dev = qdev_new("or1k-ompic");
+    qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
+
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    for (i = 0; i < num_cpus; i++) {
+        sysbus_connect_irq(s, i, get_cpu_irq(cpus, i, irq_pin));
+    }
+    sysbus_mmio_map(s, 0, base);
+
+    /* Add device tree node for ompic. */
+    nodename = g_strdup_printf("/ompic@%" HWADDR_PRIx, base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "openrisc,ompic");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", base, size);
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", irq_pin);
+    g_free(nodename);
+}
+
+static void openrisc_virt_serial_init(OR1KVirtState *state, hwaddr base,
+                                     hwaddr size, int num_cpus,
+                                     OpenRISCCPU *cpus[], int irq_pin)
+{
+    void *fdt = state->fdt;
+    char *nodename;
+    qemu_irq serial_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
+
+    serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
+                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    /* Add device tree node for serial. */
+    nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "ns16550a");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", base, size);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", irq_pin);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", VIRT_CLK_MHZ);
+    qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
+
+    /* The /chosen node is created during fdt creation. */
+    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    qemu_fdt_setprop_string(fdt, "/aliases", "uart0", nodename);
+    g_free(nodename);
+}
+
+static void openrisc_virt_test_init(OR1KVirtState *state, hwaddr base,
+                                   hwaddr size)
+{
+    void *fdt = state->fdt;
+    int test_ph;
+    char *nodename;
+
+    /* SiFive Test MMIO device */
+    sifive_test_create(base);
+
+    /* SiFive Test MMIO Reset device FDT */
+    nodename = g_strdup_printf("/soc/test@%" HWADDR_PRIx, base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon");
+    test_ph = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", base, size);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_ph);
+    qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/soc/reboot");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_ph);
+    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/soc/poweroff");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_ph);
+    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
+    g_free(nodename);
+
+}
+static void openrisc_virt_rtc_init(OR1KVirtState *state, hwaddr base,
+                                   hwaddr size, int num_cpus,
+                                   OpenRISCCPU *cpus[], int irq_pin)
+{
+    void *fdt = state->fdt;
+    char *nodename;
+    qemu_irq rtc_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
+
+    /* Goldfish RTC */
+    sysbus_create_simple(TYPE_GOLDFISH_RTC, base, rtc_irq);
+
+    /* Goldfish RTC FDT */
+    nodename = g_strdup_printf("/soc/rtc@%" HWADDR_PRIx, base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "google,goldfish-rtc");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", base, size);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", irq_pin);
+    g_free(nodename);
+
+}
+static void openrisc_virt_virtio_init(OR1KVirtState *state, hwaddr base,
+                                      hwaddr size, int num_cpus,
+                                      OpenRISCCPU *cpus[], int irq_pin)
+{
+    void *fdt = state->fdt;
+    char *nodename;
+    DeviceState *dev;
+    SysBusDevice *sysbus;
+    qemu_irq virtio_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
+
+    /* VirtIO MMIO devices */
+    dev = qdev_new(TYPE_VIRTIO_MMIO);
+    qdev_prop_set_bit(dev, "force-legacy", false);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_connect_irq(sysbus, 0, virtio_irq);
+    sysbus_mmio_map(sysbus, 0, base);
+
+    /* VirtIO MMIO devices FDT */
+    nodename = g_strdup_printf("/soc/virtio_mmio@%" HWADDR_PRIx, base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "virtio,mmio");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", base, size);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", irq_pin);
+    g_free(nodename);
+}
+
+static void openrisc_virt_init(MachineState *machine)
+{
+    ram_addr_t ram_size = machine->ram_size;
+    const char *kernel_filename = machine->kernel_filename;
+    OpenRISCCPU *cpus[VIRT_CPUS_MAX] = {};
+    OR1KVirtState *state = VIRT_MACHINE(machine);
+    MemoryRegion *ram;
+    hwaddr load_addr;
+    int n;
+    unsigned int smp_cpus = machine->smp.cpus;
+
+    assert(smp_cpus >= 1 && smp_cpus <= VIRT_CPUS_MAX);
+    for (n = 0; n < smp_cpus; n++) {
+        cpus[n] = OPENRISC_CPU(cpu_create(machine->cpu_type));
+        if (cpus[n] == NULL) {
+            fprintf(stderr, "Unable to find CPU definition!\n");
+            exit(1);
+        }
+
+        cpu_openrisc_clock_init(cpus[n]);
+
+        qemu_register_reset(main_cpu_reset, cpus[n]);
+    }
+
+    ram = g_malloc(sizeof(*ram));
+    memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0, ram);
+
+    openrisc_create_fdt(state, virt_memmap, smp_cpus, machine->ram_size,
+                        machine->kernel_cmdline);
+
+    if (smp_cpus > 1) {
+        openrisc_virt_ompic_init(state, virt_memmap[VIRT_OMPIC].base,
+                                 virt_memmap[VIRT_OMPIC].size,
+                                 smp_cpus, cpus, VIRT_OMPIC_IRQ);
+    }
+
+    openrisc_virt_serial_init(state, virt_memmap[VIRT_UART].base,
+                              virt_memmap[VIRT_UART].size,
+                              smp_cpus, cpus, VIRT_UART_IRQ);
+
+    openrisc_virt_test_init(state, virt_memmap[VIRT_TEST].base,
+                            virt_memmap[VIRT_TEST].size);
+
+    openrisc_virt_rtc_init(state, virt_memmap[VIRT_RTC].base,
+                           virt_memmap[VIRT_RTC].size, smp_cpus, cpus,
+                           VIRT_RTC_IRQ);
+
+    for (n = 0; n < VIRTIO_COUNT; n++) {
+        openrisc_virt_virtio_init(state, virt_memmap[VIRT_VIRTIO].base
+                                         + n * virt_memmap[VIRT_VIRTIO].size,
+                                  virt_memmap[VIRT_VIRTIO].size,
+                                  smp_cpus, cpus, VIRT_VIRTIO_IRQ + n);
+    }
+
+    load_addr = openrisc_load_kernel(ram_size, kernel_filename,
+                                     &boot_info.bootstrap_pc);
+    if (load_addr > 0) {
+        if (machine->initrd_filename) {
+            load_addr = openrisc_load_initrd(state->fdt,
+                                             machine->initrd_filename,
+                                             load_addr, machine->ram_size);
+        }
+        boot_info.fdt_addr = openrisc_load_fdt(state->fdt, load_addr,
+                                               machine->ram_size);
+    }
+}
+
+static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "or1k virtual machine";
+    mc->init = openrisc_virt_init;
+    mc->max_cpus = VIRT_CPUS_MAX;
+    mc->is_default = false;
+    mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
+}
+
+static const TypeInfo or1ksim_machine_typeinfo = {
+    .name       = TYPE_VIRT_MACHINE,
+    .parent     = TYPE_MACHINE,
+    .class_init = openrisc_virt_machine_init,
+    .instance_size = sizeof(OR1KVirtState),
+};
+
+static void or1ksim_machine_init_register_types(void)
+{
+    type_register_static(&or1ksim_machine_typeinfo);
+}
+
+type_init(or1ksim_machine_init_register_types)
-- 
2.37.1

