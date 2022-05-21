Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FAC433EF
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:13:54 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C2E3724758;
	Sat, 21 May 2022 15:13:53 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mail.librecores.org (Postfix) with ESMTPS id 85CF92412D
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:13:51 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 oe17-20020a17090b395100b001df77d29587so13659186pjb.2
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
 b=MxywOSFHz7PZ/XnD//EDP0QUHLfj+as9iHe+yiq4nk06+24WLMwUQcJ27b5V2I/xsL
 tAISylV4H1lBAdvOk9R41xYs6l5RrJfv5iBxwFXtA7wk7oXbPgB/YdVNQ5p6XaB1bEon
 gBx8Yj/1ssUEJsUF4W4RBm0g977FZrkapO1+0Xwv+H9drf/J+lB7gCQbxd+zPdWcSlys
 uClIymNljdApPgJ6zSv2I4GYZP34o1VUqM33Botm50uW4o/7kEH12NsN4fnS4woK3aQI
 7Mi4Ec8pQWSQwgqWFw7DrCTWhBQI8Lfy6OhoS6O72clVydI7yB4fj5CZFakrtgv8OsoM
 lq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
 b=ijOwqfPe49tXmnfsHcnxZ7kKYOa2/uL5xW4AxMLnBw+0MBQGE0/95WOplhd+/JkJLU
 tc6KrBq+ll1vcOdPmxW2ArB863VFk0PxRGnmaHjXahI7Uf03miP5vNu/5lxaTf02VOGw
 lTFyC1JQWFxOqmChYLdCE+6Y140PkIgVYhOAwOwJ2dh4DNYi4NjAz6iad9Qp2cEZNr6y
 0Hyliy0y7/8b8U7j5rt5KZtizGnVumKMpdFvsSbc7WwDd+6u6AjL0mFiAJABPPtflc2Y
 e5vROQQJ3PoZB3lPlGQhV4633/xpNPJG+Tzmrep+ydw1H1v0JcXS855JuQSIUiqCLYPs
 Sq1A==
X-Gm-Message-State: AOAM531UnkIOFjA5Ss8321iAP6EtIQOaArKNN0UVoaU8awGhr9ywTzRj
 JUkieKhYk6Yf1WMmRTcU3Q0=
X-Google-Smtp-Source: ABdhPJycrrEqvaylteUpNBdePlGKsQ4p/h0pFbpeM860AzJGdXaRGgOhQLbqf3o8ZIZTX/pn7UvPPQ==
X-Received: by 2002:a17:902:7c8c:b0:161:f5b4:9aa6 with SMTP id
 y12-20020a1709027c8c00b00161f5b49aa6mr7028272pll.79.1653138830133; 
 Sat, 21 May 2022 06:13:50 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a654385000000b003c14af5062csm1470295pgp.68.2022.05.21.06.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:13:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/13] openrisc: Add syscall details to emergency syscall
 debugging
Date: Sat, 21 May 2022 22:13:14 +0900
Message-Id: <20220521131323.631209-5-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Petr Mladek <pmladek@suse.com>,
 Chris Down <chris@chrisdown.name>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Randy Dunlap <rdunlap@infradead.org>,
 Openrisc <openrisc@lists.librecores.org>, Andrey Bacherov <bandvig@mail.ru>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

When bringing linux on the or1k Marocchino we ran into issues starting
init.  This patch adds the syscall number and return address to
assist tracing syscalls even before strace is able to be used.

By default this is all disabled but a developer could adjust the ifdef
to enable debugging.

Cc: Andrey Bacherov <bandvig@mail.ru>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 3ca1b1f490b9..54a87bba35ca 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -601,7 +601,7 @@ UNHANDLED_EXCEPTION(_vector_0xb00,0xb00)
  */
 
 _string_syscall_return:
-	.string "syscall return %ld \n\r\0"
+	.string "syscall r9:0x%08x -> syscall(%ld) return %ld\0"
 	.align 4
 
 ENTRY(_sys_call_handler)
@@ -679,15 +679,25 @@ _syscall_return:
 _syscall_debug:
 	l.movhi r3,hi(_string_syscall_return)
 	l.ori   r3,r3,lo(_string_syscall_return)
-	l.ori   r27,r0,1
+	l.ori   r27,r0,2
 	l.sw    -4(r1),r27
 	l.sw    -8(r1),r11
-	l.addi  r1,r1,-8
+	l.lwz	r29,PT_ORIG_GPR11(r1)
+	l.sw    -12(r1),r29
+	l.lwz	r29,PT_GPR9(r1)
+	l.sw    -16(r1),r29
 	l.movhi r27,hi(_printk)
 	l.ori   r27,r27,lo(_printk)
 	l.jalr  r27
-	 l.nop
-	l.addi  r1,r1,8
+	 l.addi  r1,r1,-16
+	l.addi  r1,r1,16
+#endif
+#if 0
+_syscall_show_regs:
+	l.movhi r27,hi(show_registers)
+	l.ori   r27,r27,lo(show_registers)
+	l.jalr  r27
+	 l.or	r3,r1,r1
 #endif
 
 _syscall_check_trace_leave:
-- 
2.31.1

