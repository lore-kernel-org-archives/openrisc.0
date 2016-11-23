From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:40 +0900
Subject: [OpenRISC] [PATCH 14/18] gdb: testsuite: Add or1k l.nop inscruction
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-15-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The test case requires adding a nop instruction.  For or1k the
instruction is `l.nop`. This change uses the correct operation.
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


