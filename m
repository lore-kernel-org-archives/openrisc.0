Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E74C4321E
	for <openrisc@archiver.kernel.org>; Fri, 14 Oct 2022 15:58:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D55F424B82;
	Fri, 14 Oct 2022 17:58:50 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by mail.librecores.org (Postfix) with ESMTPS id 96C3E24B82
 for <openrisc@lists.librecores.org>; Fri, 14 Oct 2022 17:58:48 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id w18so11423344ejq.11
 for <openrisc@lists.librecores.org>; Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFKG/UoJdjvjZL4a++TyBLwRn5J9ab/1o+9LeC1+Wdk=;
 b=TWAL9EKRVGNsLjKjhYh/mC6I8/1d/oatjVnsDN9OWuvFem7UzU02ZKqRzzv3m+6WNJ
 XpbFkMRKHd8kMuyJPFPJ2O4coxdaDl4faAyVqhStpaSUGYq7BHI1TWK1CROOsrCSLceS
 oCa0J4Fufc1QFYIqSNT7YYCBkHCuQagy+1h8ytDYHkttIN15LC4NsO9AFDHEPqj1jTqO
 4aCSqLM2Nu3stjaVcqAwPtMDAHgS/shNxwcrymDs9yg/ism0dyRjPiNJywK3a2Ao/iyX
 qrOsHJe4Ab8pwfjJp7mLQWu47/wJG/qQKDv8bTBXEBTHUkrCbt724EXqhc5mXve0RXVF
 Q5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFKG/UoJdjvjZL4a++TyBLwRn5J9ab/1o+9LeC1+Wdk=;
 b=Zjjf4WtQDRDjakQ3v39laxVZmc04dyf4JK3fX63E9forpvzQqQVhQosUQrZMQpGjpk
 jIso7cajDo35S6j+OWg1mbBY0JJFewfsVuEx4fybZL7pQkmICaZup7lU9XNg2s0Tgl9S
 1NdFUMT0ruhLhDThCLoOyjLdFi+odHYpGMHZNlHLbYLwBsYEzs7DXFAvZKl0XeR/KRxY
 CcFq4yXXrrcS6VbGymZWncOdzadS7ZwIjO9xwCqVx5J5yoeA6aGNfxA2n04FdtaTEr0c
 Czm99iFcC1V1zJ+HH7CMZr7HrbIlBgLO6PabXfg1WNCFe3zRCZifzI7DIxiLKJxYMAGs
 awsg==
X-Gm-Message-State: ACrzQf2gZfEHTKddejiidXdKCsb6gJvWKntY49/ALM2VB3G4GP+3PrtX
 m+PdepLMGaUZDk6Kfk8BJFwHIQ==
X-Google-Smtp-Source: AMsMyM7/e9vDSoMxdhGGaaPUCS7n6lh8z7ltnxJPYvupdtdDP7MiBbMySEaXciThld3Qry9um9n4rA==
X-Received: by 2002:a17:906:4783:b0:780:5be5:c81b with SMTP id
 cw3-20020a170906478300b007805be5c81bmr4152627ejc.76.1665763128360; 
 Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906434f00b007806c1474e1sm1686070ejm.127.2022.10.14.08.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] RISC-V: Fix /proc/cpuinfo cpumask warning
Date: Fri, 14 Oct 2022 17:58:44 +0200
Message-Id: <20221014155845.1986223-2-ajones@ventanamicro.com>
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
 Dave Hansen <dave.hansen@linux.intel.com>,
 Conor Dooley <conor.dooley@microchip.com>, Anup Patel <anup@brainfault.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 openrisc@lists.librecores.org
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
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 4d0dece5996c..5aa0ae8dd115 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -166,6 +166,9 @@ static void print_mmu(struct seq_file *f)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos == nr_cpu_ids)
+		return NULL;
+
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return (void *)(uintptr_t)(1 + *pos);
-- 
2.37.3

