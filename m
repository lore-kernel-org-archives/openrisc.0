Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D54C433F5
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:46 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B8E4F24919;
	Tue, 17 May 2022 02:55:45 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mail.librecores.org (Postfix) with ESMTPS id B08A324975
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:43 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 x23-20020a17090a789700b001df763d4ed0so1059426pjk.0
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6s5Kt+Fz8ODBsnaEn4hTWh6elxNZ/IIbeZw2XTvUCZg=;
 b=l9BCm+sZ/jPB00HhEvjDgNEBEZubgYsHBxfKzYQWLsXeMk7sC7EtDNnhmZul6RoA0n
 SOQYpqJmzwwC6ayzYVCcwcX6YYAi/DxWNaxKiV0TTUUIZ3D82gME2gJjJmZGl6xyHl+X
 i/IZkzXiPpVoYOSIkoOXPPW8daAFzitvLKTrSPCuyZfPrvXRGNJTTTiUYmoV3dkTAFg3
 0Bset5Z9Y6xm6ZENrofdTr3hbh/LZ/lsw020yAaYZ2h+2cLCqmWhUg/6x9kYD+P4VV/e
 GYkKWLJlYgXsLom70JZTc0HvzyOh8IqkKVqiEHBbrPNVcvxxoZRI7yDs4QUT1F+ZFbSV
 DALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6s5Kt+Fz8ODBsnaEn4hTWh6elxNZ/IIbeZw2XTvUCZg=;
 b=ItVfx87X1E5FiJm22m8HLUeIUR0sCoQDFRpPw8omqrtlp7JzKKepTvoMd9747U/eKn
 ltb8HRxnAWaZb8QUwHRI6LjnZXE79WzlxpTcufuYJtd6eLZ0NdfwMIX1MGkRJTQfCS0E
 qPgCicYpcCx0etgFHDEt2ou2tPNU8wMVLAjqYqMlCTEOpgNVc2sRoGqm+O38kg8HDWae
 hdVAay1bbkK1eu8NhGXXM+sPM3d7c8YkJqKQEszFusoVYSCjD6C8+rZpW6eSrP158rA0
 dhID8U0xNb1A1X67DbETv/DRBM7D73C9nXqivHcJcW+uV6LZ5vpf1AMW4gw/mHr1/OTl
 cpiQ==
X-Gm-Message-State: AOAM5312wswjXB/gigWrIsJZL63qhdqm5BsTMMTB4h6tWXpBpt1opccd
 HWGc3vkdaFx7wBQK9TlAH6o=
X-Google-Smtp-Source: ABdhPJxvFFdRTk3lKAN1oUhl5cV3phAoVEYDgCYWnKR565VZbl7z6Gtn4FzBT+iaLvJuWKdNzFTXRQ==
X-Received: by 2002:a17:903:246:b0:153:84fe:a9b0 with SMTP id
 j6-20020a170903024600b0015384fea9b0mr19934908plh.163.1652748942250; 
 Mon, 16 May 2022 17:55:42 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 k189-20020a6384c6000000b003c574b4a95dsm7374535pgd.53.2022.05.16.17.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:41 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/13] openrisc: Pretty print show_registers memory dumps
Date: Tue, 17 May 2022 09:55:02 +0900
Message-Id: <20220517005510.3500105-6-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Openrisc <openrisc@lists.librecores.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Currently show registers, print memory dumps character by character and
there is no address information, so its a bit difficult to use.  For
example before a stack dump looks as follows.

    [   13.650000] Stack:
    [   13.650000] Call trace
    [   13.690000] [<(ptrval)>] ? put_timespec64+0x44/0x60
    [   13.690000] [<(ptrval)>] ? _data_page_fault_handler+0x104/0x10c
    [   13.700000]
    [   13.700000] Code:
    [   13.700000] 13
    [   13.700000] ff
    [   13.700000] ff
    [   13.700000] f9
    [   13.710000] 84
    [   13.710000] 82
    [   13.710000] ff
    [   13.710000] bc
    [   13.710000] 07
    [   13.710000] fd
    [   13.720000] 4e
    [   13.720000] 67
    [   13.720000] 84
    [   13.720000] 62
    [   13.720000] ff
    ...

This change updates this to print the address and data a word at time.

    [    0.830000] Stack:
    [    0.830000] Call trace:
    [    0.830000] [<(ptrval)>] load_elf_binary+0x744/0xf5c
    [    0.830000] [<(ptrval)>] ? __kernel_read+0x144/0x184
    [    0.830000] [<(ptrval)>] bprm_execve+0x27c/0x3e4
    [    0.830000] [<(ptrval)>] kernel_execve+0x16c/0x1a0
    [    0.830000] [<(ptrval)>] run_init_process+0xa0/0xec
    [    0.830000] [<(ptrval)>] ? kernel_init+0x0/0x14c
    [    0.830000] [<(ptrval)>] kernel_init+0x7c/0x14c
    [    0.830000] [<(ptrval)>] ? calculate_sigpending+0x30/0x40
    [    0.830000] [<(ptrval)>] ret_from_fork+0x1c/0x84
    [    0.830000]
    [    0.830000]  c1033dbc:       c1033dec
    [    0.830000]  c1033dc0:       c015258c
    [    0.830000]  c1033dc4:       c129da00
    [    0.830000]  c1033dc8:       00000002
    [    0.830000]  c1033dcc:       00000000
    [    0.830000]  c1033dd0:       c129da00
    [    0.830000]  c1033dd4:       00000000
    [    0.830000]  c1033dd8:       00000000
    [    0.830000] (c1033ddc:)      00001e04
    [    0.830000]  c1033de0:       001501fc
    [    0.830000]  c1033de4:       c1033e68
    [    0.830000]  c1033de8:       c0152e60
    [    0.830000]  c1033dec:       c129da5c
    [    0.830000]  c1033df0:       c0674a20
    [    0.830000]  c1033df4:       c1033e50
    [    0.830000]  c1033df8:       c00e3d6c
    [    0.830000]  c1033dfc:       c129da5c
    [    0.830000]  c1033e00:       00000003
    [    0.830000]  c1033e04:       00150000
    [    0.830000]  c1033e08:       00002034
    [    0.830000]  c1033e0c:       001501fc
    [    0.830000]  c1033e10:       00000000
    [    0.830000]  c1033e14:       00150000
    [    0.830000]  c1033e18:       0014ebbc
    [    0.830000]  c1033e1c:       00002000
    [    0.830000]  c1033e20:       00000003
    [    0.830000]  c1033e24:       c12a07e0
    [    0.830000]  c1033e28:       00000000
    [    0.830000]  c1033e2c:       00000000
    [    0.830000]  c1033e30:       00000000
    [    0.830000]  c1033e34:       40040000
    [    0.830000]  c1033e38:       00000000
    [    0.830000]
    [    0.830000] Code:
    [    0.830000]  c00047a4:       9c21fff8
    [    0.830000]  c00047a8:       d4012000
    [    0.830000]  c00047ac:       d4011804
    [    0.830000]  c00047b0:       e4040000
    [    0.830000]  c00047b4:       10000005
    [    0.830000]  c00047b8:       9c84ffff
    [    0.830000] (c00047bc:)      d8030000
    [    0.830000]  c00047c0:       03fffffc
    [    0.830000]  c00047c4:       9c630001
    [    0.830000]  c00047c8:       9d640001
    [    0.830000]  c00047cc:       84810000
    [    0.830000]  c00047d0:       84610004

Now we are also printing a bit of the stack as well as the code.  The
stack is output to help with debugging.  There may be concern about
exposing sensitive information on the stack, but we are already dumping
all register content which would have similar sensitive information.  So
I am going ahead as this proves useful in investigation.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 0446a3c34372..f2478bba77b9 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -46,6 +46,14 @@ void print_trace(void *data, unsigned long addr, int reliable)
 	       (void *) addr);
 }
 
+static void print_data(unsigned long base_addr, unsigned long word, int i)
+{
+	if (i == 0)
+		printk("(%08lx:)\t%08lx", base_addr + (i * 4), word);
+	else
+		printk(" %08lx:\t%08lx", base_addr + (i * 4), word);
+}
+
 /* displays a short stack trace */
 void show_stack(struct task_struct *task, unsigned long *esp, const char *loglvl)
 {
@@ -99,22 +107,36 @@ void show_registers(struct pt_regs *regs)
 		printk("\nStack: ");
 		show_stack(NULL, (unsigned long *)esp, KERN_EMERG);
 
+		if (esp < PAGE_OFFSET)
+			goto bad_stack;
+
+		printk("\n");
+		for (i = -8; i < 24; i += 1) {
+			unsigned long word;
+
+			if (__get_user(word, &((unsigned long *)esp)[i])) {
+bad_stack:
+				printk(" Bad Stack value.");
+				break;
+			}
+
+			print_data(esp, word, i);
+		}
+
 		printk("\nCode: ");
 		if (regs->pc < PAGE_OFFSET)
 			goto bad;
 
-		for (i = -24; i < 24; i++) {
-			unsigned char c;
-			if (__get_user(c, &((unsigned char *)regs->pc)[i])) {
+		for (i = -6; i < 6; i += 1) {
+			unsigned long word;
+
+			if (__get_user(word, &((unsigned long *)regs->pc)[i])) {
 bad:
 				printk(" Bad PC value.");
 				break;
 			}
 
-			if (i == 0)
-				printk("(%02x) ", c);
-			else
-				printk("%02x ", c);
+			print_data(regs->pc, word, i);
 		}
 	}
 	printk("\n");
@@ -185,13 +207,11 @@ void nommu_dump_state(struct pt_regs *regs,
 	printk("\nCode: ");
 
 	for (i = -24; i < 24; i++) {
-		unsigned char c;
-		c = ((unsigned char *)(__pa(regs->pc)))[i];
+		unsigned long word;
+
+		word = ((unsigned long *)(__pa(regs->pc)))[i];
 
-		if (i == 0)
-			printk("(%02x) ", c);
-		else
-			printk("%02x ", c);
+		print_data(regs->pc, word, i);
 	}
 	printk("\n");
 }
-- 
2.31.1

