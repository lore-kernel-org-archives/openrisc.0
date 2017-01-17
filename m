From: Valentin Rothberg <valentinrothberg@gmail.com>
Date: Tue, 17 Jan 2017 09:12:48 +0100
Subject: [OpenRISC] [PATCH] arch/openrisc/lib/memcpy.c: use correct OR1200
	option
Message-ID: <20170117081248.3449-1-valentinrothberg@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The Kconfig option for OR12000 is OR1K_1200.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 arch/openrisc/lib/memcpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
index 4706f01a199a..669887a60e27 100644
--- a/arch/openrisc/lib/memcpy.c
+++ b/arch/openrisc/lib/memcpy.c
@@ -17,7 +17,7 @@
 
 #include <linux/string.h>
 
-#ifdef CONFIG_OR1200
+#ifdef CONFIG_OR1K_1200
 /*
  * Do memcpy with word copies and loop unrolling. This gives the
  * best performance on the OR1200 and MOR1KX archirectures
-- 
2.11.0

