From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:08:09 +0900
Subject: [OpenRISC] [PATCH 12/22] openrisc: remove unnecessary stddef.h
	include
In-Reply-To: <cover.1484432596.git.shorne@gmail.com>
References: <cover.1484432596.git.shorne@gmail.com>
Message-ID: <f23d22fe2bb4bf3d6b3379f2cadc3395154acd57.1484432596.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

This causes the build to fail when building with the or1k-musl-linux-
toolchain and it is not needed.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 4f59fa4..2282888 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -16,7 +16,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <stddef.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
-- 
2.9.3

