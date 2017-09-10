From: Stafford Horne <shorne@gmail.com>
Date: Sun, 10 Sep 2017 15:49:14 +0900
Subject: [OpenRISC] [PATCH v2 02/14] openrisc: define CPU_BIG_ENDIAN as true
In-Reply-To: <20170910064926.5874-1-shorne@gmail.com>
References: <20170910064926.5874-1-shorne@gmail.com>
Message-ID: <20170910064926.5874-3-shorne@gmail.com>
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
index ee34d94f7aa2..356dd67a86ea 100644
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

