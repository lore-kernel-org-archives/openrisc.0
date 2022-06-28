Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE486C43334
	for <openrisc@archiver.kernel.org>; Tue, 28 Jun 2022 01:29:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9B7BA2017F;
	Tue, 28 Jun 2022 03:29:05 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mail.librecores.org (Postfix) with ESMTPS id 6127024871
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 03:29:03 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id q140so10713805pgq.6
 for <openrisc@lists.librecores.org>; Mon, 27 Jun 2022 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8E+gxTAN8rG2WVxuHrJcDTa+6kpi17eTJQwDbUSCKcU=;
 b=R9593Yh/ziRj+PhSTZGNljtUYtRZ7KBVQKtqvdeZLDtVXwQxmJezp36t50uMBy2Fue
 OAZ8d7yx/Q0WiuCTlblLoLk3ecQIFZRO8frKruDuNlKPHQuYNSWp2xyWEObU8I7+JFgI
 9ercAgwDqi2xZKpblouEWR+LMA/5t/2vbM7AUEo8XmAj1FEb62Fa8pjg1mFFwprsqd/r
 oalvbNOgEQrg92Pyr/he4kQE7xVG6feGS8vqdTagaEmZlFnuDsEiKKjdPk6CFxaLP9aR
 z3FuUjTiB2GJWQ/oj+QkEXWwP8WxPGVo+6XejS4SWK861G0vwzysi2pIUkw7Hb1z8qB3
 v3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8E+gxTAN8rG2WVxuHrJcDTa+6kpi17eTJQwDbUSCKcU=;
 b=iXcb2hbuiDDgBVRA+lpzhsCdeUi9EPaZx5nsEBLon9WzQlgdfYsAKI8kyy/LPnC/ZJ
 2gPYmICIYAu4QlO1rmRXUqIHAd02A5xPdBg2S8eI8NRB1H5TRi6Emuv4XmqRx91C+ZLj
 mDDVmNXtieAGaf5VquCHuQP6iFyXKznv3pnwoXojgmSLrW6sUxrv9dGJSMJdkfXHWZuI
 yIKQdXBKlosl6dCWYo1qrbZ6iCJ5OhaJofcUPeq1GqW9IkjOJpq1ntSSbWVew3BcsHoj
 LwEDIifEWPk+P4C+cR3z1nQBi8ZgwnWxqg5uY5H9z2wDlIEAet9puzDFON9ctA/BZfrl
 +O2g==
X-Gm-Message-State: AJIora9VIfd00BmMUVI9+oQbVKaR29j5X366kj/8OTYr86MkYjdXd9sX
 /A2I3r2kVGaT+YLIjKfLnJ0=
X-Google-Smtp-Source: AGRyM1ua6NTQPrcwr20mLPjho7uV/TLlVfmN+1LnA/K+O1jHWhkJ5PMJPqzE6EuzG0El+n8W3Ez4wQ==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id
 n1-20020a654501000000b003fc4895283bmr15473379pgq.231.1656379741940; 
 Mon, 27 Jun 2022 18:29:01 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 k26-20020aa7821a000000b0052517150777sm7960560pfi.41.2022.06.27.18.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 18:29:01 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip: or1k-pic: Undefine mask_ack for level triggered
 hardware
Date: Tue, 28 Jun 2022 10:28:54 +0900
Message-Id: <20220628012854.681220-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
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
Cc: Jonas Bonn <jonas@southpole.se>, Marc Zyngier <maz@kernel.org>,
 Openrisc <openrisc@lists.librecores.org>, Thomas Gleixner <tglx@linutronix.de>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The mask_ack operation clears the interrupt by writing to the PICSR
register.  This we don't want for level triggered interrupt because
it does not actually clear the interrupt on the source hardware.

This was causing issues in qemu with multi core setups where
interrupts would continue to fire even though they had been cleared in
PICSR.

Just remove the mask_ack operation.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Note,

I currently have this queued with openrisc fixes for 5.19-rcX.  If this is ok
with the IRQ maintainers I would like to have this merged via the OpenRISC
queue.

 drivers/irqchip/irq-or1k-pic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index 49b47e787644..f289ccd95291 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -66,7 +66,6 @@ static struct or1k_pic_dev or1k_pic_level = {
 		.name = "or1k-PIC-level",
 		.irq_unmask = or1k_pic_unmask,
 		.irq_mask = or1k_pic_mask,
-		.irq_mask_ack = or1k_pic_mask_ack,
 	},
 	.handle = handle_level_irq,
 	.flags = IRQ_LEVEL | IRQ_NOPROBE,
-- 
2.36.1

