Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB3C4332F
	for <openrisc@archiver.kernel.org>; Mon,  9 May 2022 22:32:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 22AB2248FE;
	Tue, 10 May 2022 00:32:30 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id 4A113248FE
 for <openrisc@lists.librecores.org>; Tue, 10 May 2022 00:32:26 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 cq17-20020a17090af99100b001dc0386cd8fso579222pjb.5
 for <openrisc@lists.librecores.org>; Mon, 09 May 2022 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ZW4Wh2F92AaGgkTq3RYNioOG15W5RvqR7U43OAjNTGE=;
 b=OJ8/z1H0yxOfjvNIz5GyJj5zfB3yzETOSWZgiZ4JDbCXZ4D/Fw0kDuTE+TVB7WnjKz
 f10yDnI2QhASS2wNA9HaJ3RgUMeT75ziZXqgEzTmHHJtxq59d2fXeEjM5wOAxZW2NzD1
 vsqWI3UMY+G9WNlAQbNLY9dcfzxfr+bKESuRkrl9KWNGc0FcGikBLc/QIWcVyMnbd54f
 g3kXLZhpt3B23HL6lhDUviKv8fCVonj8AkNF1BOtU4dS23DtdFTjMLYo7kVdPu9uaMRF
 r3zvAnCirXnIri808iEE9IDgcsFN4ys53jS+uv4sZq5oYQt047znsym3BXBmMlanOmDg
 Sl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ZW4Wh2F92AaGgkTq3RYNioOG15W5RvqR7U43OAjNTGE=;
 b=idR9+HVJkpLzv7KKvYm8ya1w1Vk9P9Y1R1MI3PiiyHkgHz9q2fibJJPKk3h4/p6CAM
 vmAIMKuEb/eSqXm72OTCFn10beraB5ku0MJcnEiTu69AkZNROrnoO0MoGfYMMZr0+fxM
 MR6ZAGDfQsqOMNhYZRxkQsL+DWi0fWHCk9OyJ4X/cADDANklMMQbINDjFJ9LSluLycVI
 Y2LlplxbetncZbspVsaGLfk/Qg9snmWFtKzFiyIUQdsUNb4x6espfttjnKi6mPNimtTb
 lXmZ7BdCTrap89uCyKfW2FAXQ56ZyxjZg0HAfC12Pt7wMI6/vJaNtDTHHP3YQ9Yqy6X5
 yrAg==
X-Gm-Message-State: AOAM533/rc5N2NBtAGzVXa1POTXBUVLZUYZE3uxYUSiGhYVeaWqkrS2P
 s3cnGuHmdXrKt2hsSXCKUp2p9A==
X-Google-Smtp-Source: ABdhPJx0hcRTNWyyUDxvbLajs6wyBIGgRAtfmL2Lsz3K2ittGTQcIfLVbn7WWX9D3t+/vP39Ej+XHg==
X-Received: by 2002:a17:902:bf09:b0:153:99a6:55b8 with SMTP id
 bi9-20020a170902bf0900b0015399a655b8mr17645821plb.142.1652135544838; 
 Mon, 09 May 2022 15:32:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 w8-20020a170902e88800b0015eb200cc00sm378567plg.138.2022.05.09.15.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 15:32:24 -0700 (PDT)
Subject: [PATCH v5 1/7] asm-generic: ticket-lock: New generic ticket-based
 spinlock
Date: Mon,  9 May 2022 15:29:50 -0700
Message-Id: <20220509222956.2886-2-palmer@rivosinc.com>
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
Cc: Heiko Stuebner <heiko@sntech.de>, peterz@infradead.org,
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

From: Peter Zijlstra <peterz@infradead.org>

This is a simple, fair spinlock.  Specifically it doesn't have all the
subtle memory model dependencies that qspinlock has, which makes it more
suitable for simple systems as it is more likely to be correct.  It is
implemented entirely in terms of standard atomics and thus works fine
without any arch-specific code.

This replaces the existing asm-generic/spinlock.h, which just errored
out on SMP systems.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/spinlock.h       | 94 +++++++++++++++++++++++++---
 include/asm-generic/spinlock_types.h | 17 +++++
 2 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 include/asm-generic/spinlock_types.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index adaf6acab172..fdfebcb050f4 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -1,12 +1,92 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_SPINLOCK_H
-#define __ASM_GENERIC_SPINLOCK_H
+
 /*
- * You need to implement asm/spinlock.h for SMP support. The generic
- * version does not handle SMP.
+ * 'Generic' ticket-lock implementation.
+ *
+ * It relies on atomic_fetch_add() having well defined forward progress
+ * guarantees under contention. If your architecture cannot provide this, stick
+ * to a test-and-set lock.
+ *
+ * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
+ * sub-word of the value. This is generally true for anything LL/SC although
+ * you'd be hard pressed to find anything useful in architecture specifications
+ * about this. If your architecture cannot do this you might be better off with
+ * a test-and-set.
+ *
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
+ * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
+ * a full fence after the spin to upgrade the otherwise-RCpc
+ * atomic_cond_read_acquire().
+ *
+ * The implementation uses smp_cond_load_acquire() to spin, so if the
+ * architecture has WFE like instructions to sleep instead of poll for word
+ * modifications be sure to implement that (see ARM64 for example).
+ *
  */
-#ifdef CONFIG_SMP
-#error need an architecture specific asm/spinlock.h
-#endif
+
+#ifndef __ASM_GENERIC_SPINLOCK_H
+#define __ASM_GENERIC_SPINLOCK_H
+
+#include <linux/atomic.h>
+#include <asm-generic/spinlock_types.h>
+
+static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, lock);
+	u16 ticket = val >> 16;
+
+	if (ticket == (u16)val)
+		return;
+
+	/*
+	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
+	 * custom cond_read_rcsc() here we just emit a full fence.  We only
+	 * need the prior reads before subsequent writes ordering from
+	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
+	 * have no outstanding writes due to the atomic_fetch_add() the extra
+	 * orderings are free.
+	 */
+	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
+	smp_mb();
+}
+
+static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(lock);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	u32 val = atomic_read(lock);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return ((val >> 16) != (val & 0xffff));
+}
+
+static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return !arch_spin_is_locked(&lock);
+}
+
+#include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
new file mode 100644
index 000000000000..8962bb730945
--- /dev/null
+++ b/include/asm-generic/spinlock_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
+#define __ASM_GENERIC_SPINLOCK_TYPES_H
+
+#include <linux/types.h>
+typedef atomic_t arch_spinlock_t;
+
+/*
+ * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
+ * include.
+ */
+#include <asm/qrwlock_types.h>
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+
+#endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
-- 
2.34.1

