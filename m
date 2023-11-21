Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4953DC61D96;
	Tue, 21 Nov 2023 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjKUPEl (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 21 Nov 2023 10:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjKUOZr (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB34510DC
        for <linux-openrisc@vger.kernel.org>; Tue, 21 Nov 2023 06:25:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso4864149b3a.2
        for <linux-openrisc@vger.kernel.org>; Tue, 21 Nov 2023 06:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576718; x=1701181518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeriZn2HB3faAf90rsoEJC630QNkZ7QDKTlPQoSO5Cg=;
        b=XW+v8Rqdj+W5RDTFT73muFM1vxV9PU11P9yOjIYCFxt+FwPJzicvFYIxmHAJVCif3t
         NGKsMcTx7m5sjP33I8osRZhwxpRyc6lxktDfsjH/5PynaGz5mWaUtRYpPRDf66MSjKgc
         qF+iSpqX24h0tVxbUURYKpYHmclFNJQvS0/KLtK532uTvCMIfAzm7MmcfNp+s509jDEL
         dmYelKtKuMD7V7kLbWdno/MQU5xN4RadKdO8zzqFlZTtnSRU/nj01G8fMF16Zwehg7gf
         RUpWhCb4A+rRZ9ixMPGakEK1JGrRrBuhti/oZz+farpVI/NgKBqxnJoopwCRBDr3ASpI
         qV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576718; x=1701181518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeriZn2HB3faAf90rsoEJC630QNkZ7QDKTlPQoSO5Cg=;
        b=QY40ZZJ39ziAtoS8Aajx3SM+9YbgK2NFLe/dugXnhzWBkOup968qlIpWNSfHMgymjN
         6yFqPou7LP1x1JCAH1KuflPlvVQl0dlRiS4TLPFq3goJ84PBcLJK00iDdp36klaYa5wF
         oL03DPzFZO1YaPlFXlG6liVm6bzN1cTcDoQVZazN8Ff85EUcdxvex8IW8WS5hl9yv723
         KWZqNJJe7L8tI7xezPqNu0v7ezb9mL6TVQ5nOda855gs+4u17OXCiTZsh0w46HCkGHhq
         M2Mx6oEdG1oRZ/1q8PxAanx+T+yOjoR48yAK29tjKQ9ktbq4OBQ/UqfMMbY6EzfmloWK
         ud0A==
X-Gm-Message-State: AOJu0YxmDkxvziVeqbFxgeIaxM7RCvo0bL8jUdcuZYTr8g5ZrgiDjEfT
        xu0GGJwUiM3Gsi/Gf7Q5sFv0+g==
X-Google-Smtp-Source: AGHT+IE9vXr4RgqaSgCijzdvIxGnYYLFWxRa46XZgScWeMammtbE3X5UDSfvdft/8HJ3WbLcZEd/qg==
X-Received: by 2002:a05:6a00:9a1:b0:6cb:8c70:4790 with SMTP id u33-20020a056a0009a100b006cb8c704790mr6739253pfg.1.1700576718381;
        Tue, 21 Nov 2023 06:25:18 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:25:18 -0800 (PST)
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
Subject: [PATCH v3 5/5] arch,locking/atomic: xtensa: define arch_cmpxchg_local as __cmpxchg_local
Date:   Tue, 21 Nov 2023 22:23:47 +0800
Message-Id: <20231121142347.241356-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

The xtensa architecture already has __cmpxchg_local defined but not used.
The purpose of __cmpxchg_local() is solely for arch_cmpxchg_local(), just
as the definition of arch_cmpxchg_local() for other architectures like x86,
arm and powerpc.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/xtensa/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 675a11ea8de7..956c9925df1c 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -108,7 +108,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * them available.
  */
 #define arch_cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),        \
 			(unsigned long)(n), sizeof(*(ptr))))
 #define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n))
-- 
2.40.1

