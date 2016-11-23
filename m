From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:19 +0900
Subject: [OpenRISC] [PATCH 05/18] sim: or1k: add NOP_EXIT_SILENT;
	make simulator print exit code for NOP_EXIT; 
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-6-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

make newlib's exit use NOP_EXIT_SILENT
---
 sim/or1k/ChangeLog |  8 ++++++++
 sim/or1k/or1k.c    |  3 +++
 sim/or1k/or1k.h    | 23 ++++++++++++-----------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/sim/or1k/ChangeLog b/sim/or1k/ChangeLog
index 3dc053a..cd2617c 100644
--- a/sim/or1k/ChangeLog
+++ b/sim/or1k/ChangeLog
@@ -1,3 +1,11 @@
+2012-05-21  Peter Gavin  <pgavin@gmail.com>
+
+	* or1k.c (or1k32bf_nop) make NOP_EXIT report exit code on
+	simulator output; add NOP_EXIT_SILENT which silently exits. This
+	is needed to maintain compatibility with existing testsuites, but
+	we need to be able to silently exit for the gcc testsuite.
+	Newlib's exit will use NOP_EXIT_SILENT.
+
 2012-05-17  Peter Gavin  <pgavin@gmail.com>
 
 	* or1k.c (or1k32bf_nop) handle NOP_NOP, NOP_REPORT; warn if
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
index 9f6e207..aca7333 100644
--- a/sim/or1k/or1k.c
+++ b/sim/or1k/or1k.c
@@ -136,6 +136,9 @@ void or1k32bf_nop (sim_cpu *current_cpu, USI uimm16)
     break;
     
   case NOP_EXIT:
+    sim_io_printf (CPU_STATE(current_cpu), "exit(%d)\n", GET_H_GPR(3));
+    /* fall through */
+  case NOP_EXIT_SILENT:
     sim_engine_halt (sd, current_cpu, NULL, CPU_PC_GET (current_cpu), sim_exited, GET_H_GPR (3));
     break;
 
diff --git a/sim/or1k/or1k.h b/sim/or1k/or1k.h
index 513c946..f1c9b73 100644
--- a/sim/or1k/or1k.h
+++ b/sim/or1k/or1k.h
@@ -1,17 +1,18 @@
 #ifndef OR1K_H
 #define OR1K_H
 
-#define NOP_NOP       0x0
-#define NOP_EXIT      0x1
-#define NOP_REPORT    0x2
-#define NOP_PUTC      0x4
-#define NOP_CNT_RESET 0x5
-#define NOP_GET_TICKS 0x6
-#define NOP_GET_PS    0x7
-#define NOP_TRACE_ON  0x8
-#define NOP_TRACE_OFF 0x9
-#define NOP_RANDOM    0xa
-#define NOP_OR1KSIM   0xb
+#define NOP_NOP         0x0
+#define NOP_EXIT        0x1
+#define NOP_REPORT      0x2
+#define NOP_PUTC        0x4
+#define NOP_CNT_RESET   0x5
+#define NOP_GET_TICKS   0x6
+#define NOP_GET_PS      0x7
+#define NOP_TRACE_ON    0x8
+#define NOP_TRACE_OFF   0x9
+#define NOP_RANDOM      0xa
+#define NOP_OR1KSIM     0xb
+#define NOP_EXIT_SILENT 0xc
 
 #define NUM_SPR 0x20000
 #define SPR_GROUP_SHIFT 11
-- 
2.7.4


