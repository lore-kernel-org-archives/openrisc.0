Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF0C433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2FEEF248F1;
	Sun, 15 May 2022 14:42:24 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mail.librecores.org (Postfix) with ESMTPS id 78FCD20CE9
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:22 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id d22so12002523plr.9
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
 b=Qf2SFi15nUqunuSsHbUvOLDs9jx8EfYTjiHnmxRleIxk/xBIm5RBYHeYAfO61uuwQz
 Nx7D+WbgMss1gQdJ/eOx5k92CPGxwSXFZ+Y4aZ6ubNX1DJpG3P725ZT4/dpxk/d/kwK7
 woSya6rxwp2rUb7YMhfIcYnLjfERr7ZOzLk8ep6bzDdf5d1WvElKtXVybkityqGG9ROl
 ZoozNwXhbmjbvJeYgkGSR84jbY4x5A4HDFxx2MCjsgc2BMdcmAg1U06pc1LHe3UT/Xgg
 i4oETKM3qSNwABkBbRJ+8bO5YDnwY+xpv+NcJUw5rXqNJPs1ReyB7hgPpCmnRhL9c4bz
 ADPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
 b=KIgolbVgvk9YSZ9knth7a1FYShdPXMzmycWw37M/Eu3SCewz/xKsBZI+9W+8j7OoL/
 sx3lv3suE05fgIPO36loAlkSl3BTTQQKzd701KT9qX5q0Nw2i7H36UQUPvss1o8qUnnh
 FX9F1vKpRSEHl9xDzsQEy2Bft/QP0piEAO0YpscTgNwBIltZ8mpmg3sbEbCrnECo1gJ+
 BvLV7ZYQst8c6e+JdGvFlrddkSwRdmjirVkeoYQmWlCucxwtElmVQ/vnSyR75Rq9vt0j
 nNWm93t26+mnGgDDposj5aSGsoqzyCDbASj7b9gTvnkg296z7PGvmTak9z47lfnDVAic
 bK8A==
X-Gm-Message-State: AOAM530O6Q3kT4Q0jFRDHItd2Bh3SYlDiW6R4NuLVEH5tjTUL/lbM5fl
 RUDumNWyCfCEHUM0de66zgc=
X-Google-Smtp-Source: ABdhPJw6rtgLAlUzww8OqkwRf7uyo9N6Q1iShOza3I7ojiZdLV37sJ8d+/UQ4p0TsSZWLhy2rIHjJw==
X-Received: by 2002:a17:902:d2c6:b0:161:6e0e:c5e1 with SMTP id
 n6-20020a170902d2c600b001616e0ec5e1mr2329079plc.139.1652618541066; 
 Sun, 15 May 2022 05:42:21 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a170903024f00b0015eee3ab203sm5157820plh.49.2022.05.15.05.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:20 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/13] openrisc: Add syscall details to emergency syscall
 debugging
Date: Sun, 15 May 2022 21:41:49 +0900
Message-Id: <20220515124158.3167452-5-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Petr Mladek <pmladek@suse.com>,
 Chris Down <chris@chrisdown.name>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Randy Dunlap <rdunlap@infradead.org>,
 Openrisc <openrisc@lists.librecores.org>, Jessica Yu <jeyu@kernel.org>,
 Andrey Bacherov <bandvig@mail.ru>
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

