From: Stafford Horne <shorne@gmail.com>
Date: Tue,  4 Aug 2020 13:23:49 +0900
Subject: [OpenRISC] [PATCH 1/6] openrisc: io: Fixup defines and move include
 to the end
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
Message-ID: <20200804042354.3930694-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This didn't seem to cause any issues, but while working on fixing up
sparse annotations for OpenRISC I noticed this.  This patch moves the
include of asm-generic/io.h to the end of the file.  Also, we add
defines of ioremap and iounmap, that way we don't get duplicate
definitions from asm-generic/io.h.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/io.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index db02fb2077d9..ef985540b674 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -25,9 +25,12 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#include <asm-generic/io.h>
-
+#define ioremap ioremap
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+
+#define iounmap iounmap
 extern void iounmap(void *addr);
 
+#include <asm-generic/io.h>
+
 #endif
-- 
2.26.2

