Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE0C4167B
	for <openrisc@archiver.kernel.org>; Fri, 23 Dec 2022 07:17:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3C7622406B;
	Fri, 23 Dec 2022 08:17:42 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by mail.librecores.org (Postfix) with ESMTPS id 2C48925BA0
 for <openrisc@lists.librecores.org>; Thu, 22 Dec 2022 12:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709735; x=1703245735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WISTUsk2o+/CiLC/dmDma5HABMnb/JSTbRj0TToQGYg=;
 b=kgTVyKLosX5w2SEpVOf5K09FyF80kFw8mw2TpzF1692kcuatOma9kRNc
 goz14tFlM8c/j4t2Riu8Pa/WiTbIP+PD76Pofz9gnu5TzoPIh34SPQ0MX
 FOpRbC/kgLS10eSelWuPdNznyhZnkvr/boFvico00bCzswjdlMlCKjwnR
 fwf+Z9V156XQxwPaHLkQP5RjYEwl3sAbJoktRye8EN0WR7v4P7SsnHtUe
 qpaCOq9K4zH8wRPcloRMoDJdNKLrp0EmnRF9moOX22VVx9mip5GvcFi1P
 V1kWb760FMy4FnBVFwCnFb/qvm5QPHSKzJEAglYPUc08BHz4KZbrG3h0b Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804861"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; d="scan'208";a="318804861"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2022 03:48:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504874"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; d="scan'208";a="629504874"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2022 03:48:48 -0800
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
Subject: [PATCH 15/19] arch/sh: rename internal name __xchg to __arch_xchg
Date: Thu, 22 Dec 2022 12:46:31 +0100
Message-Id: <20221222114635.1251934-16-andrzej.hajda@intel.com>
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
 arch/sh/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 0ed9b3f4a57796..288f6f38d98fb4 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -22,7 +22,7 @@
 
 extern void __xchg_called_with_bad_pointer(void);
 
-#define __xchg(ptr, x, size)				\
+#define __arch_xchg(ptr, x, size)				\
 ({							\
 	unsigned long __xchg__res;			\
 	volatile void *__xchg_ptr = (ptr);		\
@@ -46,7 +46,7 @@ extern void __xchg_called_with_bad_pointer(void);
 })
 
 #define arch_xchg(ptr,x)	\
-	((__typeof__(*(ptr)))__xchg((ptr),(unsigned long)(x), sizeof(*(ptr))))
+	((__typeof__(*(ptr)))__arch_xchg((ptr),(unsigned long)(x), sizeof(*(ptr))))
 
 /* This function doesn't exist, so you'll get a linker error
  * if something tries to do an invalid cmpxchg(). */
-- 
2.34.1

