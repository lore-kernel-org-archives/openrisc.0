From: Stafford Horne <shorne@gmail.com>
Date: Thu, 14 Jan 2021 08:50:30 +0900
Subject: [OpenRISC] [PATCH v2 3/5] or1k: Support for softfloat to emulate hw
 exceptions
In-Reply-To: <20210113235032.2821155-1-shorne@gmail.com>
References: <20210113235032.2821155-1-shorne@gmail.com>
Message-ID: <20210113235032.2821155-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This allows the openrisc softfloat implementation to set exceptions.
This also sets the correct tininess after rounding value to be
consistent with hardware and simulator implementations.

libgcc/ChangeLog:

	* config/or1k/sfp-machine.h (FP_RND_NEAREST, FP_RND_ZERO,
	FP_RND_PINF, FP_RND_MINF, FP_RND_MASK, FP_EX_OVERFLOW,
	FP_EX_UNDERFLOW, FP_EX_INEXACT, FP_EX_INVALID, FP_EX_DIVZERO,
	FP_EX_ALL): New constant macros.
	(_FP_DECL_EX, FP_ROUNDMODE, FP_INIT_ROUNDMODE,
	FP_HANDLE_EXCEPTIONS): New macros.
	(_FP_TININESS_AFTER_ROUNDING): Change to 1.
---
 libgcc/config/or1k/sfp-machine.h | 41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/libgcc/config/or1k/sfp-machine.h b/libgcc/config/or1k/sfp-machine.h
index 5da9e84990d..eebe5b0578e 100644
--- a/libgcc/config/or1k/sfp-machine.h
+++ b/libgcc/config/or1k/sfp-machine.h
@@ -41,12 +41,51 @@
     R##_c = FP_CLS_NAN;						\
   } while (0)
 
+/* Handle getting and setting rounding mode for soft fp operations.  */
+
+#define FP_RND_NEAREST		(0x0 << 1)
+#define FP_RND_ZERO		(0x1 << 1)
+#define FP_RND_PINF		(0x2 << 1)
+#define FP_RND_MINF		(0x3 << 1)
+#define FP_RND_MASK		(0x3 << 1)
+
+#define FP_EX_OVERFLOW		1 << 3
+#define FP_EX_UNDERFLOW		1 << 4
+#define FP_EX_INEXACT		1 << 8
+#define FP_EX_INVALID		1 << 9
+#define FP_EX_DIVZERO		1 << 11
+#define FP_EX_ALL \
+	(FP_EX_INVALID | FP_EX_DIVZERO | FP_EX_OVERFLOW | FP_EX_UNDERFLOW \
+	 | FP_EX_INEXACT)
+
+#define _FP_DECL_EX \
+  unsigned int _fpcsr __attribute__ ((unused)) = FP_RND_NEAREST
+
+#define FP_ROUNDMODE (_fpcsr & FP_RND_MASK)
+
+#ifdef __or1k_hard_float__
+#define FP_INIT_ROUNDMODE					\
+do {								\
+  __asm__ volatile ("l.mfspr %0,r0,20" : "=r" (_fpcsr));	\
+} while (0)
+
+#define FP_HANDLE_EXCEPTIONS					\
+do {								\
+  if (__builtin_expect (_fex, 0))				\
+    {								\
+      _fpcsr &= ~FP_EX_ALL;					\
+      _fpcsr |= _fex;						\
+      __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (_fpcsr));	\
+    }								\
+} while (0)
+#endif
+
 #define	__LITTLE_ENDIAN	1234
 #define	__BIG_ENDIAN	4321
 
 #define __BYTE_ORDER __BIG_ENDIAN
 
-#define _FP_TININESS_AFTER_ROUNDING 0
+#define _FP_TININESS_AFTER_ROUNDING 1
 
 /* Define ALIASNAME as a strong alias for NAME.  */
 # define strong_alias(name, aliasname) _strong_alias(name, aliasname)
-- 
2.26.2

