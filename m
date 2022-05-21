Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609ABC433EF
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A4D072412D;
	Sat, 21 May 2022 15:14:21 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mail.librecores.org (Postfix) with ESMTPS id D6B4824758
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:14:19 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id y41so9853218pfw.12
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
 b=E0vkss2uVELfv3PlZ/r95E//7dUFZcVN3Q6zI9qVYQ11thArs93Y74/ki5ZCK+wTf3
 tdv0ait1ZC13crYnB3TS7CagvX3ibFfRuD84rM2ESVm6wASQoVYYEaoRqogua1BsEiaL
 br4T9WsWwI7j3jDeyvx+V4N77DlBKuPnpwiWirc9XTBYDfS/tmBywUaObp9+c9r/nv2k
 PaAOGEproMgyWRzHaXsWUA3C3Ja7EYiRqymvBuF0cJo3tx/hppL3WDX8HU3owF23sTgd
 WuiLjemAdZ/IMMYZlk5WBF/cXGggclCunzkGy3oRJ2Ot9AbjRm5PhgeHeB5g8Y+nUkI4
 +aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
 b=hOy7gS3uxgZf+L7z3Fk3tWD9TXgA3CxabfGK0Kr1W5+O7KC7lwbRmL5wZ3urenFPw5
 l+QUEGtZlXn/bCvqrUgERz9+JYWiw2PB0XkOcesG7VguM991w1f3kXz0ml54vEppofpK
 Tj7uFpezKe4i7iwvzxHZgWtI6fnNxai4ChSOaMxejy2siajMdizyJLOTcCh4/Ea3cE7h
 v0eRlgT7q0OPQcPSkp7oRpvqcZXZr1pGe6BH/5iyEniEG1VTWW42aFabkAeRVLQfwDcq
 s4A71iEbQr+LCxuvT325Et3hZi4DJvWvMCR0hLLhTOVOeSI0V3DkoSANVS0+0uff/dw4
 b54w==
X-Gm-Message-State: AOAM532/knMJwwXsaJSyvfpsK/Z3BOZSv0eJUaVD8/in1Z1xd9QzamJT
 pitnaTHkO/htTAYU16qB7pE=
X-Google-Smtp-Source: ABdhPJxzxOv0MNjHhHaK6mn9jIflVS4+y14htbcNJBI5Q9e0Aee3EBFglJ0ijsxGWNbzJikDavP5bA==
X-Received: by 2002:a62:e80d:0:b0:50d:8f8e:ffb8 with SMTP id
 c13-20020a62e80d000000b0050d8f8effb8mr14737980pfi.37.1653138858201; 
 Sat, 21 May 2022 06:14:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 h131-20020a628389000000b0050dc762812csm3615421pfe.6.2022.05.21.06.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:14:17 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 12/13] openrisc/fault: Fix symbol scope warnings
Date: Sat, 21 May 2022 22:13:22 +0900
Message-Id: <20220521131323.631209-13-shorne@gmail.com>
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

