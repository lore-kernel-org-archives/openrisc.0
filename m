From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:32 +0900
Subject: [OpenRISC] [PATCH 18/18] sim: or1k: add additional stubs for linux
	build
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-19-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Building for linux the traps interface requires to be
expanded more.  For now just add stubs to get building.

sim/or1k/ChangeLog:

	* sim/or1k/traps-linux.c (or1k32bf_exception): create dummy
---
 sim/or1k/traps-linux.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sim/or1k/traps-linux.c b/sim/or1k/traps-linux.c
index d2a111f..263657f 100644
--- a/sim/or1k/traps-linux.c
+++ b/sim/or1k/traps-linux.c
@@ -6,3 +6,24 @@ sim_engine_invalid_insn (SIM_CPU *current_cpu, IADDR cia, SEM_PC vpc)
   /* TODO */
   abort();
 }
+
+void or1k32bf_exception (sim_cpu *current_cpu, USI pc, USI exnum)
+{
+  /* TODO */
+  abort();
+}
+
+void or1k32bf_rfe (sim_cpu *current_cpu)
+{
+  abort();
+}
+
+USI or1k32bf_mfspr (sim_cpu *current_cpu, USI addr)
+{
+  abort();
+}
+
+void or1k32bf_mtspr (sim_cpu *current_cpu, USI addr, USI val)
+{
+  abort();
+}
-- 
2.7.4


