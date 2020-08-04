From: Stafford Horne <shorne@gmail.com>
Date: Tue,  4 Aug 2020 13:23:52 +0900
Subject: [OpenRISC] [PATCH 4/6] openrisc: uaccess: Remove unused macro
 __addr_ok
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
Message-ID: <20200804042354.3930694-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Since commit b48b2c3e5043 ("openrisc: use generic strnlen_user()
function") the macro __addr_ok is no longer used.  It is safe to remove
so this patch removes it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 4b59dc9ad300..85a55359b244 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -55,9 +55,6 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 	return size <= fs && addr <= (fs - size);
 }
 
-/* Ensure that addr is below task's addr_limit */
-#define __addr_ok(addr) ((unsigned long) addr < get_fs())
-
 #define access_ok(addr, size)						\
 ({ 									\
 	__range_ok((unsigned long)(addr), (size));			\
-- 
2.26.2

