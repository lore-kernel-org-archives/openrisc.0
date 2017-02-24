From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:25 +0900
Subject: [OpenRISC] [PATCH v4 05/24] openrisc: head: refactor out tlb flush
	into it's own function
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <8c9b7db0de3d64c9a6fcd12622636d4aa6a8c30c.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

This brings it inline with the other setup oprations done like the cache
enables _ic_enable and _dc_enable.  Also, this is going to make it
easier to initialize additional cpu's when smp is introduced.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: Added commit body]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 63ba2d9..a22f1fc 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -522,22 +522,8 @@ enable_dc:
 	 l.nop
 
 flush_tlb:
-	/*
-	 *  I N V A L I D A T E   T L B   e n t r i e s
-	 */
-	LOAD_SYMBOL_2_GPR(r5,SPR_DTLBMR_BASE(0))
-	LOAD_SYMBOL_2_GPR(r6,SPR_ITLBMR_BASE(0))
-	l.addi	r7,r0,128 /* Maximum number of sets */
-1:
-	l.mtspr	r5,r0,0x0
-	l.mtspr	r6,r0,0x0
-
-	l.addi	r5,r5,1
-	l.addi	r6,r6,1
-	l.sfeq	r7,r0
-	l.bnf	1b
-	 l.addi	r7,r7,-1
-
+	l.jal	_flush_tlb
+	 l.nop
 
 /* The MMU needs to be enabled before or32_early_setup is called */
 
@@ -629,6 +615,26 @@ jump_start_kernel:
 	l.jr    r30
 	 l.nop
 
+_flush_tlb:
+	/*
+	 *  I N V A L I D A T E   T L B   e n t r i e s
+	 */
+	LOAD_SYMBOL_2_GPR(r5,SPR_DTLBMR_BASE(0))
+	LOAD_SYMBOL_2_GPR(r6,SPR_ITLBMR_BASE(0))
+	l.addi	r7,r0,128 /* Maximum number of sets */
+1:
+	l.mtspr	r5,r0,0x0
+	l.mtspr	r6,r0,0x0
+
+	l.addi	r5,r5,1
+	l.addi	r6,r6,1
+	l.sfeq	r7,r0
+	l.bnf	1b
+	 l.addi	r7,r7,-1
+
+	l.jr	r9
+	 l.nop
+
 /* ========================================[ cache ]=== */
 
 	/* aligment here so we don't change memory offsets with
-- 
2.9.3

