Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17053C433EF
	for <openrisc@archiver.kernel.org>; Mon,  9 May 2022 22:32:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id ECACC24903;
	Tue, 10 May 2022 00:32:31 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mail.librecores.org (Postfix) with ESMTPS id 839EE2490D
 for <openrisc@lists.librecores.org>; Tue, 10 May 2022 00:32:29 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id bo5so13420396pfb.4
 for <openrisc@lists.librecores.org>; Mon, 09 May 2022 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=tZRB3zIhTe4/kb2F6h0EyN2enk/ffsUfIt+uwvi71Kg=;
 b=J+qsV4sWyFVIgrDABezJovYhrW4Jzg11JZEk3WHOu3XuH7ze7t8fja6VuYB/Q9+tvp
 hEGF1icNSsM/0iiwFW281ATk7W6c7j7aGjBVYF99/u2B+jtb1YPKidpHvOTI9Jz4Lxh0
 6ez184UbojY7hhrrt0T6FZE8HWD85dHmAjAnZ8oC2Zoi0XQiqEUxOtwdNZdV12X1XPpb
 eOYtED253uK5GFiuWQ0wMSV73xWdJ5eHnN6WbBvwyOEpmAXVeAgkp/8WXuJtj+PnD01O
 qpc9n7G8viwouPMU6f6ZYvZjxFGQ2Vre7sEym/xdvKnlQk1eXINRDKWRRUAa4P4IDS/e
 ukRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tZRB3zIhTe4/kb2F6h0EyN2enk/ffsUfIt+uwvi71Kg=;
 b=Ww/UJdck8bNJ0brjoZIEmYwp/C5qkyFyCpNk/Z80BbXf1NV8hR09df2bhU1lp9undm
 JOZue1VU3SB9NEsSjqRioOA0HWvilQ1hQ+2n0MFnica/Wp7iUIagVp/aqGiRA6hrnJYO
 Nld8IgYwHXZdiAip9/S8qk9TfWcwFX3vb2dVlzYj0QWp6H6rQ5mDdsOOs3CRVjRyLQHw
 rATiNc7LTtAVUMSdg+bgLLvIG6Z1LrqmbxNhoojqYH+/LJl5EVLCm2J5zR1GRu1HNhBr
 s9mRMr42RQ6q09LcPFkCn6RBpbdkN9IN+9BLzHxeTXMSUD8S3e8cX4TVKc/poHxnRPvp
 51VA==
X-Gm-Message-State: AOAM531feDhp4d8nsUftOd8O7oi30OpKgCi5IQ6BMsKKrcinf1pw7LOi
 vkPuBbXLfGqp6Or8sCKBRx2uKw==
X-Google-Smtp-Source: ABdhPJwTvHuoY8QbgphQvJH1puYeHk+wgzU1cmj+NdWGbUsi4eAleYRwVAU4/MCzw+CVlQAM7BcJ9A==
X-Received: by 2002:a63:8749:0:b0:3c6:aa1d:bd3c with SMTP id
 i70-20020a638749000000b003c6aa1dbd3cmr7379146pge.403.1652135548093; 
 Mon, 09 May 2022 15:32:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 20-20020a630d54000000b003c14af50627sm9008129pgn.63.2022.05.09.15.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 15:32:27 -0700 (PDT)
Subject: [PATCH v5 4/7] openrisc: Move to ticket-spinlock
Date: Mon,  9 May 2022 15:29:53 -0700
Message-Id: <20220509222956.2886-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509222956.2886-1-palmer@rivosinc.com>
References: <20220509222956.2886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: peterz@infradead.org, Palmer Dabbelt <palmer@rivosinc.com>,
 guoren@kernel.org, jszhang@kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, jonas@southpole.se, linux-csky@vger.kernel.org,
 mingo@redhat.com, longman@redhat.com, linux-arch@vger.kernel.org,
 aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>, boqun.feng@gmail.com,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, sudipm.mukherjee@gmail.com,
 macro@orcam.me.uk
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Peter Zijlstra <peterz@infradead.org>

We have no indications that openrisc meets the qspinlock requirements,
so move to ticket-spinlock as that is more likey to be correct.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/openrisc/Kconfig                      |  1 -
 arch/openrisc/include/asm/Kbuild           |  5 ++--
 arch/openrisc/include/asm/spinlock.h       | 27 ----------------------
 arch/openrisc/include/asm/spinlock_types.h |  7 ------
 4 files changed, 2 insertions(+), 38 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/spinlock.h
 delete mode 100644 arch/openrisc/include/asm/spinlock_types.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 0d68adf6e02b..99f0e4a4cbbd 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -30,7 +30,6 @@ config OPENRISC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
-	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..3386b9c1c073 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
-generic-y += qspinlock_types.h
-generic-y += qspinlock.h
+generic-y += spinlock_types.h
+generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
deleted file mode 100644
index 264944a71535..000000000000
--- a/arch/openrisc/include/asm/spinlock.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- * et al.
- */
-
-#ifndef __ASM_OPENRISC_SPINLOCK_H
-#define __ASM_OPENRISC_SPINLOCK_H
-
-#include <asm/qspinlock.h>
-
-#include <asm/qrwlock.h>
-
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
-
-#endif
diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
deleted file mode 100644
index 7c6fb1208c88..000000000000
--- a/arch/openrisc/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
-#define _ASM_OPENRISC_SPINLOCK_TYPES_H
-
-#include <asm/qspinlock_types.h>
-#include <asm/qrwlock_types.h>
-
-#endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
-- 
2.34.1

