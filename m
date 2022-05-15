Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B6C433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E747020D0C;
	Sun, 15 May 2022 14:42:50 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mail.librecores.org (Postfix) with ESMTPS id 92D0B20D0C
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:49 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id i24so11686785pfa.7
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
 b=pS/jHvHWwnFrMXvw/NKO7jVf7rgAWmrSVIhik0j+dafXTZMkW49m+3oCGrFQqDzbos
 fEEJzmYybyqQFqXj6DKvTAXpZ59cC2trVDVaFT3N2OPV98AUho+qv5H2EI3gdseGYAc9
 dC/I5NtukRdxetaDlvbcln8bqw9kuGMdgQfjUQ50erk4ehtML9NK0f+DvIKGzaceJh08
 whIQDqUpRrBI1AoXyeTdk0QEn6KMdAiUODtkefc4xfMwDrHiwgFBrdxFfDK+hACaNZqM
 z7AC5DtDZr+ue5N5p0LbiL8fEqedqJHRk98LeinCbc0Wsv2OeWheFz/FdlTzn8F6fvrq
 9jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
 b=sAeuUGZtzFcUwqCoSJNkuDQsbnkiJkQ4zrSKxvyK6oEDpy7i4WRa770tfWCernnUsl
 wIhCWxO0VkRGE6iWF8Lby6ab0fkfO5aWS2Y6M9btq02Oz/cd6LQtLnGcoBXCSgnpar9s
 y4TSvvV7VR22E12b9Jp5q//NmK1iZ9vOBg5z4ISkA9/nuT523E1pnYqzm7egd1IwaoET
 Gp+pwe2cAAsaA9izeq5gslmkTvi32rqUNcSAt/W78jc7u74Nv1seke1fCMVM50OOVW2I
 G2b1QlGc2ZGdrX/8xuXOk6K5s0wviGV7SRdMFm6T6w4pMjRw+1xqcgeK98lHWPtx6L01
 FeVQ==
X-Gm-Message-State: AOAM531PyRj52UhufNA9zcHRvfaCdhJiHpKalyHaYM64HwFNafg3u1zP
 r3+k0274TvlQRxmkW6+A8vk=
X-Google-Smtp-Source: ABdhPJzK3nMYwucViE+6UcrtAYIhYH8yd+pU+/ungG8bLNSFY/C8q7rakJXXY7nDCSbGIll7b+Lapw==
X-Received: by 2002:a65:6a16:0:b0:39d:4f3:67e6 with SMTP id
 m22-20020a656a16000000b0039d04f367e6mr11720141pgu.84.1652618568182; 
 Sun, 15 May 2022 05:42:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170903234300b0015e8d4eb1f6sm5209876plh.64.2022.05.15.05.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:47 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/13] openrisc/fault: Fix symbol scope warnings
Date: Sun, 15 May 2022 21:41:57 +0900
Message-Id: <20220515124158.3167452-13-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Randy Dunlap <rdunlap@infradead.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Openrisc <openrisc@lists.librecores.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Sparse reported the following warning:

    arch/openrisc/mm/fault.c:27:15: warning: symbol 'pte_misses' was not declared. Should it be static?
    arch/openrisc/mm/fault.c:28:15: warning: symbol 'pte_errors' was not declared. Should it be static?
    arch/openrisc/mm/fault.c:33:16: warning: symbol 'current_pgd' was not declared. Should it be static?

This patch fixes these by:
 - Remove unused pte_misses and pte_errors counters which are no longer
   used.
 - Add asm/mmu_context.h include to provide the current_pgd declaration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/fault.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 80bb66ad42f6..516cba14dec9 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -18,15 +18,13 @@
 #include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
+#include <asm/mmu_context.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
 #define NUM_TLB_ENTRIES 64
 #define TLB_OFFSET(add) (((add) >> PAGE_SHIFT) & (NUM_TLB_ENTRIES-1))
 
-unsigned long pte_misses;	/* updated by do_page_fault() */
-unsigned long pte_errors;	/* updated by do_page_fault() */
-
 /* __PHX__ :: - check the vmalloc_fault in do_page_fault()
  *            - also look into include/asm/mmu_context.h
  */
-- 
2.31.1

