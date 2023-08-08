Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D65C001DB;
	Tue,  8 Aug 2023 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjHHSjg (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 8 Aug 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjHHSjL (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 8 Aug 2023 14:39:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014B1E5A2
        for <linux-openrisc@vger.kernel.org>; Tue,  8 Aug 2023 10:23:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9a828c920so91273841fa.1
        for <linux-openrisc@vger.kernel.org>; Tue, 08 Aug 2023 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515421; x=1692120221;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uTsNkzMlGNumI6E4N2sbj8WhFeiKobXXpi0Tum0hp4=;
        b=N/PE9aHoDr5vc0/3dCrEi9eYqYH7zF1ewu1IutWqKJQKWvxNCYBHnmyhgWjdSw9+q7
         cmxZP5hOoDLn7eIv86pBKXyiBC3aux7kCudyB51lkixFV4KdWaj7oupXUIWAhjrb7wOo
         2fTQ3MoKmxctn4AZ90RzFcTwQT19zlh72J0bIz6PloHpM2HCo/E95HjyeEymIwdnuj3v
         i4BfwWJerVKigHDKYp4RSZhMungW03JDKh/IFC7Cj20tye06jHijMShEAo/tEiVc3wMF
         db+yKLoKGRVQXyq1aI7/Gly6NbSippxojCptCnu/Z6zw/XrR6s9uf6QypjgcDdFArd1U
         i4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515421; x=1692120221;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uTsNkzMlGNumI6E4N2sbj8WhFeiKobXXpi0Tum0hp4=;
        b=l41VNpP76aMya3xt7xmQvU1LfQ7Vhzhc1JisEAwRIcDGnCRvnEpe2bkFulrxUC0AG0
         /AYMuDa7XAzlwTkMBPr2TTChel9EjlFJp/etilYDx+AgDcy+3LIYA9qFfo6LsZjjpnXW
         j41Uwu2jj13rbyH8Snvm+qKmdhCtwtzmE/TXn9Va1UNmyG8CtqXLTdSqueTc4Vt39Rar
         X3Ar//lAdY34lOvPGWJ/iZgd35XPGBhdIwa3c+gtnZdq6zy4RAgmaxSqXWvGvcE/qokT
         Im86i7wTdgkqXQTwEXxwmWqGa10ukB//s2sBsvuGz3x1NkEYuaTxAMKThTuDdbGEes3V
         Jeig==
X-Gm-Message-State: AOJu0YygC4Xf/pDrMVchGYSsSY7x3y/59XDLkf4T8ulJ70EUHZnF2Baq
        /m6KKBLeL6JVNhyj86ku+xlX75F1RG1LWd8JCZE=
X-Google-Smtp-Source: AGHT+IES5amA4SDlpCkbvTEDM6S0+rLZht3qutP1HCZ45dXQD1IYG/yvCBi5SrhtOxK+41I3d98chg==
X-Received: by 2002:a2e:805a:0:b0:2b9:ee3e:240b with SMTP id p26-20020a2e805a000000b002b9ee3e240bmr9312875ljg.41.1691487151244;
        Tue, 08 Aug 2023 02:32:31 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b22-20020a2e9896000000b002b9f0b25ff6sm2196530ljj.4.2023.08.08.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:32:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 11:32:30 +0200
Subject: [PATCH] openrisc: Make pfn accessors statics inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-virt-to-phys-openrisc-v1-1-b2c16cf000a8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK0L0mQC/x3MMQqAMAxA0atIZgO1RSheRRykppqlLYmIIr27x
 fEN/7+gJEwKU/eC0MXKOTUMfQfhWNNOyFszWGOd8cbjxXLimbEcj2IulIQ1oI/RjME6t1KE1ha
 hyPf/nZdaPyHMl5RnAAAA
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry, do the same with pfn_to_virt().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/openrisc/include/asm/page.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 52b0d7e76446..bb044c4aa93b 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -72,8 +72,15 @@ typedef struct page *pgtable_t;
 #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
 #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void * pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn) << PAGE_SHIFT;
+}
 
 #define virt_to_page(addr) \
 	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-virt-to-phys-openrisc-8ff05c233aef

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

