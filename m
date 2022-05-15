Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C5AC433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4810B20CE9;
	Sun, 15 May 2022 14:42:41 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mail.librecores.org (Postfix) with ESMTPS id A97BB248F2
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:39 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id m12so12028193plb.4
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
 b=Lo6scrQ+k9iHe4huyVLvgU/wxxBjA9bU8Ih1wmkpJo0Ev0Rlpkd25v1GKuGMlqkX92
 WhVHWnsm2nWCy3gNU+y1xjk2pto+37bnLdMW3kD0/lEbz2M1JP0suKY4CLM1rvk5Z7CH
 2xadzZOzkWj/MD3u73lOVz3iUthzEzb2rkQqezefryB2ovt/hkV8mbVLG5h9JNNjnFfA
 poh54JesuZhk4+fKKyORu0rR0HlP82O00aymUyUQgEH6UwcmkHr6TLdlcK7+Y/ZifE1+
 4EV+dlTkeiLs0q8Sdvbh5mntq3H9ULNfMyNdQb4C8vzJBK2aS0p44umitDyzX+pfs9u0
 A9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
 b=Nx5kRrTQH4oJ8/v4GXQ1IshY6fhazuk9b5ZM0CIvnab+p4qtkK58WJdcQ4EJXtidRF
 +Ltpjm4dIGczmsUyH8XbcTgNrM+IYFOV6pnu1T/82fMtDO8QiqJ7RBU/TVMYKWDaDJLu
 74lQob4u7bd8pqqAz8l5HZolW1/u1IvDk1ViW1vFic3V37yL2L5LbUxr4A+4XiwL5/ym
 v+7wAIvyxra6U7cYcdgVG4PS+r8JwZhrx8jWUWwq3DQjx1zSUm+0I633jbtNpIAMfp3+
 cSnHFmYY8Sy272cpGnklvw+pDslGKHKl59Dbtu6mftqRE2nlJlXC2QqF5xzZDhe933CW
 CIXg==
X-Gm-Message-State: AOAM531i2Jc1jsFPOowNyzDVmtvIsDnh/14r7aKPkbTwdcIUgZ8lSN6D
 AVTrcxzKAMc+TvirjE2BVtY=
X-Google-Smtp-Source: ABdhPJwEa15HWk3Et/kczvNW94n1lSxp/nf7itF2ZI5UFYnj6sBZE9pkT79HfOEXd7/OGPTL5nmjyw==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id
 q13-20020a170902f78d00b0014d522edeb3mr13304884pln.173.1652618558263; 
 Sun, 15 May 2022 05:42:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 f38-20020a631026000000b003c14af5062csm4751375pgl.68.2022.05.15.05.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:37 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/13] openrisc/traps: Declare unhandled_exception for
 asmlinkage
Date: Sun, 15 May 2022 21:41:54 +0900
Message-Id: <20220515124158.3167452-10-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
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

