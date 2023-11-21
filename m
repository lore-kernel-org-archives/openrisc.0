Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBDC61D85;
	Tue, 21 Nov 2023 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjKUOYy (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 21 Nov 2023 09:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjKUOYx (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 21 Nov 2023 09:24:53 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDBD72
        for <linux-openrisc@vger.kernel.org>; Tue, 21 Nov 2023 06:24:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso5307258b3a.2
        for <linux-openrisc@vger.kernel.org>; Tue, 21 Nov 2023 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576685; x=1701181485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQYwJQjKhySUG7SsmpVBnxUpf+Jrz1ajgA6palaWrFM=;
        b=REfrDuQxXQ+HzwB7FgCwmor5rAI71g2RCGGb46LBPw4XtSe8F78WA6gTNWd8Qh/0yh
         5dIM3+q89dTSMA5EKwHdA9LTELAIXr1bmNuKewoK7vNWoV7oPtTj90ZMVt4QJ0cg8BKs
         UrBha3hyPjeD+a6f3/p3n8HWV4lzc/c+Qk7LeJ97JMdC3nd0grAmX7cRgrWX6erZ+J7k
         pgyWoVdF0S47lNBGdTU5tnr5vhIUhj9JXAyS+W5CCmFeZIZEvQT+yecS7QVbo4PwLwtY
         qRoh7keGmiHRfLl1N55RnRoVTJiv31N2Rn/piXit5TvGZZIPAGpmY8Elq3Q2xJaMr2kR
         3WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576685; x=1701181485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQYwJQjKhySUG7SsmpVBnxUpf+Jrz1ajgA6palaWrFM=;
        b=WFWlJG3Bg1DoIrhdTp5TFNooNPZCjXH5JHWqIpM+HiAIUTWWwQ7qIGYSCGayVbNxR/
         KMa4iSn6rA5vwawi45taMLt5DGHGl61mYzqFakY8LZO8iXT2RpiSWp5voHHyWvyohThi
         fhJyet9BEGn5Y/Dj6jbiMUsxT1mJSMIsG/PIh4Ruor5M4rOHqfDL+la3KKJSRDpNAQDz
         iGi1fk5+zfG9ZOro1Cfgf4XTP/C9PggGDwAJWWIfg3wMVON5EFNsTCc+XmMuluyRUYnX
         OOTVxHuLudmES+Afl/r4SbbXJLThJ3ZwOFDyyQ61YnYiu+MFE/4p/Gnqhhzr0xkS185l
         rdmw==
X-Gm-Message-State: AOJu0YxyV7b1bUYldTREc+pARJfbLJE2dGAtbEQ0oBVlD21Ki1IO48dt
        RsQ2z5PLbGBEjDP6ubiKgn/ubg==
X-Google-Smtp-Source: AGHT+IEIjroP416LXBt6XlPHirqpf89r1vmzg9nVdVzS5F8PL+ZcqkvogWm5yXbuGxjX92apejfh4w==
X-Received: by 2002:a05:6a00:80a:b0:6cb:a18b:2182 with SMTP id m10-20020a056a00080a00b006cba18b2182mr8114491pfk.1.1700576685502;
        Tue, 21 Nov 2023 06:24:45 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:24:45 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     ubizjak@gmail.com, mark.rutland@arm.com, vgupta@kernel.org,
        bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, geert@linux-m68k.org,
        andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
        andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.org,
        mhiramat@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mattwu@163.com, linux@roeck-us.net,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v3 1/5] arch,locking/atomic: arc: arch_cmpxchg should check data size
Date:   Tue, 21 Nov 2023 22:23:43 +0800
Message-Id: <20231121142347.241356-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

arch_cmpxchg() should check data size rather than pointer size in case
CONFIG_ARC_HAS_LLSC is defined. So rename __cmpxchg to __cmpxchg_32 to
emphasize it's explicit support of 32bit data size with BUILD_BUG_ON()
added to avoid any possible misuses with unsupported data types.

In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.

v2 -> v3:
  - Patches regrouped and has the improvement for xtensa included
  - Comments refined to address why these changes are needed

v1 -> v2:
  - Try using native cmpxchg variants if avaialble, as Arnd advised

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/arc/include/asm/cmpxchg.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067de..bf46514f6f12 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -18,14 +18,16 @@
  * if (*ptr == @old)
  *      *ptr = @new
  */
-#define __cmpxchg(ptr, old, new)					\
+#define __cmpxchg_32(ptr, old, new)					\
 ({									\
 	__typeof__(*(ptr)) _prev;					\
 									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
+									\
 	__asm__ __volatile__(						\
-	"1:	llock  %0, [%1]	\n"					\
+	"1:	llock  %0, [%1]		\n"				\
 	"	brne   %0, %2, 2f	\n"				\
-	"	scond  %3, [%1]	\n"					\
+	"	scond  %3, [%1]		\n"				\
 	"	bnz     1b		\n"				\
 	"2:				\n"				\
 	: "=&r"(_prev)	/* Early clobber prevent reg reuse */		\
@@ -47,7 +49,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 4:								\
-		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
+		_prev_ = __cmpxchg_32(_p_, _o_, _n_);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -65,8 +67,6 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
-									\
 	/*								\
 	 * spin lock/unlock provide the needed smp_mb() before/after	\
 	 */								\
-- 
2.40.1

