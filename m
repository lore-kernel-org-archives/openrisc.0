From: Stafford Horne <shorne@gmail.com>
Date: Fri, 17 Mar 2017 14:18:39 +0900
Subject: [OpenRISC] [PATCH] cpu: or1k: Set ppc on pc change
Message-ID: <20170317051839.31241-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Currently the openrisc previous program counter (ppc) is never updated
when running the cgen based simulator.  This causes issues when running
the single step delay detection code in gdb.

cpu/ChangeLog:

2017-02-12  Stafford Horne  <shorne@gmail.com>

	* or1kcommon.cpu: Add pc set semantics to also update ppc.
---
Note I dont think any code needs rebuilding as this is only going to be
used by the simulator (not yet upstream).

 cpu/or1kcommon.cpu | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cpu/or1kcommon.cpu b/cpu/or1kcommon.cpu
index 1119f98..ced70c3 100644
--- a/cpu/or1kcommon.cpu
+++ b/cpu/or1kcommon.cpu
@@ -26,6 +26,11 @@
   (comment "program counter")
   (attrs PC (MACH ORBIS-MACHS))
   (type pc UWI)
+  (get () (raw-reg h-pc))
+  (set (newval) (sequence ()
+                 (set (reg h-sys-ppc) (raw-reg h-pc))
+                 (set (raw-reg h-pc) newval)
+                ))
   )
 
 (define-pmacro REG-INDICES
-- 
2.9.3

