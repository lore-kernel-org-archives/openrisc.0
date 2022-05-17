Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03286C433EF
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1103224958;
	Tue, 17 May 2022 02:55:38 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mail.librecores.org (Postfix) with ESMTPS id F08DB24967
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:36 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 z7-20020a17090abd8700b001df78c7c209so992215pjr.1
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8oLADI5NiHsnQbc73WheH/PuvP/+QEln3IGTPYBBAzo=;
 b=V/+CTtdeJnUKuXDCGH6M/X0W1zvVeJof1JXCsrKIids9z9JZ0SgI935DIS00Y83oA+
 R3yny+ba7IvenXfqyNazXP5CC4Jd8WKgUa8iZmwPzNRN+I7bhT1OiMtWPRzaTgrogyrW
 LZvO688C9uYRdqu63tP1pscsxGUShlhNU3C811xEUwV44ydjjkkMRCkvxiytyIW2+hfP
 FRRj4HDrp0m2dS5skBKX+IeF9lcN/BYkhAmj5btvClQbZggmvmGlMLk3MDgO8ZBkNTvw
 2zGQxX5kecmDtmagEN+oXedLmt6Tl44L4R3xjwtSo9Dx7P6JDQoR58jKmbRVncpXZJMK
 ojSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8oLADI5NiHsnQbc73WheH/PuvP/+QEln3IGTPYBBAzo=;
 b=OFGGdMTW0IhUiSLsyn21TogPIpwg7LvTgPBm6FOItdCV0GkUblOkxNxKP5/pZVeXtS
 dTjgqcRlzaAEHh1cP5O5vgpQsi9ybDXz3x3aiGHRv10XgkQZan/GeacKwK0MUiDWmzN6
 lXnQ4mDFgg3VzchXjYXZwH6CJt8XvXRw0POT9aOuzCP67DJJt9zS8S/oB5aDliZ17Ef4
 AvZXoDH62VEUrgyUFGPtGR7yshN0t7PByHmVF40xa5XOQME1kpdcIlhzGN0mXeahGBcG
 bl2mm4LkEIlDX/u+cwNYHenDRULtNu3gBL5Vv+g2iVKmJJ2L8altWHKvj9eb+uDHn/Pk
 shsg==
X-Gm-Message-State: AOAM5323P9U8g2FaM/87lOtRbRmI0iX/FNHxsgoBjku+ztKbYTrKOcDz
 /Kd7dqyFhVbwZAIsrOAFZsY=
X-Google-Smtp-Source: ABdhPJyJvaNZcoAIqSz7o+nJGt4QTm8WYq1w1faSsAKwdTtUDvyeYa69U7QGc3rKO0+DKrxPtmlDSQ==
X-Received: by 2002:a17:903:2481:b0:15f:249c:2006 with SMTP id
 p1-20020a170903248100b0015f249c2006mr20168453plw.31.1652748935585; 
 Mon, 16 May 2022 17:55:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a170902e88800b0015e8d4eb28fsm7633165plg.217.2022.05.16.17.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:34 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/13] openrisc: Add support for liteuart emergency printing
Date: Tue, 17 May 2022 09:55:00 +0900
Message-Id: <20220517005510.3500105-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Openrisc <openrisc@lists.librecores.org>,
 Randy Dunlap <rdunlap@infradead.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This patch adds support for sending emergency print output, such as
unhandled exception details, to a liteuart serial device.  This is the
default device available on litex platforms.

If a developer want to use this they should update UART_BASE_ADD
to the address of liteuart.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - Update for patch 2/12 ifdef changes

 arch/openrisc/kernel/head.S | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 7bfa6e4b60c5..21db50563f97 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1555,7 +1555,18 @@ ENTRY(_emergency_putc)
 	l.movhi r4,hi(UART_BASE_ADD)
 	l.ori	r4,r4,lo(UART_BASE_ADD)
 
-#if defined(CONFIG_SERIAL_8250)
+#if defined(CONFIG_SERIAL_LITEUART)
+	/* Check OFF_TXFULL status */
+1:      l.lwz	r5,4(r4)
+	l.andi	r5,r5,0xff
+	l.sfnei	r5,0
+	l.bf	1b
+	 l.nop
+
+	/* Write character */
+	l.andi	r7,r7,0xff
+	l.sw	0(r4),r7
+#elif defined(CONFIG_SERIAL_8250)
 	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
 1:      l.lbz   r5,5(r4)
-- 
2.31.1

