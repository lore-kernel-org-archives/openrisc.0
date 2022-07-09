Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E541C433EF
	for <openrisc@archiver.kernel.org>; Sat,  9 Jul 2022 21:16:21 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 09FDD21052;
	Sat,  9 Jul 2022 23:16:20 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mail.librecores.org (Postfix) with ESMTPS id AFAFE20EEF
 for <openrisc@lists.librecores.org>; Sat,  9 Jul 2022 23:16:18 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id m14so1517911plg.5
 for <openrisc@lists.librecores.org>; Sat, 09 Jul 2022 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c+pbbkuTfdK3RD+xw+jDI7D4rUYNVSIOak1x3V2zW8Y=;
 b=aICdV93jXxwJmbvGcHBbHwGyDRdI7NX1U4p9MYRjoL3DEX8cOykCUhtw31eWwfHRjB
 BovmjJaS29bmvBExHQuyfAyTiZjCrsjR4FlUqISc8W1OKwKSVMRIC9hKJEc0md+/hSCc
 zqiiQ8mbWq59/LoveRtGbmTHgiuwgtoxZuWJG4rb6F2mFdIQbUdFtUMSHMqXc+teUAcr
 RUmVOYgk++PUDVwWeS1zgiMI6w05paWtLPkHFir064I4rbtHZvzi1VzPklkyoasXGWGl
 i7Z6GZKVGzcNq9e1x4Z+RF0LEWCdG/rbWspDokcSK1zUStGPE3AxyasMlwDyi6ALRlNH
 sYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c+pbbkuTfdK3RD+xw+jDI7D4rUYNVSIOak1x3V2zW8Y=;
 b=04yehLSFEI9Pfeu999zFEFOyEAH/DlN7ZYMhhLLmJ+HrVSgMKV0GyOUSbwkM6vDz46
 XguRIE0Ob1yYGMOiECLSid94BU1EIUIG8m5evr6oYN8HzqjwuyX89erXc0Nr2VG8gFOF
 EptaiS1ae0v1n/PZUi0LDXqZnUTBlRWZYMFWCjpf7kAueOvfamjDUkZPGmLIp8bK7/pv
 JF+GPRkw0U2EvNCdq/D4HMiiWl40dFTV1plLlZNsiLCVzS1DMZHLXrJCZsne7741qNUN
 PBcrz3Zd4wgMFIq+JFBIW+cUgXj+sNHRrHd6IX2BTKdgMPW8S9DTlKQBVTqdA5Y3xT+5
 Z7WQ==
X-Gm-Message-State: AJIora9I6n1TFPk1luf2R/fcrYOEGSKs5xxGO/TWEPcFUDHlq/WXU7i2
 O7+CnzQlRI7XxVFOxEsuRDI=
X-Google-Smtp-Source: AGRyM1vY3LIMJkl3C67NFy0C5/Bk1O6eH26Rb3zoV4lXG3RQL8jGzj12n0y8C/t1/bHY+4m7wb+UWw==
X-Received: by 2002:a17:902:dac2:b0:16c:6a1:692c with SMTP id
 q2-20020a170902dac200b0016c06a1692cmr10180535plx.19.1657401377063; 
 Sat, 09 Jul 2022 14:16:17 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a621a08000000b00528e84c3093sm1952354pfa.143.2022.07.09.14.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Jul 2022 14:16:16 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] OpenRISC support for virt platform with PCI
Date: Sun, 10 Jul 2022 06:15:47 +0900
Message-Id: <20220709211549.1163327-1-shorne@gmail.com>
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

[1] https://github.com/stffrdhrn/qemu/tree/or1k-virt-2

Stafford Horne (2):
  openrisc: Add pci bus support
  openrisc: Add virt defconfig

 arch/openrisc/Kconfig                |   7 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   4 +-
 arch/openrisc/include/asm/pci.h      |  36 +++++++++
 5 files changed, 151 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig
 create mode 100644 arch/openrisc/include/asm/pci.h

-- 
2.36.1

