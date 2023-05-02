Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D4C77B78;
	Tue,  2 May 2023 18:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEBS5w (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 2 May 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEBS5v (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 2 May 2023 14:57:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A1CDC
        for <linux-openrisc@vger.kernel.org>; Tue,  2 May 2023 11:57:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso530811f8f.2
        for <linux-openrisc@vger.kernel.org>; Tue, 02 May 2023 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053869; x=1685645869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWQ/Z9BlPUubmldvNXKKW220gK42PZJS+hO6IM/QHuo=;
        b=hPf05h8ARyAkMITsL8o91UOAv2cXi1iHPKQpXrC41Cao96Zy1UnWm+nUuSw4n3i8NT
         JJEc8Y1BxYPQg3h0kULgoNFOES8Lv7BKm8r1AKRY+qVW38a2zNkhbKCozciHS+3uQym+
         iq8oXc0kK+PvepCL68bnrpeRLD/Uq2pU/AwoyejUtaQ23Any4hmCUvoZNAksJcAP4s1f
         Xb0Cd0epBxVsSEbAQYZ5c6xx1AYB2FXFcujkM/2gNKq6e1oZ2xpW98LwhkqHWdc7nvO7
         hTJLYXkR8Jbx/eZsvHfLQQbBqTZsU/GiFD0nWwC0C25sJaxjgZ98DbAcucaTypEXwLpS
         moPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053869; x=1685645869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWQ/Z9BlPUubmldvNXKKW220gK42PZJS+hO6IM/QHuo=;
        b=cLzcEQ+cezp/yhJcfNxlFR27zH7OwZdNa1Oe/Q8yqBB88GJiEMVe9SSbp/5FvBlTSi
         Fg8emrLYrHRlXwTNnODa2/JjCNtWZEG+YvfO+ZsdYVcS4KBowBlxod2l0mJk77fITYoq
         KYt/Evxx+72sk+dIbw/2+Bwm9TjPUgoFlTyVZZyO2Ud1UIswGrW0eKDnUT+DEnzLBtET
         WLsTvX/i4+MU1veFFKahTp3DzsT/onQNCsIaAGUUfEjk4IENsxpv55Yw3D8GlEWIzpu/
         XILPQ5SZoDsb7NRlegKQcdgvfv7jRm5rMzMbulS5F0CF5ZqpC83t/v/F0tqcO4iywZNb
         fSTw==
X-Gm-Message-State: AC+VfDzxX71cSGEpFlEmLRlXogq42YOb8Xr8/PLQDL/I1/85HgpiJDcf
        X6pBpvcuW/76Lo5Uf+MkOKM=
X-Google-Smtp-Source: ACHHUZ5lhNppFFW3mrxRZ4Oz09TQIfOQGSIfePGoH7teb8eXrs1LQ0d4RmyrG/zLHGtpq4h3Jb9uUA==
X-Received: by 2002:a5d:634e:0:b0:2fa:6929:eb81 with SMTP id b14-20020a5d634e000000b002fa6929eb81mr14018614wrw.31.1683053868763;
        Tue, 02 May 2023 11:57:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b002feea065cc9sm31656202wrv.111.2023.05.02.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:57:48 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/3] target/openrisc: Set PC to cpu state on FPU exception
Date:   Tue,  2 May 2023 19:57:30 +0100
Message-Id: <20230502185731.3543420-3-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230502185731.3543420-1-shorne@gmail.com>
References: <20230502185731.3543420-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Store the PC to ensure the correct value can be read in the exception
handler.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/fpu_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index f9e34fa2cc..1feebb9ac7 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 #include "fpu/softfloat.h"
@@ -55,6 +56,9 @@ void HELPER(update_fpcsr)(CPUOpenRISCState *env)
         if (tmp) {
             env->fpcsr |= tmp;
             if (env->fpcsr & FPCSR_FPEE) {
+                CPUState *cs = env_cpu(env);
+
+                cpu_restore_state(cs, GETPC());
                 helper_exception(env, EXCP_FPE);
             }
         }
-- 
2.39.1

