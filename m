From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 14 Feb 2022 17:34:39 +0100
Subject: [OpenRISC] [PATCH 01/14] uaccess: fix integer overflow on
 access_ok()
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
Message-ID: <20220214163452.1568807-2-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

Three architectures check the end of a user access against the
address limit without taking a possible overflow into account.
Passing a negative length or another overflow in here returns
success when it should not.

Use the most common correct implementation here, which optimizes
for a constant 'size' argument, and turns the common case into a
single comparison.

Cc: stable at vger.kernel.org
Fixes: da551281947c ("csky: User access")
Fixes: f663b60f5215 ("microblaze: Fix uaccess_ok macro")
Fixes: 7567746e1c0d ("Hexagon: Add user access functions")
Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/uaccess.h       |  7 +++----
 arch/hexagon/include/asm/uaccess.h    | 18 +++++++++---------
 arch/microblaze/include/asm/uaccess.h | 19 ++++---------------
 3 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index c40f06ee8d3e..ac5a54f57d40 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -3,14 +3,13 @@
 #ifndef __ASM_CSKY_UACCESS_H
 #define __ASM_CSKY_UACCESS_H
 
-#define user_addr_max() \
-	(uaccess_kernel() ? KERNEL_DS.seg : get_fs().seg)
+#define user_addr_max() (current_thread_info()->addr_limit.seg)
 
 static inline int __access_ok(unsigned long addr, unsigned long size)
 {
-	unsigned long limit = current_thread_info()->addr_limit.seg;
+	unsigned long limit = user_addr_max();
 
-	return ((addr < limit) && ((addr + size) < limit));
+	return (size <= limit) && (addr <= (limit - size));
 }
 #define __access_ok __access_ok
 
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index ef5bfef8d490..719ba3f3c45c 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -25,17 +25,17 @@
  * Returns true (nonzero) if the memory block *may* be valid, false (zero)
  * if it is definitely invalid.
  *
- * User address space in Hexagon, like x86, goes to 0xbfffffff, so the
- * simple MSB-based tests used by MIPS won't work.  Some further
- * optimization is probably possible here, but for now, keep it
- * reasonably simple and not *too* slow.  After all, we've got the
- * MMU for backup.
  */
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
+#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
 
-#define __access_ok(addr, size) \
-	((get_fs().seg == KERNEL_DS.seg) || \
-	(((unsigned long)addr < get_fs().seg) && \
-	  (unsigned long)size < (get_fs().seg - (unsigned long)addr)))
+static inline int __access_ok(unsigned long addr, unsigned long size)
+{
+	unsigned long limit = TASK_SIZE;
+
+	return (size <= limit) && (addr <= (limit - size));
+}
+#define __access_ok __access_ok
 
 /*
  * When a kernel-mode page fault is taken, the faulting instruction
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index d2a8ef9f8978..5b6e0e7788f4 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -39,24 +39,13 @@
 
 # define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
-static inline int access_ok(const void __user *addr, unsigned long size)
+static inline int __access_ok(unsigned long addr, unsigned long size)
 {
-	if (!size)
-		goto ok;
+	unsigned long limit = user_addr_max();
 
-	if ((get_fs().seg < ((unsigned long)addr)) ||
-			(get_fs().seg < ((unsigned long)addr + size - 1))) {
-		pr_devel("ACCESS fail at 0x%08x (size 0x%x), seg 0x%08x\n",
-			(__force u32)addr, (u32)size,
-			(u32)get_fs().seg);
-		return 0;
-	}
-ok:
-	pr_devel("ACCESS OK@0x%08x (size 0x%x), seg 0x%08x\n",
-			(__force u32)addr, (u32)size,
-			(u32)get_fs().seg);
-	return 1;
+	return (size <= limit) && (addr <= (limit - size));
 }
+#define access_ok(addr, size) __access_ok((unsigned long)addr, size)
 
 # define __FIXUP_SECTION	".section .fixup,\"ax\"\n"
 # define __EX_TABLE_SECTION	".section __ex_table,\"a\"\n"
-- 
2.29.2

