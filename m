Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C6C19F2B
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:41 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7D28924A7B;
	Sat, 30 Jul 2022 01:06:40 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mail.librecores.org (Postfix) with ESMTPS id 6F25E24A78
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:39 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id f65so5046163pgc.12
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BbWEiIuyggnyFyXXn6RRuP9nqwzyt9y0LyosHzVyHv8=;
 b=irWbsfVCY7EXryHUEgvv9zXRUHvT+ug+enJTNshE7OTDz6mvljflFWeSCqWVnRKXkQ
 1ViHLbF59Lg2yTUire29uNENqh5ggpCL8Xft8BfQCipC7WfyfnthVLIfbfDOh24ajmqe
 f2uMSigEaEQmQscCfycv6pcncYI0AqXMCnvVQqf3Vi1qL5w/hNSvlRY5iS9qA4r+1D/u
 5RHzG3YK1lQK3d+0ZnK6pQPf3TuBzBTORICLymG6pqP/0oTl/P33fdJKibUW1Uo4se3l
 CHO0ksn+P8Glqzij/isR60c2nv9maWKmUzMm6pa2hmxoJTrlgaNPs1B5TjFnvoeDWUMJ
 j4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BbWEiIuyggnyFyXXn6RRuP9nqwzyt9y0LyosHzVyHv8=;
 b=xOhQ/MVWyBCt+ui4r46bjMc23xpNI+wPwIklpLIe9DGfBK1OhDNpISbGipPU7MRBSH
 Cq7NkiRTQFQ0DzAd1nQbiMNfMRy5Huz8gTn2nh3Jgzslcl1ivoY3RwpTyhLWS0PQ5dOS
 0/3JyPrSHqrrVnEwIjdSpD708n8URAuShy74ZYukUyBPD3xPZdIMwH8POfPmRRRbSWkr
 g3Tz2zs+PQdltVbukWqSLfs+irTFK3TZzrzKK8vuXSq83jInsVCCvMKKIIifr2RR4tHN
 5XgtHZDmWCW3ZkJQQDdDrc0yR1Fwh41rHdHjFgprninqARfkq2EXZEq9vSgaqG+hooUC
 15og==
X-Gm-Message-State: AJIora9KaEGPjkwGEFcrDaE5Pkgabgp7peRjKHEu3UeqLRbtHPJHYNvr
 DgqisAGxBjaEj5lBDqV8tMA=
X-Google-Smtp-Source: AGRyM1vyctu8vP735GDkjlYdyCKhr1opLcOO1hw5ZYtJmbkC6hXPVEihXtTtt8dvGzRGnagm1sJWmg==
X-Received: by 2002:a63:c049:0:b0:41b:823d:43a8 with SMTP id
 z9-20020a63c049000000b0041b823d43a8mr4498276pgi.283.1659135997894; 
 Fri, 29 Jul 2022 16:06:37 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a63e24e000000b0040ced958e8fsm3051983pgj.80.2022.07.29.16.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:37 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 10/11] hw/openrisc: virt: pass random seed to fdt
Date: Sat, 30 Jul 2022 08:01:16 +0900
Message-Id: <20220729230117.3768312-11-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
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
Since v2:
 - No changes

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
2.37.1

