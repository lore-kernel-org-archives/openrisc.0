From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Wed, 20 Oct 2021 15:16:37 +0300
Subject: [OpenRISC] [PATCH] openrisc: signal: remove unused DEBUG_SIG macro
Message-ID: <20211020121637.6629-1-kda@linux-powerpc.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/openrisc/kernel/signal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 1ebcff271096..99516c9191c7 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -28,8 +28,6 @@
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
 
-#define DEBUG_SIG 0
-
 struct rt_sigframe {
 	struct siginfo info;
 	struct ucontext uc;
-- 
2.16.4

