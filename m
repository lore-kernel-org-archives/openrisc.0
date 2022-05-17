Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6FC433F5
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:56:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4130024981;
	Tue, 17 May 2022 02:56:08 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mail.librecores.org (Postfix) with ESMTPS id 0375C24985
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:56:06 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 z7-20020a17090abd8700b001df78c7c209so992215pjr.1
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
 b=IIIyXSQJWf8UayE82aTml286GpqPORX9ViI9e/yl8XghTxo/ZP4IGnG0yfs5lmsqZh
 XAq01FX14zp3kWmuGrRB787zVcW0Xl2iiLvehDKRPIh6vH6lLApEoZfReOfW4GdGGCip
 i3n+iOtizlgQl+dYG9gSswt+9j5ErccPVhmYyo7iCJC+0rlm2A3kFK/yB6V152fE1p/M
 OiHfebI9mZGTN86UDz2R0krR4FF6bejrChRfTiWyCP05MNGmysQlsbAm5s/ghHmea3wm
 eNqeweDIspoMcW9uaocky1EbdAzCujoUwYTRr0daPN1pfrfvathmDgiX0W85H+XFHVfk
 v/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
 b=JMfP77vtKdoBJzAV3bgSO2aHBkk0PS/Ds1629an/WublpILNYLHXi4f3LS8zXfZNeA
 8RKlWEqIsyzwOV5QUCKd8UtY+S0j4jbt1RKItY9AbdJMarPIMKyV6iDpBd6xXDGTBIUB
 loBGGdVTI8Ma5gn0DIfxH0Y6LHMoEfDrV6nMqkjrYYJLbJI0MQXFs27b2suhIxSlIxUn
 pifXqW3q+jn+HoTdZfRpQXJFlOV5Bqg5saaDZIIVRQbR2A/fNIssMc8DU6QNEQGeYhUJ
 aVPzAk9EuiSBl7t/gvyJyDrOaRCq5rYiQ7cQ785+/j1y30qkcn9GmNqYYN9kvLMzUrbo
 YF7w==
X-Gm-Message-State: AOAM531zWDVe2gH2x9NjHQgxVaDiAZbOPPIJCbMOhL322SRwIjqDm1zh
 keQaPvRrbvjvBuo7olM0ewA=
X-Google-Smtp-Source: ABdhPJzCzap+mCp/6EYXmoaBxWvMCbfqW76N0OCIz6ZiKWNdjx7NhOv3OkFJ2by8dxR+EwgzUmRbjw==
X-Received: by 2002:a17:902:a516:b0:15f:309f:7805 with SMTP id
 s22-20020a170902a51600b0015f309f7805mr20022119plq.114.1652748965506; 
 Mon, 16 May 2022 17:56:05 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a17090ad08100b001df501391efsm273548pju.53.2022.05.16.17.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:56:04 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/13] openrisc/fault: Fix symbol scope warnings
Date: Tue, 17 May 2022 09:55:09 +0900
Message-Id: <20220517005510.3500105-13-shorne@gmail.com>
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

