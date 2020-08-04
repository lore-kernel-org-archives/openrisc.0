From: Stafford Horne <shorne@gmail.com>
Date: Tue,  4 Aug 2020 13:23:50 +0900
Subject: [OpenRISC] [PATCH 2/6] openrisc: uaccess: Fix sparse address space
 warnings
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
Message-ID: <20200804042354.3930694-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The OpenRISC user access functions put_user(), get_user() and
clear_user() were missing proper sparse annotations.  This generated
warnings like the below.

This patch adds the annotations to fix the warnings.

Example warnings:

net/ipv4/ip_sockglue.c:759:29: warning: incorrect type in argument 1 (different address spaces)
net/ipv4/ip_sockglue.c:759:29:    expected void const volatile [noderef] __user *
net/ipv4/ip_sockglue.c:759:29:    got int const *__gu_addr
net/ipv4/ip_sockglue.c:764:29: warning: incorrect type in initializer (different address spaces)
net/ipv4/ip_sockglue.c:764:29:    expected unsigned char const *__gu_addr
net/ipv4/ip_sockglue.c:764:29:    got unsigned char [noderef] __user *

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 46e31bb4a9ad..f2fc5c4b88c3 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -100,7 +100,7 @@ extern long __put_user_bad(void);
 #define __put_user_check(x, ptr, size)					\
 ({									\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
 	if (access_ok(__pu_addr, size))			\
 		__put_user_size((x), __pu_addr, (size), __pu_err);	\
 	__pu_err;							\
@@ -173,7 +173,7 @@ struct __large_struct {
 #define __get_user_check(x, ptr, size)					\
 ({									\
 	long __gu_err = -EFAULT, __gu_val = 0;				\
-	const __typeof__(*(ptr)) * __gu_addr = (ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	if (access_ok(__gu_addr, size))			\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
@@ -248,10 +248,10 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long size)
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
-extern unsigned long __clear_user(void *addr, unsigned long size);
+extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
 static inline __must_check unsigned long
-clear_user(void *addr, unsigned long size)
+clear_user(void __user *addr, unsigned long size)
 {
 	if (likely(access_ok(addr, size)))
 		size = __clear_user(addr, size);
-- 
2.26.2

