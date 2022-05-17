Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA07C433F5
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:32 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6430724960;
	Tue, 17 May 2022 02:55:31 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mail.librecores.org (Postfix) with ESMTPS id F15352495D
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:29 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 v5-20020a17090a7c0500b001df84fa82f8so557688pjf.5
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
 b=oBdS6oGKMONo6W7KiHyC44QKcc6QdwUE0uChA6qKnet4V/Bq5PQUYToWMMltiIqZn8
 D9HOEyqT1XBgJ9tUkWvKLZm4SX2kqk/hbHnlN2kPPDZl5K5OhQPRKGpNoPJoHMs/QKEZ
 zBwnjtGSpv3PebkKGv2D9mBORqNd2lBc1ZR3LeYtKES6PbSzRef0uOOOThSX4Z5QdagE
 mW0iMqK+L0ABtC1NS5Ni/EV+N3vPaUam8aprpyqFTTyBsG21fHhzN/jJWJyw1aRGjute
 SY3zAtmi8iiI9eKWKo9gyeEZxslBu/nRu2GxcEQDY38QEpleGsFUm8EO2DwjXAd2BvyH
 L/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
 b=lz8Auq4CaTsO4TnyuOM046h8ixXzUpDM97EUrQ4IKNS8Zz85MZo8LI4ebhxefx9E7B
 mHxrm+aGdlAAMLgacDCRf++GGLh5zN7S2B/psTMSiEid6adfg3iRmNli1r7+9otAbe0x
 2f3R/jEMaXpPkekC4L91sUieClRrCUUZtWrsy5W0TdLuLqVt+oHX66QrfTIDIuLepdtT
 T7uLEXH8eNDqO2zapi4917c5VLi9/XNt/UMpxOLzGe64A/fxFRFYIoAECHVNao8FlqAU
 ye9KTQQC+wD0LKtblrruYJHU6PhYUbgUXifRDGAv8HCKQ6y//0EXD70e9rkgJuJXqCyT
 jOqA==
X-Gm-Message-State: AOAM533tw8hb2irm4Cd9RuFJKTOcyF0OkCwhoSktsHXqUBOiKnpZDBK6
 mnpJSluDSFFhejhek/ppXbH+eF+f+G4=
X-Google-Smtp-Source: ABdhPJzricSwjwhsyYUriiO42PXB0BfxYRb3I3qa8uLhZwnsRNsV5LadGCU21WU8vjpqDMrKzBvETw==
X-Received: by 2002:a17:90b:3649:b0:1db:a201:5373 with SMTP id
 nh9-20020a17090b364900b001dba2015373mr22178032pjb.175.1652748928539; 
 Mon, 16 May 2022 17:55:28 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a628609000000b0050dc7628193sm7353806pfd.109.2022.05.16.17.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:27 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/13] openrisc: Add gcc machine instruction flag
 configuration
Date: Tue, 17 May 2022 09:54:58 +0900
Message-Id: <20220517005510.3500105-2-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

OpenRISC GCC supports flags to enable the backend to output instructions
if they are supported by a target processor.  This patch adds
configuration flags to enable configuring these flags to tune the kernel
for a particular CPU configuration.

In the future we could also enable all of these flags by default and
provide instruction emulation in the kernel to make these choices easier
for users but this is what we provide for now.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig  | 53 ++++++++++++++++++++++++++++++++++++++++++
 arch/openrisc/Makefile | 17 ++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 0d68adf6e02b..ea7eac20911a 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -114,6 +114,59 @@ config OPENRISC_HAVE_INST_DIV
 	default y
 	help
 	  Select this if your implementation has a hardware divide instruction
+
+config OPENRISC_HAVE_INST_CMOV
+	bool "Have instruction l.cmov for conditional move"
+	default y
+	help
+	  This config enables gcc to generate l.cmov instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.cmov conistional move instruction.
+
+	  Say N if you are unsure.
+
+config OPENRISC_HAVE_INST_ROR
+	bool "Have instruction l.ror for rotate right"
+	default y
+	help
+	  This config enables gcc to generate l.ror instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.ror rotate right instruction.
+
+	  Say N if you are unsure.
+
+config OPENRISC_HAVE_INST_RORI
+	bool "Have instruction l.rori for rotate right with immediate"
+	default y
+	help
+	  This config enables gcc to generate l.rori instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.rori rotate right with immediate instruction.
+
+	  Say N if you are unsure.
+
+config OPENRISC_HAVE_INST_SEXT
+	bool "Have instructions l.ext* for sign extension"
+	default y
+	help
+	  This config enables gcc to generate l.ext* instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.exths, l.extbs, l.exthz and l.extbz size extend instructions.
+
+	  Say N if you are unsure.
+
 endmenu
 
 config NR_CPUS
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 760b734fb822..b446510173cd 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -21,6 +21,7 @@ OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
 LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
+KBUILD_CFLAGS	+= -msfimm -mshftimm
 
 all: vmlinux.bin
 
@@ -38,6 +39,22 @@ else
 	KBUILD_CFLAGS += $(call cc-option,-msoft-div)
 endif
 
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_CMOV),y)
+	KBUILD_CFLAGS += $(call cc-option,-mcmov)
+endif
+
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_ROR),y)
+	KBUILD_CFLAGS += $(call cc-option,-mror)
+endif
+
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_RORI),y)
+	KBUILD_CFLAGS += $(call cc-option,-mrori)
+endif
+
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
+	KBUILD_CFLAGS += $(call cc-option,-msext)
+endif
+
 head-y 		:= arch/openrisc/kernel/head.o
 
 libs-y		+= $(LIBGCC)
-- 
2.31.1

