Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97630C62B
	for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765735346; cv=none; b=RSmbBVHl8I8VRzmmqqSps7+a3uJLpUJHtO0c1nwdITXrXSLvlhG6gwRr0RIx718NQNfIaqrnLAKgJUPwlilrR/v2VHMElLDOmZDmTaTMp5T7J/kYjbJUmfFb9iQUkt3ZRY2rVZ4tmM+gqtGZHG+9LbGp85G7TlxDfi/pZWFvZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765735346; c=relaxed/simple;
	bh=Upo/KeJ1tydzhEX3FEnB2Lq6CdSMUiNT1LlycW0K1NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqIogZ2Vgeyvh2hfSgqaSKG3Rxwnx5T52WKsjzWu+Q1k2e+1PYfqWiheU6C0E068Rugyk5it/Bv0w7lMSrz/T2ekyovbn7n181mnTuSyGVPzaQyKWC/oVqaZSQjSCZIWkZocXOrzBCOVikI7kkYnQZdYll5j78LvUrpbq701N/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gynnoUqd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gynnoUqd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so1919603f8f.1
        for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 10:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765735343; x=1766340143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFXHMGeoomdbZOLp3ce3D0yDHo0q4hSajO4R4fHl4CQ=;
        b=gynnoUqdjZdfIbkWjlVgJAF+2SgoVuno9diMquCkPmC64TQ868ryTl2CfbT1CBjX+G
         IliwzJWE6oieFTxjhBinSRhJ+3nxX2I3NizdATLIzQDglTvmPTeY0uY9bfljMWm47+ef
         gUJeG8L/5VQ18DrfqoJbM/ShBI15MjVP4UkIPpnv1soFmBwQjZ9YEQCDB3sPyH2KkfgT
         ki0oj+ZVETNyIgvcMdy70+dFRpI5iA6jzXylTRP32w34i0fYRL70onTbkDVLZN9fTMdN
         JMZy7rsRaKAaESBoboF/8apeBg33BqnRmyHuV1JKeEHQ7UwhLKtzyTp8k73DNZnWrCIX
         qsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765735343; x=1766340143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFXHMGeoomdbZOLp3ce3D0yDHo0q4hSajO4R4fHl4CQ=;
        b=UHrLYMr2reGTadmSx01G2yROA+YuxYcvzf/DMVTqQFxgyAEqgi0bWpq/D4yonS9QsT
         M1OirCB1jvI2YR6tiQ4OzGxAjjjWoqBtQzyyIX6DwiH9I1c/BfBCIRBK2lQGPrza9OX3
         21rcuYS6/I+9ai/hIIB8aYGNjHX3s/wzE2MyPgKSPIm/JzNkopALJkgF+/nUYvOZX4IO
         HS4mff/VDmWvSJwri2JqC893Qhb8iOJBHq0Z7fjPTuY/T0HPm6CyxRCaPRONanL2tapK
         MruKwh+5K8tPGjBDq+rf0H4qkcrkjFOWKJFzIIazJ+N6dzifWHHhgfn7atvLrXJu5R/O
         ZGkg==
X-Gm-Message-State: AOJu0YzTw/7taRv4QDZpVLxYQBzfDO9lWfuBeuPVgzctX3S6DXGqhxOJ
	uoifcSnYTGdxg2ZEA39joHOqvIeraCoOgoTw0hJ0tPmIKFmIiqPkdILREsNY+g==
X-Gm-Gg: AY/fxX5r41OdVoEz93FxulYoBvppeMqwMQ/8QROxWCOuEe7vz++DWZQa7CMyZlWNAkR
	3VqqeG4G9ADfcrIq1BQXuEXqwVb7vhOW9FqKJTqxWqTgJyepmNDpDHauKEiBMIkzk07AG3bYdf/
	6B4UQHVTvbsLPWI1Z7Hw818985Fu/afQTKrlXu9GSrowFvi/u2zGQxpmtqXIO+FizZNfHPXv1+Y
	ZsVE/XGEyR/cES1dsv4/W3BVSMEVGOlv+us1U0P+5rr70NICH1KJC0CYYD9S6/mghsfsL6yIGmu
	xf8Ax++cIwop5CsXdZf213vJXFwZmj5w3ZF7jIRY37FvC8McqQQBH6bJZo/fHd/kFeyMXsQ2DPZ
	273muE8JDN75Z98WZFTDs3sEfpfCTOejoRImoqURULts1qdyAsu9K3s5TTm+jk4Yhgr8JvM6I8l
	xJFJykaVFLBDSHRDJSWT6sMReyt8RD3IFFSqzVE1vTrwdk+GlFBXQ1/8kZ62y6UMGc
X-Google-Smtp-Source: AGHT+IFBYOK1tyGfwO114byCkmi23dhpNbs6vJuHuSe5U0l9V4ENnxuM2Cf0xygYGmqZgWbSG1E/mw==
X-Received: by 2002:a05:6000:240a:b0:430:f494:6a9c with SMTP id ffacd0b85a97d-430f4946d3amr3593476f8f.17.1765735342647;
        Sun, 14 Dec 2025 10:02:22 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f5f6ede8sm7167762f8f.4.2025.12.14.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 10:02:21 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/5] openrisc: Fix IPIs on simple multicore systems
Date: Sun, 14 Dec 2025 18:01:43 +0000
Message-ID: <20251214180158.3955285-4-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214180158.3955285-1-shorne@gmail.com>
References: <20251214180158.3955285-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c05671846451 ("openrisc: sleep instead of spin on secondary
wait") fixed OpenRISC SMP Linux for QEMU. However, stability was never
achieved on FPGA development boards.  This is because the above patch
has a step to unmask IPIs on non-boot cpu's but on hardware without
power management, IPIs remain masked.

This meant that IPI's were never actually working on the simple SMP
systems we run on development boards.  The systems booted but stability
was very suspect.

Add the ability to unmask IPI's on the non-boot cores.  This is done by
making the OMPIC IRQs proper percpu IRQs.  We can then use the
enabled_percpu_irq() to unmask IRQ on the non-boot cpus.

Update the or1k PIC driver to use a flow handler that can switch between
percpu and the configured level or edge flow handlers at runtime.
This mechanism is inspired by that done in the J-Core AIC driver.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/smp.h |  3 ++-
 arch/openrisc/kernel/smp.c      | 22 +++++++++++++++++++++-
 drivers/irqchip/irq-ompic.c     | 15 +++++++++++----
 drivers/irqchip/irq-or1k-pic.c  | 27 ++++++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/include/asm/smp.h b/arch/openrisc/include/asm/smp.h
index e21d2f12b5b6..007296f160ef 100644
--- a/arch/openrisc/include/asm/smp.h
+++ b/arch/openrisc/include/asm/smp.h
@@ -20,7 +20,8 @@ extern void smp_init_cpus(void);
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
+extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int),
+			       unsigned int irq);
 extern void handle_IPI(unsigned int ipi_msg);
 
 #endif /* __ASM_OPENRISC_SMP_H */
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 86da4bc5ee0b..040ca201b692 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -13,6 +13,7 @@
 
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/irq.h>
@@ -25,6 +26,7 @@
 
 asmlinkage __init void secondary_start_kernel(void);
 
+static unsigned int ipi_irq __ro_after_init;
 static void (*smp_cross_call)(const struct cpumask *, unsigned int);
 
 unsigned long secondary_release = -1;
@@ -39,6 +41,14 @@ enum ipi_msg_type {
 
 static DEFINE_SPINLOCK(boot_lock);
 
+static void or1k_ipi_enable(void)
+{
+	if (WARN_ON_ONCE(!ipi_irq))
+		return;
+
+	enable_percpu_irq(ipi_irq, 0);
+}
+
 static void boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/*
@@ -136,6 +146,7 @@ asmlinkage __init void secondary_start_kernel(void)
 	complete(&cpu_running);
 
 	synchronise_count_slave(cpu);
+	or1k_ipi_enable();
 	set_cpu_online(cpu, true);
 
 	local_irq_enable();
@@ -195,9 +206,18 @@ void smp_send_stop(void)
 	smp_call_function(stop_this_cpu, NULL, 0);
 }
 
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
+void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int),
+			       unsigned int irq)
 {
+	if (WARN_ON(ipi_irq))
+		return;
+
 	smp_cross_call = fn;
+
+	ipi_irq = irq;
+
+	/* Enabled IPIs for boot CPU immediately */
+	or1k_ipi_enable();
 }
 
 void arch_send_call_function_single_ipi(int cpu)
diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
index e66ef4373b1e..f0e0b435bb1d 100644
--- a/drivers/irqchip/irq-ompic.c
+++ b/drivers/irqchip/irq-ompic.c
@@ -84,6 +84,8 @@ DEFINE_PER_CPU(unsigned long, ops);
 
 static void __iomem *ompic_base;
 
+static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
+
 static inline u32 ompic_readreg(void __iomem *base, loff_t offset)
 {
 	return ioread32be(base + offset);
@@ -183,12 +185,17 @@ static int __init ompic_of_init(struct device_node *node,
 		goto out_unmap;
 	}
 
-	ret = request_irq(irq, ompic_ipi_handler, IRQF_PERCPU,
-				"ompic_ipi", NULL);
-	if (ret)
+	irq_set_percpu_devid(irq);
+	ret = request_percpu_irq(irq, ompic_ipi_handler, "ompic_ipi",
+				 &ipi_dummy_dev);
+
+	if (ret) {
+		pr_err("ompic: failed to request irq %d, error: %d",
+		       irq, ret);
 		goto out_irq_disp;
+	}
 
-	set_smp_cross_call(ompic_raise_softirq);
+	set_smp_cross_call(ompic_raise_softirq, irq);
 
 	return 0;
 
diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index 48126067c54b..73dc99c71d40 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -118,11 +118,36 @@ static void or1k_pic_handle_irq(struct pt_regs *regs)
 		generic_handle_domain_irq(root_domain, irq);
 }
 
+/*
+ * The OR1K PIC is a cpu-local interrupt controller and does not distinguish or
+ * use distinct irq number ranges for per-cpu event interrupts (IPI). Since
+ * information to determine whether a particular irq number should be treated as
+ * per-cpu is not available at mapping time, we use a wrapper handler function
+ * which chooses the right handler at runtime based on whether IRQF_PERCPU was
+ * used when requesting the irq.  Borrowed from J-Core AIC.
+ */
+static void or1k_irq_flow_handler(struct irq_desc *desc)
+{
+#ifdef CONFIG_SMP
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct or1k_pic_dev *pic = data->domain->host_data;
+
+	if (irqd_is_per_cpu(data))
+		handle_percpu_devid_irq(desc);
+	else
+		pic->handle(desc);
+#endif
+}
+
 static int or1k_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct or1k_pic_dev *pic = d->host_data;
 
-	irq_set_chip_and_handler(irq, &pic->chip, pic->handle);
+	if (IS_ENABLED(CONFIG_SMP))
+		irq_set_chip_and_handler(irq, &pic->chip, or1k_irq_flow_handler);
+	else
+		irq_set_chip_and_handler(irq, &pic->chip, pic->handle);
+
 	irq_set_status_flags(irq, pic->flags);
 
 	return 0;
-- 
2.51.0

