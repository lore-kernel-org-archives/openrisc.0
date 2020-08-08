From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Aug 2020 08:06:47 +0900
Subject: [OpenRISC] [PATCH v3 6/6] openrisc: uaccess: Add user address space
 check to access_ok
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
Message-ID: <20200808230647.833047-7-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Now that __user annotations are fixed for openrisc uaccess api's we can
add checking to the access_ok macro.  This patch adds the __chk_user_ptr
check, on normal builds the added check is a nop.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
Changes since v2:
 - Remove __force in cast suggsted by Luc

 arch/openrisc/include/asm/uaccess.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 85a55359b244..7c5892f56765 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -57,6 +57,7 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size)						\
 ({ 									\
+	__chk_user_ptr(addr);						\
 	__range_ok((unsigned long)(addr), (size));			\
 })
 
-- 
2.26.2

