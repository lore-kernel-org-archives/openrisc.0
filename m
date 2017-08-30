From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 06:58:33 +0900
Subject: [OpenRISC] [PATCH 02/13] openrisc: define CPU_BIG_ENDIAN as true
In-Reply-To: <cover.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
Message-ID: <65f12040f262906af8a599a85090f8482ef553cb.1504129273.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

While working on SMP for OpenRISC I found this is needed for qrwlocks to
work correctly.  OpenRISC is big endian so this should have been here
already.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index ba8ae92ec5fb..8ddfc92ab813 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -29,6 +29,9 @@ config OPENRISC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select NO_BOOTMEM
 
+config CPU_BIG_ENDIAN
+	def_bool y
+
 config MMU
 	def_bool y
 
-- 
2.13.5

