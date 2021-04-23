From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 23 Apr 2021 17:09:28 +0200
Subject: [OpenRISC] [PATCH] openrisc: Fix a memory leak
Message-ID: <c078439e31fd60e1617be8c17cc1ec57639e0586.1619190470.git.christophe.jaillet@wanadoo.fr>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

'setup_find_cpu_node()' take a reference on the node it returns.
This reference must be decremented when not needed anymore, or there will
be a leak.

Add the missing 'of_node_put(cpu)'.

Note that 'setup_cpuinfo()' that also calls this function already has a
correct 'of_node_put(cpu)' at its end.

Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/openrisc/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 2416a9f91533..c6f9e7b9f7cb 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -278,6 +278,8 @@ void calibrate_delay(void)
 	pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
 		loops_per_jiffy / (500000 / HZ),
 		(loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
+
+	of_node_put(cpu);
 }
 
 void __init setup_arch(char **cmdline_p)
-- 
2.27.0

