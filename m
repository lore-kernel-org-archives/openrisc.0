From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:21 +0900
Subject: [OpenRISC] [PATCH 07/18] sim: or1k: remove erroneous warning
	message in sim/or1k/or1k.c
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-8-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/or1k/ChangeLog:

	* or1k.c (or1k32bf_make_load_store_addr): remove stupid erroneous warning
	message
---
 sim/or1k/ChangeLog | 6 ++++++
 sim/or1k/or1k.c    | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sim/or1k/ChangeLog b/sim/or1k/ChangeLog
index 90dc44a..ccc2c85 100644
--- a/sim/or1k/ChangeLog
+++ b/sim/or1k/ChangeLog
@@ -1,5 +1,11 @@
 2012-06-22  Peter Gavin  <pgavin@gmail.com>
 
+	* or1k.c:
+	(or1k32bf_make_load_store_addr) remove stupid erroneous warning
+	message
+
+2012-06-22  Peter Gavin  <pgavin@gmail.com>
+
 	* configure: regenerated
 
 2012-06-22  Peter Gavin  <pgavin@gmail.com>
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
index 45147d2..776e720 100644
--- a/sim/or1k/or1k.c
+++ b/sim/or1k/or1k.c
@@ -187,11 +187,6 @@ USI or1k32bf_make_load_store_addr (sim_cpu *current_cpu, USI base, SI offset, in
 {
   SIM_DESC sd = CPU_STATE(current_cpu);
 
-  if (!GET_H_SYS_SR_SM ()) {
-    sim_io_eprintf(sd, "WARNING: l.mfspr in user mode\n");
-    return;
-  }
-  
   USI addr = base + offset;
   
   if (GET_H_SYS_SR_LEE ()) {
-- 
2.7.4


