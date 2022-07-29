Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF44C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:06:34 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9F81024A7A;
	Sat, 30 Jul 2022 01:06:33 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mail.librecores.org (Postfix) with ESMTPS id E49EE24A5A
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:06:31 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 a7-20020a17090a008700b001f325db8b90so5146276pja.0
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=675f6o+9+HX/m5+vXfpzLjKZNc+MOKTIadu1Dz7TZmg=;
 b=TyLtWTaJ9zqkX1/mIZPoCZsQMfs696KhW4LJNYCHPJ09q8XfQdjpM7Ld/pTlFT2x+G
 LrTqSkLDVp1nVgLAFxns2DiTmm6NdJjaYC94J7TnkE4pSfmy/QZILuKwX4R63qm5JBMp
 IjVT0pGfYTzvoyQy7sZBHH6KYC1qQeCJI3VR8DpKv/YJpwCdd+CwuNDbWFAdG3tcbHyl
 8J2bibrbv78EDDOlpQwPoOAYDnRShCtcESVAOIeq41oh/0gC32sVtX4tkFjUhLdvRr9+
 pVyrcZgdOJWhGWmIFz3TGds08w9zmF9HNEfJcedeOKqFwJaG9OjIF7t/eNLc29Sq/lPw
 Yq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=675f6o+9+HX/m5+vXfpzLjKZNc+MOKTIadu1Dz7TZmg=;
 b=OQQf5zju0KZTa8WRKoFKYoYMwQ1C0ibTy0tAXMaykDAiau5h9GNcz75ZrV7cQ8nbSV
 HUw0KOc71Z+tUUarZfRUEDjvN12UkkAQRJv26xNuolGsABQkov5nPZMBI6bYRtUv2XZp
 V1iq2uzrB7Cg6YqD2krNMQit50x26ugKvm+nf2KobaUXFjAWtm9rIJChDQqyXKZKosKM
 Qr1bPbiBD/mCo2rNj/nmCOCvXSI0Am5ZXzHv3PM5QpL433D5mKvemVZ2Nxge2ozdG+zJ
 mQqrETuYAk7ZxUrI3lqVEOAEkRAZAJKZnCBPlW+TnONfxRz45yRh5VyCj9wFKpbNZ075
 qJ5w==
X-Gm-Message-State: ACgBeo0fwUl5xNnYTLjlX6N+83awp6argPghNmjHMGkVjdmkoM1GzhDj
 oyDlAPNycBQ9SnIgJ1Di/JA=
X-Google-Smtp-Source: AA6agR7Sf7jMkQWJC8pRFddCK1n3AQAfX33tUM7mEG1UwFLydd9mx9OM0xpxFKGRfnSN3Z7zQJEDzQ==
X-Received: by 2002:a17:902:c713:b0:16e:cbe3:29da with SMTP id
 p19-20020a170902c71300b0016ecbe329damr843978plp.61.1659135990367; 
 Fri, 29 Jul 2022 16:06:30 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 nl8-20020a17090b384800b001f3e643ebbfsm960410pjb.0.2022.07.29.16.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:06:30 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 07/11] target/openrisc: Add interrupted CPU to log
Date: Sat, 30 Jul 2022 08:01:13 +0900
Message-Id: <20220729230117.3768312-8-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729230117.3768312-1-shorne@gmail.com>
References: <20220729230117.3768312-1-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

When we are tracing it's helpful to know which CPU's are getting
interrupted, add that detail to the log line.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - Added Reviewed-by

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
2.37.1

