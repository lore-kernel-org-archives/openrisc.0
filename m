Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08043C4332F
	for <openrisc@archiver.kernel.org>; Fri, 14 Oct 2022 15:58:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9DDBA24B92;
	Fri, 14 Oct 2022 17:58:48 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by mail.librecores.org (Postfix) with ESMTPS id 9555724B6F
 for <openrisc@lists.librecores.org>; Fri, 14 Oct 2022 17:58:47 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id w18so11423149ejq.11
 for <openrisc@lists.librecores.org>; Fri, 14 Oct 2022 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W5eO6i8yGqM/Qk/helghde+sK2B6uuy7iGWdi59LQv0=;
 b=m5i1o0Ap34XB2wlP21XgYIqsVDRRQOqNgXMX5tJzWsaI6hGrAZN9MXRzGc93zF2XPA
 8L/SLRgslFncCk0nXLKfro+LvVAuBiIJEkGi+kku5MAuwTr4Av+VkPDyus9j5yCxKY0e
 YOtAgl4m9DWHQK3UYRyVu1beWyQGVeOVcZD55vwQwp4fSb0QhgMCnZzRu0uhrRUo1Tvq
 XZgdlHZK3gCz7g4TIGW4i3ZvbPG7Gm3XysvcL00yJwc2GO4L3l9DhN608jkbddOb/W9j
 f6nCuDr1Hx3UpL7i6FB65/PdJkLsqhTn6pdhYB+vtA5dMZT/TwoMfVhWXkBkx0/mc7XG
 dKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W5eO6i8yGqM/Qk/helghde+sK2B6uuy7iGWdi59LQv0=;
 b=j6OyULt8MY50lz0LjlIhGe3rDzeSwub2JaskdLXisoOrwD9zGsILxpAGsaXYgMmFH6
 vIBscY/3w5tLAdj4fMvCfFf2kREGJrcrG21ZQE96CSgTrYjWjcTx6xTB+LqULdKvkyB+
 x8F5ScX5mQSWDwfuXqbbAMccSG/9CXz2VNXHLYvAI8g6ie+nvGXOHbH46GLZxlvi0AWT
 W6cipnn8EGf2ZrUdLn2DIQxY49TC0Fpz1k+bkPv29m9PxH+/2h97/I3jKyzXVDCnruM1
 Y6SV5+KuJwN5rBxCH3BYYY9DdvRYyjq3b7LBcq20CdKAKkXDvvY2pj9I30mLklo3aHVf
 PPSg==
X-Gm-Message-State: ACrzQf3xX7hjLN9bl6fteQWtrcGD/vfyp+KYFHsCPRfylBoFA4JFKAud
 9AJ6jUKrk3I10pGHbBUIfNYYqA==
X-Google-Smtp-Source: AMsMyM7W6+fPu+mWcsl2mA5mLUmVxJY6ZAokGeJNv3DvlB68CliPDKXds+EoUBatPkHWx2Y7U7pt8g==
X-Received: by 2002:a17:907:94c9:b0:78d:3544:ff0a with SMTP id
 dn9-20020a17090794c900b0078d3544ff0amr3984138ejc.386.1665763126950; 
 Fri, 14 Oct 2022 08:58:46 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a170906944500b007262a5e2204sm1693950ejx.153.2022.10.14.08.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 08:58:46 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
Date: Fri, 14 Oct 2022 17:58:43 +0200
Message-Id: <20221014155845.1986223-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
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
Cc: Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
start and next seq operations implement a pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }
    
which will issue the warning when reading /proc/cpuinfo.

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

This series address the issue for x86 and riscv, but from a quick
grep of cpuinfo seq operations, I think at least openrisc, powerpc,
and s390 also need an equivalent patch. While the test is simple (see
next paragraph) I'm not equipped to test on each architecture.

To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.

While the patches are being posted together in a series since they're
for two different architectures they don't necessarily need to go
through the same tree.

v3:
  - Change condition from >= to == in order to still get a warning
    for > as that's unexpected. [Yury]
  - Picked up tags on the riscv patch

v2:
  - Added all the information I should have in the first place
    to the commit message [Boris]
  - Changed style of fix [Boris]

Andrew Jones (2):
  RISC-V: Fix /proc/cpuinfo cpumask warning
  x86: Fix /proc/cpuinfo cpumask warning

 arch/riscv/kernel/cpu.c    | 3 +++
 arch/x86/kernel/cpu/proc.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.37.3

