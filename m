From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 13 Jan 2017 11:46:39 +0100
Subject: [OpenRISC] [PATCH v3 1/8] arm: put types.h in uapi
In-Reply-To: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
References: <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This header file is exported, thus move it to uapi.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 arch/arm/include/asm/types.h      | 40 ---------------------------------------
 arch/arm/include/uapi/asm/types.h | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 40 deletions(-)
 delete mode 100644 arch/arm/include/asm/types.h
 create mode 100644 arch/arm/include/uapi/asm/types.h

diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
deleted file mode 100644
index a53cdb8f068c..000000000000
--- a/arch/arm/include/asm/types.h
+++ /dev/null
@@ -1,40 +0,0 @@
-#ifndef _ASM_TYPES_H
-#define _ASM_TYPES_H
-
-#include <asm-generic/int-ll64.h>
-
-/*
- * The C99 types uintXX_t that are usually defined in 'stdint.h' are not as
- * unambiguous on ARM as you would expect. For the types below, there is a
- * difference on ARM between GCC built for bare metal ARM, GCC built for glibc
- * and the kernel itself, which results in build errors if you try to build with
- * -ffreestanding and include 'stdint.h' (such as when you include 'arm_neon.h'
- * in order to use NEON intrinsics)
- *
- * As the typedefs for these types in 'stdint.h' are based on builtin defines
- * supplied by GCC, we can tweak these to align with the kernel's idea of those
- * types, so 'linux/types.h' and 'stdint.h' can be safely included from the same
- * source file (provided that -ffreestanding is used).
- *
- *                    int32_t         uint32_t               uintptr_t
- * bare metal GCC     long            unsigned long          unsigned int
- * glibc GCC          int             unsigned int           unsigned int
- * kernel             int             unsigned int           unsigned long
- */
-
-#ifdef __INT32_TYPE__
-#undef __INT32_TYPE__
-#define __INT32_TYPE__		int
-#endif
-
-#ifdef __UINT32_TYPE__
-#undef __UINT32_TYPE__
-#define __UINT32_TYPE__	unsigned int
-#endif
-
-#ifdef __UINTPTR_TYPE__
-#undef __UINTPTR_TYPE__
-#define __UINTPTR_TYPE__	unsigned long
-#endif
-
-#endif /* _ASM_TYPES_H */
diff --git a/arch/arm/include/uapi/asm/types.h b/arch/arm/include/uapi/asm/types.h
new file mode 100644
index 000000000000..9435a42f575e
--- /dev/null
+++ b/arch/arm/include/uapi/asm/types.h
@@ -0,0 +1,40 @@
+#ifndef _UAPI_ASM_TYPES_H
+#define _UAPI_ASM_TYPES_H
+
+#include <asm-generic/int-ll64.h>
+
+/*
+ * The C99 types uintXX_t that are usually defined in 'stdint.h' are not as
+ * unambiguous on ARM as you would expect. For the types below, there is a
+ * difference on ARM between GCC built for bare metal ARM, GCC built for glibc
+ * and the kernel itself, which results in build errors if you try to build with
+ * -ffreestanding and include 'stdint.h' (such as when you include 'arm_neon.h'
+ * in order to use NEON intrinsics)
+ *
+ * As the typedefs for these types in 'stdint.h' are based on builtin defines
+ * supplied by GCC, we can tweak these to align with the kernel's idea of those
+ * types, so 'linux/types.h' and 'stdint.h' can be safely included from the same
+ * source file (provided that -ffreestanding is used).
+ *
+ *                    int32_t         uint32_t               uintptr_t
+ * bare metal GCC     long            unsigned long          unsigned int
+ * glibc GCC          int             unsigned int           unsigned int
+ * kernel             int             unsigned int           unsigned long
+ */
+
+#ifdef __INT32_TYPE__
+#undef __INT32_TYPE__
+#define __INT32_TYPE__		int
+#endif
+
+#ifdef __UINT32_TYPE__
+#undef __UINT32_TYPE__
+#define __UINT32_TYPE__	unsigned int
+#endif
+
+#ifdef __UINTPTR_TYPE__
+#undef __UINTPTR_TYPE__
+#define __UINTPTR_TYPE__	unsigned long
+#endif
+
+#endif /* _UAPI_ASM_TYPES_H */
-- 
2.8.1

