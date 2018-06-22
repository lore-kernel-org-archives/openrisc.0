From: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 22 Jun 2018 10:01:22 -0700
Subject: [OpenRISC] [PATCH 1/5] irq: Port the ARM IRQ drivers to
	GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Message-ID: <20180622170126.6308-2-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

GENERIC_IRQ_MULTI_HANDLER is incompatible with MULTI_IRQ_HANDLER because
they define the same symbols.  Multiple generic irqchip drivers select
MULTI_IRQ_HANDLER, which is now defined on all architectures that
provide set_handle_irq().  This patch selects GENERIC_IRQ_MULTI_HANDLER
for all drivers that used to select MULTI_IRQ_HANDLER, but only when
MULTI_IRQ_HANDLER doesn't exist.  I'll then convert every architecture
over from MULTI_IRQ_HANDLER to GENERIC_IRQ_MULTI_HANDLER before removing
the extra MULTI_IRQ_HANDLER scaffolding.

CC: Shea Levy <shea@shealevy.com>
CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/irqchip/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..7527f6a9adae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -9,6 +9,7 @@ config ARM_GIC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,6 +36,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -67,6 +69,7 @@ config ARM_VIC
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -94,6 +97,7 @@ config ATMEL_AIC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
@@ -101,6 +105,7 @@ config ATMEL_AIC5_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -138,6 +143,7 @@ config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -163,6 +169,7 @@ config CLPS711X_IRQCHIP
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -182,6 +189,7 @@ config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config PIC32_EVIC
 	bool
-- 
2.16.4

