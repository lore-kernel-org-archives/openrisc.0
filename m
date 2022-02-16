From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 16 Feb 2022 14:13:20 +0100
Subject: [OpenRISC] [PATCH v2 06/18] x86: use more conventional access_ok()
 definition
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Message-ID: <20220216131332.1489939-7-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

The way that access_ok() is defined on x86 is slightly different from
most other architectures, and a bit more complex.

The generic version tends to result in the best output on all
architectures, as it results in single comparison against a constant
limit for calls with a known size.

There are a few callers of __range_not_ok(), all of which use TASK_SIZE
as the limit rather than TASK_SIZE_MAX, but I could not see any reason
for picking this. Changing these to call __access_ok() instead uses the
default limit, but keeps the behavior otherwise.

x86 is the only architecture with a WARN_ON_IN_IRQ() checking
access_ok(), but it's probably best to leave that in place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/uaccess.h | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 79c4869ccdd6..a59ba2578e64 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -16,33 +16,14 @@
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
  */
-static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size)
+static inline bool __access_ok(void __user *ptr, unsigned long size)
 {
 	unsigned long limit = TASK_SIZE_MAX;
+	unsigned long addr = ptr;
 
-	/*
-	 * If we have used "sizeof()" for the size,
-	 * we know it won't overflow the limit (but
-	 * it might overflow the 'addr', so it's
-	 * important to subtract the size from the
-	 * limit, not add it to the address).
-	 */
-	if (__builtin_constant_p(size))
-		return unlikely(addr > limit - size);
-
-	/* Arbitrary sizes? Be careful about overflow */
-	addr += size;
-	if (unlikely(addr < size))
-		return true;
-	return unlikely(addr > limit);
+	return (size <= limit) && (addr <= (limit - size));
 }
 
-#define __access_ok(addr, size)						\
-({									\
-	__chk_user_ptr(addr);						\
-	!__chk_range_not_ok((unsigned long __force)(addr), size);	\
-})
-
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()	\
-- 
2.29.2

