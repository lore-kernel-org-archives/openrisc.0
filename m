From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 14 Feb 2022 17:34:47 +0100
Subject: [OpenRISC] [PATCH 09/14] m68k: drop custom __access_ok()
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
Message-ID: <20220214163452.1568807-10-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

While most m68k platforms use separate address spaces for user
and kernel space, at least coldfire does not, and the other
ones have a TASK_SIZE that is less than the entire 4GB address
range.

Using the generic implementation of __access_ok() stops coldfire
user space from trivially accessing kernel memory, and is probably
the right thing elsewhere for consistency as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/uaccess.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index d6bb5720365a..64914872a5c9 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -10,19 +10,6 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <asm/extable.h>
-
-/* We let the MMU do all checking */
-static inline int __access_ok(const void __user *addr,
-			    unsigned long size)
-{
-	/*
-	 * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
-	 * for TASK_SIZE!
-	 * Removing this helper is probably sufficient.
-	 */
-	return 1;
-}
-#define __access_ok __access_ok
 #include <asm-generic/access_ok.h>
 
 /*
-- 
2.29.2

