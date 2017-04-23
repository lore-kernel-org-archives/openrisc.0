From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:52 +0900
Subject: [OpenRISC] [PATCH v2 4/9] target/openrisc: add numcores and coreid
	support
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
References: <cover.1492986468.git.shorne@gmail.com>
Message-ID: <4d3ebb3092f5ac66a58357cee15bd5432e77f2fe.1492986468.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

These are used to identify the processor in SMP system.  Their
definition has been defined in verilog cores but it not yet part of the
spec but it will be soon.

The proposal for this is available:
  https://openrisc.io/proposals/core-identifier-and-number-of-cores

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 6ba8162..e13666b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -233,6 +233,12 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 64): /* ESR */
         return env->esr;
 
+    case TO_SPR(0, 128): /* COREID */
+        return 0;
+
+    case TO_SPR(0, 129): /* NUMCORES */
+        return 1;
+
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         return env->tlb->dtlb[0][idx].mr;
-- 
2.9.3

