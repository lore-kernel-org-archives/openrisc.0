From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:21 +0900
Subject: [OpenRISC] [PATCH v4 01/24] openrisc: use SPARSE_IRQ
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <c0fcaf554ed9b65477576439e8de63578d731070.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Jonas Bonn <jonas@southpole.se>

The sparse IRQ framework is preferred nowadays so switch over to it.

Signed-off-by: Jonas Bonn <jonas@southpole.se>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig            | 1 +
 arch/openrisc/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 8d22015..1e95920 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -12,6 +12,7 @@ config OPENRISC
 	select HAVE_MEMBLOCK
 	select GPIOLIB
         select HAVE_ARCH_TRACEHOOK
+	select SPARSE_IRQ
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 2832f03..6dd177d 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -29,6 +29,7 @@ generic-y += hw_irq.h
 generic-y += ioctl.h
 generic-y += ioctls.h
 generic-y += ipcbuf.h
+generic-y += irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
-- 
2.9.3

