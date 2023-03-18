Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35198C61DA4;
	Sat, 18 Mar 2023 08:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCRIEo (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sat, 18 Mar 2023 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCRIEm (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sat, 18 Mar 2023 04:04:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A84711B
        for <linux-openrisc@vger.kernel.org>; Sat, 18 Mar 2023 01:04:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so6300230wmb.5
        for <linux-openrisc@vger.kernel.org>; Sat, 18 Mar 2023 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679126662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqj3eoizRLYpARgkZdhtFQjWuK9djeyoVu1xTCjA+0Q=;
        b=AWN0WDu8+PSd7em2ca5Qht6XPiP//s/112YbDDFs2DaEZhJcwRTi+XpK4h42C3+3Nh
         lw50z+J5BT2+6hB7tuL3o/FDXkVor9Ne8i/WWEs1+eRaj5j6jyOXk1TLamZuwIhUcue+
         2JXhvUbMXRiHWArKOKYRAx5n00BXwV3pzs7/4hhIkuwPDtoxMu5MLJruuYOHCNvySDxh
         X+i0bt++pNkAesoVBN+Ujqw67MBand4vmCdRulfXKNdLKX0moOEnYUEKHBXtjIlz6U1q
         eKHOMkgWOfl+SQ/LBVmTqUR6azl0bU+FCCjFVkSJb4/a3lbI+khFJql834X4z9w5GLgg
         H2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqj3eoizRLYpARgkZdhtFQjWuK9djeyoVu1xTCjA+0Q=;
        b=4oVi9MKexN00vkk71kC6/8aPWbsOgWHC3Uc54FSsLLf3tsdlXR5h9HnpMSIfTql4bz
         Fbxzrh8Rj/lizowMDDFRoaa2OfAbyXQQXoW8Kexa/J5NTYUbMN5ccS7o1i25RH7IubsN
         6SYqyAnVX8HExhG0Th4hy08cRGhOaWEfSLjr5PfNCofmpKkhR4M3xzjkBUwH3lGElgMO
         Cxcg0g6IZLHQsI7pgC1IlzgDsFo2G3DfHYghkoOm5YDLFmFfVHlDuAOC9MSCblXr6gRO
         VffdKLPDr4MYBYXr0jlBDZ0YgGO/8SFCkiCpWFkRppSVzaZqhUkcTLbYGUqK9fdOef5l
         IF2w==
X-Gm-Message-State: AO0yUKVS7nrePvh5K8kAJl+jkSeeMNsuS+j4BCpBErXW+O93y9hC9/eQ
        Ncvnlj3+N1q7a29gXNUdojiqOSB3azw=
X-Google-Smtp-Source: AK7set8YW4tU8t2e+XOTRC1iwl/J5fJFYIR8eprKgckpvgMuFdnTFNep7LN1uOq3fz5ft8lQhiAQLw==
X-Received: by 2002:a05:600c:4452:b0:3e1:374:8b66 with SMTP id v18-20020a05600c445200b003e103748b66mr26263510wmn.40.1679126662338;
        Sat, 18 Mar 2023 01:04:22 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003e2096da239sm10245677wmb.7.2023.03.18.01.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:04:21 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     GCC patches <gcc-patches@gcc.gnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Do not clear existing FPU exceptions before updating
Date:   Sat, 18 Mar 2023 17:04:05 +0900
Message-Id: <20230318080405.2799610-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

We should always carry the exceptions forward.  This bug was found when
working on testing glibc math tests, many tests were failing with
Overflow and Underflow flags not set.  This was traced to here.

libgcc/ChangeLog:

	* config/or1k/sfp-machine.h (FP_HANDLE_EXCEPTIONS): Remove
	statement clearing existing exceptions.
---
 libgcc/config/or1k/sfp-machine.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libgcc/config/or1k/sfp-machine.h b/libgcc/config/or1k/sfp-machine.h
index 162c6bc5326..c804270fb3c 100644
--- a/libgcc/config/or1k/sfp-machine.h
+++ b/libgcc/config/or1k/sfp-machine.h
@@ -73,7 +73,6 @@ do {								\
 do {								\
   if (__builtin_expect (_fex, 0))				\
     {								\
-      _fpcsr &= ~FP_EX_ALL;					\
       _fpcsr |= _fex;						\
       __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (_fpcsr));	\
     }								\
-- 
2.39.1

