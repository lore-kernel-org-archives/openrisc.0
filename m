From: Stafford Horne <shorne@gmail.com>
Date: Mon, 13 Sep 2021 21:47:57 +0900
Subject: [OpenRISC] [PATCH 2/5] gdb: or1k: fixup linux regcache comment
In-Reply-To: <20210913124800.471680-1-shorne@gmail.com>
References: <20210913124800.471680-1-shorne@gmail.com>
Message-ID: <20210913124800.471680-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The old comment was not properly updated from the RISC-V example used.
Update it to match OpenRISC.
---
 gdb/or1k-linux-tdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/gdb/or1k-linux-tdep.c b/gdb/or1k-linux-tdep.c
index 2ad55f0d9ec..2efb4d0b0f9 100644
--- a/gdb/or1k-linux-tdep.c
+++ b/gdb/or1k-linux-tdep.c
@@ -27,9 +27,10 @@
 #include "trad-frame.h"
 #include "gdbarch.h"
 
-/* Define the general register mapping.  The kernel puts the PC at offset 0,
-   gdb puts it at offset 32.  Register x0 is always 0 and can be ignored.
-   Registers x1 to x31 are in the same place.  */
+/* Define the general register mapping.  The kernel and GDB put registers
+   r1 to r31 in the same place.  The NPC register is stored at index 32 in
+   linux and 33 in GDB, in GDB 32 is for PPC which is not popupated from linux.
+   Register r0 is always 0 and can be ignored.  */
 
 static const struct regcache_map_entry or1k_linux_gregmap[] =
 {
-- 
2.31.1

