From: Stafford Horne <shorne@gmail.com>
Date: Tue,  4 Aug 2020 13:23:54 +0900
Subject: [OpenRISC] [PATCH 6/6] openrisc: uaccess: Add user address space
 check to access_ok
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
Message-ID: <20200804042354.3930694-7-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Now that __user annotations are fixed for openrisc uaccess api's we can
add checking to the access_ok macro.  This patch adds the __chk_user_ptr
check, on normal builds the added check is a nop.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 85a55359b244..53ddc66abb3f 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -57,7 +57,8 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size)						\
 ({ 									\
-	__range_ok((unsigned long)(addr), (size));			\
+	__chk_user_ptr(addr);						\
+	__range_ok((__force unsigned long)(addr), (size));		\
 })
 
 /*
-- 
2.26.2

