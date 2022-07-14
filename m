Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C8ECCA486
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:27:46 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 5519724916;
	Thu, 14 Jul 2022 06:27:45 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id 9A2F7248B4
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:27:44 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 x18-20020a17090a8a9200b001ef83b332f5so7176338pjn.0
 for <openrisc@lists.librecores.org>; Wed, 13 Jul 2022 21:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1zxZAoy64GdtsJQOfRGCbNc3VQnUKxrndVlWjexAZME=;
 b=i9qANYhdJ1TDqpr/gQ/fVixRIYA9nY9RltKyOvwVt1eIqD1isphbX/CIUFZkepe7tq
 uvYGafyIEefyU/FNiJkE1cCTNzcjJB8ZfyhKwgCpRsxd8R+kF9/fgd1j3A9DbI6FNq7t
 QWY6olDoQnYpCMY1cdHbhEpZluSWMLZLcQUGFiLit+NFxE0L3Fkx/E1mmMxOCc3jtyxR
 kUe1E01oD2cdHPtbaJhkkAdICDWlev2XRTc1DOSMM5LVKZzZJQMHCOFeqfYtk9lNAhp8
 /vlX5YWS5vR7B+Ted7ceDxS/JgDHbPsL9xnkShSWWutLp+csYXnaixd4DaO8RWh+1vb7
 KdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1zxZAoy64GdtsJQOfRGCbNc3VQnUKxrndVlWjexAZME=;
 b=eNduLf6/caYa9xyWy7fkbWLqJgxtDM8MQ27naVEXjX0Y8djPxgLjAsTn7vLloesxGB
 rEBEltifzmtj+SoIqKIzcarfDzYgOr9Cg/wsXlV0MEqmqnBpAZF8vMybl79dkeh8BmkK
 VRpYn1VwL6t2n7JA/MQDKo8t7HiAGydLp/SrnS96ceLzuzegwFosrLYrB2wsJNqKog77
 HqyvpNECvPUQRV6kiIVyNa+O86k1atBeiQM5GVBFe0pTLEUo3jdjCgmx2spa7wfNQX9Z
 CJBL3MljUwTNZ9NQbDADxOqQ1fZKrAo5mCgDoNUXpLDd6Hoh2KUKugMtmV8lHtHkha19
 zrgg==
X-Gm-Message-State: AJIora8o1CxgsHbXgQBv+aEEBGdr34zWi0Gp/Q65/MEx6RTZp9hpc6FW
 Ut1YcAnaqETAskmqg1GFfpY=
X-Google-Smtp-Source: AGRyM1vf5Tts11shJZnxVMR8ji9kdGEwP6T7fHyzDKH5EteBhIdecA66VKgsMU6CVeYNJ13Te0y9CA==
X-Received: by 2002:a17:90b:4d85:b0:1ef:9fd2:b789 with SMTP id
 oj5-20020a17090b4d8500b001ef9fd2b789mr14006208pjb.196.1657772863079; 
 Wed, 13 Jul 2022 21:27:43 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa7959a000000b00528bd940390sm396538pfj.153.2022.07.13.21.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 21:27:42 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] OpenRISC support for virt platform with PCI
Date: Thu, 14 Jul 2022 13:27:33 +0900
Message-Id: <20220714042736.2133067-1-shorne@gmail.com>
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

This is a set of kernel patches which I have been using to support the new QEMU
virt platform [1].  The virt platform supports PCI hence I have a patch here to
add PCI support to OpenRISC.

A defconfig is also included which turns on drivers supported devices include
virt network cards and the goldfish RTC.

[1] https://github.com/stffrdhrn/qemu/tree/or1k-virt-3

Changes since v1:

 - Remove PIO support as suggest by Arnd

Stafford Horne (2):
  openrisc: Add pci bus support
  openrisc: Add virt defconfig

 arch/openrisc/Kconfig                |   7 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   2 +-
 arch/openrisc/include/asm/pci.h      |  36 +++++++++
 5 files changed, 150 insertions(+), 4 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig
 create mode 100644 arch/openrisc/include/asm/pci.h

-- 
2.36.1

