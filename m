From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:35 +0900
Subject: [OpenRISC] [PATCH v2 5/9] openrisc: add NR_CPUS Kconfig default
	value
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <1e0020e0c4f622c7a386b50cd37f51e7d67814b4.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The build system now expects that NR_CPUS is defined.

Follow 4cbbbb4 ("microblaze: Fix missing NR_CPUS in menuconfig")

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 489e7f9..691e1af 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -98,6 +98,9 @@ config OPENRISC_HAVE_INST_DIV
 	  Select this if your implementation has a hardware divide instruction
 endmenu
 
+config NR_CPUS
+	int
+	default "1"
 
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
-- 
2.7.4


