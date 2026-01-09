Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFD35BDC9
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966284; cv=none; b=nSZSzPTvc52s0IbAy4bp36VwxjQZIQ3TFEdeprtIhyIAVr19Df1fzlbfgBMxZebOkkll2362962a1AgJZZRBrRrmzR7QiecdULN2IQ2J6JKZrMTb76TcjT4q+XL1wr62VShXkDOV6JndQMGW+hzP6+vMS58RHS5URu8D+KrI9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966284; c=relaxed/simple;
	bh=Upo/KeJ1tydzhEX3FEnB2Lq6CdSMUiNT1LlycW0K1NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tot8Ofdd7whO3VTLBqUlLW/epsscOCs5XuLfUIzziINUMMDy5KYX2S8tFaD2t0qluzH4sNrdOzJs4tUl8v4exk+5jzFPuoni6Fjt3yxgMl5I3Zm9wzOoHlx8sE9SvZucqFqW1GlvLL1prt9D+oT7j0c+sc7+H7mApdzEbkYHfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzxVsvk9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzxVsvk9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so3450041f8f.2
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966277; x=1768571077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFXHMGeoomdbZOLp3ce3D0yDHo0q4hSajO4R4fHl4CQ=;
        b=DzxVsvk9sq38COq/EXceOTw5+SkCdykMCrCuXWlT2U5zh24Ey6rvsiqp/ihyp6xuOP
         6qD4OsOTw9H2y+PNO43t0kOAu/KVANDyvia5M4DpO4QXBs5jWtpv8lVqZTmu5h/y6/Qf
         sPYCLTQJIW/HfTQVBiakPJMa95PdOqv1HM6YKkryu+k+1IL0k5zP7KINMT3CYogj7Mwh
         BCkrJH+ezKm0MaQg5ZTOfAytCuyvsXe9/mu6Fvo15h0nDlzm3PJO2QJ1ItfvErNBzoWE
         cH0tBODhGvREAy4b2ShWlUY+Lo6TNAud5A6Io6U/k7Gw3LMr9hunT6ShM1iRdb1bLfYW
         1Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966277; x=1768571077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFXHMGeoomdbZOLp3ce3D0yDHo0q4hSajO4R4fHl4CQ=;
        b=q32ccaGXPkkrnh76lR92OaepxrOJ32L2XiZiR/N+ts1VaXFWMCC4a9fdC7cd4Hr/Nv
         0jFRN0AmMso68pbYr4Wc8jIkJ4KFCr1j4SgTspdxYqkz2O5VfRLLgRfiMPYrtghmyHQG
         1272TfMMjq94kZoQ6JN/Mq0+i7RNZpB6FtXwcyrfClaalBdrEPO3IxoX6kOUrsZ6WMtN
         RiEVvf4C22ipq7KRuS3OJPbTYhzY5OYGD+IFiUi8pTVruTFXNtv6ma8JsWGqTTNwHaKe
         aMBaKW+K1i5ma0Ss+8vBC8/yChMfEIUN9VLEf38hjKFBqalc1QNCo69hzZoVUsn9Vlpd
         wcRg==
X-Gm-Message-State: AOJu0Yy8sQgmcUJXdTHokdtVEb6hfKUAilA2t/sVESYgovSSCVzbG0eG
	9F6o9mh5qTtvDp0RFXePGLP6Dfw+HWsB8zWr7o5Uli/s0jKA8rKBa7Yz
X-Gm-Gg: AY/fxX7CU5KHwyeEQ2+AnFx8cc48QH7ESdHHJj7DAGSp0RNBxY2CTzwQnKXH3Nnv6Av
	4zTA5F9BleoAFoWAHQYIyjSKjnUD5d6tpQcwh18HDZONJcsr5GcNjx2jgJ/xNRibicywAut2wOv
	q59zdeLnj0UGr0LxL9WajTeIw0QdyawMhywwaBl0Si4innmyX5JbWKc8wigLc4Xg46kukq+/czL
	OH+GGrYlJOJpJAP49BoM1TOwjUDw2bMVdJoewiz43CgqTQEZbuW/l2l9C++bHYrcG6h5iGnmgzO
	uZBZJun5oNg97nysB6Ko3k8/RT93/nJXLLUJ5KnJmrei1fkK71PW9fzDFuNdmHXWS3MGWj/ec/o
	HtiUAIzwtZDa5Tfn9tc6X1e1pRVll6h+9saNypBVkMQAo3BTXiUJ3hDh+XInN+YcxrbCH6fHGCV
	ADomq7pG6KFYgdRNnPEqX7ltfN/l8HYNPRBXVZl7jR7ZXUa7opzMCI5AhqzUnTr0SN
X-Google-Smtp-Source: AGHT+IHZQoFtqq+7pXWo9CI4HdTv8iw93DcZ3knjJJYcfuMygPzsSwYV++HNu5fIXxFgXn1FqOzKSw==
X-Received: by 2002:a05:6000:2305:b0:431:a33:d864 with SMTP id ffacd0b85a97d-432c3790a14mr12113322f8f.18.1767966277267;
        Fri, 09 Jan 2026 05:44:37 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm22383077f8f.31.2026.01.09.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:36 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 4/6] openrisc: Fix IPIs on simple multicore systems
Date: Fri,  9 Jan 2026 13:43:55 +0000
Message-ID: <20260109134409.2153333-5-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109134409.2153333-1-shorne@gmail.com>
References: <20260109134409.2153333-1-shorne@gmail.com>
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

