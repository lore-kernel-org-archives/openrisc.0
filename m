From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Mon, 22 Jun 2020 14:11:24 +0200
Subject: [OpenRISC] [PATCH] openrisc: fix __user in raw_copy_to_user()'s
 prototype
Message-ID: <20200622121124.80398-1-luc.vanoostenryck@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

raw_copy_to_user()'s prototype seems to be a copy & paste of
raw_copy_from_user() and as such has the __user annotation
in the 'from' argument instead of the 'to'.

So, move the __user annotation in the prototype to the 'to'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 17c24f14615f..46e31bb4a9ad 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -241,7 +241,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long size)
 	return __copy_tofrom_user(to, (__force const void *)from, size);
 }
 static inline unsigned long
-raw_copy_to_user(void *to, const void __user *from, unsigned long size)
+raw_copy_to_user(void __user *to, const void *from, unsigned long size)
 {
 	return __copy_tofrom_user((__force void *)to, from, size);
 }
-- 
2.27.0

