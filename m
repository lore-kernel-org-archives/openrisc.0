Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E5EC433EF
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 13:21:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C7B9024844;
	Wed,  6 Jul 2022 15:21:37 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mail.librecores.org (Postfix) with ESMTPS id 4896A2422B
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 15:21:36 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id i190so1409357pge.7
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=0wycCic3IQjLfFUkhvbAA5k6Sim7nNN6yKAb7C8DaIc=;
 b=Gkowlk9kxyMQoZWdag95a2G3CObcLUndvl22zb6fP5tnkzyvBaxjA2T80fgfYmzDT7
 /kStuwFmmZomXiOhisu0B6ZcbDuhRgkJTWUmCmVHyc5D+FcohyoAypY+OtXLYsVwurqx
 FEIoOrKHtxj+jksFe/hNqB2NlQP80o/ABQBE/CQ9Oo3TfOq1riEIzGgFWiOf5I+2DsEk
 T5Hix+EKnsmTd2eMJ8BCAdiBJmLTtyjuwh0H7a2sq+PFejDNfs44m9QN9r6DTqxjgxPp
 yqaH92Pac+GcGYbiQJnNwIMnz7mXgixaqmIEBhr/DrkCeP4JGBrNetZHa1fm5ddgP9Xl
 LuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=0wycCic3IQjLfFUkhvbAA5k6Sim7nNN6yKAb7C8DaIc=;
 b=AmhhbnHACqX72zHwP3eUcjgn3hyYBheBBAejOWqSSALVHYGae9bl6Y64ftQdI+zpi4
 LadM0bITTu2g4f6lxKx7b+al5FTkTudLoR1TDt27W34XB41WEsw0rTLOUvIDIKB2DZ+Q
 Y9OorLEbF0Wv4eLheseEjFX9FfvRvo4xTwd80mHBsG2YXqmWieB/EG9ZtczEENg4LL6g
 chANO6fxZWsKS2SXCvCMW9BanitpZXq5fsTi9TtlR0xgS0SkpsP2fHJHmGkJrC4OBuGR
 dMOvvB0JLOK84m+E4ARvUkA+qwW10m2l646ROAXt6YVlW+Kt5FtoMrd4hRg67BL1rhxU
 qolw==
X-Gm-Message-State: AJIora+PH+C+W7D7EpWZDVc0DHSZx0lfN/LOh7UsVjAhueqFHyNPmKm1
 y6LpeGOfO3N1c+zZ5YneASo=
X-Google-Smtp-Source: AGRyM1sVX23KTq7UqJA/iy6sLn9wajWmLcN6iiPJ9IW7uON2Mqa9yjpF3DACkZA8OHtjP53OEB13zQ==
X-Received: by 2002:a05:6a00:1d2a:b0:528:a318:7ed8 with SMTP id
 a42-20020a056a001d2a00b00528a3187ed8mr4572888pfx.55.1657113694588; 
 Wed, 06 Jul 2022 06:21:34 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 142-20020a630094000000b0040d376ea100sm3046505pga.73.2022.07.06.06.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 06:21:34 -0700 (PDT)
Date: Wed, 6 Jul 2022 22:21:32 +0900
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: OpenRISC fixes for 5.19-rc5
Message-ID: <YsWMXAF3ePlWuxyF@antec>
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

Hi Linus,

Please consider for pull.

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 48bddb89d59eec27c3305d179b1832d5292e285d:

  openrisc: unwinder: Fix grammar issue in comment (2022-06-28 17:31:24 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.19-rc5

Fixups for OpenRISC found during recent testing:
 - An OpenRISC irqchip fix to stop acking level interrupts which was
   causing issues on SMP platforms.
 - A comment typo fix in our unwinder code.

----------------------------------------------------------------

Note, if you do check this against being in linux-next I dropped one patch from
the linux next tree before creating this pull request.  The dropped patch was to
add wireguard selftest support, but we decided against it as there are still
some qemu bugs to workout before turning on wireguard selftests for OpenRISC.

Stafford Horne (1):
      irqchip: or1k-pic: Undefine mask_ack for level triggered hardware

Xiang wangx (1):
      openrisc: unwinder: Fix grammar issue in comment

 arch/openrisc/kernel/unwinder.c | 2 +-
 drivers/irqchip/irq-or1k-pic.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
