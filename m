Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B807C00140
	for <openrisc@archiver.kernel.org>; Fri,  5 Aug 2022 20:30:11 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 38B8B24A1B;
	Fri,  5 Aug 2022 22:30:10 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mail.librecores.org (Postfix) with ESMTPS id A34A4249BB
 for <openrisc@lists.librecores.org>; Fri,  5 Aug 2022 22:30:08 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so3923783pjf.2
 for <openrisc@lists.librecores.org>; Fri, 05 Aug 2022 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=8shiq3ExegNMJKwy0qXw4HrKImMBLrJX5WjP8qCxZoQ=;
 b=A+AjsT5HxnNkB8Q7xyJ2l9prw3L3QSOYq+ERHA46rfe63EW6v6Nyw6FjLX0fj/pHzm
 rGWQ/SuyFLdO6vFeIEFOGgkJxp4vEG1qzy8oWWSQ8wTl4UFoVhaQc+84Ns3tv2oc8bTD
 ijU67z6Xy5UFIGcQiobSngm1F3820DIERB3f9Pgsd5f35+Mljilm8Og5svMNQtR8Wcgq
 5WFgq8j0OPrZXEqjpSERhM1bsCbtjv11vCLgFc/6DrhfPOtfghZAtCL180gqaR/hsCE3
 8It+1ZG2TCZRalYvf94QH0a14Cru95peGmACUIqAY3srIyyjzoRyWOOovs2h6C+xeoTY
 WEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=8shiq3ExegNMJKwy0qXw4HrKImMBLrJX5WjP8qCxZoQ=;
 b=tCD4k8o4kX1Fzluxb8x7jKnZG3y2us/wxraI/JmSWh5Vy8lyBkH/oXULkCAfWyfSch
 MdStZYjPRuWGRvkdx5oUELb+yhlJAh5E6v7DpZzLrKQFb+1tMMZpWZthwk08HY023Vvr
 PULeoOXHh9voMZWwu+M69jl1lak66uudm7bDWAtwkiyXaKC9zpgaWnaYffrc7TUJrJcg
 IjUpKRXsG6fgDEZLc8WGV5If8g6WOOkD6JjupFei4N6udcJIfhQT724TyycWlCylQqDs
 8j6WWyV3zh+MZ2dvxStXFOGtdu4hXbEXbrAgeiaenwDFUE/K3sGqE8UePxIHbkeuEYN7
 rM3A==
X-Gm-Message-State: ACgBeo3lqdjQqNSniTZ9JCxDSzqHMgJb1pw8ohvb+lGSyNOk0lB+vhYs
 zJeQDOmfeKaboxRP8Lguh1g=
X-Google-Smtp-Source: AA6agR7fLbI82TXjaKf5dCIm3W3ikIcL9njw1IikMRoYURZ5NitU7R45eTsoXDwOtcVDAc45LtAUrg==
X-Received: by 2002:a17:902:f54b:b0:16e:f07b:46d0 with SMTP id
 h11-20020a170902f54b00b0016ef07b46d0mr8426975plf.77.1659731406810; 
 Fri, 05 Aug 2022 13:30:06 -0700 (PDT)
Received: from localhost ([182.171.77.115]) by smtp.gmail.com with ESMTPSA id
 x10-20020aa79aca000000b0052e6d5ee183sm3380241pfp.129.2022.08.05.13.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Aug 2022 13:30:06 -0700 (PDT)
Date: Sat, 6 Aug 2022 05:30:04 +0900
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] OpenRISC fixes/updates for v6.0-rc1
Message-ID: <Yu19zEVnjSkH8nO2@antec>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hello Linus,

Please consider for pull,

The following changes since commit 0757060a438835df82bd8aec40d4abc7dc4c9584:

  Merge branch 'pci/header-cleanup-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git (2022-07-30 05:47:13 +0900)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 52e0ea900202d23843daee8f7089817e81dd3dd7:

  openrisc: io: Define iounmap argument as volatile (2022-07-30 05:50:15 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.20-rc1/6.0

In this cycle we add PCI support to OpenRISC used in our new QEMU virt
platform.  The base of this series is a merge of Bjorn's PCI headers
cleanup branch and 5.16-rc6.  The patches from the PCI branch are needed
for the series to work.

The main updates from me include:
 - Kconfig updates to support OpenRISC PCI (just config now after the
   PCI cleanups I did on Bjorn's branch)
 - A new defconfig for the qemu virt platform.
 - Also there is one MAINTAINERS update.  As I was working on the PCI
   series we kept getting bounces from Richard's old email address. I
   added this here; I am not sure how these are usually handled when
   the maintainer doesn't queue it themselves.

----------------------------------------------------------------
Stafford Horne (4):
      openrisc: Add pci bus support
      openrisc: Add virt defconfig
      MAINTAINERS: Update Richard Henderson's address
      openrisc: io: Define iounmap argument as volatile

 MAINTAINERS                          |   2 +-
 arch/openrisc/Kconfig                |   5 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   4 +-
 arch/openrisc/mm/ioremap.c           |   2 +-
 6 files changed, 117 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig
