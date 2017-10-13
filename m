From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 22:49:27 +0900
Subject: [OpenRISC] [PATCH v2 2/5] target/openrisc: Make coreid and numcores
	variable
In-Reply-To: <20171013134930.32547-1-shorne@gmail.com>
References: <20171013134930.32547-1-shorne@gmail.com>
Message-ID: <20171013134930.32547-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Previously coreid and numcores were hard coded as 0 and 1 respectively
as OpenRISC QEMU did not have multicore support.

Multicore support is now being added so these registers need to have
configured values.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index abdef5d6a5..dc6e5cc7f2 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
+#include "sysemu/sysemu.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
@@ -249,10 +250,10 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->esr;
 
     case TO_SPR(0, 128): /* COREID */
-        return 0;
+        return cpu->parent_obj.cpu_index;
 
     case TO_SPR(0, 129): /* NUMCORES */
-        return 1;
+        return max_cpus;
 
     case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
         idx = (spr - 1024);
-- 
2.13.6

