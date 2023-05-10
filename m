Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A5C7EE26;
	Wed, 10 May 2023 15:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjEJPci (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbjEJPch (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 11:32:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879630D4
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42c865535so20609625e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732755; x=1686324755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csrTYP46uv8wz6vyHOZQLXOhfuaiNnRYRLiW7uRVmzE=;
        b=azReCyQo9AgaGA3ibfYJryDdwquXFqJwPZwK0X3Dm7urN26R+XZbpLATyGxBarPO+i
         k7ftL5jcOPnE7EKvuFlaLv2TD9/5/IvTkpkhFHkWLAB+8ukQkPkuaPRVC9rXpC3f6KrO
         Fs1NSosBcw3/1CEtTRe1+NDu2yBY4Q07/EDs7VQTvFGBCsnFmZWenqSSfIVxmgnlvpe8
         ihlMC3tonynFOnUaDURRitZcA5QkJlhKX5jRlFaj5bPqXiPU1t06cTBaAP/HHlSvmKMa
         ybA1xkRQPPjGPmS8KoOAvx96aiiEL33i+KsqOGr3BN3PUckYiorJFkOPs48TVNeVDmV8
         xMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732755; x=1686324755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csrTYP46uv8wz6vyHOZQLXOhfuaiNnRYRLiW7uRVmzE=;
        b=S4sdtoGeMh9ARBwcyjPYpYFQJXtuw1ePVJHwzvstrV2lFJbF6lPCpnqV4QCYxQEKyg
         EMO0LabhZyzZoyvjvL5E2SNmAxhU5HGunZ1RcG1WyAdvXCRC+/4AcSJ+5T2H2oPHpE+w
         g2rWpK6MmP1yM+hEnAYKbKekHpGIAKZVumMaBw17+PeGV2AQCvIJn8jkWmoeEwBkaxfu
         Lihrk138wfcSXRmLbzK/k8s+fpmhXZFdyNkQD59VgfzfRZVVQ9cET38MBVXShIF4iaZm
         JYm1vledj6fOLybmLJOnYwJuE56Sc7kCJoj+ZzWtz7JY1Wuv6nP1cNuDvj6LxHpQ9AeH
         PVGA==
X-Gm-Message-State: AC+VfDwxAlBdOSCOs/s91tZ1xHXPWJDoJZwBFOZ4oLtXdMybD3YpG7cH
        yugexhk9tOrKPxKM5KPXGCE=
X-Google-Smtp-Source: ACHHUZ4d8w3jwX0NwLaCbLZ+ubxAXF2N260dZROoXaUG1NICx/cqcEC0cnoWdEno8KdyavlNhKXpzQ==
X-Received: by 2002:a7b:c5d2:0:b0:3f3:2b37:dd34 with SMTP id n18-20020a7bc5d2000000b003f32b37dd34mr11817929wmk.9.1683732754947;
        Wed, 10 May 2023 08:32:34 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003ee20b4b2dasm22951062wmf.46.2023.05.10.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:32:34 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 2/3] target/openrisc: Set PC to cpu state on FPU exception
Date:   Wed, 10 May 2023 16:32:27 +0100
Message-Id: <20230510153228.264954-3-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230510153228.264954-1-shorne@gmail.com>
References: <20230510153228.264954-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Store the PC to ensure the correct value can be read in the exception
handler.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Use function do_fpe (similar to do_range) to raise exception.

 target/openrisc/fpu_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index f9e34fa2cc..8b81d2f62f 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -20,8 +20,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "exception.h"
 #include "fpu/softfloat.h"
 
 static int ieee_ex_to_openrisc(int fexcp)
@@ -45,6 +45,15 @@ static int ieee_ex_to_openrisc(int fexcp)
     return ret;
 }
 
+static G_NORETURN
+void do_fpe(CPUOpenRISCState *env, uintptr_t pc)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_FPE;
+    cpu_loop_exit_restore(cs, pc);
+}
+
 void HELPER(update_fpcsr)(CPUOpenRISCState *env)
 {
     int tmp = get_float_exception_flags(&env->fp_status);
@@ -55,7 +64,7 @@ void HELPER(update_fpcsr)(CPUOpenRISCState *env)
         if (tmp) {
             env->fpcsr |= tmp;
             if (env->fpcsr & FPCSR_FPEE) {
-                helper_exception(env, EXCP_FPE);
+                do_fpe(env, GETPC());
             }
         }
     }
-- 
2.39.1

