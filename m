From: Stafford Horne <shorne@gmail.com>
Date: Wed, 22 Feb 2017 04:11:52 +0900
Subject: [OpenRISC] [PATCH v3 23/25] arch/openrisc/lib/memcpy.c: use correct
	OR1200 option
In-Reply-To: <cover.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
Message-ID: <8c0d8e3c16f01efe3d44838a2b07581227a2babb.1487702890.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Valentin Rothberg <valentinrothberg@gmail.com>

The Kconfig option for OR12000 is OR1K_1200.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/lib/memcpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
index 4706f01..669887a 100644
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
2.9.3

