Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FDC433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:18 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C340720D0C;
	Sun, 15 May 2022 14:42:17 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mail.librecores.org (Postfix) with ESMTPS id AFCF724808
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:15 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id l14so1052941pjk.2
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xo5Ghd/3yJ7FLKh8D+m75D1eKalJcyY8jdsgr84yU/I=;
 b=UGg9D7WDFM+99mE8iFDNjNTGmvsUchZrGHxjkNG2X2WjeW5oP6TQ5UaSLuw1EjGEwB
 80Qrsfzq9EPBq+vMCE9MYV22lKl3bQrI+Gzhp4HfsRRoEsCWsyj2buZfsgHIR3Xf604B
 6BBckUO6kB2Xp3GyL5BScTftLwfgXZnZ47e9rxBqjXpAJKnPwnVlozwGpYtdHhVBG8yA
 ljInbiCjp6/0O58ExEx/G/x9wOoxyP52cWeh2xSG9+Bxz1Ap1IxoTjBC1+5q1AVRe3gn
 l3rMTC3o+0SyuQn16w/26OXtpI1bZOftql5KG/gkZq7R+fUxUDnLtctPFH40HZ1ACTup
 83Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xo5Ghd/3yJ7FLKh8D+m75D1eKalJcyY8jdsgr84yU/I=;
 b=keEEJy3ndJdZrzKps5GQ7t7tp8HGjcgsqynfAPYXQkUWA+JsOABrqAivykJbg6EtPv
 zT6+dChSNsv1iidwVm9WG5lKlBLNkLsPDtpG/+R6f7OxOIQ3sDVzGIqc7QjhtoP4j8Iz
 O4YSN4iBewvB/NXgD0FY6ROrZiiRfssSbyLd6K0j747w5zBoTMCzlFrGeeUK0xTye5UK
 OodGT2jZcZXLollbuC6VNdWZbzoFF/m3I2m1tsebjJP9H5A/Im929HyJ9BZl4OTvfSS+
 dRDhUkwXoQA9Sj6993zo0/IS0Kf4StZxOeiW/3Twqsdany/eFOwqz6WYYOZIvUC+KKtM
 AvAw==
X-Gm-Message-State: AOAM533VhDOv+RvobLqCtjwlUPLiXZDNzDMl1mvDYe5d1ggrNnFPtx/G
 KfE4aGP4wDATdHU1UGOBojU=
X-Google-Smtp-Source: ABdhPJyk6e85mbLA1N9B5xixcrQxE0nu+AzMGR3tpBKDUBP72f9SXKWY5HCUM6aRWIS6w0LDcXTlWA==
X-Received: by 2002:a17:90a:7f94:b0:1cb:1853:da1b with SMTP id
 m20-20020a17090a7f9400b001cb1853da1bmr14161696pjl.14.1652618534246; 
 Sun, 15 May 2022 05:42:14 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a17090ae58600b001cd4989febcsm6669885pjz.8.2022.05.15.05.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:13 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/13] openrisc: Cleanup emergency print handling
Date: Sun, 15 May 2022 21:41:47 +0900
Message-Id: <20220515124158.3167452-3-shorne@gmail.com>
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

The emergency print support only works for 8250 compatible serial ports.
Now that OpenRISC platforms may be configured with different serial port
hardware we don't want emergency print to try to print to non-existent
hardware which will cause lockups.

This patch contains several fixes to get emergency print working again:

 - Update symbol loading to not assume the location of symbols
 - Split the putc print operation out to its own function to allow
   for different future implementations.
 - Update _emergency_print_nr and _emergency_print to use the putc
   function.
 - Guard serial 8250 specific sequences by CONFIG_SERIAL_8250
 - Update string line feed from lf,cr to cr,lf.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 148 +++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 63 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 15f1b38dfe03..b1f3a65c271c 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -297,19 +297,23 @@
 	/* temporary store r3, r9 into r1, r10 */		;\
 	l.addi	r1,r3,0x0					;\
 	l.addi	r10,r9,0x0					;\
-	/* the string referenced by r3 must be low enough */	;\
+	LOAD_SYMBOL_2_GPR(r9,_string_unhandled_exception)	;\
+	tophys	(r3,r9)						;\
 	l.jal	_emergency_print				;\
-	l.ori	r3,r0,lo(_string_unhandled_exception)		;\
+	 l.nop							;\
 	l.mfspr	r3,r0,SPR_NPC					;\
 	l.jal	_emergency_print_nr				;\
-	l.andi	r3,r3,0x1f00					;\
-	/* the string referenced by r3 must be low enough */	;\
+	 l.andi	r3,r3,0x1f00					;\
+	LOAD_SYMBOL_2_GPR(r9,_string_epc_prefix)		;\
+	tophys	(r3,r9)						;\
 	l.jal	_emergency_print				;\
-	l.ori	r3,r0,lo(_string_epc_prefix)			;\
+	 l.nop							;\
 	l.jal	_emergency_print_nr				;\
-	l.mfspr	r3,r0,SPR_EPCR_BASE				;\
+	 l.mfspr r3,r0,SPR_EPCR_BASE				;\
+	LOAD_SYMBOL_2_GPR(r9,_string_nl)			;\
+	tophys	(r3,r9)						;\
 	l.jal	_emergency_print				;\
-	l.ori	r3,r0,lo(_string_nl)				;\
+	 l.nop							;\
 	/* end of printing */					;\
 	l.addi	r3,r1,0x0					;\
 	l.addi	r9,r10,0x0					;\
@@ -1530,65 +1534,99 @@ trampoline_out:
 	l.jr	r9
 	l.nop
 
-
 /*
- * DSCR: prints a string referenced by r3.
+ * DESC: Prints ASCII character stored in r7
  *
- * PRMS: r3     	- address of the first character of null
- *			terminated string to be printed
+ * PRMS: r7	- a 32-bit value with an ASCII character in the first byte
+ *		position.
  *
- * PREQ: UART at UART_BASE_ADD has to be initialized
+ * PREQ: The UART at UART_BASE_ADD has to be initialized
  *
- * POST: caller should be aware that r3, r9 are changed
+ * POST: internally used but restores:
+ * 	 r4	- to store UART_BASE_ADD
+ *	 r5	- for loading OFF_TXFULL / THRE,TEMT
+ *	 r6	- for storing bitmask (SERIAL_8250)
  */
-ENTRY(_emergency_print)
+ENTRY(_emergency_putc)
 	EMERGENCY_PRINT_STORE_GPR4
 	EMERGENCY_PRINT_STORE_GPR5
 	EMERGENCY_PRINT_STORE_GPR6
-	EMERGENCY_PRINT_STORE_GPR7
-2:
-	l.lbz	r7,0(r3)
-	l.sfeq	r7,r0
-	l.bf	9f
-	l.nop
 
-// putc:
 	l.movhi r4,hi(UART_BASE_ADD)
+	l.ori	r4,r4,lo(UART_BASE_ADD)
 
+#elif defined(CONFIG_SERIAL_8250)
+	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
 1:      l.lbz   r5,5(r4)
 	l.andi  r5,r5,0x20
 	l.sfeq  r5,r6
 	l.bnf   1b
-	l.nop
+	 l.nop
 
+	/* Write character */
 	l.sb    0(r4),r7
 
+	/* Check UART LSR THRE|TEMT (hold, empty) bits */
 	l.addi  r6,r0,0x60
 1:      l.lbz   r5,5(r4)
 	l.andi  r5,r5,0x60
 	l.sfeq  r5,r6
 	l.bnf   1b
-	l.nop
+	 l.nop
+#endif
+	EMERGENCY_PRINT_LOAD_GPR6
+	EMERGENCY_PRINT_LOAD_GPR5
+	EMERGENCY_PRINT_LOAD_GPR4
+	l.jr	r9
+	 l.nop
+
+/*
+ * DSCR: prints a string referenced by r3.
+ *
+ * PRMS: r3     	- address of the first character of null
+ *			terminated string to be printed
+ *
+ * PREQ: UART at UART_BASE_ADD has to be initialized
+ *
+ * POST: caller should be aware that r3, r9 are changed
+ */
+ENTRY(_emergency_print)
+	EMERGENCY_PRINT_STORE_GPR7
+	EMERGENCY_PRINT_STORE_GPR9
+
+	/* Load character to r7, check for null terminator */
+2:	l.lbz	r7,0(r3)
+	l.sfeqi	r7,0x0
+	l.bf	9f
+	 l.nop
+
+	l.jal	_emergency_putc
+	 l.nop
 
 	/* next character */
 	l.j	2b
-	l.addi	r3,r3,0x1
+	 l.addi	r3,r3,0x1
 
 9:
+	EMERGENCY_PRINT_LOAD_GPR9
 	EMERGENCY_PRINT_LOAD_GPR7
-	EMERGENCY_PRINT_LOAD_GPR6
-	EMERGENCY_PRINT_LOAD_GPR5
-	EMERGENCY_PRINT_LOAD_GPR4
 	l.jr	r9
-	l.nop
+	 l.nop
 
+/*
+ * DSCR: prints a number in r3 in hex.
+ *
+ * PRMS: r3     	- a 32-bit unsigned integer
+ *
+ * PREQ: UART at UART_BASE_ADD has to be initialized
+ *
+ * POST: caller should be aware that r3, r9 are changed
+ */
 ENTRY(_emergency_print_nr)
-	EMERGENCY_PRINT_STORE_GPR4
-	EMERGENCY_PRINT_STORE_GPR5
-	EMERGENCY_PRINT_STORE_GPR6
 	EMERGENCY_PRINT_STORE_GPR7
 	EMERGENCY_PRINT_STORE_GPR8
+	EMERGENCY_PRINT_STORE_GPR9
 
 	l.addi	r8,r0,32		// shift register
 
@@ -1600,58 +1638,39 @@ ENTRY(_emergency_print_nr)
 	/* don't skip the last zero if number == 0x0 */
 	l.sfeqi	r8,0x4
 	l.bf	2f
-	l.nop
+	 l.nop
 
 	l.sfeq	r7,r0
 	l.bf	1b
-	l.nop
+	 l.nop
 
 2:
 	l.srl	r7,r3,r8
 
 	l.andi	r7,r7,0xf
 	l.sflts	r8,r0
-	l.bf	9f
+	 l.bf	9f
 
+	/* Numbers greater than 9 translate to a-f */
 	l.sfgtui r7,0x9
 	l.bnf	8f
-	l.nop
+	 l.nop
 	l.addi	r7,r7,0x27
 
-8:
-	l.addi	r7,r7,0x30
-// putc:
-	l.movhi r4,hi(UART_BASE_ADD)
-
-	l.addi  r6,r0,0x20
-1:      l.lbz   r5,5(r4)
-	l.andi  r5,r5,0x20
-	l.sfeq  r5,r6
-	l.bnf   1b
-	l.nop
-
-	l.sb    0(r4),r7
-
-	l.addi  r6,r0,0x60
-1:      l.lbz   r5,5(r4)
-	l.andi  r5,r5,0x60
-	l.sfeq  r5,r6
-	l.bnf   1b
-	l.nop
+	/* Convert to ascii and output character */
+8:	l.jal	_emergency_putc
+	 l.addi	r7,r7,0x30
 
 	/* next character */
 	l.j	2b
 	l.addi	r8,r8,-0x4
 
 9:
+	EMERGENCY_PRINT_LOAD_GPR9
 	EMERGENCY_PRINT_LOAD_GPR8
 	EMERGENCY_PRINT_LOAD_GPR7
-	EMERGENCY_PRINT_LOAD_GPR6
-	EMERGENCY_PRINT_LOAD_GPR5
-	EMERGENCY_PRINT_LOAD_GPR4
 	l.jr	r9
-	l.nop
-
+	 l.nop
 
 /*
  * This should be used for debugging only.
@@ -1676,7 +1695,9 @@ ENTRY(_emergency_print_nr)
 
 ENTRY(_early_uart_init)
 	l.movhi	r3,hi(UART_BASE_ADD)
+	l.ori	r3,r3,lo(UART_BASE_ADD)
 
+#if defined(CONFIG_SERIAL_8250)
 	l.addi	r4,r0,0x7
 	l.sb	0x2(r3),r4
 
@@ -1694,9 +1715,10 @@ ENTRY(_early_uart_init)
 	l.addi  r4,r0,((UART_DIVISOR) & 0x000000ff)
 	l.sb	UART_DLL(r3),r4
 	l.sb	0x3(r3),r5
+#endif
 
 	l.jr	r9
-	l.nop
+	 l.nop
 
 	.align	0x1000
 	.global _secondary_evbar
@@ -1711,13 +1733,13 @@ _secondary_evbar:
 
 	.section .rodata
 _string_unhandled_exception:
-	.string "\n\rRunarunaround: Unhandled exception 0x\0"
+	.string "\r\nRunarunaround: Unhandled exception 0x\0"
 
 _string_epc_prefix:
 	.string ": EPC=0x\0"
 
 _string_nl:
-	.string "\n\r\0"
+	.string "\r\n\0"
 
 
 /* ========================================[ page aligned structures ]=== */
-- 
2.31.1

