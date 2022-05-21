Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E4C433F5
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:18 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 797AA24758;
	Sat, 21 May 2022 15:14:17 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mail.librecores.org (Postfix) with ESMTPS id EB193247C2
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:14:15 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id a9so7886980pgv.12
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
 b=nmgM+6vuXjpX8KiwaDgzVgiYN2BD9hnKoi1p6MXLnRPMVGudkXgQk5rpmk2WEZeSfD
 TUU4GF4qa3c0hBliZhaoUoLCI3n5c/bqAS0RPC4swau3lhMzh+cE1IvOrbl6zy5r6MLX
 W2n+UbMqKQIZpgneQz4e6zjiLZu7FTYwfuekLnyGUc+SLYShDDHe04VjYSuiwqxuv8U5
 0PdvQsz/j42plRlSL7E6VxsATCEdO3cC0OcQ3eDyYhFlFA+QZROMVz0MIImXVQiwfamN
 OkACTC2CzmtHqvTadDkcfUy1nYLliiFahuyjCbV0lpLPOlZNHjrT3cTM7AsF3uCCGDGP
 /CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
 b=mRbWSwOFYcDcUprgF+mAZ4DqC4H4JEdDin181L78aENRoHAm7sfro8iBJ+49vD8NXY
 1/XIGXH1pJn9KMviUQOnwKEDxMD0w23S3mRiBjn3ptyyz8Wsq4B6ddDFNRYQcLptOgM8
 Ub0PBKIT88P1XMQLXMcXdJ3UOdQwaF3GXoJam4wSaStNPNbsGEToz7TIEQ/X9ztUKdYo
 u6OWylajA1Y4ret5ETnOWr/1Bg720WN/wnUk6DdnbUihm56cVtO2ngddVd+Se3l65MWq
 K7YCCI+2/MG7BNEPUPoBZP9ZsTw0KIuOYKJERlnZQhDLZmvNpYh841Z/W00MSH7B69xE
 /9mA==
X-Gm-Message-State: AOAM533djTGKZForL/qeJyIbRs6ZtUx6+aVJMCAj5G35uv0A0Nuw6XNw
 47ZYJm27mpEaDv5MhfHsEBQ=
X-Google-Smtp-Source: ABdhPJzSXnY7snJEhqn+uj+twSGinI9pDclYPisFikM4HmtEYq3hRdpqXVRiekvfzyKo1ySKSWhiog==
X-Received: by 2002:a05:6a00:21c6:b0:4fa:914c:2c2b with SMTP id
 t6-20020a056a0021c600b004fa914c2c2bmr14746058pfj.56.1653138854479; 
 Sat, 21 May 2022 06:14:14 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 a31-20020a056a001d1f00b00517c84fd24asm3577253pfx.172.2022.05.21.06.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:14:13 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 11/13] openrisc/delay: Add include to fix symbol not
 declared warning
Date: Sat, 21 May 2022 22:13:21 +0900
Message-Id: <20220521131323.631209-12-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Add asm/timex.h include for read_current_timer prototype.

Sparse reporting the following warning:

    arch/openrisc/lib/delay.c:23:5: warning: symbol 'read_current_timer' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/lib/delay.c b/arch/openrisc/lib/delay.c
index 036ae57180ef..5e89e4131304 100644
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/timex.h>
 #include <asm/param.h>
 #include <asm/delay.h>
 #include <asm/timex.h>
-- 
2.31.1

