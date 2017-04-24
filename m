From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 21:52:52 +0900
Subject: [OpenRISC] [PATCH v6 3/5] gdb: testsuite: Add or1k l.nop instruction
In-Reply-To: <cover.1493038197.git.shorne@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
Message-ID: <f09ca3ddec4ce23f2f45bbd4590bde0f4ee134bf.1493038197.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The test case requires adding a nop instruction.  For or1k the
instruction is `l.nop`. This change uses the correct operation.

gdb/testsuite/ChangeLog:

2016-05-11  Stafford Horne  <shorne@gmail.com>

	* gdb.base/bp-permanent.c: Define nop of or1k.
---
 gdb/testsuite/gdb.base/bp-permanent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gdb/testsuite/gdb.base/bp-permanent.c b/gdb/testsuite/gdb.base/bp-permanent.c
index acd5be7..d42aafa 100644
--- a/gdb/testsuite/gdb.base/bp-permanent.c
+++ b/gdb/testsuite/gdb.base/bp-permanent.c
@@ -26,6 +26,8 @@
 
 #if defined(__s390__) || defined(__s390x__)
 #define NOP asm("nopr 0")
+#elif defined(__or1k__)
+#define NOP asm("l.nop")
 #else
 #define NOP asm("nop")
 #endif
-- 
2.9.3

