Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD9C433EF
	for <openrisc@archiver.kernel.org>; Mon, 25 Jul 2022 02:08:17 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 73E4320C6A;
	Mon, 25 Jul 2022 04:08:16 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mail.librecores.org (Postfix) with ESMTPS id E005520E49
 for <openrisc@lists.librecores.org>; Mon, 25 Jul 2022 04:08:14 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id d7so9117537plr.9
 for <openrisc@lists.librecores.org>; Sun, 24 Jul 2022 19:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2bb8XU1Bnk4jusD63lmk3Ol2o00AOfRxKRkmAkiDP4o=;
 b=fZIYHmc8N+T0x4kQRJbfoR40FVeWXHFoj1Ez9pMFcXxzgRhu2PqfTJX13WZ/W+RErc
 OPcB5PlL1q7UBLiBsWYp3lmlcvt9LTpbaSGcKj1OlF3D9EJ2VUaL0wG5GK4fm3QG6s3F
 CqsJ4rBlixoSyIwWe1Al7OeyD+ZwvQEXYZw1+eILqV8AEuRLuJ+TYwAvQon6qTm4+0Wu
 gWL3JwtDy4xRDqckeXp1Os7f93urL1kvSDpHRRwv7nzF1i1sITAxOcmqV6odWEh4z8OZ
 XhuLNTpmXovVM+mTrmFrG3WgCoM+U4Llhuo/N2j7RE1xvfb7kkfWmTc0wYInGzP5GKZs
 AqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2bb8XU1Bnk4jusD63lmk3Ol2o00AOfRxKRkmAkiDP4o=;
 b=dX1pgFBZeonmdFS+p7j2pOwagKHCQ9LAOTFizFTd2hgj4Hr1qdVFpWhwXBJaesIvqn
 2kG5e109xcCddf0F1/snxy4Jnvk69Z/39yZz83xnyWYPTFUtxpkdahZKp1iatXFJP+U5
 ZRWLXrulc0tH5vGJo7BsdDgM7v9sTikIL/8kUjCMMaljhIqrZA4XaFSna8q+w71PCXhB
 TWCJsxKEt+ZWqkwjP+gKExEnH6dLzp0Y1FCbUa5/COM54SChyxLeyT9+81mpaNdt/+AG
 YxaKZ0LWey/oH09OugppasDYydg3lTLTwFkt71q7s2eoMm4shMG0dLUf7nmIEiC0gs3r
 HNLg==
X-Gm-Message-State: AJIora8dBGJDBuWKYD+BbLZhX95pe8TJwqWCiDpfKyzxQ5dBMY421ZzP
 fEOOdGdrlHTNgXSbGzR0CyQ=
X-Google-Smtp-Source: AGRyM1vZnZRBfbk7P18DqP3O8ruzD393p79BGSWNpGSjB7sr0RoO7KDfhkFVa9m61iUpftGqgqdWYg==
X-Received: by 2002:a17:902:8a86:b0:16c:4292:9f56 with SMTP id
 p6-20020a1709028a8600b0016c42929f56mr10268982plo.36.1658714893200; 
 Sun, 24 Jul 2022 19:08:13 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a170902d51100b0016c50179b1esm1691376plg.152.2022.07.24.19.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Jul 2022 19:08:12 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] openrisc: Add pci bus support
Date: Mon, 25 Jul 2022 11:07:36 +0900
Message-Id: <20220725020737.1221739-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725020737.1221739-1-shorne@gmail.com>
References: <20220725020737.1221739-1-shorne@gmail.com>
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
 openrisc@lists.librecores.org, Bjorn Helgaas <helgaas@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This patch adds required definitions to allow for PCI buses on OpenRISC.
This is being tested on the OpenRISC QEMU virt platform which is in
development.

OpenRISC does not have IO ports so we keep the definition of
IO_SPACE_LIMIT and PIO_RESERVED to be 0.

Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
systems") all platforms that support PCI also need to support parallel
port.  We add a generic header to support compiling parallel port
drivers, though they generally will not work as they require IO ports.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig            | 5 ++++-
 arch/openrisc/include/asm/Kbuild | 1 +
 arch/openrisc/include/asm/io.h   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e814df4c483c..c7f282f60f64 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -20,8 +20,9 @@ config OPENRISC
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
-	select GENERIC_IOMAP
+	select GENERIC_PCI_IOMAP
 	select GENERIC_CPU_DEVICES
+	select HAVE_PCI
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -32,6 +33,8 @@ config OPENRISC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_MSI if PCI
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
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
 
-- 
2.36.1

