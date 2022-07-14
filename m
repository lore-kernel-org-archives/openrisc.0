Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF38C43334
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:27:53 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 773D424914;
	Thu, 14 Jul 2022 06:27:52 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mail.librecores.org (Postfix) with ESMTPS id 42131248B4
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:27:51 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 z12-20020a17090a7b8c00b001ef84000b8bso7109515pjc.1
 for <openrisc@lists.librecores.org>; Wed, 13 Jul 2022 21:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1ANa/UfBZBIYOUOOK5aYse1VM4y5RCfZnupJabCiODk=;
 b=XyXet3y8zlu/z59ZUtVcN/LAQQMb4P3DKAdKdThaPQeHyy5vulQIu2gfwRzAn7RkEu
 2lZ8kRNJ+ZpPwkUmYL8qYzJum+5/VYHRnXL8FHQoSEi5zI3v3H7sUn/pcX6mk25sHmaf
 C9kletF+w3P5LhJmWiJrfc4/HYoetV91307ferO9mbnOmbgMUdDnfZQA5F/QxJlqduKJ
 ieEgyKCNexFqoQQ3Zbl6qWDJZq1wHxAme79mdKyNA8LycVz9E4LckfmDB05lnFgHwTYs
 pfpNj3Y7BTkqJy2wkceCOL9HOXr7ICJRQvhaBNrIzaS1E+5dauDwo290aefyausoMcno
 79xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1ANa/UfBZBIYOUOOK5aYse1VM4y5RCfZnupJabCiODk=;
 b=NQd1C2xjL+L/2jLZEfgSynC64ygtsbyy89AdC9xa3fl0712f1M5esszyPlzqAERRqR
 SF/qWMn/gUOidvykU1CLOdnC8vqVPvCk1RuKyEl8kDq9NAB+NBKcv1wCShKG4mENimhu
 A79UAhcecQ/gH6d3pwrgAj95bZWS73MlgiER2IyuYhN9uGA58ZBwd5SCuF/y6iGHSCCU
 wCXDL9iMrUh36O6tzMxhm7/ziENETFteV4yPpkLmePcWuB4K4W7G7SomEZquubiIRKoH
 azUb8gg0dkJAU3fHrjY6GneY+1+TOx4zbYiF3elSRIU5OpRStYUAeYMsGsHVNeiGPadA
 VVHg==
X-Gm-Message-State: AJIora8chbQ3wovPOVnRePWF/WV7hRF3rj1Z6jqgVCAk39uWpsztX+9P
 q1xFsfeBbahY2/EYNglK1Dg=
X-Google-Smtp-Source: AGRyM1u0MtU6yGx0/BvbIR9/NQQXwtZOS3pQyNLQZrmd5yAt3jnVf7rEUQEGRqrBlIN8HJOwU/KqVA==
X-Received: by 2002:a17:90b:30c4:b0:1ef:8d1b:f9bf with SMTP id
 hi4-20020a17090b30c400b001ef8d1bf9bfmr7637317pjb.158.1657772869879; 
 Wed, 13 Jul 2022 21:27:49 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a1709027c0700b0016cae5f04e6sm284395pll.135.2022.07.13.21.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 21:27:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] openrisc: Add pci bus support
Date: Thu, 14 Jul 2022 13:27:34 +0900
Message-Id: <20220714042736.2133067-2-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714042736.2133067-1-shorne@gmail.com>
References: <20220714042736.2133067-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This patch adds required definitions to allow for PCI buses on OpenRISC.
This is being in the QEMU virt platform.

OpenRISC does not have IO ports so this defines PCI IO to be allowed in
any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
MMIO for all IO.

Also, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
systems") all platforms that support PCI also need to support parallel
port.  We add a generic header to support parallel port drivers.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Revert definition of IO_SPACE_LIMIT

 arch/openrisc/Kconfig            |  7 ++++---
 arch/openrisc/include/asm/Kbuild |  1 +
 arch/openrisc/include/asm/io.h   |  2 +-
 arch/openrisc/include/asm/pci.h  | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)
 create mode 100644 arch/openrisc/include/asm/pci.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e814df4c483c..327241988819 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,7 +21,9 @@ config OPENRISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IOMAP
+	select GENERIC_PCI_IOMAP
 	select GENERIC_CPU_DEVICES
+	select HAVE_PCI
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -32,6 +34,8 @@ config OPENRISC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_MSI if PCI
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
@@ -46,9 +50,6 @@ config MMU
 config GENERIC_HWEIGHT
 	def_bool y
 
-config NO_IOPORT_MAP
-	def_bool y
-
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 3386b9c1c073..c8c99b554ca4 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
+generic-y += parport.h
 generic-y += spinlock_types.h
 generic-y += spinlock.h
 generic-y += qrwlock_types.h
diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index c298061c70a7..625ac6ad1205 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 /*
- * PCI: can we really do 0 here if we have no port IO?
+ * PCI: We do not use IO ports in OpenRISC
  */
 #define IO_SPACE_LIMIT		0
 
diff --git a/arch/openrisc/include/asm/pci.h b/arch/openrisc/include/asm/pci.h
new file mode 100644
index 000000000000..e0865d2f3f42
--- /dev/null
+++ b/arch/openrisc/include/asm/pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_OPENRISC_PCI_H
+#define __ASM_OPENRISC_PCI_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+
+#define PCIBIOS_MIN_IO		0
+#define PCIBIOS_MIN_MEM		0
+
+/* OpenRISC bootloaders do not initialize PCI bus */
+#define pcibios_assign_all_busses() 1
+
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
+
+extern int isa_dma_bridge_buggy;
+
+#ifdef CONFIG_PCI
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQs on or1k */
+	return -ENODEV;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+#endif /* CONFIG_PCI */
+
+#endif /* __ASM_OPENRISC_PCI_H */
-- 
2.36.1

