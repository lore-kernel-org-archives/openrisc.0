Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D24C6FA82
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:21 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C98DD24B41;
	Sun,  4 Sep 2022 09:26:20 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mail.librecores.org (Postfix) with ESMTPS id 5221F24B3F
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:19 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 az24-20020a05600c601800b003a842e4983cso4067000wmb.0
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=JzE3BnwXRopw8l+GYkEmSmqp7UW2cE9nuMRHARwLvoE=;
 b=l5wOQriXCYObMfQ50ZyW2BPzkUa1iomPA4cRZLrkeyqwLYVGT5GSNHo9IbFWF7Usa/
 7DpWtnUhKf85f+lsYg/tLX0i9D2UZuLMbIJo+HoDGZDxgNhq+j5ATYm9UcHTJWrYKSTM
 2c4ncwlCQ+xKQVqHrERYsF2QUZAyFckFxWFCVqYhtWlwUAUSDGDjVfZijPG0hcXJnAqW
 7APXOwp5FOgXIagsdF3/SvMrqYCagj10DiaXQpke+fX5niMibmB/aiYAPBmLV33dgWrK
 plGyOtp+nJOgIY01l8G8mtAXpU53tn/qsvbgULOmc/nF5dIXfyHsIvbdVVLVX2QKdBqZ
 w+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=JzE3BnwXRopw8l+GYkEmSmqp7UW2cE9nuMRHARwLvoE=;
 b=dOm8QLyXvBqQZysFVGLx/FaMX3sLpWd/eAUd0xp5Nlr3eLvr47kRbBsgk3Qn465hPx
 7ygyGXI0fMTlM6fHV1IBlXCRUJKc5rdhmLPR0/Bw4meyMh3b9CPvZG44GT96DDGTKLWD
 i/vnvuqeKFFOmaFnnClT5id8AeKXVWIVRsTodvkxHAJjrXUbXlcasTFaHgpMpF8FMLk+
 ey7KFw3TVhtA1DOYbc4hBedFh0cZx9aobejetN+iuoiaJt5fw7kKdNLlxlakPZdUtcSX
 JzmNLeJdKhEfkCkCeQPGKrdz8RTIoRf+BtHNipcIoDzzJ8CAo1+9jvHcYYWx0VpS7aC1
 AiLg==
X-Gm-Message-State: ACgBeo0BXDZcdFowzs5NBTObNcLPv1aM60oIFsaa0S6G+M0vMwMNy7AS
 bCS7gVZqVTgIqSEU/JLeYEw=
X-Google-Smtp-Source: AA6agR7MOIEITAors4wvQjJ2Wr5SvZ4HMNRvAS0uUoJq83zvOAxiChumpWFURrNpjhRyProCkmc4Ow==
X-Received: by 2002:a7b:ce91:0:b0:3a7:b67c:888f with SMTP id
 q17-20020a7bce91000000b003a7b67c888fmr7722962wmj.187.1662276379052; 
 Sun, 04 Sep 2022 00:26:19 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 u21-20020a7bc055000000b003a3442f1229sm12924571wmc.29.2022.09.04.00.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:18 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] target/openrisc: Add interrupted CPU to log
Date: Sun,  4 Sep 2022 08:26:03 +0100
Message-Id: <20220904072607.44275-8-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904072607.44275-1-shorne@gmail.com>
References: <20220904072607.44275-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: openrisc@lists.librecores.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

When we are tracing it's helpful to know which CPU's are getting
interrupted, add that detail to the log line.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index e5724f5371..c31c6f12c4 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -83,7 +83,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
             [EXCP_TRAP]     = "TRAP",
         };
 
-        qemu_log_mask(CPU_LOG_INT, "INT: %s\n", int_name[exception]);
+        qemu_log_mask(CPU_LOG_INT, "CPU: %d INT: %s\n",
+                      cs->cpu_index,
+                      int_name[exception]);
 
         hwaddr vect_pc = exception << 8;
         if (env->cpucfgr & CPUCFGR_EVBARP) {
-- 
2.37.2

