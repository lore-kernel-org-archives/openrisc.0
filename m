Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFAC19F2B
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id BFBE524A71;
	Sat, 30 Jul 2022 01:06:21 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mail.librecores.org (Postfix) with ESMTPS id ADF5524A7A
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:19 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id d7so2020618pgc.13
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TfhTaKLipR7ZnPNEZbMG+vKVDM09H6zgRLcLiJBdoNc=;
 b=OZhVs519WgLdi5RziBRJJZoA8/bWA/aUD7of7Eb9uR6Jql3lkm6tOTKChBIsh1L8CZ
 XZWacKNDLmHwQsX0uGCd7KyCaaxKI9JNd9GdOMqo4d0yio27Vrj3CnVtP+RZfMGw2Ueq
 mJlBEf73ARKVq/cBbLVLNd+5jbnMBRolucGMtpgB8DKnmZY8tSd2Mdq4bkc6178uLnQB
 Zjtc4IJ99ujXSG+Icu432hjEU1Kg/aSuBepUs/iw7kNGuvypgGygA5uBwOpjxYsmZz6q
 gUcssID4czv60wiaOJN5IjO8Dawiaop0nP0DYGX3Q4ZLKAMeUQtPPpjZ6HE4S0mMLu6V
 obCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TfhTaKLipR7ZnPNEZbMG+vKVDM09H6zgRLcLiJBdoNc=;
 b=5s1XTqKP0YJunMhsJFACU25tdHXPacbksbMXPg4zr/GOyCIx6YsSZxjYECz/440igv
 HhwDKXYMLShgPp/IQ6maaaVn1wBBf1n89xrw1Lx6mlATevNn8h/gNgnCExvvLKjrDrQw
 Eb9MjERKMiuGOyWtt77wu0yITFq5+nBHoD2bo64+Fbt7J/2lpHtQozj0lDTzdj+UIg8G
 6CcSCldqMAOago0vmEKEi3GDDgh2xjU1yf0iT5hXCJZWB2dzcsq6wEMdoAROPG2He5pl
 uuc0bPfnwEk8NaAbvzzfZFOijdmhuYZ9tLLM5j4O0CvsSUprWX4fWfNfD7nI+6CyatFh
 TR0w==
X-Gm-Message-State: AJIora8RjjKbG0UZQkStz7lUPMmyK8TIZKXkdfxxA8o/StzxZGQN1ukT
 FRCHoRwUFZZJozNTcYsdHWg4VxptaqBwiw==
X-Google-Smtp-Source: AGRyM1uPIPjtPZ6Rchwe23IWOZgfe9sKMu87ZkdW97D/i2152jhZuRU7rvGhvneC3EwkkIJCGyTyOQ==
X-Received: by 2002:a05:6a00:815:b0:52b:8895:a0bd with SMTP id
 m21-20020a056a00081500b0052b8895a0bdmr5621588pfk.57.1659135978168; 
 Fri, 29 Jul 2022 16:06:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a170902860b00b0016be9d498d0sm4083896plo.211.2022.07.29.16.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:17 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 02/11] target/openrisc: Fix memory reading in debugger
Date: Sat, 30 Jul 2022 08:01:08 +0900
Message-Id: <20220729230117.3768312-3-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729230117.3768312-1-shorne@gmail.com>
References: <20220729230117.3768312-1-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
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
Since v2:
 - No changes, added Reviewed-by

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
2.37.1

