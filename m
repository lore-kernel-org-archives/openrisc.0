Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F6C7EE22;
	Wed, 10 May 2023 15:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjEJPcg (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjEJPcf (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 11:32:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BB30DA
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso30744935e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732752; x=1686324752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mT8b3wI1jOAZ42ahPsG1g/N0fgPfBNbODwJvXFdJVsI=;
        b=sadZ0WKFIdP5qPernAUs+u4AbU37o7RUhZDRQ7lazCBzLAj+nFzJW/ecpslhDzAzIp
         efukamcHGAb8C2oEQXkYsUqk3tTL7suGho6TEi4yJlxoqtZcWs018iel0+0/xpgBQ+eQ
         rNPOs6rNt/08NaHLETViQckonwx2FgXsHqdzKt3K/kU/+5cPCVe/8BnGcTUlTVXQr3A7
         h/M1ridl00skD7o3DekdT8zipvjwcp1l7hDFs7TBEM2r2PgX3N9C7hWBVYEOVNOU6sTb
         d+2gWtjQvrBgDDzMyVBz9RGTNc3ARZd3UKtIGEkJfL96fnh0wzoX48w/LCjbYlhWltIM
         NLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732752; x=1686324752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mT8b3wI1jOAZ42ahPsG1g/N0fgPfBNbODwJvXFdJVsI=;
        b=Wk5VhkcJpOJix6rM7EIeOyCzHHM8Dz/r2VwRhPDdrA3GQo/7WSOf6mrR01/ASq9uSr
         HvjDVUodth4Q63U2cRTRu+2n21IBDSzx98MDRt3cb7t6lsRBS+jnC4ZD30X+q3Tp/mgP
         cfsQsYICmFyXHBWfhO3vOUf5xpJoZybPQBo/svzxBxZM3WyR/g1UG2RyWMUpKTGuHKol
         pNzXXOD/1vRhOE0U9n8T+8tZzFAIDvVfZz9SsYuBHsYam2xfjzVTTwo/bwyHqLFafSL2
         GfxW+4Nd8r5d5aqblAaNHQ0c8VQtUpdjwTEEdqSQNh8b7LIgxeiXI7x4VA23YfMG2zVe
         Vr3A==
X-Gm-Message-State: AC+VfDyHCDUZqMlkeDXfMsPBH++z01awnFKpTuQV4+oCY+3tKDOMdWiV
        C4x2f+4Ty+HP7qDc1ZyG0kg=
X-Google-Smtp-Source: ACHHUZ4gEex/3qjAqFij+6fraDFKcmCxIv/usHWf97ewgWqsqfPIkJyjDgfv04rDB9tNCNcllzni4g==
X-Received: by 2002:a7b:c419:0:b0:3f4:a09f:1877 with SMTP id k25-20020a7bc419000000b003f4a09f1877mr1716451wmi.23.1683732752052;
        Wed, 10 May 2023 08:32:32 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id j18-20020adfff92000000b00307bc4e39e5sm1621411wrr.117.2023.05.10.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:32:31 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/3] OpenRISC updates for user space FPU
Date:   Wed, 10 May 2023 16:32:25 +0100
Message-Id: <20230510153228.264954-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Since v1:
 - Fixups suggested by Richard Henderson

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

 target/openrisc/cpu.c        |  4 ++
 target/openrisc/fpu_helper.c | 13 ++++++-
 target/openrisc/sys_helper.c | 45 +++++++++++++++++-----
 target/openrisc/translate.c  | 72 ++++++++++++++++--------------------
 4 files changed, 82 insertions(+), 52 deletions(-)

-- 
2.39.1

