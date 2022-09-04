Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39424ECAAD3
	for <openrisc@archiver.kernel.org>; Sun,  4 Sep 2022 07:26:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id EE89124B1A;
	Sun,  4 Sep 2022 09:26:12 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mail.librecores.org (Postfix) with ESMTPS id 7153E24AC9
 for <openrisc@lists.librecores.org>; Sun,  4 Sep 2022 09:26:11 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 c131-20020a1c3589000000b003a84b160addso5388493wma.2
 for <openrisc@lists.librecores.org>; Sun, 04 Sep 2022 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=YZ+8OE6OqyKCsYpTCKgvLyTHvwK6nGORs1oXgs9w+ZY=;
 b=H91pUz+KwHs03kKUg2fAcrTFXhtGv/Nt9vo7wlbbRmCz6z3q9AHhisAePuAOr4ybIf
 UbIWd42jJ5kOsipPUtkHJ8m66lj+tmUEM80Jnq7vccHuNO5yZs7rvIpn8gEpvC7P2vT3
 jgLSfgk95FVyvhIhlUy7lqEQkF6dIAAZTr0MzuEZ8g03zz2JNOd3fzhotMaNmAPd6ZKv
 1NvoqY1aT96i06nYWUTq12awoUYXdJgZOtWXyRs2KFgTDdIi/qnC4fg2//4BXzKz/1Jj
 m4jxINNEydrf4z9WcQcJlPibdy9n5WUtMrkTUZ9ODF58ZBbwoCVbnxgIQLnu6bRMPEMU
 MR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=YZ+8OE6OqyKCsYpTCKgvLyTHvwK6nGORs1oXgs9w+ZY=;
 b=1YYQb0/sU4YuYCD+ucQYYscvXLu3VxOZM57hy8voqI3oldL1SEweC43HB6iERIgJZa
 OOqTLVd57yawc9NQzsv35iTRFZ5ls/GMOlQl99saj57WDg5uOKXqf7cCo/1j5SVtJApn
 qGGIRFUq+cOwAwGebfqFck2ivU4LfO6Cz5bHJyya1sMrucYoTOxyFf5WWwIcbAmjXmx4
 Eb6t0UOGe84jNMJWoziihgrChoFQXI4dHrodcLkT9P4ERLEQdWne0DTXSHomlLcDE6wB
 cjKUb1M39xeLH06DpGhXrpPsBufT3SsxrFSe1ITE4EpsBqwamNOaZ5aYmCPaAIMiLh+Y
 dZjg==
X-Gm-Message-State: ACgBeo0FrbcxtYU+kt8ATUihkJT3dpIZvyh1KHNRnX7S4lCpVKGJyHI2
 0Lm5xOQL7cYYgeTjqJ9SfuA=
X-Google-Smtp-Source: AA6agR7zmfA2SzuJI+Rc1nTWKAkTQ4hK4qduGWpLCyYXsQWQhyttMtMIhQnyVKJxd4S3xffYkelATw==
X-Received: by 2002:a05:600c:2909:b0:3a6:2ef5:772e with SMTP id
 i9-20020a05600c290900b003a62ef5772emr7415892wmd.16.1662276370928; 
 Sun, 04 Sep 2022 00:26:10 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 bu3-20020a056000078300b0022863395912sm1833017wrb.53.2022.09.04.00.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Sep 2022 00:26:10 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] OpenRISC updates for 7.2.0
Date: Sun,  4 Sep 2022 08:25:56 +0100
Message-Id: <20220904072607.44275-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
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
Cc: openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The following changes since commit 61fd710b8da8aedcea9b4f197283dc38638e4b60:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2022-09-02 13:24:28 -0400)

are available in the Git repository at:

  git@github.com:stffrdhrn/qemu.git tags/pull-or1k-20220904

for you to fetch changes up to b14df228d7c4fe6e86e7f8a4998e9ccf4967b678:

  docs/system: openrisc: Add OpenRISC documentation (2022-09-04 07:02:57 +0100)

----------------------------------------------------------------
OpenRISC updates for 7.2.0

Updates to add the OpenRISC virt plaform to QEMU. Highlights
include:

- New virt plaform with, virtio and pci bus support
- OpenRISC support for MTTCG
- Goldfish RTC device endianness is configurable now

----------------------------------------------------------------
Jason A. Donenfeld (1):
      hw/openrisc: virt: pass random seed to fdt

Stafford Horne (10):
      hw/openrisc: Split re-usable boot time apis out to boot.c
      target/openrisc: Fix memory reading in debugger
      goldfish_rtc: Add big-endian property
      hw/openrisc: Add the OpenRISC virtual machine
      hw/openrisc: Add PCI bus support to virt
      hw/openrisc: Initialize timer time at startup
      target/openrisc: Add interrupted CPU to log
      target/openrisc: Enable MTTCG
      target/openrisc: Interrupt handling fixes
      docs/system: openrisc: Add OpenRISC documentation

 configs/devices/or1k-softmmu/default.mak |   1 +
 configs/targets/or1k-softmmu.mak         |   1 +
 docs/system/openrisc/cpu-features.rst    |  15 +
 docs/system/openrisc/emulation.rst       |  17 +
 docs/system/openrisc/or1k-sim.rst        |  43 +++
 docs/system/openrisc/virt.rst            |  50 +++
 docs/system/target-openrisc.rst          |  71 ++++
 docs/system/targets.rst                  |   1 +
 hw/m68k/virt.c                           |   1 +
 hw/openrisc/Kconfig                      |  12 +
 hw/openrisc/boot.c                       | 116 +++++++
 hw/openrisc/cputimer.c                   |  22 +-
 hw/openrisc/meson.build                  |   2 +
 hw/openrisc/openrisc_sim.c               | 106 +-----
 hw/openrisc/virt.c                       | 571 +++++++++++++++++++++++++++++++
 hw/rtc/goldfish_rtc.c                    |  37 +-
 include/hw/openrisc/boot.h               |  34 ++
 include/hw/rtc/goldfish_rtc.h            |   2 +
 target/openrisc/cpu.c                    |   1 -
 target/openrisc/cpu.h                    |   2 +
 target/openrisc/interrupt.c              |   4 +-
 target/openrisc/mmu.c                    |   8 +-
 target/openrisc/sys_helper.c             |  14 +-
 23 files changed, 1017 insertions(+), 114 deletions(-)
 create mode 100644 docs/system/openrisc/cpu-features.rst
 create mode 100644 docs/system/openrisc/emulation.rst
 create mode 100644 docs/system/openrisc/or1k-sim.rst
 create mode 100644 docs/system/openrisc/virt.rst
 create mode 100644 docs/system/target-openrisc.rst
 create mode 100644 hw/openrisc/boot.c
 create mode 100644 hw/openrisc/virt.c
 create mode 100644 include/hw/openrisc/boot.h

Jason A. Donenfeld (1):
  hw/openrisc: virt: pass random seed to fdt

Stafford Horne (10):
  hw/openrisc: Split re-usable boot time apis out to boot.c
  target/openrisc: Fix memory reading in debugger
  goldfish_rtc: Add big-endian property
  hw/openrisc: Add the OpenRISC virtual machine
  hw/openrisc: Add PCI bus support to virt
  hw/openrisc: Initialize timer time at startup
  target/openrisc: Add interrupted CPU to log
  target/openrisc: Enable MTTCG
  target/openrisc: Interrupt handling fixes
  docs/system: openrisc: Add OpenRISC documentation

 configs/devices/or1k-softmmu/default.mak |   1 +
 configs/targets/or1k-softmmu.mak         |   1 +
 docs/system/openrisc/cpu-features.rst    |  15 +
 docs/system/openrisc/emulation.rst       |  17 +
 docs/system/openrisc/or1k-sim.rst        |  43 ++
 docs/system/openrisc/virt.rst            |  50 ++
 docs/system/target-openrisc.rst          |  71 +++
 docs/system/targets.rst                  |   1 +
 hw/m68k/virt.c                           |   1 +
 hw/openrisc/Kconfig                      |  12 +
 hw/openrisc/boot.c                       | 116 +++++
 hw/openrisc/cputimer.c                   |  22 +-
 hw/openrisc/meson.build                  |   2 +
 hw/openrisc/openrisc_sim.c               | 106 +----
 hw/openrisc/virt.c                       | 571 +++++++++++++++++++++++
 hw/rtc/goldfish_rtc.c                    |  37 +-
 include/hw/openrisc/boot.h               |  34 ++
 include/hw/rtc/goldfish_rtc.h            |   2 +
 target/openrisc/cpu.c                    |   1 -
 target/openrisc/cpu.h                    |   2 +
 target/openrisc/interrupt.c              |   4 +-
 target/openrisc/mmu.c                    |   8 +-
 target/openrisc/sys_helper.c             |  14 +-
 23 files changed, 1017 insertions(+), 114 deletions(-)
 create mode 100644 docs/system/openrisc/cpu-features.rst
 create mode 100644 docs/system/openrisc/emulation.rst
 create mode 100644 docs/system/openrisc/or1k-sim.rst
 create mode 100644 docs/system/openrisc/virt.rst
 create mode 100644 docs/system/target-openrisc.rst
 create mode 100644 hw/openrisc/boot.c
 create mode 100644 hw/openrisc/virt.c
 create mode 100644 include/hw/openrisc/boot.h

-- 
2.37.2

