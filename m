Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD9C433EF
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:29:12 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A4DE82481B;
	Sun,  3 Jul 2022 23:29:11 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mail.librecores.org (Postfix) with ESMTPS id 90DC9240F3
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:29:10 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id f85so3502958pfa.3
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nJGaTiX/BLUER+4e6y/h+nDbaqosvJUwqSAtFT+vVk0=;
 b=aG83zP5QRndcmXGzy6NtCswGy5+CVYuR7xtKGKwdXGnRjKK69fjxe2RBr0wa6GwxJz
 Bq+ABRZDi3bXs138PmDcbuqNvYYg3vX+NHtTKj3cb9hvyI+xJaVjCxdk2Sv7wShOaY+q
 pyTHlZH1RexXwK527m/1LiTDS5JSvBAmB3J2e0pw9jOqJa5btipLjOEDoziJy2sHfcxB
 LvqUxpBDKVXLsLN0HcyJpbpXfl18gAUWk6G0IfmULfX+tNNk2dMKSbiEzGPC9gkQxpo4
 6ARt51sUf7r2QdrDWKn08SFacU5zuwmyUIcZ+swHRi1uyRbOuftbm+kdqIgcsdqR7zj8
 1YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nJGaTiX/BLUER+4e6y/h+nDbaqosvJUwqSAtFT+vVk0=;
 b=2XeL0adK8aGg15XuGrqpEUOltU3kiN4BgHbA/LLG9g+gQPouH9+ct3P9gbvuzV/Rg8
 1Qu8qDMDZpVW+2Wk3QOA0DJiisoI4rgASuYkuV5Ce7mQup72XdVqdGhYKugpOH5f7Www
 9cyVClpmCEzo347JNdMeALCTBuh4B91pp6zAaf78I1KMpkSwrTT5L0O1GZoIJlFiKP91
 iiTq7XWHoSXMDuxJNgHZTp54ujjoXQluxXWGI3x77pDeO8Ga+C5B7bFpGWzBQWiMzpuO
 uhbuuOAfaGVe2TZBDUDag56ShxvQRsMrG+Q82RuU/HMsSjcxvMOEYw94smXvejE0pxbt
 x4WQ==
X-Gm-Message-State: AJIora+y1kou6UT9x23zzJhJnbmSCY4XUzTbsVzwAYKBcJ4hdS2n1cdn
 l2YsmsWD3xsexs+daFLVNwvr3paVOmU=
X-Google-Smtp-Source: AGRyM1tPl4bc4BIMVpPPbZZXnvM3liTPJmo88w4IS10HD5n/x/GTAc4+G5xZp2MGJDCj516I4G5LOQ==
X-Received: by 2002:aa7:861a:0:b0:528:3f68:553 with SMTP id
 p26-20020aa7861a000000b005283f680553mr12554900pfn.9.1656883749146; 
 Sun, 03 Jul 2022 14:29:09 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a17090a948600b001ef8264bc1fsm1604447pjo.14.2022.07.03.14.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:29:08 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 10/11] hw/openrisc: virt: pass random seed to fdt
Date: Mon,  4 Jul 2022 06:28:22 +0900
Message-Id: <20220703212823.10067-11-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
initialize early. Set this using the usual guest random number
generation function. This is confirmed to successfully initialize the
RNG on Linux 5.19-rc2.

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index f1d1293eeb..a301d0d769 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
@@ -130,6 +131,7 @@ static void openrisc_create_fdt(OR1KVirtState *state,
     void *fdt;
     int cpu;
     char *nodename;
+    uint8_t rng_seed[32];
 
     fdt = state->fdt = create_device_tree(&state->fdt_size);
     if (!fdt) {
@@ -186,6 +188,10 @@ static void openrisc_create_fdt(OR1KVirtState *state,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
 
+    /* Pass seed to RNG. */
+    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
+
     /* Create aliases node for use by devices. */
     qemu_fdt_add_subnode(fdt, "/aliases");
 }
-- 
2.36.1

