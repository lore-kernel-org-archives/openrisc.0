Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10850C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 23:01:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C1B2F24A4D;
	Sat, 30 Jul 2022 01:01:32 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mail.librecores.org (Postfix) with ESMTPS id CA84D249AF
 for <openrisc@lists.librecores.org>; Sat, 30 Jul 2022 01:01:31 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id bh13so5060624pgb.4
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ziY0fpWKKJV5IPV8QpzIzXUwcWcfgSw4zQhSrURIRBg=;
 b=T9pDKMr44uzp3sKdO1JTN3Qs66ViAJq7O1wg5njBtueTRHtIBMXEQWGZgbrIs3yH3x
 1oU6ydo9lS02LeXOocUcowv68k8olAbpSiUEy2cILtqMUVe2zpfAPGRCAjKg7Jwo2HM3
 DjSMp9DN/re5EFwL5/FBhugTl9wonKK8wKWDRt83mqHll2H+qcluxJ+U8z8p2K8iZwAi
 Yagod1jtOU56UiFa+YGMWr/BNDbcURt7Bp6Iiz9GjjfcbQdWSq3TKbMtzsxFbPoRTxzD
 ztdwDx3j9JdzyrH8v5xzdXhBV4tJZXS6mq10l9tNTQke/brvFlpVcQgeemaFuFk2GCwZ
 qnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ziY0fpWKKJV5IPV8QpzIzXUwcWcfgSw4zQhSrURIRBg=;
 b=v1qafoZ+Xgz/TUDqHFoAQ2L6CutA1MSL0lPzcy2pkc/tbfo0uoy7darUYJeMu5mcM/
 E1ggftfgD2EcZYvW6QP8QYqkhhlw+mFv1qY51ACVqfLUR+C7yAYpqNFgm4Q1ZcuSQnfO
 /cA7xCr+POFy998A3/h4vPcdM+9LcDRWP//Hy62IJqDWwBmfZw1/UWxSeVash5fq7nWQ
 YZfbd4zCJpT6MxJIGuUg0Watn2AWLoG6HgUWIzKfCAIYhpsegOT8eBXyJKk0HK0Fiqhe
 CrH/q9oXSkv2aJvq62TQKHr4la7NOUEuH5E9EUCvKpeNVdAp9g2C4lyQbwh3GoBWFLSx
 tgGw==
X-Gm-Message-State: AJIora82yxA8BRb+HCM3Eye7JESDvbQQ0jkYy8GsMKlK4d59VyXqbWau
 CDhpVwVJa71TRCsyoPTE9dA=
X-Google-Smtp-Source: AGRyM1v2DMDCu9kPz/f3hkJSd7Wm7+fE7BfusWQYweG5BEE3BDehboLj/nw8pH2mJSYBg6aJAHPlMA==
X-Received: by 2002:a63:901:0:b0:41b:6d0b:e8b4 with SMTP id
 1-20020a630901000000b0041b6d0be8b4mr4635061pgj.327.1659135690114; 
 Fri, 29 Jul 2022 16:01:30 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a170902cf1000b0016d23e941f2sm4109023plg.258.2022.07.29.16.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 16:01:29 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v3 00/11] OpenRISC Virtual Machine
Date: Sat, 30 Jul 2022 08:01:06 +0900
Message-Id: <20220729230117.3768312-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Hello,

This is the OpenRISC Virtual Machine plaform which we are now using for OpenRISC
CI such as the wireguard testing that Jason has been working on.  I also have
recently used it to test glibc 2.36 and it worked well. Previous glibc testsuite
runs on my FPGA board took about 3 days, running on qemu virt now takes 6 hours.

The first few patches help get OpenRISC QEMU ready for the virtual machine.
There is one bug fix for GDB debugging there too.

Next we have the Virt patch followed by a separate patch to add PCI support
which is split out because it's a bit easier to review that way I thought.  The
next few patches are fixes to get the Multicore platform stable, such as adding
MTTCG support and fixing some interrupt and timer related bugs.

The platform is relatively stable now, but every few boots we get about 10
second hangs.  However, overall this is much more stable than the SMP support we
had before.  So I want to submit this for review and maybe upstream it before
tracking down these last issues which might take significant more time.

This is being tested with the or1k-5.20-updates kernel branch here:

  https://github.com/stffrdhrn/linux/commits/or1k-5.20-updates

  This tree has support for: OpenRISC PCI and virt_defconfig and an irqchip bug
  fix.

Changes since v2:
 - Changed goldfish_rtc endian property to boolean
 - Moved or1k timer init from init to reset
 - Removed cpu_openrisc_timer_has_advanced lock optimization in MTTCG patch,
   measuring revealed it did not help much.
Changes since v1:
 - Dropped semihosting support
 - Added PCI support
 - Added OpenRISC documentation
 - Added OpenRISC support for MTTCG
 - Support Configurating Goldfish RTC endianness
 - Added a few bug fix patches

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
 docs/system/target-openrisc.rst          |  72 +++
 docs/system/targets.rst                  |   1 +
 hw/m68k/virt.c                           |   1 +
 hw/openrisc/Kconfig                      |  12 +
 hw/openrisc/boot.c                       | 117 +++++
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
 23 files changed, 1019 insertions(+), 114 deletions(-)
 create mode 100644 docs/system/openrisc/cpu-features.rst
 create mode 100644 docs/system/openrisc/emulation.rst
 create mode 100644 docs/system/openrisc/or1k-sim.rst
 create mode 100644 docs/system/openrisc/virt.rst
 create mode 100644 docs/system/target-openrisc.rst
 create mode 100644 hw/openrisc/boot.c
 create mode 100644 hw/openrisc/virt.c
 create mode 100644 include/hw/openrisc/boot.h

-- 
2.37.1

