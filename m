Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A507FEE49A8;
	Sat, 19 Aug 2023 07:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbjHSHqL (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sat, 19 Aug 2023 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbjHSHpz (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sat, 19 Aug 2023 03:45:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F210D7
        for <linux-openrisc@vger.kernel.org>; Sat, 19 Aug 2023 00:45:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so904267f8f.2
        for <linux-openrisc@vger.kernel.org>; Sat, 19 Aug 2023 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692431151; x=1693035951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqwRpuN9OjtoW+N1a/du/STnGvvajKaIuwHbsoDvEOk=;
        b=eMyilGfReK88AMx1hKk+CW+k0cRXcGpr7tx2UoPsn/RXtFWFldJvKiE7ttIxW2gAHN
         dpPBpTgD3n4L6GErBWgDvgGXlrHjpjZO39mueVjv+WZmCiI7PCF/0yMz+uMbqjTAkSN4
         yCqjZSR8G03pgIA6T62NZJ3sX6QACzsGC7nHimfX1/C+YQORzUTAk80ZNnoSlEnU0GCi
         9wJlm2K3fS0nZkvbNoXnl51rmRN9zF29Ozeo8uVucpHkm9v9LJ9Ub6fAVY7Xg+ZBt8M5
         A2qYDF481uSUo84B49sGrCisRkYxADEUhbXOuUMHb+fj0FL51zb3ztAqh8cU4xZEnnv+
         FMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692431151; x=1693035951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqwRpuN9OjtoW+N1a/du/STnGvvajKaIuwHbsoDvEOk=;
        b=Cc1atTBc8hgiTsMpGYwngw0qyxMatDxuiVcmiiZd6I9kJ7YMKMrKMLEx1VkZwXp0fV
         xXT0u/bmgM+FscdFgrtyaYppuPpAyploYypiRDrTDC0oyQk7KgueMCNzEI+37Yz/PZNW
         V5NgZlWeZp3M1BofRrFXpcQ8aPX8gu1NqgMatLh53tLQsENJ9FKPzMLQLZprTj8rhlKQ
         cE9wAfrrHAqP3Xh2nprbaKWyYGVLnKRsWl+rXzojjosrKcUWoWTBem7awenteYS7UKy5
         VSZChG3zsELcPT9knM6Ggbidm3eaLozRdPOIV3yjr/iTwl32eM5dGHyvQBKRNjSpvKmw
         m2rA==
X-Gm-Message-State: AOJu0YxuDAXsHeUDvjEZYX1WNAf+JZIjSlrrBbepFx5YaDDrJ/BrnO/L
        NCH22C8PKH/UrUQ/5VedSKZrekGS8PxKIQ==
X-Google-Smtp-Source: AGHT+IGaUyF05wbDySY8Z7WTUZoff2+XjuMdQbzsq2fttAyxmZ58HnEiSu2n7gfXuUcS24wPaZvTRA==
X-Received: by 2002:a5d:6103:0:b0:317:53e7:d7c2 with SMTP id v3-20020a5d6103000000b0031753e7d7c2mr985226wrt.11.1692431151248;
        Sat, 19 Aug 2023 00:45:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm5267536wrp.39.2023.08.19.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 00:45:50 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     GNU Binutils <binutils@sourceware.org>
Cc:     Mike Frysinger <vapier@gentoo.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH] sim: or1k: Eliminate dangerous RWX load segments
Date:   Sat, 19 Aug 2023 08:45:18 +0100
Message-Id: <20230819074518.2253226-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

This fixes test failures caused by the new linker warning which report:

  ./ld/ld-new: warning: load.S.x has a LOAD segment with RWX permissions

Fix this by splitting the linker MEMORY into ram and rom to avoid
generating RWX sections.  This required tests to be adjusted to fix
issues with the move.  Namely:

  - fpu tests: were incorrectly using l.ori with ha(anchor) which now
    that we pushed the anchor up in memory it exposes the bug.  Update
    to used the correct l.movhi instruction instead.
  - adrp test: the test reports ram offset addresses, now that we have
    moved memory layout around a bit I adjusted the test output.  Some
    padding is added before pi to show that the actual address of pi and
    the adrp page offset are not the same.

Bug: https://sourceware.org/PR29957
---
 sim/testsuite/or1k/adrp.S               | 5 +++--
 sim/testsuite/or1k/fpu-unordered.S      | 2 +-
 sim/testsuite/or1k/fpu64a32-unordered.S | 2 +-
 sim/testsuite/or1k/fpu64a32.S           | 2 +-
 sim/testsuite/or1k/or1k-test.ld         | 7 ++++---
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sim/testsuite/or1k/adrp.S b/sim/testsuite/or1k/adrp.S
index eaddcb03885..192324c698e 100644
--- a/sim/testsuite/or1k/adrp.S
+++ b/sim/testsuite/or1k/adrp.S
@@ -17,9 +17,9 @@
 
 # mach: or1k
 # output: report(0x00002064);\n
-# output: report(0x00012138);\n
+# output: report(0x0001a008);\n
 # output: report(0x00002000);\n
-# output: report(0x00012000);\n
+# output: report(0x0001a000);\n
 # output: report(0x00002000);\n
 # output: report(0x00014000);\n
 # output: report(0x00000000);\n
@@ -32,6 +32,7 @@
 	.section .data
 	.org 0x10000
 	.align 4
+pad:	.quad 	0
 	.type   pi, @object
 	.size   pi, 4
 pi:
diff --git a/sim/testsuite/or1k/fpu-unordered.S b/sim/testsuite/or1k/fpu-unordered.S
index 624aa0fe05d..a89172e37af 100644
--- a/sim/testsuite/or1k/fpu-unordered.S
+++ b/sim/testsuite/or1k/fpu-unordered.S
@@ -57,7 +57,7 @@ start_tests:
 	 *  r13  e   as float
 	 *  r16  nan as float
 	 */
-	l.ori	r11, r0, ha(anchor)
+	l.movhi	r11, ha(anchor)
 	l.addi	r11, r11, lo(anchor)
 	l.lwz	r12, 0(r11)
 
diff --git a/sim/testsuite/or1k/fpu64a32-unordered.S b/sim/testsuite/or1k/fpu64a32-unordered.S
index e0ae6e770d1..51d915e4e75 100644
--- a/sim/testsuite/or1k/fpu64a32-unordered.S
+++ b/sim/testsuite/or1k/fpu64a32-unordered.S
@@ -58,7 +58,7 @@ start_tests:
 	 *  r14,r15  e   as double
 	 *  r16,r17  nan as double
 	 */
-	l.ori	r11, r0, ha(anchor)
+	l.movhi	r11, ha(anchor)
 	l.addi	r11, r11, lo(anchor)
 	l.lwz	r12, 0(r11)
 	l.lwz	r13, 4(r11)
diff --git a/sim/testsuite/or1k/fpu64a32.S b/sim/testsuite/or1k/fpu64a32.S
index 71b72b7761c..6ea60b28cf2 100644
--- a/sim/testsuite/or1k/fpu64a32.S
+++ b/sim/testsuite/or1k/fpu64a32.S
@@ -98,7 +98,7 @@ start_tests:
 	 *  r14,r15  e  as double
 	 *  r16,r17  a long long
 	 */
-	l.ori	r11, r0, ha(anchor)
+	l.movhi	r11, ha(anchor)
 	l.addi	r11, r11, lo(anchor)
 	l.lwz	r12, 0(r11)
 	l.lwz	r13, 4(r11)
diff --git a/sim/testsuite/or1k/or1k-test.ld b/sim/testsuite/or1k/or1k-test.ld
index f1535daeabd..c26ecaf3f23 100644
--- a/sim/testsuite/or1k/or1k-test.ld
+++ b/sim/testsuite/or1k/or1k-test.ld
@@ -20,8 +20,9 @@ MEMORY
     /* The exception vectors actually start at 0x100, but if you specify
        that address here, the "--output-target binary" step will start from
        address 0 with the contents meant for address 0x100.  */
-    exception_vectors : ORIGIN =  0 , LENGTH = 8K
-    ram               : ORIGIN =  8K, LENGTH = 2M - 8K
+    exception_vectors : ORIGIN =  0 , LENGTH =  8K
+    rom               : ORIGIN =  8K, LENGTH = 40K
+    ram               : ORIGIN = 40K, LENGTH =  2M - 40K
 }
 
 SECTIONS
@@ -37,7 +38,7 @@ SECTIONS
 	*(.text.*)
 	*(.rodata)
 	*(.rodata.*)
-    } > ram
+    } > rom
 
     .data :
     {
-- 
2.39.1

