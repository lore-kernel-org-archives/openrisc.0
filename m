Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CBBC433EF
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:52 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2D7692496D;
	Tue, 17 May 2022 02:55:52 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mail.librecores.org (Postfix) with ESMTPS id 557B92497A
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:50 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id ev18so5357787pjb.4
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
 b=lolJi/grF0XlxD0r+TbFled81nc41kCjirhMSf0FXwqJhgcA8wkMXF7orqRsYZ4O8K
 HGYSFBCi8BY43TfxB2xjssMePXmxTLaSehRbu64Z9Osgx/XCY0VqetZzjwV5MiOlVfOY
 JgOqIIahzEqUFFqnxRATc+KX0bd4/2F0mGu1iu9jOpImzUOhHcTquEk2rrPwb/uDFN5C
 V3w+3hYVC4/yqYcG/G/AI0HThbrMZlky4kg0uIDDYfun/gSr1lY/xw3U/sjDm7M7O1JH
 29ctNIXRq6FYVn3IxBOqGVS6RlE2PPiP6VuUVXvvcnOf1y0Nr07UYEGMKjQ0qVhFwaNc
 +2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
 b=lOLB5M0tzrc5cTmIpIYk5h8Ph6jzCEJX/yHE6nGiSI1d9fFrVd1AF23yVhIyL4odMD
 JVpsfQkgn74Kka4WBq6VSNTf0y6dooHJwg6YWc3dprs8+p3co17+yyZ2AXXGLlhozW2N
 oXBpqAxjO+ob3p2HbIYWZxk1TCIF0YgtNnRZkyIRgmwhWEUNe9ghi+DDqhCQNKuv02fc
 ej1/2rB8uXH1HZrbjqBXNdjPp+Vxzz2rkx57frPjGmuuT+79OiZ8GgzpjU8idBmc07dE
 JAYgaU41UdKwvx+CS5+Hw4voYUu2lBbe7WT0PFT5tsA+YnYvjYS8pcmUNKPY24bdmYkn
 g7XQ==
X-Gm-Message-State: AOAM530xTRNgE/nmnAuUiUNTy/Z8XmK308Etmtl8VxhQj4C0i0UT2av+
 c2FzHU4fzGSfuljM/CPqvgs=
X-Google-Smtp-Source: ABdhPJzHJQEjBCfKJWcGHDyr9TTDGKtZomcGfjSzIvd4OX6WWrNI7QdR0unRWlq3+NmORDe+a0HdLg==
X-Received: by 2002:a17:902:d191:b0:161:5c4f:ce9e with SMTP id
 m17-20020a170902d19100b001615c4fce9emr11941745plb.159.1652748948956; 
 Mon, 16 May 2022 17:55:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 13-20020a630e4d000000b003c14af50626sm7084057pgo.62.2022.05.16.17.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:48 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/13] openrisc/traps: Declare file scope symbols as static
Date: Tue, 17 May 2022 09:55:04 +0900
Message-Id: <20220517005510.3500105-8-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
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

