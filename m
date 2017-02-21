From: Stafford Horne <shorne@gmail.com>
Date: Wed, 22 Feb 2017 04:11:54 +0900
Subject: [OpenRISC] [PATCH v3 25/25] openrisc: head: Init r0 to 0 on start
In-Reply-To: <cover.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
Message-ID: <20913e0a776dda47da0d95e7769867636f180f90.1487702890.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Originally openrisc spec 0 specified that r0 would be wired to ground.
This is no longer the case.  r0 is not guaranteed to be 0 at init, so we
need to initialize it to 0 before using it.

Also, if we are clearing r0 we cant use r0 to clear itself. Change the
the CLEAR_GPR macro to use movhi for clearing.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 573e131..e8a1784 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -35,7 +35,7 @@
 	l.add	rd,rd,rs
 
 #define CLEAR_GPR(gpr)				\
-	l.or    gpr,r0,r0
+	l.movhi	gpr,0x0
 
 #define LOAD_SYMBOL_2_GPR(gpr,symbol)		\
 	l.movhi gpr,hi(symbol)			;\
@@ -443,6 +443,9 @@ _dispatch_do_ipage_fault:
 	__HEAD
 	.global _start
 _start:
+	/* Init r0 to zero as per spec */
+	CLEAR_GPR(r0)
+
 	/* save kernel parameters */
 	l.or	r25,r0,r3	/* pointer to fdt */
 
-- 
2.9.3

