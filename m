Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA6C433EF
	for <openrisc@archiver.kernel.org>; Thu, 26 May 2022 22:23:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id EC3C7248C7;
	Fri, 27 May 2022 00:23:41 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mail.librecores.org (Postfix) with ESMTPS id E4A3624862
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 00:23:39 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id t28so2421120pga.6
 for <openrisc@lists.librecores.org>; Thu, 26 May 2022 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=qTkavwHRG1kUc7MxLLp8QNhHsYtlyypXgt7Cjx7vDVs=;
 b=PshBz5VS9QipcURmfBmNiQgFaxxRYldCwPz4iHpsbw2DXAjjVYY1vsfMQRE4cR4xBc
 ESydKV5rkBbalNPk55GbhtDwJN8xJ34M25U8DtFK3qyQSUdqZhSYhLjhDozi16BhQA6U
 /i2RD7b24+7cNBayA7W5Cm6goqg6xW/j+5u9dM26wwKqgF49CX2x6f99EGw8ev3Cbtrg
 7IVYG9V6UUwx7TbL99gLN+fGS/NwRk9ml+iQGf7a2fa1duxo3GGlQYUo3jazcwHsFdHU
 BCp996pwt872vvF53nA/d2RbQh2sKTImfaIRUrwbaizdTVfSrrJPh6pYsK5bECD+pOsD
 lgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=qTkavwHRG1kUc7MxLLp8QNhHsYtlyypXgt7Cjx7vDVs=;
 b=W0TYngPKDrnmT5ANovd12hZLbCGecmutfeCOVFPpd8R7RoflajYJvfMyirADbQK2gy
 GAYq6pXBYyclk2AZJ/0aZAnZSNJGPxRrtMEQVDyZpYHiQsG0YGPLPOHohwIJndBhLZ5m
 PY0Lh7eybc0MQkWHGRMYrLZnJDK+1M3YDjHRY25VjgcQ7WXl4Fcwjyf32toqhSNgxpjk
 SPEn5nXfB+CM0T7/XHQ7qysgAUep/8PSC97b4c9ze4D3Y5oyksb71N4OH1kApJUD4p7O
 uRd84jLOI1FCu/fFxHBLBmPZTr/epVz5oYjc4zIPvLCO5/uZwgib1G0lgjRGBftkvFBL
 DeaA==
X-Gm-Message-State: AOAM532X4jE3N0lQVGqt9Fa3TX/Awn3iDOnCAvCJ2/RRjKCchNAOIU/l
 jDkx4y/qODlQiqYvmTiV4XQ=
X-Google-Smtp-Source: ABdhPJwbfOaJPqis6FimF5jgp55B1scv/z1hwwGkaOmrhZks5bXXO1AAmJiliGEIG583B56XDFGuNA==
X-Received: by 2002:a05:6a00:7d6:b0:518:9fa0:7dc with SMTP id
 n22-20020a056a0007d600b005189fa007dcmr22226173pfu.36.1653603818173; 
 Thu, 26 May 2022 15:23:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a17090a2e0400b001df2b09ce9dsm165500pjd.4.2022.05.26.15.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 15:23:37 -0700 (PDT)
Date: Fri, 27 May 2022 07:23:35 +0900
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] OpenRISC updates for 5.19
Message-ID: <Yo/955uRNSaSMBqn@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 Openrisc <openrisc@lists.librecores.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Linus,

Please consider for pull

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 83da38d82b2f7ac207646e55be94e8bd642e2c39:

  openrisc: Allow power off handler overriding (2022-05-23 17:15:50 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.19

Fixups and enhancements for OpenRISC:
 - A few sparse warning fixups and other cleanups I noticed when working
   on a recent TLB bug found on a new OpenRISC core bring up.
 - A few fixup's from me and Jason A Donenfeld to help shutdown OpenRISC
   platforms when running CI tests

----------------------------------------------------------------
Jason A. Donenfeld (2):
      openrisc: remove bogus nops and shutdowns
      openrisc: define nop command for simulator reboot

Julia Lawall (1):
      openrisc: fix typos in comments

Stafford Horne (14):
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
      openrisc: Allow power off handler overriding

 arch/openrisc/Kconfig                     |  53 +++++
 arch/openrisc/Makefile                    |  17 ++
 arch/openrisc/configs/or1klitex_defconfig |  32 +++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++++----------------------
 arch/openrisc/kernel/process.c            |  19 +-
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++---
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   9 +-
 arch/openrisc/mm/tlb.c                    |   2 +-
 11 files changed, 272 insertions(+), 315 deletions(-)
