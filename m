From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:22 +0900
Subject: [OpenRISC] [PATCH 08/18] sim: or1k: fix fl1 in sim
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-9-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/or1k/ChangeLog:

	* or1k.c (or1k32bf_fl1): fix bug
---
 sim/or1k/ChangeLog | 5 +++++
 sim/or1k/or1k.c    | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sim/or1k/ChangeLog b/sim/or1k/ChangeLog
index ccc2c85..5d120fe 100644
--- a/sim/or1k/ChangeLog
+++ b/sim/or1k/ChangeLog
@@ -1,6 +1,11 @@
 2012-06-22  Peter Gavin  <pgavin@gmail.com>
 
 	* or1k.c:
+	(or1k32bf_fl1) fix bug
+
+2012-06-22  Peter Gavin  <pgavin@gmail.com>
+
+	* or1k.c:
 	(or1k32bf_make_load_store_addr) remove stupid erroneous warning
 	message
 
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
index 776e720..98225ab 100644
--- a/sim/or1k/or1k.c
+++ b/sim/or1k/or1k.c
@@ -225,8 +225,8 @@ USI or1k32bf_fl1 (sim_cpu *current_cpu, USI val)
 {
   USI bit;
   USI ret;
-  for (bit = 1, ret = 1; bit; bit <<= 1, ret++) {
-    if (!(val & bit))
+  for (bit = 1 << 31, ret = 32; bit; bit >>= 1, ret--) {
+    if (val & bit)
       return ret;
   }
   return 0;
-- 
2.7.4


