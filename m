From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 16 Feb 2022 14:13:24 +0100
Subject: [OpenRISC] [PATCH v2 10/18] m68k: fix access_ok for coldfire
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Message-ID: <20220216131332.1489939-11-arnd@kernel.org>
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

Using the default implementation of __access_ok() stops coldfire
user space from trivially accessing kernel memory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/uaccess.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index 79617c0b2f91..8eb625e75452 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -12,14 +12,21 @@
 #include <asm/extable.h>
 
 /* We let the MMU do all checking */
-static inline int access_ok(const void __user *addr,
+static inline int access_ok(const void __user *ptr,
 			    unsigned long size)
 {
+	unsigned long limit = TASK_SIZE;
+	unsigned long addr = (unsigned long)ptr;
+
 	/*
 	 * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
 	 * for TASK_SIZE!
+	 * Removing this helper is probably sufficient.
 	 */
-	return 1;
+	if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
+		return 1;
+
+	return (size <= limit) && (addr <= (limit - size));
 }
 
 /*
-- 
2.29.2

