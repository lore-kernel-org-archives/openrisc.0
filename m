Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D32C433FE
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6244F2496F;
	Tue, 17 May 2022 02:55:41 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mail.librecores.org (Postfix) with ESMTPS id 3488324970
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:40 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id 204so15548142pfx.3
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
 b=UupvaoPH523tK0FTB32h9+ccvRKp5igs/DWMORUUtCOWOso6fYzWmPV+1a1zyTdqcf
 du5DS5q7UYYny+lco4UHxNUe3g5wjcaAjf+2mpilM4MX2LQrmQVChFFq4njBYqqd7aWN
 PS875JvWku0ngw3WBdywFS5kRHOrXvF3wvwqRT+BlF0HTPedbYu8zAMqPXquJCdDm5iN
 Fs1QKOhsrYQAYijAjK9eyaxDeQuad7fkz/TccnfzfSVMZibZpptOdBr7/FR1bvRTJmth
 1D3SPUI66RyKUk23pqzp5FBv5lPmiPsEp9cc1SSCLxuVHYc/NBd/LnoUj6QU33lsSkoi
 e1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
 b=6IsiuumyBXTYj03ISOsWB0XgX7xLsgifAlDMzk+xQyIQooP+7SU9Bw8JRlazC5g7VE
 OYhFyxZrZcuK757psu+Au9P2aTdZfNHCr964FlURN87M0t9uUMVQQ2Dn6GML/8ocRwfq
 ti77VT4rq3/o3dLzGfxB7afiEdeC0c6Y4DqaPXASABx+LvN6/Zv/Fk0FIh8vb7RY3QNo
 /3DpEfB1ZrWrHGu4hhT7RGH4pVt1vObNaI68pZ68SZU48YJT/teXzfWU8t2Mupx30st5
 RBurEZR2NaIEMPPNjKsDdtZbMNrB1EnqvCWdhd5PrWZP9TXTd1J2acpk1F5Z4NIZI3Im
 4Fqw==
X-Gm-Message-State: AOAM533T1m9qNJzP8LOKSACsN4TygJqQartFiJ9wF5w/gfSRkpAXXY+l
 Hlu3/rH4Mm23FAoY9J/00CU=
X-Google-Smtp-Source: ABdhPJyZJpbgtHCnP93HtiV36JN+8M71Eq1x/qZGWWPpnNp/RLPeQVQ7W2jRJDrqPdRD3V8yp3zEzQ==
X-Received: by 2002:a65:6297:0:b0:3db:4820:2867 with SMTP id
 f23-20020a656297000000b003db48202867mr16938361pgv.503.1652748938816; 
 Mon, 16 May 2022 17:55:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 cs20-20020a17090af51400b001df5dea7d4bsm282211pjb.43.2022.05.16.17.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/13] openrisc: Add syscall details to emergency syscall
 debugging
Date: Tue, 17 May 2022 09:55:01 +0900
Message-Id: <20220517005510.3500105-5-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Petr Mladek <pmladek@suse.com>,
 Chris Down <chris@chrisdown.name>, Mark Rutland <mark.rutland@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
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

