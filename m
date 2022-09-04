Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BEDC6FA83
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:16 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8B49224B26;
	Sun,  4 Sep 2022 09:26:15 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mail.librecores.org (Postfix) with ESMTPS id 9A66F24B2B
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:13 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id t7so2449609wrm.10
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=zg3xTO087zHJTEu9DdsDHo8PhqHlfCLyRHR7IWwnkPA=;
 b=PMCqS3iVJvk5k0EYbxXDUad6P5AlY7oT0bFVOAUttzNiidrwVUsYBE63j21wDOFHWl
 ks3eajvZvHLPYl7mlHu/FO0LLeLXB4HyRy4bGjCA2h6sDCbg/IfUoF18ZfxMYlvwwIGF
 kTT7UBnMv2ArSvZ6rEwKFgIWl/rHCZQLrvbv0iHf2dXsCL4EVQ7A6IS0xEVJw/EQ/Rkc
 ErHJNn6N2mqdalG+/XsJvZGoAcqj9dZtCMgvs8A3+aaGHXWbsNBXXCWuO98I05WFVaLa
 ASdaZmrLigWSGgx2EeAqA3Pwi0ykRDu5YFVu57I+HbLS4AlkmuUklxXJ1XkZYfV7oIfA
 qiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=zg3xTO087zHJTEu9DdsDHo8PhqHlfCLyRHR7IWwnkPA=;
 b=csWU/Ckt2CzaUTNVroMWagNkCz2hnG/tYwpP7J9LXRILJb7l9YxiViv3wUcTFGmErp
 fkg1GRH2VaWYaAaR9VckWrir06f4hEGhdukX6loMYGJ0cAB5aDtxyYmDyLJtc0kNlK0w
 Uhkusx6bEa7DfzG34E8nmJOm/Ouab7ky/x6dYmb/CAZ2AiVUrwlOf3DzGVEC5+h0Qbu8
 PFOmyGt7Sus7T5brYBe7pxfdv6eac4vxCS1luUIL9IKmkOazrFB2AfuYIzhmMfKUOJ2K
 2yBRPChgqoGIvr5sYEiv+d/s387duWdl3f7JRxrlK9D9l5T4PnRcCdlvp/c6kGyedL6V
 SBbQ==
X-Gm-Message-State: ACgBeo3VSMXISQj4NNCjIc9uQ//Jqhz7Dv20SPOrUlsjqKeWPDelu31k
 z2+lcHmqvG9dMdo2gOFO+tXryHKCiNA=
X-Google-Smtp-Source: AA6agR6P8SXjc4k5lJQqz5z3Q+eHS2EI8BiRFb+eafxlUN4fYNYgf+GPii7jUxXIw+EKzRIxg1UxCQ==
X-Received: by 2002:a5d:4a91:0:b0:226:d01b:abf with SMTP id
 o17-20020a5d4a91000000b00226d01b0abfmr21962204wrq.268.1662276373253; 
 Sun, 04 Sep 2022 00:26:13 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 x1-20020a5d6b41000000b002250c35826dsm5480581wrw.104.2022.09.04.00.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:12 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] target/openrisc: Fix memory reading in debugger
Date: Sun,  4 Sep 2022 08:25:58 +0100
Message-Id: <20220904072607.44275-3-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904072607.44275-1-shorne@gmail.com>
References: <20220904072607.44275-1-shorne@gmail.com>
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
Cc: openrisc@lists.librecores.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

In commit f0655423ca ("target/openrisc: Reorg tlb lookup") data and
instruction TLB reads were combined.  This, broke debugger reads where
we first tried to map using the data tlb then fall back to the
instruction tlb.

This patch replicates this logic by first requesting a PAGE_READ
protection mapping then falling back to PAGE_EXEC.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.37.2

