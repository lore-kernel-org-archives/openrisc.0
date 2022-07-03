Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D507C43334
	for <openrisc@archiver.kernel.org>; Sun,  3 Jul 2022 21:28:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0F7EA240F3;
	Sun,  3 Jul 2022 23:28:48 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mail.librecores.org (Postfix) with ESMTPS id 4B91D2406B
 for <openrisc@lists.librecores.org>; Sun,  3 Jul 2022 23:28:47 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 n16-20020a17090ade9000b001ed15b37424so7734120pjv.3
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BnOvjZiW9u4sx8x+Ss3mNCv4J9tIowByCWqNKuz5lKQ=;
 b=WgAJPuRMgibvmQi0sUlccPkrX/iiPAHnaOLe8SStio1pl1zdIRly0EBkW75+CWeaYK
 3zR8YwLlRfxV3U1cfZBQI3QzWjTjKHCaEV0N+FMPkMNvPvY0Nu5fbNUxcKWEB3A1zaRT
 m2RxvbKbZN9DfpaBowUpWhgJ5NU2oO6xez6pt/gd+YSQ/WOhoHpLnIkdUxOkkQqK0/db
 NgIQjqSKL3QbiZ+UKUeF7WhiJC8vgomh7RYVsgGEBU4co6pryt4/t6bhKYbksm1S9vNi
 5pVQDOewLDcdPRhaputi16eID2fxux99yL+XdR4vYgdRKhvBiqzMZF38cysef6WqUfgI
 vS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BnOvjZiW9u4sx8x+Ss3mNCv4J9tIowByCWqNKuz5lKQ=;
 b=mkaNz1TvoMyNKCynbj0QJ6ILzl9FZ0A0TdYmC1urA6yiDJLzkL1WVTvx9TkkE0qvdu
 O88YSQeHqHkZjR19+PxtpdytOdcDrUuqSB3k3b4yFCjFLAJcqEm6u9dLwHelpLFH/159
 txP0tNz2nmEXIV9tswCQsy0miWWJykRIMngfQRPsrkzOJ2co4YvR4p1KwwspZ9DotnxR
 +3IxZN77nphslie0CilAAglqRFpb3X+hbn1VPhRk83TYAeLGKJ1BfTQshs0TLrkBpKv/
 wx20Vdtzl5IGpr6kOzppyIWWdl5nZ1KEj0QD7m4stOXdevDkGhMD3uRcNTp4C2qqZuog
 CxUw==
X-Gm-Message-State: AJIora86FzzkG2gyGpcQvgjryZqDe8TkR+Fn0nP2BqN2/3vL1lFL9z02
 +U0boHJ7DkEDWbCu7QIy5YLC90zDGEc=
X-Google-Smtp-Source: AGRyM1s7d1u9/66Gm8B1U9hFHMS+NTp6IaA1tPWQkH77kzVmLVnPcYMcTCsBzu+H9KIYbYbCH1SB2A==
X-Received: by 2002:a17:90a:9e7:b0:1ef:6fd7:b5f7 with SMTP id
 94-20020a17090a09e700b001ef6fd7b5f7mr11279329pjo.158.1656883725660; 
 Sun, 03 Jul 2022 14:28:45 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a170902bd0400b0016b81679c31sm13912883pls.213.2022.07.03.14.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 14:28:45 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PATCH v2 00/11] OpenRISC Virtual Machine
Date: Mon,  4 Jul 2022 06:28:12 +0900
Message-Id: <20220703212823.10067-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Hello,

This is the OpenRISC Virtual Machine plaform which we are now using for OpenRISC
CI such as the wireguard testing that Jason has been working on.

The first few patches help get OpenRISC QEMU ready for the virtual machine.
There is one bug fix for GDB debugging there too.

Next we have the Virt patch followed by a separate patch to add PCI support
which is split out because it's a bit easier to review that way I thought.  The
next few patches are fixes to get the Multicore platform stable, such as adding
MTTCG support and fixing some interrupt and timer related bugs.

The platform is relatively stable now, but every few boots we get ~10 second soft
lockups.  My hunch is that this is another interrupt race condition where IPI's
end up getting lost.  However, overall the is much more stable than the SMP
support we had before.  So I want to submit this for review and maybe upstream
it before tracking down these last issues which might take significant more
time.

This is being tested with my or1k-virt kernel branch here:

  https://github.com/stffrdhrn/linux/commits/or1k-virt

  This tree has support for: OpenRISC PCI and virt_defconfig and an irqchip bug
  fix.

Changes since v1:
 - Dropped semihosting support
 - Added PCI support
 - Added OpenRISC documentation
 - Added OpenRISC support for MTTCG
 - Support Configurating Goldfish RTC endianness
 - Added a few bug fix patches

-Stafford

Jason A. Donenfeld (1):
  hw/openrisc: virt: pass random seed to fdt

Stafford Horne (10):
  hw/openrisc: Split re-usable boot time apis out to boot.c
  target/openrisc: Fix memory reading in debugger
  goldfish_rtc: Add endianness property
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
 hw/openrisc/Kconfig                      |  12 +
 hw/openrisc/boot.c                       | 117 +++++
 hw/openrisc/cputimer.c                   |  18 +
 hw/openrisc/meson.build                  |   2 +
 hw/openrisc/openrisc_sim.c               | 106 +----
 hw/openrisc/virt.c                       | 578 +++++++++++++++++++++++
 hw/rtc/goldfish_rtc.c                    |  46 +-
 include/hw/openrisc/boot.h               |  34 ++
 include/hw/rtc/goldfish_rtc.h            |   2 +
 target/openrisc/cpu.c                    |   1 -
 target/openrisc/cpu.h                    |   3 +
 target/openrisc/interrupt.c              |   4 +-
 target/openrisc/mmu.c                    |   8 +-
 target/openrisc/sys_helper.c             |  18 +-
 22 files changed, 1035 insertions(+), 114 deletions(-)
 create mode 100644 docs/system/openrisc/cpu-features.rst
 create mode 100644 docs/system/openrisc/emulation.rst
 create mode 100644 docs/system/openrisc/or1k-sim.rst
 create mode 100644 docs/system/openrisc/virt.rst
 create mode 100644 docs/system/target-openrisc.rst
 create mode 100644 hw/openrisc/boot.c
 create mode 100644 hw/openrisc/virt.c
 create mode 100644 include/hw/openrisc/boot.h

-- 
2.36.1

