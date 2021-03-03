From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Mar 2021 22:50:25 +0900
Subject: [OpenRISC] [PATCH 3/4] openrisc: Add linkage.h
In-Reply-To: <20210303135026.3450789-1-shorne@gmail.com>
References: <20210303135026.3450789-1-shorne@gmail.com>
Message-ID: <20210303135026.3450789-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Copied from glibc minus bits we don't need.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/linkage.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/openrisc/include/asm/linkage.h

diff --git a/arch/openrisc/include/asm/linkage.h b/arch/openrisc/include/asm/linkage.h
new file mode 100644
index 000000000..dbe4b4e31
--- /dev/null
+++ b/arch/openrisc/include/asm/linkage.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define __ALIGN .align 0
+#define __ALIGN_STR ".align 0"
+
+#endif
-- 
2.26.2

