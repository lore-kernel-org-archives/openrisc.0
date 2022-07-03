Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95171C43334
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:29:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CB1342481B;
	Sun,  3 Jul 2022 23:29:05 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mail.librecores.org (Postfix) with ESMTPS id E36A424853
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:29:03 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id 5so1099853plk.9
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8XzVtM7jNZntW2ICseJWIzEx5QJb2NL5Wk2zg4Z/3nI=;
 b=hL3WLTmmrLcuv7P6JhsfNwYpnNK/zHsCfgAqyptezt81DHooxYfiwmSG5j5HgL4cy8
 9gjNYvQdm0MFP70dGHn5hKst80PsBsUUDFZHQx0fTvujJhOhahVCXJHbnTfDwMHvBXf9
 cLyNb87pm0yDbjugWPHI+QvDm7GpVh+2bHO3/szawygTluUJKJuUaHzlWeh3Z97iW4G9
 1wOuaeIsn1X93U9N4sLRJTnN4PcOBBNUq9U5Q6/qdNomXFuMPw9aNTe3vJiXWzdKuirm
 NZYZN4DTPiypZMdTlaUUEqVmYhLLZfIGkO3mQRYBnj8DGxiW3t8oTsP03jcO1Bvya1i5
 kafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XzVtM7jNZntW2ICseJWIzEx5QJb2NL5Wk2zg4Z/3nI=;
 b=CH8oKRB78e0Dj7I6wRzKe+pENl6tmssGqd4ssYYWK2SVIeS7Ohi50/wZ/2md9h6ipt
 vNZOH+VU+jSQswp8MPJaYQTtValqpRiSWmkJ60kWRqNzLLtBdCoa54qnWWqZv20bVxW0
 khUNFttbmaxwmPzdHtddD64Fgb2eCj6YOm5HE1RtoYo6P6LGZ/b7j9O5OpvHGMo9xe4X
 lxfs1Ro8pHzcpe6fTt+3TyRKsRs6UhokWDqny6y/ezt8cRfQ6ys9zw/N9YmTdOKUC0oh
 GDEcPGTfdkw+NONi5maFxPqKmzUc95ruqLECDNZTqfl9M29QNm3CHpAE6fYMWpn4WiMS
 S9PA==
X-Gm-Message-State: AJIora9DrVpghZbRfWoPc080e8a/1M8BCUGDdsMaFvjj3KmvH7UWDFwt
 hzrEoaVyay/91LuOLmtLtEs=
X-Google-Smtp-Source: AGRyM1sQxQEL8AlR6JmsnMMwjL1/mdd6o/NKyxK5nUr92sXnXv7t0rBLO3w24er8mGQDNRHufbpAkQ==
X-Received: by 2002:a17:90a:f2d7:b0:1ef:8859:d61 with SMTP id
 gt23-20020a17090af2d700b001ef88590d61mr1812191pjb.215.1656883742538; 
 Sun, 03 Jul 2022 14:29:02 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170902e54a00b0016191b843e2sm19527228plf.235.2022.07.03.14.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:29:02 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 07/11] target/openrisc: Add interrupted CPU to log
Date: Mon,  4 Jul 2022 06:28:19 +0900
Message-Id: <20220703212823.10067-8-shorne@gmail.com>
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

When we are tracing it's helpful to know which CPU's are getting
interrupted, att that detail to the log line.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index e5724f5371..c31c6f12c4 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -83,7 +83,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
             [EXCP_TRAP]     = "TRAP",
         };
 
-        qemu_log_mask(CPU_LOG_INT, "INT: %s\n", int_name[exception]);
+        qemu_log_mask(CPU_LOG_INT, "CPU: %d INT: %s\n",
+                      cs->cpu_index,
+                      int_name[exception]);
 
         hwaddr vect_pc = exception << 8;
         if (env->cpucfgr & CPUCFGR_EVBARP) {
-- 
2.36.1

