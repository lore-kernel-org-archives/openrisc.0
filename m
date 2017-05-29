From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 May 2017 23:55:34 +0900
Subject: [OpenRISC] [PATCH] openrisc: Switch to use export.h instead of
	module.h
Message-ID: <20170529145537.15200-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Reduce dependencies on module.h since all we need here is export.h
for EXPORT_SYMBOL.

Fixes: f50169324df4 ("module.h: split out the EXPORT_SYMBOL into export.h")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/or32_ksyms.c | 2 +-
 arch/openrisc/kernel/process.c    | 2 +-
 arch/openrisc/lib/delay.c         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index ee3e604..d7260fd 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -15,7 +15,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/elfcore.h>
 #include <linux/sched.h>
 #include <linux/in6.h>
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index f8da545..98318ac 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -26,7 +26,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
diff --git a/arch/openrisc/lib/delay.c b/arch/openrisc/lib/delay.c
index c82b09f..8b13fdf 100644
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -16,8 +16,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
+#include <asm/param.h>
 #include <asm/delay.h>
 #include <asm/timex.h>
 #include <asm/processor.h>
-- 
2.9.4

