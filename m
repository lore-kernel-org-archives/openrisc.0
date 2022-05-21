Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B645FC433F5
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:11 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id ED1D82492F;
	Sat, 21 May 2022 15:14:10 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mail.librecores.org (Postfix) with ESMTPS id 769F124960
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:14:09 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id c2so9432057plh.2
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
 b=DXSLnl6bzRiqQd9B3yCFb3QN0I29DuZvmyvMOt1C5IzPBsMZujmBjjyjiPXn8dM5Mi
 1EI6K4reqiBhLCza62OYrJa3ud9LTNNkk1lz32pXboLjnSv9jja0+LzxK8QgXWcXidAL
 JUi/BgVHD1aLJfk6SrAZans9hpJJaDzzW4PwoCNXGGJxW3Fl7Guwjot7Kfi1ws4O8UB/
 TfYKuiNdoCEO6UmA0QqO8qghU9qoscOe0g+tEcxinZ5zkle3SWuNXXlUqaEudsZ+q8mS
 AckGqF8C890g19t7+O78uuwQig6Pj3bmEq4dmoKbNDK9GfOvCVYN0pn9Jt0kRQPsNTEQ
 EIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
 b=lmMa3MHzn00pRdWUvmF2oB8OJXG+GbfiG1kgGK+qP8yxhnBRGQeWaBtcqJBf15NMOq
 B66b6Y/pxPCqMx40kS65F3jtJ/YkQQWk8yO+RPd9Cilh+SoIYTcz/Dh+/ESDT9bSNUfX
 Xx7nqBqhgxfPUt7ZXWt6v+kN+5O4Ut520NI0ZI2n9bdmYe8E9k+dz25AZy+/uTxMqfow
 2BNgTethXGeYqUvuGb4xYPZOT/5jkVfvCNjzw8c7tATy9UYXYhBeps1jVg+LQ4fqKiit
 WAjEkVWLOFh4QIv9J2l91+iWT2Z5Ds5iuZd45GS9QKdsZo1dUNeepHsihVwdVjWPflrQ
 4Cew==
X-Gm-Message-State: AOAM531JlsX8IcgUm0d+wpp6WwhfADSTeekR/W3rEuUsZoWjy5wk7rgY
 SbLpO4iawS0A+QDcHGexRJOvjCeNBiJvww==
X-Google-Smtp-Source: ABdhPJzRR6zf4/aFz4vGSyRfNAJ3VFLw0FA+iXux+gNdzSOHEVGhZYeu9Oa58IX6yFdO8P/mN1weHQ==
X-Received: by 2002:a17:902:ea53:b0:15b:1bb8:ac9e with SMTP id
 r19-20020a170902ea5300b0015b1bb8ac9emr14147213plg.45.1653138848062; 
 Sat, 21 May 2022 06:14:08 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170903019100b00161c3fc7a44sm1581665plg.108.2022.05.21.06.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:14:07 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/13] openrisc/traps: Declare unhandled_exception for
 asmlinkage
Date: Sat, 21 May 2022 22:13:19 +0900
Message-Id: <20220521131323.631209-10-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Openrisc <openrisc@lists.librecores.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Noticed this when workin on warnings.  As unhandled_exception is used in
entry.S we should attribute it with asmlinkage.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 99cd2e6f8873..fd9a0f2b66c4 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -235,7 +235,7 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	make_task_dead(SIGSEGV);
 }
 
-void unhandled_exception(struct pt_regs *regs, int ea, int vector)
+asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
 	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
 	       ea, vector);
-- 
2.31.1

