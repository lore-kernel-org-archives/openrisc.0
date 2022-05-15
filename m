Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE43BC433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:20 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id F1D65248F2;
	Sun, 15 May 2022 14:42:19 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mail.librecores.org (Postfix) with ESMTPS id D4B2D24808
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:18 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 o13-20020a17090a9f8d00b001df3fc52ea7so919430pjp.3
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LZhkT/STYABSG9JFFXmVnUhiG8e1lb5tF7lB29mjolw=;
 b=HTEYr+6PFZb39JW1W9CGgOnL+UBCeh8qfaIHP9HxIb8+fup5A+23/EYQbRXR9M2ipS
 iV1IFYNfg6D72qQ0Th6GWW8Fn6IpEF6vXgfKSsquVLv7XaPL7pxuL9vGARqCDpOsyhwB
 upIXkH9tPsooCuGm+y0jYJgvjDW7pysBYvaBQ52qzT1ognIvUBd2O572jWgk8FLCSsD9
 H2W9PszQLF3DwERFaUsUm4aosAajMnAI/KzDcENl/6nncvnKkSbqfP+lXlwFV9Ml59g8
 laY4XsgWMaFS+cQ+Skq0b3oHBaavVI42dRTbx9ebIyFUl8cdUdezBXQinFto1hdsNQD4
 fm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LZhkT/STYABSG9JFFXmVnUhiG8e1lb5tF7lB29mjolw=;
 b=ccHrYJDw8l/VRBgDuyzsVbqjSHfxFUXk2POLqoztVNakAiH8ZB3d1yGOWmHKJc4p1Q
 KoIxe9L99PCqJqQB4qEz72R7WkjBvdmt37xr72kCmSygFeUAj4zjb+mGDK+B5jKnCVYj
 c4LxX9dC6lCKQ0JEkHS3jS+do/q97RFtzItuXZ5okjFgcUUGnKBke0ZaYfUfQ0HYQ4af
 BOG/IcesOY9DmKxyBVa2kkePns7CquoYGgJdrfj3QScJ+4/c8FiNN54QOp1euOJhoSMC
 fZl4VElR5FVfXaxaFZXjHXKJEMOkpc39isKdc3+4ZnWmVOCfggFMvaSjm4QQePAc1R0X
 wnyA==
X-Gm-Message-State: AOAM5334IQKELPZMm3zbCCwCOxq/uqNeJIPE9pJbaWfkgn3QY/DA7hYZ
 7rhx4Bn2qslEKLmPEUcAvfg=
X-Google-Smtp-Source: ABdhPJyegSgNu3P86pqOLF041EckwBsKCfaN53VQlGxpKQyqJM4h9bAQ149bfGSkEfyYv+DRpOoQwQ==
X-Received: by 2002:a17:90b:391:b0:1df:42e2:ae17 with SMTP id
 ga17-20020a17090b039100b001df42e2ae17mr2312009pjb.198.1652618537439; 
 Sun, 15 May 2022 05:42:17 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a1709028a9500b0015e8d4eb24asm5058042plo.148.2022.05.15.05.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:16 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/13] openrisc: Add support for liteuart emergency printing
Date: Sun, 15 May 2022 21:41:48 +0900
Message-Id: <20220515124158.3167452-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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
 arch/openrisc/kernel/head.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index b1f3a65c271c..21db50563f97 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1555,6 +1555,17 @@ ENTRY(_emergency_putc)
 	l.movhi r4,hi(UART_BASE_ADD)
 	l.ori	r4,r4,lo(UART_BASE_ADD)
 
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
 #elif defined(CONFIG_SERIAL_8250)
 	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
-- 
2.31.1

