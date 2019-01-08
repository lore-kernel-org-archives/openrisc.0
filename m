From: Stafford Horne <shorne@gmail.com>
Date: Tue,  8 Jan 2019 22:15:15 +0900
Subject: [OpenRISC] [PATCH] arch/openrisc: Fix issues with access_ok()
Message-ID: <20190108131516.27903-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
exposed incorrect implementations of access_ok() macro in several
architectures.  This change fixes 2 issues found in OpenRISC.

OpenRISC was not properly using parenthesis for arguments and also using
arguments twice.  This patch fixes those 2 issues.

I test booted this patch with v5.0-rc1 on qemu and it's working fine.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index bc8191a34db7..a44682c8adc3 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -58,8 +58,12 @@
 /* Ensure that addr is below task's addr_limit */
 #define __addr_ok(addr) ((unsigned long) addr < get_fs())
 
-#define access_ok(addr, size) \
-	__range_ok((unsigned long)addr, (unsigned long)size)
+#define access_ok(addr, size)						\
+({ 									\
+	unsigned long __ao_addr = (unsigned long)(addr);		\
+	unsigned long __ao_size = (unsigned long)(size);		\
+	__range_ok(__ao_addr, __ao_size);				\
+})
 
 /*
  * These are the main single-value transfer routines.  They automatically
-- 
2.19.1

