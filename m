From: Tobias Klauser <tklauser@distanz.ch>
Date: Mon, 15 May 2017 12:14:51 +0200
Subject: [OpenRISC] [PATCH] openrisc: explicitly include linux/bug.h in
	asm/fixmap.h
Message-ID: <20170515101451.27973-1-tklauser@distanz.ch>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

openrisc's asm/fixmap.h uses the BUG() and BUG_ON() macros but relies on
implict inclusion of linux/bug.h which means that changes in other
headers could break the build. Thus, add an explicit include.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/openrisc/include/asm/fixmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
index 52733416c1f3..5a0159546f9e 100644
--- a/arch/openrisc/include/asm/fixmap.h
+++ b/arch/openrisc/include/asm/fixmap.h
@@ -27,6 +27,7 @@
 #define FIXADDR_TOP	((unsigned long) (-2*PAGE_SIZE))
 
 #include <linux/kernel.h>
+#include <linux/bug.h>
 #include <asm/page.h>
 
 /*
-- 
2.13.0


