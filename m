Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B1C433F5
	for <openrisc@archiver.kernel.org>; Fri, 27 May 2022 17:27:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E77A7247C2;
	Fri, 27 May 2022 19:27:42 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mail.librecores.org (Postfix) with ESMTPS id BEB97247C2
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 19:27:40 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id q4so4678540plr.11
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dKxraNqOZmC1Qjd1FJlCqqyBvierGHSKYTP+opFyWIE=;
 b=Yc87GM7+F/nYRNEVqsZA8OJ4YLOq9NqBGBEzFB8cquToTRhQp/2IwQTPAObKVNRBen
 xy5lEjmV4XzaVbrBtHAUg1XO3xLxRHIP5fZyb5/tSYhuf5/cTJXlcI1MI6R9VCQFm+kk
 nsQhgGVdrkN9gkbegRP7dE0xIgOCZtJV2VTr2SjWv/voxPI012arrt7boo/YVOG0zzpZ
 emX0aElByuwOH8GlpC4xCDC3+CCLuud5vAuMGLeLAyAVIpewPCxqbmx1hOKjAWUYLqPc
 lvWOl8dhzR1OENf86LFVcF5cJssKiY+u0ZIg6qKaLUdyCu4DijCrWFUF5eDSmJOa0HFq
 DHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dKxraNqOZmC1Qjd1FJlCqqyBvierGHSKYTP+opFyWIE=;
 b=n8jPpsW99PX70kybOgGTEZgzg0/+IqzpOQpuA5aBS2DBCu7oumPlvitFxjd/O+GEV3
 YKqLTcox/Y7OqL7WmaB7NQS2HPXhptQ2gJD/ov1vxp4ZyeSQ9FqzGM0NAefEDpqhlvf7
 1+l8FQrwMYdin23tf4PjZSIrsW2h6V19iVtDhHZxzKBgQoQutBKn5yHurdn1ht3Cmwi7
 HWJpuM2v4eYe/QLlb8AXqhSHXCSpZ21fNGprWQt4iemau1sv7IbaQbUtooWklA5fR8F5
 QN8dqi+meu9tdqOZwmO4BuOyjtP6wqSR2p//Ytiih3mXEYYC5VuOcGpKBSl8OtnRoBZN
 SX6w==
X-Gm-Message-State: AOAM532gR2gS4yadRP2OYEF/1+ovbVVUuHpouwYv3ySJ0sjRNtWN1t/A
 X4b+o+AzpmzIy3/elf5JvsA=
X-Google-Smtp-Source: ABdhPJzsjUwA4OHUFiopRUYj+HP+AsaLxQoaYY1U2mrRMfaxsXCSZG9SfCXxNB/Ho0pNZY00xLeG8g==
X-Received: by 2002:a17:903:244c:b0:162:4b19:a0e7 with SMTP id
 l12-20020a170903244c00b001624b19a0e7mr18380075pls.44.1653672459159; 
 Fri, 27 May 2022 10:27:39 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 u27-20020a63455b000000b003db0f2d135esm3599647pgk.49.2022.05.27.10.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 10:27:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [RFC PATCH 0/3] OpenRISC Semihosting and Virt
Date: Sat, 28 May 2022 02:27:27 +0900
Message-Id: <20220527172731.1742837-1-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hello,

I provide 2 options here 2 help with OpenRISC CI testing sush as the wireguard
testing that Jason has been working on.

The two are:

 1. Add semihosting to openrisc to handle l.nop based Halt and Reset
 2. Define a new virt platform, this includes widing in the sifive test device
    that provides a syscon interface to allow for shutdown and reboot.

We could upstream both of them or just one. I am leaning toward dropping the
semi-hosting work and just going ahead with virt.

The semi-hosting stuff was discussed here:

 - https://www.mail-archive.com/qemu-devel@nongnu.org/msg884560.html

Also, I started to propose architecture changes here:

 - https://github.com/openrisc/openrisc.github.io/pull/18

However, looking at how other platforms define semihosting it seems the openrisc
requirements are quite different.  We do not use the open/close/write etc
syscalls as riscv, arm etc do.

Stafford Horne (3):
  target/openrisc: Add basic support for semihosting
  hw/openrisc: Split re-usable boot time apis out to boot.c
  hw/openrisc: Add the OpenRISC virtual machine

 configs/devices/or1k-softmmu/default.mak |   3 +
 hw/openrisc/Kconfig                      |   9 +
 hw/openrisc/boot.c                       | 127 +++++++
 hw/openrisc/meson.build                  |   2 +
 hw/openrisc/openrisc_sim.c               | 106 +-----
 hw/openrisc/virt.c                       | 429 +++++++++++++++++++++++
 include/hw/openrisc/boot.h               |  34 ++
 qemu-options.hx                          |  16 +-
 target/openrisc/cpu.h                    |   2 +
 target/openrisc/helper.h                 |   1 +
 target/openrisc/meson.build              |   1 +
 target/openrisc/openrisc-semi.c          |  54 +++
 target/openrisc/sys_helper.c             |   5 +
 target/openrisc/translate.c              |   6 +
 14 files changed, 690 insertions(+), 105 deletions(-)
 create mode 100644 hw/openrisc/boot.c
 create mode 100644 hw/openrisc/virt.c
 create mode 100644 include/hw/openrisc/boot.h
 create mode 100644 target/openrisc/openrisc-semi.c

-- 
2.31.1

