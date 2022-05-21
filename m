Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F1C433EF
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 01:53:54 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 919212491B;
	Sat, 21 May 2022 03:53:53 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mail.librecores.org (Postfix) with ESMTPS id 9AD182412D
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 03:53:51 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id s14so8671608plk.8
 for <openrisc@lists.librecores.org>; Fri, 20 May 2022 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A9WAfYeuw2rM/x9RDm1gVc1LuP/yWR8j3Z6vMIFpmHE=;
 b=AEP0hwK7eENdujB43s0AppydtVZW8WoJ97TELyc6SbvsrUEE3OMviBxGDctnbSTa7m
 Vqj6z2y2mJjyte/ZWcrTBkuHCO3TMas5gqAPbhRMaBSNa8mUi597dM6ulffqHUTDELci
 1UM3CtQZM+O06orSWrLuGbUYnCIH9ePZWrDvfbI+IF2dIKp7uYARvvZG/pli2wFQsJu4
 k2DDVfr6KU7HdDE47gzawF4gsyVKVicIC+L1zCMqOj1Hv0BF2LZRZSVsOwa9vyucfa6j
 frXtEM+oi/dVPAUFVZ1LwHsglkv0o4QYnpR+AF+H+ZuP8x2tpEa+Jq/bKvrZho/8ZWhj
 MIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A9WAfYeuw2rM/x9RDm1gVc1LuP/yWR8j3Z6vMIFpmHE=;
 b=KJBQoUMOqcYtKz2AUOATJ3G+seh27MhueMAUrZC0GfwAgSzX04/7wDEL6tonkOkZ3P
 7j02L1bOWvykhulfOQw/3TxSPQlrwTFYStK8qnJ8kQ+NnZ02T6IWec9irlDYlckrJKEx
 eDvs4XSYnfAGXS4nYwC4l3Y1aQBgy/XEBQwFEgKlb/hMxoQsHh48uJIz7fDo3snjOmi7
 0U3MSpubMneotbverbKyS5/SQaUzLFh6FwPoYxEmHr4pRrhsjQwDFaiTkfwTAW+9vcov
 Mid3mxIlEPPT5IOv6oma4yZiBBlJfCT7dR+OPmZYylxJtldtQJHg8XnpZGv4ilgRvB0P
 UMVw==
X-Gm-Message-State: AOAM531fr5+V8K6K3rmD6Mi68eDAPHjnESDtKXasw2OqtwWTif7+pvGJ
 XwghvcJPN5hqa18EGgaj5g4=
X-Google-Smtp-Source: ABdhPJwYl1UI4zWLTkjd6jq9LfcEw83cmeNVHfA1KrzsYl8aFhrN6XVsEkKFo9Dxncisbmtie5hU5A==
X-Received: by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP id
 h1-20020a170902b94100b0014daf723f23mr12589600pls.6.1653098029956; 
 Fri, 20 May 2022 18:53:49 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902f78d00b0015e8d4eb242sm363598pln.140.2022.05.20.18.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 18:53:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] openrisc: Allow power off handler overriding
Date: Sat, 21 May 2022 10:53:21 +0900
Message-Id: <20220521015322.188707-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
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
Cc: Jonas Bonn <jonas@southpole.se>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Kees Cook <keescook@chromium.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Openrisc <openrisc@lists.librecores.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The OpenRISC platform always defines a default pm_power_off hanlder
which is only useful for simulators.  Having this set also means power
management drivers like syscon-power are not able to wire in their own
pm_power_off handlers.

Fix this by not setting the pm_power_off handler by default and fallback
to the simulator power off handler if no handler is set.

This has been tested with a new OpenRISC virt platform I am working on
for QEMU.

  https://github.com/stffrdhrn/qemu/commits/or1k-virt

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..1cca89a3b0c8 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -60,6 +60,16 @@ void machine_restart(char *cmd)
 	while (1);
 }
 
+/*
+ * This is used if pm_power_off has not been set by a power management
+ * driver, in this case we can assume we are on a simulator.  On
+ * OpenRISC simulators l.nop 1 will trigger the simulator exit.
+ */
+static void default_power_off(void)
+{
+	__asm__("l.nop 1");
+}
+
 /*
  * Similar to machine_power_off, but don't shut off power.  Add code
  * here to freeze the system for e.g. post-mortem debug purpose when
@@ -75,7 +85,10 @@ void machine_halt(void)
 void machine_power_off(void)
 {
 	printk(KERN_INFO "*** MACHINE POWER OFF ***\n");
-	__asm__("l.nop 1");
+	if (pm_power_off != NULL)
+		pm_power_off();
+	else
+		default_power_off();
 }
 
 /*
@@ -89,7 +102,7 @@ void arch_cpu_idle(void)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
 }
 
-void (*pm_power_off) (void) = machine_power_off;
+void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
 
 /*
-- 
2.31.1

