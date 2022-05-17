Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5904AC433EF
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:30 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 26F2124946;
	Tue, 17 May 2022 02:55:29 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id 5352E24919
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:27 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 oe17-20020a17090b395100b001df77d29587so984949pjb.2
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+xTvUZ/MZ/hBMOv0pU4miRbRa4E1wCeud/j7eErPbOM=;
 b=At1cMaJ1YI6mdPHBhH3EPPsHY6nby2Qx29Higj+fSkAGshMg27QehHqxn0Qw60C7WG
 rmyP9l5SX7+5F1EKSb6XFioQ46dBJFzb20vro+6u5Di0S6qxt4ID+ywnzkrDF4pLUWSU
 UQtHCGBdEY37uV+5XzXfWif/D0H+dbaUJr4k8uAxypOo2w4BwZzYOl9rs2goqvNolCr9
 HCUijfCdjwZs61FHuQ0RJLRCWmPqinCtzR/SCKWVYT7liaWWT4vhMET+ZZd5djczY38Q
 ByvA2k9qUemcnjyzOyghUseZVCwrNSPUsHDX3buS62/jkabqMnSinkoQIqrB/DczqS+D
 +cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+xTvUZ/MZ/hBMOv0pU4miRbRa4E1wCeud/j7eErPbOM=;
 b=ET471SpeZG+zAB1WJx66qRlKQmUArcPJtyzgzdF0cRHblxyonk0ULsrCSwCG0kAIUM
 1SNJLZMViZt8CcEamlqgqYLSB9d2dFsI5/bygXKhQLwgeFeVXft8vFEQjj4s8k+Yv07j
 VixKTJddHcmekqyBSM7BcGXwA2iUeJMTR0SDcyg1huiQbGbcad+anuMGgGJhxMkXxKTY
 1iTlkz3LLhDmVPwBQUhE1KAy/CXODSVj7TZBoz+nY8C1wn1DnPQbTNZGnkz6um+DzmMr
 vsDHVq1aMhfYq2DcRLQXu8W1mmCYyBMnpiLkJOKjXQ4o3AsMFbB6QyXmIJyU4G/JdTc6
 rfew==
X-Gm-Message-State: AOAM531u21ZZMlp7FTT0y+Y5NXltbordbeBRrl9nTdHAtqBDgw4qbzXJ
 Ec1ZxrhXMlahSLc9Srswxmo=
X-Google-Smtp-Source: ABdhPJyag62O3xF/5d9ATebbPs62aYvEzfoSK6yl9zsJiq2cgZwzvUpHoCEpuDyZIqK2SUIzuJ74aQ==
X-Received: by 2002:a17:902:7e01:b0:15e:caea:d6 with SMTP id
 b1-20020a1709027e0100b0015ecaea00d6mr19997264plm.33.1652748925641; 
 Mon, 16 May 2022 17:55:25 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a63fb42000000b003ed6b3dc52esm5486685pgj.55.2022.05.16.17.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:25 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/13]  OpenRISC misc cleanups for 5.19
Date: Tue, 17 May 2022 09:54:57 +0900
Message-Id: <20220517005510.3500105-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
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
Cc: Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This is a collection of misc cleanups I have accumulated when working on some
recent OpenRISC projects.

The patch themes:
 - Sparse warning cleanups
 - Removal of dead code
 - Emergency debug fixups in head.S
 - Support for gcc machine instruction flags
 - defconfig updates for litex

I have tested these patches when verifying the glibc port by running the glibc
test suite.

Changes since v1:
 - Fix if/elif issue in emergency print fixes pointed out by Samuel Holland

Stafford Horne (13):
  openrisc: Add gcc machine instruction flag configuration
  openrisc: Cleanup emergency print handling
  openrisc: Add support for liteuart emergency printing
  openrisc: Add syscall details to emergency syscall debugging
  openrisc: Pretty print show_registers memory dumps
  openrisc: Update litex defconfig to support glibc userland
  openrisc/traps: Declare file scope symbols as static
  openrisc/traps: Remove die_if_kernel function
  openrisc/traps: Declare unhandled_exception for asmlinkage
  openrisc/time: Fix symbol scope warnings
  openrisc/delay: Add include to fix symbol not declared warning
  openrisc/fault: Fix symbol scope warnings
  openrisc: Remove unused IMMU tlb workardound

 arch/openrisc/Kconfig                     |  53 ++++
 arch/openrisc/Makefile                    |  17 +
 arch/openrisc/configs/or1klitex_defconfig |  33 ++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++----------------
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++--
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   4 +-
 9 files changed, 255 insertions(+), 307 deletions(-)

-- 
2.31.1

