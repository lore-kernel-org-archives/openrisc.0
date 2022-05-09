Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7588C433F5
	for <openrisc@archiver.kernel.org>; Mon,  9 May 2022 22:32:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D1B5A248FE;
	Tue, 10 May 2022 00:32:34 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mail.librecores.org (Postfix) with ESMTPS id 41E5E2490A
 for <openrisc@lists.librecores.org>; Tue, 10 May 2022 00:32:33 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id s14so15189742plk.8
 for <openrisc@lists.librecores.org>; Mon, 09 May 2022 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Z3KkgMzaCsKED3+22qU0jRs/X/gxCeKEBc73aw1loXs=;
 b=5vPCveToxUi4ttmh8DPCDy3ak9rPZYrBa1vVaCCIrmS6NeHkVk5bHBq8IVjFktNkNG
 AvYErCFvU0+hXObXVqDU8qyV4bDHC4+o8GCF5qmDERdGC4UhP8jFXa9zTk7wsrCBS3Ur
 hYBnHEgjZeYUJO6BBpoZJiINRKpgW38BN9zIXLfpOOD6MVlW+Mj9iXUaiyV7h5ASvLqZ
 hVURqRgWeSjGJCcO3SUgK9XiJKniI+25OVH+/6Lr3S1gUjbadvAJMRYa/PDQ436HjsAT
 QrveNwpwVx4a+V1WgcLhb2cl1ZogdB/YI2keetilTCYkVwt47kvVoj8unXjX9rKFjbkg
 CWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Z3KkgMzaCsKED3+22qU0jRs/X/gxCeKEBc73aw1loXs=;
 b=obVJhN1nIQBjUIwfyJfnXjIXMk0n9CbVSYkhzwNLDfGiOb0lP0+DXNHSQiZ/pvNjAk
 1oTwqFAxzGiwzLpBL9kjJ0iy+MsSMWxcEJJCduK9CVVDvz/Gx9nODfvSAwLCm8sMThDS
 fJr00yrd7S1omNcBUeUIHAS+EUPSIBDuwk7D0RlEZdyB/ZlJMawl8x5M2On+TJH/bNym
 Pa0Zd9H/kPKhvOkKcNro6JSCL+fidTNxanqYiNivjDDovaEPk9tyR201jKKKKLlMLrcE
 nae/nqdJjyG5JQADWftjZosjFZj52GV86vqkmQDIkKI97SDTukG1lfkQcC3j4tMx9vex
 mWcQ==
X-Gm-Message-State: AOAM533LttYuvlAQCdEXEYv7ZmiYezP590yaKvw6AoAZV4q357MBWzzq
 9sG82mxvbPV6sWoI7EY6gEPxOw==
X-Google-Smtp-Source: ABdhPJw7JCborLgVxycE/OcVHLhZbdmXu7Ia1T+hDGVVlKqCVv1PQUH1RupjT9FzRxe0AXir7lMqhA==
X-Received: by 2002:a17:90a:a385:b0:1cb:bfa8:ae01 with SMTP id
 x5-20020a17090aa38500b001cbbfa8ae01mr19875610pjp.116.1652135551812; 
 Mon, 09 May 2022 15:32:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 r5-20020a170902ea4500b0015eddb8e450sm412122plg.25.2022.05.09.15.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 15:32:31 -0700 (PDT)
Subject: [PATCH v5 7/7] csky: Move to generic ticket-spinlock
Date: Mon,  9 May 2022 15:29:56 -0700
Message-Id: <20220509222956.2886-8-palmer@rivosinc.com>
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
Cc: Guo Ren <guoren@linux.alibaba.com>, peterz@infradead.org,
 Palmer Dabbelt <palmer@rivosinc.com>, guoren@kernel.org, jszhang@kernel.org,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 jonas@southpole.se, linux-csky@vger.kernel.org, mingo@redhat.com,
 longman@redhat.com, linux-arch@vger.kernel.org, aou@eecs.berkeley.edu,
 Arnd Bergmann <arnd@arndb.de>, boqun.feng@gmail.com,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, sudipm.mukherjee@gmail.com,
 macro@orcam.me.uk
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Guo Ren <guoren@linux.alibaba.com>

There is no benefit from custom implementation for ticket-spinlock,
so move to generic ticket-spinlock for easy maintenance.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/csky/include/asm/Kbuild           |  3 +
 arch/csky/include/asm/spinlock.h       | 89 --------------------------
 arch/csky/include/asm/spinlock_types.h | 27 --------
 3 files changed, 3 insertions(+), 116 deletions(-)
 delete mode 100644 arch/csky/include/asm/spinlock.h
 delete mode 100644 arch/csky/include/asm/spinlock_types.h

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 888248235c23..103207a58f97 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -3,7 +3,10 @@ generic-y += asm-offsets.h
 generic-y += extable.h
 generic-y += gpio.h
 generic-y += kvm_para.h
+generic-y += spinlock.h
+generic-y += spinlock_types.h
 generic-y += qrwlock.h
+generic-y += qrwlock_types.h
 generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
deleted file mode 100644
index 69f5aa249c5f..000000000000
--- a/arch/csky/include/asm/spinlock.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_CSKY_SPINLOCK_H
-#define __ASM_CSKY_SPINLOCK_H
-
-#include <linux/spinlock_types.h>
-#include <asm/barrier.h>
-
-/*
- * Ticket-based spin-locking.
- */
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	arch_spinlock_t lockval;
-	u32 ticket_next = 1 << TICKET_NEXT;
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%2) \n"
-		"	mov		%1, %0	 \n"
-		"	add		%0, %3	 \n"
-		"	stex.w		%0, (%2) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp), "=&r" (lockval)
-		: "r"(p), "r"(ticket_next)
-		: "cc");
-
-	while (lockval.tickets.next != lockval.tickets.owner)
-		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
-
-	smp_mb();
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 tmp, contended, res;
-	u32 ticket_next = 1 << TICKET_NEXT;
-	u32 *p = &lock->lock;
-
-	do {
-		asm volatile (
-		"	ldex.w		%0, (%3)   \n"
-		"	movi		%2, 1	   \n"
-		"	rotli		%1, %0, 16 \n"
-		"	cmpne		%1, %0     \n"
-		"	bt		1f         \n"
-		"	movi		%2, 0	   \n"
-		"	add		%0, %0, %4 \n"
-		"	stex.w		%0, (%3)   \n"
-		"1:				   \n"
-		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
-		: "r"(p), "r"(ticket_next)
-		: "cc");
-	} while (!res);
-
-	if (!contended)
-		smp_mb();
-
-	return !contended;
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
-}
-
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return lock.tickets.owner == lock.tickets.next;
-}
-
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	return !arch_spin_value_unlocked(READ_ONCE(*lock));
-}
-
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
-
-	return (tickets.next - tickets.owner) > 1;
-}
-#define arch_spin_is_contended	arch_spin_is_contended
-
-#include <asm/qrwlock.h>
-
-#endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
deleted file mode 100644
index db87a12c3827..000000000000
--- a/arch/csky/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_CSKY_SPINLOCK_TYPES_H
-#define __ASM_CSKY_SPINLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
-#endif
-
-#define TICKET_NEXT	16
-
-typedef struct {
-	union {
-		u32 lock;
-		struct __raw_tickets {
-			/* little endian */
-			u16 owner;
-			u16 next;
-		} tickets;
-	};
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
-
-#include <asm-generic/qrwlock_types.h>
-
-#endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
-- 
2.34.1

