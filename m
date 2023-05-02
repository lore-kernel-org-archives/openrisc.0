Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD78C7EE26;
	Tue,  2 May 2023 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEBS5x (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 2 May 2023 14:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEBS5w (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 2 May 2023 14:57:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B710C6
        for <linux-openrisc@vger.kernel.org>; Tue,  2 May 2023 11:57:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f7db354092so2629247f8f.2
        for <linux-openrisc@vger.kernel.org>; Tue, 02 May 2023 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053870; x=1685645870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEF1qi6MMuB+c4HTiM42q+lLMXcDmiJq+W9maCZXnaA=;
        b=kDBHiS6FPPfleL2cXIDNRnVtSgSb+9dLs6tuBIuhecfoD2tL0SQrTJjrbz6rK2IrZF
         eWyWPOCTkF/UhEsGuH9PlUW/XFWSDDqmxJ9WMhQfQCuAmtCzUSm8VCFF1eX229r6lPFf
         zWpXa/Cm8zOiMRK6w7KNK1ahXt3xP+Grb2y4xBUH+SXK/wX514GJm6+j+rN86W1g4M12
         9ofy4klE3UV83KQJoRiSv2X2d0ZJybE9SdLLybjW9RvG/r3ElmxQJapSgUXQx/sYSUSi
         4CXNZsPDZtd20+kbHHu/LOceGk9bmYZ2SNLLG1P/F4G1vI/xhz7b1cxlVPVZJ7uFufQE
         Lngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053870; x=1685645870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEF1qi6MMuB+c4HTiM42q+lLMXcDmiJq+W9maCZXnaA=;
        b=kYimJNoKGci7dmkhhZwhvVCDdBpFeqUbMoXAoO0sj9rJgbbOcRVOtw9nsaZkB1ogJt
         Af2+R0gwIo/meujUY1ClkcOwW7Ew5uYEL/AbkbmQzSGqpe/BzC5Vs1kCBUM7IU2W4eeS
         pn6fXudteH/dIbSJtCPkchb1KGmcNSaSTw2RmroCd9PwE7ZNLBALIjzPjDRXd5Ez5odE
         VwYuViM4WYDJ1S9ph9XvQEBxyDPaqav+RBZ1fkZ+az3fv/Ww49vhCqiA+ORmZ2nAlFqV
         DXR63tUsE9E7Pn10UoLJJq4suLgsfcCSP1cU1mYsPqsUz4a75rQjjy3LUMbLPdm4rgc9
         RIzg==
X-Gm-Message-State: AC+VfDzKsvMjEoxJrfxXzHKAyK0hJ/m0XWK1dlnRWvz8izEkSzQyp9aX
        MdEdw/VG6nfAA5fH4Uf1dqgdsR9og88=
X-Google-Smtp-Source: ACHHUZ4S3dfBdfy774H5DOYO04fbZftVf7nnvy1feT14LQdwK+lxJm6piyX4Alhews/LsFoB0ERmbw==
X-Received: by 2002:a5d:460f:0:b0:2d8:47c7:7b50 with SMTP id t15-20020a5d460f000000b002d847c77b50mr11827686wrq.1.1683053869896;
        Tue, 02 May 2023 11:57:49 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdd4c000000b0030635735a57sm3073320wrm.60.2023.05.02.11.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:57:49 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 3/3] target/openrisc: Setup FPU for detecting tininess before rounding
Date:   Tue,  2 May 2023 19:57:31 +0100
Message-Id: <20230502185731.3543420-4-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230502185731.3543420-1-shorne@gmail.com>
References: <20230502185731.3543420-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

OpenRISC defines tininess to be detected before rounding.  Setup qemu to
obey this.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 0ce4f796fa..cdbff26fb5 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
@@ -90,6 +91,10 @@ static void openrisc_cpu_reset_hold(Object *obj)
     s->exception_index = -1;
     cpu_set_fpcsr(&cpu->env, 0);
 
+    set_default_nan_mode(1, &cpu->env.fp_status);
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &cpu->env.fp_status);
+
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
     cpu->env.picsr = 0x00000000;
-- 
2.39.1

