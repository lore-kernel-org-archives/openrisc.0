Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA2C43334
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:28:54 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 653DE24844;
	Sun,  3 Jul 2022 23:28:53 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mail.librecores.org (Postfix) with ESMTPS id E93E82484E
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:28:51 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id d5so6948037plo.12
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XWUHW2uWZ9zbOeqP0838xJKDYozgaZ7qX3ZxMT89y1s=;
 b=FPTmeYFa7SGP3RqRs277v+U2WgT87Df53L5MdEHZOlTxs9cACfF745h3yJY+gBf9Ja
 AS4rqj7YWDKvTePTe9YKayM6o9a1Gdit2xmMZwKnX0Brb4xMSjSkZAffUuHhPEv3pez2
 V77KRT1Mzvm/ORsJvHGnR+qIULzT4H1uCC/wk+OU0/5KQzsri0hONtRfP3XTbGIejw5S
 JKIkC6fHnnuBfLOejBs5ff9A6Ri6SGq8AFvfrA5ecgGUs76I05aOrYxWK6YuUDj0oob5
 VCFTCG4yTbh87jeHqIEfs0y4xiPHWfsgU6zfEZuhXdSlsd1Lp/f8H60C72YG7ucK02YS
 wGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XWUHW2uWZ9zbOeqP0838xJKDYozgaZ7qX3ZxMT89y1s=;
 b=YWdeBJynxZx3sT1QK6OvyLPa5BQGEGiamPe+4MyH9/1mLwlG7ef9UHX4PUB3QGbFCx
 DJZn8Fcx8CTWTMzSwiJ3Fqf7mYU+nZavuTw/FOhaAYT7inWf4SYf8xOrMEv+rNhI8N2A
 6gzZMUCgh7cZQ+M6upJnlQq6TPC10j3/3hC6ZPZ+LCIk3bLoRqzlJU84TzUqiCYt6b8C
 NlqzEzTS4ZljpFli4Z4WKSpW8ECw1N9yhMFEz++aeE+NKIpiOBgbmn8yWmx6JJkjDYes
 hanYM7mYvaWdyW3qrlxZP3wS0P+YKgZunG+oRpw0EHcEvcPIlzMoyFGz+jBgnb2h1A2z
 0whw==
X-Gm-Message-State: AJIora8FSoiutFniqPp7dOo0vjzagJl3kb8dIDs4vrwxuimt1Azlonl2
 nvMHU8hliPdTH5gGnGYaSlY=
X-Google-Smtp-Source: AGRyM1v9bS+Z0b/KwgjPpu3fNgsJnT/RVsWrOKV4P1uDkTfuGTLQEK72xjbansHlW5X8FuJHkeJjsw==
X-Received: by 2002:a17:90a:6043:b0:1ec:c929:d16d with SMTP id
 h3-20020a17090a604300b001ecc929d16dmr33309723pjm.7.1656883730524; 
 Sun, 03 Jul 2022 14:28:50 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a056a00158900b0051b8e7765edsm19623465pfk.67.2022.07.03.14.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:28:50 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 02/11] target/openrisc: Fix memory reading in debugger
Date: Mon,  4 Jul 2022 06:28:14 +0900
Message-Id: <20220703212823.10067-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220703212823.10067-1-shorne@gmail.com>
References: <20220703212823.10067-1-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

In commit f0655423ca ("target/openrisc: Reorg tlb lookup") data and
instruction TLB reads were combined.  This, broke debugger reads where
we first tried to map using the data tlb then fall back to the
instruction tlb.

This patch replicates this logic by first requesting a PAGE_READ
protection mapping then falling back to PAGE_EXEC.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index d7e1320998..0b8afdbacf 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -148,7 +148,13 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     case SR_DME | SR_IME:
         /* The mmu is definitely enabled.  */
         excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
-                            PAGE_EXEC | PAGE_READ | PAGE_WRITE,
+                            PAGE_READ,
+                            (sr & SR_SM) != 0);
+        if (!excp) {
+            return phys_addr;
+        }
+        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
+                            PAGE_EXEC,
                             (sr & SR_SM) != 0);
         return excp ? -1 : phys_addr;
 
-- 
2.36.1

