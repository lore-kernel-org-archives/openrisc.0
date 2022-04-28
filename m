From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Thu, 28 Apr 2022 13:11:39 +0200
Subject: [OpenRISC] [PATCH] openrisc: define nop command for simulator reboot
Message-ID: <20220428111139.1330966-1-Jason@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The simulator defines `l.nop 1` for shutdown, but doesn't have anything
for reboot. Use 13 for this, which is currently unused, dubbed
`NOP_REBOOT`.

Cc: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/all/YmnaDUpVI5ihgvg6 at zx2c4.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/openrisc/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..4cce95fa6eb5 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -52,6 +52,8 @@ void machine_restart(char *cmd)
 {
 	do_kernel_restart(cmd);
 
+	__asm__("l.nop 13");
+
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
 
-- 
2.35.1

