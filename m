Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744C2C43217
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:08 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B8AE224758;
	Sat, 21 May 2022 15:14:07 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mail.librecores.org (Postfix) with ESMTPS id DACCB24758
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:14:05 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id 137so9919510pgb.5
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
 b=cK2xhVsGyV8VicAIx7RO1hnU738yQyl0C95qeHyJMhTXaHhYmXRvaUDq7GkJrXHDDU
 VaD71U3BRjiWyy7w5zQcGOdAVS10yh3fiGzlSCLHdGkGLCdTJjbzcEJKqZ3Jv7eAh1qZ
 PP6C/YIf5kG4pjSPFWMoCWcD0OwN2/+s1R3DH8DYBuQt5nr44+ElZ80GyCfKmgZ5V6mq
 /STJXr1jbJcSGOe95mHhXItNuhNKIuNltjLHBv9T/pw90dPdgx5pk/wM3FdEv4C4V0EO
 in9Q1ZrWW/+JccujTvceUy39LYWT6fb3Tw0l/xcl/q9l7zvWdC84ENEPpcr0kzWfMpPT
 K+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
 b=I0AdowKu2qhzCsQP3Gk0vaxkuUkNoeABA0PO5Dw+akxfxeJnpU6XKhMxRdKmo4bJwd
 76E9FxVoU369QQEsD4JAq+L0D9XjgrLgghQMMo/O1uK2xotdvbAjw9hcX8hXe92pEcIS
 unND85um9xXT9xUVkfXTqc/3qohikqt6J+hfGbOmuDHISF9aIBX4MCmwgjHjF9IV38a+
 fq14CaxcbLH1uxc5+73yX4l2GsfUylSHtJJ7dPdFnKRHWnWadrpvV1PF45uETC7A8zuJ
 KE8N0/VtHVjgakz1YQNl7m1hj/FBkGhWPfRVooKKSe28I5hiCzD+4buJKr/frr+0foBw
 x4PA==
X-Gm-Message-State: AOAM532taLmvuj/cD/WRbpoKf/2a12HErEDCwRkXvhsKLih+XsItxhbD
 MI9t9WVkRASZmjWQI+8KGmQ=
X-Google-Smtp-Source: ABdhPJyLWt4gX8XuEVkhq42WgdF3C0m9EL1l6FbEi/bqSXoDHDApDfOlBx9NvZ64lxpBhABsJYf9BQ==
X-Received: by 2002:a05:6a00:e8e:b0:518:287c:ce82 with SMTP id
 bo14-20020a056a000e8e00b00518287cce82mr14806077pfb.4.1653138844368; 
 Sat, 21 May 2022 06:14:04 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a170902748300b00161929fb1adsm1573706pll.54.2022.05.21.06.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:14:03 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/13] openrisc/traps: Remove die_if_kernel function
Date: Sat, 21 May 2022 22:13:18 +0900
Message-Id: <20220521131323.631209-9-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Openrisc <openrisc@lists.librecores.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This was noticed when I saw this warning:

    arch/openrisc/kernel/traps.c:234:6: warning: no previous prototype for 'die_if_kernel' [-Wmissing-prototypes]
      234 | void die_if_kernel(const char *str, struct pt_regs *regs, long err)
	  |      ^~~~~~~~~~~~~

The die_if_kernel function is not used in the OpenRISC port so remove
it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 9e0937eb31ca..99cd2e6f8873 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -235,15 +235,6 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	make_task_dead(SIGSEGV);
 }
 
-/* This is normally the 'Oops' routine */
-void die_if_kernel(const char *str, struct pt_regs *regs, long err)
-{
-	if (user_mode(regs))
-		return;
-
-	die(str, regs, err);
-}
-
 void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
 	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
-- 
2.31.1

