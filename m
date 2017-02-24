From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:32 +0900
Subject: [OpenRISC] [PATCH v4 12/24] openrisc: Fix the bitmask for the unit
	present register
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <4812c836e956dbc7e10b15d6dcce2f2a2aff4748.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Sebastian Macke <sebastian@macke.de>

The bits were swapped, as per spec and processor implementation the
power management present bit is 9 and PIC bit is 8. This patch brings
the definitions into spec.

Signed-off-by: Sebastian Macke <sebastian@macke.de>
[shorne at gmail.com: Added commit body]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/spr_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/spr_defs.h b/arch/openrisc/include/asm/spr_defs.h
index 5dbc668..367dac7 100644
--- a/arch/openrisc/include/asm/spr_defs.h
+++ b/arch/openrisc/include/asm/spr_defs.h
@@ -152,8 +152,8 @@
 #define SPR_UPR_MP	   0x00000020  /* MAC present */
 #define SPR_UPR_DUP	   0x00000040  /* Debug unit present */
 #define SPR_UPR_PCUP	   0x00000080  /* Performance counters unit present */
-#define SPR_UPR_PMP	   0x00000100  /* Power management present */
-#define SPR_UPR_PICP	   0x00000200  /* PIC present */
+#define SPR_UPR_PICP	   0x00000100  /* PIC present */
+#define SPR_UPR_PMP	   0x00000200  /* Power management present */
 #define SPR_UPR_TTP	   0x00000400  /* Tick timer present */
 #define SPR_UPR_RES	   0x00fe0000  /* Reserved */
 #define SPR_UPR_CUP	   0xff000000  /* Context units present */
-- 
2.9.3

