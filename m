Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6AC433FE
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:13:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 298D82412D;
	Sat, 21 May 2022 15:13:42 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mail.librecores.org (Postfix) with ESMTPS id 3FF842412D
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:13:40 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id h13so3594022pfq.5
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXO4BheuhYf/qtVPhrmMyquWayElWld6sjdR5X3gNkE=;
 b=l6xk/kluVQpMuwRXPybjDty5NMjYJs9gDfwu/kLMXMr4MTLCUzBVK+UTLB1/DhB6DT
 APVt63p0+SycjvMMyPyDkq4s7oLVc/7A5RqJTqFTJObilxMMKRNgXz3qULPIgfEJXJQH
 EXSKbjzznlfM9znHRhrHuCdh9jAZ+LkGcJ3+kLn+BToHzbqaK6hzlnUrHuNfs6iOY98+
 RdT14U64yKUa/kvIMQEMA62hJ5WAPU0q4aBSGKc2DmCw6Pdf2KLt21U9vkCctwPwBDpR
 E7jGahl1nzOzqnuqgqJCmBrEwhgvVWeZ0Mv9Da87b5eAWyT1KrSo4LZW5cTigR8P6eR2
 6kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXO4BheuhYf/qtVPhrmMyquWayElWld6sjdR5X3gNkE=;
 b=HRDPostFeRCa3bTOGD4unT3OuipLMs1fnEWt6+mX0+aL8sgTnMRFnCu9mJIrZi1JYL
 CVfnZyATbuf/Z5PZPiVu6VJ9UBcZMX1kTRZTOOnN7c3GCtOQtzyb/XkZRG7PUdA+YbVw
 4IfHNh3JvOFYkHc3/CmoQjYwnbK3GtP340rG5BZdDBKkRx9b38PfEK1UOXkwZGEQNWKo
 TPTyeiLBuAbne4BJOnjtuwqzp0MnYxA7h19YrO+x9zzn24F5TE25bXtJem58YXjDJpnm
 8M46KCU+dqRMsnTytE9x3fKOQHqgGq4yK3GwgSWJPkpe7rrbFZu24xNajxS5VJazZ1x7
 pKsg==
X-Gm-Message-State: AOAM532j1qvY+dw8tjbEQ8p+j1FGu1RlfnZuMN6FERQ1GTf31MayhI7D
 OVIqgWBjoWZF8dy4OYTpeYA=
X-Google-Smtp-Source: ABdhPJzbNA9d6fiiiDWRXIgbgBoWlld0RwTG6FoUevm82feThooClQUtFgklc9cPjFrLzTaW83B1Yw==
X-Received: by 2002:a63:4846:0:b0:3f2:5f88:e7ab with SMTP id
 x6-20020a634846000000b003f25f88e7abmr12944774pgk.2.1653138818691; 
 Sat, 21 May 2022 06:13:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 jb15-20020a170903258f00b0015e8d4eb256sm1564170plb.160.2022.05.21.06.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:13:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/13] openrisc: Add gcc machine instruction flag
 configuration
Date: Sat, 21 May 2022 22:13:11 +0900
Message-Id: <20220521131323.631209-2-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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
index 0d68adf6e02b..37243f023805 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -114,6 +114,59 @@ config OPENRISC_HAVE_INST_DIV
 	default y
 	help
 	  Select this if your implementation has a hardware divide instruction
+
+config OPENRISC_HAVE_INST_CMOV
+	bool "Have instruction l.cmov for conditional move"
+	default n
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
+	default n
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
+	default n
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
+	default n
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

