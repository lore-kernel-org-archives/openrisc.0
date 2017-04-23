From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:50 +0900
Subject: [OpenRISC] [PATCH v2 2/9] target/openrisc: Implement EPH bit
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
References: <cover.1492986468.git.shorne@gmail.com>
Message-ID: <3fee028d1ea02cd16470dc5c65d54974ef85b673.1492986468.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Tim 'mithro' Ansell <mithro@mithis.com>

Exception Prefix High (EPH) control bit of the Supervision Register
(SR).

The significant bits (31-12) of the vector offset address for each
exception depend on the setting of the Supervision Register (SR)'s EPH
bit and the Exception Vector Base Address Register (EVBAR).

If SR[EPH] is set, the vector offset is logically ORed with the offset
0xF0000000.

This means if EPH is;
 * 0 - Exceptions vectors start at EVBAR
 * 1 - Exception vectors start at EVBAR | 0xF0000000

Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 78f0ba9..2c91fab 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -69,6 +69,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         if (env->cpucfgr & CPUCFGR_EVBARP) {
             vect_pc |= env->evbar;
         }
+        if (env->sr & SR_EPH) {
+            vect_pc |= 0xf0000000;
+        }
         env->pc = vect_pc;
     } else {
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
-- 
2.9.3

