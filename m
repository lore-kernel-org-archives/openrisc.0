Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88556C7EE26;
	Thu, 11 May 2023 15:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbjEKPKK (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 11 May 2023 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKPKJ (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 11 May 2023 11:10:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2A810F6
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so5904654f8f.1
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817806; x=1686409806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woscPhkVSzEl8I9GHPQdrPr9fWimU19q3FnzxdVnQus=;
        b=GVco0JmF6YjIS44Dc1aXt1G422QkEYcS3DNxNfooT40ONaa7ntaAdAT59UCcKVYWuD
         DRls+kLQAPbsS/vhjlkFEtp8Bj2yY2ySt3EPjxdb582+kVYEEJDpBpC9/PN0ClbXNC9a
         lIXQtOYJYYPewVtUUW/rwWn47w3IQ9BCR1YG6I78tLwwV8isVJOoUGWFfjr1Wmd7UzTf
         Jgq/YT/Jncj9uOWP3AqkehjLKzcOIcgS372Sp9zS8QHJP5lCMgBNh7nTbcwTp3f0XqIW
         xKwKPXbUiu+lHyf+0+Ia8OcshyxGZjBsGYOX9EvdxIyfVsNEWWewocy+BO2TsgObR+gu
         sj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817806; x=1686409806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woscPhkVSzEl8I9GHPQdrPr9fWimU19q3FnzxdVnQus=;
        b=R4p4pukDh1yWJhZVQinc4Z71BZKwdGMfdKyds2qYm1e+hAuIL9NUi6H9N6i4zoV5XM
         vmjI2uq542glpbxi8KzvtJsP8uZmILz06tfnRLaIHYbffuOyJUQICIcqQxx4vx+J67Gv
         lZiv9SZWozXnpECaa4piuk+iYky0x/w2j51ocCiOUgQGgJHDEvfu80wjGApEhw3fazSP
         IZSyXC26cH+j3VbQ9cxVLw7GBeHGFbRhbnHygnej57EmtYChQxTkw6z+4QeXJYuT/5Uz
         AGA3TRTu3MwIKpbUMejek+aF8ioux73/gfaOcbBeAYfiJBA/ba9hSfSvybSxKhkt0nAl
         VsQA==
X-Gm-Message-State: AC+VfDwofFq+ibdcxCSwpWomnTU7Dl+igRrI3EeQCGIDppbxQkq7us8B
        2ijVXm8cGwxCFOKVOpHZEXg=
X-Google-Smtp-Source: ACHHUZ6pZxkH20q8pvuG9JNq8nxaz7BTjcYoa/jpxSw7s4UDtpgaFxEor38jIkCDVTvyDWpe7nYCeA==
X-Received: by 2002:a5d:6285:0:b0:307:b9da:1547 with SMTP id k5-20020a5d6285000000b00307b9da1547mr5069301wru.12.1683817806426;
        Thu, 11 May 2023 08:10:06 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0030631a599a0sm20603811wrh.24.2023.05.11.08.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:10:05 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/3] target/openrisc: Set PC to cpu state on FPU exception
Date:   Thu, 11 May 2023 16:09:58 +0100
Message-Id: <20230511151000.381911-3-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230511151000.381911-1-shorne@gmail.com>
References: <20230511151000.381911-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Store the PC to ensure the correct value can be read in the exception
handler.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Since v2:
 - Add reviewed-by
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

