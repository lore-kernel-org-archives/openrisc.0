Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39797C433FE
	for <openrisc@archiver.kernel.org>; Thu,  3 Nov 2022 14:25:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 03D16258ED;
	Thu,  3 Nov 2022 15:25:09 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mail.librecores.org (Postfix) with ESMTPS id 7A51924C66
 for <openrisc@lists.librecores.org>; Thu,  3 Nov 2022 15:25:07 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id y16so2991623wrt.12
 for <openrisc@lists.librecores.org>; Thu, 03 Nov 2022 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fj/ZFbn3Zm8rxzcKsJGd6yFucy8YocyT0mV+oXpe7Do=;
 b=jMtJfzvsVyM2XNkO7dOnrzsj5bFsNMWPr9qRIuRvfNs1tOIvR8I1IP8JVx8tLG7Dep
 v7Un2NZW58xBtWmwuCjYH772AaiwgcpVC21xqkhn0o/tmaNi7buIljvNSAt6F+cUJUMm
 ty0TFwUWGldw91R8cET10BSTY/z5J4prX7tkwNyHo6zddMYQimrfEvNM/sLXJ4IbkhDZ
 m9cFvv72Li0sU8oIZulB0WLbKf4nulNrh7pWjefMCTf4HMlXuiYiEY3FH49w0tZgWXlu
 BN1Vbu6K5RGrqIIVUiu2VYCjwuaaGz/52VTavOGbRx053ikoFEVXHhj2bCgUlI2OBbQL
 U+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fj/ZFbn3Zm8rxzcKsJGd6yFucy8YocyT0mV+oXpe7Do=;
 b=NSDR87s+Yv4TFSEnu5XL6I15zc4f71GIuO5AHBo4i7xhoaYfig71bMRxRzeMiy8RWq
 fq+dkejRRumBdUY9XGHcv0aPm9EvTiDJdYqmmuw2zQkjVEYtQbInUsUEpZBbN8yAyDv+
 r6sTs/cfBjhwWZkZtXp2MfM6Th4NjAiV/q9uKqhnuj1YhBR7ZIVccKZ77DWGdLDBUZNX
 vmwlpW5oIlYNGIiSBCkgPLry7K0ixYHWylVE/KQXA2Qsw881v6WhI/mnZbEuPA/3j4Oj
 SWC5FAbhbqTEynjndvkL8DOeOnogsPoSapRoY6CeyOhxXZVQq4iwffiOSgj10Zpepbaq
 tEig==
X-Gm-Message-State: ACrzQf3Gq56qFxBX/F4zlzgqUozy+5bUe/9sX0sFv+UrDo8O0iU4UOe7
 2C28zFEBGsDm3sJqVCkKN7sFmg==
X-Google-Smtp-Source: AMsMyM7Fd10uROzTNx7lsAW66oPjI1uph9DNvAe559a3qkiRN8acm3Iyt5ChbLPnm5wfe14jlQcTjQ==
X-Received: by 2002:a05:6000:170d:b0:236:6aa1:8a56 with SMTP id
 n13-20020a056000170d00b002366aa18a56mr18858226wrc.302.1667485507181; 
 Thu, 03 Nov 2022 07:25:07 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a05600c0a5300b003c21ba7d7d6sm1348138wmq.44.2022.11.03.07.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 07:25:06 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] x86: cpuinfo: Ensure inputs to cpumask_next are valid
Date: Thu,  3 Nov 2022 15:25:04 +0100
Message-Id: <20221103142504.278543-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103142504.278543-1-ajones@ventanamicro.com>
References: <20221103142504.278543-1-ajones@ventanamicro.com>
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

The valid cpumask range is [0, nr_cpu_ids) and cpumask_next()
currently calls find_next_bit() with its input CPU ID number plus one
for the bit number, giving cpumask_next() the range [-1, nr_cpu_ids - 1).
seq_read_iter() and cpuinfo's start and next seq operations implement a
pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }

which will eventually result in cpumask_next() being called with
nr_cpu_ids - 1. A kernel compiled with commit 78e5a3399421 ("cpumask:
fix checking valid cpu range"), but not its revert, commit
80493877d7d0 ("Revert "cpumask: fix checking valid cpu range"."),
will generate a warning when DEBUG_PER_CPU_MAPS is enabled each time
/proc/cpuinfo is read. Future-proof cpuinfo by checking its input to
cpumask_next() is valid.

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

