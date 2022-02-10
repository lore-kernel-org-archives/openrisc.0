From: Stafford Horne <shorne@gmail.com>
Date: Fri, 11 Feb 2022 07:28:39 +0900
Subject: [OpenRISC] [PATCH v4] openrisc: remove CONFIG_SET_FS
Message-ID: <20220210222841.3187484-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Remove the address space override API set_fs().  The OpenRISC user
address space is now limited to TASK_SIZE.

To support this we implement and wire in __get_kernel_nofault and
__set_kernel_nofault.

The function user_addr_max is removed as there is a default definition
provided when CONFIG_SET_FS is not used.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
SInce v3:
 - Change order of __range_ok back and add comment about optimization.

Since v2:
 - Change order of __range_ok condition to be more clear.

Since v1:
 - Fix commit message with misleading comment about User Mode Linux.

 arch/openrisc/Kconfig                   |  1 -
 arch/openrisc/include/asm/thread_info.h |  7 ----
 arch/openrisc/include/asm/uaccess.h     | 51 +++++++++++--------------
 3 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index bf047dca7ec6..ceda77fb8bc8 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -36,7 +36,6 @@ config OPENRISC
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 
 config CPU_BIG_ENDIAN
diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 659834ab87fa..4af3049c34c2 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -40,18 +40,12 @@
  */
 #ifndef __ASSEMBLY__
 
-typedef unsigned long mm_segment_t;
-
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
-	mm_segment_t		addr_limit; /* thread address space:
-					       0-0x7FFFFFFF for user-thead
-					       0-0xFFFFFFFF for kernel-thread
-					     */
 	__u8			supervisor_stack[0];
 
 	/* saved context data */
@@ -71,7 +65,6 @@ struct thread_info {
 	.flags		= 0,				\
 	.cpu		= 0,				\
 	.preempt_count	= INIT_PREEMPT_COUNT,		\
-	.addr_limit	= KERNEL_DS,			\
 	.ksp            = 0,                            \
 }
 
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 120f5005461b..e6407173e549 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -23,36 +23,13 @@
 #include <asm/page.h>
 #include <asm/extable.h>
 
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-/* addr_limit is the maximum accessible address for the task. we misuse
- * the KERNEL_DS and USER_DS values to both assign and compare the
- * addr_limit values through the equally misnamed get/set_fs macros.
- * (see above)
- */
-
-#define KERNEL_DS	(~0UL)
-
-#define USER_DS		(TASK_SIZE)
-#define get_fs()	(current_thread_info()->addr_limit)
-#define set_fs(x)	(current_thread_info()->addr_limit = (x))
-
-#define uaccess_kernel()	(get_fs() == KERNEL_DS)
-
 /* Ensure that the range from addr to addr+size is all within the process'
- * address space
+ * address space.  Note, we compare size vs TASK_SIZE as size is often
+ * constant and this will be optimized to a single compare.
  */
 static inline int __range_ok(unsigned long addr, unsigned long size)
 {
-	const mm_segment_t fs = get_fs();
-
-	return size <= fs && addr <= (fs - size);
+	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
 }
 
 #define access_ok(addr, size)						\
@@ -241,6 +218,25 @@ do {									\
 		(__typeof__((x)-(x)))__gu_tmp);		\
 }
 
+#define __get_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(src);	\
+	type data;					\
+	if (__get_user(data, p))			\
+		goto label;				\
+	*(type *)dst = data;				\
+}
+
+#define __put_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(dst);	\
+	type data = *(type *)src;			\
+	if (__put_user(data, p))			\
+		goto label;				\
+}
+
+#define HAVE_GET_KERNEL_NOFAULT
+
 /* more complex routines */
 
 extern unsigned long __must_check
@@ -268,9 +264,6 @@ clear_user(void __user *addr, unsigned long size)
 	return size;
 }
 
-#define user_addr_max() \
-	(uaccess_kernel() ? ~0UL : TASK_SIZE)
-
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 extern __must_check long strnlen_user(const char __user *str, long n);
-- 
2.31.1

