From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:36 +0900
Subject: [OpenRISC] [PATCH v2 6/9] openrisc: remove the redundant
	of_platform_populate
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <8229b02de46da492810331e374cf2a3f8731e2bb.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Rob Herring <robh@kernel.org>

The of_platform_populate call in the openrisc arch code is now redundant
as the DT core provides a default call. Openrisc has a NULL match table
which means only top level nodes with compatible strings will have
devices creates. The default version will also descend nodes in the
match table such as "simple-bus" which should be fine as openrisc
doesn't have any of these (though it is preferred that memory-mapped
peripherals be grouped under a bus node(s)).

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/setup.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index b4ed8b3..d2f78cf 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -38,7 +38,6 @@
 #include <linux/of.h>
 #include <linux/memblock.h>
 #include <linux/device.h>
-#include <linux/of_platform.h>
 
 #include <asm/sections.h>
 #include <asm/segment.h>
@@ -219,15 +218,6 @@ void __init or32_early_setup(void *fdt)
 	early_init_devtree(fdt);
 }
 
-static int __init openrisc_device_probe(void)
-{
-	of_platform_populate(NULL, NULL, NULL, NULL);
-
-	return 0;
-}
-
-device_initcall(openrisc_device_probe);
-
 static inline unsigned long extract_value_bits(unsigned long reg,
 					       short bit_nr, short width)
 {
-- 
2.7.4


