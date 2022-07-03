Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE9C433EF
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:29:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 15BBB247C4;
	Sun,  3 Jul 2022 23:29:01 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id 4D0BF248C5
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:28:59 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 i8-20020a17090a4b8800b001ef8a65bfbdso192597pjh.1
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jMcTDTg0aRUKV1Y2DsdmuAplqV4InraIpUWyolfTvv8=;
 b=Nq3yxSPmdJ40xn4aa+TRGgJBYGz4qORXGYsMDPZgqZHkMdVdE6bHzYS4TM2R5CiGAX
 L5NM8LJpQjGDiwMV0TtTOCZQETB44HBW1FGiDyBaHJTVEckUwM145avfuhnaUS3yzv7X
 r5Abfpgw31Pr0YhEh3XkFsfkNXV/1scaZq+WWVwF4yybiEQn3Wd2v3d7+DH9i/lTPKP3
 IAVrlS7V5ErRp205G622R9sUBfhYcP30ee2JRFhrNE3P+YPTO5IW2SHQ3p7mDyUnMarB
 /Xzp3rcVqPEVeJ8GTrL32G7wnDLMIJEta0ezd5wXHJS5CTMM2RIQ10XoCbzgH2YBK8Fo
 YwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jMcTDTg0aRUKV1Y2DsdmuAplqV4InraIpUWyolfTvv8=;
 b=ky8C4c3P7EI7qq0xadrRerB1zFwHC3m0/JZMOEF8xNnkYA9kRT2JeOhXOYwVmlric1
 3+macGnA/rA8EcABqEnLH53M8LB7GAvWhE+J7GwfUbKlnLcfZODg7kwgL8gKQHeaZgGn
 JEkppA7tzazOPZEeOwHcVRwsyGuTIztkjphYhsc2njy0p5rITJvOWVvmRFcSXR8Dtdq9
 ISVCuzFrZRjF9pr40taW1esgyL4ZPglL4elUOyQKsg9zUwuQ2lehyIaSvyjDAngM/H3Y
 KmYjM9tO7p0AElWXzS4zfWdI53e0OBB+RIF11OoQ2/+z+WF9XplNHtrekc21jcx4GB8i
 MZdA==
X-Gm-Message-State: AJIora+GtgqLJTo+8mgXb5B5bDE/Zx91f8df4te+Ih2yZONn5b3l+FHY
 zWZBTRQ7Xqhprdxmbe4PVrZTNL93frg=
X-Google-Smtp-Source: AGRyM1uhYR21NceN7CUs7znYM32kdHA0xeMszylzEHsfR0JRNwVXGF3k/kYg9eYH32F23LgI25pRlg==
X-Received: by 2002:a17:902:bd86:b0:16a:8464:6cb4 with SMTP id
 q6-20020a170902bd8600b0016a84646cb4mr32652346pls.92.1656883737688; 
 Sun, 03 Jul 2022 14:28:57 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a17090a718100b001ef87123615sm637501pjk.37.2022.07.03.14.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:28:57 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 05/11] hw/openrisc: Add PCI bus support to virt
Date: Mon,  4 Jul 2022 06:28:17 +0900
Message-Id: <20220703212823.10067-6-shorne@gmail.com>
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

This is mostly borrowed from xtensa and riscv as examples.  The
create_pcie_irq_map swizzle function is almost and exact copy
but here we use a single cell interrupt, possibly we can make
this generic.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/Kconfig |   3 +
 hw/openrisc/virt.c  | 160 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 202134668e..97af258b55 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -7,8 +7,11 @@ config OR1K_SIM
 
 config OR1K_VIRT
     bool
+    imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
+    select PCI
+    select PCI_EXPRESS_GENERIC_BRIDGE
     select GOLDFISH_RTC
     select SERIAL
     select SIFIVE_TEST
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index bdb00f6e32..f1d1293eeb 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -17,6 +17,8 @@
 #include "hw/core/split-irq.h"
 #include "hw/openrisc/boot.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/rtc/goldfish_rtc.h"
 #include "hw/sysbus.h"
@@ -47,6 +49,9 @@ typedef struct OR1KVirtState {
 
 enum {
     VIRT_DRAM,
+    VIRT_ECAM,
+    VIRT_MMIO,
+    VIRT_PIO,
     VIRT_TEST,
     VIRT_RTC,
     VIRT_VIRTIO,
@@ -60,6 +65,7 @@ enum {
     VIRT_RTC_IRQ = 3,
     VIRT_VIRTIO_IRQ = 4, /* to 12 */
     VIRTIO_COUNT = 8,
+    VIRT_PCI_IRQ_BASE = 13, /* to 17 */
 };
 
 static const struct MemmapEntry {
@@ -72,6 +78,9 @@ static const struct MemmapEntry {
     [VIRT_RTC] =       { 0x96005000,     0x1000 },
     [VIRT_VIRTIO] =    { 0x97000000,     0x1000 },
     [VIRT_OMPIC] =     { 0x98000000, VIRT_CPUS_MAX * 8 },
+    [VIRT_ECAM] =      { 0x9e000000,  0x1000000 },
+    [VIRT_PIO] =       { 0x9f000000,  0x1000000 },
+    [VIRT_MMIO] =      { 0xa0000000, 0x10000000 },
 };
 
 static struct openrisc_boot_info {
@@ -115,12 +124,12 @@ static qemu_irq get_per_cpu_irq(OpenRISCCPU *cpus[], int num_cpus, int irq_pin)
 static void openrisc_create_fdt(OR1KVirtState *state,
                                 const struct MemmapEntry *memmap,
                                 int num_cpus, uint64_t mem_size,
-                                const char *cmdline)
+                                const char *cmdline,
+                                int32_t *pic_phandle)
 {
     void *fdt;
     int cpu;
     char *nodename;
-    int pic_ph;
 
     fdt = state->fdt = create_device_tree(&state->fdt_size);
     if (!fdt) {
@@ -163,14 +172,14 @@ static void openrisc_create_fdt(OR1KVirtState *state,
 
     nodename = (char *)"/pic";
     qemu_fdt_add_subnode(fdt, nodename);
-    pic_ph = qemu_fdt_alloc_phandle(fdt);
+    *pic_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_setprop_string(fdt, nodename, "compatible",
                             "opencores,or1k-pic-level");
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", pic_ph);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", *pic_phandle);
 
-    qemu_fdt_setprop_cell(fdt, "/", "interrupt-parent", pic_ph);
+    qemu_fdt_setprop_cell(fdt, "/", "interrupt-parent", *pic_phandle);
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     if (cmdline) {
@@ -275,6 +284,7 @@ static void openrisc_virt_test_init(OR1KVirtState *state, hwaddr base,
     g_free(nodename);
 
 }
+
 static void openrisc_virt_rtc_init(OR1KVirtState *state, hwaddr base,
                                    hwaddr size, int num_cpus,
                                    OpenRISCCPU *cpus[], int irq_pin)
@@ -303,6 +313,134 @@ static void openrisc_virt_rtc_init(OR1KVirtState *state, hwaddr base,
     g_free(nodename);
 
 }
+
+static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
+                                uint32_t irqchip_phandle)
+{
+    int pin, dev;
+    uint32_t irq_map_stride = 0;
+    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS * 6] = {};
+    uint32_t *irq_map = full_irq_map;
+
+    /*
+     * This code creates a standard swizzle of interrupts such that
+     * each device's first interrupt is based on it's PCI_SLOT number.
+     * (See pci_swizzle_map_irq_fn())
+     *
+     * We only need one entry per interrupt in the table (not one per
+     * possible slot) seeing the interrupt-map-mask will allow the table
+     * to wrap to any number of devices.
+     */
+    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
+        int devfn = dev << 3;
+
+        for (pin = 0; pin < GPEX_NUM_IRQS; pin++) {
+            int irq_nr = irq_base + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
+            int i = 0;
+
+            /* Fill PCI address cells */
+            irq_map[i++] = cpu_to_be32(devfn << 8);
+            irq_map[i++] = 0;
+            irq_map[i++] = 0;
+
+            /* Fill PCI Interrupt cells */
+            irq_map[i++] = cpu_to_be32(pin + 1);
+
+            /* Fill interrupt controller phandle and cells */
+            irq_map[i++] = cpu_to_be32(irqchip_phandle);
+            irq_map[i++] = cpu_to_be32(irq_nr);
+
+            if (!irq_map_stride) {
+                irq_map_stride = i;
+            }
+            irq_map += irq_map_stride;
+        }
+    }
+
+    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
+                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
+                     irq_map_stride * sizeof(uint32_t));
+
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
+                           0x1800, 0, 0, 0x7);
+}
+
+static void openrisc_virt_pcie_init(OR1KVirtState *state,
+                                    hwaddr ecam_base, hwaddr ecam_size,
+                                    hwaddr pio_base, hwaddr pio_size,
+                                    hwaddr mmio_base, hwaddr mmio_size,
+                                    int num_cpus, OpenRISCCPU *cpus[],
+                                    int irq_base, int32_t pic_phandle)
+{
+    void *fdt = state->fdt;
+    char *nodename;
+    MemoryRegion *alias;
+    MemoryRegion *reg;
+    DeviceState *dev;
+    qemu_irq pcie_irq;
+    int i;
+
+    dev = qdev_new(TYPE_GPEX_HOST);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    /* Map ECAM space. */
+    alias = g_new0(MemoryRegion, 1);
+    reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(alias, OBJECT(dev), "pcie-ecam",
+                             reg, 0, ecam_size);
+    memory_region_add_subregion(get_system_memory(), ecam_base, alias);
+
+    /*
+     * Map the MMIO window into system address space so as to expose
+     * the section of PCI MMIO space which starts at the same base address
+     * (ie 1:1 mapping for that part of PCI MMIO space visible through
+     * the window).
+     */
+    alias = g_new0(MemoryRegion, 1);
+    reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(alias, OBJECT(dev), "pcie-mmio",
+                             reg, mmio_base, mmio_size);
+    memory_region_add_subregion(get_system_memory(), mmio_base, alias);
+
+    /* Map IO port space. */
+    alias = g_new0(MemoryRegion, 1);
+    reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2);
+    memory_region_init_alias(alias, OBJECT(dev), "pcie-pio",
+                             reg, 0, pio_size);
+    memory_region_add_subregion(get_system_memory(), pio_base, alias);
+
+    /* Connect IRQ lines. */
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        pcie_irq = get_per_cpu_irq(cpus, num_cpus, irq_base + i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pcie_irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, irq_base + i);
+    }
+
+    nodename = g_strdup_printf("/soc/pci@%" HWADDR_PRIx, ecam_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 3);
+    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
+    qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
+                           ecam_size / PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", ecam_base, ecam_size);
+    /* pci-address(3) cpu-address(1) pci-size(2) */
+    qemu_fdt_setprop_cells(fdt, nodename, "ranges",
+                           FDT_PCI_RANGE_IOPORT, 0, 0,
+                           pio_base, 0, pio_size,
+                           FDT_PCI_RANGE_MMIO, 0, mmio_base,
+                           mmio_base, 0, mmio_size);
+
+    create_pcie_irq_map(fdt, nodename, irq_base, pic_phandle);
+    g_free(nodename);
+}
+
 static void openrisc_virt_virtio_init(OR1KVirtState *state, hwaddr base,
                                       hwaddr size, int num_cpus,
                                       OpenRISCCPU *cpus[], int irq_pin)
@@ -340,6 +478,7 @@ static void openrisc_virt_init(MachineState *machine)
     hwaddr load_addr;
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
+    int32_t pic_phandle;
 
     assert(smp_cpus >= 1 && smp_cpus <= VIRT_CPUS_MAX);
     for (n = 0; n < smp_cpus; n++) {
@@ -359,7 +498,7 @@ static void openrisc_virt_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     openrisc_create_fdt(state, virt_memmap, smp_cpus, machine->ram_size,
-                        machine->kernel_cmdline);
+                        machine->kernel_cmdline, &pic_phandle);
 
     if (smp_cpus > 1) {
         openrisc_virt_ompic_init(state, virt_memmap[VIRT_OMPIC].base,
@@ -378,6 +517,15 @@ static void openrisc_virt_init(MachineState *machine)
                            virt_memmap[VIRT_RTC].size, smp_cpus, cpus,
                            VIRT_RTC_IRQ);
 
+    openrisc_virt_pcie_init(state, virt_memmap[VIRT_ECAM].base,
+                            virt_memmap[VIRT_ECAM].size,
+                            virt_memmap[VIRT_PIO].base,
+                            virt_memmap[VIRT_PIO].size,
+                            virt_memmap[VIRT_MMIO].base,
+                            virt_memmap[VIRT_MMIO].size,
+                            smp_cpus, cpus,
+                            VIRT_PCI_IRQ_BASE, pic_phandle);
+
     for (n = 0; n < VIRTIO_COUNT; n++) {
         openrisc_virt_virtio_init(state, virt_memmap[VIRT_VIRTIO].base
                                          + n * virt_memmap[VIRT_VIRTIO].size,
-- 
2.36.1

