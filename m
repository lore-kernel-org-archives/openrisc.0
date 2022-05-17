Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70059C433EF
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:59 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9289324980;
	Tue, 17 May 2022 02:55:58 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mail.librecores.org (Postfix) with ESMTPS id F3C6A2497D
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:56 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id p8so15521658pfh.8
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
 b=AnNSio8MU8aUblNXEC6S4jK102eG0to3VFxQn44aaTWb7YYxMIy3IC2pxI6oGsCEv/
 prVQiRYxTAXz5CWqYRWwLD1UyzwbeLyMA7k41CMiUytHJxV1vWIcIU9OXoisq+xIYtEz
 ZZ40h5vhDJDee6DUxobLBTpJ40faCf6VkijDsL7m6n4jJrLw/fqrbkX1FWCAYg6/3nql
 /9s/Ev0caf5hUMN6GxE272facYSz/9WECpBRJQgDWCZWuiSgOXhs2hCTUmZmWf76Wmo/
 /VLXww8BL3cFQ/LZ+g5aKO8dSFs1vz7zpjLPeEpD2DOXHfcCfKIkv9LM42wt0mNc99/7
 BYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
 b=nQ8XtnwJVsX2huXc3nDJ+HrZQE5OWUJ6918NwEWWz5KGxbsErqGC1tSqTERTN7paFx
 8upumMyoenHuJtF7eYUf+Hg4AEx7NEYIzry9ZtAnXvTY9qIpKwIo51VdYFVFt0k05RZx
 MoHYkEy+CvvGTy3KiMt+/fmQMBGuZDgB6DYhKThRp8J9cSN+DhwdXh+0vPs2BTPezCMK
 yAT+Cc6vGVRi523O7+pTZY3WpyTLZ4lehqp9OzpzY5zCUH2I/y+k2fUjv+r2iM96BDAj
 nJkKQ1rvESME4g8EFCSMLefmCeld1OxbBWnBP7OTBDH1BKNch3/fKUKnJISg98WJXSuA
 /BbQ==
X-Gm-Message-State: AOAM533RQ72v0UGLK7jIK0brvWQgPBeENKQvwOwcfTJMkOnO/CoGoTtm
 FzTy8P6haAw8m/s+xn5vO6w=
X-Google-Smtp-Source: ABdhPJwXcbp6DdwNTKzzohdiQOrQn3fCObLXri0C6XjchRPG/DsjUK2H3PNGpGQM9dNxEwAkvo+dkw==
X-Received: by 2002:a63:2321:0:b0:3da:f4b9:90e with SMTP id
 j33-20020a632321000000b003daf4b9090emr17804892pgj.31.1652748955611; 
 Mon, 16 May 2022 17:55:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 gd8-20020a17090b0fc800b001d9780b7779sm293643pjb.15.2022.05.16.17.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:54 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/13] openrisc/traps: Declare unhandled_exception for
 asmlinkage
Date: Tue, 17 May 2022 09:55:06 +0900
Message-Id: <20220517005510.3500105-10-shorne@gmail.com>
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
 "Eric W. Biederman" <ebiederm@xmission.com>
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

