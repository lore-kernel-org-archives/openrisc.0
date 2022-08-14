Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B4DC3F6B0
	for <openrisc@archiver.kernel.org>; Sun, 14 Aug 2022 15:32:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C58E224997;
	Sun, 14 Aug 2022 17:32:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id A5DE520AC2
 for <openrisc@lists.librecores.org>; Sun, 14 Aug 2022 17:32:35 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE7D60C41;
 Sun, 14 Aug 2022 15:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219B4C433C1;
 Sun, 14 Aug 2022 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660491154;
 bh=TmwB1yyIO7hlQxEEZ3YP1Hse/khGDr1TusJ9UJG8jgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T8qgupMX/EiiIo3lPB08xcTlg9JwBYVg2JbJ/4pUssg24CO9zRea/AfjFliqUcyLI
 7KkTGoG2ciJHzL43K1v9usd2bRrdPVRAXd/MWi67L0gYWLoauPbLr7JCuO3ao80Zwm
 oZQbGP9kjYxs7SacX77UynDSyiqveGivhNYY7V6j+Ecs46IRqW77zk4vwSNbSHF9Ey
 cA8cuZXQkpnWSkIoyaBO/Dxxk9+DLA+bnAJSnloQg9/pd5Bi0Cj0N8D8fXaDBSDoD0
 +ttUfqL/9LkY+Hd5HMffUvnF3IrHzUfCvlvGpxhuVWD+8PwT4G93NVDnKa9OdbNBsN
 taG/RpGOS/01Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 48/56] openrisc: io: Define iounmap argument as
 volatile
Date: Sun, 14 Aug 2022 11:30:18 -0400
Message-Id: <20220814153026.2377377-48-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814153026.2377377-1-sashal@kernel.org>
References: <20220814153026.2377377-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, jonas@southpole.se,
 openrisc@lists.librecores.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit 52e0ea900202d23843daee8f7089817e81dd3dd7 ]

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
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/include/asm/io.h | 2 +-
 arch/openrisc/mm/ioremap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index c298061c70a7..8aa3e78181e9 100644
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
2.35.1

