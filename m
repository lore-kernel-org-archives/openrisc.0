From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Sep 2017 23:01:24 +0900
Subject: [OpenRISC] [PATCH] MAINTAINERS: Add OpenRISC pic maintainer
Message-ID: <20170919140135.32646-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The OpenRISC team is the maintainer of the irqchip or1k-pic driver under
drivers/irqchip.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2281af4b41b6..8ce029872089 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10009,6 +10009,7 @@ L:	openrisc at lists.librecores.org
 W:	http://openrisc.io
 S:	Maintained
 F:	arch/openrisc/
+F:	drivers/irqchip/irq-or1k-*
 
 OPENVSWITCH
 M:	Pravin Shelar <pshelar@nicira.com>
-- 
2.13.5

