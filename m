From: Stafford Horne <shorne@gmail.com>
Date: Sat,  5 Sep 2020 22:19:35 +0900
Subject: [OpenRISC] [PATCH v2 3/3] openrisc: Fix issue with get_user for
 64-bit values
In-Reply-To: <20200905131935.972386-1-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
Message-ID: <20200905131935.972386-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

A build failure was raised by kbuild with the following error.

    drivers/android/binder.c: Assembler messages:
    drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
    drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

The issue is with 64-bit get_user() calls on openrisc.  I traced this to
a problem where in the internally in the get_user macros there is a cast
to long __gu_val this causes GCC to think the get_user call is 32-bit.
This binder code is really long and GCC allocates register r30, which
triggers the issue. The 64-bit get_user asm tries to get the 64-bit pair
register, which for r30 overflows the general register names and returns
the dummy register ?ap.

The fix is to just remove the assignment to the 32-bit temporary
variable __gu_val.

Link: https://lore.kernel.org/lkml/202008200453.ohnhqkjQ%25lkp at intel.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index f0390211236b..4a8976dda1a5 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -165,19 +165,19 @@ struct __large_struct {
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
-	long __gu_err, __gu_val;				\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;		\
+	long __gu_err;						\
+	__get_user_size((x), (ptr), (size), __gu_err);		\
 	__gu_err;						\
 })
 
 #define __get_user_check(x, ptr, size)					\
 ({									\
-	long __gu_err = -EFAULT, __gu_val = 0;				\
+	long __gu_err = -EFAULT;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
-	if (access_ok(__gu_addr, size))			\
-		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (access_ok(__gu_addr, size))					\
+		__get_user_size((x), __gu_addr, (size), __gu_err);	\
+	else								\
+		(x) = 0;						\
 	__gu_err;							\
 })
 
@@ -191,7 +191,7 @@ do {									\
 	case 2: __get_user_asm(x, ptr, retval, "l.lhz"); break;		\
 	case 4: __get_user_asm(x, ptr, retval, "l.lwz"); break;		\
 	case 8: __get_user_asm2(x, ptr, retval); break;			\
-	default: (x) = __get_user_bad();				\
+	default: (x) = (__typeof__(x)) __get_user_bad();		\
 	}								\
 } while (0)
 
-- 
2.26.2

