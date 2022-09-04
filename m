Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47570C6FA83
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:24 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9009C24B2F;
	Sun,  4 Sep 2022 09:26:23 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mail.librecores.org (Postfix) with ESMTPS id C82C324B3C
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:22 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id n17so7492875wrm.4
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=OPQrnSVeL4J+2x1UvAxj0DL+BYtY7LPxxx3tMOdidn4=;
 b=FERCrkw+LGR8shAFQlEfaeK4bw8ifWV3EQzprlJq5v2mc9tTRs8rM5M12IApCbU7DJ
 el+iHdRbIQ4gzcYC57GW6sLtx6NAWF9CkP+8xG3N3UyHS02fJdSwyLfwKP0vywJJEM+M
 3d5oslaiW1FoXLnFN7Mu/xMX7owBoWVEntUvZkriz7Sf5EdBHeVWdoWyzxsc24JAEiO5
 7eYCAIvXH60m69EtgJY4IgHfbfRPAWBXv1Ax+thC4vRv875ZdqtGs2giFqUuqKg8pRsB
 JcLlvCs5yv+7uOq0VgtjG8JsXol7Rpy3g+QYmIsMf9Jz2PgpWAamjEoOWS3UxhLjXoh6
 CO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=OPQrnSVeL4J+2x1UvAxj0DL+BYtY7LPxxx3tMOdidn4=;
 b=O8HV22j+2uSxBQFyKqL+2uhHiN+lL43gF+FiKR8mNLNVdD15V80sJ4cGap8YuxlISE
 H/ctAOS3yS1N+CCynUBGAzqBZy9aSLAYyI6mf8oUmM1xD6BkNpmuKUkq/TQs8EI0izVZ
 Lf8/MWACkNvcO67L9IM19vrqIeZRjKyCMG8m7/CfFdRNK0a5ig3yM3VIZCR5OMkAacD+
 BrAJIPX8JlIO+GJSy1pBCfPdAo1LssO8DxCBk0UE3C5aN/1XcRRryECs9CtpkbGtCApT
 wFoAnN5mOW9S8dlFuI1Xrrz6DDM2j+K60cbQqPTB23MMU32vaY+1I+GE6TtnnirkvaBb
 u7HA==
X-Gm-Message-State: ACgBeo3kJMtg93kNAJl9r5YqoeZI79k/a+6UpkdI9B9czMyq+/9fSPsS
 9V1BsRtM7ZnuIJMSmlSb4pE=
X-Google-Smtp-Source: AA6agR6GXxwmH381Y7cjsnT1zkZT6NnO473dPStP4UVoAzFmGrMm38UFEMFDgdzM6e7TuB9jCoCsxA==
X-Received: by 2002:a5d:4b08:0:b0:228:7268:58c6 with SMTP id
 v8-20020a5d4b08000000b00228726858c6mr436956wrq.525.1662276382478; 
 Sun, 04 Sep 2022 00:26:22 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 c13-20020adfed8d000000b00226d217c3e6sm5446100wro.64.2022.09.04.00.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:22 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw/openrisc: virt: pass random seed to fdt
Date: Sun,  4 Sep 2022 08:26:06 +0100
Message-Id: <20220904072607.44275-11-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, openrisc@lists.librecores.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
initialize early. Set this using the usual guest random number
generation function. This is confirmed to successfully initialize the
RNG on Linux 5.19-rc2.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 9a78234a28..f8a68a6a6b 100644
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
2.37.2

