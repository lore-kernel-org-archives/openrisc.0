Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A8C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 11:07:55 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3C8FD24A1A;
	Fri, 29 Jul 2022 13:07:54 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mail.librecores.org (Postfix) with ESMTPS id 4F6B8242D7
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 13:07:53 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so4943365pjf.2
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dg0qE236j75IPYm3gyWWoQDxRHaWsFT0nXvPkft/ED8=;
 b=ilJK0XZe2/X1mmOKGXUe7ww8k5aJC6BxG3gXRHNND8F9mB8+Kjx0cnfWcbP8b4RiAT
 FkwHtfg+0/u3L2aUSr9sjPsbwa04Ub7LAT02BB151HyxlDC2bL+z68H4SwxIl6U4S17G
 1x2LjCsYwmFl56sS3FCrBsK4e7K6iLoWClhOWazEUfls0CnI00erWFu8a9/mFfdU8mG7
 gPKlckyLVb3daPgBDIJsAM4JCkdPNwbkgaCCW1RhS8AUpXEb69wwnUec+JURsmQrW7ja
 fNyDQuOGSOezjnw4fkqvgQPnVXxk5mB0+KibcEdJ9pnSMzGsDMHg0ka+hZ1eLo3tSLPH
 c/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dg0qE236j75IPYm3gyWWoQDxRHaWsFT0nXvPkft/ED8=;
 b=TUUv0hsPIbvQV9//hz0QbTQn4Mh0gID6AxAg1SlcYEK7Ag6EZm+zUzoW5CX2k1ghpT
 B2EEHABQRVg7UBhwcHrXw16SEbKHnesNwVkEsaXw6U9iAj545lxrJpawHqzUyQIbEKuP
 Feyl5ngM/sH/FF1/oLhTozviNyhnSMBmoa85CrTKBBKvRTCq4P3v44X4AbTaXwJicimt
 aFMaW3676BXG644c5fzEYMs5hzt0mP65w6ljALYGcNrzVs9w1MMNmBsXs5BpVSRtB8eb
 k6WvoZLKTeai2JcxJURNvAj9mskVC1B2/VuTsXsKkQH2cIw0+0X4N/NE/xDHPGTnsK2I
 tAuw==
X-Gm-Message-State: ACgBeo0Y9HrOPfWgytoZ1DY+kpRRLw4hAFlH0Pqpn7xNZDzERKy9kZHG
 iV7ZiynJJ0rgH1WLUJl0D1Y=
X-Google-Smtp-Source: AA6agR7K0DVPsqc7kshSFFkVsCLalRuyPMUBZgOkbFEOCB/w9q23UDpCLSXXq6fl+CpHWKhDOs+3nA==
X-Received: by 2002:a17:903:40c4:b0:16d:d2a9:43ae with SMTP id
 t4-20020a17090340c400b0016dd2a943aemr2322406pld.57.1659092871617; 
 Fri, 29 Jul 2022 04:07:51 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a17090abf8b00b001efa332d365sm2719340pjs.33.2022.07.29.04.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 04:07:51 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] openrisc: io: Define iounmap argument as volatile
Date: Fri, 29 Jul 2022 20:07:25 +0900
Message-Id: <20220729110726.3635262-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
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
Cc: Jonas Bonn <jonas@southpole.se>, openrisc@lists.librecores.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

When OpenRISC enables PCI it allows for more drivers to be compiled
resulting in exposing the following with -Werror.

    drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
    drivers/video/fbdev/riva/fbdev.c:2062:42: error:
	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

    drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
    drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

    drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
    drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

Most architectures define the iounmap argument to be volatile.  To fix this
issue we do the same for OpenRISC.  This patch must go before PCI is enabled on
OpenRISC to avoid any compile failures.

Link: https://lore.kernel.org/lkml/20220729033728.GA2195022@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/io.h | 2 +-
 arch/openrisc/mm/ioremap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 625ac6ad1205..ee6043a03173 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -31,7 +31,7 @@
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 
 #define iounmap iounmap
-extern void iounmap(void __iomem *addr);
+extern void iounmap(volatile void __iomem *addr);
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a76743..8ec0dafecf25 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void iounmap(void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	/* If the page is from the fixmap pool then we just clear out
 	 * the fixmap mapping.
-- 
2.37.1

