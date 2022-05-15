Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F80C433FE
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1BE1620CE9;
	Sun, 15 May 2022 14:42:38 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id 6DC5A248F1
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:36 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 w17-20020a17090a529100b001db302efed6so11802928pjh.4
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
 b=CUCIL+9IqRDN2tJAKVtzSzg97nX5O/JVAGHwOTY5DEpkHUytrXA/oXzlwAwXb2WBb8
 8N2nRud02vIqlwXUP4YZnnsD9AxZu8iQtGS0pp5/8XppjqZnmaE07Wz82rf+a+DSfpBt
 ekv1ybRFgnpr6UTANmIfRECHA1i/xQ91h9vPuP/t/pCZxhtGF74ECwz0v0/Jb4den/pl
 B2ymDTQk0nfTvlwnAMloyqPyY3m/ADG/xu5L98Zldy5/WwcpmZd6SsdGC2mICJOlk7rc
 tHvBznNJt1polk4ODdmghCrvTMXZVeA5uN4J9yIr5meyA9JA1Yk88zBWmxmOxcmEmSBH
 nVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
 b=cCZ4di6PUYi9v2+PBTzJF3iA53IaPYescOxw/ucb1u1NAWZGmCXCp/6NY6/UfLSqrx
 w993bnaeFlSBqeIXqsytk7m0A6a87ydZJPzdyoQC3LExGqTUIF34L46E6PZGq0eBzWYn
 m/4C+F6/pb6EB0VVIG6JHA5yQJxAwYMhSvX7r1W2q/Q31wAguWsssjXc0wL4RL3qKzNI
 BPJN+WU0YHLCEAb0BiTE/mCR8TZGaeeAmfY+V+aJgTmkhGV0i+Sf4RQV7kmsaom/+CB7
 56DQThH+L204pY85x03usfaC6+nUQORGfX8Yb86YoPvlVkIqaJoysIJiASB1ZOCIRm7d
 i4IA==
X-Gm-Message-State: AOAM531hliwuse0T+MBDUba8Cr5kliYRdvsDpf1Hv0aqJ9DEd0ZUZdIQ
 DOpbMbPn/hnE4GcIR6VFZqk=
X-Google-Smtp-Source: ABdhPJwll4DIMNy2JuWm6ejdna8WNoX3+eiQHDVN4fLW8HnaNS1u+hk/bQv2o6r610cu+5jGCXD9vQ==
X-Received: by 2002:a17:903:240f:b0:156:8e81:a0a3 with SMTP id
 e15-20020a170903240f00b001568e81a0a3mr13027370plo.13.1652618555086; 
 Sun, 15 May 2022 05:42:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 c9-20020aa78e09000000b0050dc76281ebsm4945390pfr.197.2022.05.15.05.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:34 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/13] openrisc/traps: Remove die_if_kernel function
Date: Sun, 15 May 2022 21:41:53 +0900
Message-Id: <20220515124158.3167452-9-shorne@gmail.com>
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

