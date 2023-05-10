Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC46C77B7C;
	Wed, 10 May 2023 15:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjEJPco (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 11:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjEJPcl (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 11:32:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83ED30D4
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30644c18072so4941342f8f.2
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732756; x=1686324756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuCoDiAObR/Z2Z2rP0Xwqovsoce8UpTQfGK7ANVfuJg=;
        b=KIsq5p2U2yMptwyjPYSaCRAThtTaWZ7xLaVsAKqsv53q6EYaNAbeyZGRkhGOBSiGpV
         /FtDPMApZ6haqXtdRbhT2zHiiedDuDqOALgALSaxZSPUb5e9mNhff1ZqkydMMiKKCwdg
         ktmlaBEb3jeacH+9jMCubIOiFjUW7aqgeTf0rxKmScofNOnsl5cBRYmFLD2jVwbIH02p
         BGSZqLXJiiRW8zPQ776azOljZnWCXq5VjcnTEMoGCsKmPZPVkpDE/jCb0RMDXwsolvMz
         2UQurxQ+k66wlwfx/W+AlfV9i+9L+hRHdFaVkvclfegtlBbPCBsCXyKupZ5aDLBIt48o
         e3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732756; x=1686324756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuCoDiAObR/Z2Z2rP0Xwqovsoce8UpTQfGK7ANVfuJg=;
        b=iXijOD1GLVn7PcwxHSsPzAeFgo8fi8rcoOl4IgbabBdxIQdzu3dnQyTHA369n4n37H
         hRjeYm0zWbsJKzS9mNDLcLy1qeahIJF+rU381szGY6oBpZifc7eM1zY6zAQ9/joPG83d
         XERFy+cP7qhhUybaUYpekvjG1xckpFtBYNpwIUBO31wVORkjlG+Ld/BxcB0jKzF3qlVX
         wqxL1LDO6siadtTDtq0fhf8jgWekrdscL0JEQXB17DPbEnHMrFaR6To5njoefH3+45MM
         JeL6pAvljPPlBAoE6PPoBMXuh0okwCpVBvl+lECm8r73akf5wMuVhtQv5o5+UyovuhUu
         wu5w==
X-Gm-Message-State: AC+VfDwxLoQtugwGFj6bC2a7bxFDuqr2Cm1Rpv+q1A0YTz6+brTTfnnx
        5RTAjQfSXsOReQDzD7NYIa4=
X-Google-Smtp-Source: ACHHUZ6vtCmnt4hzcunQjfDLkcgztJ61GW3/hX6XhjJkp2R2GdOU49jEXRlVGXgXiaDAqsXiqhB+9w==
X-Received: by 2002:a5d:510a:0:b0:304:8149:239b with SMTP id s10-20020a5d510a000000b003048149239bmr11917447wrt.50.1683732756332;
        Wed, 10 May 2023 08:32:36 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id r10-20020a056000014a00b00307972e46fasm9394157wrx.107.2023.05.10.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:32:35 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 3/3] target/openrisc: Setup FPU for detecting tininess before rounding
Date:   Wed, 10 May 2023 16:32:28 +0100
Message-Id: <20230510153228.264954-4-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230510153228.264954-1-shorne@gmail.com>
References: <20230510153228.264954-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

OpenRISC defines tininess to be detected before rounding.  Setup qemu to
obey this.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Remove setting default NaN behavior.  I discussed with the FPU developers and
   they mentioned the OpenRISC hardware should be IEEE compliant when handling
   and forwarding NaN payloads, and they don't want try change this.

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

