From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:08:01 +0900
Subject: [OpenRISC] [PATCH 04/22] openrisc: head: use THREAD_SIZE instead of
	magic constant
In-Reply-To: <cover.1484432596.git.shorne@gmail.com>
References: <cover.1484432596.git.shorne@gmail.com>
Message-ID: <70c8d993b2b3c7cd6188cf2405004e065db3be59.1484432596.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

The stack size was hard coded to 0x2000, use the standard THREAD_SIZE
definition loaded from thread_info.h.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: Added body to the commit message]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 2346c5b..63ba2d9 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -24,6 +24,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
+#include <asm/thread_info.h>
 #include <asm/cache.h>
 #include <asm/spr_defs.h>
 #include <asm/asm-offsets.h>
@@ -486,7 +487,8 @@ _start:
 	/*
 	 * set up initial ksp and current
 	 */
-	LOAD_SYMBOL_2_GPR(r1,init_thread_union+0x2000)	// setup kernel stack
+	/* setup kernel stack */
+	LOAD_SYMBOL_2_GPR(r1,init_thread_union + THREAD_SIZE)
 	LOAD_SYMBOL_2_GPR(r10,init_thread_union)	// setup current
 	tophys	(r31,r10)
 	l.sw	TI_KSP(r31), r1
-- 
2.9.3

