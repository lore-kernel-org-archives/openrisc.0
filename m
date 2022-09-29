Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D343CC4321E
	for <openrisc@archiver.kernel.org>; Thu, 29 Sep 2022 14:20:30 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 68078248C9;
	Thu, 29 Sep 2022 16:20:29 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mail.librecores.org (Postfix) with ESMTPS id EAF5A24B4C
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 12:15:02 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id o5so627532wms.1
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=Lc6s8nTaNgkoD4GXAuKRr/e01vV82I0xCYG4ndZR8mE=;
 b=VdBznro6tQvY7Ra91sjpFkGp+23+ltMc0M1+HxUAvmurxDmHkN7xXAyapDHCQp2bYo
 IcOHjVcB8XjCdHPEr0405NHKsQYIhAy6v715IoylVtkLVAibALifEmoyafDO2Q3t6xFw
 Kwxpfc32BXs8sFIvB9JYqONOMyQKwWJ4SwQD98zGWDLyuLSi3zYSu4h2LIa0fLGBWfHN
 rq2n46ZMetA5bVrlMAIJvCqpESIEO4qs0rqf3HqAzJvg6o1HvfKu3CN4wm5o0R8soN5e
 1PMLSss+sDDLwNDP34n8rROTB0FJFJhXW2Cm5917WHeJnQ9AvzgKH+v+TpaIzvlYW2rp
 YOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=Lc6s8nTaNgkoD4GXAuKRr/e01vV82I0xCYG4ndZR8mE=;
 b=LBuDbzg26T6PItTcNlOuLWGzInMlZ1ywuF568yu6HrzBZ0sxRlPKPQNTKsQlypZ6z/
 WsuqkW12+LaAB7dqEM2jBwIgsI4LXxGK6KMEHDAjIs5Z9v8j6EogPcdySs89kd0h8sIF
 0JOEVwvB0aPxFYWuw4hx9rKsPQeQhO/4yEDWMFjkjv1z7hZxtP9itle2ReEBkDgS5kv4
 MTjJ/gDpc1JYAtweaOokyw8HLF7iCt6znKRRpEP0Je9pkIhS3g42gFHTTEPBZQHNs1MV
 pS+XijDPZtUKjeIC/uafZ9V3P3v47ZWWRjJp1owBp4bh2pH14uLGElUcnFipvg75sVlD
 /P8Q==
X-Gm-Message-State: ACrzQf1DwQC8GJ0NyvlIWpvOJoxRDOqwHRKsvceZR3YmNolwbXVLC83U
 pg4ReKjJc765dTLMxEqwnWY=
X-Google-Smtp-Source: AMsMyM7FpPxLU4VpzfSVtrPr1gZyMHNeT29IKj9PKpbnj4eER3yeCC1DHIVY0fz/w9FO3cQ4tORCvA==
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id
 r5-20020a05600c320500b003b33813ae3fmr1777401wmp.158.1664446502451; 
 Thu, 29 Sep 2022 03:15:02 -0700 (PDT)
Received: from felia.fritz.box
 (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de.
 [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adfe946000000b0022af63bb6f2sm4163241wrn.113.2022.09.29.03.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 03:15:02 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org
Subject: [PATCH] openrisc: update config files
Date: Thu, 29 Sep 2022 12:14:58 +0200
Message-Id: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 29 Sep 2022 16:20:25 +0200
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
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Clean up config files by:
  - removing configs that were deleted in the past
  - removing configs not in tree and without recently pending patches
  - adding new configs that are replacements for old configs in the file

For some detailed information, see Link.

Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/openrisc/configs/or1ksim_defconfig    | 5 -----
 arch/openrisc/configs/simple_smp_defconfig | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 6e1e004047c7..af1164807206 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -19,9 +19,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -34,7 +31,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
-CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_ETHOC=y
 CONFIG_MICREL_PHY=y
@@ -52,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index ff49d868e040..84ca3203af9c 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -27,9 +27,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -60,5 +57,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_XZ_DEC=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_RCU_TRACE is not set
-- 
2.17.1

