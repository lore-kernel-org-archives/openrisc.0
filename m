Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC2FC43217
	for <openrisc@archiver.kernel.org>; Fri, 14 Oct 2022 15:58:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 03E1A24B98;
	Fri, 14 Oct 2022 17:58:51 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by mail.librecores.org (Postfix) with ESMTPS id 1A02F24B9B
 for <openrisc@lists.librecores.org>; Fri, 14 Oct 2022 17:58:50 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id u21so7437016edi.9
 for <openrisc@lists.librecores.org>; Fri, 14 Oct 2022 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBIOqGjmdzThiZsnnbTdUiYSPQXS/qp/QRUJHndogxY=;
 b=de2qcklml8jKYdhJlyXqmJXoz8FYGzMVRLfN9JcOUqf4UOLuKCrWZr59qwP/CI15i8
 9ZEYt9iqHJUORqeLDasCpf2TvKXJ2eNiOMML8Fk+bz7YKFJbV57Ez3yS2OMYxbifi8aU
 80V2z5mOPzJ5j+SPiaK/ExtA7pvzSXkVFgQy9BgPDzmgfE18Klp1ebv/IKnNb6TVl3x7
 K0gO3P8T9E6LTR2oS1WZnI3pbS2vkD6iCSFlqd/rinFyB9u6Ftb/GsYDL097UX4vn1na
 X5w9kGup7pabQp9pwZ84Krxhofd+fyywuWkx0d61FPGLmHqmWuc2PbVNpdjodZPMfLJV
 6NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBIOqGjmdzThiZsnnbTdUiYSPQXS/qp/QRUJHndogxY=;
 b=PkGT2re4sJt1QFrQT7v0o2j50Cv1QnjgIENop0yXwGPhPWxrYIrDPlLUxdZwyRIGp1
 /gIDdbMLVdQ03696CF06nD1X0KKkQQxIZ5LujoIH/E14DFujSAmmjAyxg+EyTCgQe2+P
 MHKKeITO8LTK7UABd0VEoc/l+Cu5xwxFcqfh533wtTnz1G9X1DgJAwA13+b+2BHFj9Me
 ZbNxXlbsOrxP2XcycVqKfUpH/VAoL2GFz3qwQdgJgL/Xl9Ouh8405H8tmGCpMjAb6Zox
 wYSF/PmmBJL6S2PqsCnCEwMxXLOfkefgLNfTbKRtfmTe/S1HnbtHnglpbpjfYhGGXbgH
 hI/Q==
X-Gm-Message-State: ACrzQf1WUJ0BfVT/RgYY1o4KLS0mQGPp6EEiDabNBHxR1Jc1P4gL+Ss1
 5Xh0k7K3XKC3bGZyWlTL3IwdPg==
X-Google-Smtp-Source: AMsMyM7AeOygOXkM1z/GTKaGU+3a1Uh1fQyGWBmDx0oj1luEK/7mcX83iQG4d2XLgbn9xXhJP10WDg==
X-Received: by 2002:a05:6402:3485:b0:45c:d688:6848 with SMTP id
 v5-20020a056402348500b0045cd6886848mr4672473edc.279.1665763129826; 
 Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170906300c00b0077a1dd3e7b7sm1746796ejz.102.2022.10.14.08.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Date: Fri, 14 Oct 2022 17:58:45 +0200
Message-Id: <20221014155845.1986223-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
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

which will issue the warning when reading /proc/cpuinfo. Ensure no
warning is generated by validating the cpu index before calling
cpumask_next().

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..de3f93ac6e49 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos == nr_cpu_ids)
+		return NULL;
+
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return &cpu_data(*pos);
-- 
2.37.3

