Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95200C433F5
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:13:50 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 87ABB2492F;
	Sat, 21 May 2022 15:13:49 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mail.librecores.org (Postfix) with ESMTPS id D159724960
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:13:47 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 nr2-20020a17090b240200b001df2b1bfc40so13638687pjb.5
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=egjC6NgwBLWYIyKnRSW+X/wYthcyg40wdtxiZu51vtc=;
 b=Eri97N4csdJvg9j8fzgy7MS1YyQ+NxThLJw+0XcBkwt0rJ1Yl0MhA7CKtyi3sFq4/3
 ULDf/1UNk03mIhAcJHfX7ygdKGmgIuMQCynaG7TnOKget9/Bz3FkKGmA7RcApHDDfMn0
 ruE2gs/UdKz88zxVSTbSzTgfIUVN4tHFGwD49EwfHsRcBRj+NrUV9EoNwsyyd2ptsFeU
 F688McRuRwqfX7YU3NsutYHF3bkqt6xMcDnzCunYHdsYLrYcJMocb5VV4TEB94yz2SJ/
 5JOgRW0ngIxg/Aj0RLNItndbolIiTuDWWUJmCgV+xXtd5fse1Jw4rouMplXomwJKTVOs
 WwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=egjC6NgwBLWYIyKnRSW+X/wYthcyg40wdtxiZu51vtc=;
 b=w5/MoGghQcV4i5vdlc4spHakwTQliJ1D3HvT8w/0Tpr5aSijkhgyTVk5fYTknqo069
 wKgpvMNcE60rsVcdL+Cux53/g1P93IBw2fClY18kc9dZ0Rk/SOnG6q5ZapzNvaUnVnzy
 MTmHtvyW5YTS911EkFgOmALMJoUj4Qb6Hf53xEBzL1RPVtJ8VVO7+ZeEbk8tEwy3jqin
 bPXUZNxciehk4iNrzJsjmKPLlFNQvl2mZihukAacJ5YP0lYTLxDvDE/jDiIrWjrOxwcq
 Iurwl8BSH3wJw4ej9sayCRsKq4km7khQjcCICn1XKrzJy8WGbuLx0S1CKLu8JDbPkB4R
 JHNw==
X-Gm-Message-State: AOAM5301S7cisPGXVqpTwlSiWYNQQU25/uo0Jh1m/xuJE+wEn2A4RoC7
 N7zF2Orm0mTUK1a2venAUUkdbTtY4l4=
X-Google-Smtp-Source: ABdhPJxkPxXSelXTcn/TSy5d8joziO5MtffGIlNjryF2zLVJkVfnQdR0EZUMgSBwiqMSUdHFgvcSmQ==
X-Received: by 2002:a17:90b:1482:b0:1df:5b39:8a4 with SMTP id
 js2-20020a17090b148200b001df5b3908a4mr17034745pjb.233.1653138826467; 
 Sat, 21 May 2022 06:13:46 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1709028a9300b00161a9df4de8sm1566514plo.145.2022.05.21.06.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:13:45 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/13] openrisc: Add support for liteuart emergency printing
Date: Sat, 21 May 2022 22:13:13 +0900
Message-Id: <20220521131323.631209-4-shorne@gmail.com>
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

