Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23908C433EF
	for <openrisc@archiver.kernel.org>; Sat,  9 Jul 2022 21:16:41 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2F97722126;
	Sat,  9 Jul 2022 23:16:40 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mail.librecores.org (Postfix) with ESMTPS id 1E55F21052
 for <openrisc@lists.librecores.org>; Sat,  9 Jul 2022 23:16:39 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id m2so1523305plx.3
 for <openrisc@lists.librecores.org>; Sat, 09 Jul 2022 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQshL0ubFsAEbwRRKdyb/1irD0i2pVbsxkak9vbWWbY=;
 b=SnupiACxDcbgC4he6qEmIxmTiXTIyYFXzA2H78F6apwE+otf5xOSO286+uayTPVeK0
 Uw1Gt7z4oygriZ2NRt+ryvI5lG0SfhSYOn0KKQs03n1AW4/345VMVQMRbiHtM+8SHGaq
 W2/oKSlVYOqEutjgIgvFg/V0VePDp7Pejv35si78CYq/6vQt5fn5c/N4rdjEeLzTBp2A
 RwB6Cmxm+E7cKFsusukgN8MZyNX462Dp41J//qJZwoCR5axJqJX4lza4lQp49iZFLoN+
 9C19p06utAjlW/7EiGmAXXH3WaROPGRiGk3KCeTclm+ULdRj83MFDI7H1nkYSzDQC0/8
 8Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQshL0ubFsAEbwRRKdyb/1irD0i2pVbsxkak9vbWWbY=;
 b=XgWrFmcm26b5AyJe93Z+Emx9LAhREl6+NCP5Klvhs379iy2XSfPbEO1Qx+VGqMfYzF
 wvyRnilS77KmZa1zUs8ZkeI9htb957F1Yd5unyD3XwD73f7EEijUFMeJ49kAeJZ+5LkE
 FkWJf8vrytzCZ8x1wJnH2xjOJ2MCT0Y5+/675rYJ5olZIwNvVlL0hwByUOJL/ZHr9e1N
 2hcaHFIwgWw0uUEuHSBrWsUodCYvf7CSwkm0Lpo5BhhOGN7aAtU6+xpFa89ylepvel3i
 oHP76E0Ebt17XytU+E8NuN4HIvWS61/LHuybQNdqpEQI8bHpzDFxxNyK6B2yOcfwYNB5
 NWGQ==
X-Gm-Message-State: AJIora+87pG8HHtNxOt7rf1KILmENk8U2vVAjxjUCN9J4MmAjJ4UTtpE
 d7jssdva+vkC5TyQ+SSD64w=
X-Google-Smtp-Source: AGRyM1vutUmBGnmHcsHSxZEBr06j2+o2lupBHft00wHXPbFp+f4V20AekDvnXrpyAVn9+jM3naCdeQ==
X-Received: by 2002:a17:90b:3e86:b0:1ec:f7e8:e4e4 with SMTP id
 rj6-20020a17090b3e8600b001ecf7e8e4e4mr8159795pjb.218.1657401397764; 
 Sat, 09 Jul 2022 14:16:37 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 x127-20020a626385000000b0052512fdaa43sm1876822pfb.163.2022.07.09.14.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Jul 2022 14:16:37 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] openrisc: Add pci bus support
Date: Sun, 10 Jul 2022 06:15:48 +0900
Message-Id: <20220709211549.1163327-2-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709211549.1163327-1-shorne@gmail.com>
References: <20220709211549.1163327-1-shorne@gmail.com>
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
 arch/openrisc/Kconfig            |  7 ++++---
 arch/openrisc/include/asm/Kbuild |  1 +
 arch/openrisc/include/asm/io.h   |  4 ++--
 arch/openrisc/include/asm/pci.h  | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 5 deletions(-)
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
index c298061c70a7..1595aa69d96d 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -17,9 +17,9 @@
 #include <linux/types.h>
 
 /*
- * PCI: can we really do 0 here if we have no port IO?
+ * PCI: All address space can be used for IO
  */
-#define IO_SPACE_LIMIT		0
+#define IO_SPACE_LIMIT ~(0UL)
 
 /* OpenRISC has no port IO */
 #define HAVE_ARCH_PIO_SIZE	1
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

