From: Stafford Horne <shorne@gmail.com>
Date: Tue, 11 Jan 2022 12:00:54 +0900
Subject: [OpenRISC] [PATCH] openrisc: init: Add support for common clk
Message-ID: <20220111030055.2043568-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

When testing the new litex_mmc driver it was found to not work on
OpenRISC due to missing support for common clk.  This patch does the
basic initialization to allow OpenRISC to use the common clk framework.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig       | 1 +
 arch/openrisc/kernel/time.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index c2491b295d60..f724b3f1aeed 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,6 +10,7 @@ config OPENRISC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select COMMON_CLK
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index a6e69386f82a..6d18989d63d0 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -20,6 +20,7 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of_clk.h>
 
 #include <asm/cpuinfo.h>
 
@@ -169,4 +170,7 @@ void __init time_init(void)
 
 	openrisc_timer_init();
 	openrisc_clockevent_init();
+
+	of_clk_init(NULL);
+	timer_probe();
 }
-- 
2.31.1

