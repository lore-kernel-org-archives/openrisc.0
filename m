From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Mar 2021 22:50:23 +0900
Subject: [OpenRISC] [PATCH 1/4] openrisc: Use movhi to zero registers
In-Reply-To: <20210303135026.3450789-1-shorne@gmail.com>
References: <20210303135026.3450789-1-shorne@gmail.com>
Message-ID: <20210303135026.3450789-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is needed when running on FPGA as registers are not guaranteed
to be initialized to 0.  Using movhi allows to explicitly set 0.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/cpu/start.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/cpu/start.S b/arch/openrisc/cpu/start.S
index 7ac790b05..c448d3775 100644
--- a/arch/openrisc/cpu/start.S
+++ b/arch/openrisc/cpu/start.S
@@ -37,10 +37,10 @@
 	.org	0x100
 __reset:
 	/* there is no guarantee r0 is hardwired to zero, clear it here */
-	l.andi	r0, r0, 0
+	l.movhi	r0, 0x0
 	/* reset stack and frame pointers */
-	l.andi	r1, r0, 0
-	l.andi	r2, r0, 0
+	l.movhi	r1, 0x0
+	l.movhi	r2, 0x0
 
 	/* set supervisor mode */
 	l.ori	r3,r0,SPR_SR_SM
-- 
2.26.2

