Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974CC433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 01:40:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DC8CE247CB;
	Sun, 15 May 2022 03:40:21 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mail.librecores.org (Postfix) with ESMTPS id A890D24927
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 03:40:19 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id i24so10992019pfa.7
 for <openrisc@lists.librecores.org>; Sat, 14 May 2022 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lGPG1Q4prfE/rl5qsEZlPOkMPbP4eygWnz8hzswRd/4=;
 b=cR3ws6f1/E0n2n7vF0zR7G67jsroEnEHUNMY6cXoS/GBFsBE970SVqSbPR6kfHuEWE
 bTNkyWdRYyjfFqlmjdo4LOZJ2VzvyjY66taMZiIPiTCfLuNTfr4N5toKGlSSy6sYN7PI
 UdzzSmTPFTtrK/5IL2VSm21b1hItDF505po+mrU3sK4ek8AiAA/zjHzeuVzBlWZrO0hL
 8gr+e2kSPaZijFZmEkyruzxPZSi+Cr90yYBJ7iRTDfsY33S+/gYdCNMvmrsxCn9bUqZ/
 Xawh3nu/BWcsBzOG+2evs8n1Z1ijhlVeDuvqVI/gXIfito6HVURzMRRBAOaQulpprE13
 4AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lGPG1Q4prfE/rl5qsEZlPOkMPbP4eygWnz8hzswRd/4=;
 b=395gCdcpwrrwkERfJ2Fic7d2+l1DsGLXAKJ67MVc366UfGLmvqymfEedEMHP4bYqKg
 EbMzi+Rx2UMgWEENORnFDMD0iBioX/1siOAYdguLrxY646QkulRxtpHQwraHJGQQgbHA
 zg698Ewtrwb3HP0AME6mzPDZEftB2GxyZSvIhw/NY+8+D0w9SVkOTH1+tQ+tY2jdOdxv
 fodzoGyY0rWASR7qnG/mGloGmqxRHXOhRRzLDhuYPelDq2DXveBXawGXxuinTAccMXzw
 x702azJV8U8mMrI/dmyqHL1o0uZt5a0rI5k19J1DxUGlGyIYKCwuoeSPUoGXivoBb2tt
 XWkQ==
X-Gm-Message-State: AOAM532ica3WztW4wDkjxqZ+Efgozzz6b9JWzyklu0IblWLbgpCCWlAZ
 LOBJWq3hSh0ab0i22kuvMfo=
X-Google-Smtp-Source: ABdhPJxdD0fE1jz01AKQ4DOi818HJdV0mD+kfRa2p7eYzyLNUMND2BYOBU0loqL9wuXWCmSLNCPKRg==
X-Received: by 2002:a05:6a00:1307:b0:50d:b02e:11df with SMTP id
 j7-20020a056a00130700b0050db02e11dfmr11435637pfu.4.1652578818293; 
 Sat, 14 May 2022 18:40:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 21-20020a630b15000000b003db580384d6sm3963954pgl.60.2022.05.14.18.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 May 2022 18:40:17 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PULL 4/4] target/openrisc: Do not reset delay slot flag on early tb
 exit
Date: Sun, 15 May 2022 10:39:48 +0900
Message-Id: <20220515013948.2993495-5-shorne@gmail.com>
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
 Openrisc <openrisc@lists.librecores.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This was found when running linux crypto algorithm selftests used by
wireguard.  We found that randomly the tests would fail.  We found
through investigation that a combination of a tick timer interrupt,
raised when executing a delay slot instruction at a page boundary caused
the issue.

This was caused when handling the TB_EXIT_REQUESTED case in cpu_tb_exec.
On OpenRISC, which doesn't implement synchronize_from_tb, set_pc was
being used as a fallback.  The OpenRISC set_pc implementation clears
dflag, which caused the exception handling logic to not account for the
delay slot.  This was the bug, because it meant when execution resumed
after the interrupt was handling it resumed in the wrong place.

Fix this by implementing synchronize_from_tb which simply updates pc,
and not clear the delay slot flag.

Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index dfbafc5236..41d1b2a24a 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -30,6 +31,15 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.dflag = 0;
 }
 
+static void openrisc_cpu_synchronize_from_tb(CPUState *cs,
+                                             const TranslationBlock *tb)
+{
+    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
+
+    cpu->env.pc = tb->pc;
+}
+
+
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD |
@@ -186,6 +196,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 
 static const struct TCGCPUOps openrisc_tcg_ops = {
     .initialize = openrisc_translate_init,
+    .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
-- 
2.31.1

