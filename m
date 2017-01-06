From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri,  6 Jan 2017 10:43:55 +0100
Subject: [OpenRISC] [PATCH v2 3/7] nios2: put setup.h in uapi
In-Reply-To: <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <1483695839-18660-4-git-send-email-nicolas.dichtel@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This header file is exported, thus move it to uapi.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 arch/nios2/include/asm/setup.h      | 2 +-
 arch/nios2/include/uapi/asm/setup.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 arch/nios2/include/uapi/asm/setup.h

diff --git a/arch/nios2/include/asm/setup.h b/arch/nios2/include/asm/setup.h
index dcbf8cf1a344..d49e9e91bf55 100644
--- a/arch/nios2/include/asm/setup.h
+++ b/arch/nios2/include/asm/setup.h
@@ -19,7 +19,7 @@
 #ifndef _ASM_NIOS2_SETUP_H
 #define _ASM_NIOS2_SETUP_H
 
-#include <asm-generic/setup.h>
+#include <uapi/asm/setup.h>
 
 #ifndef __ASSEMBLY__
 #ifdef __KERNEL__
diff --git a/arch/nios2/include/uapi/asm/setup.h b/arch/nios2/include/uapi/asm/setup.h
new file mode 100644
index 000000000000..8d8285997ba8
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/setup.h
@@ -0,0 +1,6 @@
+#ifndef _UAPI_ASM_NIOS2_SETUP_H
+#define _UAPI_ASM_NIOS2_SETUP_H
+
+#include <asm-generic/setup.h>
+
+#endif /* _UAPI_ASM_NIOS2_SETUP_H */
-- 
2.8.1

