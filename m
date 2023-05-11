Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13EFC77B7C;
	Thu, 11 May 2023 15:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjEKPKM (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 11 May 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbjEKPKL (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 11 May 2023 11:10:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A810F6
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso19474295e9.2
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817808; x=1686409808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H53SzrgO3ToHMUxDNY/DRv16525yykIj2GicLYBw9HE=;
        b=hhbOXIpv8hae4f1/pgUX5pZtIlTUIB7ChkXXaTzwl1HzlWbRmgQ4RNs/FY1X7ExvMg
         K4HKVAmaaM6pwgOqih5Zc57OvS/6ynVkPEszdYTgtkWLCddYDabnAy3ZqVQV+SN6NUTN
         lMW9qi42i3q0jtgLMMjIFEoIkdZ6To0GWQeHiLMVN2PmnOcnw21LCa903L2f2PAl+oL6
         im+5OAQbDLAFGdGuCEQ1zwuu1JmKhwTvOFQwgYYQfnr0yZlAFKckAQg39wi6ZotjVPKe
         MlwQzwVSL9QEasJ4+6WCjTElD0fhfRv6cTYzy37jMzd0CGOSE6mG7XkSJeCgzN0icozE
         83Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817808; x=1686409808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H53SzrgO3ToHMUxDNY/DRv16525yykIj2GicLYBw9HE=;
        b=HcOXB/KTnY3Dt8cHptt+6ddN0RIAWs6hGJPx95iWTOvXmh07fnM+AUu33Ehsfffzqr
         lR4SVAbLunhGnGIHnNBEp9rAtKJyzC+t2am1APnUrPG/wMmmVAhICyD0i8FLjTX967lG
         I9ZSCCpg74tpsrNoZoGXC43z0bNwxg111cgSjBSZNVQweVXY/x1d15F0UPaBXbDygpWq
         RjxpRTly4ls4SZyHqdnd9wckQg7lacU9QJW/RegWLlAs797sOY3XhIrdhOkxW3d5bN1d
         hGtB02uW3eNku/rCzHXbCFXA9zGATEWvo4E4LFCc6B+ksWvbVM4PHT6ghEvNxs4tpubI
         nzkw==
X-Gm-Message-State: AC+VfDw2ZUlwGdIRs41vh5vtU7x5Mvmfv+R1/t13uipsNFIo8pCc9gpx
        5qftcRhrAjK+tF2jsiQaVp8=
X-Google-Smtp-Source: ACHHUZ4DHwv/BLI291DFdbNZ5tWNK0c7ay1bRzeYlHINJGOP8kdOrTCbBv7xRNet7znJrRPZqIvNDA==
X-Received: by 2002:a05:600c:2047:b0:3f4:2452:9675 with SMTP id p7-20020a05600c204700b003f424529675mr10279607wmg.0.1683817807960;
        Thu, 11 May 2023 08:10:07 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f325f0e020sm25834044wmb.47.2023.05.11.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:10:07 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/3] target/openrisc: Setup FPU for detecting tininess before rounding
Date:   Thu, 11 May 2023 16:09:59 +0100
Message-Id: <20230511151000.381911-4-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230511151000.381911-1-shorne@gmail.com>
References: <20230511151000.381911-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

OpenRISC defines tininess to be detected before rounding.  Setup qemu to
obey this.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Since v2:
 - Add reviewed-by
Since v1:
 - Remove setting default NaN behavior.

 target/openrisc/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 0ce4f796fa..61d748cfdc 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
@@ -90,6 +91,9 @@ static void openrisc_cpu_reset_hold(Object *obj)
     s->exception_index = -1;
     cpu_set_fpcsr(&cpu->env, 0);
 
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &cpu->env.fp_status);
+
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
     cpu->env.picsr = 0x00000000;
-- 
2.39.1

