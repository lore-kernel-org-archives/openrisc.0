From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Jul 2019 12:33:48 +0900
Subject: [OpenRISC] [PATCH v2 2/5] or1k: Fix issues with msoft-div
In-Reply-To: <20190703033351.11924-1-shorne@gmail.com>
References: <20190703033351.11924-1-shorne@gmail.com>
Message-ID: <20190703033351.11924-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Fixes bad assembly logic with software divide as reported by Richard Selvaggi.
Also, add a basic test to verify the soft math works when enabled.

gcc/testsuite/ChangeLog:

	PR target/90362
	* gcc.target/or1k/div-mul-3.c: New test.

libgcc/ChangeLog:

	PR target/90362
	* config/or1k/lib1funcs.S (__udivsi3): Change l.sfeqi
	to l.sfeq and l.sfltsi to l.sflts equivalents as the immediate
	instructions are not available on every processor.  Change a
	l.bnf to l.bf to fix logic issue.
---
Changes since v1:
 - none

 gcc/testsuite/gcc.target/or1k/div-mul-3.c | 31 +++++++++++++++++++++++
 libgcc/config/or1k/lib1funcs.S            |  6 ++---
 2 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-3.c

diff --git a/gcc/testsuite/gcc.target/or1k/div-mul-3.c b/gcc/testsuite/gcc.target/or1k/div-mul-3.c
new file mode 100644
index 00000000000..2c4f91b7e98
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/div-mul-3.c
@@ -0,0 +1,31 @@
+/* { dg-do run } */
+/* { dg-options "-O2 -msoft-div -msoft-mul" } */
+
+struct testcase {
+  int a;
+  int b;
+  int c;
+  int expected;
+};
+
+struct testcase tests[] = {
+  {2, 200, 3, 133},
+  {3, 300, 3, 300},
+  {2, 500, 3, 333},
+  {4, 250, 3, 333},
+  {0, 0, 0, 0}
+};
+
+int calc (int a, int b, int c) {
+  return a * b / c;
+}
+
+int main () {
+  int fail = 0;
+  struct testcase *tc;
+
+  for (int i = 0; (tc = &tests[i], tc->c); i++)
+    fail |= (calc (tc->a, tc->b, tc->c) != tc->expected);
+
+  return fail;
+}
diff --git a/libgcc/config/or1k/lib1funcs.S b/libgcc/config/or1k/lib1funcs.S
index d2103923486..6d058977229 100644
--- a/libgcc/config/or1k/lib1funcs.S
+++ b/libgcc/config/or1k/lib1funcs.S
@@ -68,18 +68,18 @@ __udivmodsi3_internal:
 	   is not clobbered by this routine, and use that as to
 	   save a return address without creating a stack frame.  */
 
-	l.sfeqi		r4, 0		/* division by zero; return 0.  */
+	l.sfeq		r4, r0		/* division by zero; return 0.  */
 	l.ori		r11, r0, 0	/* initial quotient */
 	l.bf		9f
 	 l.ori		r12, r3, 0	/* initial remainder */
 
 	/* Given X/Y, shift Y left until Y >= X.  */
 	l.ori		r6, r0, 1	/* mask = 1 */
-1:	l.sfltsi	r4, 0		/* y has msb set */
+1:	l.sflts		r4, r0		/* y has msb set */
 	l.bf		2f
 	 l.sfltu	r4, r12		/* y < x */
 	l.add		r4, r4, r4	/* y <<= 1 */
-	l.bnf		1b
+	l.bf		1b
 	 l.add		r6, r6, r6	/* mask <<= 1 */
 
 	/* Shift Y back to the right again, subtracting from X.  */
-- 
2.21.0

