From: Stafford Horne <shorne@gmail.com>
Date: Thu,  5 Aug 2021 12:00:33 +0900
Subject: [OpenRISC] [PATCH] openrisc: Fix compiler warnings in setup
Message-ID: <20210805030035.2994973-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This was pointed out with the recent name change of or32_early_setup to
or1k_early_setup.  Investigating the file I found a few other warnings
so cleaning them up here.

    arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
      220 | void __init or1k_early_setup(void *fdt)
	  |             ^~~~~~~~~~~~~~~~

Fix this the missing or1k_early_setup prototype warning by adding an
asm/setup.h file to define the prototype.

    arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
      246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
	  |             ^~~~~~~~~~~~~~~~~~

The function detect_unit_config is not used, just remove it.

    arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'

Add @fdt docs to the function comment to suppress this warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/setup.h | 14 ++++++++++++++
 arch/openrisc/kernel/setup.c      | 16 +---------------
 2 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 arch/openrisc/include/asm/setup.h

diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
new file mode 100644
index 000000000000..b6d096eeb11c
--- /dev/null
+++ b/arch/openrisc/include/asm/setup.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Stafford Horne
+ */
+#ifndef _ASM_OR1K_SETUP_H
+#define _ASM_OR1K_SETUP_H
+
+#include <asm-generic/setup.h>
+
+#ifndef __ASSEMBLY__
+void __init or1k_early_setup(void *fdt);
+#endif
+
+#endif /* _ASM_OR1K_SETUP_H */
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 7eddcac0ef2f..0cd04d936a7a 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -210,6 +210,7 @@ void __init setup_cpuinfo(void)
 
 /**
  * or1k_early_setup
+ * @fdt: pointer to the start of the device tree in memory or NULL
  *
  * Handles the pointer to the device tree that this kernel is to use
  * for establishing the available platform devices.
@@ -243,21 +244,6 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
 	return mask & reg;
 }
 
-void __init detect_unit_config(unsigned long upr, unsigned long mask,
-			       char *text, void (*func) (void))
-{
-	if (text != NULL)
-		printk("%s", text);
-
-	if (upr & mask) {
-		if (func != NULL)
-			func();
-		else
-			printk("present\n");
-	} else
-		printk("not present\n");
-}
-
 /*
  * calibrate_delay
  *
-- 
2.31.1

