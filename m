From: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 22 Jun 2018 10:01:26 -0700
Subject: [OpenRISC] [PATCH 5/5] irq: Remove MULTI_IRQ_HANDLER as it's now
	obselete
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Message-ID: <20180622170126.6308-6-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Now that every user of MULTI_IRQ_HANDLER has been convereted over to use
GENERIC_IRQ_MULTI_HANDLER we can remove the references to
MULTI_IRQ_HANDLER.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/irqchip/Kconfig | 24 ++++++++----------------
 kernel/irq/Kconfig      |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7527f6a9adae..d564d21245c5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,8 +8,7 @@ config ARM_GIC
 	bool
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,8 +34,7 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -68,8 +66,7 @@ config ARM_NVIC
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -96,16 +93,14 @@ config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -142,8 +137,7 @@ config DW_APB_ICTL
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -168,8 +162,7 @@ config CLPS711X_IRQCHIP
 	bool
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -188,8 +181,7 @@ config OMAP_IRQCHIP
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config PIC32_EVIC
 	bool
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index c6766f326072..5f3e2baefca9 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -134,7 +134,6 @@ config GENERIC_IRQ_DEBUGFS
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
-	depends on !MULTI_IRQ_HANDLER
 	bool
 	help
 	  Allow to specify the low level IRQ handler at run time.
-- 
2.16.4

