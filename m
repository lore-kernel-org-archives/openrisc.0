From: Stafford Horne <shorne@gmail.com>
Date: Fri,  2 Jul 2021 08:17:48 +0900
Subject: [OpenRISC] [PATCH] libgloss/or1k: Correct the IMMU SXE and UXE flags
Message-ID: <20210701231748.1098623-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

These have been defined incorrectly, as per specification and CPU
implementations SXE is bit 6 and UXE is bit 7.  This was noticed when
tracking down our test suite mmu test failures.

 Test Suite: https://github.com/openrisc/or1k-tests/blob/master/native/or1k/or1k-mmu.c#L68-L72
 Spec: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf

See section 8.4.8 Instruction Translation Lookaside Buffer Way y Translate
Registers where these are defined.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 libgloss/or1k/include/or1k-sprs.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/libgloss/or1k/include/or1k-sprs.h b/libgloss/or1k/include/or1k-sprs.h
index 8d1fe5ed9..d545fb1d3 100644
--- a/libgloss/or1k/include/or1k-sprs.h
+++ b/libgloss/or1k/include/or1k-sprs.h
@@ -1797,17 +1797,17 @@
 #define OR1K_SPR_IMMU_ITLBW_TR_D_GET(X) (((X) >> 5) & 0x1)
 #define OR1K_SPR_IMMU_ITLBW_TR_D_SET(X, Y) (((X) & OR1K_UNSIGNED(0xffffffdf)) | ((!!(Y)) << 5))
 
-/* User Execute Enable */
-#define OR1K_SPR_IMMU_ITLBW_TR_UXE_OFFSET 6
-#define OR1K_SPR_IMMU_ITLBW_TR_UXE_MASK   0x00000040
-#define OR1K_SPR_IMMU_ITLBW_TR_UXE_GET(X) (((X) >> 6) & 0x1)
-#define OR1K_SPR_IMMU_ITLBW_TR_UXE_SET(X, Y) (((X) & OR1K_UNSIGNED(0xffffffbf)) | ((!!(Y)) << 6))
-
 /* Supervisor Execute Enable */
-#define OR1K_SPR_IMMU_ITLBW_TR_SXE_OFFSET 7
-#define OR1K_SPR_IMMU_ITLBW_TR_SXE_MASK   0x00000080
-#define OR1K_SPR_IMMU_ITLBW_TR_SXE_GET(X) (((X) >> 7) & 0x1)
-#define OR1K_SPR_IMMU_ITLBW_TR_SXE_SET(X, Y) (((X) & OR1K_UNSIGNED(0xffffff7f)) | ((!!(Y)) << 7))
+#define OR1K_SPR_IMMU_ITLBW_TR_SXE_OFFSET 6
+#define OR1K_SPR_IMMU_ITLBW_TR_SXE_MASK   0x00000040
+#define OR1K_SPR_IMMU_ITLBW_TR_SXE_GET(X) (((X) >> 6) & 0x1)
+#define OR1K_SPR_IMMU_ITLBW_TR_SXE_SET(X, Y) (((X) & OR1K_UNSIGNED(0xffffffbf)) | ((!!(Y)) << 6))
+
+/* User Execute Enable */
+#define OR1K_SPR_IMMU_ITLBW_TR_UXE_OFFSET 7
+#define OR1K_SPR_IMMU_ITLBW_TR_UXE_MASK   0x00000080
+#define OR1K_SPR_IMMU_ITLBW_TR_UXE_GET(X) (((X) >> 7) & 0x1)
+#define OR1K_SPR_IMMU_ITLBW_TR_UXE_SET(X, Y) (((X) & OR1K_UNSIGNED(0xffffff7f)) | ((!!(Y)) << 7))
 
 /* Physical Page Number */
 #define OR1K_SPR_IMMU_ITLBW_TR_PPN_LSB    13
-- 
2.31.1

