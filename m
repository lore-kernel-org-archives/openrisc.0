Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B2AC433FE
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:55 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 60EA72497C;
	Tue, 17 May 2022 02:55:54 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mail.librecores.org (Postfix) with ESMTPS id 93DD52497D
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:53 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 pq9-20020a17090b3d8900b001df622bf81dso897900pjb.3
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
 b=WHGy/FigKtpjnR0C/zvZzZKw82dDIx9z+0NO4/b1iqKaQ/L6icwl70tjS+vHAAlnKj
 TVt4JbXCTMQUOyaPvfYy4bIrT86YM0bKZT+chnoq6SJX7+2OhqLV/YUXuXJVuvVDxzJA
 h14DGve6uUkDhDNUXn8tD7mOT4nCvcP4EKHCdrp8yyhFQGYRTS/sKYQtN66O4GzzyQHx
 kGFltFCl5MTjCJjEd2YCa8rZTffpg9XoX2bdzfCXAM+MysAZH+jgmnUzJVPXyGxeC25K
 PN11R+jIzWdIZLs64/9MshIAogvSw8aVUiH0E0quNX/Eqewn5/qXV+4+0QqgJwc9bPwe
 YdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
 b=3jD1trbJk0XDueKK1P0zBadzBWqI2UQkAistYBVwHxt/DtWyvO1hdykfBh79/K56m2
 Zf1d1YDGiy2JsknVg9XBenBKKc62x+nOpuJzhCOaXYHRokGypsoeH/mYf6AUZr/emSaS
 fcNyE+FhojyjbJ4JvaDGGCN/fVfl8yz4Yl4KXF4KJJDBKBoaHkQ11CbeWpTtFUjX3AOz
 Pz2vvNHQmD9GQn0kOUiv8LZH2IYV/tnzkL7qXy7Y9WPrxu3qe8mY0S4Wh7hg4vanxXr1
 1cpSYVp2f+ibKshRVSFfLwCVekJfrjBf0T2vXTJ+2gCN7+3mG4U2usFCi6Okq6fFsNk2
 2BFQ==
X-Gm-Message-State: AOAM531f+R1EsHBdl629VCTtl8+OXbN8P1oScOmYYkSvGLolCbetkT0D
 C6gZrryNgIsfmvfluBOFGzk=
X-Google-Smtp-Source: ABdhPJy5VHtPWLlYSrYw1gcfTPLMW48qsnQGgyFXX1YLRyLH78izI4koIEmJWPPcAq4bBJMclmC/6w==
X-Received: by 2002:a17:902:cec9:b0:15e:cbf4:c246 with SMTP id
 d9-20020a170902cec900b0015ecbf4c246mr19899475plg.1.1652748952205; 
 Mon, 16 May 2022 17:55:52 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a6563d0000000b003c14af50607sm7243875pgv.31.2022.05.16.17.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:51 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/13] openrisc/traps: Remove die_if_kernel function
Date: Tue, 17 May 2022 09:55:05 +0900
Message-Id: <20220517005510.3500105-9-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Openrisc <openrisc@lists.librecores.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This was noticed when I saw this warning:

    arch/openrisc/kernel/traps.c:234:6: warning: no previous prototype for 'die_if_kernel' [-Wmissing-prototypes]
      234 | void die_if_kernel(const char *str, struct pt_regs *regs, long err)
	  |      ^~~~~~~~~~~~~

The die_if_kernel function is not used in the OpenRISC port so remove
it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 9e0937eb31ca..99cd2e6f8873 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -235,15 +235,6 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	make_task_dead(SIGSEGV);
 }
 
-/* This is normally the 'Oops' routine */
-void die_if_kernel(const char *str, struct pt_regs *regs, long err)
-{
-	if (user_mode(regs))
-		return;
-
-	die(str, regs, err);
-}
-
 void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
 	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
-- 
2.31.1

