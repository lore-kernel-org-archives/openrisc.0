Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68267C433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 01:40:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0E5CB240FC;
	Sun, 15 May 2022 03:39:59 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mail.librecores.org (Postfix) with ESMTPS id BB3C9248F1
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 03:39:57 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id c9so11369571plh.2
 for <openrisc@lists.librecores.org>; Sat, 14 May 2022 18:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mvQBk5SiMUkiCo0+hW1crF9AFqWoaojULkuaaUUtHH0=;
 b=PQd2HwSMCMR8MpHL234noYu8t9AkrCk1zHcPTwwDb4USKVSvK4PzmR1hq2O7B9EAqh
 UbokYp9M4/734/EeWq7RVsHAulFoH0iZ1vwGCxqgUojkWWL9H1ATuSg1FLNtqW8+Yefz
 3Zyo0bgkGDjUOU91vYDYDXtAk8a00fDrmpMa7thrq6WrVxdVs/CYsIRiFpMZaaFoSz7N
 njlOviauikGBhnAuGloLyVkS/x8T8n8DQosYAj6EkmL25Rki/kRwchOz+6Fl0sV0c7NW
 MzxuE/QS1uUon0oWezYATya/CTjy8ZwQehvKG6Y3bXCK8u/AdFc0IxmgCiqsPe4JOsHZ
 7+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mvQBk5SiMUkiCo0+hW1crF9AFqWoaojULkuaaUUtHH0=;
 b=iX6MCKygMkpv8tPzjkM0xarYBrjRJ2BuVuNujB/SGDN0Z76yDMnL2AVjUmc4iTt2oi
 /jYOyqhykGXGYJ8w/O0OrwjYy0csX1T21irheKza6uNzmp0GrHnMT2cpLicxyHDp8/II
 3zZGpZIAh+iXk8MSlTN4T/+C3ZCRG2S1X5YzrYdE+bJYxZHSqDJiOJcAR/VxjHtug+ia
 YyKJ465NIMwVfq7qRhrJR4SnvLqmvvAkhoQtY4v40bvnLo2z7wqs3auWcq1gdtSyo6cn
 70s/fnKne2svPgr2QOaRbEwJIkk0+ksLAigFEMoPGOhQa0pa1o78aBh9MUeSrHWNNxVR
 wMtA==
X-Gm-Message-State: AOAM5311C/60zXIs7ws6PoTWkZ+VFTwdnFfmlDvqeWelIC+DdBnyNyr8
 8otI/gEFfheXSHyQHL4J+fM=
X-Google-Smtp-Source: ABdhPJzWNOMvYHvXyUEBKW28k78/LichPuyKCoxdUQsuvqvyPh0xE/Q2TH2dKqr4v87eXEYc1gia5g==
X-Received: by 2002:a17:902:ebc8:b0:15f:417c:288b with SMTP id
 p8-20020a170902ebc800b0015f417c288bmr11626261plg.14.1652578796160; 
 Sat, 14 May 2022 18:39:56 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a63f846000000b003c14af5060asm4118104pgj.34.2022.05.14.18.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 May 2022 18:39:54 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: [PULL 0/4] OpenRISC fixes for QEMU 2022-05-15
Date: Sun, 15 May 2022 10:39:44 +0900
Message-Id: <20220515013948.2993495-1-shorne@gmail.com>
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

The following changes since commit 2e3408b3cc7de4e87a9adafc8c19bfce3abec947:

  Merge tag 'misc-pull-request' of gitlab.com:marcandre.lureau/qemu into staging (2022-05-03 09:13:17 -0700)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/or1k-pull-request-20220515

for you to fetch changes up to e8f0ab0cd674241cbab7231ce05ac1bfa0b4f5ed:

  target/openrisc: Do not reset delay slot flag on early tb exit (2022-05-15 10:33:01 +0900)

----------------------------------------------------------------
OpenRISC Fixes for 7.0

 - A few or1ksim fixes and enhancements
 - A fix for OpenRISC tcg backend around delay slot handling

----------------------------------------------------------------
Jason A. Donenfeld (3):
      hw/openrisc: page-align FDT address
      hw/openrisc: support 4 serial ports in or1ksim
      hw/openrisc: use right OMPIC size variable

Stafford Horne (1):
      target/openrisc: Do not reset delay slot flag on early tb exit

 hw/openrisc/openrisc_sim.c | 28 +++++++++++++++++++---------
 target/openrisc/cpu.c      | 11 +++++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

Jason A. Donenfeld (3):
  hw/openrisc: page-align FDT address
  hw/openrisc: support 4 serial ports in or1ksim
  hw/openrisc: use right OMPIC size variable

Stafford Horne (1):
  target/openrisc: Do not reset delay slot flag on early tb exit

 hw/openrisc/openrisc_sim.c | 28 +++++++++++++++++++---------
 target/openrisc/cpu.c      | 11 +++++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.31.1

