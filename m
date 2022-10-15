Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98910C4332F
	for <openrisc@archiver.kernel.org>; Sat, 15 Oct 2022 16:48:55 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 794EA24BD5;
	Sat, 15 Oct 2022 18:48:54 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mail.librecores.org (Postfix) with ESMTPS id 7094024B77
 for <openrisc@lists.librecores.org>; Sat, 15 Oct 2022 18:48:53 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id bk15so12002146wrb.13
 for <openrisc@lists.librecores.org>; Sat, 15 Oct 2022 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=loly9KUFB8PbWChec+LUQaUzF19XotFqi6Pac7eROaY=;
 b=cSTN13HhqgcpUCpxdosHHpbI6WH5HDFkdZs46rV+CMeOu7ARjBH9VX1oBoJmfhnpux
 E4hno/c15Al6ICFYko16J9EGNb4VOsbtsnr5f6BWF5FCQsol5y4M4K/dtX8PePAWSaWb
 tGiY9em9PuvhDgdrrYeVg7Vv3eQU9fqFZhXfB4MWiJEo51Uvt6eUYUdIbccf7S3iziV6
 5gLou6h1ZRBASy/L540SW/htQJlX8XqlHa7ZbGyxO5iIw+cDqf+11eB12G4q+8hyNkNe
 CROGPXNG9Os9PdVeNyfuwrhpDlNwizbqF6kswhoJ2DiNojsgNjlXGYERQAjRJWsGm4+r
 J7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loly9KUFB8PbWChec+LUQaUzF19XotFqi6Pac7eROaY=;
 b=f61H8dPsmGiWYuD7g6+t7KFKHih1pugUqMR01TbwiWWTGsG0sbuVOe63P8TTi9I9k6
 Sp8zdd3sgcWkaUIqlt0FNWt7BjGuOAetKF9vJUdk0aY9BoxjdGFlOxccEU3YPjE78Y7y
 RtDY40mqCPWSa0RbMg4Qt5rSnoHaffwi66dfdjRAyK1kDtS9BXuJGtlZRl9eLEc3hs1m
 dgPdSGvAmPn79wsVrODWYekMNhvpKx6Zu6rl0yqTCQfZ7vkrxIvaJqzrqoXA3TNXnJIT
 EbPhA2poalbDSI6InopYykqRE5fMRa7DnEo1hOlCMkXyC6R9lXuq0giEwJB2bcH7dZSk
 NvlQ==
X-Gm-Message-State: ACrzQf1IdSHr6h+ShY+KYO+S7DtDZ8Lx66qH8AJHQcumlgk9KXOljoEA
 ksgBZtQ7Ba+Ksigo8fQixj8=
X-Google-Smtp-Source: AMsMyM7rGH7ib6DeJF8OPZaegYPVhejKtD203z3/7LfRYBYoSymh37dlFVeLh2o5IlPMiVxTk2EyFQ==
X-Received: by 2002:a05:6000:1688:b0:22e:58cd:5a2b with SMTP id
 y8-20020a056000168800b0022e58cd5a2bmr1872892wrd.365.1665852532647; 
 Sat, 15 Oct 2022 09:48:52 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 bz13-20020a056000090d00b00228cd9f6349sm4541568wrb.106.2022.10.15.09.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Oct 2022 09:48:50 -0700 (PDT)
Date: Sat, 15 Oct 2022 17:48:50 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] OpenRISC updates for v6.1-rc1
Message-ID: <Y0rkcqBr6Wan4ueU@stafford-asahi>
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

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 34a0bac084e49324c29e6d0984d24096e02c6314:

  MAINTAINERS: git://github -> https://github.com for openrisc (2022-10-15 17:26:51 +0100)

----------------------------------------------------------------
OpenRISC 6.1 Updates

I have relocated to London so not much work from me while I get settled.

Still, OpenRISC picked up two patches in this window:
 - Fix for kernel page table walking from Jann Horn
 - MAINTAINER entry cleanup from Palmer Dabbelt

----------------------------------------------------------------
Jann Horn (1):
      openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached

Palmer Dabbelt (1):
      MAINTAINERS: git://github -> https://github.com for openrisc

 MAINTAINERS                |  2 +-
 arch/openrisc/kernel/dma.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)
