From: Stafford Horne <shorne@gmail.com>
Date: Sun, 12 Feb 2017 21:33:50 +0900
Subject: [OpenRISC] [PATCH 1/2] cpu: or1k: Set ppc on pc change
In-Reply-To: <cover.1486902449.git.shorne@gmail.com>
References: <cover.1486902449.git.shorne@gmail.com>
Message-ID: <f524408139239b4ed10d55444a4f01b665568e2f.1486902449.git.shorne@gmail.com>
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

