Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C93FC77B73;
	Tue,  2 May 2023 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEBS5u (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 2 May 2023 14:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBS5u (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 2 May 2023 14:57:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E946DC
        for <linux-openrisc@vger.kernel.org>; Tue,  2 May 2023 11:57:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f19ab994ccso43565685e9.2
        for <linux-openrisc@vger.kernel.org>; Tue, 02 May 2023 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053866; x=1685645866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vndw2eMh0yfeEeXEe2QijYmw64Ibmm18Jr5KHQSTkwg=;
        b=H9JVvHpr+Gi2tcJxdtd8JJHc9P8Y+17r53kYZugJOTq+EKNUxyseK/+8IGwzFpHr66
         d22LpCsiGMSN8AIpfbxyqxoIlmbe+sepAlSgwsxPillKpVLA8EGC5dAHw3IMXFxwxejR
         TlyklhHEbYcGSdqzI2iAunPcEO+SVg5CuK3t64BcDDM+vT0A1YH+7vclzgScXmdxms7a
         Thd7bBATAznUBvPH37I0Dm0vijtnBshcBOf4L9uruSP9EJcX7VzAlG4GidORmNLRjd/W
         6O7yyIhFs1gwYpjIsym1LLaaYSrasypIDV+E3nt8ArbR4ITjGl0GGvzdGdI0iot2E9ID
         oKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053866; x=1685645866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vndw2eMh0yfeEeXEe2QijYmw64Ibmm18Jr5KHQSTkwg=;
        b=O9SFQ1iMUUYFYIZAnigPteHN0zwI3ETtL4Dht7T8d3vKcyimq5oBIk71RChVivH6Xb
         3WNCjQSdZl6npJJWAkKSgoINUCNu/yye4tCw+EiicPYmbcHa3QluoVwE9O2a+Kvjr5bl
         TtWswlPdwrVUL/tCx91ojpXkR3zPg0TKE/TzdcoNuZBeQ5pkzBCN84oYSP2WmwOS1+jI
         AJdogkkJWDe7CJu2tEUsO2pwR3czFZo8f/RfXtSybnxOd2a3QQxZaa0IbejjFfmv7G+j
         cc9m05eNVRJ7EHNJk17YiL5trvVOURjdDSMQGeHD550hoNV2RsYQYqzzNLCKfQ/xsjxO
         FHAg==
X-Gm-Message-State: AC+VfDwSghV4HwJKJyVrtWa5xb2qgQoM9lgoZ44/TjaT4D+p28Szw3Nr
        DzoRd8mWRr8NldPbJr8fAX5EL/xCs64=
X-Google-Smtp-Source: ACHHUZ4bFRE/maZDnUvlfnh/XXES59TIPwoq77XHt5oMAJNW12K8SOgtfm+cHErCYc9Kyxz0jyhBKw==
X-Received: by 2002:a05:600c:2046:b0:3f1:9503:4db0 with SMTP id p6-20020a05600c204600b003f195034db0mr13098687wmg.13.1683053865722;
        Tue, 02 May 2023 11:57:45 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b0030633152664sm4002354wrt.87.2023.05.02.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:57:44 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/3] OpenRISC updates for user space FPU
Date:   Tue,  2 May 2023 19:57:28 +0100
Message-Id: <20230502185731.3543420-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

This series adds support for the FPU related architecture changes defined in
architecture spec revision v1.4.

 - https://openrisc.io/revisions/r1.4

In summary the architecture changes are:

 - Change FPCSR SPR permissions to allow for reading and writing from user
   space.
 - Clarify that FPU underflow detection is done by detecting tininess before
   rounding.

Previous to this series FPCSR reads and writes from user-mode in QEMU would
throw an illegal argument exception.  The proper behavior should have been to
treat these operations as no-ops as the cpu implementations do.  As mentioned
series changes FPCSR read/write to follow the spec.

The series has been tested with the FPU support added in glibc test suite and
all math tests are passing.

Stafford Horne (3):
  target/openrisc: Allow fpcsr access in user mode
  target/openrisc: Set PC to cpu state on FPU exception
  target/openrisc: Setup FPU for detecting tininess before rounding

 target/openrisc/cpu.c        |  5 +++
 target/openrisc/fpu_helper.c |  4 ++
 target/openrisc/sys_helper.c | 45 +++++++++++++++++-----
 target/openrisc/translate.c  | 72 ++++++++++++++++--------------------
 4 files changed, 76 insertions(+), 50 deletions(-)

-- 
2.39.1

