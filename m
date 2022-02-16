From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 16 Feb 2022 14:13:23 +0100
Subject: [OpenRISC] [PATCH v2 09/18] mips: use simpler access_ok()
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Message-ID: <20220216131332.1489939-10-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

Before unifying the mips version of __access_ok() with the generic
code, this converts it to the same algorithm. This is a change in
behavior on mips64, as now address in the user segment, the lower
2^62 bytes, is taken to be valid, relying on a page fault for
addresses that are within that segment but not valid on that CPU.

The new version should be the most effecient way to do this, but
it gets rid of the special handling for size=0 that most other
architectures ignore as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/uaccess.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index db9a8e002b62..d7c89dc3426c 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -19,6 +19,7 @@
 #ifdef CONFIG_32BIT
 
 #define __UA_LIMIT 0x80000000UL
+#define TASK_SIZE_MAX	__UA_LIMIT
 
 #define __UA_ADDR	".word"
 #define __UA_LA		"la"
@@ -33,6 +34,7 @@
 extern u64 __ua_limit;
 
 #define __UA_LIMIT	__ua_limit
+#define TASK_SIZE_MAX	XKSSEG
 
 #define __UA_ADDR	".dword"
 #define __UA_LA		"dla"
@@ -42,22 +44,6 @@ extern u64 __ua_limit;
 
 #endif /* CONFIG_64BIT */
 
-/*
- * Is a address valid? This does a straightforward calculation rather
- * than tests.
- *
- * Address valid if:
- *  - "addr" doesn't have any high-bits set
- *  - AND "size" doesn't have any high-bits set
- *  - AND "addr+size" doesn't have any high-bits set
- *  - OR we are in kernel mode.
- *
- * __ua_size() is a trick to avoid runtime checking of positive constant
- * sizes; for those we already know at compile time that the size is ok.
- */
-#define __ua_size(size)							\
-	((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
-
 /*
  * access_ok: - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -79,9 +65,9 @@ extern u64 __ua_limit;
 static inline int __access_ok(const void __user *p, unsigned long size)
 {
 	unsigned long addr = (unsigned long)p;
-	unsigned long end = addr + size - !!size;
+	unsigned long limit = TASK_SIZE_MAX;
 
-	return (__UA_LIMIT & (addr | end | __ua_size(size))) == 0;
+	return (size <= limit) && (addr <= (limit - size));
 }
 
 #define access_ok(addr, size)					\
-- 
2.29.2

