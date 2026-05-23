Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8582E6CCD
	for <linux-openrisc@vger.kernel.org>; Sat, 23 May 2026 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514620; cv=none; b=OqLt0spNQepFcYrPtX3g0q57lOMTxFUgHNY43znbxcq941pG2saJ1OY7bB6IDxhkw1b9SmtsAwnKArUhsZcOirfKbljXfY2Y88FpHE2AsSyynJ6OvN8Bgi5+Npz3VmHsSHkSF5UpL9lXpBeEmptxG7jTqZDoCxjnf+MQTHueKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514620; c=relaxed/simple;
	bh=K1iy/7Us+v9iabohnw6QHdQ4FKbTQ+1yjGBvyFrzzaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djG5X6yyAlMpRcAeE/h+XvSG9aprDv6c13l44bO2mLP5B14zOPCjtm1eYLIch0pxsSCtA1f3DV7nnJHcjX+NOBxKpbhbkdLL3PjHhP/KTqewmQbBSAdVJqHsb6Aj0fuEyovjEJRsWaaiE+E4EbNT+Iv0m6bSTce3y6nitiTY1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQ8PAWkF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ8PAWkF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44509921fbcso5142726f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 22 May 2026 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779514618; x=1780119418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfCXYx65YgeEukMHypUmArLMk/VIi+xGB6BZmr+icPM=;
        b=rQ8PAWkFYtCSvihyR3Nf21St1nM3N2XyrNwWp8eAh+Z7W3C51MJKlyyTV5sNh4nf/e
         OU2OhCghSunIuXKUdvO5m1HMc8NB4beWjqIGZXMcTIgvi4F5AkZQ5jZnsr0ktvmOUQka
         fgz3Aspqm5+Cn9ti8uEA0ccnHJpPONqqeS2NGUGSGLiQHg7pA5XMlaIR6GJ7vyFe11jW
         DOg05O70HxJsAIKheBwB4um7XLvk+bRHXiHEq/hKF/6sQMkrZmKKbx8o31Rev1AID48c
         2FuEpWgQFLb6VKHQk3h6Q37OGPb4MdkpMQHe3HbYZeEpPwqEERKsXVXmcDEZiOGLVyHM
         5t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779514618; x=1780119418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfCXYx65YgeEukMHypUmArLMk/VIi+xGB6BZmr+icPM=;
        b=I5M79XyQbFnlPltsff3sI/+2KeVgEBiS9vQ2JtC8jzBnU95pGZCKmzFBKarhDrKonH
         dr99k6gR/jmo+RsiF77POur/Y1pAE6MYnEFdUGnwNQFPXMHKNsolmrQwgNrKHUOvhyNU
         /BvTbr6wGbomRxQNclMPMu3XcJ3mxnl0/FThcutVXMiSpFI+jmUtcpwvmqaZ3PRIf+k3
         3j8405fCaFcb1t6N5xLBdan5ugU8WaeoF+IPhWM29SW3jS82evObQg7ijPEKbRBmDv5Z
         3mM6FiyHx1esuQLCsYuyXjmClwOagE4XM5FfoeUvz03T6t23KhvPMcPkWgomTEiJ+FnS
         Z+tg==
X-Gm-Message-State: AOJu0YxQWq4tgkESX3v9eaRh55YLscrtFNffaOgEj3pYKYB3FHREqEXY
	ZRDYUyVpoisDB1ppLLtM2ufIRnI7PVzbCham8TrKZzJuYP64pHP3dZQ3
X-Gm-Gg: Acq92OFliacB1KjroPVrpgkv9J7P4Qh4ll2Fp8n14nwfGEy5jBbAahN5uJHf589x7Lv
	3pSyokJr8v3fn8uezfp/Pqct2Bk8qu2g9MkUJ4tJ0s56WrreNUhyt3oP9YtI7yfyxodrOLWGo0v
	uR9uOyhVyHOcEgjREt0UD6Chbwlw1MjCJKVpfv5qxR++K4xOKTaDrFOl0WlrP/CCQPQ7MieD2dD
	A17xpKiTZEIFhzBFToLbY/9IG5I5RU6i06DziPHZtI9EkPcHFgcual3/YnFxj5nncGa5H3rEnFa
	Ej6G8xwfqeP3m+gzRCB7bA9uF3pILDOlb7kB2n+nV+ONsw2iTDlu+XHUvNXqUU7vxnN4sgj/qMe
	tvdXa3wESiA5oxAI0j3yX4qDDw9FHQV1ez+IwulAlE0yAkk8SZIcmgSeRyQ+erLC8sjNcOgRYEs
	JL2FyoCXfYBYaSqWYYQZiIo5e5CBSPp2dLEBmpO2vHOZ5DzeX/PtkBHQuTCye6NoohBaU/38LqP
	ILUtw==
X-Received: by 2002:a05:6000:2007:b0:43e:a81d:c475 with SMTP id ffacd0b85a97d-45eb3673201mr10681423f8f.6.1779514617661;
        Fri, 22 May 2026 22:36:57 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm9473519f8f.30.2026.05.22.22.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:36:56 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH 3/3] openrisc: Fix jump_label smp syncing
Date: Sat, 23 May 2026 06:36:18 +0100
Message-ID: <20260523053624.630443-4-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523053624.630443-1-shorne@gmail.com>
References: <20260523053624.630443-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original commit 8c30b0018f9d ("openrisc: Add jump label support")
copies from arm64 and does not properly consider how icache invalidation
on remote cores works in OpenRISC.  On OpenRISC remote icaches need to
be invalidated otherwise static key's may remain state after updating.

Fix SMP cache syncing by:

 1. Properly invalidate remote core icaches on SMP systems by using
    icache_all_inv.  The old code uses kick_all_cpus_sync() which runs a
    no-op IPI function call on remote CPU's which does execute a lot of
    code and flushes many cache lines in the process, but does not flush
    all and it's not correct on OpenRISC.
 2. For architectures that do not have WRITETHROUGH caches be sure
    to flush the dcache after patching.

To test this I first reproduced the issue using a custom test module
[0].  The test confirmed that some icache lines maintained stale
static_key code sequences after calling static_branch_enable().  After
this patch there are no longer jump_label coherency issues.

[0] https://github.com/stffrdhrn/or1k-utils/tree/master/tests/smp_static_key_test

Cc: stable@vger.kernel.org # depends on openrisc: Add icache_all_inv
Fixes: 8c30b0018f9d ("openrisc: Add jump label support")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/jump_label.c | 2 +-
 arch/openrisc/kernel/patching.c   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
index ab7137c23b46..9cb63f2d2e2b 100644
--- a/arch/openrisc/kernel/jump_label.c
+++ b/arch/openrisc/kernel/jump_label.c
@@ -47,5 +47,5 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 
 void arch_jump_label_transform_apply(void)
 {
-	kick_all_cpus_sync();
+	icache_all_inv();
 }
diff --git a/arch/openrisc/kernel/patching.c b/arch/openrisc/kernel/patching.c
index d186172beb33..5db027b78bc4 100644
--- a/arch/openrisc/kernel/patching.c
+++ b/arch/openrisc/kernel/patching.c
@@ -49,6 +49,9 @@ static int __patch_insn_write(void *addr, u32 insn)
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
 	ret = copy_to_kernel_nofault(waddr, &insn, OPENRISC_INSN_SIZE);
+	if (!IS_ENABLED(CONFIG_DCACHE_WRITETHROUGH))
+		local_dcache_range_flush((unsigned long)waddr,
+					 (unsigned long)waddr + OPENRISC_INSN_SIZE);
 	local_icache_range_inv((unsigned long)waddr,
 			       (unsigned long)waddr + OPENRISC_INSN_SIZE);
 
-- 
2.53.0

