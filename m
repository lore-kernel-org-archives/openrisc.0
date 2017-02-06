From: Stafford Horne <shorne@gmail.com>
Date: Mon,  6 Feb 2017 23:38:39 +0900
Subject: [OpenRISC] [PATCH 2/3] libgloss: or1k: If available call the init
	for init_array
In-Reply-To: <cover.1486391219.git.shorne@gmail.com>
References: <cover.1486391219.git.shorne@gmail.com>
Message-ID: <0c64720c78e17dc41fab6f2a80b6e101e78e459a.1486391219.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

There was an issue revealed in gdb testing where C++ virtual tables
were not getting properly initialized.  This seems to be due to the
c++ global constructors moving from ctors to init_array.

This fix makes sure we call the proper method for initializing the
constructors in all places.
---
 libgloss/or1k/crt0.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libgloss/or1k/crt0.S b/libgloss/or1k/crt0.S
index 84adba1..03d7323 100644
--- a/libgloss/or1k/crt0.S
+++ b/libgloss/or1k/crt0.S
@@ -36,6 +36,7 @@
       the obvious things..                                                    */
 /* -------------------------------------------------------------------------- */
 
+#include "newlib.h"
 #include "include/or1k-asm.h"
 #include "include/or1k-sprs.h"
 
@@ -96,6 +97,11 @@ _or1k_exception_stack_size:	.word EXCEPTION_STACK_SIZE
                                                                               */
 /* -------------------------------------------------------------------------- */
 
+#ifdef HAVE_INITFINI_ARRAY
+#define _init	__libc_init_array
+#define _fini	__libc_fini_array
+#endif
+
 #define GPR_BUF_OFFSET(x) (x << 2)
 
 #ifndef __OR1K_MULTICORE__
-- 
2.9.3

