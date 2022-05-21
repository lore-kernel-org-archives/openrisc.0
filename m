Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65296C433EF
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:04 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 82AE024758;
	Sat, 21 May 2022 15:14:03 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mail.librecores.org (Postfix) with ESMTPS id 2D40924758
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:14:02 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id y199so9857649pfb.9
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
 b=EhoD7jpbnPzy8VdYE6Da9KaxEBcK5nlsjBo0jRUA7SnJIr9x2+QTmjnPEitkOsnQ82
 FDg2A+qg3UXTXaiArxi5X5eEPUV5aJSNtwPRJeehjHA3VGR1mkM9C5CY4mJPLzuL4F36
 lqOE23I4trR2zVBpBXiZ5DkATI9lNLbE/tpWLwCOkotOq/WoEN9czrR+EXYnsoQuNu2w
 yxdEtbAxWmMD7yCjDPmH3Ww2RpP2+fVInj4SdXpr3CinpsbcVyd28TsoBVrWFzp4PAJp
 piHHvviLyVYDKifOMHwjHo7umj0r/4EWj26lF67JrSC0X5NwZNYtWiE0GvlBsNS72TI1
 KU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
 b=Xl0ERRXNEHRXZC11wMXFijF5MxRKZQv91Ob5Eoko6Vn6/nnZ0nZgbHMWXGGvBa+6j7
 1NKwIjBddiuFqmrMwSbQNsRaBEMBcibK6pn6cTW8MOwicphRcD7lwgqTuGSBsaHMQ8rw
 LdOu5oQx2CquC0jIZ2PEFeFcqQl/MVhf0K3tkP5rQY7catibmSpo6TYoFXxij2/GAmlp
 kdGWQ65zeOaPM98rBXRE7mKiDiAF6EnLxX/5kDRqcAIeLv8+6wdatOKz4tnq22LfLwzc
 +Tjwv5dlmYJ++c49/l07y+3dRN2mKYnVioZQMhU/AlgxQbtzklS3t3AoeWnxIwajYMQ5
 89FA==
X-Gm-Message-State: AOAM531AqKuvU0aY5xPO27pAuCMkgq4yI9gclhlqakrLuMd93zl7bS8g
 kd7emLttBf2HKv0kez4tXcLEWjM8riU5mg==
X-Google-Smtp-Source: ABdhPJyKIW3WotfnL1yeSTCYDA2WB1z5y39r22s9dVdmWhEmBH6WpFdAXpzN0ZhCDdIOGpKXR7st3Q==
X-Received: by 2002:a05:6a00:b94:b0:50f:2255:ae03 with SMTP id
 g20-20020a056a000b9400b0050f2255ae03mr14833395pfj.74.1653138840676; 
 Sat, 21 May 2022 06:14:00 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 190-20020a6204c7000000b0050dc76281basm3740557pfe.148.2022.05.21.06.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:14:00 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/13] openrisc/traps: Declare file scope symbols as static
Date: Sat, 21 May 2022 22:13:17 +0900
Message-Id: <20220521131323.631209-8-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
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

