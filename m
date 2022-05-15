Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90CC433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 01:40:20 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id AFE2B2492A;
	Sun, 15 May 2022 03:40:19 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mail.librecores.org (Postfix) with ESMTPS id 8646C2492A
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 03:40:17 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id d25so10979941pfo.10
 for <openrisc@lists.librecores.org>; Sat, 14 May 2022 18:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4yG9LUo6ACH0FVGSSXuYuNUnXAuJpS2Sf77zj4LlmBQ=;
 b=myi5+Og2GI3OwpyOmQEqFgQjqjMyJjNCYq3aDNYkqVvt99+kJkMZ4ql7vBkERAS22y
 Ma/f90m+VhVvG7EQLySb3gYvp4iybPQUsUmr+BNkRJ1erlSD5Uush9S+Aj3pc+diMOyT
 OCXe+bncuE+9Bme7jSpVNPLLQjlJfo4pvR/xTgJBdDUQkPPFz6lLzA/wSsuDHQ2NL3fj
 P79FPtPHzFwjqAttmUNwJVM8pYR5rwWGSgio8sm+6aJYuiYPJ/sNzPqNhXIdiqlWzKpm
 kfI+LMdCmkDTxpHXRBAaDjbDRTC4z9czOM71H+lOWlIK/9B1LkMnyidytP8De/i1Gd/A
 ZWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4yG9LUo6ACH0FVGSSXuYuNUnXAuJpS2Sf77zj4LlmBQ=;
 b=cafT8LT9xEW704RyMtTfe8Xj81K2NZVvcwf40D89ars6/mYoIiGLZFInkusPMA4FfO
 f9vExPOq5wmLdlT69vtLw/fUoj5x2tcT1bY96YLsvRUmx9wPNvdjRjW+cnldQcKBLoiC
 ARxT66o3eOxKev5Fr5bFoDIoQ8FT+IyH4tvWQCxJYdPLydLh3Rd4jDTQND02Gf68CF26
 arLgO4KhsLMkAvE6UikewvBbfDmY+BqBThkiMJ6SZ1sx0NaQLK98Pu8pIfrqUWPnEOh/
 l3vQS8k/bLVnUBpc7i/vEcNwQF9eTmxVeX05CcRCHJ2Os05+vyvzTRdj9qh1S9QnLiSz
 D8Fg==
X-Gm-Message-State: AOAM531t0Yg5maooKLMKHd6xz3ojeb1yDngVJbFu+pT5pWm9XM1yXqkI
 5JHzPaU3KEEFutrrTVNoapQ=
X-Google-Smtp-Source: ABdhPJwAHE2XEH06GA78Ysn8v38JzzGSMznZSpSMfGHF3TcRzcOa+NKoeAdTSWh720tG+umoMAJClQ==
X-Received: by 2002:a05:6a00:1903:b0:4fa:fa9e:42e6 with SMTP id
 y3-20020a056a00190300b004fafa9e42e6mr11303108pfi.1.1652578816046; 
 Sat, 14 May 2022 18:40:16 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a1709029a8c00b0015e8d4eb2b7sm4214388plp.257.2022.05.14.18.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 May 2022 18:40:15 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PULL 3/4] hw/openrisc: use right OMPIC size variable
Date: Sun, 15 May 2022 10:39:47 +0900
Message-Id: <20220515013948.2993495-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515013948.2993495-1-shorne@gmail.com>
References: <20220515013948.2993495-1-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>, Jia Liu <proljc@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

This appears to be a copy and paste error. The UART size was used
instead of the much smaller OMPIC size. But actually that smaller OMPIC
size is wrong too and doesn't allow the IPI to work in Linux. So set it
to the old value.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
[smh:Updated OR1KSIM_OMPIC size to use OR1KSIM_CPUS_MAX]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/openrisc_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 6873124f74..35adce17ac 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -82,7 +82,7 @@ static const struct MemmapEntry {
     [OR1KSIM_DRAM] =      { 0x00000000,          0 },
     [OR1KSIM_UART] =      { 0x90000000,      0x100 },
     [OR1KSIM_ETHOC] =     { 0x92000000,      0x800 },
-    [OR1KSIM_OMPIC] =     { 0x98000000,         16 },
+    [OR1KSIM_OMPIC] =     { 0x98000000, OR1KSIM_CPUS_MAX * 8 },
 };
 
 static struct openrisc_boot_info {
@@ -418,7 +418,7 @@ static void openrisc_sim_init(MachineState *machine)
 
     if (smp_cpus > 1) {
         openrisc_sim_ompic_init(state, or1ksim_memmap[OR1KSIM_OMPIC].base,
-                                or1ksim_memmap[OR1KSIM_UART].size,
+                                or1ksim_memmap[OR1KSIM_OMPIC].size,
                                 smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
     }
 
-- 
2.31.1

