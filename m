Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5213ACF02
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489855; cv=none; b=EMIZ8TjsRqlButvJWCQQK1FsDfqvH78uOTbgq8+E+N08Z/9H+X4mf6TqlWs7RUKwdF2Xn0sjl7U7V4wRdX1jOYuEk9RAGgou4M5tgtm8mHHF4N0+6XoLvEVPORiJTKITWSGHWHm5WB607bq+RLBkuWdtKnhPYrHWcUf2zAtpjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489855; c=relaxed/simple;
	bh=IKKdRw2BPRZGdSnokUi+lLWreRL7wCXnn1Ye9vz44zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf9trlIcx9BH6Vp9nX6ARzyAobnYja7ZOZ8XI6XFmQA752Ff/N5g+0lahWbWTN/EJDeTURlL2nxjDCBAnj123WzJfpYC6rNZo4+DYn4FLJgSwhrCXQYLM+SyBUhUBgkHPbaiXUOHhFMfCMaakmmjQLvGhoPA8TxywlZDJSJ0MD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKpAD379; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKpAD379"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so7634035e9.2
        for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489836; x=1769094636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjqV3wlU4tHE/m54DQEIhq4RJtDBUToXmEOJfRTmvP0=;
        b=UKpAD379w186/vZ/Aapff8yCWVmtIZW0MA2y8tdn6C//mCBemtqXbNbRni4DAxIor0
         a75l0vk0WvpjVyDSDAxapIwQ2aD6ULjK9TUgf4I6VDO/c+lYt1q2L80AJaTiaCEQYsKz
         kcnTH3uYmuqcYpGUNRyVcHTtWY6FUYa/kRE1R1K+6vmyRupt8t0CDTkV9XnokFupwrO6
         eNOlosI7vpDlZ7CnLi5zrKNHWDUaAQGLKnVrUtpMD2oOSlb972U1dXukELIipR+Nlo+G
         nYPpWJE/ejx1ybAbZxCLFId3TADEqTbmuCmzGKYMz8DWUFhDd8lIB+CLPCBf6Zxy6kth
         WJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489836; x=1769094636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjqV3wlU4tHE/m54DQEIhq4RJtDBUToXmEOJfRTmvP0=;
        b=ioESHmnt4zQpsiu+rAuphNiUjOhJy/S8b0E7SSlBhtLApHpHlCcVoDpKoM3tuY8zO9
         pYYDgUI8KlduWiCK9aRz32HeCPK0Xf04ngm5UgpuVD1ZPJe2CKsVUqlxdnDPm4VAp7Tr
         fgL1jUKOMCDpK/Ol4Kh4U5iB92UDP3RrB5jkdB+2+Q/spBqCFWyWOA62+/KdVTXbAqEl
         l3qkDKD7BniV2Mo331ctQkVjjAfarRhLkWNeaev2VwUkBysZFCU5jlDRW53FC3FvuyGM
         dZJtVWejJTiW0ZKpjz7emlF0dA6SqIoyC2RxJKrKYoA2HqydsYi43qHRwwezPC8y7XaN
         CrFw==
X-Gm-Message-State: AOJu0YzSjBxhEES0Es+bkrJlPI8sXZ0Dib3FW5nDGWrFibCbekVES/sB
	JI9QWU4Bmze3SoZekBKUsoMtGTrO4fqE349xuhoyKNNJZzjR1T00mf2l
X-Gm-Gg: AY/fxX4Pw5T5/HXN33G4CBk0g0AlJorfhcmXOleSwtyBk3Mq060GgclgjO14LppzOzM
	6Yia35g8yqShqfXA5dOlVfNhHDWWandQi48ifN7VnqjkfDSmvYc7XDyMmuHeGck9WU+Wg7l8B0+
	eAzHubEnT9E/C0weGAWBjG+TU7TeGm+w+G0ihFxvoSrsSRSGG8jONrQWNwOndS7567OJbFgo7ob
	OiiiMX4O/4uWC1xR5U4aiCSuEL+cAmu8FSYItqRLd9ymD2k/mIm5rTj6HeVLtvwwfU5ouE0eQgQ
	uuBbaUzeVWvn9zAZ1TDbN80Jjg2GNI5sBlDGxP1+ytzcdoEAQxQvgEZmsamCyIGTPuJZkR/uV2I
	yj5kwU8FrKaSLc0IKOukippfvRm1B7blu5KYEhjMwAB0OdSMCDSADgEc2/bGQxlnUh4OQ4MJOYc
	UKXaIqm94x1Xf+Mo4SFCusevUos8xZgWLFPxb6lP9iJurfX9AZG+2m2re4XoZ9P7yuctPtcsPn/
	Vc=
X-Received: by 2002:a05:600c:4693:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-4801e30ae84mr1037785e9.9.1768489835791;
        Thu, 15 Jan 2026 07:10:35 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b26764fsm51725885e9.12.2026.01.15.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:10:34 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v6 4/6] openrisc: Fix IPIs on simple multicore systems
Date: Thu, 15 Jan 2026 15:10:00 +0000
Message-ID: <20260115151014.3956805-5-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115151014.3956805-1-shorne@gmail.com>
References: <20260115151014.3956805-1-shorne@gmail.com>
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
Acked-by: Thomas Gleixner <tglx@kernel.org>
---
Since v5:
 - No changes.
Since v4:
 - Added acked-by.

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

