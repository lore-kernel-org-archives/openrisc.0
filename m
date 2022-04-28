From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Thu, 28 Apr 2022 12:35:16 +0200
Subject: [OpenRISC] [PATCH] hw/openrisc: page-align FDT address
Message-ID: <20220428103516.1149436-1-Jason@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The QEMU-provided FDT was only being recognized by the kernel when it
was used in conjunction with -initrd. Without it, the magic bytes
wouldn't be there and the kernel couldn't load it. This patch fixes the
issue by page aligning the provided FDT.

Cc: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 hw/openrisc/openrisc_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 8184caa60b..99b14940f4 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -356,7 +356,7 @@ static uint32_t openrisc_load_fdt(Or1ksimState *state, hwaddr load_start,
     }
 
     /* We put fdt right after the kernel and/or initrd. */
-    fdt_addr = ROUND_UP(load_start, 4);
+    fdt_addr = TARGET_PAGE_ALIGN(load_start);
 
     ret = fdt_pack(fdt);
     /* Should only fail if we've built a corrupted tree */
-- 
2.35.1

