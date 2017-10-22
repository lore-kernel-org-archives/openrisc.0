From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 11:46:39 +0900
Subject: [OpenRISC] [PATCH 1/3] Documentation: Move OpenRISC docs out of
	arch/
In-Reply-To: <20171022024641.28478-1-shorne@gmail.com>
References: <20171022024641.28478-1-shorne@gmail.com>
Message-ID: <20171022024641.28478-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The OpenRISC docs have traditionally been in arch/ but that does not
seem like the correct place to be.  Move them so they will be more
visible to others.  Also update MAINTAINERS to make sure we get
notifications of changes.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/README.openrisc => Documentation/openrisc/README | 0
 arch/openrisc/TODO.openrisc => Documentation/openrisc/TODO     | 0
 MAINTAINERS                                                    | 1 +
 3 files changed, 1 insertion(+)
 rename arch/openrisc/README.openrisc => Documentation/openrisc/README (100%)
 rename arch/openrisc/TODO.openrisc => Documentation/openrisc/TODO (100%)

diff --git a/arch/openrisc/README.openrisc b/Documentation/openrisc/README
similarity index 100%
rename from arch/openrisc/README.openrisc
rename to Documentation/openrisc/README
diff --git a/arch/openrisc/TODO.openrisc b/Documentation/openrisc/TODO
similarity index 100%
rename from arch/openrisc/TODO.openrisc
rename to Documentation/openrisc/TODO
diff --git a/MAINTAINERS b/MAINTAINERS
index 8ce029872089..a57d13cb414d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10008,6 +10008,7 @@ T:	git git://github.com/openrisc/linux.git
 L:	openrisc at lists.librecores.org
 W:	http://openrisc.io
 S:	Maintained
+F:	Documentation/openrisc/
 F:	arch/openrisc/
 F:	drivers/irqchip/irq-or1k-*
 
-- 
2.13.6

