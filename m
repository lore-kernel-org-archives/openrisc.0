From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:34 +0900
Subject: [OpenRISC] [PATCH v2 4/9] openrisc: Support both old (or32) and new
	(or1k) toolchain
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <8e7431bdf6d3839f7594282547669d3c2d24311e.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Guenter Roeck <linux@roeck-us.net>

The output file format for or1k has changed from "elf32-or32"
to "elf32-or1k". Select the correct output format automatically
to be able to compile the kernel with both toolchain variants.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/vmlinux.lds.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index d68b9ed..ef31fc2 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -30,7 +30,13 @@
 #include <asm/cache.h>
 #include <asm-generic/vmlinux.lds.h>
 
-OUTPUT_FORMAT("elf32-or32", "elf32-or32", "elf32-or32")
+#ifdef __OR1K__
+#define __OUTPUT_FORMAT        "elf32-or1k"
+#else
+#define __OUTPUT_FORMAT        "elf32-or32"
+#endif
+
+OUTPUT_FORMAT(__OUTPUT_FORMAT, __OUTPUT_FORMAT, __OUTPUT_FORMAT)
 jiffies = jiffies_64 + 4;
 
 SECTIONS
-- 
2.7.4


