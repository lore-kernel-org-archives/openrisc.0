Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54EC433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:12 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 62F7E20CE9;
	Sun, 15 May 2022 14:42:11 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mail.librecores.org (Postfix) with ESMTPS id A3F2924216
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:09 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id c11so11990948plg.13
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AVFRHlzGX/WRPz6rMiRYI/Ib3vqoWaqc8BQYvZ/LSIw=;
 b=GdwFTCPfiO7U9zosXxBYcmAhFZEaMxvG4SFgMUw0AhuFegMc2OQ1Xwr5VDAyHE1+J4
 4VNF81weFqaGZIrQm8Ee6tApJwzn7N3atSaPeZop5agNoThRnLzfvoz5JXBMPG1SOghp
 DGEcGxEgnBY8LVTZtiQ8c0Ixix2KZqYdiBQrcoH5stOW+UhNYay8I5QDbcJmfQkQBC8h
 XYBsRGvVJlLbTAml3ooN9rZsrzGu+EETood1emxQvigTV1O0x/b9Sj6rWqW1MyU7anUU
 WKZt8+Bcoubs3Jki51/L77N/m10WeSOPZ0MHxzv3u/bk13EMIZEd7QbzBMGOJSXyNlAK
 sctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AVFRHlzGX/WRPz6rMiRYI/Ib3vqoWaqc8BQYvZ/LSIw=;
 b=XS+4Bv7IZoyFD3KzMh40P2BGdG9LvnTCDHHmOaBBUtIBm4vhr7HfGj2P2m+rlzolBB
 CIF3Vzsj5jqk8u/FXlx4KjVqL3kSyrBqErIfGb3rMn0J6D2zN0ECFC2VJlhjRr0gGp3z
 NRIfrqLBuqtBJ+Gj2amXE36tZMBN/HIa064cr2szXkAKVV2wsquJxdGANUdd43yh20pE
 YULDgqIJIt2gQeZRwLUAdj/eWqjHqdGKP+wRxVP9KsK1RWFHONv+wBv+0vMwTWwsv48f
 qnLUPrJa5rW4XypiVv7sTpL0c+35TyPUqtYbPVyeQM6x+84VJvKW2W0EPZTCXd+Ufzxr
 iOQg==
X-Gm-Message-State: AOAM530oD0eQj86BD/y7cbBMUb24jwshPldxwXE6OU7lmtXZhnW7Wd4g
 ZBamRdjaMEiy8sHA8KtLw5s=
X-Google-Smtp-Source: ABdhPJyttjmNeeyG93To3spB1iaqBDuusIqIkyuFaa7RIV56YC49oI0C1AkgwgnzdhnM5CYiJPEOow==
X-Received: by 2002:a17:90b:1d92:b0:1dc:3f14:f8d0 with SMTP id
 pf18-20020a17090b1d9200b001dc3f14f8d0mr14391431pjb.7.1652618528030; 
 Sun, 15 May 2022 05:42:08 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a056a00174b00b0050dc76281bfsm4948797pfc.153.2022.05.15.05.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:07 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/13] OpenIRSC misc cleanups for 5.19
Date: Sun, 15 May 2022 21:41:45 +0900
Message-Id: <20220515124158.3167452-1-shorne@gmail.com>
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

