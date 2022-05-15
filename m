Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E6C433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 01:40:14 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 412C3240FC;
	Sun, 15 May 2022 03:40:13 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mail.librecores.org (Postfix) with ESMTPS id 45FEF240FC
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 03:40:12 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id c14so11017811pfn.2
 for <openrisc@lists.librecores.org>; Sat, 14 May 2022 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D8CeNai5hoihLKkHUXkY+f/fMIbV4YMBEU8bGlpc+0s=;
 b=ZxVu/cWR+IvYjKbtcVhkX6CgIMce0aOWzjalwL2wGshyORidy66P6+Bjc0EHaLxZQX
 zWJs0Us8zRmxjs8KbEqS3wFXA/hxIXoFOddIxK3QalwddUI540zMCbV7god0uIISGdcI
 UrO73R5eVF6XkvfU/5GDhd5+jbvgF+/QK9h0Y/Ot2PolWUFN5sZ1nZBxrmtnkdjenH6r
 E7By7Bemwhq6vXXohRwHH+E9g/B2I4tdxJqMrgpaTlRLxPlX8Qav/yZp9JLKtmpbL1EG
 ZgKQTDGOeXOHlg9JrrxDL0TjMDSw6zu15qdGi0PWYFAT+7i9GfNvx+zLx+89uArvtxaM
 WaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D8CeNai5hoihLKkHUXkY+f/fMIbV4YMBEU8bGlpc+0s=;
 b=KXTiR19DlNX92pW3IUGLl7J6vwfj9WnrJDhQbQPhCgO8vmBgD2Qq7CEustIjo3r2k4
 Jcz2aiWHUszofae2MRzgUMDvM4R1XwtxerdvjKaA/D+SIwuUHDTqegJLmIhK3CUxEmP/
 4wY95go/nq0UNRPq2VIeC9LXCLv6BK3fppe21JfR1Sod5bytYW//L2fWxsv3EARz7P22
 FcAlkto7eufsOWQ1ac01d+/qCuS4kgTMvcm81LynX8SQe1dNiuvsx39EhAlA2EgmgTPh
 lg7aW7Cv6+mvDA5cGyNU4nx8a2mffHLligKzWEDmWnVvASAhPtRk1oO9x5QyzU5/k3By
 iLqw==
X-Gm-Message-State: AOAM532NEsam2NtbgPh4renGscTgYoDqwNV5BS0Lp9h9rWmugucP2o6q
 evSJChENpRbnWpulDn8iK7A=
X-Google-Smtp-Source: ABdhPJwqXroJ2r/qacIRI05lBh2vA9pp8s++Pd8zOjIilPil/xXH6iwHXu35zzRJtYFlCWjOpVn9fg==
X-Received: by 2002:a05:6a00:134f:b0:50e:10e0:ef82 with SMTP id
 k15-20020a056a00134f00b0050e10e0ef82mr11597338pfu.45.1652578810890; 
 Sat, 14 May 2022 18:40:10 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a056a00213a00b00510749ae412sm4193425pfj.48.2022.05.14.18.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 May 2022 18:40:10 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PULL 1/4] hw/openrisc: page-align FDT address
Date: Sun, 15 May 2022 10:39:45 +0900
Message-Id: <20220515013948.2993495-2-shorne@gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>, Jia Liu <proljc@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

The QEMU-provided FDT was only being recognized by the kernel when it
was used in conjunction with -initrd. Without it, the magic bytes
wouldn't be there and the kernel couldn't load it. This patch fixes the
issue by page aligning the provided FDT.

Cc: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/openrisc_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 8184caa60b..99b14940f4 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -356,7 +356,7 @@ static uint32_t openrisc_load_fdt(Or1ksimState *state, hwaddr load_start,
     }
 
     /* We put fdt right after the kernel and/or initrd. */
-    fdt_addr = ROUND_UP(load_start, 4);
+    fdt_addr = TARGET_PAGE_ALIGN(load_start);
 
     ret = fdt_pack(fdt);
     /* Should only fail if we've built a corrupted tree */
-- 
2.31.1

