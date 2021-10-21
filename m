From: Stafford Horne <shorne@gmail.com>
Date: Thu, 21 Oct 2021 22:18:59 +0900
Subject: [OpenRISC] [PATCH] or1k: Update FPU to specify detect tininess
 before rounding
Message-ID: <20211021131859.1065675-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This was not defined in the spec and not consistent in the
implementation causing incosistent behavior.  After review we have
updated the CPU implementations and proposed the spec be updated to
specific that FPU tininess checks check for tininess before roudning.

Architecture change draft:

	https://openrisc.io/proposals/p18-fpu-tininess

libgcc/ChangeLog:

	* config/or1k/sfp-machine.h (_FP_TININESS_AFTER_ROUNDING):
	Change to 0.
---
 libgcc/config/or1k/sfp-machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libgcc/config/or1k/sfp-machine.h b/libgcc/config/or1k/sfp-machine.h
index eebe5b0578e..162c6bc5326 100644
--- a/libgcc/config/or1k/sfp-machine.h
+++ b/libgcc/config/or1k/sfp-machine.h
@@ -85,7 +85,7 @@ do {								\
 
 #define __BYTE_ORDER __BIG_ENDIAN
 
-#define _FP_TININESS_AFTER_ROUNDING 1
+#define _FP_TININESS_AFTER_ROUNDING 0
 
 /* Define ALIASNAME as a strong alias for NAME.  */
 # define strong_alias(name, aliasname) _strong_alias(name, aliasname)
-- 
2.31.1

