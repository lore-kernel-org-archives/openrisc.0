From: Stafford Horne <shorne@gmail.com>
Date: Sun, 27 Nov 2016 15:16:45 +0900
Subject: [OpenRISC] [PATCH v2 3/4] gdb: testsuite: Add or1k l.nop inscruction
In-Reply-To: <cover.1480216015.git.shorne@gmail.com>
References: <cover.1480216015.git.shorne@gmail.com>
Message-ID: <36e9bf30cf03493ad9af5a05d25bda36346f6dbe.1480216015.git.shorne@gmail.com>
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
index 541a89b..7e17dc7 100644
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
2.7.4


