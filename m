From: Aaron Wu <aaron.wu@analog.com>
Date: Thu, 15 Mar 2018 18:50:28 +0800
Subject: [OpenRISC] [Blackfin removal] [PATCH 28/28] MAINTAINERS: Remove
	Blackfin from MAINTAINERS list
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
Message-ID: <1521111028-19856-28-git-send-email-aaron.wu@analog.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin from MAINTAINERS list
---
 MAINTAINERS | 52 ----------------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf..f5a0857 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,13 +841,6 @@ F:	sound/soc/codecs/ad7*
 F:	sound/soc/codecs/ssm*
 F:	sound/soc/codecs/sigmadsp.*
 
-ANALOG DEVICES INC ASOC DRIVERS
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Supported
-F:	sound/soc/blackfin/*
-
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -2629,51 +2622,6 @@ F:	Documentation/filesystems/bfs.txt
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
-BLACKFIN ARCHITECTURE
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-T:	git git://git.code.sf.net/p/adi-linux/code
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	arch/blackfin/
-
-BLACKFIN EMAC DRIVER
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/net/ethernet/adi/
-
-BLACKFIN MEDIA DRIVER
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Orphan
-F:	drivers/media/platform/blackfin/
-F:	drivers/media/i2c/adv7183*
-F:	drivers/media/i2c/vs6624*
-
-BLACKFIN RTC DRIVER
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/rtc/rtc-bfin.c
-
-BLACKFIN SDH DRIVER
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/mmc/host/bfin_sdh.c
-
-BLACKFIN SERIAL DRIVER
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/tty/serial/bfin_uart.c
-
-BLACKFIN WATCHDOG DRIVER
-L:	adi-buildroot-devel at lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/watchdog/bfin_wdt.c
-
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
-- 
2.7.4

