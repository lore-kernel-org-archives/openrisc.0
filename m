From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:34 +0900
Subject: [OpenRISC] [PATCH 08/18] gdb: or1k: change or1k_push_dummy_code
	stack alignment
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-9-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

gdb/ChangeLog
	* or1k-tdep.c (or1k_push_dummy_code) : Use or1k_frame_align to
	align the stack pointer.
---
 gdb/or1k-tdep.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index cb0871f..81bb541 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -1173,10 +1173,14 @@ or1k_push_dummy_code (struct gdbarch *gdbarch,
 		      CORE_ADDR *bp_addr,
 		      struct regcache *regcache)
 {
-  /* Allocate space sufficient for a breakpoint, keeping the stack aligned.  */
-  sp = (sp - 4) & ~15;
+  CORE_ADDR bp_slot;
+
+  /* Reserve enough room on the stack for our breakpoint instruction.  */
+  bp_slot = sp - 4;
   /* Store the address of that breakpoint */
-  *bp_addr = sp;
+  *bp_addr = bp_slot;
+  /* keeping the stack aligned.  */
+  sp = or1k_frame_align (gdbarch, bp_slot);
   /* The call starts at the callee's entry point.  */
   *real_pc = function;
 
-- 
2.7.4


