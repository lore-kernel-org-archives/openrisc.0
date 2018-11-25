From: Liu Xiang <liu.xiang6@zte.com.cn>
Date: Sun, 25 Nov 2018 17:33:10 +0800
Subject: [OpenRISC] [PATCH] openrisc: Add spaces around & operator
Message-ID: <1543138390-3726-1-git-send-email-liu.xiang6@zte.com.cn>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add spaces around '&' to follow kernel coding style.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 arch/openrisc/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
index 5a01595..75c7a77 100644
--- a/arch/openrisc/include/asm/fixmap.h
+++ b/arch/openrisc/include/asm/fixmap.h
@@ -55,7 +55,7 @@ enum fixed_addresses {
 #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x) & PAGE_MASK)) >> PAGE_SHIFT)
 
 /*
  * 'index to address' translation. If anyone tries to use the idx
-- 
1.9.1

