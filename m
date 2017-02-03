From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Feb 2017 00:48:38 +0900
Subject: [OpenRISC] [PATCH v2 14/23] openrisc: Initial support for the idle
	state
In-Reply-To: <cover.1486135912.git.shorne@gmail.com>
References: <cover.1486135912.git.shorne@gmail.com>
Message-ID: <65ff301d6ac85d035829285d5a87bc1c095f455e.1486135912.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Sebastian Macke <sebastian@macke.de>

This patch adds basic support for the idle state of the cpu.
The patch overrides the regular idle function, enables the interupts,
checks for the power management unit and enables the cpu doze mode
if available.

Signed-off-by: Sebastian Macke <sebastian@macke.de>
[shorne at gmail.com: Fixed checkpatch, blankline after declarations]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index c49350b..ffde77f 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -75,6 +75,20 @@ void machine_power_off(void)
 	__asm__("l.nop 1");
 }
 
+/*
+ * Send the doze signal to the cpu if available.
+ * Make sure, that all interrupts are enabled
+ */
+void arch_cpu_idle(void)
+{
+	unsigned long upr;
+
+	local_irq_enable();
+	upr = mfspr(SPR_UPR);
+	if (upr & SPR_UPR_PMP)
+		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
+}
+
 void (*pm_power_off) (void) = machine_power_off;
 
 /*
-- 
2.9.3

