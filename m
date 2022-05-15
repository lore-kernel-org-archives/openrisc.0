Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE2C433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:14 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9530720D0C;
	Sun, 15 May 2022 14:42:13 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mail.librecores.org (Postfix) with ESMTPS id ECF39248F2
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:11 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id q4so11999880plr.11
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
 b=EYf+o3rbH2eW5IncWe6cMBP0B6uHWzKwOKWro70z/747jg3zJZyrOV142C6BB8aU3W
 1B6LNQX5Ih2MJuYXjGEgJ4kFwezLdm6OVmil8HLgZRheIjanZNG/TNasOLfaS1o1oyGT
 xSFdT/LV+t2WLsWc2ceBXUJWgoihZO1vgLtw7+qca4Y3EPMZU8RPT3ODmzy0H8sXtTpa
 jkzue1yPoAdd51LwBu0KkJ1gD3lkiPER3SFFKTmyxQT32kKz4f1P+rRP1Yh4hB3qoXBc
 a+BYtZo63lM9v8Mj6qZgGHlwblgIJ3xIcQ0oAbMcH1Njt4ox6d7VxBiQUFovUALOnoQs
 2znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
 b=qU2fe3tm4M0alWMuHPV9mXPmWxhJgQiyjexMQ15Oi5RY916YQJh+tCTWVfPZvSlyf7
 gtfvLKp2rQg237l7axj1TppfzB7D5qwgjf/050eoAW44u1hpnjbdVFa2O0W4xgrO/oew
 JqzWP7MSc5tO05VyEGDp5+WtfnMb3g7dGYXWHPN2y0IgEnIdSX5biPyjbSDmoJ+4RZQs
 p3ryv4V/4fHcPtkOjibYwyGmovq3r/lq4+/NDC+qhYHFRM5COQ6xzRK84of8qs+V4FYz
 Av5fh9jRqQ5+6Ul0nVze+5Cwrno0tyAwDqJcgfEGJtO6JQC4sv92pWFJTWbs36fuSSq2
 W8Kw==
X-Gm-Message-State: AOAM530PM0NCoW69HAX6LcSgYg5qBhZv00iOMZEudKx98PrsVOZGMy1O
 PlTEkceYUo9QqJyOr6PaKQk=
X-Google-Smtp-Source: ABdhPJzxBhwVV+BdYvtR01oKfFqfWOB27LkD5kc+uhejdXzN4Ws0fe09+84sGHS105erznma5LCd/Q==
X-Received: by 2002:a17:902:8487:b0:15f:b2c:435 with SMTP id
 c7-20020a170902848700b0015f0b2c0435mr13365405plo.33.1652618530476; 
 Sun, 15 May 2022 05:42:10 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902e94d00b0015e8d4eb208sm5054498pll.82.2022.05.15.05.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:09 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/13] openrisc: Add gcc machine instruction flag configuration
Date: Sun, 15 May 2022 21:41:46 +0900
Message-Id: <20220515124158.3167452-2-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

