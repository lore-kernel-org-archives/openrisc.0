Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA0C77B7F;
	Thu, 11 May 2023 15:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbjEKPKI (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 11 May 2023 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbjEKPKH (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 11 May 2023 11:10:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B371FD3
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-306f2b42a86so5789185f8f.3
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817804; x=1686409804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4EMMFFjBP4WjNJpcZVHV7+t+mLFPsuxrgpTIf95HUi8=;
        b=ekmzRrBhdYFdBVRnL3IYuLbPkVe+oaKTP7r6ydvN072SazyLg3VqTAAiEY/mCJsq8e
         6zRxpq6b2SIleCLKqVyokQyYR14WfO1FXxChpB+K+3X6h1d2YiqHeAr9qPmQx/mrsPAc
         joukW+1d1Wf4xHY5R4Tk7sqiEkH93OZXe8uFlhwo6Chhs77DYAuG0wCHDYihvej9fXjo
         jlL/4Frxa2QP7jnPok2Wvcgk4KsuoHz+VLr9SoqamTX6kNIfGa1sXvUX3XcDRag/iTEc
         pGu1zcOMt1DTlzdsyOeUvKHvUFVQ4dc/sC0ztRpisywF8Axq+kvIFScgSfKeTkd9PIPc
         EbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817804; x=1686409804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EMMFFjBP4WjNJpcZVHV7+t+mLFPsuxrgpTIf95HUi8=;
        b=RuzDRxkrxd9PGpTKjwLLnS7ypuEPjl1FvSnMqC1qftANO39OedY+kraUT0Xc33l27S
         ZaaQHlH6b+5ablKoEq2R4Su2+fIPOEsrn2cKpm1BXaPhx0sfB+l32KikyZj0bUlbl+or
         nbEVEu8MJMdDMnPWxDjKl/s3QqGu4M+7LJs1iwD1Pgr1Gmnz4WbU44j4u775C+8/iMRy
         zNgUB/d07qbK047TEQBQHp4h+suPv08plVzW0JyRwr7Mk8bbh3YHltZWW6eGslrOkvSg
         7RZKWwyidnN7WgQlCi6rNZ+9cAMAp6KjUlnXnH965DxLCGI4BB2ldAJ7sza2nFqo1LR5
         RVrw==
X-Gm-Message-State: AC+VfDwi/5qNL0aasuA7TGyGB6PS+zRiA8SRnNUpVJY4qyt0ArZYU6Eo
        8aW/IiAK0FpLa4GR4PU7fUo=
X-Google-Smtp-Source: ACHHUZ637Cm0xG1mf+vZW+8aCeQA/XIwLe6U0Fl+tT5HWR9SETswiUXUVgVD00m8BiYcIAaqVZ/ndA==
X-Received: by 2002:a5d:5308:0:b0:306:3a47:cd78 with SMTP id e8-20020a5d5308000000b003063a47cd78mr14767817wrv.71.1683817803997;
        Thu, 11 May 2023 08:10:03 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id r9-20020adfe689000000b002f6dafef040sm20721330wrm.12.2023.05.11.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:10:03 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/3] OpenRISC updates for user space FPU
Date:   Thu, 11 May 2023 16:09:56 +0100
Message-Id: <20230511151000.381911-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Hello,

Since v2:
 - Add reviewed-by's from Richard
 - Pull cpu definition out of ifdef in helper_mfspr
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
 target/openrisc/sys_helper.c | 45 ++++++++++++++++------
 target/openrisc/translate.c  | 72 ++++++++++++++++--------------------
 4 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.39.1

