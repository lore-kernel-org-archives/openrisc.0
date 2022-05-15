Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD7C433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DEDE820D0C;
	Sun, 15 May 2022 14:42:34 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mail.librecores.org (Postfix) with ESMTPS id 6145C248F2
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:33 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id g184so11709726pgc.1
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
 b=ksSpxTNN13tMggvaejsEI+GQ4F41SIaUMtsGc/Fbqvm0NY7LV1vR2jqG1m7GoxPGku
 PhKShLPS2YaFrCkWF6qzNE5E8jWTrJU+moMax9b1xoFBY6SRdkK8bVp2Zc/G/nSySbjW
 liOdoPCmqor7GMxuSCOuApzqyuWuAqnY0sdvxKZMccFR3frD5U5yhzHbEI5vUEAwePLj
 7NigwZjZe3z2aNqzabMoA3gJKXQB748Hy11fqo1cWv8xhly2r4khbd9fxdgzD7LDLZow
 RisaBQqRaleTGpSUZAdrxcMWrZ4s18sPFISuodoVqegDk4/ERIEhkV9Mf2goI4bvRbnb
 pyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
 b=yfuz/TkSGnBhiEnRxwDz/lAx8q2lc+5jmteuYNGGJtXquT7dRYlI/tywb+bw4g4+9P
 +hEsMmt2qb/8sFqUMjfCkA6Sc+5r8UpRZnz7DTmfZCSvzpK33t7SspAvt4o/LoxH9Wmx
 G6KCQmVrHEjCckNTF4zpdbmUuXLfkZcdPZoN63C9+RQ5XEKEXreqk0PYa8Gm0sxdDZTW
 8wR55ivjZOku14QqhO7k8Z2DGqFxSiwVrNt075SG9xlWVWH8h11fIEiDmRCllDci4zDC
 JYJH9O5SdzYfxoGPOCaZqB8B6bQkZAgGifzCZpoq+HTtRIabBwtJIgQv4Gf0D+CrNjJE
 cNNg==
X-Gm-Message-State: AOAM533WLAkzevUCKib70q11h4TQFHcvdaoDE7OhMsZODcsPAVFBMjNV
 hg9a3DFuhWpuB3ae0On90O0=
X-Google-Smtp-Source: ABdhPJwTNC03YPfYWQHf0N8lARTn79n+/NuIFfhPaElPQM+ruE5EgRmd23V1wPxuw7p6lSSipEta1Q==
X-Received: by 2002:a63:d34d:0:b0:3db:a518:1ff8 with SMTP id
 u13-20020a63d34d000000b003dba5181ff8mr9206517pgi.593.1652618552046; 
 Sun, 15 May 2022 05:42:32 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a170902b21300b0015ef63f2382sm5054670plr.231.2022.05.15.05.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:31 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/13] openrisc/traps: Declare file scope symbols as static
Date: Sun, 15 May 2022 21:41:52 +0900
Message-Id: <20220515124158.3167452-8-shorne@gmail.com>
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
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Openrisc <openrisc@lists.librecores.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Sparse was reporting the following warnings:

    arch/openrisc/kernel/traps.c:37:5: warning: symbol 'kstack_depth_to_print' was not declared. Should it be static?
    arch/openrisc/kernel/traps.c:39:22: warning: symbol 'lwa_addr' was not declared. Should it be static?
    arch/openrisc/kernel/traps.c:41:6: warning: symbol 'print_trace' was not declared. Should it be static?

The function print_trace and local variables kstack_depth_to_print and
lwa_addr are not used outside of this file.  This patch marks them as
static.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index f2478bba77b9..9e0937eb31ca 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -34,11 +34,11 @@
 #include <asm/unwinder.h>
 #include <asm/sections.h>
 
-int kstack_depth_to_print = 0x180;
+static int kstack_depth_to_print = 0x180;
 int lwa_flag;
-unsigned long __user *lwa_addr;
+static unsigned long __user *lwa_addr;
 
-void print_trace(void *data, unsigned long addr, int reliable)
+static void print_trace(void *data, unsigned long addr, int reliable)
 {
 	const char *loglvl = data;
 
-- 
2.31.1

