Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432E5C433EF
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:13:40 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0437A247C2;
	Sat, 21 May 2022 15:13:39 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mail.librecores.org (Postfix) with ESMTPS id 3EEC824758
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:13:37 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id p8so9855911pfh.8
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7tsnp7LDR4Kj+qjwcH/l61gToy0Uf2WpoVPY59g6dIY=;
 b=ZxwBpu0DVHrWeYFLzEEFa4jqJp/XPgAheEoJmFhCsDTylRmZnEJ2ggi9MHv9yPWMxw
 wF1e6XpqBCKCAaHSRwQuq7UukRsDdWhgIP+KjeUcvG8E3hp3xwbCUP9wjfFagr6f4LNG
 /NZlAEeyRkyETtJCe1ZDNnANcPvwaMJL+qJLJduaAx5tMqZxZJGJTqW/ic9UpLcTyBPN
 elRLB6K+9LQg+IAPX91KwSIadvZ6crob7IUAyCAUYcrLHyYQ03G+TB3fRsPKcVv2hj4B
 Fgj3FJaxV7aBXJ5apxocIuthy7NrVzXzkGXewAm9cpkF1EW7Naz6Abp0J0DgS7J6L8p9
 n9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7tsnp7LDR4Kj+qjwcH/l61gToy0Uf2WpoVPY59g6dIY=;
 b=ti80ATRWeJHCAC+VmHf7fV1HEGSrMkwO5lZEwe8R01eD6aAdEGNMwlTwQeoKUwXcOM
 rPaalwqtQGDpXgYIuE+p5HL76LyiznkMygCDE6wyGjWA/weZ8fNrnW4hd2L97tFloypn
 SJ3AR+cAzT6x2zeR2mNlsD/bATC/Ia9ZNuGrZUtFnHHybKGkN0OiRWuYM0M07kqwDrf5
 /qMaZJNY2P7Lgf5Czt87T1k9D6KKAmWLqSpiW2yDBdowWmnpk+HGJzfFxNyBH0dXRu1T
 2vxgfK7lKfq3/1w9IFNVI3qDk74seFAOb6+O4kHqBzpbOYarPELWtf9YIQHShKrtKkAw
 JsJg==
X-Gm-Message-State: AOAM533JE+5nNd2UIGQ5nwrfUoHjstrLQupooE3s8LwIJQGHm9ucNqKQ
 HmrJ0LEbqD6C3Nj+WlwmcLM=
X-Google-Smtp-Source: ABdhPJwPiWuciTXjZ6QiW+0tPWmqJkOlUJHzwTydnETcGzgcmqZFazom/EYilMGkXkAd23K30ypKIA==
X-Received: by 2002:a62:a516:0:b0:505:722e:15d5 with SMTP id
 v22-20020a62a516000000b00505722e15d5mr14855952pfm.52.1653138815604; 
 Sat, 21 May 2022 06:13:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a170902e41400b0015e8d4eb25csm1553075ple.166.2022.05.21.06.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:13:34 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/13] OpenRISC misc cleanups for 5.19
Date: Sat, 21 May 2022 22:13:10 +0900
Message-Id: <20220521131323.631209-1-shorne@gmail.com>
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

Changes since v2:
 - Don't enabled class II instructions by default
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
 arch/openrisc/configs/or1klitex_defconfig |  32 ++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++----------------
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++--
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   4 +-
 9 files changed, 254 insertions(+), 307 deletions(-)

-- 
2.31.1

