Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD07C4332F
	for <openrisc@archiver.kernel.org>; Fri, 23 Dec 2022 07:17:41 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6A5C5248F9;
	Fri, 23 Dec 2022 08:17:40 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by mail.librecores.org (Postfix) with ESMTPS id B002225B9D
 for <openrisc@lists.librecores.org>; Thu, 22 Dec 2022 12:48:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709725; x=1703245725;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F9SleecBAnyNkNrMFTTvSCZSu7ImUGAg65gwiv6wE30=;
 b=GNXhGi/ZbUzichoP3LTtHiwMVTSnH3BRImBZuJiLKTblfGzLwAtNWybV
 9RiSjoSwq6zDyGIIrVcl9InmB9lTcYJFlSC1Od1hRZEP6VlTPhAiHgxnS
 ZdVKoNLCxp+kSnQAIrKqri0ZKpZP0/eTq+pZZbsWHmZo1ub7URH7NeIyr
 tELSmrxmXOyq1oJpdduqGwiHf65Uham+p8AD+zrH9YVA7qjAW2CfK1W7X
 Ps6rNoM+ItRu/7xyRfZ7KI8rTtV+wbKpYooo56IvndBJ8LNe4eBf8W/oW
 QSmGW2y7mXFUAPKlqlF1ieVkmJAstMmR62xWjTy25/W2aww070o9a1jmh g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804805"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; d="scan'208";a="318804805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2022 03:48:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504822"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; d="scan'208";a="629504822"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2022 03:48:36 -0800
From: Andrzej Hajda <andrzej.hajda@intel.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 13/19] arch/riscv: rename internal name __xchg to __arch_xchg
Date: Thu, 22 Dec 2022 12:46:29 +0100
Message-Id: <20221222114635.1251934-14-andrzej.hajda@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222114635.1251934-1-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Dec 2022 08:17:29 +0100
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

__xchg will be used for non-atomic xchg macro.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 arch/riscv/include/asm/atomic.h  | 2 +-
 arch/riscv/include/asm/cmpxchg.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 0dfe9d857a762b..bba472928b5393 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -261,7 +261,7 @@ c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
 static __always_inline							\
 c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
 {									\
-	return __xchg(&(v->counter), n, size);				\
+	return __arch_xchg(&(v->counter), n, size);			\
 }									\
 static __always_inline							\
 c_t arch_atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,	\
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e52d..2f4726d3cfcc25 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -114,7 +114,7 @@
 					    _x_, sizeof(*(ptr)));	\
 })
 
-#define __xchg(ptr, new, size)						\
+#define __arch_xchg(ptr, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(new) __new = (new);					\
@@ -143,7 +143,7 @@
 #define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
 })
 
 #define xchg32(ptr, x)							\
-- 
2.34.1

